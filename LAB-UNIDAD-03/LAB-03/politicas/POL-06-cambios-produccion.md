
# POL-06 — Cambios en producción

**Objetivo:** Reducir el riesgo de interrupciones, pérdida de información, errores de configuración y modificaciones no autorizadas en los sistemas que utilizan datos reales.

**Alcance:** Aplica a los cambios realizados en el ambiente de producción de PostgreSQL y MongoDB, incluyendo estructuras, tablas, colecciones, permisos, configuraciones, aplicaciones y mecanismos de auditoría. Se consideran los ambientes de acuerdo con la definición establecida en la Unidad I.

**Regla:**
1. Antes de realizar un cambio en producción deberá existir una solicitud documentada, su justificación, una evaluación de riesgos y la aprobación del propietario del dato o responsable del sistema. También deberá verificarse la disponibilidad de un respaldo cuando el cambio pueda afectar información.
2. Durante el cambio, el DBA o administrador responsable deberá utilizar una cuenta autorizada, registrar las operaciones realizadas y evitar modificaciones ajenas a la solicitud aprobada.
3. Después del cambio, el responsable deberá verificar el funcionamiento del sistema, comprobar que los permisos y controles de auditoría continúen activos y documentar el resultado.

**Responsable:** El propietario del dato o responsable del sistema aprueba; el DBA de PostgreSQL o administrador de MongoDB ejecuta; el Responsable de Seguridad supervisa los cambios relacionados con accesos, datos personales y controles de seguridad.

**Excepciones:** Los cambios urgentes necesarios para corregir fallas críticas o incidentes podrán realizarse con autorización del Responsable de Seguridad y del responsable del sistema. La solicitud, justificación y evidencia deberán completarse después de atender la emergencia.

**Evidencia:**
- Bitácora de PostgreSQL del LAB-01, Actividad 6, con registros de modificaciones realizadas.
- Vista `dba.bitacora` y registros de auditoría `auditoria.cambios_clientes` (LAB-01).
- Script `sql/02-comentarios-diccionario.sql` y diccionario `evidencias/03-diccionario.md` (LAB-03), como evidencia de cambios documentados en los objetos.
- Solicitudes de cambio aprobadas y actas de verificación en producción: actualmente no existen; deberán generarse.

**Revisión:** Cada seis meses y después de un cambio crítico o incidente que afecte producción.
