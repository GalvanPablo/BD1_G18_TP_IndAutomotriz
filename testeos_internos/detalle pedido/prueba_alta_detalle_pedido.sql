-- Variables para almacenar los valores de salida
SET @out_detalle_pedido_id = 0;
SET @out_mensaje = '';

-- Llamada al procedimiento almacenado para dar de alta un detalle de pedido
CALL AltaDetallePedido(
    1, -- ID del pedido
    3, -- ID del modelo
    2, -- Cantidad
    15000.00, -- Precio
    @out_detalle_pedido_id, -- Variable para almacenar el ID del detalle de pedido
    @out_mensaje -- Variable para almacenar el mensaje de salida
);

-- Ver los resultados
SELECT @out_detalle_pedido_id AS DetallePedidoID, @out_mensaje AS Mensaje;
