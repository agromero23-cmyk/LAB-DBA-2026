-- LAB-01
-- Actividad 12: El incidente auditado

-- IMPORTANTE:
-- Ejecutar conectado como postgres en la base de datos postgres.
-- Puerto local: 5433.

-- 1. Consultar los eventos de auditoría
SELECT
    id_evento,
    momento,
    usuario_sesion,
    usuario_efectivo,
    aplicacion,
    ip_cliente,
    operacion,
    id_cliente
FROM auditoria.cambios_clientes
ORDER BY id_evento;

-- 2. Comparar los valores anteriores y posteriores
-- Identifica exactamente qué campos cambiaron.

SELECT
    a.id_evento,
    a.momento,
    a.usuario_sesion,
    a.ip_cliente,
    d.key AS campo,
    a.valores_antes ->> d.key AS antes,
    d.value #>> '{}' AS despues
FROM auditoria.cambios_clientes a
CROSS JOIN LATERAL jsonb_each(a.valores_despues) d
WHERE a.operacion = 'UPDATE'
  AND a.valores_antes -> d.key IS DISTINCT FROM d.value
ORDER BY a.id_evento;

-- 3. Consultar los valores originales y nuevos del cliente 3
SELECT
    id_evento,
    valores_antes ->> 'rfc' AS rfc_anterior,
    valores_despues ->> 'rfc' AS rfc_nuevo
FROM auditoria.cambios_clientes
WHERE operacion = 'UPDATE'
  AND id_cliente = 3
ORDER BY id_evento;

-- 4. Consultar el RFC actual del cliente
SELECT id, nombre, rfc
FROM public.clientes
WHERE id = 3;

-- 5. Restaurar el RFC anterior (EJECUTAR SOLO DESPUÉS
-- DE CONSULTAR EL VALOR REAL EN valores_antes).
--
-- Ejemplo del enunciado:
-- UPDATE public.clientes
-- SET rfc = 'GAMA780912XYZ'
-- WHERE id = 3;
--
-- En tu entorno local, si el valor anterior registrado
-- es GAMA780912XXX, utiliza ese valor en lugar del ejemplo.

