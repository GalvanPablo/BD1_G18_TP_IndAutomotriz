DROP PROCEDURE IF EXISTS generar_vehiculo_segun_pedido_sp;

DELIMITER //
CREATE PROCEDURE generar_vehiculo_segun_pedido_sp(
	IN pedidoID INT,
    
    OUT nResultado INT,
    OUT cMensaje VARCHAR(50)
)
BEGIN
    DECLARE detalle_modeloID INT;
    DECLARE detalle_cantidad INT;
    DECLARE eof INT;
    DECLARE iteracion INT;
    DECLARE nro_chasis VARCHAR(45);
    
	DECLARE cur_detallePedido
		CURSOR FOR
			SELECT dp.modelo_modelo_id, dp.cantidad FROM detalle_pedido dp WHERE dp.pedido_pedido_id = pedidoID;
		
	DECLARE CONTINUE HANDLER
		FOR NOT FOUND SET eof = 1;
    
    SET nResultado = 0;
    SET cMensaje = "";
    
    IF pedidoID IS NULL OR pedidoID <= 0 THEN
		SET nResultado = -1;
		SET cMensaje = "El pedido ID no puede ser nulo o menor/igual que 0";
	END IF;
    
    IF EXISTS (SELECT * FROM vehiculo v WHERE v.pedido_pedido_id = pedidoID LIMIT 1) THEN
		SET nResultado = -2;
		SET cMensaje = "Ya existen vehiculos generados de este pedido";
	END IF;
    
    IF nResultado = 0 THEN
		OPEN cur_detallePedido;
		
		getDetallePedido: LOOP
			FETCH cur_detallePedido INTO detalle_modeloID, detalle_cantidad;
			IF eof = 1 THEN
				LEAVE getDetallePedido;
			END IF;
			#SET cMensaje = CONCAT(cMensaje, " - Modelo: ", detalle_modeloID, " Cantidad: ", detalle_cantidad);
			
			SET iteracion = 0;
			WHILE iteracion < detalle_cantidad DO
				SET nro_chasis = generar_nro_chasis_fn(detalle_modeloID);
				
				INSERT INTO vehiculo (pedido_pedido_id, modelo_modelo_id, nro_chasis)
				VALUES (pedidoID, detalle_modeloID, nro_chasis);
				
				SET iteracion = iteracion + 1;
			END WHILE;
			
			
		END LOOP getDetallePedido;
		
		CLOSE cur_detallePedido;
	END IF;
END //
DELIMITER ;
