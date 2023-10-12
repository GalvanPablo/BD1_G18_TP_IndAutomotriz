
DELIMITER //

-- Modificar procedimiento almacenado para dar de alta un concesionario
CREATE PROCEDURE AltaConcesionario (
    IN p_nombre_concesionario VARCHAR(45),
    IN p_mail_concesionario VARCHAR(45),
    IN p_telefono_concesionario VARCHAR(45),
    IN p_direccion_id INT UNSIGNED, -- Nueva entrada para la dirección_id
    OUT p_concesionario_id INT UNSIGNED,
    OUT cMensaje VARCHAR(255)
)
BEGIN
    -- Declarar una condición para salir
    DECLARE done INT DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- ROLLBACK en caso de error
        ROLLBACK;
        SET cMensaje = 'Error: Ocurrió una excepción SQL. Revise los datos ingresados y vuelva a intentarlo.';
        SET done = 1;
    END;

    -- Iniciar una transacción
    START TRANSACTION;

    -- Verificar si el concesionario ya existe
    IF EXISTS (
        SELECT 1 
        FROM bd1_ind_automotriz.concesionario 
        WHERE nombre = p_nombre_concesionario 
        OR mail = p_mail_concesionario 
        OR telefono = p_telefono_concesionario
    ) THEN
        SET cMensaje = 'Error: El concesionario con ese nombre, email o teléfono ya existe.';
        SET done = 1;
    ELSE
        -- Insertar concesionario
        INSERT INTO bd1_ind_automotriz.concesionario (
            nombre, 
            mail, 
            telefono,
            direccion_direccion_id -- Asignar la dirección_id
        )
        VALUES (
            p_nombre_concesionario, 
            p_mail_concesionario, 
            p_telefono_concesionario,
            p_direccion_id -- Utilizar el valor proporcionado como dirección_id
        );

        -- Obtener ID del concesionario insertado
        SET p_concesionario_id = LAST_INSERT_ID();
    END IF;

    -- Commit de la transacción si no hay errores
    IF NOT done THEN
        COMMIT;
        -- Establecer mensaje de éxito
        SET cMensaje = '';
    END IF;

END;
//
DELIMITER ;
