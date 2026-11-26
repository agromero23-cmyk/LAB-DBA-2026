

# POL-03 — Retención

**Objetivo:** Evitar la conservación indefinida de información y reducir el riesgo de exposición de datos personales, sin eliminar evidencias necesarias para auditorías o investigaciones.

**Alcance:** Aplica a los datos de clientes, registros de auditoría de PostgreSQL, bitácoras del servidor, registros de MongoDB y documentación relacionada con cambios y accesos.

**Regla:**
1. Los registros de acceso y las instrucciones registradas mediante `log_statement = 'mod'` se conservarán durante 12 meses; los cambios de privilegios y estructura, así como las auditorías de cambios de clientes, se conservarán durante 24 meses.
2. Los registros de `mongod` se conservarán durante 12 meses, los datos de `system.profile` durante 30 días y las instantáneas de privilegios de MongoDB durante 24 meses.
3. Al vencer el plazo, la información se eliminará de forma segura o se anonimizará, siempre que no exista una investigación, auditoría u obligación de conservación pendiente. Las evidencias relacionadas con incidentes deberán conservarse hasta que el caso se cierre.

**Responsable:** El propietario del dato autoriza los criterios de conservación; el DBA y el administrador de MongoDB ejecutan las acciones. El Responsable de Seguridad supervisa el cumplimiento.

**Excepciones:** Se podrá ampliar el plazo cuando exista una investigación, auditoría o requerimiento legal. La ampliación deberá ser autorizada por el Responsable de Seguridad y documentada.

**Evidencia:**
- `evidencias/05-conservacion.md` (LAB-03, Actividad 5), con los plazos propuestos para cada tipo de registro.
- Vista `dba.bitacora` y registros de auditoría `auditoria.cambios_clientes` (LAB-01).
- Colección `system.profile` de MongoDB (LAB-03).
- Registro de eliminación o anonimización: actualmente no existe; deberá generarse cuando se realicen estas acciones.

**Revisión:** Cada seis meses o cuando cambien las obligaciones de conservación, los sistemas o las necesidades de auditoría.
