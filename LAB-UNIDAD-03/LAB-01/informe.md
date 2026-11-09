# LAB-01 — Bitácoras y auditoría del dato en PostgreSQL

## 1. Despliegue y situación inicial

Para realizar la práctica se utilizó PostgreSQL 18 instalado en Windows, con pgAdmin 4 y SQL Shell (psql) como herramientas de administración y consulta. El servidor se trabajó en el puerto `5433` y se utilizó la base de datos `postgres`, donde se encontraban la tabla `clientes` y los usuarios de prueba `app_ventas` y `soporte_ana`.

Al inicio se revisaron los parámetros de registro mediante `pg_settings`. Se observó que la configuración inicial no permitía conservar suficiente información para reconstruir las modificaciones realizadas sobre los datos. Por ejemplo, `log_statement` estaba configurado en `none`, por lo que las sentencias SQL no se registraban de manera general.

Esto representaba un problema para responder a las preguntas de Dirección, ya que no siempre era posible identificar qué usuario había ejecutado una operación, cuándo ocurrió o qué valor tenía un campo antes de ser modificado. La bitácora tradicional permite conocer ciertas operaciones, pero no necesariamente conserva los valores anteriores y posteriores de cada registro.

## 2. Configuración aplicada

Durante la práctica se revisaron y modificaron diferentes parámetros de registro para mejorar la visibilidad de las operaciones realizadas en el servidor.

| Parámetro | Configuración revisada o aplicada | Función |
|---|---|---|
| `logging_collector` | Se habilitó (`on`) | Permite recopilar los mensajes del servidor en archivos de registro. |
| `log_destination` | Se revisó | Define el destino de los mensajes de registro. |
| `log_directory` | Se revisó | Indica el directorio donde se guardan los archivos de bitácora. |
| `log_filename` | Se revisó | Define el formato del nombre de los archivos de registro. |
| `log_connections` | Se revisó | Permite registrar los intentos de conexión. |
| `log_disconnections` | Se revisó | Permite registrar las desconexiones. |
| `log_line_prefix` | Se revisó | Agrega información como fecha, hora, proceso y usuario a cada línea. |
| `log_statement` | Se probaron `ddl`, `mod` y `all` | Controla qué tipos de sentencias SQL se registran. |
| `log_min_error_statement` | Se revisó | Determina qué sentencias asociadas a errores se registran. |
| `log_timezone` | Se revisó | Define la zona horaria utilizada en los registros. |

La opción `logging_collector` requirió reiniciar el servicio de PostgreSQL para que el cambio tuviera efecto. En cambio, varios parámetros pueden modificarse mediante recarga de configuración o aplicarse a una sesión, dependiendo de su alcance y de la opción utilizada.

También se exploraron los niveles de registro:

- `ddl`: registra instrucciones relacionadas con la definición de objetos, como `CREATE`, `ALTER` y `DROP`.
- `mod`: registra modificaciones de datos, como `INSERT`, `UPDATE` y `DELETE`.
- `all`: registra todas las sentencias, incluyendo consultas `SELECT`, por lo que puede generar un volumen considerable de información.

La configuración permitió obtener más información sobre conexiones, errores, cambios de estructura y modificaciones de datos. Sin embargo, se comprobó que una bitácora convencional no sustituye un mecanismo específico de auditoría de valores.

## 3. Eventos observados

Durante las actividades se analizaron distintos tipos de eventos registrados por PostgreSQL.

### 3.1 Conexiones exitosas

Se realizó una conexión con el usuario `app_ventas`, utilizando el nombre de aplicación `app-ventas-web`. Esto permitió observar información relacionada con el usuario, la base de datos y la aplicación que estableció la sesión.

Este evento ayuda a reconocer las conexiones realizadas al servidor, aunque por sí solo no identifica a la persona física que utilizó las credenciales.

### 3.2 Conexiones fallidas

Se simularon intentos de acceso con una contraseña incorrecta y con un nombre de usuario inexistente.

