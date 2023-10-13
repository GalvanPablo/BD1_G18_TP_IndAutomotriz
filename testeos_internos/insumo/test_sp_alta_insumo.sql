-- Variables para almacenar los valores de salida
SET @out_insumo_id = 0;
SET @out_mensaje = '';

-- Llamada al procedimiento almacenado
CALL AgregarInsumo(
    'Neumático', -- Nombre del insumo
    @out_insumo_id,    -- Variable para almacenar el ID del insumo
    @out_mensaje        -- Variable para almacenar el mensaje de salida
);

-- Ver los resultados
SELECT @out_insumo_id AS InsumoID, @out_mensaje AS Mensaje;
