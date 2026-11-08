# Actividad 2 — Que el servidor administre su propia bitácora

## Preguntas y respuestas

### 1. ¿Por qué `logging_collector` requiere reinicio y `log_statement` solo recarga?

Porque `logging_collector` necesita iniciar un proceso interno que se encarga de recibir y guardar los registros en archivos, por lo que requiere reiniciar PostgreSQL. En cambio, `log_statement` es una configuración que puede actualizarse al recargar los parámetros del servidor, sin necesidad de detenerlo.

### 2. ¿Qué ventaja tiene que la bitácora se lea con SQL y no con una herramienta del sistema operativo o del contenedor? ¿Qué riesgo introduce?

La ventaja es que permite consultar, filtrar y ordenar los registros directamente desde PostgreSQL, sin necesidad de acceder manualmente a los archivos del sistema operativo. El riesgo es que, si se conceden permisos incorrectos, otros usuarios podrían consultar información sensible, como nombres de usuarios, consultas ejecutadas o errores del sistema.

### 3. ¿Quién debería poder consultar `dba.bitacora`?

Solamente el administrador de la base de datos y el personal autorizado para realizar auditorías. Los usuarios de aplicaciones y usuarios comunes no deberían tener acceso, porque las bitácoras pueden contener información sensible.