# Actividad 3 — El incidente sin bitácora

## Objetivo

Simular una modificación del RFC realizada por la aplicación de ventas y comprobar si existe evidencia del cambio en la bitácora de PostgreSQL.

## Procedimiento realizado

Se ejecutó una actualización del RFC del cliente con ID 3, utilizando el usuario `app_ventas`, conectado a la base de datos `postgres`.

```sql
UPDATE clientes
SET rfc = 'GAMA780912XXX'
WHERE id = 3;
```

El resultado de la ejecución fue `UPDATE 1`.

## Búsqueda en la bitácora

Se realizó una búsqueda de registros relacionados con la actualización del RFC y la conexión de `app_ventas`.

Se utilizó una consulta para leer el archivo de bitácora considerando su codificación Windows-1252.

## Evidencias

- `03-01-update-app-ventas.png`: ejecución de la actualización.
- `03-02-busqueda-bitacora.png`: búsqueda de registros en la bitácora.
- `03-03-verificacion-rfc.png`: comprobación del RFC actualizado.

## Preguntas de análisis

**1. ¿Puedes demostrar quién modificó el RFC?**

La ejecución se realizó utilizando el usuario `app_ventas`. Sin embargo, para demostrarlo mediante auditoría se necesita un registro confiable de la operación en la bitácora. Si no existe ese registro, no se puede demostrar únicamente con la información disponible quién realizó el cambio.

**2. ¿Puedes demostrar que el cambio no lo hizo soporte_ana?**

No. La ausencia de registros no demuestra que soporte_ana no haya realizado el cambio. Para comprobarlo se necesitarían registros de auditoría completos.

**3. Los privilegios de la Unidad II, ¿impidieron el cambio? ¿Debían impedirlo?**

El cambio se pudo ejecutar utilizando `app_ventas`, por lo que sus permisos permitieron la operación. Los privilegios deben limitar las acciones de cada usuario de acuerdo con sus responsabilidades y aplicar el principio de mínimo privilegio.

**4. ¿Qué tendría que haber estado configurado antes del incidente?**

Se debieron configurar previamente los registros de conexiones, desconexiones y modificaciones de datos, además de una identificación adecuada del usuario, la base de datos, la dirección IP y la fecha y hora de cada operación. También se debía establecer una política de protección y conservación de las bitácoras.

## Conclusión

Esta actividad demuestra la importancia de configurar la auditoría antes de que ocurra un incidente. Si una modificación no quedó registrada en su momento, no es posible reconstruir con certeza quién la realizó utilizando una bitácora que no conservó esa información.