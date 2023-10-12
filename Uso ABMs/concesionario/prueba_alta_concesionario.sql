-- Variables para almacenar los valores de salida
SET @out_concesionario_id = 0;
SET @out_mensaje = '';

-- Llamada al procedimiento almacenado
CALL AltaDireccionYConcesionario(
    'Argentina', -- Nombre del país
    'ARG',       -- Código ISO del país
    'Buenos Aires', -- Nombre de la provincia
    'La Plata',  -- Nombre de la ciudad
    'Calle 50',  -- Calle
    '1234',      -- Número
    '1900',      -- Código postal
    'Concesionario La Plata', -- Nombre del concesionario
    'contacto@concesionariolaplata.com', -- Email del concesionario
    '221-123-4567', -- Teléfono del concesionario
    @out_concesionario_id, -- Variable para almacenar el ID del concesionario
    @out_mensaje           -- Variable para almacenar el mensaje de salida
);

-- Ver los resultados
SELECT @out_concesionario_id AS ConcesionarioID, @out_mensaje AS Mensaje;


