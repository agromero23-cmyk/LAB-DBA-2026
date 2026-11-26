
# POL-05 — Uso de datos sensibles

**Objetivo:** Reducir el riesgo de exposición, uso indebido o divulgación de datos personales y de información que pueda afectar a los clientes o a la organización.

**Alcance:** Aplica a los datos personales almacenados en PostgreSQL y MongoDB, incluyendo nombres, correos, teléfonos, RFC, edades, ciudades y códigos postales. También incluye registros de auditoría y bitácoras que puedan contener estos datos.

**Regla:**
1. Solo podrán consultar datos personales los usuarios autorizados por el propietario del dato y cuando exista una finalidad laboral o institucional justificada.
2. Las consultas o modificaciones relacionadas con datos personales deberán realizarse utilizando cuentas individuales y los permisos mínimos necesarios.
3. Los accesos y modificaciones deberán conservar evidencia en las bitácoras y registros de auditoría disponibles. Las evidencias se conservarán durante los plazos de POL-03 y, si existe una investigación abierta, hasta su cierre.

**Responsable:** El propietario del dato autoriza el uso; el DBA o administrador de MongoDB asigna los permisos; el Responsable de Seguridad supervisa los accesos y las auditorías.

**Excepciones:** El acceso extraordinario podrá autorizarse para atender incidentes, auditorías o requerimientos legales. Deberá justificarse, limitarse al tiempo necesario y quedar registrado.

**Evidencia:**
- Clasificación de campos de clientes elaborada en el LAB-03, Actividad 7 (calidad y clasificación de datos).
- Matriz de responsables `evidencias/02-responsables.md` (LAB-03).
- Diccionario de datos `evidencias/03-diccionario.md` (LAB-03).
- Registros de modificaciones en `auditoria.cambios_clientes` y vista `dba.bitacora` (LAB-01).
- Registro de solicitudes y justificaciones de acceso a datos personales: actualmente no existe; deberá generarse.

**Revisión:** Cada seis meses y cuando se incorporen nuevos datos personales, usuarios o finalidades de uso.
