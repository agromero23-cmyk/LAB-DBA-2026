# Actividad 10 — Diseñar y crear el registro de auditoría

## Objetivo

Diseñar una tabla de auditoría que permita registrar los cambios realizados en la información de los clientes, conservando datos sobre quién realizó la operación, cuándo ocurrió y qué información fue modificada.

## 1. Diseño de los campos

| Campo propuesto | Tipo | ¿Qué pregunta responde? | ¿Puede ser nulo? ¿Por qué? |
|---|---|---|---|
| `id_evento` | BIGSERIAL | ¿Cuál es el identificador único del evento? | No, porque es la llave primaria y se genera automáticamente. |
| `momento` | TIMESTAMPTZ | ¿En qué fecha y hora ocurrió el cambio? | No, porque todo evento debe tener una fecha y hora. |
| `usuario_sesion` | TEXT | ¿Con qué usuario se inició la sesión? | No, porque permite identificar la cuenta que inició la conexión. |
| `usuario_efectivo` | TEXT | ¿Qué usuario ejecutó realmente la operación? | No, porque permite identificar el usuario efectivo. |
| `aplicacion` | TEXT | ¿Desde qué aplicación se realizó la operación? | Sí, porque algunas conexiones pueden no proporcionar un nombre de aplicación. |
| `ip_cliente` | INET | ¿Desde qué dirección IP se conectó el cliente? | Sí, porque las conexiones locales pueden no tener una dirección IP. |
| `operacion` | TEXT | ¿Qué tipo de operación se realizó? | No, porque debe conocerse si fue INSERT, UPDATE o DELETE. |
| `id_cliente` | BIGINT | ¿Qué cliente fue afectado? | Sí, porque no todos los eventos necesariamente estarán relacionados con un cliente específico. |
| `valores_antes` | JSONB | ¿Cómo estaban los datos antes del cambio? | Sí, porque en una inserción no existe un estado anterior. |
| `valores_despues` | JSONB | ¿Cómo quedaron los datos después del cambio? | Sí, porque en una eliminación no existe un estado posterior. |

## 2. ¿Por qué momento usa TIMESTAMPTZ y no TIMESTAMP?

Se utiliza `TIMESTAMPTZ` porque permite almacenar la fecha y hora considerando la zona horaria. Esto ayuda a interpretar correctamente cuándo ocurrió un evento, incluso si los registros se consultan desde diferentes zonas horarias.

## 3. ¿Por qué se guarda el registro completo en JSONB y no solo la columna que cambió?

Porque permite conservar una copia completa de los datos del cliente antes y después de la modificación. Así es más fácil revisar qué información tenía originalmente y cómo quedó después del cambio.

Además, JSONB ofrece flexibilidad si en el futuro se agregan o modifican columnas en la tabla `clientes`.

## 4. ¿Qué implica que la tabla de auditoría también contenga RFC?

El RFC debe considerarse un dato personal que requiere protección. Por eso, la tabla de auditoría debe tener acceso restringido y solamente el personal autorizado debe poder consultar sus registros.

También se deben aplicar medidas de seguridad para evitar la exposición, modificación o eliminación no autorizada de esta información.

## 5. Conclusión

La tabla `auditoria.cambios_clientes` permitirá conservar información importante sobre las modificaciones realizadas en los datos de los clientes. Su diseño contempla la identificación del usuario, la fecha, la aplicación, la dirección IP y los valores anteriores y posteriores. Esto facilitará las revisiones y ayudará a mantener un mayor control sobre la información.