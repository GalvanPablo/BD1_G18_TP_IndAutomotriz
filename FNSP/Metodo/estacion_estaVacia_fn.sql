DROP FUNCTION IF EXISTS estacion_estaVacia_fn;

DELIMITER //
CREATE FUNCTION estacion_estaVacia_fn(
	estacion_id INT
)
RETURNS INT READS SQL DATA
BEGIN
	DECLARE estaVacia INT;
    DECLARE ultimoIngreso DATETIME;
    DECLARE ultimoEgreso DATETIME;
	
    #Obtengo el registro del ultimo ingreso de la estación
    SELECT ve.fecha_hora_ingreso, ve.fecha_hora_egreso INTO ultimoIngreso, ultimoEgreso FROM vehiculo_en_estacion ve
    WHERE ve.estacion_estacion_id = estacion_id
    ORDER BY ve.fecha_hora_ingreso DESC
    LIMIT 1;
    
    #Compruebo si en ese ultimo registro existe una fecha/hora de salida
    IF ultimoIngreso IS NOT NULL AND ultimoEgreso IS NULL THEN
		SET estaVacia = 0; #No esta vacia ya que no tiene hora de salida
	ELSE
		SET estaVacia = 1; #Si esta vacia
	END IF;
    
    
    RETURN estaVacia;
END //
DELIMITER ;