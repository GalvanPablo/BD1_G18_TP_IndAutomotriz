USE bd1_ind_automotriz;

-- Variables para almacenar los valores de salida
SET @out_concesionario_id = 0;
SET @out_mensaje = '';

-- Llamada al procedimiento para insertar la dirección
CALL direccion_alta_sp(
    'Calle San Martín',     -- Calle
    '1234',                 -- Número
    '50000',                -- Código postal
    'La Plata',             -- Nombre de la ciudad
    'Córdoba',              -- Nombre de la provincia
    'Argentina',            -- Nombre del país
    @out_direccion_id		-- Variable para almacenar el ID de dirección
);

-- Llamada al procedimiento almacenado para insertar la dirección y concesionario
CALL AltaConcesionario(
    'Autos del Centro',                       -- Nombre del concesionario
    'info@autosdelcentro.com.ar',             -- Email del concesionario
    '0223-444-5678',                          -- Teléfono del concesionario
    @out_direccion_id, -- Utiliza el valor de @out_direccion_id
    @out_concesionario_id, -- Variable para almacenar el ID de concesionario
    @out_mensaje -- Variable para almacenar el mensaje de salida
);

-- Llamada al procedimiento para insertar la dirección
CALL direccion_alta_sp(
    'Calle 50',      -- Calle
    '1234',          -- Número
    '1900',          -- Código postal
    'La Plata',      -- Nombre de la ciudad
    'Buenos Aires',  -- Nombre de la provincia
    'Argentina',     -- Nombre del país
    @out_direccion_id		-- Variable para almacenar el ID de dirección
);

-- Llamada al procedimiento almacenado para insertar la dirección y concesionario
CALL AltaConcesionario(
    'Concesionario La Plata',           -- Nombre del concesionario
    'contacto@concesionariolaplata.com', -- Email del concesionario
    '221-123-4567',                     -- Teléfono del concesionario
    @out_direccion_id,                  -- Utiliza el valor de @out_direccion_id
    @out_concesionario_id,              -- Variable para almacenar el ID del concesionario
    @out_mensaje                        -- Variable para almacenar el mensaje de salida
);

-- Llamada al procedimiento para insertar la dirección
CALL direccion_alta_sp(
    'Avenida Costanera',      -- Calle
    '567',                   -- Número
    '7600',                  -- Código postal
    'Mar del Plata',          -- Nombre de la ciudad
    'Buenos Aires',          -- Nombre de la provincia
    'Argentina',             -- Nombre del país
    @out_direccion_id		-- Variable para almacenar el ID de dirección
);

-- Llamada al procedimiento almacenado para insertar la dirección y concesionario
CALL AltaConcesionario(
    'Concesionario Costa',           -- Nombre del concesionario
    'ventas@concesionariocosta.com.ar', -- Email del concesionario
    '223-111-2222',                  -- Teléfono del concesionario
    @out_direccion_id,               -- Utiliza el valor de @out_direccion_id
    @out_concesionario_id,           -- Variable para almacenar el ID del concesionario
    @out_mensaje                     -- Variable para almacenar el mensaje de salida
);

-- Llamada al procedimiento para insertar la dirección
CALL direccion_alta_sp(
    'Calle 19',            -- Calle
    '876',                 -- Número
    '1900',                -- Código postal
    'La Plata',            -- Nombre de la ciudad
    'Buenos Aires',        -- Nombre de la provincia
    'Argentina',           -- Nombre del país
    @out_direccion_id       -- Variable para almacenar el ID de dirección
);

-- Llamada al procedimiento almacenado para insertar la dirección y concesionario
CALL AltaConcesionario(
    'Concesionario Automotriz del Sur',       -- Nombre del concesionario
    'ventas@concesionariosur.com.ar',         -- Email del concesionario
    '011-555-1234',                           -- Teléfono del concesionario
    @out_direccion_id,                       -- Utiliza el valor de @out_direccion_id
    @out_concesionario_id,                   -- Variable para almacenar el ID del concesionario
    @out_mensaje                             -- Variable para almacenar el mensaje de salida
);

-- Llamada al procedimiento para insertar la dirección
CALL direccion_alta_sp(
    'Avenida 9 de Julio',    -- Calle
    '789',                   -- Número
    '4000',                  -- Código postal
    'San Miguel de Tucumán', -- Nombre de la ciudad
    'Tucumán',               -- Nombre de la provincia
    'Argentina',             -- Nombre del país
    @out_direccion_id       -- Variable para almacenar el ID de dirección
);

-- Llamada al procedimiento almacenado para insertar la dirección y concesionario
CALL AltaConcesionario(
    'Motor Group Argentina',                  -- Nombre del concesionario
    'ventas@motorgroup.com.ar',               -- Email del concesionario
    '011-777-9876',                           -- Teléfono del concesionario
    @out_direccion_id,                       -- Utiliza el valor de @out_direccion_id
    @out_concesionario_id,                   -- Variable para almacenar el ID del concesionario
    @out_mensaje                             -- Variable para almacenar el mensaje de salida
);

-- Llamada al procedimiento para insertar la dirección
CALL direccion_alta_sp(
    'Calle San Juan',        -- Calle
    '456',                   -- Número
    '5500',                  -- Código postal
    'Mendoza Capital',       -- Nombre de la ciudad
    'Mendoza',               -- Nombre de la provincia
    'Argentina',             -- Nombre del país
    @out_direccion_id        -- Variable para almacenar el ID de dirección
);

