DELIMITER //
CREATE PROCEDURE ModificarConcesionarioYDireccion (
    IN p_concesionario_id INT UNSIGNED,
    IN p_nombre_concesionario VARCHAR(45),
    IN p_mail_concesionario VARCHAR(45),
    IN p_telefono_concesionario VARCHAR(45),
    IN p_calle VARCHAR(45),
    IN p_numero VARCHAR(45),
    IN p_codigo_postal VARCHAR(45),
    OUT nResultado INT,
    OUT cMensaje VARCHAR(255)
)
BEGIN
    -- Declarar variables al inicio del bloque
    DECLARE v_direccion_id INT UNSIGNED;

    -- Inicializar variables de salida
    SET nResultado = 0;
    SET cMensaje = '';

    -- Iniciar una transacción
    START TRANSACTION;
    
    -- Obtener el ID de la dirección asociada al concesionario
    SELECT direccion_direccion_id INTO v_direccion_id
    FROM bd1_ind_automotriz.concesionario
    WHERE concesionario_id = p_concesionario_id
    AND baja = 0;  -- Asegurar que el concesionario está activo

    -- Si no se encuentra el concesionario o está inactivo, establecer el mensaje de error
    IF v_direccion_id IS NULL THEN
        SET nResultado = -1;
        SET cMensaje = 'Error: El concesionario con el ID especificado no existe o no está activo.';
    ELSE
        -- Modificar la dirección
        UPDATE bd1_ind_automotriz.direccion
        SET
            calle = p_calle,
            numero = p_numero,
            codigo_postal = p_codigo_postal
        WHERE
            direccion_id = v_direccion_id;
        
        -- Modificar el concesionario
        UPDATE bd1_ind_automotriz.concesionario
        SET
            nombre = p_nombre_concesionario,
            mail = p_mail_concesionario,
            telefono = p_telefono_concesionario
        WHERE
            concesionario_id = p_concesionario_id
            AND baja = 0;  -- Asegurar que el concesionario está activo
        
        -- Si ninguna fila fue afectada en ambas actualizaciones, establecer el mensaje de error
        IF ROW_COUNT() = 0 THEN
            SET nResultado = -2;
            SET cMensaje = 'Error: No se pudo modificar la dirección o el concesionario. Verifique los datos proporcionados.';
        END IF;
    END IF;

    -- Si se encontró un error, deshacer la transacción; de lo contrario, confirmar la transacción
    IF nResultado < 0 THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
    
END;
//
DELIMITER ;