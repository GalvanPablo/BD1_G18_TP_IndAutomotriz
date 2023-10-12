
DELIMITER //

-- Crear procedimiento almacenado para dar de alta una dirección y un concesionario
CREATE PROCEDURE AltaDireccionYConcesionario (
    IN p_nombre_pais VARCHAR(45),
    IN p_codigo_iso VARCHAR(3),
    IN p_nombre_provincia VARCHAR(45),
    IN p_nombre_ciudad VARCHAR(45),
    IN p_calle VARCHAR(45),
    IN p_numero VARCHAR(45),
    IN p_codigo_postal VARCHAR(45),
    IN p_nombre_concesionario VARCHAR(45),
    IN p_mail_concesionario VARCHAR(45),
    IN p_telefono_concesionario VARCHAR(45),
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

    -- Verificar si el país ya existe
    IF EXISTS (SELECT 1 FROM bd1_ind_automotriz.pais WHERE nombre = p_nombre_pais OR codigo_iso = p_codigo_iso) THEN
        SET cMensaje = 'Error: El país con ese nombre o código ISO ya existe.';
        SET done = 1;
    END IF;

    IF NOT done THEN
        -- Insertar país
        INSERT INTO bd1_ind_automotriz.pais (nombre, codigo_iso)
        VALUES (p_nombre_pais, p_codigo_iso);

        -- Obtener ID del país insertado
        SET @pais_id = LAST_INSERT_ID();
    END IF;

    IF NOT done THEN
        -- Verificar si la provincia ya existe
        IF EXISTS (SELECT 1 FROM bd1_ind_automotriz.provincia WHERE nombre = p_nombre_provincia AND pais_pais_id = @pais_id) THEN
            SET cMensaje = 'Error: La provincia con ese nombre ya existe en el país especificado.';
            SET done = 1;
        ELSE
            -- Insertar provincia
            INSERT INTO bd1_ind_automotriz.provincia (nombre, pais_pais_id)
            VALUES (p_nombre_provincia, @pais_id);

            -- Obtener ID de la provincia insertada
            SET @provincia_id = LAST_INSERT_ID();
        END IF;
    END IF;

    IF NOT done THEN
        -- Verificar si la ciudad ya existe
        IF EXISTS (SELECT 1 FROM bd1_ind_automotriz.ciudad WHERE nombre = p_nombre_ciudad AND provincia_provincia_id = @provincia_id) THEN
            SET cMensaje = 'Error: La ciudad con ese nombre ya existe en la provincia especificada.';
            SET done = 1;
        ELSE
            -- Insertar ciudad
            INSERT INTO bd1_ind_automotriz.ciudad (nombre, provincia_provincia_id)
            VALUES (p_nombre_ciudad, @provincia_id);

            -- Obtener ID de la ciudad insertada
            SET @ciudad_id = LAST_INSERT_ID();
        END IF;
    END IF;

    IF NOT done THEN
        -- Verificar si la dirección ya existe
        IF EXISTS (SELECT 1 FROM bd1_ind_automotriz.direccion WHERE calle = p_calle AND numero = p_numero AND ciudad_ciudad_id = @ciudad_id) THEN
            SET cMensaje = 'Error: La dirección con esa calle y número ya existe en la ciudad especificada.';
            SET done = 1;
        ELSE
            -- Insertar dirección
            INSERT INTO bd1_ind_automotriz.direccion (calle, numero, codigo_postal, ciudad_ciudad_id)
            VALUES (p_calle, p_numero, p_codigo_postal, @ciudad_id);
            
            SET @direccion_id = LAST_INSERT_ID();
        END IF;
    END IF;

    IF NOT done THEN
        -- Verificar si el concesionario ya existe
        IF EXISTS (
            SELECT 1 
            FROM bd1_ind_automotriz.concesionario 
            WHERE nombre = p_nombre_concesionario 
            OR mail = p_mail_concesionario 
            OR telefono = p_telefono_concesionario 
            OR direccion_direccion_id = @direccion_id
        ) THEN
            SET cMensaje = 'Error: El concesionario con ese nombre, email, teléfono o dirección ya existe.';
            SET done = 1;
        ELSE
            -- Insertar concesionario
            INSERT INTO bd1_ind_automotriz.concesionario (
                nombre, 
                mail, 
                telefono, 
                direccion_direccion_id
            )
            VALUES (
                p_nombre_concesionario, 
                p_mail_concesionario, 
                p_telefono_concesionario, 
                @direccion_id
            );

            -- Obtener ID del concesionario insertado
            SET p_concesionario_id = LAST_INSERT_ID();
        END IF;
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