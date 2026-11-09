
-- LAB-01
-- Actividad 6: Cambios de privilegios y de estructura
-- Base de datos: postgres
-- Puerto: 5433
-- Ejecutar conectado como administrador (postgres).

-- 1. Activar el registro de sentencias DDL
-- Se aplica a esta sesión.

SET log_statement = 'ddl';


-- 2. Revocar UPDATE a soporte_ana
REVOKE UPDATE ON clientes FROM soporte_ana;


-- 3. Conceder UPDATE a app_ventas
GRANT UPDATE ON clientes TO app_ventas;


-- 4. Modificar la estructura de clientes
ALTER TABLE clientes
ADD COLUMN segmento VARCHAR(20);


-- 5. Crear un rol temporal.
-- ADVERTENCIA: esta sentencia registra la contraseña
-- en texto claro si log_statement está activo.

CREATE ROLE rol_temporal
LOGIN
PASSWORD 'Temporal_Practica_2026';


-- 6. Eliminar el rol temporal
DROP ROLE rol_temporal;


-- 7. Consultar las sentencias registradas
-- La lectura utiliza WIN1252 por el problema de codificación
-- identificado anteriormente en el archivo de bitácora.

WITH lineas AS (
    SELECT
        t.n AS num,
        t.linea
    FROM regexp_split_to_table(
        convert_from(
            pg_read_binary_file(pg_current_logfile()),
            'WIN1252'
        ),
        E'\n'
    ) WITH ORDINALITY AS t(linea, n)
)
SELECT num, linea
FROM lineas
WHERE linea ILIKE '%statement:%'
ORDER BY num;


-- 8. Verificar la estructura de la tabla
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'clientes'
ORDER BY ordinal_position;


-- 9. Verificar los privilegios de la tabla
SELECT
    grantee,
    privilege_type
FROM information_schema.role_table_grants
WHERE table_name = 'clientes'
  AND grantee IN ('app_ventas', 'soporte_ana')
ORDER BY grantee, privilege_type;

