# Actividad 7 — Modificaciones de datos: DDL frente a MOD

## Objetivo

Comparar los niveles de registro `ddl` y `mod` de PostgreSQL para identificar qué operaciones quedan registradas en la bitácora.

## Procedimiento realizado

Primero se utilizó la configuración:

```sql
ALTER SYSTEM SET log_statement = 'ddl';
```

Después se realizó una actualización del RFC del cliente con ID 3 utilizando el usuario `app_ventas`.

Se comprobó que la bitácora registró información sobre la conexión y desconexión del usuario, pero no mostró la sentencia UPDATE.

Posteriormente, se cambió la configuración:

```sql
ALTER SYSTEM SET log_statement = 'mod';
SELECT pg_reload_conf();
```

Con esta configuración se realizó una modificación del teléfono del cliente y una consulta para leer su información.

## Análisis de resultados

Con `log_statement = 'ddl'`, PostgreSQL registra las operaciones relacionadas con la definición de objetos y estructura de la base de datos, pero no registra las modificaciones de datos realizadas mediante UPDATE.

Al cambiar a `log_statement = 'mod'`, PostgreSQL comenzó a registrar las sentencias que modifican datos, como UPDATE, INSERT y DELETE.

En la bitácora se pudo identificar:

- El usuario que realizó la modificación: `app_ventas`.
- La fecha y hora de la operación.
- La dirección del cliente: `127.0.0.1`.
- La aplicación utilizada: `app-ventas-web`.
- La sentencia ejecutada para modificar el teléfono.

También se comprobó que la consulta SELECT no quedó registrada, porque el nivel `mod` no incluye las operaciones de lectura.

## Preguntas de análisis

**1. ¿Qué nivel habría registrado la lectura del RFC? ¿Qué costo tendría en un servidor con miles de consultas por minuto?**

El nivel `all` habría registrado la lectura del RFC porque permite registrar todas las sentencias SQL, incluyendo SELECT.

Sin embargo, tendría un costo considerable en un servidor con miles de consultas por minuto, ya que produciría una gran cantidad de registros, aumentaría el uso de almacenamiento y podría afectar el rendimiento del servidor. También dificultaría la revisión de la bitácora debido al volumen de información.

**2. ¿Qué le falta a esta bitácora para revertir el cambio con certeza?**

A la bitácora le falta registrar el valor anterior y el valor nuevo del dato modificado. Aunque muestra quién realizó el cambio y qué sentencia ejecutó, no conserva por sí sola una copia del estado anterior del registro.

Para poder revertir el cambio con certeza se necesitaría contar con mecanismos adicionales, como auditoría mediante triggers, tablas de historial o respaldos que permitan recuperar los valores anteriores.

## Conclusión

Esta actividad demuestra que el nivel de registro configurado en PostgreSQL determina qué operaciones quedan almacenadas en la bitácora. El nivel `ddl` registra cambios de estructura y permisos, mientras que `mod` permite identificar modificaciones de datos. Sin embargo, registrar una sentencia no garantiza que sea posible recuperar los valores anteriores, por lo que se necesitan mecanismos adicionales de auditoría e historial.