# Analisis de Riesgo - Contrato de API Canal Transaccional

## 1. Resumen Ejecutivo

Este documento identifica los modos de falla, evalua el impacto y propone estrategias de mitigacion para el contrato de API del canal transaccional. El sistema debe soportar 1,500 solicitudes por segundo (rps) con una latencia maxima de 200ms y un SLA del 99.9% de disponibilidad.

## 2. Actores del Sistema y Dependencias Externas

| Actor/Sistema              | Rol                                    | Criticidad  |
|----------------------------|----------------------------------------|-------------|
| Canal Transaccional        | Cliente de la API (originador)         | Alta        |
| Motor Antifraude           | Validacion de riesgo crediticio        | Alta        |
| Buró de Riesgos            | Consulta de historial crediticio       | Alta        |
| Core Bancario              | Originacion y gestión del crédito      | Critica     |
| Sistema de Auditoria       | Registro de trazabilidad               | Media       |

## 3. Modos de Falla Identificados

### 3.1 Falla en Buró de Riesgos

**Descripcion**: El servicio de consulta al buró de riesgos (experian, transunion o equivalente) no responde o responde con timeout.

**Sintomas**:
- Timeout despues de 200ms al intentar conectar
- Error de conexion "Connection refused"
- Respuesta con codigo HTTP 503 Service Unavailable
- Latencia elevada (mayor a 500ms)

**Frecuencia Estimada**: Alta (3-5 veces por dia en horas pico)

**Causas Raiz Comunes**:
- Sobrecarga del servicio externo del buró
- Problemas de red o firewall
- Mantenimiento programado sin notificacion
- Fallo en proveedor de conectividad

### 3.2 Timeout en Motor Antifraude

**Descripcion**: El servicio de validacion antifraude no responde dentro del tiempo esperado.

**Sintomas**:
- Respuesta lenta (mayor a 200ms)
- Timeout en la llamada al servicio
- Error "ANTIFRAUDE_TIMEOUT" con codigo 503

**Frecuencia Estimada**: Media (1-2 veces por dia)

**Causas Raiz Comunes**:
- Base de datos de reglas saturada
- Modelo de ML con inferencia lenta
- Concurrencia excesiva de consultas
- Recursos de infraestructura insuficientes

### 3.3 Core Bancario Saturado

**Descripcion**: El sistema core del banco no puede procesar el volumen de solicitudes.

**Sintomas**:
- Alta latencia en respuestas (mayor a 1s)
- Errores de timeout frecuentes
- Cola de procesamiento llena
- Uso de CPU superior al 90%

**Frecuencia Estimada**: Baja (eventual en picos extremos)

**Causas Raiz Comunes**:
- Throughput excede capacidad diseniada
- Bloqueos en base de datos
- Procesos batch competidores
- Fallo de nodos en cluster

### 3.4 Duplicacion de Solicitudes

**Descripcion**: El cliente envia la misma solicitud multiple veces sin clave de idempotencia.

**Sintomas**:
- Multiple creditos aprobados para el mismo cliente
- Inconsistencia en estado de cuenta
- Registros duplicados en core
- Violacion de reglas de negocio

**Frecuencia Estimada**: Media (errores de cliente)

**Causas Raiz Comunes**:
- Cliente no implementa retry con idempotencia
- Timeout de red causing retransmision
- Botones duplicados en interfaz
- Integracion con sistemas legacy

### 3.5 Fallo de Red Entre Componentes

**Descripcion**: La red entre el API gateway y los servicios internos presenta problemas.

**Sintomas**:
- Error de conexion entre servicios
- Paquetes perdidos
- Latencia variable
- DNS resolution failures

**Frecuencia Estimada**: Baja (infraestructura estable)

## 4. Matriz de Impacto y Probabilidad

| Modo de Falla          | Probabilidad | Impacto   | Severidad | Prioridad |
|------------------------|--------------|-----------|-----------|----------|
| Buró caído             | Alta         | Alto      | Critica   | P1       |
| Timeout antifraude     | Media        | Alto      | Alta      | P1       |
| Core saturado          | Baja         | Critico   | Critica   | P2       |
| Duplicacion solicitudes| Media        | Alto      | Alta      | P1       |
| Fallo de red           | Baja         | Medio     | Media     | P3       |

## 5. Impacto por Escenario

### 5.1 Impacto: Rechazo de 30% de Solicitudes

