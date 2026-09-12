# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Como saber que terminaste

```bash
npx --yes @redocly/cli lint openapi.yaml
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Integración, Especialidad Analista SOA, Tecnología Api, Senior

### Brecha de conocimiento
Necesita fortalecer la practica de Api

### Misión / candidato
Liderar la iniciativa de contrato de api para el canal transaccional

### Reto
- Tema: Contrato de API para el canal transaccional
- Seniority: senior-l2
- Tipo: practical
- Título: Diseño y Implementación de Contrato de API para Canal Transaccional
- Tiempo estimado: 4 semanas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Exploración y Definición de Requisitos — objetivo: Identificar y documentar los requisitos funcionales y no funcionales del contrato de API. — entregable (NO resolver): Documento de requisitos funcionales y no funcionales del contrato de API.
- Fase 2: Diseño del Contrato de API — objetivo: Diseñar el contrato de API basado en los requisitos definidos. — entregable (NO resolver): Diseño conceptual del contrato de API con endpoints, métodos, esquemas, y decisiones de diseño documentadas.
- Fase 3: Implementación y Validación del Contrato de API — objetivo: Implementar y validar el contrato de API diseñado. — entregable (NO resolver): Contrato de API implementado y validado, con pruebas unitarias y de integración documentadas.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: api-spec/openapi.yaml ===
openapi: 3.1.0
info:
  title: Canal Transaccional - API de Crédito
  description: |
    Contrato de API para el canal transaccional de gestión de créditos.
    Integración con originador de créditos, motor antifraude, buró de riesgos y core bancario.
    
    ## Características Principales
    - Idempotencia en operaciones de crédito mediante header Idempotency-Key
    - Throughput: 1,500 rps en hora pico
    - Latencia máxima: 200ms
    - SLA: 99.9%
    - Tolerancia a fallos temporales del buró de riesgos
    
    ## Estándares Aplicados
    - BIAN Service Domains para modelado de servicios financieros
    - ISO 20022 para mensajes financieros
    - FAPI para seguridad en APIs financieras
  version: 1.0.0
  contact:
    name: Equipo de Integración
    email: integracion@empresa.com
  license:
    name: Proprietario
    url: https://empresa.com/licencia

extensions:
  x-throughput: 1500
  x-max-latency: 200
  x-sla: 99.9
  x-bian-version: "17.06"

servers:
  - url: https://api.canal-transaccional.empresa.com/v1
    description: Servidor de producción
    variables:
      version:
        default: v1
  - url: https://sandbox.canal-transaccional.empresa.com/v1
    description: Servidor de sandbox para pruebas

security:
  - OAuth2ClientCredentials: []
  - ApiKeyHeader: []

tags:
  - name: Créditos
    description: Operaciones de gestión de solicitudes de crédito
  - name: Consultas
    description: Consultas de estado y historial
  - name: Salud
    description: Endpoints de health check y métricas

paths:
  /creditos/solicitudes:
    post:
      tags:
        - Créditos
      summary: Crear solicitud de crédito
      description: |
        Crea una nueva solicitud de crédito en el canal transaccional.
        El proceso orquesta las validaciones de antifraude, buró de riesgos y confirmación del core bancario.
        
        ## Idempotencia
        Este endpoint es idempotente. Envíe el header `Idempotency-Key` con un UUID único
        para evitar duplicados en caso de reintentos por timeout.
        
        ## Flujo de Procesamiento
        1. Validación de solicitud (schema)
        2. Evaluación antifraude
        3. Consulta buró de riesgos
        4. Registro en core bancario
        5. Respuesta al cliente
      operationId: crearSolicitudCredito
      parameters:
        - $ref: '#/components/parameters/IdempotencyKey'
        - $ref: '#/components/parameters/X-Correlation-ID'
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/SolicitudCredito'
            example:
              solicitud_id: "SOL-2024-00012345"
              cliente:
                tipo_documento: "CC"
                numero_documento: "1234567890"
                nombre: "Juan Pérez García"
                correo: "juan.perez@email.com"
                telefono: "+573001234567"
              credito:
                monto: 50000000
                moneda: "COP"
                plazo_meses: 36
                tasa_interes: 1.5
                destino: "CONSUMO"
              ingreso:
                salary: 8000000
                otros_ingresos: 500000
                salary_neto: 6800000
              empleo:
                tipo_contrato: "FIJO"
                antiguedad_meses: 24
                empresa: "Empresa ABC SAS"
      responses:
        '201':
          description: Solicitud de crédito creada exitosamente
          headers:
            X-Correlation-ID:
              schema:
                type: string
              description: Correlation ID para trazabilidad
            X-Request-Id:
              schema:
                type: string
              description: ID único de la solicitud
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/RespuestaSolicitudCredito'
              example:
                solicitud_id: "SOL-2024-00012345"
                estado: "APROBADO"
                mensaje: "Solicitud aprobada"
                fecha_aprobacion: "2024-01-15T10:30:00Z"
                numero_credito: "CRE-2024-00098765"
                detalles:
                  monto_aprobado: 50000000
                  tasa_interes: 1.5
                  plazo_meses: 36
                  cuota_mensual: 1687500
        '400':
          $ref: '#/components/responses/ErrorValidacion'
        '401':
          $ref: '#/components/responses/ErrorAutenticacion'
        '403':
          $ref: '#/components/responses/ErrorAutorizacion'
        '409':
          $ref: '#/components/responses/ErrorConflicto'
        '422':
          $ref: '#/components/responses/ErrorNegocio'
        '429':
          $ref: '#/components/responses/ErrorRateLimit'
        '500':
          $ref: '#/components/responses/ErrorInterno'
        '503':
          $ref: '#/components/responses/ErrorServicioNoDisponible'

  /creditos/solicitudes/{solicitudId}:
    get:
      tags:
        - Consultas
      summary: Consultar estado de solicitud de crédito
      description: |
        Consulta el estado actual de una solicitud de crédito previamente creada.
        Retorna información completa incluyendo historial de estados y evaluaciones.
      operationId: consultarSolicitudCredito
      parameters:
        - name: solicitudId
          in: path
          required: true
          schema:
            type: string
            pattern: '^SOL-[0-9]{4}-[0-9]{8}$'
          description: ID de la solicitud de crédito
          example: "SOL-2024-00012345"
        - $ref: '#/components/parameters/X-Correlation-ID'
      responses:
        '200':
          description: Solicitud encontrada
          headers:
            X-Correlation-ID:
              schema:
                type: string
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/DetalleSolicitudCredito'
        '404':
          $ref: '#/components/responses/ErrorNoEncontrado'
        '429':
          $ref: '#/components/responses/ErrorRateLimit'

  /creditos/solicitudes/{solicitudId}/evaluaciones:
    get:
      tags:
        - Consultas
      summary: Consultar evaluaciones de una solicitud
      description: |
        Retorna las evaluaciones realizadas por el motor antifraude y buró de riesgos.
        Útil para auditoría y diagnóstico de rechazos.
      operationId: consultarEvaluacionesSolicitud
      parameters:
        - name: solicitudId
          in: path
          required: true
          schema:
            type: string
          description: ID de la solicitud
        - $ref: '#/components/parameters/X-Correlation-ID'
      responses:
        '200':
          description: Evaluaciones recuperadas
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ListaEvaluaciones'
        '404':
          $ref: '#/components/responses/ErrorNoEncontrado'

  /creditos/{creditoId}/desembolso:
    post:
      tags:
        - Créditos
      summary: Ejecutar desembolso de crédito
      description: |
        Ejecuta el desembolso de un crédito aprobado. Requiere que el crédito
        esté en estado APROBADO y no haya sido desembolsado anteriormente.
      operationId: ejecutarDesembolso
      parameters:
        - $ref: '#/components/parameters/IdempotencyKey'
        - $ref: '#/components/parameters/X-Correlation-ID'
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/SolicitudDesembolso'
      responses:
        '200':
          description: Desembolso ejecutado
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/RespuestaDesembolso'
        '400':
          $ref: '#/components/responses/ErrorValidacion'
        '409':
          $ref: '#/components/responses/ErrorConflicto'

  /creditos/clientes/{numeroDocumento}/historial:
    get:
      tags:
        - Consultas
      summary: Consultar historial de créditos de un cliente
      description: |
        Retorna el historial de solicitudes y créditos de un cliente específico.
        Utilizado para análisis de comportamiento crediticio.
      operationId: consultarHistorialCliente
      parameters:
        - name: numeroDocumento
          in: path
          required: true
          schema:
            type: string
          description: Número de documento del cliente
        - name: tipoDocumento
          in: query
          schema:
            type: string
            enum:
              - CC
              - CE
              - NIT
              - PASAPORTE
        - name: estado
          in: query
          schema:
            type: string
            enum:
              - APROBADO
              - RECHAZADO
              - CANCELADO
              - DESEMBOLSADO
        - $ref: '#/components/parameters/X-Correlation-ID'
      responses:
        '200':
          description: Historial del cliente
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/HistorialCliente'
        '404':
          $ref: '#/components/responses/ErrorNoEncontrado'

  /health:
    get:
      tags:
        - Salud
      summary: Health check de la API
      description: |
        Endpoint de verificación de salud. Retorna el estado de la API
        y sus dependencias (antifraude, buró, core bancario).
      operationId: healthCheck
      responses:
        '200':
          description: Sistema saludable
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/HealthStatus'
        '503':
          description: Sistema no saludable
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/HealthStatus'

  /metrics:
    get:
      tags:
        - Salud
      summary: Métricas de la API
      description: |
        Retorna métricas operativas incluyendo throughput, latencia y tasa de errores.
      operationId: getMetrics
      responses:
        '200':
          description: Métricas recuperadas
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/MetricasAPI'

components:
  parameters:
    IdempotencyKey:
      name: Idempotency-Key
      in: header
      required: true
      description: |
        Clave de idempotencia única (UUID v4). Obligatorio para operaciones
        de crédito que modifican estado. Debe ser único por cada intento de operación.
        Si se reenvía una solicitud con la misma clave, se retorna la respuesta original
        sin reprocesar.
      schema:
        type: string
        format: uuid
      example: "550e8400-e29b-41d4-a716-446655440000"

    X-Correlation-ID:
      name: X-Correlation-ID
      in: header
      required: false
      description: |
        Correlation ID para trazabilidad de solicitudes a través de múltiples servicios.
        Si no se provee, el servidor generará uno.
      schema:
        type: string
        format: uuid
      example: "550e8400-e29b-41d4-a716-446655440001"

  schemas:
    SolicitudCredito:
      type: object
      required:
        - solicitud_id
        - cliente
        - credito
        - ingreso
        - empleo
      properties:
        solicitud_id:
          type: string
          pattern: '^SOL-[0-9]{4}-[0-9]{8}$'
          description: Identificador único de la solicitud
          example: "SOL-2024-00012345"
        cliente:
          $ref: '#/components/schemas/DatosCliente'
        credito:
          $ref: '#/components/schemas/DatosCredito'
        ingreso:
          $ref: '#/components/schemas/DatosIngreso'
        empleo:
          $ref: '#/components/schemas/DatosEmpleo'

    DatosCliente:
      type: object
      required:
        - tipo_documento
        - numero_documento
        - nombre
        - correo
      properties:
        tipo_documento:
          type: string
          enum:
            - CC
            - CE
            - NIT
            - PASAPORTE
          description: Tipo de documento de identificación
        numero_documento:
          type: string
          minLength: 5
          maxLength: 20
          description: Número de documento
        nombre:
          type: string
          maxLength: 200
          description: Nombre completo del cliente
        correo:
          type: string
          format: email
          description: Correo electrónico
        telefono:
          type: string
          pattern: '^\+[1-9]\\d{1,14}$'
          description: Teléfono con código de país
        fecha_nacimiento:
          type: string
          format: date
          description: Fecha de nacimiento

    DatosCredito:
      type: object
      required:
        - monto
        - moneda
        - plazo_meses
        - tasa_interes
        - destino
      properties:
        monto:
          type: integer
          minimum: 100000
          maximum: 500000000
          description: Monto solicitado en centavos
          example: 50000000
        moneda:
          type: string
          enum:
            - COP
            - USD
            - EUR
          default: COP
        plazo_meses:
          type: integer
          minimum: 1
          maximum: 360
          description: Plazo en meses
          example: 36
        tasa_interes:
          type: number
          format: double
          minimum: 0
          maximum: 5
          description: Tasa de interés mensual en porcentaje
          example: 1.5
        destino:
          type: string
          enum:
            - CONSUMO
            - VIVIENDA
            - VEHICULO
            - MICROCREDITO
            - LIBRE_INVERSION
          description: Destino del crédito

    DatosIngreso:
      type: object
      required:
        - salary
        - salary_neto
      properties:
        salary:
          type: integer
          minimum: 0
          description: Salario bruto mensual
          example: 8000000
        otros_ingresos:
          type: integer
          minimum: 0
          description: Otros ingresos mensuales
          example: 500000
        salary_neto:
          type: integer
          minimum: 0
          description: |
            Salario neto mensual después de deducciones.
            Regla de transformación: salary_neto = salary * 0.85 (deducciones estándar)
          example: 6800000
        deducciones:
          type: integer
          minimum: 0
          description: Total de deducciones

    DatosEmpleo:
      type: object
      required:
        - tipo_contrato
        - antiguedad_meses
      properties:
        tipo_contrato:
          type: string
          enum:
            - FIJO
            - INDEFINIDO
            - PRESTACION_SERVICIOS
            - INDEPENDIENTE
          description: Tipo de contrato laboral
        antiguedad_meses:
          type: integer
          minimum: 0
          maximum: 600
          description: Antigüedad en meses
          example: 24
        empresa:
          type: string
          maxLength: 200
          description: Nombre de la empresa
        cargo:
          type: string
          maxLength: 100
          description: Cargo del empleado

    RespuestaSolicitudCredito:
      type: object
      required:
        - solicitud_id
        - estado
        - mensaje
      properties:
        solicitud_id:
          type: string
        estado:
          type: string
          enum:
            - RECIBIDO
            - EN_PROCESO
            - APROBADO
            - RECHAZADO
            - ERROR
        mensaje:
          type: string
        fecha_aprobacion:
          type: string
          format: date-time
        numero_credito:
          type: string
        detalles:
          $ref: '#/components/schemas/DetallesAprobacion'

    DetallesAprobacion:
      type: object
      properties:
        monto_aprobado:
          type: integer
        tasa_interes:
          type: number
        plazo_meses:
          type: integer
        cuota_mensual:
          type: integer
        score_antifraude:
          type: integer
          description: Score del motor antifraude (0-1000)
        nivel_riesgo:
          type: string
          enum:
            - BAJO
            - MEDIO
            - ALTO
            - CRITICO

    DetalleSolicitudCredito:
      type: object
      properties:
        solicitud_id:
          type: string
        estado:
          type: string
        cliente:
          $ref: '#/components/schemas/DatosCliente'
        credito:
          $ref: '#/components/schemas/DatosCredito'
        historial_estados:
          type: array
          items:
            $ref: '#/components/schemas/HistorialEstado'
        evaluaciones:
          type: array
          items:
            $ref: '#/components/schemas/ResultadoEvaluacion'
        fechas:
          $ref: '#/components/schemas/FechasSolicitud'

    HistorialEstado:
      type: object
      properties:
        estado:
          type: string
        fecha:
          type: string
          format: date-time
        usuario:
          type: string
        motivo:
          type: string

    ResultadoEvaluacion:
      type: object
      properties:
        evaluador:
          type: string
          enum:
            - ANTIFRAUDE
            - BURO_RIESGOS
            - CORE_BANCARIO
        resultado:
          type: string
          enum:
            - APROBADO
            - RECHAZADO
            - REVISION
            - NO_APLICA
        score:
          type: integer
        detalle:
          type: string
        timestamp:
          type: string
          format: date-time

    FechasSolicitud:
      type: object
      properties:
        creacion:
          type: string
          format: date-time
        ultima_actualizacion:
          type: string
          format: date-time
        aprobacion:
          type: string
          format: date-time
        rechazo:
          type: string
          format: date-time

    ListaEvaluaciones:
      type: object
      properties:
        solicitud_id:
          type: string
        evaluaciones:
          type: array
          items:
            $ref: '#/components/schemas/ResultadoEvaluacion'

    SolicitudDesembolso:
      type: object
      required:
        - creditoId
        - cuenta_destino
      properties:
        creditoId:
          type: string
        cuenta_destino:
          $ref: '#/components/schemas/CuentaBancaria'
        fecha_ejecucion:
          type: string
          format: date

    CuentaBancaria:
      type: object
      required:
        - numero_cuenta
        - tipo_cuenta
        - banco
      properties:
        numero_cuenta:
          type: string
        tipo_cuenta:
          type: string
          enum:
            - AHORROS
            - CORRIENTE
        banco:
          type: string

    RespuestaDesembolso:
      type: object
      properties:
        credito_id:
          type: string
        estado_desembolso:
          type: string
          enum:
            - EJECUTADO
            - PENDIENTE
            - FALLIDO
        referencia:
          type: string
        fecha_ejecucion:
          type: string
          format: date-time

    HistorialCliente:
      type: object
      properties:
        numero_documento:
          type: string
        solicitudes:
          type: array
          items:
            $ref: '#/components/schemas/ResumenSolicitud'

    ResumenSolicitud:
      type: object
      properties:
        solicitud_id:
          type: string
        fecha:
          type: string
          format: date-time
        estado:
          type: string
        monto:
          type: integer
        plazo_meses:
          type: integer

    HealthStatus:
      type: object
      properties:
        status:
          type: string
          enum:
            - HEALTHY
            - DEGRADED
            - UNHEALTHY
        timestamp:
          type: string
          format: date-time
        componentes:
          type: object
          properties:
            api:
              $ref: '#/components/schemas/ComponenteHealth'
            antifraude:
              $ref: '#/components/schemas/ComponenteHealth'
            buror:
              $ref: '#/components/schemas/ComponenteHealth'
            corebancario:
              $ref: '#/components/schemas/ComponenteHealth'

    ComponenteHealth:
      type: object
      properties:
        status:
          type: string
          enum:
            - UP
            - DOWN
            - DEGRADED
        latency_ms:
          type: integer
        last_check:
          type: string
          format: date-time

    MetricasAPI:
      type: object
      properties:
        periodo:
          type: string
        totales:
          type: object
          properties:
            solicitudes:
              type: integer
            exitosas:
              type: integer
            fallidas:
              type: integer
        throughput:
          type: object
          properties:
            rps_actual:
              type: number
            rps_pico:
              type: number
        latencia:
          type: object
          properties:
            promedio_ms:
              type: number
            p50_ms:
              type: number
            p95_ms:
              type: number
            p99_ms:
              type: number
        errores:
          type: object
          properties:
            tasa:
              type: number
            por_codigo:
              type: object
              additionalProperties:
                type: integer

    ErrorEstandar:
      type: object
      required:
        - codigo
        - mensaje
      properties:
        codigo:
          type: string
          description: Código de error interno
          example: "VALIDACION_CAMPO_REQUERIDO"
        mensaje:
          type: string
          description: Mensaje legible para el cliente
          example: "El campo monto es requerido"
        detalle:
          type: string
          description: Detalle técnico del error
        campo:
          type: string
          description: Campo que causó el error
          example: "credito.monto"

  responses:
    ErrorValidacion:
      description: Error de validación de datos
      headers:
        X-Correlation-ID:
          schema:
            type: string
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorEstandar'
          example:
            codigo: "VALIDACION_CAMPO_REQUERIDO"
            mensaje: "El campo monto es requerido"
            campo: "credito.monto"
    ErrorAutenticacion:
      description: Error de autenticación
      headers:
        X-Correlation-ID:
          schema:
            type: string
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorEstandar'
          example:
            codigo: "AUTH_TOKEN_INVALIDO"
            mensaje: "Token de autenticación inválido o expirado"
    ErrorAutorizacion:
      description: Error de autorización
      headers:
        X-Correlation-ID:
          schema:
            type: string
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorEstandar'
          example:
            codigo: "AUTH_PERMISO_INSUFICIENTE"
            mensaje: "El cliente no tiene permisos para esta operación"
    ErrorConflicto:
      description: Conflicto de estado - solicitud duplicada
      headers:
        X-Correlation-ID:
          schema:
            type: string
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorEstandar'
          example:
            codigo: "SOLICITUD_DUPLICADA"
            mensaje: "Ya existe una solicitud con este Idempotency-Key"
            detalle: "La solicitud original fue procesada exitosamente"
            campo: "Idempotency-Key"
extensions:
  x-error-code: "CONFLICT"
    ErrorNegocio:
      description: Reglas de negocio no cumplidas
      headers:
        X-Correlation-ID:
          schema:
            type: string
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorEstandar'
          example:
            codigo: "MONTO_SUPERA_CAPACIDAD_PAGO"
            mensaje: "El monto solicitado excede la capacidad de pago del cliente"
            detalle: "Cuota propuesta (1687500) supera el 40% del ingreso neto (6800000)"
    ErrorNoEncontrado:
      description: Recurso no encontrado
      headers:
        X-Correlation-ID:
          schema:
            type: string
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorEstandar'
          example:
            codigo: "RECURSO_NO_ENCONTRADO"
            mensaje: "La solicitud de crédito no existe"
            detalle: "No se encontró ninguna solicitud con ID SOL-2024-99999999"
    ErrorRateLimit:
      description: Rate limit excedido
      headers:
        X-RateLimit-Remaining:
          schema:
            type: integer
          X-RateLimit-Reset:
            schema:
              type: integer
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorEstandar'
          example:
            codigo: "RATE_LIMIT_EXCEDIDO"
            mensaje: "Ha excedido el límite de solicitudes permitidas"
            detalle: "Límite: 100 solicitudes por minuto"
    ErrorInterno:
      description: Error interno del servidor
      headers:
        X-Correlation-ID:
          schema:
            type: string
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorEstandar'
          example:
            codigo: "ERROR_INTERNO"
            mensaje: "Error interno del servidor"
            detalle: "Contacte al administrador si el problema persiste"
    ErrorServicioNoDisponible:
      description: Servicio no disponible - falla en dependencia
      headers:
        X-Correlation-ID:
          schema:
            type: string
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorEstandar'
          example:
            codigo: "BUREAU_TIMEOUT"
            mensaje: "El servicio de buró de riesgos no está disponible temporalmente"
            detalle: "Se reintentará automáticamente. Tiempo máximo de espera: 5s"

extensions:
  x-error-code: "SERVICE_UNAVAILABLE"

  securitySchemes:
    OAuth2ClientCredentials:
      type: oauth2
      flows:
        clientCredentials:
          tokenUrl: https://auth.empresa.com/oauth/token
          scopes:
            credito:write: Permiso para crear solicitudes de crédito
            credito:read: Permiso para consultar solicitudes
            credito:desembolso: Permiso para ejecutar desembolsos
    ApiKeyHeader:
      type: apiKey
      in: header
      name: X-API-Key
      description: API Key para autenticación simple


// === ARCHIVO: documentation/proceso.bpmn.md ===
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

// === ARCHIVO: documentation/mapeo-de-datos.csv ===
campo_origen,tipo_origen,obligatorio_origen,campo_destino,tipo_destino,obligatorio_destino,regla_transformacion
solicitud_id,string,si,solicitudId,uuid,si,Generado por el originador como UUID v4; se preserva en todo el flujo para trazabilidad
idempotency_key,string,si,idempotencyKey,uuid,si,UUID v4 proporcionado por el cliente; debe ser único por cada intento de solicitud
fecha_solicitud,datetime,si,fechaSolicitud,datetime-iso8601,si,Se normaliza a formato ISO 8601 con timezone UTC
canal_origen,string,si,canalOrigen,string,si,Valor exacto del canal: "WEB", "MOBILE", "BRANCH", "API"
producto,string,si,producto,string,si,Valores permitidos: "CONSUMO", "MICROCREDITO", "NOMINA", "HIPOTECARIO"
monto_solicitado,decimal,si,montoSolicitado,decimal,si,Monto en moneda local con 2 decimales; rango: 1000-500000
plazo_meses,integer,si,plazoMeses,integer,si,Rango válido: 3-72 meses; múltiplo de 1
tasa_interes,decimal,no,tasaInteres,decimal,si,Si no se proporciona, se calcula automáticamente según scoring
	
### Datos del Solicitante
tipo_documento,string,si,tipoDocumento,string,si,Valores: "CC", "CE", "TI", "PASAPORTE", "NIT"
numero_documento,string,si,numeroDocumento,string,si,Sin máscara; se sanitiza para eliminar caracteres especiales
nombre_completo,string,si,nombreCompleto,string,si,Mayúsculas automático; se normaliza espacios
fecha_nacimiento,date,si,fechaNacimiento,date-iso8601,si,Mayor de edad (>=18 años) verificado
genero,string,no,genero,string,si,Valores: "M", "F", "O", "NS" (no specify)
estado_civil,string,no,estadoCivil,string,si,Valores: "SOLTERO", "CASADO", "UNION_LIBRE", "DIVORCIADO", "VIUDO"
nivel_educativo,string,no,nivelEducativo,string,si,Valores: "PRIMARIA", "SECUNDARIA", "TECNICO", "UNIVERSITARIO", "POSTGRADO"
	
### Información de Contacto
direccion_residencia,string,si,direccionResidencia,string,si,Dirección completa formateada
ciudad_residencia,string,si,ciudadResidencia,string,si,Código DANE de municipio (5 dígitos)
departamento,string,si,departamento,string,si,Código DANE de departamento (2 dígitos)
telefono_movil,string,si,telefonoMovil,string,si,Formato: 10 dígitos sin prefijo internacional
telefono_fijo,string,no,telefonoFijo,string,si,Formato: 10 dígitos
email,string,si,email,email,si,Validación RFC 5322; se convierte a minúsculas
	
### Información Laboral
tipo_empleo,string,si,tipoEmpleo,string,si,Valores: "DEPENDIENTE", "INDEPENDIENTE", "PENSIONADO", "EMPRESARIO"
nombre_empresa,string,si,nombreEmpresa,string,si,Para dependientes: razón social; para independientes: nombre del negocio
nit_empresa,string,no,nitEmpresa,string,si,Para dependientes: NIT de la empresa; para independientes: NIT propio
cargo,string,no,cargo,string,si,Cargo del solicitante en la empresa
antiguedad_meses,integer,si,antiguedadMeses,integer,si,Mínimo 1 mes; máximo 480 meses (40 años)
salario_bruto,decimal,si,salarioBruto,decimal,si,Ingreso mensual bruto; se valida contra rango del producto
otros_ingresos,decimal,no,otrosIngresos,decimal,si,Ingresos adicionales mensuales; si es null, asume 0
descuento_nomina,decimal,no,descuentoNomina,decimal,si,Descuentos por nómina (parafiscales, etc.)
	
### Datos Calculados (derivados)
salario_neto,—,no,salarioNeto,decimal,si,"Regla: salario_neto = salario_bruto - descuento_nomina + otros_ingresos"
capacidad_pago,—,no,capacidadPago,decimal,si,"Regla: capacidad_pago = salario_neto * 0.40 (índice de endeudamiento 40%)"
monto_cuota,—,no,montoCuota,decimal,si,"Regla: calculada usando fórmula de amortización francesa con tasa_interes"
relacion_deuda_ingreso,—,no,relacionDeudaIngreso,decimal,si,"Regla: relacion_deuda_ingreso = (cuota_actual + monto_cuota) / salario_neto"
	
### Datos del Buró de Riesgos
bureau_score,—,no,bureauScore,integer,si,Score retornado por el buró (rango 300-900)
bureau_alertas,—,no,bureauAlertas,array,si,Lista de alertas activas en el buró
bureau_deudas_vigentes,—,no,bureauDeudasVigentes,integer,si,Cantidad de obligaciones vigentes
bureau_cuentas_moras,—,no,bureauCuentasMorosas,integer,si,Cantidad de cuentas en mora
bureau_consultas_recientes,—,no,bureauConsultasRecientes,integer,si,Consultas en últimos 6 meses
bureau_estado,—,no,bureauEstado,string,si,"Valores: SUCCESS, TIMEOUT, UNAVAILABLE, INVALID_CLIENT"
	
### Datos del Motor Antifraude
antifraud_score,—,no,antifraudScore,integer,si,Score de riesgo antifraude (rango 0-1000)
antifraud_nivel_riesgo,—,no,antifraudNivelRiesgo,string,si,Valores: "BAJO", "MEDIO", "ALTO", "CRITICO"
antifraud_alertas,—,no,antifraudAlertas,array,si,Lista de alertas de fraude detectadas
antifraud_validacion_identidad,—,no,antifraudValidacionIdentidad,boolean,si,Resultado de validación de identidad
	
### Resultado de la Evaluación
decision,—,no,decision,string,si,"Valores: APROBADO, RECHAZADO, REVISION_MANUAL, APROBADO_CONDICIONES"
motivo_rechazo,—,no,motivoRechazo,string,si,"Valores: SCORE_BAJO, CAPACIDAD_INSUFICIENTE, HISTORIAL_NEGATIVO, DATOS_INVALIDOS, FRAUDE_DETECTADO, DUPLICADO"
numero_credito,—,no,numeroCredito,string,si,Generado por el Core Bancario; formato: CRED-YYYYMMDD-XXXXXX
fecha_aprobacion,—,no,fechaAprobacion,datetime-iso8601,si,Timestamp de aprobación en UTC
	
### Metadata
request_timestamp,—,si,requestTimestamp,datetime-iso8601,si,Timestamp de recepción de la solicitud
processing_time_ms,—,si,processingTimeMs,integer,si,Tiempo total de procesamiento en milisegundos
api_version,—,si,apiVersion,string,si,Versión del contrato de API utilizada
warnings,—,no,warnings,array,si,Lista de warnings generados durante el procesamiento
// === ARCHIVO: documentation/decisiones-de-diseno.md ===
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


// === ARCHIVO: validation/criterios-de-aceptacion.feature ===
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

// === ARCHIVO: analysis/analisis-de-riesgo.md ===
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

// === ARCHIVO: README.md ===
# Contrato de API - Canal Transaccional

## 1. Vision General del Proyecto

Este repositorio contiene el contrato de API para el canal transaccional del banco. El contrato define la interfaz de comunicación entre el originador de créditos (canal transaccional) y los sistemas internos, incluyendo el motor antifraude, el buró de riesgos y el core bancario.

**Objetivo del Negocio**: Garantizar una comunicación eficiente, segura y tolerante a fallos entre el canal transaccional y los sistemas internos, soporteando 1,500 solicitudes por segundo con latencia maxima de 200ms y disponibilidad del 99.9%.

## 2. Arquitectura de la Integracion

### 2.1 Patrón: Orquestado vs Coreografiado

**Decision de Arquitectura**: **Orquestado**

El sistema implementa un patron orquestado donde el API Gateway actua como orquestador central de todas las operaciones. Esta decision se tomo considerando los siguientes factores:

| Criterio            | Orquestado                    | Coreografiado                |
|---------------------|-------------------------------|------------------------------|
| Control de flujo    | Centralizado en el gateway    | Distribuido entre servicios  |
| Consistencia        | Transaccional                 | Eventual                     |
| Depuración          | Traza unica y completa        | Distribuida, mas compleja    |
| Acoplamiento        | Alto (gateway conoce todos)   | Bajo (servicios independientes) |
| Latencia            | Mayor (mas saltos)            | Menor (llamadas directas)    |
| Recuperacion        | Manejo centralizado de errores| Mas complejos, requiere saga|

**Justificacion del Patron Orquestado**:

1. **Transaccionalidad**: Las operaciones de credito requieren consistencia estricta. El patron orquestado permite gestionar transacciones distribuidas desde un punto central.

2. **Trazabilidad**: Con traceability ID propagado por el gateway, se puede reconstruir el flujo completo de una solicitud, indispensable para auditoria y debugging.

3. **Control de Errores**: El gateway puede implementar reintentos, circuit breaker y fallback de forma centralizada, sin duplicar logica en cada servicio.

4. **Reglas de Negocio**: La validacion de reglas de negocio (idempotencia, validacion de campos, control deConcurrency) es mas sencilla con un orquestador central.

5. **Cumplimiento Regulatorio**: En el sector financiero, la trazabilidad y el control centralizado son requisitos no negociables.

**Trade-offs Reconocidos**:

- **Latencia**: CadaRequest pasa por mas capas (gateway -> validacion -> servicios). Mitigado con caching y procesamiento asincrono donde es posible.
- **Punto Unico de Falla**: El gateway es un punto critico. Mitigado con alta disponibilidad y circuit breaker.
- **Acoplamiento**: Los servicios estan mas acoplados al contrato del gateway. Mitigado con versionamiento y backward compatibility.

### 2.2 Diagrama de Flujo

```
                    +-------------------+
                    | Canal Transaccional|
                    +--------+----------+
                             |
                             v
                    +-------------------+
                    |   API Gateway     |
                    | (Orquestador)     |
                    +--------+----------+
                             |
              +--------------+--------------+
              |              |              |
              v              v              v
       +-----------+  +-----------+  +-------------+
       | Validacion|  |   Cache   |  |  Trazabilidad|
       |  Idempot. |  |  (Redis)  |  |  (Logging)  |
       +-----------+  +-----------+  +-------------+
              |
              +---------------+
              |               |
              v               v
    +-------------+    +-------------+
    |  Antifraude |    |   Buró de   |
    |   (ML)      |    |   Riesgos   |
    +-------------+    +-------------+
              |               |
              +-------+-------+
                      |
                      v
              +-------------+
              | Core Bancario|
              +-------------+
