DROP FUNCTION IF EXISTS generar_nro_chasis_fn;

DELIMITER //
CREATE FUNCTION generar_nro_chasis_fn(
	modelo_id INT
)
RETURNS VARCHAR(45) READS SQL DATA
BEGIN
	DECLARE ma_iso VARCHAR(3);
    DECLARE mo_iso VARCHAR(3);
    DECLARE nro INT UNSIGNED;
    DECLARE ultimo_nro INT UNSIGNED;
	
    # Obtengo el ISO del Modelo
    SELECT mo.iso INTO mo_iso FROM modelo mo
    WHERE mo.modelo_id = modelo_id;
    
    # Si obtuve el ISO significa que tambien existe el modelo, por lo tanto prosigo
    # en el caso que no existe el modelo el nro_chasis sera NULL
    IF mo_iso IS NOT NULL THEN
		# Obtengo el ISO de la Marca
		SELECT ma.iso INTO ma_iso FROM modelo mo
		LEFT JOIN marca ma ON ma.marca_id = mo.marca_marca_id
		WHERE mo.modelo_id = modelo_id;
		
        # Obtengo el ultimo Nro de chasis, si es que lo hubo, del modelo correspondiente
		SELECT CAST(SUBSTRING_INDEX(v.nro_chasis, '-', -1) AS UNSIGNED) INTO ultimo_nro FROM vehiculo v
		WHERE v.modelo_modelo_id = modelo_id
		ORDER BY v.vehiculo_id DESC
		LIMIT 1;
		
		SET nro = 1;	# Por defecto el Nro es 0000000001
        
        # Si ya se emitio un Nro
		IF ultimo_nro IS NOT NULL THEN
			SET nro =  ultimo_nro + 1;	# Se le incrementa
		END IF;
    END IF;
	
    # Devuelvo el nuevo Nro_chasis, si no se encontro modelo este es NULL
    # Digitos	Denominacion
    # 		3	ISO Marca
    #		3	ISO Modelo
    #		1	'-' (guión)
    # 	   15	Nro de serie
    # Total 17 digitos
	RETURN CONCAT(ma_iso, mo_iso, "-", LPAD(nro, 15, '0'));
END //
DELIMITER ;