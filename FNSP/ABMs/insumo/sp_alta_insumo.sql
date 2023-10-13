DELIMITER //

-- Crear procedimiento almacenado para dar de alta un insumo
CREATE PROCEDURE AgregarInsumo(
    IN p_nombre VARCHAR(45),
    OUT p_insumo_id INT UNSIGNED,
    OUT cMensaje VARCHAR(255)
)
BEGIN
-- Declarar una condición para salir
    DECLARE done INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    -- ROLLBACK en caso de error
        ROLLBACK;
        SET cMensaje = 'Error: Ocurrió una excepción SQL. Revise los datos ingresados y vuelva a intentarlo.';
    END;

    -- Iniciar una transacción
    START TRANSACTION;

    -- Verificar si el insumo ya existe
    IF EXISTS (SELECT 1 FROM `bd1_ind_automotriz`.`insumo` WHERE `nombre` = p_nombre) THEN
        SET cMensaje = 'Error: El insumo con ese nombre ya existe.';
        SET done = 1;
    ELSE
        -- Insertar el nuevo insumo
        INSERT INTO `bd1_ind_automotriz`.`insumo` (`nombre`) VALUES (p_nombre);
        
        -- Obtener el ID del insumo insertado
        SET p_insumo_id = LAST_INSERT_ID();
    END IF;

    -- Commit de la transacción si no hay errores
    IF NOT done THEN
        COMMIT;
        SET cMensaje = '';
    ELSE
        ROLLBACK;
    END IF;
END //

DELIMITER ;
