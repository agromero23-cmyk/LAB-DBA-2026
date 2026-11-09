# Actividad 9 — Sesiones activas con pg_stat_activity

## Objetivo

Identificar las sesiones activas de PostgreSQL mediante la vista `pg_stat_activity` y relacionarlas con las líneas de la bitácora.

## 1. ¿Qué columna permite relacionar una sesión con sus líneas de bitácora?

La columna **`pid`** permite relacionar una sesión activa con sus líneas de bitácora, ya que identifica el proceso de PostgreSQL. Este número también aparece entre corchetes en las líneas del registro.

## 2. Después de que termina el reporte, ¿qué fuente conserva evidencia de que existió?

La **bitácora de PostgreSQL** conserva evidencia de que la sesión existió, siempre que la configuración de registros haya guardado los eventos correspondientes.

En cambio, `pg_stat_activity` muestra principalmente las sesiones que se encuentran activas en ese momento. Cuando el reporte termina, su sesión deja de aparecer en esa vista.

## 3. ¿Por qué client_addr aparece vacío en la sesión del administrador?

Porque la sesión del administrador utiliza una conexión local mediante un socket interno de PostgreSQL, en lugar de conectarse desde una dirección IP TCP/IP.

Por eso, `client_addr` aparece como `NULL` o vacío. En cambio, la sesión de `soporte_ana` muestra `127.0.0.1` porque se conectó mediante TCP/IP.

## Conclusión

La vista `pg_stat_activity` permite observar las sesiones activas, identificar a los usuarios conectados y conocer las consultas que están ejecutando. La columna `pid` facilita relacionar cada sesión con la bitácora. Sin embargo, cuando una sesión termina, deja de aparecer en la vista, por lo que los registros de PostgreSQL son importantes para conservar evidencia de las conexiones y actividades realizadas.