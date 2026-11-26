-- ============================================
-- LABORATORIO
-- Actividad 1: Calidad de datos
-- ============================================

-- 1. Insertar registros de prueba con errores

INSERT INTO clientes
(nombre, correo, telefono, rfc, edad, ciudad, codigo_postal)
VALUES
('Ana Lopez', 'ANA.LOPEZ@example.test', '6671234567',
 'LOAA850315AB', 41, 'Culiacan', '80000'),

('Jorge Díaz', 'sin-correo', '667', NULL,
 -3, 'Culiacán', '8000');


-- 2. Verificar posibles duplicados por correo

SELECT lower(correo) AS correo_normalizado,
       count(*) AS registros,
       string_agg(id::text, ', ') AS ids
FROM clientes
GROUP BY lower(correo)
HAVING count(*) > 1;


-- 3. Verificar RFC inválidos o ausentes

SELECT id, nombre, rfc
FROM clientes
WHERE rfc IS NULL
   OR rfc !~ '^[A-ZÑ&]{3,4}[0-9]{6}[A-Z0-9]{3}$';


-- 4. Verificar correos electrónicos inválidos

SELECT id, nombre, correo
FROM clientes
WHERE correo IS NULL
   OR correo !~ '^[^@\s]+@[^@\s]+\.[^@\s]+$';


-- 5. Verificar edades fuera de rango

SELECT id, nombre, edad
FROM clientes
WHERE edad IS NOT NULL
  AND (edad < 18 OR edad > 120);


-- 6. Verificar completitud de los datos

SELECT count(*) AS total,
       count(*) FILTER (WHERE telefono IS NULL) AS sin_telefono,
       count(*) FILTER (WHERE rfc IS NULL) AS sin_rfc,
       count(*) FILTER (WHERE correo IS NULL) AS sin_correo
FROM clientes;


-- 7. Verificar teléfonos incompletos

SELECT id, nombre, telefono
FROM clientes
WHERE telefono IS NULL
   OR telefono !~ '^[0-9]{10}$';


-- ============================================
-- FIN DE LAS VERIFICACIONES
-- ============================================

 