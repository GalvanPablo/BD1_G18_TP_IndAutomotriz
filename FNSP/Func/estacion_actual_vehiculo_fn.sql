DROP FUNCTION IF EXISTS estacion_actual_vehiculo_fn;

DELIMITER //
CREATE FUNCTION estacion_actual_vehiculo_fn(
	nro_chasis VARCHAR(45)
)
RETURNS INT READS SQL DATA
BEGIN
	DECLARE vehiculo_id INT;
	DECLARE estacion_id INT;
    
    # Obtengo el ID vehiculo
    SELECT v.vehiculo_id INTO vehiculo_id FROM vehiculo v WHERE v.nro_chasis = nro_chasis;
    
    # Si no es NULL es que existe, y puede que este en una estación
    IF vehiculo_id IS NOT NULL THEN
    
		# Obtengo la ultima estación en la que estuvo el vehiculo
        SELECT estacion_id INTO estacion_id FROM vehiculo_en_estacion ve
        WHERE ve.vehiculo_vehiculo_id = vehiculo_id
        ORDER BY ve.fecha_hora_ingreso DESC
        LIMIT 1;
        
        # Si la variable estacion_id queda nula es que el auto aun no esta en producción
        
    END IF;
    RETURN estacion_id;
END //
DELIMITER ;