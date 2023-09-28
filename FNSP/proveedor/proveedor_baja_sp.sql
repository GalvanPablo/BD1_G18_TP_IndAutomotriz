DROP PROCEDURE IF EXISTS proveedor_baja_sp;

DELIMITER //
CREATE PROCEDURE proveedor_baja_sp(
    -- Datos del proveedor a modificar
    IN p_id_proveedor INT,

    -- Resultado
    OUT nResultado INT,
    OUT cMensaje VARCHAR(255)
)
BEGIN
	DECLARE v_proveedor_id INT;				-- si existe el proveedor con el ID proporcionado
    
    SET nResultado = 0;
    
	IF p_id_proveedor IS NULL THEN	-- Si el ID del provedor a modificar es nulo
        SET nResultado = -2;
        SET cMensaje = "El ID del proveedor no puede ser nulo";
    ELSE
		-- Verificar si el proveedor con el ID proporcionado existe y no este dado de baja
		SELECT proveedor_id INTO v_proveedor_id FROM proveedor WHERE proveedor_id = p_id_proveedor AND baja = 0;
		
		IF v_proveedor_id IS NULL THEN	-- Si no existe el proveedor o esta dado de baja
			SET nResultado = -1;
			SET cMensaje = CONCAT("No se encontró un proveedor con el ID '", p_id_proveedor, "' o ya esta dado de baja");
		ELSE	-- Si existe y no esta dado de baja
			UPDATE proveedor
				SET
					baja = 1
				WHERE proveedor_id = p_id_proveedor;
		END IF;
    END IF;
END //
DELIMITER ;