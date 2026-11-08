-- LAB-04 Hardening - Actividad 1
-- Identificar la superficie de ataque de PostgreSQL.
-- Ejecuta estas consultas en pgAdmin usando Query Tool.
-- Solo son consultas de lectura; no modifican la configuración.

-- 1. Versión del servidor
SELECT version();

-- 2. Puerto de PostgreSQL
SHOW port;

-- 3. Interfaces en las que escucha PostgreSQL
SHOW listen_addresses;

-- 4. Estado de SSL en el servidor
SHOW ssl;

-- 5. Método de almacenamiento para nuevas contraseñas
SHOW password_encryption;

-- 6. Conexiones activas
SELECT
    pid,
    usename,
    datname,
    client_addr,
    client_port,
    application_name
FROM pg_stat_activity
ORDER BY usename, datname;
