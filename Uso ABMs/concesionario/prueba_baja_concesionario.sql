-- Variables para almacenar los resultados
SET @resultado := 0;
SET @mensaje := '';

-- Llamada al procedimiento almacenado
CALL BajaConcesionario(2, @nResultado, @cMensaje);  -- Suponiendo que 1 es el ID del concesionario a dar de baja

-- Ver los resultados
SELECT @nResultado, @cMensaje;