Los registros permitieron identificar errores de autenticación. Estos eventos son importantes porque varios intentos fallidos en un periodo corto pueden indicar un posible intento de acceso no autorizado.

### 3.3 Cambios de privilegios y estructura

Se realizaron operaciones como `GRANT`, `REVOKE`, `ALTER TABLE`, `CREATE ROLE` y `DROP ROLE`.

Estas instrucciones permitieron observar cambios en los permisos y en la estructura de la base de datos. Por ejemplo, se modificaron privilegios de los usuarios de prueba y se agregó una columna a la tabla `clientes`.

### 3.4 Errores y operaciones rechazadas

Se probó una operación `DELETE` con el usuario `soporte_ana`, que no contaba con los permisos necesarios. PostgreSQL rechazó la operación.

Esto permitió comprobar que la autenticación y la autorización son diferentes: la primera verifica la identidad de la cuenta y la segunda determina qué acciones puede realizar.

### 3.5 Sesiones activas

Mediante `pg_stat_activity` se revisaron las sesiones activas y se identificaron datos como el PID, usuario, aplicación, dirección del cliente y consulta en ejecución.

El PID resulta útil para relacionar una sesión con los registros del servidor. Sin embargo, esta vista muestra principalmente información de las sesiones actuales, no constituye por sí misma un historial permanente.

## 4. Auditoría del dato

Debido a que las bitácoras convencionales no conservan de manera estructurada los valores anteriores y posteriores de cada registro, se diseñó un mecanismo de auditoría específico para la tabla `clientes`.

Se creó el esquema `auditoria` y la tabla `auditoria.cambios_clientes`, con los siguientes campos:

| Campo | Descripción |
|---|---|
| `id_evento` | Identificador único del evento. |
| `momento` | Fecha y hora en que ocurrió la modificación. |
| `usuario_sesion` | Usuario que inició la sesión. |
| `usuario_efectivo` | Usuario cuyos permisos se utilizan durante la operación. |
| `aplicacion` | Nombre de la aplicación que realizó la conexión. |
| `ip_cliente` | Dirección IP desde la que se conectó el cliente. |
| `operacion` | Tipo de operación: INSERT, UPDATE o DELETE. |
| `id_cliente` | Identificador del cliente afectado. |
| `valores_antes` | Datos del registro antes de la operación. |
| `valores_despues` | Datos del registro después de la operación. |

Posteriormente, se creó la función `auditoria.registrar_cambio_cliente()` y un disparador asociado a la tabla `clientes`. El disparador se ejecuta después de las operaciones `INSERT`, `UPDATE` y `DELETE`, almacenando la información correspondiente en la tabla de auditoría.

### Papel de SECURITY DEFINER y session_user

La función utiliza `SECURITY DEFINER`, lo que significa que se ejecuta con los permisos del propietario de la función. Esto permite que un usuario como `app_ventas` pueda modificar un registro y que el disparador almacene el evento en el esquema de auditoría sin darle acceso directo a esa tabla.

También es importante distinguir:

- `session_user`: identifica la cuenta que inició la conexión.
- `current_user`: identifica el usuario efectivo cuyos permisos se utilizan en ese momento.

En el incidente auditado se observó que `session_user` correspondía a `app_ventas`, mientras que `current_user` correspondía a `postgres`, debido a que la función se ejecutaba con los privilegios de su propietario.

### Resultado del incidente auditado

La auditoría permitió registrar una modificación realizada sobre un cliente, incluyendo el usuario de sesión, la aplicación, la dirección IP, el tipo de operación y los valores anteriores y posteriores.

Al comparar los campos de `valores_antes` y `valores_despues`, fue posible identificar qué dato cambió y cuál era su valor previo.

**Importante:** los valores y la fecha del ejemplo del enunciado deben coincidir con el registro real de la tabla `auditoria.cambios_clientes` antes de presentarlos como evidencia definitiva.

## 5. Limitaciones

