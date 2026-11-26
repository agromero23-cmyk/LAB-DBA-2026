
-- ============================================
-- LABORATORIO U3
-- Actividad 4: Catálogo mínimo de datos
-- ============================================

-- 1. Actualizar estadísticas de las tablas

ANALYZE;


-- 2. Consultar inventario de tablas

SELECT
    n.nspname AS esquema,
    c.relname AS tabla,
    pg_get_userbyid(c.relowner) AS propietario_tecnico,
    c.reltuples::bigint AS filas_estimadas,
    pg_size_pretty(pg_total_relation_size(c.oid)) AS tamano,
    obj_description(c.oid, 'pg_class') AS descripcion
FROM pg_class c
JOIN pg_namespace n
    ON n.oid = c.relnamespace
WHERE c.relkind = 'r'
  AND n.nspname NOT IN (
      'pg_catalog',
      'information_schema'
  )
ORDER BY 1, 2;


-- 3. Consultar también las vistas del sistema
-- para identificar activos que no aparecen
-- en el inventario anterior.

SELECT
    schemaname AS esquema,
    viewname AS vista,
    viewowner AS propietario_tecnico
FROM pg_views
WHERE schemaname NOT IN (
    'pg_catalog',
    'information_schema'
)
ORDER BY schemaname, viewname;


-- ============================================
-- FIN DE LA ACTIVIDAD 4
-- ============================================
