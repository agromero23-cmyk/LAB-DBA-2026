SELECT version();
SHOW data_directory;
SHOW config_file;
SHOW hba_file;

CREATE TABLE clientes (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    correo VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    rfc VARCHAR(13),
    edad INTEGER,
    ciudad VARCHAR(80),
    codigo_postal VARCHAR(10),
    fecha_alta DATE DEFAULT CURRENT_DATE
);

INSERT INTO clientes (nombre, correo, telefono, rfc, edad, ciudad, codigo_postal) VALUES
('Ana López', 'ana.lopez@example.test', '6671234567', 'LOAA850315ABC', 41, 'Culiacán', '80000'),
('Carlos Pérez', 'carlos.perez@example.test', '6672345678', 'PECA900720DEF', 35, 'Culiacán', '80100'),
('María García', 'maria.garcia@example.test', '6673456789', 'GAMA780912GHI', 47, 'Mazatlán', '82000'),
('Luis Torres', 'luis.torres@example.test', '6674567890', 'TOLU920201JKL', 34, 'Los Mochis', '81200'),
('Laura Sánchez', 'laura.sanchez@example.test', '6675678901', 'SALA880525MNO', 38, 'Culiacán', '80200');

SELECT * FROM CLIENTES;

CREATE ROLE app_ventas;
CREATE ROLE soporte_ana LOGIN;

SELECT name, setting, source
FROM pg_settings
WHERE name IN ('log_destination', 'logging_collector', 'log_directory', 'log_filename',
               'log_connections', 'log_disconnections', 'log_line_prefix',
               'log_statement', 'log_min_error_statement', 'log_timezone')
ORDER BY name;

ALTER SYSTEM SET logging_collector = on;

SELECT name, setting, pending_restart
FROM pg_settings
WHERE name = 'logging_collector';

SELECT pg_current_logfile();

SELECT linea
FROM regexp_split_to_table(
    pg_read_file(pg_current_logfile()),
    E'\n'
) AS linea;

CREATE SCHEMA dba;

REVOKE ALL ON SCHEMA dba FROM PUBLIC;

CREATE VIEW dba.bitacora AS
SELECT t.n AS num, t.linea
FROM regexp_split_to_table(
    pg_read_file(pg_current_logfile()),
    E'\n'
) WITH ORDINALITY AS t(linea, n)
WHERE t.linea <> '';

-- Últimas 10 líneas
SELECT num, linea
FROM dba.bitacora
ORDER BY num DESC
LIMIT 10;

-- Buscar errores
SELECT linea
FROM dba.bitacora
WHERE linea ~ '(FATAL|ERROR)';

SELECT linea
FROM dba.bitacora
WHERE linea ILIKE '%update%'
   OR linea LIKE '%app_ventas%';

SHOW server_encoding;

SHOW client_encoding;

SELECT linea
FROM regexp_split_to_table(
    convert_from(
        pg_read_binary_file(pg_current_logfile()),
        'WIN1252'
    ),
    E'\n'
) AS linea
LIMIT 15;

SELECT linea
FROM regexp_split_to_table(
    convert_from(
        pg_read_binary_file(pg_current_logfile()),
        'WIN1252'
    ),
    E'\n'
) AS linea
WHERE linea ILIKE '%update%'
   OR linea ILIKE '%app_ventas%';

SELECT linea
FROM regexp_split_to_table(
    convert_from(
        pg_read_binary_file(pg_current_logfile()),
        'WIN1252'
    ),
    E'\n'
) AS linea
WHERE linea ILIKE '%UPDATE clientes SET rfc%'
   OR linea ILIKE '%connection authorized: user=app_ventas%';

SELECT id, rfc
FROM clientes
WHERE id = 3;