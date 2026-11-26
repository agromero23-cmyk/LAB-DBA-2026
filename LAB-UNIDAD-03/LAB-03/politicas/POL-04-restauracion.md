
# POL-04 — Restauración

**Objetivo:** Reducir el riesgo de recuperar información incorrecta, sobrescribir datos válidos o interrumpir las operaciones durante una recuperación.

**Alcance:** Aplica a las bases de datos PostgreSQL y MongoDB, así como a los respaldos de información comercial, configuraciones y registros de auditoría en los ambientes de desarrollo, pruebas y producción.

**Regla:**
1. Toda restauración deberá contar con una solicitud que indique la causa, los datos afectados, el respaldo que se utilizará y el impacto esperado.
2. La restauración en producción deberá ser autorizada por el propietario del dato y por el Responsable de Seguridad cuando exista un incidente de seguridad. El DBA o administrador correspondiente será responsable de ejecutarla.
3. Antes de aprobar la restauración se deberá verificar que el respaldo corresponda al sistema y periodo solicitados, y que la recuperación no elimine evidencias necesarias para una auditoría o investigación.

**Responsable:** El propietario del dato autoriza la recuperación; el Responsable de Seguridad participa cuando exista un incidente; el DBA o administrador de MongoDB ejecuta la restauración.

**Excepciones:** En una emergencia que comprometa la continuidad del servicio se podrá autorizar una restauración urgente por el Responsable de Seguridad y el responsable del área afectada. La decisión deberá documentarse y revisarse posteriormente.

**Evidencia:**
- Catálogo de datos `evidencias/04-catalogo.md` (LAB-03), que identifica los datos y sistemas que pueden requerir recuperación.
- Registro de solicitudes y autorizaciones de restauración: actualmente no existe; deberá generarse.
- Evidencia de pruebas de restauración: actualmente no existe; deberá generarse.

**Revisión:** Cada seis meses y después de cada restauración o incidente relevante.

**Nota:** El procedimiento técnico se definirá en la Unidad V.
