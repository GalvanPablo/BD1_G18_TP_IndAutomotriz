DELIMITER //

CREATE PROCEDURE BajaDetallePedido (
    IN p_pedido_id INT UNSIGNED,
    IN p_modelo_id INT UNSIGNED,
    OUT nResultado INT,
    OUT cMensaje VARCHAR(255)
)
BEGIN
    -- Inicializar variables de salida
    SET nResultado = 0;
    SET cMensaje = '';

    -- Iniciar una transacción
    START TRANSACTION;

    -- Verificar si el detalle del pedido existe
    IF NOT EXISTS (
        SELECT 1
        FROM bd1_ind_automotriz.detalle_pedido
        WHERE pedido_pedido_id = p_pedido_id
        AND modelo_modelo_id = p_modelo_id
    ) THEN
        SET nResultado = -1;
        SET cMensaje = 'Error: El detalle del pedido especificado no existe.';
    ELSE
        -- Dar de baja lógica al detalle del pedido
        UPDATE bd1_ind_automotriz.detalle_pedido
        SET baja = 1
        WHERE pedido_pedido_id = p_pedido_id
        AND modelo_modelo_id = p_modelo_id;

        -- Verificar si la operación fue exitosa
        IF ROW_COUNT() = 0 THEN
            SET nResultado = -2;
            SET cMensaje = 'Error: No se pudo dar de baja el detalle del pedido. Verifique los datos proporcionados.';
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