**Escenario**: Cuando el buró de riesgos esta caido y no hay mecanismo de fallback.

**Efectos en Negocio**:
- Perdida de oportunidades de credito (30% de solicitudes rechazadas)
- Insatisfaccion del cliente (tiempo de espera prolongado)
- Impacto en metricas de conversion (drop en aprobaciones)
- Costo operacional (procesos manuales de recuperacion)

**Perdida Economica Estimada**:
- 30% de 1,500 rps = 450 solicitudes/hora perdidas
- Promedio de $500,000 por credito = $225,000,000/hora
- En hora pico de 2 horas = $450,000,000 en perdidas potenciales

### 5.2 Impacto: Latencia Excesiva

**Escenario**: Tiempo de respuesta mayor a 500ms.

**Efectos**:
- Timeout en clientes移动 (apps mobiles)
- Abandono de usuarios (bounce rate)
- Experiencia de usuario degradada
- Reintentos que aumentan carga

### 5.3 Impacto: Duplicacion de Creditos

**Escenario**: Solicitudes duplicadas procesadas correctamente.

**Efectos**:
- Exceso de exposure crediticio
- Violacion de politicas de riesgo
- Procesos de reversa costosos
- Impacto en indicadores de mora
- Reclamaciones y soporte

## 6. Estrategias de Mitigacion

### 6.1 Reintentos con Backoff Exponencial

**Implementacion**:
```
Reintentos maximos: 3
Backoff inicial: 100ms
Factor de multiplicacion: 2
Backoff maximo: 400ms

Intento 1: inmediato
Intento 2: 100ms despues
Intento 3: 300ms despues (100ms * 2^1)
Intento 4: 700ms despues (100ms * 2^2) - si aplica
```

**Parametros de Configuracion**:
- `retry.maxAttempts`: 3
- `retry.initialInterval`: 100ms
- `retry.multiplier`: 2.0
- `retry.maxInterval`: 400ms
- `retry.jitter`: true (para evitar thundering herd)

**Beneficio Esperado**: Reduccion del 80% en rechazos por fallas transitorias.

### 6.2 Circuit Breaker

**Configuracion**:
```
Umbral de apertura: 5 fallos en 10 segundos
Tiempo de duracion abierto: 30 segundos
Umbral de media apertura: 2 exitosos
```

**Estados**:
- **Cerrado**: Operaciones normales, cuenta fallos
- **Abierto**: Falla rapida, rechaza solicitudes inmediatamente
- **Media apertura**: Prueba si el servicio se recupero

**Beneficio**: Previene cascadas de fallo y permite recuperacion del sistema.

### 6.3 Cache Local de Buró

**Estrategia**:
- TTL de cache: 24 horas para datos de buró
- Solo para consultas de riesgo (no datos sensibles)
- Fallback cuando buró esta caido
- Advertencia en respuesta indicando datos cacheados

**Datos a Cachear**:
- Score crediticio
- Categoría de riesgo
- Historial de pagos (resumen)

**No Cachear**:
- Datos personales identificables
- Detalles de cuentas abiertas
- Informacion sensible financieros

**Beneficio**: Continuidad operativa durante 80% de fallas de buró.

### 6.4 Idempotencia en Solicitudes de Credito

**Implementacion**:
- Header obligatorio: `Idempotency-Key` (UUID v4)
- Almacenamiento en Redis con TTL de 24 horas
- Respuesta cacheada para duplicados
- Log de solicitudes duplicadas para auditoria

**Flujo**:
1.Cliente genera UUID y lo incluye en header
2.API valida presencia del header
3.Se verifica si la clave existe en cache
4.Si existe: retorna respuesta original (200 OK)
5.Si no existe: procesa y almacena respuesta

**Beneficio**: Eliminacion total de duplicaciones accidentales.

### 6.5 Rate Limiting y Degradacion Graceful

**Limites**:
- Throughput maximo: 1,700 rps (buffer sobre 1,500)
- Burst permitido: 100 solicitudes
- Timeout de cola: 5 segundos

**Respuesta cuando se excede**:
- Codigo: 429 Too Many Requests
- Header Retry-After: 1 segundo
- No acepta solicitudes hasta reducir carga

**Beneficio**: Proteccion contra sobrecarga y degradacion controlada.

### 6.6 Monitoreo y Alertas

**Metricas Clave**:
- Latencia p50, p95, p99
- Tasa de error por servicio
- Usage de recursos (CPU, memoria, conexiones)
- Queue depth
- Circuit breaker state

