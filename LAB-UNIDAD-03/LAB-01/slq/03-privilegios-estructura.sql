-- Actividad 4: Configurar la bitácora

-- 1. Configuración de parámetros de auditoría y bitácora
ALTER SYSTEM SET log_connections = on;
ALTER SYSTEM SET log_disconnections = on;
ALTER SYSTEM SET log_line_prefix = '%m [%p] user=%u db=%d app=%a client=%h ';
ALTER SYSTEM SET log_statement = 'ddl';

-- 2. Recargar la configuración del servidor
SELECT pg_reload_conf();

-- 3. Verificación del origen de los valores aplicados
SELECT name, setting, source, sourcefile
FROM pg_settings
WHERE name IN ('log_connections', 'log_line_prefix', 'log_statement');

-- 4. Consulta de las últimas líneas en la bitácora
SELECT num, linea FROM dba.bitacora ORDER BY num DESC LIMIT 6;

SET client_encoding = 'LATIN1';
-- O alternativamente:
SET client_encoding = 'WIN1252';

