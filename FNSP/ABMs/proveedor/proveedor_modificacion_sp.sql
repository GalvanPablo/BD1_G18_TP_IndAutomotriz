DROP PROCEDURE IF EXISTS proveedor_modificacion_sp;

DELIMITER //
CREATE PROCEDURE proveedor_modificacion_sp(
    -- Datos del proveedor a modificar
    IN p_id_proveedor INT,
    IN p_nombre_nuevo VARCHAR(45),
    IN p_mail VARCHAR(45),
    IN p_telefono VARCHAR(45),

    -- Resultado
    OUT nResultado INT,
    OUT cMensaje VARCHAR(255)
)
BEGIN
	DECLARE v_proveedor_id INT;				-- si existe el proveedor con el ID proporcionado
    DECLARE v_nombre_actual VARCHAR(45); 	-- si el nuevo nombre es diferente al nombre actual
    DECLARE v_otro_proveedor_id INT; 		-- si el nuevo nombre no se está utilizando por otro proveedor
    
    SET nResultado = 0;
    SET @cambios_realizados = 0;

    IF p_id_proveedor IS NULL THEN	-- Si el ID del provedor a modificar es nulo
        SET nResultado = -2;
        SET cMensaje = "El ID del proveedor no puede ser nulo";
    ELSE
		-- Verificar si el proveedor con el ID proporcionado existe y no este dado de baja
		SELECT proveedor_id INTO v_proveedor_id FROM proveedor WHERE proveedor_id = p_id_proveedor AND baja = 0;
		
		IF v_proveedor_id IS NULL THEN	-- Si no existe el proveedor o esta dado de baja
			SET nResultado = -1;
			SET cMensaje = CONCAT("No se encontró un proveedor con el ID '", p_id_proveedor, "' o esta dado de baja");
		ELSE	-- Si existe
			IF p_nombre_nuevo IS NOT NULL THEN -- Si el nuevo nombre no es nulo
				-- Verificar si el nuevo nombre es diferente al nombre actual
				SELECT nombre INTO v_nombre_actual FROM proveedor WHERE proveedor_id = p_id_proveedor;

				IF v_nombre_actual <> p_nombre_nuevo THEN -- Si es diferente
					-- Verificar si el nuevo nombre no se está utilizando por otro proveedor
					SELECT proveedor_id INTO v_otro_proveedor_id FROM proveedor WHERE nombre = p_nombre_nuevo AND proveedor_id <> p_id_proveedor;

					IF v_otro_proveedor_id IS NOT NULL THEN	-- Si ya esta usado el nombre
						SET nResultado = -3;
						SET cMensaje = CONCAT("Ya existe otro proveedor con el nombre '", p_nombre_nuevo, "'");
					ELSE
						-- Actualizar el nombre del proveedor si es diferente y no se está utilizando por otro proveedor
						UPDATE proveedor
						SET
							nombre = p_nombre_nuevo
						WHERE proveedor_id = p_id_proveedor;
						SET @cambios_realizados = 1;
					END IF;
				END IF;
			END IF;


			-- Verificar y actualizar el correo del proveedor si es diferente
			IF p_mail IS NOT NULL AND p_mail <> (SELECT mail FROM proveedor WHERE proveedor_id = p_id_proveedor) THEN
				UPDATE proveedor
				SET
					mail = p_mail
				WHERE proveedor_id = p_id_proveedor;
				SET @cambios_realizados = 1;
			END IF;

			-- Verificar y actualizar el teléfono del proveedor si es diferente
			IF p_telefono IS NOT NULL AND p_telefono <> (SELECT telefono FROM proveedor WHERE proveedor_id = p_id_proveedor) THEN
				UPDATE proveedor
				SET
					telefono = p_telefono
				WHERE proveedor_id = p_id_proveedor;
				SET @cambios_realizados = 1;
			END IF;

			-- Verificar si se realizaron cambios
			IF @cambios_realizados = 0 THEN
				SET nResultado = -4;
				SET cMensaje = "No se realizaron cambios en el proveedor";
			END IF;
		END IF;
	END IF;
END //
DELIMITER ;
