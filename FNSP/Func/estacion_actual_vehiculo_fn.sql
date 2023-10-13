DROP FUNCTION IF EXISTS estacion_actual_vehiculo_fn;

##############################################################################
####### FALTA TESTEAR ########################################################
##############################################################################

DELIMITER //
CREATE FUNCTION estacion_actual_vehiculo_fn(
	nro_chasis VARCHAR(45)
)
RETURNS INT READS SQL DATA
BEGIN
	DECLARE vehiculo_id INT DEFAULT -2;
	DECLARE estacion_id INT;
    DECLARE fecha_hora_egreso DATETIME
    
    # Obtengo el ID vehiculo
    SELECT v.vehiculo_id INTO vehiculo_id FROM vehiculo v WHERE v.nro_chasis = nro_chasis;
    
    # Si no es NULL es que existe, y puede que este en una estación
    IF vehiculo_id IS NOT NULL THEN
		# Obtengo la ultima estación en la que estuvo el vehiculo
        SELECT ve.estacion_id, ve.fecha_hora_egreso INTO estacion_id, fecha_hora_egreso FROM vehiculo_en_estacion ve
        WHERE ve.vehiculo_vehiculo_id = vehiculo_id
        ORDER BY ve.fecha_hora_ingreso DESC
        LIMIT 1;

        IF estacion_id IS NULL THEN
            # Nunca entro a producción
            SET estacion_id = -1;
        ELSE
            IF fecha_hora_egreso IS NOT NULL THEN
                # El vehiculo esta terminado
                SET estacion_id = 0
            END IF
        END IF;
    END IF;

    # Posibles valores de salida
    # -2 El vehiculo no existe
    # -1 El vehiculo nunca entro a producción
    # 0 El vehiculo esta terminado
    # estacion_id > 0 El vehiculo esta en alguna estacion

    RETURN estacion_id;
END //
DELIMITER ;