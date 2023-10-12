DROP PROCEDURE IF EXISTS pedido_modificacion_sp;

DELIMITER //
CREATE PROCEDURE pedido_modificacion_sp(
    
    IN pedido_id INT,
    IN p_concesionario_id INT,
    IN nueva_fecha_pedido DATE

    -- Resultado
    OUT nResultado INT,
    OUT cMensaje VARCHAR(255)
)
BEGIN
	
    DECLARE v_concesionario_id INT;
    SET nResultado = 0;

    IF p_concesionario_id IS NULL THEN	-- Si el ID del concesionario a modificar es nulo
        SET nResultado = -2;
        SET cMensaje = "El ID del concesionario no puede ser nulo";
    ELSE
		-- Verificar si el concesionario con el ID proporcionado existe y no este dado de baja
		SELECT concesionario_id INTO v_concesionario_id FROM concesionario WHERE concesionario_id = p_concesionario_id AND baja = 0;
		
		IF v_concesionario_id IS NULL THEN	
			SET nResultado = -1;
			SET cMensaje = CONCAT("No se encontró un concesionario con el ID '", p_concesionario_id, "' o esta dado de baja");
		ELSE	-- Si existe
			
    UPDATE pedido
    SET
        fecha_pedido = nueva_fecha_pedido
    WHERE pedido_id = pedido_id
END IF

END //
DELIMITER ;