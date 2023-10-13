DROP PROCEDURE IF EXISTS avanzar_produccion_vehiculo_sp;

DELIMITER //
CREATE PROCEDURE avanzar_produccion_vehiculo_sp(
	IN nro_chasis VARCHAR(45),
    
    OUT nResultado INT,
    OUT cMensaje VARCHAR(256)
)
BEGIN
	DECLARE vehiculo_id INT;
	DECLARE estacion_actual INT;
    DECLARE id_siguiente_estacion_linea INT;
    DECLARE id_ultima_estacion_linea INT;
    
    SET nResultado = 0;
    
	IF nro_chasis IS NULL THEN
		SET nResultado = -1;
        SET cMensaje = "El nro_chasis no puede ser nulo";
    END IF;
    
    SELECT v.vehiculo_id INTO vehiculo_id FROM vehiculo v WHERE v.nro_chasis = nro_chasis;
    
    IF vehiculo_id IS NULL THEN
		SET nResultado = -2;
        SET cMensaje = CONCAT("No se ha encontrado el vehiculo con el nro_chasis ", nro_chasis);
    END IF;
    
    IF nResultado = 0 THEN
		SET estacion_actual = estacion_actual_vehiculo_fn(nro_chasis);
        
        IF estacion_actual > 0 THEN
        
			# Obtengo la ID de la ultima estacion de la linea
			SELECT e.estacion_id INTO id_ultima_estacion_linea FROM estacion e
			LEFT JOIN linea_montaje le ON le.linea_montaje_id = e.linea_montaje_linea_montaje_id
			LEFT JOIN modelo m ON m.modelo_id = le.modelo_modelo_id
			LEFT JOIN vehiculo v ON v.modelo_modelo_id = m.modelo_id
			WHERE v.vehiculo_id = 1
			ORDER BY e.orden DESC
			LIMIT 1;
            
            # Si se encuentra en la ultima estacion
            IF estacion_actual = id_ultima_estacion_linea THEN
                UPDATE vehiculo_en_estacion ve
					SET fecha_hora_egreso = NOW()
					WHERE ve.vehiculo_vehiculo_id = vehiculo_id AND ve.estacion_estacion_id = estacion_actual;
                SET cMensaje = "El vehiculo termino su producción";
            ELSE
				# Buscar la estacion siguiente
				SELECT e.estacion_id INTO id_siguiente_estacion_linea FROM estacion e
				LEFT JOIN linea_montaje le ON le.linea_montaje_id = e.linea_montaje_linea_montaje_id
				LEFT JOIN modelo m ON m.modelo_id = le.modelo_modelo_id
				LEFT JOIN vehiculo v ON v.modelo_modelo_id = m.modelo_id
				WHERE
					v.vehiculo_id = vehiculo_id
					AND (SELECT e.orden FROM estacion e WHERE e.estacion_id = estacion_actual) < e.orden
				ORDER BY e.orden ASC
				LIMIT 1;
                
                # Si la siguiente estacion esta libre
                IF estacion_estaVacia_fn(id_siguiente_estacion_linea) = 1 THEN
					# Actualizar la estacion actual diciendo que la abandono (seteando la hora de salida)
					UPDATE vehiculo_en_estacion ve
						SET fecha_hora_egreso = NOW()
						WHERE ve.vehiculo_vehiculo_id = vehiculo_id AND ve.estacion_estacion_id = estacion_actual;
					
					# 
					INSERT INTO vehiculo_en_estacion (vehiculo_vehiculo_id, estacion_estacion_id, fecha_hora_ingreso)
						VALUES (vehiculo_id,id_siguiente_estacion_linea,NOW());
					SET cMensaje = CONCAT("El vehiculo avanza a la estacion: ", id_siguiente_estacion_linea);
                    
				ELSE
					SET nResultado = -3;
					SET cMensaje = "La siguiente estacion esta ocupada";
				END IF;
                
            END IF;
            
        END IF;
        
	END IF;
END //
DELIMITER ;
