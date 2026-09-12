# Decisiones de Diseño del Contrato de API

## Resumen Ejecutivo

Este documento documenta las decisiones de arquitectura tomadas para el contrato de API del canal transaccional de originación de créditos. Cada decisión incluye el análisis de alternativas, la selección realizada y las consecuencias en throughput y latencia.

---

## Decisión 1: REST vs SOAP

### Contexto
La integración con sistemas externos (originadores) y internos (core bancario, buró) requiere un protocolo de comunicación definido.

### Alternativas Evaluadas

| Criterio | REST | SOAP |
|----------|------|------|
| Complejidad | Baja | Media-Alta |
| Payload | JSON (menor) | XML (mayor) |
| Herramientas | Amplias | Limitadas |
| Cache HTTP | Sí | No |
| Seguridad | TLS + OAuth2 | WS-Security (sobrecarga) |
| Curva de aprendizaje | Baja | Media |

### Análisis de Rendimiento

**REST con JSON:**
- Payload promedio solicitud: ~2.5 KB
- Payload promedio respuesta: ~1.8 KB
- Overhead de parsing: ~2-5ms
- Serialización: ~1-3ms

**SOAP con XML:**
- Payload promedio solicitud: ~6.0 KB (incluye envelope SOAP)
- Payload promedio respuesta: ~4.2 KB
- Overhead de parsing: ~8-15ms
- Serialización: ~5-10ms
- Overhead WS-Security: +3-5KB y +10-20ms

### Selección: **REST con JSON**

**Justificación:**
- JSON reduce el tamaño del payload en ~60% vs XML
- La latencia adicional de parsing XML (+10ms) impacta directamente en el SLA de 200ms
- El ecosistema actual de clientes soporta REST nativamente
- La integración con sistemas modernos (motor antifraude, core) es más sencilla

**Consecuencias en throughput y latencia:**
- **Throughput**: +25-35% vs SOAP por menor tamaño de payload y overhead de procesamiento
- **Latencia**: -15-20ms promedio por eliminación de parseo XML y envelope SOAP
- **Recursos**: -30% uso de CPU en servidores por serialización más eficiente

---

## Decisión 2: JSON vs XML

### Contexto
Una vez seleccionado REST como protocolo, se debe definir el formato de datos.

### Alternativas Evaluadas

| Criterio | JSON | XML |
|----------|------|-----|
| Tamaño payload | Menor | Mayor |
| Legibilidad | Media | Alta |
| Validación de esquemas | JSON Schema | XSD |
| Soporte binario | Base64 | MTOM |
| Nativos clientes | Todos | Limitado |

### Análisis de Rendimiento

**JSON:**
- Parsing: ~1-3ms con JSON.parse nativo
- Serialización: ~1-2ms con JSON.stringify
- Tamaño: ~40-50% menor que XML equivalente

**XML:**
- Parsing: ~5-12ms con DOMParser
- Serialización: ~4-8ms con XMLSerializer
- Tamaño: referencia base

### Selección: **JSON**

**Justificación:**
- JSON es el estándar de facto para APIs REST modernas
- El parsing nativo en navegadores y runtimes es más rápido
- La reducción de tamaño impacta positivamente en bandwidth y latencia
- JSON Schema ofrece validación equivalente a XSD con menor complejidad

**Consecuencias en throughput y latencia:**
- **Throughput**: +20-30% por menor tamanho de requests
- **Latencia**: -8-12ms por parsing más eficiente
- **Ancho de banda**: -40% vs XML

---

## Decisión 3: Versionado con Headers vs URL

### Contexto
Las APIs evolucionan y requieren versionado para mantener compatibilidad con clientes existentes.

### Alternativas Evaluadas

| Criterio | Header (Accept) | URL Path | Query Parameter |
|----------|-----------------|----------|-----------------|
| Visibilidad | Baja | Alta | Media |
| Cache-friendly | No | Sí | Parcial |
| Documentación | Compleja | Simple | Simple |
| Cliente legacy | Difícil | Fácil | Fácil |

### Análisis de Rendimiento

**Versionado por URL (v1/credit-requests):**
- Cacheo en CDN: Sí, por URL completa
- Routing: Directo, sin análisis de headers
- Latencia routing: ~0.1ms

**Versionado por Header (Accept: application/vnd.banco.v1+json):**
- Cacheo en CDN: No, requiere configuración Vary
- Routing: Análisis de header adicional
- Latencia routing: ~0.5-1ms por parsing de header

### Selección: **URL Path**

**Justificación:**
- El versionado en URL es más visible y fácil de documentar
- Los clientes pueden hacer cache efectivo de las respuestas
- El routing es más eficiente sin análisis de headers
- Es el estándar de facto (Stripe, GitHub, Twitter)

**Consecuencias en throughput y latencia:**
- **Throughput**: +5-10% en cache hit ratio por versionado en URL
- **Latencia**: -0.5-1ms por request por eliminación de parsing de headers
- **CDN**: Configuración más simple y efectividad de cache mayor

---

## Decisión 4: Manejo de Errores con Códigos HTTP vs Extensiones OpenAPI

### Contexto
La API debe comunicar errores de manera estándar y extensible para que los clientes puedan manejar diferentes tipos de fallo.

### Alternativas Evaluadas

| Criterio | Solo Códigos HTTP | Códigos + x-error-code | Códigos + Cuerpo Detallado |
|----------|-------------------|------------------------|---------------------------|
| Simplicidad | Alta | Media | Media |
| Granularidad | Baja | Alta | Alta |
| Estandarización | RFC 7231 | Propietario | RFC 7807 |
| Cliente legacy | Compatible | Requiere adaptación | Requiere adaptación |

