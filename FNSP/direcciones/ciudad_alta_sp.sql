DROP PROCEDURE IF EXISTS ciudad_alta_sp;

DELIMITER //
CREATE PROCEDURE ciudad_alta_sp(
	IN c_nombre VARCHAR(45),
    IN c_provincia_id INT,
    OUT c_ciudad_id INT
)
BEGIN
    DECLARE v_id INT;
    -- Verificar si la ciudad ya existe en la provincia especificada
    SELECT ciudad_id INTO v_id FROM ciudad WHERE nombre = c_nombre AND provincia_provincia_id = c_provincia_id;

    IF v_id IS NULL THEN
        -- Si la ciudad no existe, insertarla
        INSERT INTO ciudad (nombre, provincia_provincia_id) VALUES (c_nombre, c_provincia_id);
        SET v_id = LAST_INSERT_ID(); -- Obtener el ID generado
    END IF;

    SET c_ciudad_id = v_id;
END //
DELIMITER ;
