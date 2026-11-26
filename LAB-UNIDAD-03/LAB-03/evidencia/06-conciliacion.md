
# Actividad 7 — Registro de cambios y conciliación

## 1. Objetivo

Crear un registro de solicitudes de cambio que permita comprobar que las modificaciones realizadas en la base de datos fueron solicitadas, aprobadas y ejecutadas dentro de una ventana autorizada.

Para esta actividad se creó el esquema `gobierno` y la tabla `gobierno.solicitudes_cambio`, que permite relacionar los cambios realizados en PostgreSQL con un folio de autorización.

## 2. Solicitud de cambio registrada

| Campo | Información |
|---|---|
| Folio | CAM-2026-014 |
| Descripción | Agregar columna canal_alta a clientes |
| Solicitado por | Gerencia Comercial |
| Aprobado por | Comité de cambios |
| Ambiente | Producción |
| Fecha de aprobación | Un día antes de la ejecución |
| Ventana de inicio | Cinco minutos antes de la ejecución |
| Ventana de fin | Una hora después de la ejecución |

**Resultado de la verificación:** La solicitud CAM-2026-014 se encontraba dentro de su ventana autorizada (`dentro_de_ventana = true`).

## 3. Tabla de conciliación

Se compararon las instrucciones de la bitácora `dba.bitacora` con las solicitudes registradas en `gobierno.solicitudes_cambio`.

| Momento (bitácora) | Usuario | Sentencia | Folio que lo autoriza | ¿Autorizado? | Hallazgo |
|---|---|---|---|---|---|
| 2026-10-25 22:54:26.533 | postgres | ALTER TABLE clientes ADD COLUMN canal_alta VARCHAR(20) | CAM-2026-014 | Sí | Cambio aprobado y ejecutado dentro de la ventana autorizada. |
| 2026-10-25 22:50:53.460 | app_ventas | ALTER TABLE clientes DISABLE TRIGGER trg_auditoria_clientes | Sin folio | No | Intento de desactivar el mecanismo de auditoría desde una cuenta de aplicación. |
| 2026-10-25 22:50:53.549 | postgres | ALTER TABLE clientes DISABLE TRIGGER trg_auditoria_clientes | Sin folio | No | Desactivación del disparador de auditoría mediante una cuenta administradora. |
| 2026-10-25 22:50:09.367 | postgres | GRANT UPDATE ON clientes TO app_ventas | Sin folio | No comprobado | Cambio de privilegios sin solicitud identificada en el registro. |

**Nota:** La tabla utiliza los momentos y usuarios del fragmento proporcionado en las instrucciones. La ausencia de un folio en la tabla no demuestra por sí sola que el cambio nunca fue autorizado; significa que no se encontró una solicitud que lo respalde en el registro consultado.

## 4. Análisis de los cambios sin folio

En el fragmento de bitácora aparecen diferentes operaciones que no están relacionadas con el folio CAM-2026-014.

Algunas operaciones pueden corresponder a la preparación del laboratorio, por ejemplo:

- La creación de roles de prueba.
- La asignación y revocación de privilegios.
- La incorporación de la columna `segmento`.
- La preparación de escenarios para comprobar los controles de seguridad.

Estas operaciones pueden tener una justificación académica, pero siguen siendo cambios que deben documentarse.

En cambio, la desactivación del disparador `trg_auditoria_clientes` representa un hallazgo de seguridad porque afecta directamente el mecanismo encargado de registrar modificaciones en los datos.

También debe revisarse el cambio de privilegios `GRANT UPDATE ON clientes TO app_ventas`, ya que no aparece asociado a una solicitud de cambio en el registro presentado.

## 5. Preguntas

### 1. ¿Qué cambios de la bitácora no tienen folio? Clasifícalos: ¿son de preparación del laboratorio o representan hallazgos?

Se identifican cambios como la creación de roles, asignación y revocación de permisos, incorporación de la columna `segmento` y desactivación del disparador de auditoría.

La creación de roles y los cambios de permisos pueden clasificarse como preparación del laboratorio si se realizaron para probar los controles de acceso. Sin embargo, deben quedar documentados.

La desactivación del disparador de auditoría es un hallazgo de seguridad porque puede impedir que se registren modificaciones realizadas sobre la tabla. El cambio de privilegios sin folio también requiere revisión para comprobar quién lo solicitó y quién lo autorizó.

### 2. La desactivación del disparador del LAB-01 (Actividad 14), ¿qué tan grave es como hallazgo? ¿Por qué? ¿Qué distingue la línea 163 de la 169?

Es un hallazgo grave porque desactivar el disparador de auditoría puede provocar que las modificaciones realizadas en la tabla `clientes` no queden registradas en `auditoria.cambios_clientes`.

Esto afecta la trazabilidad y dificulta investigar modificaciones no autorizadas.

La diferencia entre ambas líneas es el usuario que ejecutó la instrucción:

- **Línea 163:** muestra que `app_ventas` intentó ejecutar la desactivación del disparador.
- **Línea 169:** muestra que `postgres`, una cuenta administradora, ejecutó la misma operación.

La primera línea representa un intento desde una cuenta de aplicación, mientras que la segunda muestra la ejecución con una cuenta privilegiada. Para determinar si el primer intento fue rechazado, se deben revisar los mensajes de error relacionados en la bitácora.

### 3. ¿Qué limitación tiene esta conciliación si log_statement estuvo en none durante algún periodo?

La conciliación queda incompleta porque las instrucciones ejecutadas mientras `log_statement` tenía el valor `none` no se registraron mediante ese mecanismo.

Por lo tanto, no se puede asegurar que todos los cambios realizados durante ese periodo aparezcan en la bitácora. Esto representa un hueco de evidencia y dificulta demostrar que cada modificación fue autorizada.

Un ejemplo es la creación de la vista `dba.bitacora`, que no aparece porque se creó cuando el registro de instrucciones todavía estaba desactivado.

### 4. ¿Quién debería realizar la conciliación: el DBA que hizo los cambios u otra persona?

La conciliación debería realizarla una persona independiente del DBA que ejecutó los cambios, preferentemente el Responsable de Seguridad o el Responsable de Auditoría.

Esto permite una revisión objetiva y reduce el riesgo de que una misma persona realice los cambios y después valide su propia autorización.

El DBA debe proporcionar las bitácoras y los registros necesarios, pero la revisión y aprobación de la conciliación deben quedar a cargo de otra persona.

## 6. Hallazgos principales

1. Existen operaciones de preparación del laboratorio que no están relacionadas con un folio de autorización.
2. Se identificó una desactivación del disparador de auditoría, que afecta la trazabilidad de los cambios.
3. Se observó una modificación de privilegios sin una solicitud identificada.
4. La configuración `log_statement = none` durante un periodo provocó un hueco en la evidencia.
5. La bitácora puede contener contraseñas u otros secretos, por lo que debe revisarse y ocultarse esa información antes de compartirla.

## 7. Conclusión

La actividad permitió comprobar la importancia de relacionar cada cambio realizado en producción con una solicitud previamente aprobada. El registro CAM-2026-014 demuestra cómo una modificación puede tener un responsable, una autorización y una ventana de ejecución.

También se identificaron operaciones sin folio y una desactivación del disparador de auditoría, lo que demuestra que tener una bitácora no es suficiente si no se revisa y concilia periódicamente.

Finalmente, la conciliación debe ser realizada por una persona independiente del DBA que ejecutó los cambios, para mantener un control más confiable y evitar modificaciones sin autorización.
