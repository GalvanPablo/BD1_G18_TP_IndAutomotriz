DELIMITER //
CREATE PROCEDURE BajaConcesionario (
    IN p_concesionario_id INT UNSIGNED,
    OUT nResultado INT,
    OUT cMensaje VARCHAR(255)
)
BEGIN
    -- Inicializar variables de salida
    SET nResultado = 0;
    SET cMensaje = '';

    -- Iniciar una transacción
    START TRANSACTION;

    -- Verificar si el concesionario existe y está activo
    IF NOT EXISTS (
        SELECT 1
        FROM bd1_ind_automotriz.concesionario
        WHERE concesionario_id = p_concesionario_id
        AND baja = 0
    ) THEN
        SET nResultado = -1;
        SET cMensaje = 'Error: El concesionario con el ID especificado no existe o ya está dado de baja.';
    ELSE
        -- Dar de baja lógica al concesionario
        UPDATE bd1_ind_automotriz.concesionario
        SET baja = 1
        WHERE concesionario_id = p_concesionario_id
        AND baja = 0;

        -- Verificar si la operación fue exitosa
        IF ROW_COUNT() = 0 THEN
            SET nResultado = -2;
            SET cMensaje = 'Error: No se pudo dar de baja al concesionario. Verifique los datos proporcionados.';
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