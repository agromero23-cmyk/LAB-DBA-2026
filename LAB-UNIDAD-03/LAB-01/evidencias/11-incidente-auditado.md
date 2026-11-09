# Actividad 12 — El incidente auditado

## Objetivo

Comprobar que el sistema de auditoría registra los cambios realizados en la tabla `clientes`, identificando al usuario, la aplicación, la dirección IP y los valores anteriores y posteriores.

## 1. Comparación de la hipótesis de la Actividad 11

La hipótesis fue que, si la función no utilizara `SECURITY DEFINER`, podría fallar cuando el usuario que realiza la modificación no tenga permisos para insertar registros en la tabla de auditoría.

El resultado demuestra la utilidad de `SECURITY DEFINER`: `app_ventas` pudo actualizar el RFC y la función registró el evento utilizando los permisos de su propietario.

También se observa que `usuario_sesion` conserva el nombre `app_ventas`, mientras que `usuario_efectivo` muestra `postgres`, porque la función se ejecuta con los permisos de su propietario.

## 2. ¿Qué sentencia UPDATE restauraría el valor anterior?

Para restaurar el RFC se debe consultar primero la columna `valores_antes` del evento y utilizar el valor que realmente estaba guardado.

Ejemplo del enunciado:

```sql
UPDATE clientes
SET rfc = 'GAMA780912XYZ'
WHERE id = 3;
```

En mi entorno debo utilizar el RFC anterior que aparezca en mi propio registro de auditoría.

## 3. ¿Qué columna conserva más valor para una investigación: aplicacion o ip_cliente? ¿Cuál puede falsificar el cliente con más facilidad?

La columna `ip_cliente` puede aportar más información para una investigación porque permite identificar la dirección de red desde la que se realizó la conexión.

La columna `aplicacion` también es útil para distinguir conexiones, pero puede falsificarse más fácilmente porque el propio cliente puede declarar su `application_name`.

Por lo tanto, ninguna de las dos columnas debe utilizarse por sí sola para demostrar la identidad de una aplicación o persona.

## 4. ¿Por qué app_ventas no puede consultar directamente la tabla de auditoría?

Porque el esquema `auditoria` tiene restringido el acceso público. Aunque `app_ventas` puede modificar los registros de clientes y activar el disparador, no tiene permiso para consultar directamente la tabla de auditoría.

Esto ayuda a proteger los registros contra consultas de usuarios que no están autorizados.

## Conclusión

La auditoría permitió identificar que el usuario de sesión fue `app_ventas`, que la operación se realizó desde la aplicación declarada y que se modificó el RFC del cliente con ID 3.

También se comprobó que los valores anteriores y posteriores permiten conocer exactamente qué campo cambió. Esto demuestra la importancia de conservar registros de auditoría para investigar modificaciones en la información de los clientes.