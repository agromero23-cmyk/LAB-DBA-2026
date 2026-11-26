
# 10. Actividad 4 — Catálogo mínimo de datos

## 1. Inventario técnico de PostgreSQL

Se ejecutó el comando `ANALYZE` para actualizar las estadísticas de las tablas y posteriormente se consultó el catálogo del sistema mediante `pg_class`, `pg_namespace` y `pg_views`.

La consulta permitió identificar los esquemas, nombres de tablas, propietarios técnicos, filas estimadas, tamaños y descripciones.

También se consideró la vista `dba.bitacora`, ya que representa un activo de información que debe formar parte del inventario, aunque no aparezca en la consulta de tablas.

## 2. Catálogo de datos

| ID | Conjunto de datos | Motor | Ubicación | Propietario | Custodio | Clasificación | Contiene datos personales | Finalidad | Conservación | Diccionario |
|---|---|---|---|---|---|---|---|---|---|---|
| CAT-01 | Clientes | PostgreSQL 16 | `<servidor-pg>` / comercial / public.clientes | Gerencia Comercial | DBA | Confidencial | Sí | Gestión y atención de clientes, facturación y análisis comercial | Según política de conservación de datos personales | diccionario-clientes.csv |
| CAT-02 | Auditoría de clientes | PostgreSQL 16 | `<servidor-pg>` / comercial / auditoria.cambios_clientes | Responsable de Auditoría | DBA | Confidencial | Sí | Registrar modificaciones realizadas a los datos de clientes | Según política de auditoría | Diccionario de auditoría |
| CAT-03 | Registro de cambios | PostgreSQL 16 | `<servidor-pg>` / comercial / gobierno.solicitudes_cambio | Responsable de Gobierno de Datos | DBA | Confidencial | Puede contener | Registrar solicitudes y autorizaciones de cambios | Según política de gobierno de datos | Pendiente, Actividad 7 |
| CAT-04 | Clientes (tienda) | MongoDB 7 | `<servidor-mongo>` / comercial / clientes | Gerencia Comercial | Administrador de MongoDB | Confidencial | Sí | Gestión de información de clientes de la tienda | Según política de conservación de datos personales | Diccionario de MongoDB |
| CAT-05 | Perfilado | MongoDB 7 | `<servidor-mongo>` / comercial / system.profile | Responsable de Seguridad de la Información | Administrador de MongoDB | Confidencial | Puede contener | Registrar operaciones y analizar el rendimiento de MongoDB | Según política de retención de registros técnicos | Diccionario de perfilado |

**Nota:** Los nombres de servidores son referencias que deben sustituirse por los nombres o direcciones reales del entorno. CAT-03 se completará después de crear el objeto correspondiente en la Actividad 7.

## 3. Preguntas

### 1. ¿Por qué CAT-02 y CAT-05 contienen datos personales aunque su propósito sea la auditoría?

Porque los registros de auditoría pueden almacenar información relacionada con los clientes, como identificadores, RFC, nombres y valores anteriores o posteriores a una modificación.

En MongoDB, los registros de perfilado también pueden contener consultas y parámetros relacionados con información personal.

Por eso, aunque su finalidad sea auditar o supervisar operaciones, deben protegerse y limitarse sus accesos.

### 2. ¿Qué pasa si CAT-01 y CAT-04 tienen propietarios distintos y el RFC de un cliente difiere entre ambos motores?

Se genera una inconsistencia en la información del cliente, lo que puede provocar errores en la facturación y en otros procesos comerciales.

Para resolverlo debe existir un responsable que determine cuál es la información correcta, verificar el RFC con una fuente confiable y autorizar la corrección en ambos motores.

También es necesario establecer reglas de sincronización para evitar que las diferencias vuelvan a aparecer.

### 3. ¿Qué información del catálogo cambia con más frecuencia y quién debe actualizarla?

La información que puede cambiar con mayor frecuencia es la ubicación de los servidores, los custodios, los usuarios autorizados, la finalidad de los datos y las políticas de conservación.

El propietario de los datos debe informar y aprobar los cambios relacionados con el negocio, mientras que el DBA o administrador correspondiente debe actualizar la información técnica del catálogo.

El catálogo debe mantenerse actualizado para que la organización conozca dónde están sus datos, quién es responsable de ellos y cómo deben protegerse.

## 4. Conclusión

Esta actividad permitió identificar los principales conjuntos de datos utilizados en PostgreSQL y MongoDB, integrando su ubicación, propietarios, custodios, clasificación y finalidad.

También se comprendió que no basta con conocer las tablas existentes, sino que es necesario mantener un inventario de todos los activos de información, incluyendo auditorías y registros de operaciones.

Finalmente, el catálogo ayuda a mejorar el gobierno de datos, identificar responsabilidades y mantener un mejor control sobre la información de la organización.
