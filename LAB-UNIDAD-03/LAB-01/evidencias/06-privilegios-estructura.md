# Actividad 6 — Cambios de privilegios y de estructura

## Objetivo

Identificar cómo PostgreSQL registra los cambios de privilegios, las modificaciones de estructura y las operaciones relacionadas con la creación y eliminación de roles.

## Procedimiento realizado

Se realizaron las siguientes operaciones utilizando el usuario administrador:

1. Revocar el privilegio UPDATE al usuario `soporte_ana`.
2. Conceder el privilegio UPDATE al usuario `app_ventas`.
3. Agregar la columna `segmento` a la tabla `clientes`.
4. Crear un rol temporal utilizando una contraseña en la sentencia SQL.
5. Eliminar el rol temporal.

También se configuró `log_statement = 'ddl'` para registrar las operaciones correspondientes.

## Preguntas de análisis

**1. ¿Qué tipo de evento es cada una de las tres primeras sentencias (privilegio o estructura)?**

- `REVOKE UPDATE ON clientes FROM soporte_ana`: es un cambio de privilegios porque revoca un permiso de un usuario.
- `GRANT UPDATE ON clientes TO app_ventas`: es un cambio de privilegios porque concede permiso para actualizar registros.
- `ALTER TABLE clientes ADD COLUMN segmento VARCHAR(20)`: es un cambio de estructura porque modifica la definición de la tabla agregando una columna.

**2. ¿Por qué GRANT y REVOKE quedan registrados con log_statement = 'ddl'?**

Porque PostgreSQL clasifica las sentencias GRANT y REVOKE dentro de las operaciones de definición y administración de objetos y permisos. Por eso quedan registradas cuando se utiliza `log_statement = 'ddl'`.

**3. Si la bitácora contiene contraseñas, ¿quién debería poder leerla? Relaciónalo con la gestión de secretos de la Unidad II.**

La bitácora debe estar disponible únicamente para administradores de bases de datos y personal de auditoría autorizado. No debe permitirse el acceso a usuarios comunes ni a las aplicaciones.

En relación con la gestión de secretos de la Unidad II, las contraseñas deben protegerse y no almacenarse en texto claro. También se deben restringir los permisos de lectura de las bitácoras, evitar registrar secretos y aplicar políticas de rotación y protección de credenciales.

El comando `\password` permite establecer una contraseña sin escribirla directamente en una sentencia SQL en texto claro. PostgreSQL utiliza autenticación SCRAM para proteger la credencial. Sin embargo, el resumen SCRAM también debe tratarse como información sensible.

## Conclusión

Esta actividad demuestra que las bitácoras permiten conocer los cambios realizados en los privilegios y en la estructura de una base de datos. Sin embargo, también pueden exponer información sensible cuando se registran contraseñas en las sentencias SQL. Por eso es importante proteger los registros y aplicar buenas prácticas en la gestión de secretos.