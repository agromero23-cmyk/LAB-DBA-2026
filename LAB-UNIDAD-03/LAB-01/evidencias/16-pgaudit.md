# Actividad 19 — Auditoría de objeto sobre columnas sensibles

## Objetivo

Comprender cómo funciona la auditoría de objetos de pgAudit y cómo permite registrar operaciones relacionadas con columnas sensibles de la tabla `clientes`.

## 1. ¿Por qué no apareció SELECT nombre, ciudad...? ¿Por qué sí apareció SELECT * ...?

La consulta `SELECT nombre, ciudad FROM clientes WHERE id = 2` no apareció porque solamente consulta columnas que no están dentro de los privilegios asignados al rol `auditor_datos`.

En cambio, `SELECT * FROM clientes WHERE id = 4` sí apareció porque consulta todas las columnas de la tabla, incluyendo `rfc` y `telefono`, que son columnas vigiladas por el rol auditor.

Por eso, pgAudit permite identificar consultas que involucran información sensible.

## 2. ¿Por qué no apareció UPDATE ... ciudad ...?

Porque el rol `auditor_datos` solamente tiene privilegios de actualización sobre las columnas `rfc` y `telefono`.

La consulta que modifica `ciudad` no involucra ninguna de las columnas configuradas para la auditoría de objetos, por lo que no genera una entrada de auditoría de objeto.

## 3. ¿Qué diferencia de volumen esperarías frente a log_statement = 'all'?

Con pgAudit configurado para auditar objetos específicos, se espera un menor volumen de registros porque solamente se registran las operaciones que involucran los objetos y columnas seleccionados.

En cambio, `log_statement = 'all'` registra todas las sentencias SQL ejecutadas, incluyendo consultas que no contienen información sensible.

Por lo tanto, pgAudit permite una auditoría más específica y reduce el ruido en las bitácoras, aunque el volumen dependerá de la cantidad de operaciones sobre los objetos vigilados.

## 4. ¿Qué implica para la separación de funciones que pgAudit no pueda auditar de forma confiable a los superusuarios?

Implica que no se debe depender únicamente de pgAudit para vigilar las actividades de los superusuarios.

Es necesario separar las responsabilidades entre el administrador de la base de datos y el personal encargado de supervisar y proteger los registros de auditoría.

También se recomienda enviar las bitácoras a un sistema externo administrado por otra área, de manera que el administrador de PostgreSQL no pueda modificar o eliminar fácilmente las evidencias de sus propias acciones.

## 5. Análisis de los resultados

Los resultados muestran que:

- La consulta de `nombre` y `ciudad` no generó un registro de auditoría de objeto.
- La consulta que utilizó `SELECT *` sí fue registrada porque incluyó columnas sensibles.
- La actualización del RFC fue registrada como una operación `WRITE`.
- La actualización de `ciudad` no apareció porque esa columna no está dentro del alcance de los privilegios del rol auditor.
- El cambio de privilegios realizado por `postgres` apareció como un evento de auditoría de sesión de tipo `ROLE` y comando `GRANT`.

## Conclusión

pgAudit permite registrar operaciones específicas sobre información sensible sin tener que almacenar todas las consultas ejecutadas en la base de datos.

Sin embargo, su funcionamiento debe complementarse con una adecuada separación de funciones y con el almacenamiento externo de las bitácoras para proteger la evidencia frente a administradores con privilegios elevados.