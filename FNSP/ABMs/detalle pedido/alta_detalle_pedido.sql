DELIMITER //

-- Crear procedimiento almacenado para dar de alta detalles de pedido
CREATE PROCEDURE AltaDetallePedido (
    IN p_pedido_id INT UNSIGNED,
    IN p_modelo_id INT UNSIGNED,
    IN p_cantidad INT UNSIGNED,
    IN p_precio DECIMAL(10, 2),
    OUT p_detalle_pedido_id INT UNSIGNED,
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

    -- Verificar si el pedido existe
    IF NOT EXISTS (SELECT 1 FROM bd1_ind_automotriz.pedido WHERE pedido_id = p_pedido_id) THEN
        SET cMensaje = 'Error: El pedido especificado no existe.';
        SET done = 1;
    END IF;

    -- Verificar si el modelo existe
    IF NOT EXISTS (SELECT 1 FROM bd1_ind_automotriz.modelo WHERE modelo_id = p_modelo_id) THEN
        SET cMensaje = 'Error: El modelo especificado no existe.';
        SET done = 1;
    END IF;

    IF NOT done THEN
        -- Insertar detalle de pedido
        INSERT INTO bd1_ind_automotriz.detalle_pedido (pedido_pedido_id, modelo_modelo_id, cantidad, precio)
        VALUES (p_pedido_id, p_modelo_id, p_cantidad, p_precio);

        -- Obtener ID del detalle de pedido insertado
        SET p_detalle_pedido_id = LAST_INSERT_ID();
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
