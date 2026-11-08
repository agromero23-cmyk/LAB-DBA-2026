# 15. Actividad 8 — Analizar un escenario de seguridad

## Pregunta 1. ¿Cuáles son los principales riesgos?

Los principales riesgos son el robo de contraseñas, la exposición de datos personales como el RFC, la interceptación de información durante la comunicación, la filtración de claves criptográficas y el acceso no autorizado a los respaldos.

Estos problemas pueden provocar la pérdida de confidencialidad de la información y permitir que personas no autorizadas utilicen los datos de la empresa.

## Pregunta 2. ¿Qué mecanismo utilizarías para cada elemento?

| Elemento | Mecanismo de protección | ¿Qué protege? |
|---|---|---|
| Nombre | Control de acceso y permisos | Limita quién puede consultar los datos personales. |
| Correo electrónico | Control de acceso y permisos | Evita que personas no autorizadas consulten la información. |
| Contraseña | Hash seguro, como Argon2id o bcrypt | Evita almacenar las contraseñas en texto claro. |
| RFC | Cifrado simétrico | Protege el RFC almacenado y permite recuperarlo con la clave correcta. |
| Información financiera | Cifrado y control de acceso | Protege la información financiera contra accesos no autorizados. |
| Claves criptográficas | Gestor de secretos o sistema de gestión de claves (KMS) | Evita que las claves queden expuestas en archivos SQL. |
| Conexiones a PostgreSQL | TLS con validación del certificado del servidor | Protege la comunicación y ayuda a verificar la identidad del servidor. |
| Respaldos de la base de datos | Cifrado y control de acceso | Evita que personas no autorizadas puedan leer los datos respaldados. |

## Pregunta 3. ¿Cuál de los problemas consideras más crítico y por qué?

Considero que el almacenamiento de contraseñas en texto claro es uno de los problemas más críticos, porque cualquier persona que obtenga acceso de lectura a la tabla podría conocer las contraseñas originales y utilizarlas para entrar a las cuentas de los usuarios.

Además, si esas contraseñas se reutilizan en otros sistemas, el problema podría afectar también a otras cuentas. Por eso, se deben almacenar mediante un algoritmo de hash seguro y nunca en texto claro.

## Pregunta 4. ¿Tener correctamente configurados los usuarios y permisos elimina estos riesgos? Justifica tu respuesta.

No, tener correctamente configurados los usuarios y permisos no elimina todos los riesgos. Aunque los permisos limitan el acceso a la información, todavía pueden existir problemas como contraseñas almacenadas en texto claro, claves expuestas, conexiones inseguras y respaldos sin cifrar.

Por esta razón, es necesario combinar los controles de acceso con el hash de contraseñas, el cifrado de información sensible, la protección de claves, el uso de TLS y el cifrado de respaldos.
