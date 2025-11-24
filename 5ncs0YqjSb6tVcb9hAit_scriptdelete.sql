--resetear todo
DO $$
DECLARE
    table_record RECORD;
    function_record RECORD;
    trigger_record RECORD;
     function_name TEXT;
BEGIN
    -- Eliminar todas las tablas
    FOR table_record IN (SELECT table_name FROM information_schema.tables WHERE table_schema = 'public') LOOP
        EXECUTE 'DROP TABLE IF EXISTS public.' || table_record.table_name || ' CASCADE';
    END LOOP;

    -- Eliminar todas las funciones
     FOR function_name IN (SELECT routine_name FROM information_schema.routines WHERE specific_schema = 'public' AND routine_type = 'FUNCTION') LOOP
        EXECUTE 'DROP FUNCTION IF EXISTS public.' || function_name || ' CASCADE';
    END LOOP;

    -- Eliminar todos los triggers
    FOR trigger_record IN (SELECT trigger_name FROM information_schema.triggers WHERE trigger_schema = 'public') LOOP
        EXECUTE 'DROP TRIGGER IF EXISTS public.' || trigger_record.trigger_name || ' ON ALL TABLES CASCADE';
    END LOOP;
END $$;
