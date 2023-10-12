DROP FUNCTION IF EXISTS estacion_estaVacia_fn;

DELIMITER //
CREATE FUNCTION estacion_estaVacia_fn(
	estacion_id VARCHAR(45)
)
RETURNS BIT(1) READS SQL DATA
BEGIN
	DECLARE estaVacia BIT(1);
    DECLARE ultimoEgreso DATETIME;
	
    SELECT ve.fecha_hora_egreso INTO ultimoEgreso FROM vehiculo_en_estacion ve
    WHERE ve.estacion_estacion_id = estacion_id
    ORDER BY ve.fecha_hora_ingreso DESC
    LIMIT 1;
    
    IF ultimoEgreso IS NULL THEN
		SET estaVacia = 1;
	ELSE
		SET estaVacia = 0;
	END IF;
    
    
    RETURN estaVacia;
END //
DELIMITER ;