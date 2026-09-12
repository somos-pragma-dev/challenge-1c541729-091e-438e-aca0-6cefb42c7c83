Feature: Contrato de API para Canal Transaccional - Criterios de Aceptacion

  Como equipo de Integracion,
  Necesito validar que el contrato de API cumple con los requisitos funcionales y no funcionales,
  Para garantizar la calidad del contrato antes de la implementacion.

  Background:
    Given el sistema de origen "canal_transaccional"
    And el endpoint base "https://api.banco.com/v1"
    And la configuracion de timeout "200ms" para llamadas externas

  # ============================================================================
  # ESCENARIOS DE IDEMPOTENCIA
  # ============================================================================

  @idempotencia @happy-path
  Scenario: Solicitud de credito con clave de idempotencia unica
    Given una solicitud de credito con los siguientes datos:
      | campo                    | valor                           |
      | idempotency-key          | 550e8400-e29b-41d4-a716-446655 |
      | numero_identificacion    | 12345678                        |
      | tipo_identificacion      | CC                              |
      | monto_solicitado         | 5000000                         |
      | plazo_meses              | 24                              |
      | destino                 | CONSUMO                         |
    When el cliente envia una solicitud POST "/creditos/solicitud"
    Then la respuesta debe tener codigo de estado "201 Created"
    And el header "Idempotency-Key" debe ser "550e8400-e29b-41d4-a716-446655"
    And el cuerpo de respuesta debe contener "estado": "APROBADO"
    And la respuesta debe incluir "id_solicitud": "SOL-2024-000001"

  @idempotencia @duplicado
  Scenario: Solicitud de credito con clave de idempotencia duplicada
    Given una solicitud de credito existente con clave "550e8400-e29b-41d4-a716-446655"
    And el estado actual de la solicitud es "APROBADO"
    And la respuesta original contiene "id_solicitud": "SOL-2024-000001"
    When el cliente envia una solicitud POST "/creditos/solicitud" con la misma clave
    Then la respuesta debe tener codigo de estado "200 OK"
    And la respuesta debe ser identical a la solicitud original
    And no debe procesarse una nueva solicitud en el core bancario
    And el header "X-Idempotent-Replay" debe ser "true"

  @idempotencia @expirada
  Scenario: Solicitud con clave de idempotencia expirada
    Given una solicitud con clave "550e8400-e29b-41d4-a716-446655"
    And la clave expiro hace "25 horas" (TTL: 24 horas)
    When el cliente envia la solicitud con la clave expirada
    Then la respuesta debe tener codigo de estado "409 Conflict"
    And el error debe contener "x-error-code": "IDEMPOTENCY_KEY_EXPIRED"
    And el mensaje debe indicar "La clave de idempotencia expiro. Genere una nueva clave."

  @idempotencia @header-faltante
  Scenario: Solicitud de credito sin header de idempotencia
    Given una solicitud de credito valida sin el header "Idempotency-Key"
    When el cliente envia POST "/creditos/solicitud"
    Then la respuesta debe tener codigo de estado "400 Bad Request"
    And el error debe contener "x-error-code": "IDEMPOTENCY_KEY_REQUIRED"
    And el mensaje debe indicar "El header Idempotency-Key es obligatorio para operaciones de credito."

  # ============================================================================
  # ESCENARIOS DE TOLERANCIA A FALLOS
  # ============================================================================

  @tolerancia-fallos @bureau-caido
  Scenario: Buró de riesgos no disponible - primer reintento
    Given el servicio "buro_riesgos" esta caido
    And el numero de reintentos configurado es "3"
    And el tiempo de espera inicial es "100ms"
    And el factor de backoff es "exponencial"
    When el cliente envia una solicitud de credito
    Then el sistema debe registrar el intento "1" de reintento
    And debe esperarse "100ms" antes del primer reintento
    And la solicitud debe reenviarse automaticamente al buró

  @tolerancia-fallos @bureau-caido-reintento2
  Scenario: Buró de riesgos no disponible - segundo reintento con backoff
    Given el servicio "buro_riesgos" esta caido
    And el primer reintento fallo
    When el sistema ejecuta el segundo reintento
    Then debe esperarse "200ms" (100ms * 2)
    And debe incrementarse el contador de reintentos a "2"
    And la solicitud debe reenviarse automaticamente

  @tolerancia-fallos @bureau-caido-reintento3
  Scenario: Buró de riesgos no disponible - tercer reintento
    Given el servicio "buro_riesgos" esta caido
    And los primeros "2" reintentos fallaron
    When el sistema ejecuta el tercer reintento
    Then debe esperarse "400ms" (100ms * 2^2)
    And debe alcanzarse el maximo de reintentos
    And la solicitud debe marcarse como "PENDIENTE_BURO"

  @tolerancia-fallos @bureau-recuperado
  Scenario: Buró se recupera despues de reintentos
    Given el servicio "buro_riesgos" estuvo caido
    And el sistema ejecuto "3" reintentos sin exito
    And la solicitud esta en estado "PENDIENTE_BURO"
    When el servicio "buro_riesgos" se recupera
    And el proceso de reconciliacion ejecuta la consulta de buró
    Then la solicitud debe actualizarse con el resultado del buró
    And el estado debe cambiar a "APROBADO" o "RECHAZADO"

  @tolerancia-fallos @timeout-antifraude
  Scenario: Timeout en servicio de antifraude
    Given el servicio "antifraude" no responde en "200ms"
    And el timeout configurado es "200ms"
    When el cliente envia una solicitud de credito
    Then la respuesta debe tener codigo de estado "503 Service Unavailable"
    And el error debe contener "x-error-code": "ANTIFRAUDE_TIMEOUT"
    And debe incluirse el header "Retry-After": "5"
    And el cliente debe poder reintentar en "5 segundos"

  @tolerancia-fallos @circuit-breaker
  Scenario: Circuit breaker abierto despues de fallos consecutivos
    Given el umbral de fallos es "5" errores en "10 segundos"
    And el servicio "core_bancario" tiene "6" fallos consecutivos
    When el circuito se abre
    And el cliente envia una nueva solicitud
    Then la respuesta debe tener codigo de estado "503 Service Unavailable"
    And el error debe contener "x-error-code": "CIRCUIT_BREAKER_OPEN"
    And el tiempo de duracion del circuito abierto es "30 segundos"

  @tolerancia-fallos @fallback-partial
  Scenario: Respuesta parcial con cache local
    Given el cache local tiene datos de buró del cliente "12345678"
    And la antiguedad del cache es "1 hora"
    When el servicio "buro_riesgos" esta caido
    Then el sistema debe usar los datos del cache como fallback
    And la respuesta debe incluir "x-cache-hit": "true"
    And el riesgo calculado debe basarse en datos cacheados
    But debe mostrarse una advertencia en la respuesta

  # ============================================================================
  # ESCENARIOS DE THROUGHPUT Y RENDIMIENTO
  # ============================================================================

  @rendimiento @throughput-normal
  Scenario: Sistema procesa 1000 solicitudes por segundo
    Given una carga de "1000" solicitudes por segundo
    And el umbral maximo de latencia es "200ms"
    When se ejecutan las solicitudes durante "60 segundos"
    Then el porcentaje de solicitudes exitosas debe ser mayor al "99.9%"
    And la latencia promedio debe ser menor a "150ms"
    And la latencia p99 debe ser menor a "200ms"

  @rendimiento @throughput-pico
  Scenario: Sistema procesa 1500 solicitudes por segundo en hora pico
    Given una carga de "1500" solicitudes por segundo
    And el umbral maximo de latencia es "200ms"
    When se ejecutan las solicitudes durante "60 segundos"
    Then el porcentaje de solicitudes exitosas debe ser mayor al "99.9%"
    And ninguna solicitud debe exceder "500ms" (timeout del cliente)
    And el uso de memoria debe ser menor al "80%"

  @rendimiento @throughput-sobrecarga
  Scenario: Sistema bajo sobrecarga - degradacion graceful
    Given una carga de "2000" solicitudes por segundo
    And el sistema esta configurado para "1500" rps maximo
    When se excede la capacidad
    Then el sistema debe rechazar solicitudes con "429 Too Many Requests"
    And debe incluir el header "Retry-After": "1"
    And las solicitudes en proceso deben completarse
    But no deben acumularse encola mas de "100" solicitudes

  @rendimiento @latencia-alta
  Scenario: Latencia elevada en servicio de antifraude
    Given el servicio "antifraude" tiene latencia de "250ms"
    And el SLA esperado es "200ms"
    When el cliente envia una solicitud
    Then la respuesta debe exceder los "200ms"
    And debe generarse una alerta de monitoreo
    And debe registrase el evento "HIGH_LATENCY"

  @rendimiento @concurrencia
  Scenario: Multiples solicitudes concurrentes al mismo cliente
    Given el cliente "12345678" envia "10" solicitudes simultaneas
    And todas tienen el mismo "numero_identificacion"
    When se procesan las solicitudes en paralelo
    Then solo "1" solicitud debe procesarse
    And las demas deben recibir "409 Conflict"
    And el error debe indicar "Solicitud duplicada en proceso"

  # ============================================================================
  # ESCENARIOS DE CONSISTENCIA DE DATOS
  # ============================================================================

  @consistencia @validacion-campos
  Scenario: Validacion de campos obligatorios
    Given una solicitud con campo obligatorio faltante "monto_solicitado"
    When el cliente envia POST "/creditos/solicitud"
    Then la respuesta debe tener codigo de estado "400 Bad Request"
    And el error debe contener "x-error-code": "VALIDATION_ERROR"
    And los detalles deben indicar "monto_solicitado es obligatorio"

  @consistencia @tipo-dato-invalido
  Scenario: Tipo de dato incorrecto en campo numerico
    Given una solicitud con "monto_solicitado": "cincomillones"
    When el cliente envia la solicitud
    Then la respuesta debe tener codigo de estado "400 Bad Request"
    And el error debe indicar que el tipo debe ser "number"

  @consistencia @rangos
  Scenario: Monto fuera de rango permitido
    Given una solicitud con monto "60000000" (maximo: 50000000)
    When el cliente envia la solicitud
    Then la respuesta debe tener codigo de estado "400 Bad Request"
    And el error debe contener "x-error-code": "MONTO_EXCEDE_LIMITE"
    And el mensaje debe indicar el rango valido

  # ============================================================================
  # ESCENARIOS DE TRAZABILIDAD
  # ============================================================================

  @trazabilidad @trace-id
  Scenario: Trazabilidad entre servicios con trace-id
    Given el cliente envia una solicitud con header "X-Trace-ID": "abc123"
    When la solicitud se procesa a traves de los servicios
    Then cada logs debe incluir "trace_id": "abc123"
    And la respuesta debe devolver el mismo "X-Trace-ID"
    And en caso de error debe poder trazarse el flujo completo

  @trazabilidad @auditoria
  Scenario: Registro de auditoria para cada solicitud
    Given una solicitud de credito exitosa
    When se procesa la solicitud
    Then debe crearse un registro de auditoria con:
      | campo              | valor                              |
      | id_solicitud       | SOL-2024-000001                    |
      | timestamp          | 2024-01-15T10:30:00Z               |
      | usuario            | canal_transaccional                |
      | accion             | CREDITO_SOLICITADO                 |
      | resultado          | APROBADO                           |
      | idempotency-key    | 550e8400-e29b-41d4-a716-446655     |