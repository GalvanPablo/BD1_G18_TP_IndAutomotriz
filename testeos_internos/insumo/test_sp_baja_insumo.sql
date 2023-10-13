-- Variables para almacenar los valores de salida para BajaInsumo
SET @resultado := 0;
SET @mensaje := '';

-- Llamada al procedimiento almacenado BajaInsumo
CALL BajaInsumo(1, @resultado, @mensaje);

-- Ver los resultados de BajaInsumo
SELECT @resultado AS Resultado, @mensaje AS Mensaje;
