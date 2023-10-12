DROP PROCEDURE IF EXISTS pedido_baja_sp;

DELIMITER //
CREATE PROCEDURE pedido_baja_sp(
    -- Datos del proveedor a modificar
    IN p_concesionario_id INT,

    -- Resultado
    OUT nResultado INT,
    OUT cMensaje VARCHAR(255)
)
BEGIN
	DECLARE v_concesionario_id INT;				-- si existe el proveedor con el ID proporcionado
    
    SET nResultado = 0;
    
	IF p_concesionario_id IS NULL THEN	-- Si el ID del provedor a modificar es nulo
        SET nResultado = -2;
        SET cMensaje = "El ID del concesionario no puede ser nulo";
    ELSE
		-- Verificar si el proveedor con el ID proporcionado existe y no este dado de baja
		SELECT concesionario_id INTO v_concesionario_id FROM concesionario WHERE concesionario_id = p_concesionario_id AND baja = 0;
		
		IF v_concesionario_id IS NULL THEN	-- Si no existe el proveedor o esta dado de baja
			SET nResultado = -1;
			SET cMensaje = CONCAT("No se encontró un concesionario con el ID '", p_concesionario_id, "' o ya esta dado de baja");
		ELSE	-- Si existe y no esta dado de baja
			UPDATE concesionario
				SET
					baja = 1
				WHERE concesionario_id = p_concesionario_id;
		END IF;
    END IF;
END //
DELIMITER ;