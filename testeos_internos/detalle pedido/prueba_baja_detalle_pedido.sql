-- Variables para almacenar los resultados
SET @nResultado := 0;
SET @cMensaje := '';

-- Llamada al procedimiento almacenado para dar de baja un detalle de pedido
CALL BajaDetallePedido(1, 2, @nResultado, @cMensaje);  -- Suponiendo que 1 es el ID del pedido y 2 es el ID del modelo a dar de baja

-- Ver los resultados
SELECT @nResultado AS nResultado, @cMensaje AS cMensaje;
