DROP PROCEDURE IF EXISTS pedido_alta_sp;

DELIMITER //
CREATE PROCEDURE pedido_alta_sp(
	IN p_concesionario_id INT,

    -- Resultado
    OUT nResultado INT,
    OUT cMensaje VARCHAR(255)
)
BEGIN
	DECLARE aux_concesionario_id INT;
    DECLARE p_fecha_pedido DATETIME;
    DECLARE p_fecha_entrega_estimada DATETIME;
    
    DECLARE p_id INT;
    
	SET nResultado = 0;
    
    SELECT concesionario_id INTO aux_concesionario_id FROM concesionario WHERE concesionario_id = p_concesionario_id;
	IF aux_concesionario_id IS NULL THEN -- Si no existe un concesionario con el ID provisto
		-- Tirar error
        SET nResultado = -1;
        SET cMensaje = CONCAT("El concesionario con ID ", p_concesionario_id, " no existe");
	ELSE
		-- Si existe el concesionario
        SET p_fecha_pedido = NOW();
        SET p_fecha_entrega_estimada = DATE_ADD(p_fecha_pedido, INTERVAL 1 WEEK);
        
        INSERT INTO pedido (fecha_pedido, concesionario_concesionario_id, fecha_entrega_estimada)
        VALUES (p_fecha_pedido, p_concesionario_id, p_fecha_entrega_estimada);
        
        SET p_id = LAST_INSERT_ID();	-- Obtengo el ID del Nuevo Proveedor
				
		IF p_id IS NULL THEN	-- Si no tengo un ID es que no se pudo insertar
			SET nResultado = -2;
			SET cMensaje = "Error al dar de alta a el nuevo pedido";
		END IF;
    END IF;
END //
DELIMITER ;