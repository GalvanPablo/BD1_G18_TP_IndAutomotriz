DELIMITER //

CREATE PROCEDURE BajaInsumo (
    IN p_insumo_id INT UNSIGNED,
    OUT nResultado INT,
    OUT cMensaje VARCHAR(255)
)
BEGIN
    -- Inicializar variables de salida
    SET nResultado = 0;
    SET cMensaje = '';

    -- Iniciar una transacción
    START TRANSACTION;

    -- Verificar si el insumo existe y no está dado de baja
    IF NOT EXISTS (
        SELECT 1
        FROM bd1_ind_automotriz.insumo
        WHERE insumo_id = p_insumo_id
        AND baja = 0
    ) THEN
        SET nResultado = -1;
        SET cMensaje = 'Error: El insumo con el ID especificado no existe o ya está dado de baja.';
    ELSE
        -- Dar de baja lógica al insumo
        UPDATE bd1_ind_automotriz.insumo
        SET baja = 1
        WHERE insumo_id = p_insumo_id
        AND baja = 0;

        -- Verificar si la operación fue exitosa
        IF ROW_COUNT() = 0 THEN
            SET nResultado = -2;
            SET cMensaje = 'Error: No se pudo dar de baja al insumo. Verifique los datos proporcionados.';
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
