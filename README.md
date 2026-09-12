# Diseño y Implementación de Contrato de API para Canal Transaccional

El equipo de Integración necesita fortalecer la práctica de APIs en el canal transaccional. El objetivo es diseñar y liderar la iniciativa de un contrato de API robusto que asegure la comunicación eficiente y segura entre el canal transaccional y los sistemas internos. Los actores involucrados son el originador de créditos, el motor antifraude, el buró de riesgos, y el core bancario. El sistema debe manejar un throughput de 1,500 solicitudes por segundo en hora pico, con una latencia máxima de 200ms y un SLA de 99.9%. La API debe ser idempotente en la gestión de solicitudes de crédito y tolerante a fallos temporales del buró de riesgos.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Contrato de API para el canal transaccional |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 4 semanas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Exploración y Definición de Requisitos

**Objetivo:** Identificar y documentar los requisitos funcionales y no funcionales del contrato de API.

**Tiempo estimado:** 1 semana

**Instrucciones:**

- Analiza el dominio del canal transaccional para identificar los actores y sus interacciones.
- Define los requisitos funcionales (operaciones soportadas, campos requeridos) y no funcionales (throughput, latencia, idempotencia) del contrato de API.
- Documenta las restricciones y ambigüedades encontradas en el sistema actual.

**Entregable:** Documento de requisitos funcionales y no funcionales del contrato de API.

<details>
<summary>Pistas de conocimiento</summary>

- Considera las interacciones entre el originador de créditos y el motor antifraude.
- Evalúa la latencia aceptable en la comunicación con el buró de riesgos.

</details>

### Fase 2: Diseño del Contrato de API

**Objetivo:** Diseñar el contrato de API basado en los requisitos definidos.

**Tiempo estimado:** 1 semana

**Instrucciones:**

- Crea un diseño conceptual del contrato de API que incluya los endpoints, métodos HTTP, y esquemas de solicitud y respuesta.
- Asegura que el diseño cumpla con los requisitos de idempotencia y tolerancia a fallos.
- Evalúa y documenta las decisiones de diseño tomadas, incluyendo trade-offs y consecuencias.

**Entregable:** Diseño conceptual del contrato de API con endpoints, métodos, esquemas, y decisiones de diseño documentadas.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el uso de claves de idempotencia en los endpoints.
- Evalúa estrategias para manejar fallos temporales del buró de riesgos.

</details>

### Fase 3: Implementación y Validación del Contrato de API

**Objetivo:** Implementar y validar el contrato de API diseñado.

**Tiempo estimado:** 2 semanas

**Instrucciones:**

- Implementa el contrato de API siguiendo el diseño conceptual.
- Realiza pruebas unitarias y de integración para validar el cumplimiento de los requisitos funcionales y no funcionales.
- Documenta cualquier issue encontrado y las soluciones implementadas.

**Entregable:** Contrato de API implementado y validado, con pruebas unitarias y de integración documentadas.

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza herramientas de testing para validar el contrato de API.
- Considera escenarios de edge cases para asegurar la robustez del contrato.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es un contrato de API y por qué es importante en el canal transaccional?
- **paraQueSirve**: ¿Para qué sirve el contrato de API en la comunicación entre el canal transaccional y los sistemas internos?
- **comoSeUsa**: ¿Cómo se usa el contrato de API para asegurar la idempotencia y tolerancia a fallos?
- **erroresComunes**: ¿Cuáles son los errores comunes al diseñar y implementar un contrato de API?
- **queDecisionesImplica**: ¿Qué decisiones de diseño implica el contrato de API y cómo afectan al sistema?

## Criterios de Evaluacion

- Identificar y documentar los requisitos funcionales y no funcionales del contrato de API.
- Diseñar un contrato de API que cumpla con los requisitos de idempotencia y tolerancia a fallos.
- Implementar y validar el contrato de API siguiendo el diseño conceptual.
- Documentar las decisiones de diseño tomadas, incluyendo trade-offs y consecuencias.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
npx --yes @redocly/cli lint openapi.yaml
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
