-- Variables para almacenar los resultados
SET @resultado := 0;
SET @mensaje := '';

-- Suponiendo que el ID del pedido y el ID del modelo que deseas modificar son 1 y 2 respectivamente
SET @pedido_id := 1;
SET @modelo_id := 2;

-- Nuevos datos para el detalle del pedido
SET @nueva_cantidad := 5;
SET @nuevo_precio := 100.00;

-- Llamar al procedimiento almacenado
CALL ModificarDetallePedido(
    @pedido_id,
    @modelo_id,
    @nueva_cantidad,
    @nuevo_precio,
    @resultado,
    @mensaje
);

-- Mostrar el resultado y el mensaje
SELECT @resultado AS resultado, @mensaje AS mensaje;
