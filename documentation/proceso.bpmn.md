# Proceso de Originación de Crédito - Notación BPMN Descrita

## Descripción General del Flujo

El proceso de originación de crédito canaliza las solicitudes desde el originador hasta la aprobación o rechazo final, involucra cuatro actores principales y maneja escenarios de fallo temporal del buró de riesgos con reintentos automáticos.

## Actores del Proceso

### 1. Originador de Créditos (Cliente Externo)
- **Rol**: Sistema externo que inicia la solicitud de crédito
- **Responsabilidades**: Enviar solicitud completa con datos del solicitante, proporcionar identificador de idempotencia, esperar respuesta síncrona
- **Timeout esperado**: 200ms para respuesta final
- **Retry allowed**: No para la solicitud original (idempotente por diseño)

### 2. Motor Antifraude (Sistema Interno)
- **Rol**: Validador de integridad y detección de fraude
- **Responsabilidades**: Verificar identidad del solicitante, detectar patrones de fraude conocidos, calcular score de riesgo
- **Criterios de evaluación**: Score > 700 = aprobado, 500-700 = revisión manual, < 500 = rechazado
- **Tiempo máximo de procesamiento**: 50ms
- **Fallback**: En caso de fallo, se asume score neutro (650) y continúa flujo con warnings

### 3. Buró de Riesgos (Servicio Externo)
- **Rol**: Consulta de historial crediticio del solicitante
- **Responsabilidades**: Retornar historial de pagos, deudas vigentes, score bureau, alertas de fraude
- **Códigos de respuesta**: SUCCESS, TIMEOUT, UNAVAILABLE, INVALID_CLIENT
- **Manejo de fallos temporales**: Retry exponencial con backoff de 100ms, 200ms, 400ms (máximo 3 intentos)
- **Fallback**: Si todos los intentos fallan, se marca como "bureau_unavailable" y se permite aprobación con condiciones

### 4. Core Bancario (Sistema Interno)
- **Rol**: Aprobación final y registro de la operación
- **Responsabilidades**: Validar capacidad financiera, registrar crédito aprobado, generar número de crédito
- **Integración síncrona**: Recibe datos validados de los pasos anteriores
- **Rollback**: Si falla el registro, se revierte la aprobación y se notifica al originador

## Puntos de Decisión del Flujo

### Decisión 1: Validación Inicial de Solicitud
- **Condición**: ¿La solicitud cumple formato y datos obligatorios?
- **Sí**: Continuar a Motor Antifraude
- **No**: Retornar error 400 con detalle de campos faltantes/inválidos

### Decisión 2: Evaluación Antifraude
- **Condición**: ¿El score de antifraude es >= 700?
- **Sí**: Continuar a Buró de Riesgos
- **No** (500-700): Escalar a revisión manual (cola async)
- **No** (< 500): Rechazar inmediatamente con código 409

### Decisión 3: Consulta Buró de Riesgos
- **Condición**: ¿La consulta al buró fue exitosa?
- **Sí**: Evaluar historial y score bureau
- **Timeout/Unavailable**: Aplicar lógica de fallback (aprobar con condiciones)
- **Error de cliente**: Rechazar por datos inválidos

### Decisión 4: Evaluación de Capacidad
- **Condición**: ¿El solicitante tiene capacidad de pago?
- **Sí**: Aprobar y registrar en Core
- **No**: Rechazar con motivo de capacidad insuficiente

### Decisión 5: Registro en Core
- **Condición**: ¿El registro fue exitoso?
- **Sí**: Retornar aprobación con número de crédito
- **No**: Ejecutar rollback y retornar error 500

## Manejo de Fallos Temporales del Buró de Riesgos

### Escenario: Timeout en Consulta de Buró
```
intento_1: consulta_buro() → timeout después de 150ms
  → esperar 100ms
intento_2: consulta_buro() → timeout después de 150ms
  → esperar 200ms  
intento_3: consulta_buro() → timeout después de 150ms
  → todas las respuestas fallidas
  → marcar como BUREAU_UNAVAILABLE
  → aplicar fallback: aprobar con score_bureau = null
  → incluir warning en respuesta: x-warning-code: BUREAU_TIMEOUT
  → continuar flujo con datos limitados
```

### Retry Policy Configurada
- **Max intentos**: 3
- **Backoff exponencial**: 100ms, 200ms, 400ms
- **Jitter**: ±20ms para evitar thundering herd
- **Circuit breaker**: Si > 50% de solicitudes fallan en 10 segundos, abrir circuito por 30 segundos

### Fallback Strategy
Cuando el buró no responde:
1. Se asume score bureau neutral (650)
2. Se reducen los límites de aprobación en 20%
3. Se añade flag "requires_manual_review" en metadata
4. Se registra evento para auditoría
5. Se notifica al equipo de operaciones

## Diagrama de Flujo (descripción textual)

```
[Inicio] → Validar_Solicitud → ¿Válida?
                                    ↓ sí              ↓ no
                            [Motor_Antifraude]      [Error 400]
                                    ↓
                            Evaluar_Score → ¿>=700?
                                    ↓ sí              ↓ no
                            [Buró_Riesgos]       [Rechazo/In Review]
                                    ↓
                            ¿Consulta_Exitosa?
                              ↓ sí        ↓ no (fallback)
                        [Evaluar_Historial]   [Aprobar_Condicional]
                                    ↓
                        [Capacidad_Financiera]
                              ↓
                        [Core_Bancario] → ¿Registro_OK?
                              ↓ sí              ↓ no
                        [Aprobación]      [Rollback + Error 500]
```

## Métricas del Proceso

| Métrica | Valor Objetivo | Crítico |
|---------|---------------|---------|
| Throughput | 1,500 req/s | 2,000 req/s |
| Latencia P99 | 200ms | 350ms |
| Disponibilidad | 99.9% | 99.5% |
| Tasa de aprobación | 75% | < 60% |
| Tasa de fallback bureau | < 5% | > 15% |

## Eventos de Negocio Emitidos

- `credit_request_received` - Solicitud entrante
- `antifraud_evaluation_completed` - Evaluación antifraude terminada
- `bureau_query_completed` - Consulta bureau terminada
- `credit_approved` - Crédito aprobado
- `credit_rejected` - Crédito rechazado
- `bureau_fallback_triggered` - Fallback de bureau activado
- `core_registration_completed` - Registro en core completado