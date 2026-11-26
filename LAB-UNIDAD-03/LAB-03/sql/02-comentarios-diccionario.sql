
-- ============================================
-- LABORATORIO U3
-- Actividad 3: Diccionario de datos operativo
-- ============================================

-- 1. Agregar segmento si todavía no existe

ALTER TABLE public.clientes
ADD COLUMN IF NOT EXISTS segmento VARCHAR(50);


-- 2. Comentario de la tabla

COMMENT ON TABLE public.clientes IS
'Clientes de Comercializadora Norte. Propietario: Gerencia Comercial. Custodio: DBA. Clasificación: confidencial (contiene datos personales).';


-- 3. Comentarios de las columnas

COMMENT ON COLUMN public.clientes.id IS
'Identificador interno del cliente. Generado por el sistema.';

COMMENT ON COLUMN public.clientes.nombre IS
'Nombre completo. Dato personal identificador directo.';

COMMENT ON COLUMN public.clientes.correo IS
'Correo de contacto. Dato personal. Uso: notificaciones al cliente.';

COMMENT ON COLUMN public.clientes.telefono IS
'Número telefónico de contacto. Dato personal identificador. Uso: comunicación con el cliente.';

COMMENT ON COLUMN public.clientes.rfc IS
'RFC del cliente. Dato personal. Uso: facturación. Cambios auditados en auditoria.cambios_clientes.';

COMMENT ON COLUMN public.clientes.edad IS
'Edad en años cumplidos. Dato personal. Uso: analítica agregada.';

COMMENT ON COLUMN public.clientes.ciudad IS
'Ciudad de residencia del cliente. Dato personal que puede contribuir a su identificación. Uso: análisis geográfico.';

COMMENT ON COLUMN public.clientes.codigo_postal IS
'Código postal del domicilio del cliente. Dato personal que puede contribuir a su identificación. Uso: ubicación geográfica.';

COMMENT ON COLUMN public.clientes.fecha_alta IS
'Fecha de registro del cliente en el sistema. Uso: control administrativo y seguimiento de antigüedad.';

COMMENT ON COLUMN public.clientes.segmento IS
'Categoría comercial asignada al cliente. Uso: clasificación y análisis comercial.';


-- 4. Consultar el diccionario de datos

SELECT
    c.ordinal_position AS pos,
    c.column_name AS columna,
    c.data_type AS tipo,
    c.character_maximum_length AS longitud,
    c.is_nullable AS acepta_nulos,
    c.column_default AS valor_por_defecto,
    col_description(
        'public.clientes'::regclass,
        c.ordinal_position
    ) AS descripcion
FROM information_schema.columns c
WHERE c.table_schema = 'public'
  AND c.table_name = 'clientes'
ORDER BY c.ordinal_position;


-- ============================================
-- FIN DE LA ACTIVIDAD 3
-- ============================================
