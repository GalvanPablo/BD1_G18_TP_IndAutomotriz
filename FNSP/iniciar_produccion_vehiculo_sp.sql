DROP PROCEDURE IF EXISTS iniciar_produccion_vehiculo_sp;

DELIMITER //
CREATE PROCEDURE iniciar_produccion_vehiculo_sp(
	IN nro_chasis VARCHAR(45),
    
    OUT nResultado INT,
    OUT cMensaje VARCHAR(256)
)
BEGIN
	DECLARE vehiculo_id INT;
	DECLARE estacion_actual INT;
    DECLARE id_primera_estacion_linea INT;
    
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
        
        IF estacion_actual = -1 THEN
			SELECT e.estacion_id INTO id_primera_estacion_linea FROM estacion e
			LEFT JOIN linea_montaje le ON le.linea_montaje_id = e.linea_montaje_linea_montaje_id
			LEFT JOIN modelo m ON m.modelo_id = le.modelo_modelo_id
			LEFT JOIN vehiculo v ON v.modelo_modelo_id = m.modelo_id
			WHERE v.vehiculo_id = vehiculo_id
			ORDER BY e.orden ASC
			LIMIT 1;
            
            IF id_primera_estacion_linea IS NOT NULL THEN
				IF estacion_estaVacia_fn(id_primera_estacion_linea) = 1 THEN
					INSERT INTO vehiculo_en_estacion (vehiculo_vehiculo_id, estacion_estacion_id, fecha_hora_ingreso)
					VALUES (vehiculo_id,id_primera_estacion_linea,NOW());
					IF LAST_INSERT_ID() IS NULL THEN
						SET nResultado = -4;
						SET cMensaje = "No se ha podido poner en producción el vehiculo";
					END IF;
				ELSE
					SET nResultado = -5;
					SET cMensaje = CONCAT("La estacion se encuentra ocupada, por ende no es posible poner en produccion el vehiculo ", nro_chasis);
                END IF;
            
				
            ELSE
				SET nResultado = -3;
				SET cMensaje = CONCAT("El modelo de vehiculo no posee linea de montaje con estaciones asignadas", nro_chasis);
            END IF;
        END IF;
        
	END IF;
END //
DELIMITER ;