-- Llamada al procedimiento almacenado para insertar la dirección y concesionario
CALL AltaConcesionario(
    'Auto Uno Argentina',                     -- Nombre del concesionario
    'atencionclientes@autouno.com.ar',       -- Email del concesionario
    '0351-888-3456',                          -- Teléfono del concesionario
    @out_direccion_id,                       -- Utiliza el valor de @out_direccion_id
    @out_concesionario_id,                   -- Variable para almacenar el ID del concesionario
    @out_mensaje                             -- Variable para almacenar el mensaje de salida
);

-- Llamada al procedimiento para insertar la dirección
CALL direccion_alta_sp(
    'Calle Caseros',         -- Calle
    '321',                   -- Número
    '4400',                  -- Código postal
    'Salta Capital',         -- Nombre de la ciudad
    'Salta',                 -- Nombre de la provincia
    'Argentina',             -- Nombre del país
    @out_direccion_id        -- Variable para almacenar el ID de dirección
);

-- Llamada al procedimiento almacenado para insertar la dirección y concesionario
CALL AltaConcesionario(
    'Vehículos del Norte',                   -- Nombre del concesionario
    'contacto@vehiculosdelnorte.com.ar',     -- Email del concesionario
    '0387-666-2345',                          -- Teléfono del concesionario
    @out_direccion_id,                       -- Utiliza el valor de @out_direccion_id
    @out_concesionario_id,                   -- Variable para almacenar el ID del concesionario
    @out_mensaje                             -- Variable para almacenar el mensaje de salida
);

-- Llamada al procedimiento para insertar la dirección
CALL direccion_alta_sp(
    'Avenida Pellegrini',     -- Calle
    '789',                    -- Número
    '2000',                   -- Código postal
    'Rosario',                -- Nombre de la ciudad
    'Santa Fe',               -- Nombre de la provincia
    'Argentina',              -- Nombre del país
    @out_direccion_id          -- Variable para almacenar el ID de dirección
);

-- Llamada al procedimiento almacenado para insertar la dirección y concesionario
CALL AltaConcesionario(
    'Autos Deli Sur',                        -- Nombre del concesionario
    'contacto@autosdelisur.com.ar',          -- Email del concesionario
    '011-444-5678',                           -- Teléfono del concesionario
    @out_direccion_id,                       -- Utiliza el valor de @out_direccion_id
    @out_concesionario_id,                   -- Variable para almacenar el ID del concesionario
    @out_mensaje                             -- Variable para almacenar el mensaje de salida
);

-- Llamada al procedimiento para insertar la dirección
CALL direccion_alta_sp(
    'Calle San Martín',     -- Calle
    '123',                  -- Número
    '5000',                 -- Código postal
    'Córdoba Capital',      -- Nombre de la ciudad
    'Córdoba',              -- Nombre de la provincia
    'Argentina',            -- Nombre del país
    @out_direccion_id		-- Variable para almacenar el ID de dirección
);

-- Llamada al procedimiento almacenado para insertar la dirección y concesionario
CALL AltaConcesionario(
    'AutoVentas Gold Argentina',              -- Nombre del concesionario
    'info@autoventasgoldargentina.com.ar',    -- Email del concesionario
    '0223-555-7890',                          -- Teléfono del concesionario
    @out_direccion_id,                        -- Utiliza el valor de @out_direccion_id
    @out_concesionario_id,                    -- Variable para almacenar el ID del concesionario
    @out_mensaje                             -- Variable para almacenar el mensaje de salida
);

-- Llamada al procedimiento para insertar la dirección
CALL direccion_alta_sp(
    'Avenida Corrientes',     -- Calle
    '789',                  -- Número
    '1000',                 -- Código postal
    'Buenos Aires',          -- Nombre de la ciudad
    'Buenos Aires',         -- Nombre de la provincia
    'Argentina',            -- Nombre del país
    @out_direccion_id		-- Variable para almacenar el ID de dirección
);

-- Llamada al procedimiento almacenado para insertar la dirección y concesionario
CALL AltaConcesionario(
    'Autos y Motos',                          -- Nombre del concesionario
    'ventas@autosymotos.com.ar',             -- Email del concesionario
    '011-666-4321',                           -- Teléfono del concesionario
    @out_direccion_id,                        -- Utiliza el valor de @out_direccion_id
    @out_concesionario_id,                    -- Variable para almacenar el ID del concesionario
    @out_mensaje                             -- Variable para almacenar el mensaje de salida
);

-- Llamada al procedimiento para insertar la dirección
CALL direccion_alta_sp(
    'Avenida San Juan',     -- Calle
    '456',                 -- Número
    '5500',                -- Código postal
    'Mendoza Capital',     -- Nombre de la ciudad
    'Mendoza',             -- Nombre de la provincia
    'Argentina',           -- Nombre del país
    @out_direccion_id		-- Variable para almacenar el ID de dirección
);

-- Llamada al procedimiento almacenado para insertar la dirección y concesionario
CALL AltaConcesionario(
    'Autos y Física Toretto',                   -- Nombre del concesionario
    'info@autosyfisicatoretto.com.ar',         -- Email del concesionario
    '0351-777-8765',                          -- Teléfono del concesionario
    @out_direccion_id,                        -- Utiliza el valor de @out_direccion_id
    @out_concesionario_id,                    -- Variable para almacenar el ID del concesionario
    @out_mensaje                             -- Variable para almacenar el mensaje de salida
);

-- Ver los resultados
SELECT @out_concesionario_id AS ConcesionarioID, @out_mensaje AS Mensaje;
