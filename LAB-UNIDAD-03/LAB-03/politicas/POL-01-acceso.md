
# POL-01 — Acceso

**Objetivo:** Reducir el riesgo de accesos no autorizados, privilegios excesivos y modificaciones realizadas por personas que no tienen responsabilidad sobre los datos.

**Alcance:** Aplica a PostgreSQL, MongoDB y sus ambientes de desarrollo, pruebas y producción. Incluye las bases de datos, tablas, vistas, colecciones, bitácoras y cuentas de usuario.

**Regla:**
1. Los usuarios y responsables de área pueden solicitar accesos indicando el sistema, los datos necesarios, el motivo y el nivel de privilegio requerido.
2. El propietario del dato debe aprobar la solicitud y el DBA o administrador correspondiente ejecutará el alta o modificación de permisos.
3. Los accesos se revisarán cada tres meses y también cuando una persona cambie de puesto o deje de colaborar en el proyecto.

**Responsable:** El propietario del dato autoriza; el DBA de PostgreSQL o administrador de MongoDB ejecuta los cambios. El Responsable de Seguridad revisa el cumplimiento.

**Excepciones:** En una emergencia se podrá otorgar acceso temporal con autorización del Responsable de Seguridad. La excepción deberá documentarse y revisarse posteriormente.

**Evidencia:**
- Bitácora de PostgreSQL del LAB-01, Actividad 6, con registros de instrucciones GRANT y REVOKE.
- Roles y permisos configurados en PostgreSQL, documentados en el LAB-01.
- Matriz de propietarios, custodios y usuarios de `evidencias/02-responsables.md` (LAB-03).
- Registro de revisiones trimestrales: actualmente no existe; deberá generarse.

**Revisión:** Cada tres meses o cuando cambien los responsables, usuarios o sistemas.
