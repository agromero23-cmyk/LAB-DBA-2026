
# 11. Actividad 5 — Criterio de conservación de bitácoras

## 1. Matriz de conservación de registros

| **Registro** | **Ubicación actual** | **Riesgo de pérdida observado** | **Sensibilidad** | **Periodo propuesto** | **Justificación** | **Dónde se conserva** | **Quién puede leerlo** | **Acción al vencer** |
|---|---|---|---|---|---|---|---|---|
| Accesos de PostgreSQL | Archivo del colector (`pg_current_logfile()`) | Rotación del archivo, reinstalación o recreación del servidor. | Alta | 12 meses | Permite investigar accesos sospechosos y detectar actividades no autorizadas. | Repositorio central de bitácoras con acceso restringido. | DBA y personal de seguridad autorizado. | Eliminar de forma segura después de verificar que no exista una investigación pendiente. |
| Cambios de privilegios y estructura | Archivo del colector | Pérdida del archivo, rotación o modificación no autorizada. | Alta | 24 meses | Estos cambios pueden afectar la seguridad y estructura del sistema, por lo que es importante conservar evidencia durante más tiempo. | Repositorio central de auditoría protegido. | DBA principal y auditoría. | Eliminar de forma segura cuando termine el plazo y no existan investigaciones pendientes. |
| Modificaciones de datos (`log_statement = 'mod'`) | Archivo del colector | Rotación, eliminación accidental o recreación del servidor. | Alta | 12 meses | Permite investigar modificaciones realizadas sobre la información y detectar cambios no autorizados. | Repositorio central de bitácoras. | DBA y auditor autorizado. | Eliminar de forma segura o anonimizar cuando corresponda según la política de retención. |
| `auditoria.cambios_clientes` | Tabla en `comercial` | Eliminación de registros, fallas del servidor o modificaciones no autorizadas. | Contiene datos personales | 24 meses | Permite conocer los valores anteriores y posteriores de los datos de clientes y comprobar las modificaciones realizadas. | Base de datos de auditoría con acceso restringido. | Responsable de auditoría y personal autorizado. | Eliminar o anonimizar los datos personales cuando termine el plazo, previa revisión de obligaciones pendientes. |
| Bitácora de `mongod` | `systemLog.path` o salida estándar; `getLog` solo en memoria | Rotación, reinicio del servicio o pérdida de archivos. | Alta | 12 meses | Permite investigar errores, accesos y eventos de seguridad de MongoDB. | Repositorio central de bitácoras. | Administrador de MongoDB y seguridad. | Eliminar de forma segura después de comprobar que no existan investigaciones pendientes. |
| `system.profile` | Colección limitada de 1 MB | Se sobrescribe automáticamente al alcanzar su límite. | Media-alta | 30 días | Sirve para analizar operaciones y problemas de rendimiento, pero no necesita conservarse tanto tiempo como una auditoría de seguridad. | Exportación de registros relevantes a un repositorio técnico. | DBA y administrador de MongoDB. | Eliminar los registros antiguos y mantener únicamente los necesarios para análisis vigentes. |
| Instantáneas de privilegios (MongoDB) | `auditoria.instantaneas_privilegios` | Eliminación accidental, modificación o pérdida de la colección. | Alta | 24 meses | Permite comparar los permisos de los usuarios y detectar cambios de privilegios no autorizados. | Colección de auditoría y repositorio central protegido. | Responsable de seguridad y auditoría. | Eliminar las instantáneas vencidas después de verificar que no exista una investigación pendiente. |

**Nota:** Los periodos son propuestas internas para el laboratorio, no plazos legales universales. Deben revisarse con el área jurídica y el responsable de seguridad antes de aplicarse en producción.

## 2. Preguntas

### 1. ¿Por qué la bitácora de cambios de privilegios merece más tiempo de conservación que la de consultas rutinarias?

Porque los cambios de privilegios pueden afectar directamente la seguridad de toda la base de datos. Por ejemplo, un usuario podría obtener permisos administrativos sin autorización o modificar los accesos de otras cuentas.

Conservar estos registros durante más tiempo permite investigar incidentes, identificar responsables y conocer cuándo se realizaron los cambios.

Las consultas rutinarias generalmente tienen menor impacto sobre la seguridad y pueden conservarse durante periodos más cortos, dependiendo de las necesidades de la organización.

### 2. ¿Qué control de integridad aplicarás a las bitácoras exportadas?

Aplicaría un hash criptográfico SHA-256 a cada archivo exportado para comprobar que no haya sido modificado.

También conservaría una copia en un repositorio protegido contra modificaciones, con acceso restringido y registro de quién consulta o administra los archivos.

De esta manera, si alguien modifica una bitácora, se podría detectar comparando su hash original con el nuevo.

### 3. ¿Qué diferencia hay entre conservar una bitácora y respaldar una base de datos?

Conservar una bitácora significa almacenar registros de eventos y operaciones para poder investigar actividades, detectar problemas y comprobar modificaciones realizadas.

Respaldar una base de datos significa crear una copia de la información para poder recuperarla en caso de fallas, pérdida de datos o daños en el sistema.

Por lo tanto, las bitácoras sirven principalmente para auditoría y seguimiento, mientras que los respaldos sirven para recuperar la información.

## 3. Consideración sobre la eliminación de datos personales

Uno de los problemas observados en el LAB-01 fue el conflicto entre conservar evidencias de auditoría y cumplir con las políticas de eliminación de datos personales.

Para atenderlo, se propone revisar periódicamente las bitácoras y evitar almacenar información personal innecesaria.

Cuando termine el periodo de conservación, se deberá evaluar si corresponde eliminar o anonimizar los datos personales, considerando las obligaciones legales, las investigaciones pendientes y las políticas de la organización.

Si existe una obligación normativa de conservar determinada información, el plazo deberá confirmarse con el área jurídica.

## 4. Conclusión

Esta actividad permitió establecer criterios para conservar diferentes tipos de bitácoras de PostgreSQL y MongoDB.

Se identificó que no todos los registros necesitan conservarse durante el mismo tiempo, ya que algunos contienen información más sensible o tienen mayor importancia para la seguridad.

También se propuso utilizar mecanismos de integridad como SHA-256 y restringir el acceso a los registros.

Finalmente, se comprendió que conservar las bitácoras no significa almacenarlas indefinidamente, sino establecer periodos justificados que permitan mantener la seguridad y respetar las políticas de protección de datos personales.
