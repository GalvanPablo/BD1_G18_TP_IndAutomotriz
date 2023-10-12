DROP PROCEDURE IF EXISTS direccion_alta_sp;

DELIMITER //
CREATE PROCEDURE direccion_alta_sp(
    IN d_calle VARCHAR(45),
    IN d_numero VARCHAR(45),
    IN d_codigo_postal VARCHAR(45),
    IN c_ciudad_nombre VARCHAR(45),
    IN p_provincia_nombre VARCHAR(45),
    IN p_pais_nombre VARCHAR(45),
    OUT d_direccion_id INT
)
BEGIN
    DECLARE v_pais_id INT;
    DECLARE v_provincia_id INT;
    DECLARE v_ciudad_id INT;

    -- Llamar al procedimiento almacenado para insertar un país y obtener su ID
    CALL pais_alta_sp(p_pais_nombre, NULL, @v_pais_id);

    -- Llamar al procedimiento almacenado para insertar una provincia
    CALL provincia_alta_sp(p_provincia_nombre, @v_pais_id, @v_provincia_id);

    -- Llamar al procedimiento almacenado para insertar una ciudad
    CALL ciudad_alta_sp(c_ciudad_nombre, @v_provincia_id, @v_ciudad_id);

    -- Insertar la dirección con la ciudad especificada
    INSERT INTO direccion (calle, numero, codigo_postal, ciudad_ciudad_id)
    VALUES (d_calle, d_numero, d_codigo_postal, @v_ciudad_id);
    
    -- Obtener el ID de la dirección recién insertada
    SET d_direccion_id = LAST_INSERT_ID();
END //
DELIMITER ;
