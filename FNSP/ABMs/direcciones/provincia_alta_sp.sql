DROP PROCEDURE IF EXISTS provincia_alta_sp;

DELIMITER //
CREATE PROCEDURE provincia_alta_sp(
	IN p_nombre VARCHAR(45),
    IN p_pais_id INT,
    OUT p_provincia_id INT
)
BEGIN
    DECLARE v_id INT;
    -- Verificar si la provincia ya existe en el país especificado
    SELECT provincia_id INTO v_id FROM provincia WHERE nombre = p_nombre AND pais_pais_id = p_pais_id;

    IF v_id IS NULL THEN
        -- Si la provincia no existe, insertarla
        INSERT INTO provincia (nombre, pais_pais_id) VALUES (p_nombre, p_pais_id);
        SET v_id = LAST_INSERT_ID(); -- Obtener el ID generado
    END IF;

    SET p_provincia_id = v_id;
END //
DELIMITER ;
