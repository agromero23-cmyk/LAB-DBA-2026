# Actividad 13 — Altas y bajas

## Objetivo

Comprobar que la tabla de auditoría conserva evidencia de los registros insertados y eliminados, incluso después de que desaparecen de la tabla original `clientes`.

## 1. El cliente Pedro Ruiz ya no existe en clientes. ¿Dónde queda evidencia de que existió y de sus datos?

La evidencia queda almacenada en la tabla `auditoria.cambios_clientes`.

Aunque Pedro Ruiz fue eliminado de la tabla `clientes`, la auditoría conserva dos eventos:

- **INSERT:** registra su creación y guarda sus datos en `valores_despues`.
- **DELETE:** registra su eliminación y conserva sus datos en `valores_antes`.

De esta manera, es posible conocer información del cliente incluso después de eliminarlo de la tabla original.

## 2. ¿Por qué ip_cliente está vacía en los eventos 2 y 3?

Porque las operaciones INSERT y DELETE fueron realizadas desde una sesión local del administrador mediante una conexión que no proporcionó una dirección IP TCP/IP.

Por eso, `inet_client_addr()` devuelve `NULL` y la columna `ip_cliente` aparece vacía.

En cambio, el evento 1 muestra `127.0.0.1` porque `app_ventas` utilizó una conexión TCP/IP.

## 3. La política de retención de la Unidad II pedía eliminar datos cuando ya no fueran necesarios. ¿Qué conflicto aparece? ¿Quién debe resolverlo?

El conflicto es que la política de retención busca eliminar los datos personales cuando ya no sean necesarios, mientras que la auditoría conserva información de los clientes para mantener evidencia de las operaciones realizadas.

Esto significa que la auditoría también puede conservar datos personales después de que el registro original haya sido eliminado.

La organización, mediante los responsables de protección de datos, seguridad y administración de la base de datos, debe establecer cuánto tiempo conservar los registros, quién puede consultarlos y cuándo deben eliminarse o anonimizarse.

## Conclusión

La actividad demuestra que las operaciones de alta y baja quedan registradas en la tabla de auditoría. Aunque Pedro Ruiz ya no aparece en `clientes`, sus datos permanecen en los eventos de auditoría.

Esto permite investigar las operaciones realizadas, pero también demuestra la importancia de establecer una política de retención que proteja los datos personales y determine durante cuánto tiempo deben conservarse.