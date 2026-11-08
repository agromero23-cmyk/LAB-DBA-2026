-- LAB-04 Hardening - Actividad 2
-- Identificar los archivos de configuración de PostgreSQL.
-- Estas consultas solo leen información.

-- 1. Archivo principal de configuración
SHOW config_file;

-- 2. Archivo de reglas de acceso
SHOW hba_file;

-- 3. Archivo de mapeo de usuarios
SHOW ident_file;

-- 4. Directorio de datos
SHOW data_directory;

-- 5. Directorio de registros
SHOW log_directory;

-- 6. Registro de conexiones
SHOW log_connections;

-- 7. Registro de desconexiones
SHOW log_disconnections;
