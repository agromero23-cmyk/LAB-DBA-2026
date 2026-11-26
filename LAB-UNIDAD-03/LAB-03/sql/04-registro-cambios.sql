
-- LAB-03 - Actividad 7
-- Registro de cambios y conciliación
-- Base de datos: comercial

-- 1. Crear el esquema de gobierno
CREATE SCHEMA IF NOT EXISTS gobierno;

-- Evitar que PUBLIC tenga permisos sobre el esquema
REVOKE ALL ON SCHEMA gobierno FROM PUBLIC;

-- 2. Crear la tabla de solicitudes de cambio
CREATE TABLE IF NOT EXISTS gobierno.solicitudes_cambio (
    folio            TEXT PRIMARY KEY,
    descripcion      TEXT NOT NULL,
    solicitado_por   TEXT NOT NULL,
    aprobado_por     TEXT,
    ambiente         TEXT NOT NULL
                     CHECK (ambiente IN ('desarrollo', 'pruebas', 'produccion')),
    fecha_aprobacion TIMESTAMPTZ,
    ventana_inicio   TIMESTAMPTZ,
    ventana_fin      TIMESTAMPTZ
);

-- 3. Documentar la tabla
COMMENT ON TABLE gobierno.solicitudes_cambio IS
'Registro de solicitudes de cambio en la base comercial. Propietario: Comité de cambios. Custodio: DBA. Evidencia de POL-06.';

-- 4. Registrar la solicitud aprobada
INSERT INTO gobierno.solicitudes_cambio (
    folio,
    descripcion,
    solicitado_por,
    aprobado_por,
    ambiente,
    fecha_aprobacion,
    ventana_inicio,
    ventana_fin
)
VALUES (
    'CAM-2026-014',
    'Agregar columna canal_alta a clientes',
    'Gerencia Comercial',
    'Comité de cambios',
    'produccion',
    now() - interval '1 day',
    now() - interval '5 minutes',
    now() + interval '1 hour'
)
ON CONFLICT (folio) DO UPDATE SET
    descripcion      = EXCLUDED.descripcion,
    solicitado_por   = EXCLUDED.solicitado_por,
    aprobado_por     = EXCLUDED.aprobado_por,
    ambiente         = EXCLUDED.ambiente,
    fecha_aprobacion = EXCLUDED.fecha_aprobacion,
    ventana_inicio   = EXCLUDED.ventana_inicio,
    ventana_fin      = EXCLUDED.ventana_fin;

-- 5. Ejecutar el cambio autorizado
ALTER TABLE public.clientes
ADD COLUMN IF NOT EXISTS canal_alta VARCHAR(20);

-- 6. Documentar el cambio en la columna
COMMENT ON COLUMN public.clientes.canal_alta IS
'Canal por el que se registró el cliente. Cambio CAM-2026-014.';

-- 7. Verificar que la solicitud esté dentro de su ventana
SELECT
    folio,
    aprobado_por,
    ventana_inicio <= now() AND now() <= ventana_fin AS dentro_de_ventana
FROM gobierno.solicitudes_cambio;

-- 8. Consultar los cambios de estructura y privilegios registrados
-- IMPORTANTE: revisar y ocultar contraseñas u otros secretos antes
-- de compartir o entregar los resultados.

SELECT
    num,
    substr(linea, 1, 23) AS momento,
    substring(linea FROM 'user=([^ ]*)') AS usuario,
    substring(linea FROM 'statement: (.*)$') AS sentencia
FROM dba.bitacora
WHERE linea ~ 'statement: (CREATE|ALTER|DROP|GRANT|REVOKE)'
ORDER BY num;

-- 9. Consultar la solicitud registrada
SELECT *
FROM gobierno.solicitudes_cambio
WHERE folio = 'CAM-2026-014';

-- 10. Confirmar que la columna exista
SELECT
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'clientes'
  AND column_name = 'canal_alta';