**Alertas**:
| Metrica                            | Umbral de Alerta      |
|------------------------------------|-----------------------|
| Latencia p99                       | > 200ms              |
| Tasa de error                      | > 1%                 |
| Circuit breaker abierto           | > 1 minuto           |
| Uso de memoria                     | > 80%                |
| Cola de solicitudes                | > 100                |

## 7. SLA y Objetivos de Disponibilidad

### 7.1 SLA Comprometido

| Metrica                    | Valor Objetivo |
|----------------------------|----------------|
| Disponibilidad             | 99.9%          |
| Tiempo de inactividad max  | 8.76 horas/año |
| Latencia p99               | < 200ms        |
| Throughput sostenido       | 1,500 rps      |
| Tasa de error              | < 0.1%         |

### 7.2 Desglose por Servicio

| Servicio              | Disponibilidad Objetivo |
|-----------------------|-------------------------|
| API Gateway           | 99.95%                  |
| Motor Antifraude      | 99.9%                   |
| Buró de Riesgos       | 99.9%                   |
| Core Bancario         | 99.99%                  |
| Cache/Redis           | 99.95%                  |

### 7.3 Calculo de Presupuesto de Error

Para 99.9% de disponibilidad en un servicio que recibe 1,500 rps:

```
Solicitudes por dia: 1,500 * 60 * 60 * 24 = 129,600,000
Presupuesto de error (0.1%): 129,600 solicitudes/ dia
Error por hora: 129,600 / 24 = 5,400 errores/ hora
Error por minuto: 5,400 / 60 = 90 errores/ minuto
```

## 8. Plan de Contingencia

### 8.1 Acciones por Tipo de Falla

| Tipo de Falla              | Accion Contingencia                              |
|----------------------------|--------------------------------------------------|
| Buró caido < 5 min        | Reintentos automaticos + cache fallback         |
| Buró caido > 5 min        | Aprobar sin consulta de buró (riesgo controlado)|
| Antifraude caido           | Aprobar con validacion basica (sin score ML)    |
| Core saturado              | Queue con timeout + notificacion al cliente     |
| Duplicacion detectada      | Bloqueo de cliente + notificacion               |

### 8.2 Runbooks Operativos

**Runbook: Buró de Riesgos No Disponible**
1. Verificar estado del circuito (abierto/cerrado)
2. Confirmar que reintentos estan activos
3. Validar cache de fallback disponible
4. Si tiempo > 5 min: escalar a equipo de infraestructura
5. Notificar a equipo de riesgo sobre aprobaciones sin buró

**Runbook: Latencia Elevada**
1. Identificar servicio cuello de botella
2. Verificar recursos del servicio (CPU, memoria)
3. Revisar queries lentas en base de datos
4. Escalar si latencia p99 > 500ms por mas de 5 minutos

## 9. Recomendaciones

### 9.1 Prioridades de Implementacion

1. **Inmediata** (Semana 1-2):
   - Implementar idempotencia en API
   - Configurar cache de buró
   - Establecer reintentos con backoff

2. **Corto Plazo** (Semana 3-4):
   - Implementar circuit breaker
   - Configurar rate limiting
   - Desplegar dashboard de monitoreo

3. **Mediano Plazo** (Mes 2-3):
   - Pruebas de carga (1,500 rps)
   - Drill de recuperacion de desastres
   - Documentacion de runbooks

### 9.2 Inversiones en Infraestructura

| Componente           | Recomendacion                              |
|----------------------|--------------------------------------------|
| Cache                | Redis cluster con replica                  |
| API Gateway          | Kong o AWS API Gateway con rate limiting  |
| Monitoreo            | Prometheus + Grafana                       |
| Logging              | ELK Stack o Datadog                        |
| Alerting             | PagerDuty o OpsGenie                       |

## 10. Aprobaciones

| Rol                      | Nombre          | Fecha          |
|--------------------------|-----------------|----------------|
| Lead Integracion         | [Pendiente]     | [Fecha]        |
| Arquitecto de Solucion   | [Pendiente]     | [Fecha]        |
| Risk Manager             | [Pendiente]     | [Fecha]        |
| CTO                      | [Pendiente]     | [Fecha]        |

---
*Documento generado para el proyecto de Contrato de API Canal Transaccional*
*Version: 1.0*
*Fecha: 2024-01-15*