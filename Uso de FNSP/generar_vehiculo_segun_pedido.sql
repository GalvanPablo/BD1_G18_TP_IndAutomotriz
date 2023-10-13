CALL generar_vehiculo_segun_pedido_sp(1, @nResultado, @cMensaje);
SELECT @nResultado, @cMensaje;


#SELECT dp.modelo_modelo_id, dp.cantidad FROM detalle_pedido dp WHERE dp.pedido_pedido_id = 1;

#SELECT * FROM vehiculo