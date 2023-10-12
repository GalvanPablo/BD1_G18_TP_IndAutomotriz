INSERT INTO marca (nombre, iso) VALUES ('Volkswagen', '0VW');
	SET @marca_id = LAST_INSERT_ID();
	INSERT INTO modelo (nombre, iso, marca_marca_id) VALUES ('Amarok', 'AMK', @marca_id);
		SET @modelo_id = LAST_INSERT_ID();
		INSERT INTO linea_montaje (modelo_modelo_id) VALUES (@modelo_id);
    INSERT INTO modelo (nombre, iso, marca_marca_id) VALUES ('Gol', 'GOL', @marca_id);
		SET @modelo_id = LAST_INSERT_ID();
		INSERT INTO linea_montaje (modelo_modelo_id) VALUES (@modelo_id);
    
INSERT INTO marca (nombre, iso) VALUES ('Ford', 'FOR');
SET @marca_id = LAST_INSERT_ID();
	INSERT INTO modelo (nombre, iso, marca_marca_id) VALUES ('Ranger', 'RAN', @marca_id);
		SET @modelo_id = LAST_INSERT_ID();
		INSERT INTO linea_montaje (modelo_modelo_id) VALUES (@modelo_id);
    INSERT INTO modelo (nombre, iso, marca_marca_id) VALUES ('Focus', 'FOC', @marca_id);
		SET @modelo_id = LAST_INSERT_ID();
		INSERT INTO linea_montaje (modelo_modelo_id) VALUES (@modelo_id);
    
INSERT INTO marca (nombre, iso) VALUES ('Toyota', 'TOY');
SET @marca_id = LAST_INSERT_ID();
	INSERT INTO modelo (nombre, iso, marca_marca_id) VALUES ('Hilux', 'HIL', @marca_id);
		SET @modelo_id = LAST_INSERT_ID();
		INSERT INTO linea_montaje (modelo_modelo_id) VALUES (@modelo_id);

INSERT INTO marca (nombre, iso) VALUES ('Fiat', 'FIA');
SET @marca_id = LAST_INSERT_ID();
	INSERT INTO modelo (nombre, iso, marca_marca_id) VALUES ('Cubo', 'CUB', @marca_id);
		SET @modelo_id = LAST_INSERT_ID();
		INSERT INTO linea_montaje (modelo_modelo_id) VALUES (@modelo_id);
    INSERT INTO modelo (nombre, iso, marca_marca_id) VALUES ('Cronos', 'CRO', @marca_id);
		SET @modelo_id = LAST_INSERT_ID();
		INSERT INTO linea_montaje (modelo_modelo_id) VALUES (@modelo_id);


SELECT ma.nombre AS Marca, ma.iso AS MarcaISO, mo.nombre AS Modelo, mo.iso AS ModeloISO
FROM modelo mo
LEFT JOIN marca ma ON ma.marca_id = mo.marca_marca_id
ORDER BY ma.nombre ASC;