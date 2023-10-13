SET @linea_montaje_id = 1;

# 1era Estación - CHASIS y CARROCERIA
INSERT INTO tarea (nombre) VALUES ('Chasis y carroceria');
SET @tarea_id = LAST_INSERT_ID();
INSERT INTO estacion (orden, linea_montaje_linea_montaje_id, tarea_tarea_id)
VALUES (1, @linea_montaje_id, @tarea_id);

# 2da Estación - PINTURA
INSERT INTO tarea (nombre) VALUES ('Pintura');
SET @tarea_id = LAST_INSERT_ID();
INSERT INTO estacion (orden, linea_montaje_linea_montaje_id, tarea_tarea_id)
VALUES (2, @linea_montaje_id, @tarea_id);

# 3ra Estación - TREN MOTRIZ
INSERT INTO tarea (nombre) VALUES ('Tren motriz');
SET @tarea_id = LAST_INSERT_ID();
INSERT INTO estacion (orden, linea_montaje_linea_montaje_id, tarea_tarea_id)
VALUES (3, @linea_montaje_id, @tarea_id);

# 3ra Estación - INTERIOR
INSERT INTO tarea (nombre) VALUES ('Interior');
SET @tarea_id = LAST_INSERT_ID();
INSERT INTO estacion (orden, linea_montaje_linea_montaje_id, tarea_tarea_id)
VALUES (4, @linea_montaje_id, @tarea_id);


SET @linea_montaje_id = 2;

# 1era Estación - CHASIS y CARROCERIA
INSERT INTO tarea (nombre) VALUES ('Chasis y carroceria');
SET @tarea_id = LAST_INSERT_ID();
INSERT INTO estacion (orden, linea_montaje_linea_montaje_id, tarea_tarea_id)
VALUES (1, @linea_montaje_id, @tarea_id);

# 2da Estación - PINTURA
INSERT INTO tarea (nombre) VALUES ('Pintura');
SET @tarea_id = LAST_INSERT_ID();
INSERT INTO estacion (orden, linea_montaje_linea_montaje_id, tarea_tarea_id)
VALUES (2, @linea_montaje_id, @tarea_id);

# 3ra Estación - TREN MOTRIZ
INSERT INTO tarea (nombre) VALUES ('Tren motriz');
SET @tarea_id = LAST_INSERT_ID();
INSERT INTO estacion (orden, linea_montaje_linea_montaje_id, tarea_tarea_id)
VALUES (3, @linea_montaje_id, @tarea_id);

# 3ra Estación - INTERIOR
INSERT INTO tarea (nombre) VALUES ('Interior');
SET @tarea_id = LAST_INSERT_ID();
INSERT INTO estacion (orden, linea_montaje_linea_montaje_id, tarea_tarea_id)
VALUES (4, @linea_montaje_id, @tarea_id);