```

## 3. Patrones de Integracion Implementados

### 3.1 Idempotencia

**Problema**: Los clientes pueden enviar solicitudes duplicadas debido a reintentos por timeout, errores de red o interfaz de usuario con botones duplicados.

**Solucion**: Header obligatorio `Idempotency-Key` con UUID v4.

```http
POST /v1/creditos/solicitud
Idempotency-Key: 550e8400-e29b-41d4-a716-446655440000
Content-Type: application/json

{
  "numero_identificacion": "12345678",
  "monto_solicitado": 5000000
}
```

**Reglas**:
- El header es obligatorio para todas las operaciones de credito
- La clave tiene un TTL de 24 horas
- Respuestas duplicadas retornan 200 OK con la respuesta original
- Se incluye header `X-Idempotent-Replay: true` para indicar respuesta cacheada

**Por que no solo POST con 201**: Porque el retry puede ocurrir despues de que la solicitud fue procesada pero antes de que el cliente recibiera la respuesta. El patrón de idempotencia garantiza que el cliente pueda reintentar sin担心 de duplicar el credito.

### 3.2 Tolerancia a Fallos con Reintentos

**Problema**: Los servicios externos (buró, antifraude) pueden fallar temporalmente.

**Solucion**: Reintentos automaticos con backoff exponencial.

```yaml
retry:
  maxAttempts: 3
  initialInterval: 100ms
  multiplier: 2.0
  maxInterval: 400ms
  jitter: true
