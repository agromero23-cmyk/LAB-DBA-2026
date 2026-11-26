
# 9. Actividad 3 — Diccionario de datos operativo dentro del motor

## 1. Documentación de la tabla

Se utilizaron los comandos `COMMENT ON TABLE` y `COMMENT ON COLUMN` para registrar el significado de la tabla `clientes` y de sus columnas directamente en PostgreSQL.

También se agregó la columna `segmento`, ya que no estaba incluida en la estructura inicial de la tabla.

## 2. Diccionario de datos

| Columna | Clasificación (Unidad II) | Finalidad | Control aplicado | ¿Cambios auditados? | Regla de calidad |
|---|---|---|---|---|---|
| `id` | Identificador interno | Identificar cada cliente dentro del sistema | PRIMARY KEY y generación automática | No aplica a modificaciones normales | Unicidad y no duplicidad |
| `nombre` | Dato personal | Identificar al cliente | Acceso restringido | Según auditoría configurada | No debe estar vacío |
| `correo` | Dato personal | Enviar notificaciones al cliente | Acceso restringido y vista enmascarada para soporte | Según auditoría configurada | Formato válido y unicidad |
| `telefono` | Dato personal | Contactar al cliente | Acceso restringido | Según auditoría configurada | Diez dígitos y formato válido |
| `rfc` | Dato personal | Facturación | Vista enmascarada para soporte (U2) | Sí, LAB-01 Parte B | Formato RFC válido |
| `edad` | Dato personal | Analítica agregada | Acceso restringido | Según auditoría configurada | Edad entre 18 y 120 años |
| `ciudad` | Dato personal indirecto | Análisis geográfico | Acceso restringido | Según auditoría configurada | Nombre de ciudad válido |
| `codigo_postal` | Dato personal indirecto | Ubicación geográfica | Acceso restringido | Según auditoría configurada | Formato de código postal válido |
| `fecha_alta` | Dato personal relacionado | Control administrativo y seguimiento de clientes | Generación automática de fecha | Según auditoría configurada | Fecha válida y no futura |
| `segmento` | Dato comercial | Clasificar clientes para análisis comercial | Acceso según funciones del usuario | Según auditoría configurada | Pertenecer a una categoría comercial válida |

## 3. Preguntas

### 1. ¿Qué ventaja tiene guardar el significado en COMMENT en lugar de solo en un documento aparte?

La ventaja es que la documentación queda almacenada directamente en PostgreSQL y puede consultarse junto con la estructura de la tabla.

Esto facilita que los administradores y desarrolladores conozcan la finalidad de cada columna sin tener que buscar otro documento. Además, ayuda a mantener la información técnica más organizada.

### 2. ¿Quedaron registrados los COMMENT en la bitácora? ¿Con qué nivel de log_statement?

Los comandos `COMMENT` son operaciones de modificación de metadatos. Con la configuración `log_statement = 'mod'`, PostgreSQL registra las instrucciones de modificación y DDL correspondientes.

Por lo tanto, los comandos de documentación pueden quedar registrados en la bitácora con ese nivel de configuración.

### 3. ¿Qué información del diccionario debe mantenerse fuera del motor? ¿Por qué?

La información que debe mantenerse fuera del motor incluye las políticas completas de privacidad, responsables legales, procedimientos de autorización, tiempos de retención, finalidad detallada del tratamiento y reglas organizacionales.

Esto se debe a que PostgreSQL almacena principalmente información técnica sobre las tablas y columnas, mientras que los documentos externos permiten describir las políticas y responsabilidades de toda la organización.

## 4. Conclusión

Esta actividad permitió documentar la estructura y el significado de los datos directamente dentro de PostgreSQL mediante comentarios.

También se generó un archivo CSV con la información del diccionario y se complementó con la clasificación, finalidad, controles y reglas de calidad de cada columna.

Esto facilita la administración de la base de datos y permite que los responsables comprendan mejor cómo debe utilizarse y protegerse la información de los clientes.
