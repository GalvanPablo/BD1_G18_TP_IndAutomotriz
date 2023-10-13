-- Variables para almacenar los valores de salida para ModificarInsumo
SET @resultado := 0;
SET @mensaje := '';

-- Suponiendo que el ID del insumo que deseas modificar es 1
SET @insumo_id := 1;

-- Nuevo nombre para el insumo
SET @nuevo_nombre_insumo := 'Nuevo Nombre de Insumo';

-- Llamar al procedimiento almacenado
CALL ModificarInsumo(
    @insumo_id,
    @nuevo_nombre_insumo,
    @resultado,
    @mensaje
);

-- Mostrar el resultado y el mensaje
SELECT @resultado AS resultado, @mensaje AS mensaje;