### Análisis de Rendimiento

**Solo códigos HTTP (200, 400, 409, 500):**
- Payload error: ~100-200 bytes
- Parsing: ~0.5ms
- Granularidad: Solo 5xx para errores de servidor, 4xx para cliente

**Códigos + x-error-code (409 + x-error-code: BUREAU_TIMEOUT):**
- Payload error: ~300-500 bytes
- Parsing: ~1ms
- Granularidad: Alta, permite manejo específico por tipo de error

### Selección: **Códigos HTTP + Extensiones OpenAPI (x-error-code, x-error-details)**

**Justificación:**
- Los códigos HTTP estándar comunican la categoría del error
- Las extensiones x-error-code permiten granularidad sin violar el estándar HTTP
- El cuerpo de error sigue RFC 7807 (Problem Details) para compatibilidad
- Permite identificar errores específicos del dominio (BUREAU_TIMEOUT, DUPLICATE_REQUEST, etc.)

**Consecuencias en throughput y latencia:**
- **Throughput**: Neutral, el overhead de extensiones es mínimo (~200 bytes)
- **Latencia**: +0.5ms por parsing de cuerpo de error extendido
- **Experience**: + значительно (significantly) mejor experience de debugging y manejo de errores en clientes

**Ejemplo de respuesta de error:**
```json
{
  "type": "https://api.banco.com/errors/credit-rejected",
  "title": "Credit Rejected",
  "status": 409,
  "detail": "La solicitud fue rechazada por score insuficiente",
  "x-error-code": "INSUFFICIENT_SCORE",
  "x-error-details": {
    "antifraud_score": 450,
    "bureau_score": 580,
    "required_minimum": 700
  }
}
```

---

## Decisión 5: Idempotencia por Header vs Path

### Contexto
Las solicitudes de crédito deben ser idempotentes para evitar duplicados en caso de retry del cliente.

### Alternativas Evaluadas

| Criterio | Idempotency-Key Header | ID en Path | Query Param |
|----------|----------------------|------------|-------------|
| Semántica REST | Media | Alta | Baja |
| Seguridad | Alta | Media | Baja |
| Cache | Compatible | Limitado | No |

### Análisis de Rendimiento

**Idempotency-Key Header:**
- Overhead: 1 header (~50 bytes)
- Lookup en cache: ~1-2ms (Redis)
- Storage: 24 horas TTL

**ID en Path (/credit-requests/{id}):**
- No permite generar nuevo ID en cliente
- Requiere POST primero para obtener ID
- Añade round-trip

### Selección: **Idempotency-Key Header (Idempotency-Key: <uuid>)**

**Justificación:**
- Permite al cliente controlar el ID de idempotencia con un UUID
- El header es el estándar de facto (Stripe, PayPal, Amazon)
- La semántica es clara: mismo idempotency-key = mismo resultado
- No requiere cambio en la URL o estructura de recursos

**Consecuencias en throughput y latencia:**
- **Throughput**: -2-5% por overhead de lookup de idempotencia en cache
- **Latencia**: +1-2ms por verificación de clave en Redis
- **Confiabilidad**: Garantía de no-duplicados, valor crítico para transacciones financieras

---

## Decisión 6: Patrón de Integración (Orquestado vs Coreografiado)

### Contexto
Múltiples sistemas participan en el flujo de originación: antifraude, buró, core.

### Alternativas Evaluadas

| Criterio | Orquestado | Coreografiado | Híbrido |
|----------|------------|---------------|---------|
| Acoplamiento | Alto | Bajo | Medio |
| Visibilidad de flujo | Alta | Baja | Media |
| Manejo de errores | Centralizado | Distribuido | Mixto |
| Latencia | Alta (chain) | Baja (paralelo) | Media |

### Análisis de Rendimiento

**Orquestado (síncrono, chain):**
- Latencia total: sum(latencia cada paso)
- Antifraude (50ms) + Buró (80ms) + Core (40ms) = 170ms
- Failed fast: sí, en cualquier paso

**Coreografiado (eventos):**
- Latencia total: max(latencia pasos paralelos) + overhead
- En paralelo: max(50, 80, 40) = 80ms + 20ms overhead = 100ms
- Failed fast: no, requiere compensación

### Selección: **Orquestado Síncrono**

**Justificación:**
- El flujo requiere validación secuencial (no puedes consultar buró si antifraude falla)
- El cliente espera respuesta síncrona en < 200ms
- La trazabilidad es más simple con orchestrator central
- El manejo de errores es más directo (rollback desde orchestrator)

**Consecuencias en throughput y latencia:**
- **Throughput**: -10-15% vs coreografiado por ejecución secuencial
- **Latencia**: 170ms promedio (dentro de SLA de 200ms)
- **Simplicidad**: + significativamente en debugging y monitoreo

---

## Resumen de Impacto en Métricas No Funcionales

| Decisión | Throughput Impact | Latencia Impact | Complejidad |
|----------|-------------------|-----------------|-------------|
| REST vs SOAP | +30% | -15ms | - |
| JSON vs XML | +25% | -10ms | - |
| Versionado URL | +5% | -0.5ms | - |
| Errores extendidos | 0% | +0.5ms | + |
| Idempotency-Key | -3% | +1.5ms | + |
| Orquestado | -10% | +70ms | + |

**Total estimado:**
- Throughput: +47% vs alternativa SOAP+XML
- Latencia: +46.5ms overhead total (dentro de SLA 200ms)
- Complejidad: Media, manejable con herramientas actuales