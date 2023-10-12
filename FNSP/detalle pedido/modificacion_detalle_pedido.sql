DELIMITER //

CREATE PROCEDURE ModificarDetallePedido (
    IN p_pedido_id INT UNSIGNED,
    IN p_modelo_id INT UNSIGNED,
    IN p_cantidad INT,
    IN p_precio DECIMAL(10, 2),
    OUT nResultado INT,
    OUT cMensaje VARCHAR(255)
)
BEGIN
    -- Declarar variables al inicio del bloque
    DECLARE v_detalle_pedido_id INT UNSIGNED;

    -- Inicializar variables de salida
    SET nResultado = 0;
    SET cMensaje = '';

    -- Iniciar una transacción
    START TRANSACTION;

    -- Obtener el ID del detalle del pedido
    SELECT pedido_pedido_id INTO v_detalle_pedido_id
    FROM bd1_ind_automotriz.detalle_pedido
    WHERE pedido_pedido_id = p_pedido_id
    AND modelo_modelo_id = p_modelo_id;

    -- Si no se encuentra el detalle del pedido, establecer el mensaje de error
    IF v_detalle_pedido_id IS NULL THEN
        SET nResultado = -1;
        SET cMensaje = 'Error: El detalle del pedido especificado no existe.';
    ELSE
        -- Modificar el detalle del pedido
        UPDATE bd1_ind_automotriz.detalle_pedido
        SET
            cantidad = p_cantidad,
            precio = p_precio
        WHERE
            pedido_pedido_id = p_pedido_id
            AND modelo_modelo_id = p_modelo_id;

        -- Si ninguna fila fue afectada en la actualización, establecer el mensaje de error
        IF ROW_COUNT() = 0 THEN
            SET nResultado = -2;
            SET cMensaje = 'Error: No se pudo modificar el detalle del pedido. Verifique los datos proporcionados.';
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
