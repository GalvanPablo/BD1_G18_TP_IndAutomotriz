DROP PROCEDURE IF EXISTS pais_alta_sp;

DELIMITER //
CREATE PROCEDURE pais_alta_sp(
	IN p_nombre VARCHAR(45),
    IN p_codigo_iso VARCHAR(3),
    OUT p_pais_id INT
)
BEGIN
    DECLARE v_id INT;
    -- Verificar si el país ya existe
    SELECT pais_id INTO v_id FROM pais WHERE nombre = p_nombre;

    IF v_id IS NULL THEN
		IF COALESCE(p_codigo_iso, '') = '' THEN
			SET p_codigo_iso = UPPER(SUBSTRING(p_nombre, 1, 3));
		END IF;
        -- Si el país no existe, insertarlo
        INSERT INTO pais (nombre, codigo_iso) VALUES (p_nombre, p_codigo_iso);
        SET v_id = LAST_INSERT_ID(); -- Obtener el ID generado
    END IF;

    SET p_pais_id = v_id;
END //
DELIMITER ;