Aunque la auditoría permitió mejorar considerablemente la trazabilidad, durante las actividades se identificaron algunas limitaciones.

### 5.1 Consultas de lectura

El disparador creado registra operaciones `INSERT`, `UPDATE` y `DELETE`, pero no registra consultas `SELECT`. Por esta razón, no permite conocer por sí solo quién consultó un dato sensible.

Para auditar lecturas se requiere un mecanismo adicional, como pgAudit, con una configuración adecuada.

### 5.2 Volumen de información

Una modificación masiva puede generar muchos registros de auditoría. Por ejemplo, un `UPDATE` que afecte un millón de filas podría producir un millón de eventos.

Esto aumenta el espacio de almacenamiento y puede afectar el rendimiento del servidor.

### 5.3 Control administrativo

Un administrador con privilegios suficientes puede modificar objetos, deshabilitar disparadores o alterar configuraciones. Durante la práctica se comprobó que, al deshabilitar temporalmente el disparador y modificar un registro, el cambio no generó un nuevo evento en la tabla de auditoría.

Por lo tanto, la auditoría dentro de la misma base de datos no es completamente independiente del administrador del servidor.

## 6. Riesgos de la bitácora

Las bitácoras son importantes para la seguridad, pero también pueden representar riesgos si no se protegen correctamente.

**Exposición de secretos:** cuando se registra una gran cantidad de sentencias SQL, pueden quedar expuestos datos sensibles, valores personales o información utilizada en operaciones de autenticación. Por eso, se debe evitar registrar contraseñas y revisar qué información se almacena.

**Pérdida de información:** los archivos pueden perderse por fallas del servidor, falta de espacio, eliminación accidental o políticas de retención inadecuadas. Es necesario establecer respaldos y procedimientos de conservación.

**Acceso de terceros:** si personas sin autorización pueden consultar las bitácoras, podrían obtener información sobre usuarios, direcciones IP, consultas y datos de la organización. Se deben restringir los permisos y proteger los archivos.

Una medida recomendable es enviar las bitácoras a un sistema externo, administrado por un área independiente, para evitar que una sola persona tenga control tanto de la base de datos como de toda la evidencia.

## 7. Cronología y conclusión

A lo largo de la práctica se construyó una cronología utilizando la bitácora del servidor y la tabla de auditoría. Se analizaron conexiones exitosas y fallidas, modificaciones de privilegios, cambios de estructura, operaciones rechazadas y modificaciones sobre los registros de clientes.

La comparación entre ambas fuentes permitió identificar una diferencia importante: la bitácora convencional registra información sobre las operaciones del servidor, mientras que la auditoría del dato conserva de manera estructurada quién realizó la operación, cuándo ocurrió y cuáles fueron los valores anteriores y posteriores.

### Conclusión

Con la configuración aplicada, PostgreSQL ofrece mejores herramientas para investigar modificaciones y detectar actividades sospechosas. La combinación de bitácoras, disparadores y una tabla de auditoría permite reconstruir con mayor precisión los cambios realizados sobre información sensible.

Sin embargo, no se puede afirmar que la configuración garantice por sí sola una trazabilidad absoluta. Para demostrar quién cambió un dato y qué valor tenía antes, es necesario que el mecanismo de auditoría estuviera activo al momento de la modificación, que los registros se conservaran y que no fueran alterados.

Además, `session_user` permite identificar la cuenta que inició la sesión, pero no necesariamente a la persona física que la utilizó. Para fortalecer la evidencia se recomienda utilizar cuentas individuales, restringir los privilegios administrativos, proteger los registros y conservar copias externas.

En conclusión, **sí es posible demostrar qué cuenta realizó una modificación y cuál era el valor anterior de un dato sensible cuando existe un evento de auditoría válido y completo**. No obstante, para atribuir la acción a una persona específica y garantizar la integridad de la evidencia, se necesitan controles adicionales de identidad, separación de funciones y almacenamiento externo de las bitácoras.