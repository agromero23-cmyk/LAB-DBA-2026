
# POL-02 — Respaldo

**Objetivo:** Reducir el riesgo de pérdida de información por errores humanos, fallas técnicas, corrupción de datos o incidentes de seguridad.

**Alcance:** Aplica a las bases de datos PostgreSQL y MongoDB, incluyendo datos comerciales, registros de auditoría, configuraciones y documentación necesaria para recuperar los servicios.

**Regla:**
1. La información de producción deberá respaldarse diariamente. Las configuraciones y registros de auditoría deberán incluirse de acuerdo con su importancia y necesidades de conservación.
2. Los respaldos deberán almacenarse en una ubicación separada de los servidores originales y protegerse contra accesos no autorizados.
3. El DBA o administrador responsable deberá verificar periódicamente que los respaldos estén completos y disponibles para una posible recuperación.

**Responsable:** El Responsable de Seguridad define los criterios de protección; el DBA de PostgreSQL y el administrador de MongoDB ejecutan y verifican los respaldos.

**Excepciones:** Los ambientes de desarrollo y pruebas podrán tener una frecuencia menor cuando el propietario del sistema lo autorice y no se manejen datos cuya pérdida afecte la operación o una investigación.

**Evidencia:**
- Catálogo de datos `evidencias/04-catalogo.md` (LAB-03), que identifica las bases y registros que deben protegerse.
- Configuración y registros de respaldos: actualmente no existe evidencia de una política de respaldos periódicos verificados; deberá generarse.
- Registro de pruebas de integridad y disponibilidad de respaldos: actualmente no existe; deberá generarse.

**Revisión:** Cada seis meses y después de incidentes que afecten la disponibilidad o integridad de la información.

**Nota:** El procedimiento técnico se definirá en la Unidad V.
