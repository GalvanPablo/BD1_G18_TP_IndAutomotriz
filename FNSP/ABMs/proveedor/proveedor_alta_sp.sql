DROP PROCEDURE IF EXISTS proveedor_alta_sp;

DELIMITER //
CREATE PROCEDURE proveedor_alta_sp(
	-- Datos del proveedor
	IN p_nombre VARCHAR(45),
    IN p_mail VARCHAR(45),
    IN p_telefono VARCHAR(45),
    
    -- Datos de la direccion
    IN d_calle VARCHAR(45),
    IN d_numero VARCHAR(45),
    IN d_codigo_postal VARCHAR(45),
    IN d_ciudad_nombre VARCHAR(45),
    IN d_provincia_nombre VARCHAR(45),
    IN d_pais_nombre VARCHAR(45),
    
    -- Resultado
    OUT nResultado INT,
    OUT cMensaje VARCHAR(255)
)
BEGIN
	DECLARE p_id INT;
    SET nResultado = 0;
    
    IF p_nombre IS NULL THEN
		SET nResultado = -2;
        SET cMensaje = "El nombre del proveedor no puede ser nulo";
    END IF;
    IF p_mail IS NULL THEN
		SET nResultado = -2;
        SET cMensaje = "El mail del proveedor no puede ser nulo";
    END IF;
    IF p_telefono IS NULL THEN
		SET nResultado = -2;
        SET cMensaje = "El telefono del proveedor no puede ser nulo";
    END IF;
    IF d_calle IS NULL THEN
		SET nResultado = -2;
        SET cMensaje = "La calle del proveedor no puede ser nula";
    END IF;
    IF d_numero IS NULL THEN
		SET nResultado = -2;
        SET cMensaje = "La altura de la calle del proveedor no puede ser nula";
    END IF;
    IF d_ciudad_nombre IS NULL THEN
		SET nResultado = -2;
        SET cMensaje = "La ciudad del proveedor no puede ser nula";
    END IF;
    IF d_provincia_nombre IS NULL THEN
		SET nResultado = -2;
        SET cMensaje = "La provincia del proveedor no puede ser nula";
    END IF;
    IF d_pais_nombre IS NULL THEN
		SET nResultado = -2;
        SET cMensaje = "El país del proveedor no puede ser nulo";
    END IF;
    
    IF nResultado = 0 THEN		-- Si no hay errores 
		SELECT proveedor_id INTO p_id FROM proveedor WHERE nombre LIKE p_nombre;	-- Consulto si existe un proveedor con el mismo nombre
        
		IF p_id IS NOT NULL THEN	-- Si existe
			SET nResultado = -1;
			SET cMensaje = CONCAT("Ya existe un proveedor con el nombre '", p_nombre, "'");
		ELSE	-- Si no existe
			CALL direccion_alta_sp(d_calle, d_numero, d_codigo_postal, d_ciudad_nombre, d_provincia_nombre, d_pais_nombre, @d_id);	-- Creo la dirección
			IF @d_id IS NULL THEN	-- Si no se pudo dar de alta la dirección
				SET nResultado = -3;
				SET cMensaje = "Error al dar de alta la dirección";
			ELSE	-- Si ya esta disponible la dirección
				INSERT INTO proveedor (nombre, mail, telefono, direccion_direccion_id)	-- Inserto el nuevo proveedor
				VALUES (p_nombre, p_mail, p_telefono, @d_id);
				
				SET p_id = LAST_INSERT_ID();	-- Obtengo el ID del Nuevo Proveedor
				
				IF p_id IS NULL THEN	-- Si no tengo un ID es que no se pudo insertar
					SET nResultado = -4;
					SET cMensaje = "Error al dar de alta a el nuevo proveedor";
				END IF;
			END IF;
		END IF;
	END IF;
END //
DELIMITER ;

-- Nomenclatura de COD ERROR
-- 0 Todo bien
-- -1 Duplicado/Existente
-- -2 Hay algo que es NULO y no puede serlo
-- -3 Error de dependencia (en este caso el alta de la dirección)
-- -4 Error desconocido