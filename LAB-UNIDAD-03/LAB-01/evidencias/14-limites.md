# Actividad 15 — Límites: lecturas y volumen

## Objetivo

Identificar las limitaciones del sistema de auditoría al registrar consultas de lectura y modificaciones masivas en la tabla `clientes`.

## 1. Si clientes tuviera un millón de registros, ¿qué ocurriría con la auditoría tras un UPDATE sin WHERE?

Si la tabla tuviera un millón de registros y se ejecutara un `UPDATE` sin la condición `WHERE`, se modificarían todos los registros.

El disparador se ejecutaría por cada fila modificada y generaría un millón de eventos en la tabla de auditoría. Esto aumentaría considerablemente el espacio de almacenamiento utilizado y podría afectar el rendimiento de la base de datos.

## 2. Propón quién podría autorizar la depuración de auditoria.cambios_clientes.

La depuración debería ser autorizada por un responsable de seguridad de la información o protección de datos, junto con el administrador de la base de datos.

Antes de eliminar registros, se debe comprobar que hayan cumplido su periodo de retención y que no sean necesarios para investigaciones, auditorías o cumplimiento de obligaciones legales.

También sería recomendable conservar un respaldo de los registros antes de realizar la depuración.

## 3. ¿Por qué log_statement = 'all' puede convertir la bitácora en un nuevo depósito de datos sensibles?

Porque registra todas las consultas ejecutadas en PostgreSQL, incluyendo aquellas que consultan información personal como RFC, teléfonos, correos y otros datos de los clientes.

Como consecuencia, la bitácora podría almacenar información sensible que normalmente no sería necesario conservar completa. Si alguien obtiene acceso a esos registros, podría consultar datos personales de los usuarios.

Por eso es importante controlar qué información se registra, quién puede acceder a ella y durante cuánto tiempo se conserva.

## 4. Análisis de los resultados

Los resultados muestran que:

- El `UPDATE` masivo generó una línea en la bitácora del servidor.
- La auditoría registró cinco nuevas filas de tipo `UPDATE`, una por cada registro modificado.
- La consulta `SELECT` realizada por `soporte_ana` no quedó registrada en la tabla de auditoría porque el disparador solamente captura operaciones `INSERT`, `UPDATE` y `DELETE`.
- La consulta de lectura tampoco apareció en la bitácora con la configuración utilizada.

## Conclusión

La auditoría mediante disparadores permite registrar los cambios realizados en los datos, pero no registra automáticamente las consultas de lectura. Además, las modificaciones masivas pueden generar una gran cantidad de registros.

Por eso es necesario complementar la auditoría con mecanismos para registrar lecturas cuando sean necesarias y establecer políticas de almacenamiento, acceso y depuración de los registros.
