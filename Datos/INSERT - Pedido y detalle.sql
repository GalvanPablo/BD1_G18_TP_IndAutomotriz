CALL pedido_alta_sp(
	1, -- ID concesionario
    @nResultado, @cMensaje
);
SET @ultimo_id = LAST_INSERT_ID();

CALL AltaDetallePedido(
    @ultimo_id, -- ID del pedido
    6, -- ID del modelo
    5, -- Cantidad
    15000.00, -- Precio
    @out_detalle_pedido_id, -- Variable para almacenar el ID del detalle de pedido
    @out_mensaje -- Variable para almacenar el mensaje de salida
);

CALL AltaDetallePedido(
    @ultimo_id, -- ID del pedido
    7, -- ID del modelo
    2, -- Cantidad
    10000.00, -- Precio
    @out_detalle_pedido_id, -- Variable para almacenar el ID del detalle de pedido
    @out_mensaje -- Variable para almacenar el mensaje de salida
);


SELECT * FROM pedido p
INNER JOIN detalle_pedido dp ON dp.pedido_pedido_id = p.pedido_id