# Actividad 5 — Accesos exitosos y fallidos

## Objetivo

Identificar cómo PostgreSQL registra los intentos de conexión exitosos y fallidos, así como la información que proporciona la bitácora para detectar posibles accesos no autorizados.

## Procedimiento realizado

Se plantearon tres intentos de conexión utilizando el usuario `app_ventas` y un usuario inexistente:

1. Conexión con contraseña incorrecta para `app_ventas`.
2. Conexión utilizando un usuario inexistente.
3. Conexión exitosa con `app_ventas`, utilizando el nombre de aplicación `app-ventas-web`.

Para realizar las pruebas en el entorno local se utilizó la base de datos `postgres` y el puerto `5433`.

## Análisis de los resultados

**1. La bitácora registra el usuario app_ventas en el intento fallido. ¿Eso prueba que la aplicación de ventas intentó entrar? ¿Qué prueba realmente?**

No necesariamente. La bitácora demuestra que se recibió un intento de autenticación utilizando el nombre de usuario `app_ventas` desde la dirección IP registrada. Sin embargo, no demuestra por sí sola que el intento provenga de la aplicación legítima de ventas, ya que alguien más pudo utilizar ese nombre de usuario.

**2. ¿Qué información adicional registra PostgreSQL cuando el rol no existe? ¿Por qué aparece en la bitácora y no en el mensaje que recibe el cliente?**

PostgreSQL registra información adicional indicando que el rol solicitado no existe. Esta información aparece en la bitácora para facilitar el análisis y la administración del servidor. Al cliente se le muestra un mensaje más general de autenticación fallida para no revelar detalles internos que podrían facilitar ataques.

**3. ¿Por qué app=[unknown] en el intento fallido, pero app=app-ventas-web en la desconexión?**

En el intento fallido no se proporcionó un nombre de aplicación, por lo que PostgreSQL lo identifica como desconocido. En la conexión exitosa sí se envió el parámetro `application_name=app-ventas-web`, por eso aparece identificado en la bitácora.

**4. ¿Qué patrón de varias líneas te haría sospechar de un ataque de fuerza bruta? Escribe la consulta que contaría los intentos fallidos por usuario.**

Un patrón sospechoso sería encontrar muchos intentos fallidos en poco tiempo, especialmente si se repiten desde una misma dirección IP y se utilizan diferentes contraseñas o nombres de usuario.

La consulta para contar los intentos fallidos por usuario se encuentra en el archivo `sql/05-accesos.sql`.

## Conclusión

La bitácora de PostgreSQL permite identificar conexiones exitosas y fallidas, conocer los usuarios utilizados y reconocer comportamientos sospechosos. Estos registros son importantes para detectar intentos de acceso no autorizado y fortalecer la seguridad de la base de datos.