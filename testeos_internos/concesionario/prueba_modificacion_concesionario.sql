-- Variables para almacenar los resultados
SET @resultado := 0;
SET @mensaje := '';

-- Suponiendo que el ID del concesionario que deseas modificar es 1
SET @concesionario_id := 2;  

-- Nuevos datos para el concesionario y su dirección
SET @nuevo_nombre_concesionario := 'Concesionario Modificado';
SET @nuevo_mail_concesionario := 'nuevo_email@ejemplo.com';
SET @nuevo_telefono_concesionario := '1234567890';
SET @nueva_calle := 'Nueva Calle';
SET @nuevo_numero := '123';
SET @nuevo_codigo_postal := '456789';

-- Llamar al procedimiento almacenado
CALL ModificarConcesionarioYDireccion(
    @concesionario_id,
    @nuevo_nombre_concesionario,
    @nuevo_mail_concesionario,
    @nuevo_telefono_concesionario,
    @nueva_calle,
    @nuevo_numero,
    @nuevo_codigo_postal,
    @resultado,
    @mensaje
);

-- Mostrar el resultado y el mensaje
SELECT @resultado AS resultado, @mensaje AS mensaje;