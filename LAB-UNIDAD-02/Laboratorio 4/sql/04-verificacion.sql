-- LAB-04 Hardening PostgreSQL
-- Actividad: verificación final de seguridad
-- Consultas de solo lectura. No modifican la configuración.

-- 1. Identificar la conexión actual
SELECT
    current_database() AS base_datos,
    current_user AS usuario_actual,
    version() AS version_postgresql;

-- 2. Revisar roles y privilegios administrativos
SELECT
    rolname AS nombre_rol,
    rolsuper AS superusuario,
    rolcreaterole AS puede_crear_roles,
    rolcreatedb AS puede_crear_bases,
    rolcanlogin AS puede_iniciar_sesion
FROM pg_roles
ORDER BY rolname;

-- 3. Revisar parámetros de seguridad disponibles
SELECT
    name AS parametro,
    setting AS valor
FROM pg_settings
WHERE name IN (
    'listen_addresses',
    'port',
    'ssl',
    'password_encryption',
    'log_connections',
    'log_disconnections'
)
ORDER BY name;

-- 4. Comprobar el cifrado TLS de la conexión actual
SELECT
    s.ssl AS tls_activo,
    s.version AS version_tls,
    s.cipher AS cifrado
FROM pg_stat_ssl AS s
WHERE s.pid = pg_backend_pid();