```

**Comportamiento**:
- Primer fallo: reintento inmediato
- Segundo fallo: espera 100ms
- Tercer fallo: espera 200ms (backoff exponencial)
- Despues de 3 fallos: marcar solicitud como PENDIENTE y continuar

**Por que backoff exponencial**: Evita el efecto "thundering herd" donde todos los clientes reintentan al mismo tiempo, saturando el servicio que esta tratando de recuperarse.

### 3.3 Circuit Breaker

**Problema**: Cuando un servicio esta realmente caido, continuar enviando solicitudes agrava el problema y causa fallos en cascada.

**Solucion**: Circuit breaker que abre cuando se alcanza un umbral de fallos.

```yaml
circuitBreaker:
  failureThreshold: 5
  successThreshold: 2
  timeout: 30s
  halfOpenRequests: 3
```

**Estados**:
- **Cerrado**: Operacion normal, cuenta fallos
- **Abierto**: Falla rapida, retorna 503 inmediatamente
- **Media Apertura**: Permite algunas solicitudes de prueba

### 3.4 Fallback con Cache

**Problema**: Cuando el buró de riesgos esta caido, no hay forma de aprobar solicitudes.

**Solucion**: Cache local con datos del ultimo query exitoso.

- TTL: 24 horas
- Solo datos de riesgo (score, categoria), NO PII
- Respuesta incluye `X-Cache-Hit: true` como advertencia

## 4. Estructura del Repositorio

```
/
|-- api-spec/
|   |-- openapi.yaml          # Contrato principal de la API
|
|-- documentation/
|   |-- proceso.bpmn.md       # Flujo de negocio en notacion BPMN
|   |-- mapeo-de-datos.csv    # Mapeo origen -> destino
|   |-- decisiones-de-diseno.md # Justificacion de decisiones
|
|-- validation/
|   |-- criterios-de-aceptacion.feature # Escenarios Gherkin
|
|-- analysis/
|   |-- analisis-de-riesgo.md # Modos de falla e impacto
|
|-- README.md                 # Este archivo
```

## 5. Estandares y Convenciones

### 5.1 Estandares de Disenio

- **OpenAPI 3.1**: Version del contrato
- **BIAN**: Dominios de servicio utilizados como referencia
- **ISO 20022**: Formato de mensajes financieros
- **FAPI**: Perfil de API para servicios financieros

### 5.2 Convenciones de Nombre

-Endpoints en plural: `/creditos/solicitudes`
- CamelCase para parametros: `numeroIdentificacion`
- snake_case para respuesta: `numero_identificacion`
- Codigos de error en mayuscula: `BUREAU_TIMEOUT`
- Headers con kebab-case: `Idempotency-Key`

### 5.3 Extensiones Propietarias

| Extension              | Descripcion                              |
|-----------------------|------------------------------------------|
| x-error-code          | Codigo de error especifico del dominio   |
| x-throughput          | Throughput esperado del endpoint         |
| x-max-latency         | Latencia maxima esperada                 |
| x-idempotent          | Indica si el endpoint es idempotente     |
| x-circuit-breaker     | Configuracion de circuit breaker         |

## 6. Verificacion del Contrato

### 6.1 Comando de Verificacion

Para validar que el contrato OpenAPI cumple con las especificaciones:

```bash
npx --yes @redocly/cli lint api-spec/openapi.yaml
```

### 6.2 Reglas de Validacion

El lint verificara:
- Sintaxis valida de YAML
- Referencias validas ($ref)
- Esquemas validos
- Codigos de respuesta apropiados
- Documentacion de endpoints

### 6.3 Generacion de Documentacion

Para generar la documentacion HTML:

```bash
npx --yes @redocly/cli build-docs api-spec/openapi.yaml -o docs/index.html
```

## 7. Criterios de Aceptacion

Los escenarios de aceptacion estan definidos en `validation/criterios-de-aceptacion.feature` usando sintaxis Gherkin.

**Categorias de pruebas**:
- Idempotencia (4 escenarios)
- Tolerancia a fallos (7 escenarios)
- Rendimiento/Throughput (5 escenarios)
- Consistencia de datos (3 escenarios)
- Trazabilidad (2 escenarios)

**Para ejecutar las pruebas**:
```bash
# Requiere un runner de Gherkin compatible
cucumber validate validation/criterios-de-aceptacion.feature
```

## 8. Analisis de Riesgos

El analisis detallado de modos de falla, impacto y mitigaciones esta en `analysis/analisis-de-riesgo.md`.

**Resumen de SLA**:

| Metrica              | Objetivo   |
|---------------------|------------|
| Disponibilidad      | 99.9%      |
| Latencia p99        | < 200ms    |
| Throughput          | 1,500 rps  |
| Tasa de error       | < 0.1%     |

## 9. Contribucion

### 9.1 Para agregar un nuevo endpoint

1. Agregar el endpoint en `api-spec/openapi.yaml`
2. Agregar el mapeo de datos en `documentation/mapeo-de-datos.csv`
3. Agregar criterios de aceptacion en `validation/criterios-de-aceptacion.feature`
4. Ejecutar lint para validar: `npx --yes @redocly/cli lint api-spec/openapi.yaml`

### 9.2 Para modificar un esquema

1. Actualizar el schema en `components/schemas/`
2. Verificar que los `$ref` sean validos
3. Ejecutar lint
4. Actualizar mapeo de datos si hay cambios en campos

## 10. Contacto y Soporte

- **Equipo de Integracion**: integracion@banco.com
- **Arquitecto de Solucion**: arquitectura@banco.com
- **Slack**: #integracion-canal-transaccional

---
*Este documento es parte del contrato de API y debe ser actualizado junto con los cambios del contrato.*
*Version: 1.0 | Ultima actualizacion: 2024-01-15*


// === ARCHIVO: api-spec/openapi.yaml ===
openapi: 3.1.0
info:
  title: Canal Transaccional - API de Crédito
  description: |
    Contrato de API para el canal transaccional de gestión de créditos.
    Integración con originador de créditos, motor antifraude, buró de riesgos y core bancario.
    
    ## Características Principales
    - Idempotencia en operaciones de crédito mediante header Idempotency-Key
    - Throughput: 1,500 rps en hora pico
    - Latencia máxima: 200ms
    - SLA: 99.9%
    - Tolerancia a fallos temporales del buró de riesgos
    
    ## Estándares Aplicados
    - BIAN Service Domains para modelado de servicios financieros
    - ISO 20022 para mensajes financieros
    - FAPI para seguridad en APIs financieras
  version: 1.0.0
  contact:
    name: Equipo de Integración
    email: integracion@empresa.com
  license:
    name: Proprietario
    url: https://empresa.com/licencia
extensions:
  x-throughput: 1500
  x-max-latency: 200
  x-sla: 99.9
  x-bian-version: "17.06"
servers:
  - url: https://api.canal-transaccional.empresa.com/v1
    description: Servidor de producción
    variables:
      version:
        default: v1
  - url: https://sandbox.canal-transaccional.empresa.com/v1
    description: Servidor de sandbox para pruebas
security:
  - OAuth2ClientCredentials: []
  - ApiKeyHeader: []
tags:
  - name: Créditos
    description: Operaciones de gestión de solicitudes de crédito
  - name: Consultas
    description: Consultas de estado y historial
  - name: Salud
    description: Endpoints de health check y métricas
paths:
  /creditos/solicitudes:
    post:
      tags:
        - Créditos
      summary: Crear solicitud de crédito
      description: |
        Crea una nueva solicitud de crédito en el canal transaccional.
        El proceso orquesta las validaciones de antifraude, buró de riesgos y confirmación del core bancario.
        
        ## Idempotencia
        Este endpoint es idempotente. Envíe el header `Idempotency-Key` con un UUID único
        para evitar duplicados en caso de reintentos por timeout.
        
        ## Flujo de Procesamiento
        1. Validación de solicitud (schema)
        2. Evaluación antifraude
        3. Consulta buró de riesgos
        4. Registro en core bancario
        5. Respuesta al cliente
      operationId: crearSolicitudCredito
      parameters:
        - $ref: '#/components/parameters/IdempotencyKey'
        - $ref: '#/components/parameters/X-Correlation-ID'
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/SolicitudCredito'
            example:
              solicitud_id: "SOL-2024-00012345"
              cliente:
                tipo_documento: "CC"
                numero_documento: "1234567890"
                nombre: "Juan Pérez García"
                correo: "juan.perez@email.com"
                telefono: "+573001234567"
              credito:
                monto: 50000000
                moneda: "COP"
                plazo_meses: 36
                tasa_interes: 1.5
                destino: "CONSUMO"
              ingreso:
                salary: 8000000
                otros_ingresos: 500000
                salary_neto: 6800000
              empleo:
                tipo_contrato: "FIJO"
                antiguedad_meses: 24
                empresa: "Empresa ABC SAS"
      responses:
        '201':
          description: Solicitud de crédito creada exitosamente
          headers:
            X-Correlation-ID:
              schema:
                type: string
              description: Correlation ID para trazabilidad
            X-Request-Id:
              schema:
                type: string
              description: ID único de la solicitud
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/RespuestaSolicitudCredito'
              example:
                solicitud_id: "SOL-2024-00012345"
                estado: "APROBADO"
                mensaje: "Solicitud aprobada"
                fecha_aprobacion: "2024-01-15T10:30:00Z"
                numero_credito: "CRE-2024-00098765"
                detalles:
                  monto_aprobado: 50000000
                  tasa_interes: 1.5
                  plazo_meses: 36
                  cuota_mensual: 1687500
        '400':
          $ref: '#/components/responses/ErrorValidacion'
        '401':
          $ref: '#/components/responses/ErrorAutenticacion'
        '403':
          $ref: '#/components/responses/ErrorAutorizacion'
        '409':
          $ref: '#/components/responses/ErrorConflicto'
        '422':
          $ref: '#/components/responses/ErrorNegocio'
        '429':
          $ref: '#/components/responses/ErrorRateLimit'
        '500':
          $ref: '#/components/responses/ErrorInterno'
        '503':
          $ref: '#/components/responses/ErrorServicioNoDisponible'
  /creditos/solicitudes/{solicitudId}:
    get:
      tags:
        - Consultas
      summary: Consultar estado de solicitud de crédito
      description: |
        Consulta el estado actual de una solicitud de crédito previamente creada.
        Retorna información completa incluyendo historial de estados y evaluaciones.
      operationId: consultarSolicitudCredito
      parameters:
        - name: solicitudId
          in: path
          required: true
          schema:
            type: string
            pattern: '^SOL-[0-9]{4}-[0-9]{8}$'
          description: ID de la solicitud de crédito
          example: "SOL-2024-00012345"
        - $ref: '#/components/parameters/X-Correlation-ID'
      responses:
        '200':
          description: Solicitud encontrada
          headers:
            X-Correlation-ID:
              schema:
                type: string
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/DetalleSolicitudCredito'
        '404':
          $ref: '#/components/responses/ErrorNoEncontrado'
        '429':
          $ref: '#/components/responses/ErrorRateLimit'
  /creditos/solicitudes/{solicitudId}/evaluaciones:
    get:
      tags:
        - Consultas
      summary: Consultar evaluaciones de una solicitud
      description: |
        Retorna las evaluaciones realizadas por el motor antifraude y buró de riesgos.
        Útil para auditoría y diagnóstico de rechazos.
      operationId: consultarEvaluacionesSolicitud
      parameters:
        - name: solicitudId
          in: path
          required: true
          schema:
            type: string
          description: ID de la solicitud
        - $ref: '#/components/parameters/X-Correlation-ID'
      responses:
        '200':
          description: Evaluaciones recuperadas
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ListaEvaluaciones'
        '404':
          $ref: '#/components/responses/ErrorNoEncontrado'
  /creditos/{creditoId}/desembolso:
    post:
      tags:
        - Créditos
      summary: Ejecutar desembolso de crédito
      description: |
        Ejecuta el desembolso de un crédito aprobado. Requiere que el crédito
        esté en estado APROBADO y no haya sido desembolsado anteriormente.
      operationId: ejecutarDesembolso
      parameters:
        - $ref: '#/components/parameters/IdempotencyKey'
        - $ref: '#/components/parameters/X-Correlation-ID'
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/SolicitudDesembolso'
      responses:
        '200':
          description: Desembolso ejecutado
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/RespuestaDesembolso'
        '400':
          $ref: '#/components/responses/ErrorValidacion'
        '409':
          $ref: '#/components/responses/ErrorConflicto'
  /creditos/clientes/{numeroDocumento}/historial:
    get:
      tags:
        - Consultas
      summary: Consultar historial de créditos de un cliente
      description: |
        Retorna el historial de solicitudes y créditos de un cliente específico.
        Utilizado para análisis de comportamiento crediticio.
      operationId: consultarHistorialCliente
      parameters:
        - name: numeroDocumento
          in: path
          required: true
          schema:
            type: string
          description: Número de documento del cliente
        - name: tipoDocumento
          in: query
          schema:
            type: string
            enum:
              - CC
              - CE
              - NIT
              - PASAPORTE
        - name: estado
          in: query
          schema:
            type: string
            enum:
              - APROBADO
              - RECHAZADO
              - CANCELADO
              - DESEMBOLSADO
        - $ref: '#/components/parameters/X-Correlation-ID'
      responses:
        '200':
          description: Historial del cliente
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/HistorialCliente'
        '404':
          $ref: '#/components/responses/ErrorNoEncontrado'
  /health:
    get:
      tags:
        - Salud
      summary: Health check de la API
      description: |
        Endpoint de verificación de salud. Retorna el estado de la API
        y sus dependencias (antifraude, buró, core bancario).
      operationId: healthCheck
      responses:
        '200':
          description: Sistema saludable
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/HealthStatus'
        '503':
          description: Sistema no saludable
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/HealthStatus'
  /metrics:
    get:
      tags:
        - Salud
      summary: Métricas de la API
      description: |
        Retorna métricas operativas incluyendo throughput, latencia y tasa de errores.
      operationId: getMetrics
      responses:
        '200':
          description: Métricas recuperadas
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/MetricasAPI'
components:
  parameters:
    IdempotencyKey:
      name: Idempotency-Key
      in: header
      required: true
      description: |
        Clave de idempotencia única (UUID v4). Obligatorio para operaciones
        de crédito que modifican estado. Debe ser único por cada intento de operación.
        Si se reenvía una solicitud con la misma clave, se retorna la respuesta original
        sin reprocesar.
      schema:
        type: string
        format: uuid
      example: "550e8400-e29b-41d4-a716-446655440000"
    X-Correlation-ID:
      name: X-Correlation-ID
      in: header
      required: false
      description: |
        Correlation ID para trazabilidad de solicitudes a través de múltiples servicios.
        Si no se provee, el servidor generará uno.
      schema:
        type: string
        format: uuid
      example: "550e8400-e29b-41d4-a716-446655440001"
  schemas:
    SolicitudCredito:
      type: object
      required:
        - solicitud_id
        - cliente
        - credito
        - ingreso
        - empleo
      properties:
        solicitud_id:
          type: string
          pattern: '^SOL-[0-9]{4}-[0-9]{8}$'
          description: Identificador único de la solicitud
          example: "SOL-2024-00012345"
        cliente:
          $ref: '#/components/schemas/DatosCliente'
        credito:
          $ref: '#/components/schemas/DatosCredito'
        ingreso:
          $ref: '#/components/schemas/DatosIngreso'
        empleo:
          $ref: '#/components/schemas/DatosEmpleo'
    DatosCliente:
      type: object
      required:
        - tipo_documento
        - numero_documento
        - nombre
        - correo
      properties:
        tipo_documento:
          type: string
          enum:
            - CC
            - CE
            - NIT
            - PASAPORTE
          description: Tipo de documento de identificación
        numero_documento:
          type: string
          minLength: 5
          maxLength: 20
          description: Número de documento
        nombre:
          type: string
          maxLength: 200
          description: Nombre completo del cliente
        correo:
          type: string
          format: email
          description: Correo electrónico
        telefono:
          type: string
          pattern: '^\+[1-9]\\d{1,14}$'
          description: Teléfono con código de país
        fecha_nacimiento:
          type: string
          format: date
          description: Fecha de nacimiento
    DatosCredito:
      type: object
      required:
        - monto
        - moneda
        - plazo_meses
        - tasa_interes
        - destino
      properties:
        monto:
          type: integer
          minimum: 100000
          maximum: 500000000
          description: Monto solicitado en centavos
          example: 50000000
        moneda:
          type: string
          enum:
            - COP
            - USD
            - EUR
          default: COP
        plazo_meses:
          type: integer
          minimum: 1
          maximum: 360
          description: Plazo en meses
          example: 36
        tasa_interes:
          type: number
          format: double
          minimum: 0
          maximum: 5
          description: Tasa de interés mensual en porcentaje
          example: 1.5
        destino:
          type: string
          enum:
            - CONSUMO
            - VIVIENDA
            - VEHICULO
            - MICROCREDITO
            - LIBRE_INVERSION
          description: Destino del crédito
    DatosIngreso:
      type: object
      required:
        - salary
        - salary_neto
      properties:
        salary:
          type: integer
          minimum: 0
          description: Salario bruto mensual
          example: 8000000
        otros_ingresos:
          type: integer
          minimum: 0
          description: Otros ingresos mensuales
          example: 500000
        salary_neto:
          type: integer
          minimum: 0
          description: |
            Salario neto mensual después de deducciones.
            Regla de transformación: salary_neto = salary * 0.85 (deducciones estándar)
          example: 6800000
        deducciones:
          type: integer
          minimum: 0
          description: Total de deducciones
    DatosEmpleo:
      type: object
      required:
        - tipo_contrato
        - antiguedad_meses
      properties:
        tipo_contrato:
          type: string
          enum:
            - FIJO
            - INDEFINIDO
            - PRESTACION_SERVICIOS
            - INDEPENDIENTE
          description: Tipo de contrato laboral
        antiguedad_meses:
          type: integer
          minimum: 0
          maximum: 600
          description: Antigüedad en meses
          example: 24
        empresa:
          type: string
          maxLength: 200
          description: Nombre de la empresa
        cargo:
          type: string
          maxLength: 100
          description: Cargo del empleado
    RespuestaSolicitudCredito:
      type: object
      required:
        - solicitud_id
        - estado
        - mensaje
      properties:
        solicitud_id:
          type: string
        estado:
          type: string
          enum:
            - RECIBIDO
            - EN_PROCESO
            - APROBADO
            - RECHAZADO
            - ERROR
        mensaje:
          type: string
        fecha_aprobacion:
          type: string
          format: date-time
        numero_credito:
          type: string
        detalles:
          $ref: '#/components/schemas/DetallesAprobacion'
    DetallesAprobacion:
      type: object
      properties:
        monto_aprobado:
          type: integer
        tasa_interes:
          type: number
        plazo_meses:
          type: integer
        cuota_mensual:
          type: integer
        score_antifraude:
          type: integer
          description: Score del motor antifraude (0-1000)
        nivel_riesgo:
          type: string
          enum:
            - BAJO
            - MEDIO
            - ALTO
            - CRITICO
    DetalleSolicitudCredito:
      type: object
      properties:
        solicitud_id:
          type: string
        estado:
          type: string
        cliente:
          $ref: '#/components/schemas/DatosCliente'
        credito:
          $ref: '#/components/schemas/DatosCredito'
        historial_estados:
          type: array
          items:
            $ref: '#/components/schemas/HistorialEstado'
        evaluaciones:
          type: array
          items:
            $ref: '#/components/schemas/ResultadoEvaluacion'
        fechas:
          $ref: '#/components/schemas/FechasSolicitud'
    HistorialEstado:
      type: object
      properties:
        estado:
          type: string
        fecha:
          type: string
          format: date-time
        usuario:
          type: string
        motivo:
          type: string
    ResultadoEvaluacion:
      type: object
      properties:
        evaluador:
          type: string
          enum:
            - ANTIFRAUDE
            - BURO_RIESGOS
            - CORE_BANCARIO
        resultado:
          type: string
          enum:
            - APROBADO
            - RECHAZADO
            - REVISION
            - NO_APLICA
        score:
          type: integer
        detalle:
          type: string
        timestamp:
          type: string
          format: date-time
    FechasSolicitud:
      type: object
      properties:
        creacion:
          type: string
          format: date-time
        ultima_actualizacion:
          type: string
          format: date-time
        aprobacion:
          type: string
          format: date-time
        rechazo:
          type: string
          format: date-time
    ListaEvaluaciones:
      type: object
      properties:
        solicitud_id:
          type: string
        evaluaciones:
          type: array
          items:
            $ref: '#/components/schemas/ResultadoEvaluacion'
    SolicitudDesembolso:
      type: object
      required:
        - creditoId
        - cuenta_destino
      properties:
        creditoId:
          type: string
        cuenta_destino:
          $ref: '#/components/schemas/CuentaBancaria'
        fecha_ejecucion:
          type: string
          format: date
    CuentaBancaria:
      type: object
      required:
        - numero_cuenta
        - tipo_cuenta
        - banco
      properties:
        numero_cuenta:
          type: string
        tipo_cuenta:
          type: string
          enum:
            - AHORROS
            - CORRIENTE
        banco:
          type: string
    RespuestaDesembolso:
      type: object
      properties:
        credito_id:
          type: string
        estado_desembolso:
          type: string
          enum:
            - EJECUTADO
            - PENDIENTE
            - FALLIDO
        referencia:
          type: string
        fecha_ejecucion:
          type: string
          format: date-time
    HistorialCliente:
      type: object
      properties:
        numero_documento:
          type: string
        solicitudes:
          type: array
          items:
            $ref: '#/components/schemas/ResumenSolicitud'
    ResumenSolicitud:
      type: object
      properties:
        solicitud_id:
          type: string
        fecha:
          type: string
          format: date-time
        estado:
          type: string
        monto:
          type: integer
        plazo_meses:
          type: integer
    HealthStatus:
      type: object
      properties:
        status:
          type: string
          enum:
            - HEALTHY
            - DEGRADED
            - UNHEALTHY
        timestamp:
          type: string
          format: date-time
        componentes:
          type: object
          properties:
            api:
              $ref: '#/components/schemas/ComponenteHealth'
            antifraude:
              $ref: '#/components/schemas/ComponenteHealth'
            buror:
              $ref: '#/components/schemas/ComponenteHealth'
            corebancario:
              $ref: '#/components/schemas/ComponenteHealth'
    ComponenteHealth:
      type: object
      properties:
        status:
          type: string
          enum:
            - UP
            - DOWN
            - DEGRADED
        latency_ms:
          type: integer
        last_check:
          type: string
          format: date-time
    MetricasAPI:
      type: object
      properties:
        periodo:
          type: string
        totales:
          type: object
          properties:
            solicitudes:
              type: integer
            exitosas:
              type: integer
            fallidas:
              type: integer
        throughput:
          type: object
          properties:
            rps_actual:
              type: number
            rps_pico:
              type: number
        latencia:
          type: object
          properties:
            promedio_ms:
              type: number
            p50_ms:
              type: number
            p95_ms:
              type: number
            p99_ms:
              type: number
        errores:
          type: object
          properties:
            tasa:
              type: number
            por_codigo:
              type: object
              additionalProperties:
                type: integer
    ErrorEstandar:
      type: object
      required:
        - codigo
        - mensaje
      properties:
        codigo:
          type: string
          description: Código de error interno
          example: "VALIDACION_CAMPO_REQUERIDO"
        mensaje:
          type: string
          description: Mensaje legible para el cliente
          example: "El campo monto es requerido"
        detalle:
          type: string
          description: Detalle técnico del error
        campo:
          type: string
          description: Campo que causó el error
          example: "credito.monto"
  responses:
    ErrorValidacion:
      description: Error de validación de datos
      headers:
        X-Correlation-ID:
          schema:
            type: string
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorEstandar'
          example:
            codigo: "VALIDACION_CAMPO_REQUERIDO"
            mensaje: "El campo monto es requerido"
            campo: "credito.monto"
    ErrorAutenticacion:
      description: Error de autenticación
      headers:
        X-Correlation-ID:
          schema:
            type: string
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorEstandar'
          example:
            codigo: "AUTH_TOKEN_INVALIDO"
            mensaje: "Token de autenticación inválido o expirado"
    ErrorAutorizacion:
      description: Error de autorización
      headers:
        X-Correlation-ID:
          schema:
            type: string
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorEstandar'
          example:
            codigo: "AUTH_PERMISO_INSUFICIENTE"
            mensaje: "El cliente no tiene permisos para esta operación"
    ErrorConflicto:
      description: Conflicto de estado - solicitud duplicada
      headers:
        X-Correlation-ID:
          schema:
            type: string
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorEstandar'
          example:
            codigo: "SOLICITUD_DUPLICADA"
            mensaje: "Ya existe una solicitud con este Idempotency-Key"
            detalle: "La solicitud original fue procesada exitosamente"
            campo: "Idempotency-Key"
    ErrorNegocio:
      description: Reglas de negocio no cumplidas
      headers:
        X-Correlation-ID:
          schema:
            type: string
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorEstandar'
          example:
            codigo: "MONTO_SUPERA_CAPACIDAD_PAGO"
            mensaje: "El monto solicitado excede la capacidad de pago del cliente"
            detalle: "Cuota propuesta (1687500) supera el 40% del ingreso neto (6800000)"
    ErrorNoEncontrado:
      description: Recurso no encontrado
      headers:
        X-Correlation-ID:
          schema:
            type: string
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorEstandar'
          example:
            codigo: "RECURSO_NO_ENCONTRADO"
            mensaje: "La solicitud de crédito no existe"
            detalle: "No se encontró ninguna solicitud con ID SOL-2024-99999999"
    ErrorRateLimit:
      description: Rate limit excedido
      headers:
        X-RateLimit-Remaining:
          schema:
            type: integer
        X-RateLimit-Reset:
          schema:
            type: integer
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorEstandar'
          example:
            codigo: "RATE_LIMIT_EXCEDIDO"
            mensaje: "Ha excedido el límite de solicitudes permitidas"
            detalle: "Límite: 100 solicitudes por minuto"
    ErrorInterno:
      description: Error interno del servidor
      headers:
        X-Correlation-ID:
          schema:
            type: string
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorEstandar'
          example:
            codigo: "ERROR_INTERNO"
            mensaje: "Error interno del servidor"
            detalle: "Contacte al administrador si el problema persiste"
    ErrorServicioNoDisponible:
      description: Servicio no disponible - falla en dependencia
      headers:
        X-Correlation-ID:
          schema:
            type: string
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/ErrorEstandar'
          example:
            codigo: "BUREAU_TIMEOUT"
            mensaje: "El servicio de buró de riesgos no está disponible temporalmente"
            detalle: "Se reintentará automáticamente. Tiempo máximo de espera: 5s"
  securitySchemes:
    OAuth2ClientCredentials:
      type: oauth2
      flows:
        clientCredentials:
          tokenUrl: https://auth.empresa.com/oauth/token
          scopes:
            credito:write: Permiso para crear solicitudes de crédito
            credito:read: Permiso para consultar solicitudes
            credito:desembolso: Permiso para ejecutar desembolsos
    ApiKeyHeader:
      type: apiKey
      in: header
      name: X-API-Key
      description: API Key para autenticación simple

```
