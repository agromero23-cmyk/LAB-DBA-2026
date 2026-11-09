
-- LAB-01
-- Actividad 11: Crear la función y el disparador de auditoría

-- 1. Crear la función que registra los cambios
CREATE OR REPLACE FUNCTION auditoria.registrar_cambio_cliente()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = pg_catalog, public
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO auditoria.cambios_clientes
            (operacion, id_cliente, valores_despues)
        VALUES
            (TG_OP, NEW.id, to_jsonb(NEW));

        RETURN NEW;

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO auditoria.cambios_clientes
            (operacion, id_cliente, valores_antes, valores_despues)
        VALUES
            (TG_OP, NEW.id, to_jsonb(OLD), to_jsonb(NEW));

        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO auditoria.cambios_clientes
            (operacion, id_cliente, valores_antes)
        VALUES
            (TG_OP, OLD.id, to_jsonb(OLD));

        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$;

-- 2. Revocar permisos de ejecución para PUBLIC
REVOKE ALL ON FUNCTION auditoria.registrar_cambio_cliente()
FROM PUBLIC;

-- 3. Eliminar el trigger anterior si existe
DROP TRIGGER IF EXISTS trg_auditoria_clientes ON public.clientes;

-- 4. Crear el trigger para INSERT, UPDATE y DELETE
CREATE TRIGGER trg_auditoria_clientes
AFTER INSERT OR UPDATE OR DELETE
ON public.clientes
FOR EACH ROW
EXECUTE FUNCTION auditoria.registrar_cambio_cliente();

-- 5. Verificar que el trigger esté habilitado
SELECT
    tgname,
    tgenabled,
    tgrelid::regclass AS tabla
FROM pg_trigger
WHERE tgname = 'trg_auditoria_clientes'
  AND NOT tgisinternal;
