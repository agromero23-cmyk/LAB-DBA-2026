# Actividad 17 — Reconstruir la cronología y responder a Dirección

## Objetivo

Reconstruir los eventos más importantes del laboratorio utilizando la bitácora de PostgreSQL y la tabla `auditoria.cambios_clientes`, identificando los cambios realizados y las limitaciones de la evidencia disponible.

## 1. Cronología de eventos

**Nota:** La siguiente tabla organiza los eventos según la secuencia de las actividades realizadas. Las fechas y horas que no aparecen en los resultados disponibles se indican como "No hay evidencia"; no se estiman.

| # | Fecha y hora | Usuario | Cliente | Tipo de evento | Qué ocurrió | ¿Exitoso? | Fuente (línea o `id_evento`) |
|---|---|---|---|---|---|---|---|
| 1 | No hay evidencia | Administrador (`postgres`) | No aplica | Configuración | Se revisaron los parámetros iniciales de logging de PostgreSQL. | Sí, se obtuvieron los valores de configuración. | Actividad 1: consulta a `pg_settings`. |
| 2 | No hay evidencia | `app_ventas` | No aplica | Acceso | Se observaron tres intentos fallidos de autenticación con el nombre de usuario `app_ventas`. | No | Bitácora: mensajes de autenticación fallida. |
| 3 | No hay evidencia | `app_ventas` | No aplica | Acceso | Se realizó una conexión exitosa identificada con la aplicación `app-ventas-web`. | Sí | Actividad 5: conexión autorizada en la bitácora. |
| 4 | No hay evidencia | `app_ventas` | ID 3 | Datos | Se ejecutó una modificación del RFC del cliente 3 en la Actividad 3. | Sí, el comando devolvió actualización realizada. | Actividad 3: ejecución del UPDATE; sin registro de auditoría verificable. |
| 5 | No hay evidencia | No hay evidencia | No hay evidencia | Datos | Se revisó la diferencia entre los registros DDL y MOD para identificar qué modificaciones quedan registradas. | No hay evidencia de un cambio específico de RFC. | Actividad 7: análisis de logging. |
| 6 | 2026-10-25 22:50:52.903439+00 (ejemplo del enunciado) | `app_ventas` | ID 3 | Datos | Se modificó el RFC. El registro muestra un valor anterior y uno posterior. | Sí | Auditoría: `id_evento = 1`. |
| 7 | No hay evidencia | `postgres` | ID 6 | Alta | Se insertó el cliente Pedro Ruiz con RFC `RUPE950101AAA`. | Sí | Auditoría: `id_evento = 2`. |
| 8 | No hay evidencia | `postgres` | ID 6 | Baja | Se eliminó el registro de Pedro Ruiz, conservando sus datos anteriores en la auditoría. | Sí | Auditoría: `id_evento = 3`. |
| 9 | No hay evidencia | `app_ventas` | No aplica | Error | La aplicación intentó eliminar registros de auditoría y desactivar el trigger, pero no tenía los permisos necesarios. | No | Actividad 14: errores de permisos en la bitácora. |
| 10 | No hay evidencia | `postgres` | ID 3 | Datos | Se desactivó el trigger, se modificó el RFC a `GAMA780912GHI` y se volvió a activar el trigger. El cambio no quedó en la tabla de auditoría. | Sí, el UPDATE; sin auditoría en la tabla. | Actividad 14: líneas de bitácora del PID 260, según el ejemplo. |
| 11 | No hay evidencia | Administrador (`postgres`) | Varios | Datos | Se realizó un UPDATE masivo del campo `segmento`, generando cinco registros nuevos de auditoría. | Sí | Actividad 15: conteo de bitácora y auditoría. |

**Aclaración:** El evento 6 utiliza la fecha y los valores del resultado de ejemplo proporcionado en el enunciado. Debe sustituirse por los datos reales de tu bitácora si son diferentes. Los eventos 7 y 8 también utilizan los identificadores del ejemplo.

## 2. Respuestas a las preguntas de Dirección

### 1. ¿Quién cambió el RFC la primera vez (Actividad 3)? ¿Y en las Actividades 7, 12 y 14?

- **Actividad 3:** El comando se ejecutó mediante la cuenta `app_ventas`, pero no hay evidencia completa en la auditoría que permita confirmar la identidad de quien realizó la operación.
- **Actividad 7:** No hay evidencia suficiente para identificar quién cambió el RFC. La actividad revisó el comportamiento de los registros DDL y MOD, pero no se proporcionó un evento de auditoría que identifique ese cambio.
- **Actividad 12:** La auditoría identifica a `app_ventas` como usuario de sesión y a `postgres` como usuario efectivo. La aplicación registrada fue `app-ventas-web`.
- **Actividad 14:** El cambio a `GAMA780912GHI` fue ejecutado por `postgres`, según las líneas de bitácora mostradas. El trigger estaba desactivado, por lo que no se generó un evento en la tabla de auditoría.

### 2. ¿Quién cambió el teléfono?

**No hay evidencia.** Los resultados compartidos muestran modificaciones del RFC y del campo `segmento`, pero no incluyen un evento que demuestre un cambio de teléfono ni identifique al usuario responsable.

### 3. ¿Hubo intentos de acceso fallidos? ¿De qué usuarios y desde dónde?

Sí. En la bitácora se observaron tres intentos fallidos de autenticación con el nombre `app_ventas`.

También se realizaron intentos con un usuario inexistente, de acuerdo con las pruebas de la Actividad 5.

En los registros revisados aparecía la dirección local `127.0.0.1`. Para confirmar la dirección de cada intento y el nombre exacto del usuario inexistente se deben consultar las líneas originales de la bitácora.

### 4. ¿Qué valor tenía el RFC antes de cada cambio?

- **Actividad 3:** No hay evidencia suficiente del valor anterior en la bitácora disponible.
- **Actividad 7:** No hay evidencia de un cambio específico de RFC.
- **Actividad 12:** El evento de ejemplo `id_evento = 1` muestra `GAMA780912XYZ` como valor anterior y `GAMA780912ZZZ` como valor posterior. Debe verificarse con el registro real del entorno local.
- **Actividad 14:** No hay evidencia del valor anterior en la tabla de auditoría porque el trigger estaba desactivado durante el cambio a `GAMA780912GHI`.

## 3. Conclusión

La reconstrucción demuestra que la bitácora y la tabla de auditoría permiten investigar diferentes tipos de eventos, como accesos, modificaciones, altas y bajas.

Sin embargo, también existen limitaciones: algunos cambios no quedaron registrados, las consultas SELECT no fueron auditadas y un administrador pudo desactivar el trigger para realizar una modificación sin generar un evento en la tabla de auditoría.

Por eso, es importante conservar las bitácoras, proteger los mecanismos de auditoría y complementar los controles técnicos con una separación de funciones.

Cuando no existe un registro que permita comprobar un evento, debe indicarse explícitamente que no hay evidencia, sin inventar fechas, usuarios o valores anteriores.