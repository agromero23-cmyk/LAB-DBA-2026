# Evidencia 01 — Configuración inicial de bitácoras en PostgreSQL

## Objetivo

Revisar la configuración inicial de registro de PostgreSQL para identificar cómo se almacenan los eventos, conexiones y sentencias SQL.

## Consulta ejecutada

```sql
SELECT name, setting, source
FROM pg_settings
WHERE name IN (
    'log_destination',
    'logging_collector',
    'log_directory',
    'log_filename',
    'log_connections',
    'log_disconnections',
    'log_line_prefix',
    'log_statement',
    'log_min_error_statement',
    'log_timezone'
)
ORDER BY name;
```

## Resultados observados

Se revisaron diez parámetros de configuración relacionados con las bitácoras de PostgreSQL.

- `log_connections`: off.
- `log_destination`: stderr.
- `log_directory`: log.
- `log_disconnections`: off.
- `log_filename`: postgresql-%Y-%m-%d_%H%M%S.log.
- `logging_collector`: off.
- `log_line_prefix`: %m [%p].
- `log_min_error_statement`: error.
- `log_statement`: none.
- `log_timezone`: Etc/UTC.

## Análisis y respuestas

**1. ¿Con esta configuración, se registra quién se conecta?**

No, porque el parámetro `log_connections` está desactivado. Por lo tanto, no se registran las conexiones exitosas de los usuarios.

**2. ¿Se registran las sentencias UPDATE?**

No se registran de manera general porque `log_statement` está configurado en `none`. Solamente podrían aparecer si están asociadas a errores que cumplan el nivel configurado.

**3. ¿La línea de bitácora incluye el usuario o la dirección IP del cliente?**

No, porque `log_line_prefix` está configurado como `%m [%p]`, que muestra la fecha, hora y el identificador del proceso, pero no el usuario ni la dirección IP.

**4. ¿En qué zona horaria se registran los eventos? ¿Por qué importa al reconstruir una cronología?**

Los eventos utilizan la zona horaria UTC (`Etc/UTC`). Esto permite comparar registros de diferentes servidores y ordenar correctamente los acontecimientos, considerando las diferencias horarias locales.

**5. Con logging_collector = off, ¿quién decide dónde termina la bitácora?**

El mecanismo con el que se ejecuta PostgreSQL, como el servicio o proceso que lo administra, se encarga de recibir y dirigir la salida estándar de errores. PostgreSQL genera los mensajes, pero su colector interno está desactivado.

## Conclusión

La configuración inicial de PostgreSQL tiene varias opciones de registro desactivadas. Esto limita la información disponible para realizar auditorías, identificar conexiones y conocer las sentencias ejecutadas. Por ello, es importante revisar y mejorar la configuración de las bitácoras para facilitar la supervisión y seguridad de la base de datos.