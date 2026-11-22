-- =====================================================================
-- ARCADIA - Script DML (inserción de datos)            Motor: Oracle 12c+
-- Archivo : sql/03_dml.sql
-- Requiere: haber ejecutado antes sql/02_ddl.sql
-- Objetivo: poblar la base con los datos necesarios para que cada uno de
--           los reportes de sql/04_dql.sql devuelva al menos 10 registros.
-- Orden   : de tablas padre a tablas hijas, para respetar las llaves foráneas.
-- Datos   : 100 % ficticios (usuarios, estudios y videojuegos inventados).
-- Fecha de referencia de los datos: 21/11/2026.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. USERS (12 jugadores)
-- ---------------------------------------------------------------------
-- 12 registros
INSERT INTO USERS (id, nickname, email, payment_method, profile_picture, cellphone) VALUES ('U001', 'ZeroCool', 'zerocool@mail.com', 'TARJETA', 'img/u001.png', 3101110001);
INSERT INTO USERS (id, nickname, email, payment_method, profile_picture, cellphone) VALUES ('U002', 'LunaPixel', 'lunapixel@mail.com', 'PSE', 'img/u002.png', 3101110002);
INSERT INTO USERS (id, nickname, email, payment_method, profile_picture, cellphone) VALUES ('U003', 'KratosFan', 'kratosfan@mail.com', 'NEQUI', NULL, 3101110003);
INSERT INTO USERS (id, nickname, email, payment_method, profile_picture, cellphone) VALUES ('U004', 'NovaByte', 'novabyte@mail.com', 'TARJETA', 'img/u004.png', 3101110004);
INSERT INTO USERS (id, nickname, email, payment_method, profile_picture, cellphone) VALUES ('U005', 'PibeGamer', 'pibegamer@mail.com', 'PAYPAL', NULL, 3101110005);
INSERT INTO USERS (id, nickname, email, payment_method, profile_picture, cellphone) VALUES ('U006', 'Dracarys', 'dracarys@mail.com', 'PSE', 'img/u006.png', 3101110006);
INSERT INTO USERS (id, nickname, email, payment_method, profile_picture, cellphone) VALUES ('U007', 'TetraX', 'tetrax@mail.com', 'TARJETA', NULL, 3101110007);
INSERT INTO USERS (id, nickname, email, payment_method, profile_picture, cellphone) VALUES ('U008', 'MiloPlay', 'miloplay@mail.com', 'NEQUI', 'img/u008.png', 3101110008);
INSERT INTO USERS (id, nickname, email, payment_method, profile_picture, cellphone) VALUES ('U009', 'Kaelith', 'kaelith@mail.com', NULL, 'img/u009.png', 3101110009);
INSERT INTO USERS (id, nickname, email, payment_method, profile_picture, cellphone) VALUES ('U010', 'RoboSam', 'robosam@mail.com', 'PSE', NULL, 3101110010);
INSERT INTO USERS (id, nickname, email, payment_method, profile_picture, cellphone) VALUES ('U011', 'Yuki88', 'yuki88@mail.com', 'PAYPAL', 'img/u011.png', 3101110011);
INSERT INTO USERS (id, nickname, email, payment_method, profile_picture, cellphone) VALUES ('U012', 'CaliGG', 'caligg@mail.com', 'TARJETA', NULL, 3101110012);

-- ---------------------------------------------------------------------
-- 2. ADMINISTRATORS (2 administradores de la plataforma)
-- ---------------------------------------------------------------------
-- 2 registros
INSERT INTO ADMINISTRATORS (id, email) VALUES ('A001', 'admin1@arcadia.co');
INSERT INTO ADMINISTRATORS (id, email) VALUES ('A002', 'admin2@arcadia.co');

-- ---------------------------------------------------------------------
-- 3. GAME_STUDIOS (6 empresas desarrolladoras)
-- ---------------------------------------------------------------------
-- 6 registros
INSERT INTO GAME_STUDIOS (nit, name, email) VALUES ('900111222', 'Pixel Forge', 'contacto@pixelforge.co');
INSERT INTO GAME_STUDIOS (nit, name, email) VALUES ('900222333', 'Andes Games', 'hola@andesgames.co');
INSERT INTO GAME_STUDIOS (nit, name, email) VALUES ('900333444', 'Nebula Works', 'info@nebulaworks.co');
INSERT INTO GAME_STUDIOS (nit, name, email) VALUES ('900444555', 'Ironleaf Studio', 'studio@ironleaf.co');
INSERT INTO GAME_STUDIOS (nit, name, email) VALUES ('900555666', 'Cumbre Interactive', 'juegos@cumbre.co');
INSERT INTO GAME_STUDIOS (nit, name, email) VALUES ('900666777', 'Sombra Labs', NULL);

-- ---------------------------------------------------------------------
-- 4. GENRES (9 géneros; 'Terror' queda sin juegos a propósito para probar outer joins)
-- ---------------------------------------------------------------------
-- 9 registros
INSERT INTO GENRES (id, name) VALUES ('GN01', 'Acción');
INSERT INTO GENRES (id, name) VALUES ('GN02', 'Aventura');
INSERT INTO GENRES (id, name) VALUES ('GN03', 'RPG');
INSERT INTO GENRES (id, name) VALUES ('GN04', 'Estrategia');
INSERT INTO GENRES (id, name) VALUES ('GN05', 'Simulación');
INSERT INTO GENRES (id, name) VALUES ('GN06', 'Indie');
INSERT INTO GENRES (id, name) VALUES ('GN07', 'Puzzle');
INSERT INTO GENRES (id, name) VALUES ('GN08', 'Deportes');
INSERT INTO GENRES (id, name) VALUES ('GN09', 'Terror');

-- ---------------------------------------------------------------------
-- 5. VIDEO_GAMES (13 videojuegos: 11 ACTIVO, 1 RETIRADO, 1 REVISION)
-- ---------------------------------------------------------------------
-- 13 registros
INSERT INTO VIDEO_GAMES (id, name, game_release_date, price, image, duration, status, ADMINISTRATORS_id) VALUES ('G001', 'Aether Drift', DATE '2023-03-15', 69900, 'img/g001.jpg', 18, 'ACTIVO', 'A001');
INSERT INTO VIDEO_GAMES (id, name, game_release_date, price, image, duration, status, ADMINISTRATORS_id) VALUES ('G002', 'Cumbre Rush', DATE '2022-07-01', 39900, 'img/g002.jpg', 12, 'ACTIVO', 'A001');
INSERT INTO VIDEO_GAMES (id, name, game_release_date, price, image, duration, status, ADMINISTRATORS_id) VALUES ('G003', 'Neon Harvest', DATE '2024-02-20', 54900, 'img/g003.jpg', 25, 'ACTIVO', 'A002');
INSERT INTO VIDEO_GAMES (id, name, game_release_date, price, image, duration, status, ADMINISTRATORS_id) VALUES ('G004', 'Ironleaf Saga', DATE '2021-11-05', 89900, 'img/g004.jpg', 60, 'ACTIVO', 'A001');
INSERT INTO VIDEO_GAMES (id, name, game_release_date, price, image, duration, status, ADMINISTRATORS_id) VALUES ('G005', 'Last Lantern', DATE '2025-10-31', 49900, NULL, 9, 'ACTIVO', 'A002');
INSERT INTO VIDEO_GAMES (id, name, game_release_date, price, image, duration, status, ADMINISTRATORS_id) VALUES ('G006', 'Orbit Chef', DATE '2023-09-12', 29900, 'img/g006.jpg', 15, 'ACTIVO', 'A001');
INSERT INTO VIDEO_GAMES (id, name, game_release_date, price, image, duration, status, ADMINISTRATORS_id) VALUES ('G007', 'Tidal Kingdoms', DATE '2022-05-18', 79900, 'img/g007.jpg', 45, 'ACTIVO', 'A002');
INSERT INTO VIDEO_GAMES (id, name, game_release_date, price, image, duration, status, ADMINISTRATORS_id) VALUES ('G008', 'Pixel Dungeon 2', DATE '2024-08-09', 34900, 'img/g008.jpg', 30, 'ACTIVO', 'A001');
INSERT INTO VIDEO_GAMES (id, name, game_release_date, price, image, duration, status, ADMINISTRATORS_id) VALUES ('G009', 'Sombra Protocol', DATE '2026-01-22', 74900, 'img/g009.jpg', 14, 'ACTIVO', 'A002');
INSERT INTO VIDEO_GAMES (id, name, game_release_date, price, image, duration, status, ADMINISTRATORS_id) VALUES ('G010', 'Mesa Verde Tales', DATE '2020-04-03', 24900, NULL, 20, 'ACTIVO', 'A001');
INSERT INTO VIDEO_GAMES (id, name, game_release_date, price, image, duration, status, ADMINISTRATORS_id) VALUES ('G011', 'Rogue Circuit', DATE '2026-09-18', 59900, 'img/g011.jpg', 22, 'ACTIVO', 'A002');
INSERT INTO VIDEO_GAMES (id, name, game_release_date, price, image, duration, status, ADMINISTRATORS_id) VALUES ('G012', 'Cosmic Barista', DATE '2019-06-14', 19900, NULL, 6, 'RETIRADO', 'A001');
INSERT INTO VIDEO_GAMES (id, name, game_release_date, price, image, duration, status, ADMINISTRATORS_id) VALUES ('G013', 'Deep Signal', DATE '2026-12-05', 64900, 'img/g013.jpg', 16, 'REVISION', 'A002');

-- ---------------------------------------------------------------------
-- 6. STUDIOS_VIDEO_GAMES (quién desarrolla cada juego; G011 es coproducción)
-- ---------------------------------------------------------------------
-- 14 registros
INSERT INTO STUDIOS_VIDEO_GAMES (id, VIDEO_GAME_id, GAME_STUDIO_nit) VALUES ('SV01', 'G001', '900111222');
INSERT INTO STUDIOS_VIDEO_GAMES (id, VIDEO_GAME_id, GAME_STUDIO_nit) VALUES ('SV02', 'G002', '900222333');
INSERT INTO STUDIOS_VIDEO_GAMES (id, VIDEO_GAME_id, GAME_STUDIO_nit) VALUES ('SV03', 'G003', '900333444');
INSERT INTO STUDIOS_VIDEO_GAMES (id, VIDEO_GAME_id, GAME_STUDIO_nit) VALUES ('SV04', 'G004', '900444555');
INSERT INTO STUDIOS_VIDEO_GAMES (id, VIDEO_GAME_id, GAME_STUDIO_nit) VALUES ('SV05', 'G005', '900666777');
INSERT INTO STUDIOS_VIDEO_GAMES (id, VIDEO_GAME_id, GAME_STUDIO_nit) VALUES ('SV06', 'G006', '900555666');
INSERT INTO STUDIOS_VIDEO_GAMES (id, VIDEO_GAME_id, GAME_STUDIO_nit) VALUES ('SV07', 'G007', '900333444');
INSERT INTO STUDIOS_VIDEO_GAMES (id, VIDEO_GAME_id, GAME_STUDIO_nit) VALUES ('SV08', 'G008', '900111222');
INSERT INTO STUDIOS_VIDEO_GAMES (id, VIDEO_GAME_id, GAME_STUDIO_nit) VALUES ('SV09', 'G009', '900666777');
INSERT INTO STUDIOS_VIDEO_GAMES (id, VIDEO_GAME_id, GAME_STUDIO_nit) VALUES ('SV10', 'G010', '900222333');
INSERT INTO STUDIOS_VIDEO_GAMES (id, VIDEO_GAME_id, GAME_STUDIO_nit) VALUES ('SV11', 'G011', '900111222');
INSERT INTO STUDIOS_VIDEO_GAMES (id, VIDEO_GAME_id, GAME_STUDIO_nit) VALUES ('SV12', 'G011', '900444555');
INSERT INTO STUDIOS_VIDEO_GAMES (id, VIDEO_GAME_id, GAME_STUDIO_nit) VALUES ('SV13', 'G012', '900555666');
INSERT INTO STUDIOS_VIDEO_GAMES (id, VIDEO_GAME_id, GAME_STUDIO_nit) VALUES ('SV14', 'G013', '900666777');

-- ---------------------------------------------------------------------
-- 7. VIDEO_GAMES_GENRES (relación N:M juego-género)
-- ---------------------------------------------------------------------
-- 25 registros
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG01', 'G001', 'GN01');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG02', 'G001', 'GN02');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG03', 'G002', 'GN08');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG04', 'G002', 'GN06');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG05', 'G003', 'GN05');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG06', 'G003', 'GN06');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG07', 'G004', 'GN03');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG08', 'G004', 'GN02');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG09', 'G005', 'GN02');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG10', 'G005', 'GN07');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG11', 'G006', 'GN05');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG12', 'G006', 'GN07');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG13', 'G007', 'GN04');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG14', 'G007', 'GN03');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG15', 'G008', 'GN03');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG16', 'G008', 'GN06');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG17', 'G008', 'GN01');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG18', 'G009', 'GN01');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG19', 'G010', 'GN02');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG20', 'G010', 'GN06');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG21', 'G011', 'GN01');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG22', 'G011', 'GN04');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG23', 'G012', 'GN05');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG24', 'G012', 'GN07');
INSERT INTO VIDEO_GAMES_GENRES (id, VIDEO_GAMES_id, GENRES_id) VALUES ('GG25', 'G013', 'GN04');

-- ---------------------------------------------------------------------
-- 8. LIBVIDEOS (bibliotecas: qué juego tiene cada usuario y desde cuándo). G013 (en REVISION) no tiene dueños; G012 (RETIRADO) conserva los de antes
-- ---------------------------------------------------------------------
-- 59 registros
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L001', DATE '2025-09-30', 'U001', 'G001');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L002', DATE '2026-04-24', 'U001', 'G003');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L003', DATE '2026-10-28', 'U001', 'G004');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L004', DATE '2026-07-20', 'U001', 'G005');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L005', DATE '2025-09-14', 'U001', 'G007');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L006', DATE '2026-01-15', 'U001', 'G008');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L007', DATE '2026-11-02', 'U001', 'G009');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L008', DATE '2026-08-05', 'U001', 'G010');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L009', DATE '2026-10-16', 'U002', 'G001');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L010', DATE '2026-08-26', 'U002', 'G002');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L011', DATE '2026-02-01', 'U002', 'G004');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L012', DATE '2025-06-03', 'U002', 'G006');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L013', DATE '2025-08-22', 'U002', 'G008');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L014', DATE '2025-09-22', 'U003', 'G001');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L015', DATE '2026-03-22', 'U003', 'G003');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L016', DATE '2025-09-09', 'U003', 'G004');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L017', DATE '2026-09-04', 'U003', 'G007');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L018', DATE '2025-06-12', 'U003', 'G010');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L019', DATE '2026-10-16', 'U004', 'G002');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L020', DATE '2026-04-18', 'U004', 'G003');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L021', DATE '2026-02-15', 'U004', 'G005');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L022', DATE '2026-07-12', 'U004', 'G006');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L023', DATE '2026-05-30', 'U004', 'G009');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L024', DATE '2026-05-23', 'U005', 'G004');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L025', DATE '2026-06-01', 'U005', 'G007');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L026', DATE '2026-06-21', 'U005', 'G008');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L027', DATE '2026-11-04', 'U005', 'G011');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L028', DATE '2026-11-08', 'U006', 'G001');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L029', DATE '2026-09-22', 'U006', 'G005');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L030', DATE '2025-08-18', 'U006', 'G006');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L031', DATE '2026-05-15', 'U006', 'G010');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L032', DATE '2025-08-31', 'U006', 'G012');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L033', DATE '2026-03-27', 'U007', 'G002');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L034', DATE '2026-03-22', 'U007', 'G003');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L035', DATE '2026-09-12', 'U007', 'G004');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L036', DATE '2025-10-23', 'U007', 'G008');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L037', DATE '2026-11-13', 'U007', 'G009');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L038', DATE '2026-04-13', 'U008', 'G001');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L039', DATE '2025-06-26', 'U008', 'G004');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L040', DATE '2026-06-13', 'U008', 'G006');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L041', DATE '2026-06-08', 'U008', 'G007');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L042', DATE '2026-09-16', 'U008', 'G010');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L043', DATE '2026-08-07', 'U009', 'G003');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L044', DATE '2025-12-16', 'U009', 'G005');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L045', DATE '2026-07-14', 'U009', 'G008');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L046', DATE '2026-11-01', 'U009', 'G009');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L047', DATE '2026-10-19', 'U009', 'G011');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L048', DATE '2025-09-28', 'U010', 'G002');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L049', DATE '2026-08-10', 'U010', 'G004');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L050', DATE '2026-11-01', 'U010', 'G006');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L051', DATE '2026-10-16', 'U010', 'G010');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L052', DATE '2026-07-13', 'U010', 'G012');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L053', DATE '2026-02-20', 'U011', 'G001');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L054', DATE '2026-08-05', 'U011', 'G007');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L055', DATE '2026-11-06', 'U011', 'G009');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L056', DATE '2026-10-18', 'U011', 'G011');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L057', DATE '2026-11-08', 'U012', 'G003');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L058', DATE '2026-07-23', 'U012', 'G005');
INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID) VALUES ('L059', DATE '2025-06-26', 'U012', 'G008');

-- ---------------------------------------------------------------------
-- 9. ACHIEVEMENTS (logros definidos por cada juego)
-- ---------------------------------------------------------------------
-- 45 registros
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC001', 'Termina el tutorial', 'G001');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC002', 'Derrota al jefe del cañón', 'G001');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC003', 'Recorre 100 km en nave', 'G001');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC004', 'Completa el juego', 'G001');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC005', 'Gana tu primera carrera', 'G002');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC006', 'Escala la cumbre en 5 min', 'G002');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC007', 'Termina 10 carreras', 'G002');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC008', 'Planta tu primer cultivo', 'G003');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC009', 'Cosecha 100 cultivos', 'G003');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC010', 'Construye un invernadero', 'G003');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC011', 'Vende tu primer lote', 'G003');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC012', 'Crea tu personaje', 'G004');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC013', 'Alcanza el nivel 20', 'G004');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC014', 'Derrota al dragón', 'G004');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC015', 'Reúne las 7 hojas', 'G004');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC016', 'Completa la saga', 'G004');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC017', 'Enciende la primera linterna', 'G005');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC018', 'Resuelve 10 acertijos', 'G005');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC019', 'Encuentra el faro oculto', 'G005');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC020', 'Sirve tu primer pedido', 'G006');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC021', 'Cocina 50 platos', 'G006');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC022', 'Obtén 3 estrellas', 'G006');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC023', 'Funda tu primer reino', 'G007');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC024', 'Gana una batalla naval', 'G007');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC025', 'Une 3 reinos', 'G007');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC026', 'Domina el mar', 'G007');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC027', 'Entra al calabozo', 'G008');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC028', 'Derrota al primer jefe', 'G008');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC029', 'Encuentra 20 tesoros', 'G008');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC030', 'Termina sin morir', 'G008');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC031', 'Infíltrate sin ser visto', 'G009');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC032', 'Completa la misión 3', 'G009');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC033', 'Desbloquea todas las armas', 'G009');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC034', 'Visita el primer pueblo', 'G010');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC035', 'Habla con 10 aldeanos', 'G010');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC036', 'Termina el festival', 'G010');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC037', 'Descubre el mapa', 'G010');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC038', 'Completa el circuito 1', 'G011');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC039', 'Construye una torre', 'G011');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC040', 'Gana sin pérdidas', 'G011');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC041', 'Prepara un café', 'G012');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC042', 'Atiende a 100 clientes', 'G012');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC043', 'Inventa una receta', 'G012');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC044', 'Recibe la primera señal', 'G013');
INSERT INTO ACHIEVEMENTS (id, description, VIDEO_GAME_ID) VALUES ('AC045', 'Descifra el mensaje', 'G013');

-- ---------------------------------------------------------------------
-- 10. LIB_ARCHIEVEMENTS (logros desbloqueados por cada biblioteca)
-- ---------------------------------------------------------------------
-- 135 registros
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA001', DATE '2026-02-15', 'AC004', 'L001');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA002', DATE '2026-09-11', 'AC009', 'L002');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA003', DATE '2026-06-22', 'AC010', 'L002');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA004', DATE '2026-11-08', 'AC014', 'L003');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA005', DATE '2026-11-12', 'AC015', 'L003');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA006', DATE '2026-11-07', 'AC016', 'L003');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA007', DATE '2026-07-24', 'AC017', 'L004');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA008', DATE '2026-08-06', 'AC018', 'L004');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA009', DATE '2026-10-31', 'AC019', 'L004');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA010', DATE '2026-11-16', 'AC023', 'L005');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA011', DATE '2025-12-24', 'AC024', 'L005');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA012', DATE '2026-06-03', 'AC025', 'L005');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA013', DATE '2026-04-06', 'AC026', 'L005');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA014', DATE '2026-11-08', 'AC027', 'L006');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA015', DATE '2026-08-13', 'AC028', 'L006');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA016', DATE '2026-10-05', 'AC034', 'L008');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA017', DATE '2026-10-09', 'AC035', 'L008');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA018', DATE '2026-10-06', 'AC037', 'L008');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA019', DATE '2026-11-06', 'AC001', 'L009');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA020', DATE '2026-10-20', 'AC002', 'L009');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA021', DATE '2026-10-27', 'AC004', 'L009');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA022', DATE '2026-11-01', 'AC005', 'L010');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA023', DATE '2026-10-14', 'AC006', 'L010');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA024', DATE '2026-11-11', 'AC007', 'L010');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA025', DATE '2026-06-04', 'AC013', 'L011');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA026', DATE '2026-10-19', 'AC014', 'L011');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA027', DATE '2026-04-06', 'AC015', 'L011');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA028', DATE '2026-06-19', 'AC016', 'L011');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA029', DATE '2026-05-02', 'AC022', 'L012');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA030', DATE '2026-07-21', 'AC027', 'L013');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA031', DATE '2026-07-03', 'AC028', 'L013');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA032', DATE '2025-11-26', 'AC029', 'L013');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA033', DATE '2026-05-31', 'AC030', 'L013');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA034', DATE '2025-12-09', 'AC001', 'L014');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA035', DATE '2025-11-28', 'AC002', 'L014');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA036', DATE '2026-11-05', 'AC003', 'L014');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA037', DATE '2025-10-23', 'AC004', 'L014');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA038', DATE '2026-06-06', 'AC010', 'L015');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA039', DATE '2026-01-23', 'AC012', 'L016');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA040', DATE '2025-11-13', 'AC014', 'L016');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA041', DATE '2025-12-13', 'AC015', 'L016');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA042', DATE '2026-09-28', 'AC016', 'L016');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA043', DATE '2026-09-23', 'AC023', 'L017');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA044', DATE '2026-11-20', 'AC035', 'L018');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA045', DATE '2025-09-14', 'AC036', 'L018');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA046', DATE '2026-08-02', 'AC037', 'L018');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA047', DATE '2026-11-05', 'AC005', 'L019');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA048', DATE '2026-11-17', 'AC006', 'L019');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA049', DATE '2026-10-16', 'AC007', 'L019');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA050', DATE '2026-07-17', 'AC008', 'L020');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA051', DATE '2026-03-01', 'AC017', 'L021');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA052', DATE '2026-05-23', 'AC018', 'L021');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA053', DATE '2026-04-02', 'AC019', 'L021');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA054', DATE '2026-10-30', 'AC020', 'L022');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA055', DATE '2026-08-24', 'AC021', 'L022');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA056', DATE '2026-11-15', 'AC022', 'L022');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA057', DATE '2026-07-09', 'AC031', 'L023');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA058', DATE '2026-09-15', 'AC032', 'L023');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA059', DATE '2026-09-24', 'AC033', 'L023');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA060', DATE '2026-07-25', 'AC025', 'L025');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA061', DATE '2026-07-11', 'AC027', 'L026');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA062', DATE '2026-07-31', 'AC028', 'L026');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA063', DATE '2026-08-12', 'AC029', 'L026');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA064', DATE '2026-08-08', 'AC030', 'L026');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA065', DATE '2026-11-18', 'AC002', 'L028');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA066', DATE '2026-09-22', 'AC017', 'L029');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA067', DATE '2026-02-15', 'AC020', 'L030');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA068', DATE '2025-10-27', 'AC021', 'L030');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA069', DATE '2025-10-30', 'AC022', 'L030');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA070', DATE '2026-08-14', 'AC034', 'L031');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA071', DATE '2026-10-17', 'AC035', 'L031');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA072', DATE '2026-05-27', 'AC036', 'L031');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA073', DATE '2026-01-08', 'AC042', 'L032');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA074', DATE '2026-07-24', 'AC005', 'L033');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA075', DATE '2026-08-04', 'AC008', 'L034');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA076', DATE '2026-06-05', 'AC010', 'L034');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA077', DATE '2026-08-20', 'AC011', 'L034');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA078', DATE '2026-11-18', 'AC012', 'L035');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA079', DATE '2026-10-31', 'AC014', 'L035');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA080', DATE '2026-11-09', 'AC015', 'L035');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA081', DATE '2026-11-20', 'AC016', 'L035');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA082', DATE '2026-04-04', 'AC027', 'L036');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA083', DATE '2025-12-15', 'AC028', 'L036');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA084', DATE '2026-01-17', 'AC029', 'L036');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA085', DATE '2026-03-02', 'AC030', 'L036');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA086', DATE '2026-11-13', 'AC031', 'L037');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA087', DATE '2026-11-14', 'AC033', 'L037');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA088', DATE '2026-11-18', 'AC001', 'L038');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA089', DATE '2026-06-30', 'AC003', 'L038');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA090', DATE '2026-10-18', 'AC012', 'L039');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA091', DATE '2026-08-09', 'AC013', 'L039');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA092', DATE '2026-05-12', 'AC014', 'L039');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA093', DATE '2026-11-08', 'AC015', 'L039');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA094', DATE '2025-12-31', 'AC016', 'L039');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA095', DATE '2026-07-12', 'AC020', 'L040');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA096', DATE '2026-11-11', 'AC021', 'L040');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA097', DATE '2026-10-26', 'AC022', 'L040');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA098', DATE '2026-08-02', 'AC023', 'L041');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA099', DATE '2026-06-16', 'AC024', 'L041');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA100', DATE '2026-10-26', 'AC034', 'L042');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA101', DATE '2026-11-10', 'AC035', 'L042');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA102', DATE '2026-10-31', 'AC037', 'L042');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA103', DATE '2026-09-23', 'AC011', 'L043');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA104', DATE '2026-08-07', 'AC019', 'L044');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA105', DATE '2026-08-11', 'AC027', 'L045');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA106', DATE '2026-07-15', 'AC030', 'L045');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA107', DATE '2026-11-06', 'AC032', 'L046');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA108', DATE '2026-10-29', 'AC039', 'L047');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA109', DATE '2026-09-24', 'AC005', 'L048');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA110', DATE '2026-10-06', 'AC012', 'L049');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA111', DATE '2026-08-14', 'AC013', 'L049');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA112', DATE '2026-11-06', 'AC014', 'L049');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA113', DATE '2026-10-14', 'AC015', 'L049');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA114', DATE '2026-08-14', 'AC016', 'L049');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA115', DATE '2026-10-21', 'AC036', 'L051');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA116', DATE '2026-10-20', 'AC037', 'L051');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA117', DATE '2026-07-14', 'AC041', 'L052');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA118', DATE '2026-07-24', 'AC042', 'L052');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA119', DATE '2026-09-17', 'AC043', 'L052');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA120', DATE '2026-05-16', 'AC001', 'L053');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA121', DATE '2026-11-11', 'AC002', 'L053');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA122', DATE '2026-06-21', 'AC003', 'L053');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA123', DATE '2026-03-19', 'AC004', 'L053');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA124', DATE '2026-09-03', 'AC023', 'L054');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA125', DATE '2026-10-03', 'AC024', 'L054');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA126', DATE '2026-08-09', 'AC025', 'L054');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA127', DATE '2026-09-23', 'AC026', 'L054');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA128', DATE '2026-10-28', 'AC038', 'L056');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA129', DATE '2026-11-09', 'AC011', 'L057');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA130', DATE '2026-08-01', 'AC017', 'L058');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA131', DATE '2026-08-08', 'AC018', 'L058');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA132', DATE '2026-03-02', 'AC027', 'L059');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA133', DATE '2026-10-24', 'AC028', 'L059');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA134', DATE '2025-11-25', 'AC029', 'L059');
INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id) VALUES ('LA135', DATE '2026-05-22', 'AC030', 'L059');

-- ---------------------------------------------------------------------
-- 11. STATISTICS (horas jugadas: periodos mensuales ago-oct 2026 y semanales de noviembre)
-- ---------------------------------------------------------------------
-- 187 registros
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0001', DATE '2026-11-02', DATE '2026-11-08', 15, 'L001');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0002', DATE '2026-11-09', DATE '2026-11-15', 13, 'L001');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0003', DATE '2026-08-01', DATE '2026-08-31', 35, 'L002');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0004', DATE '2026-11-02', DATE '2026-11-08', 12, 'L002');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0005', DATE '2026-11-09', DATE '2026-11-15', 9, 'L002');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0006', DATE '2026-10-01', DATE '2026-10-31', 26, 'L003');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0007', DATE '2026-11-09', DATE '2026-11-15', 9, 'L003');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0008', DATE '2026-09-01', DATE '2026-09-30', 37, 'L004');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0009', DATE '2026-10-01', DATE '2026-10-31', 41, 'L004');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0010', DATE '2026-11-02', DATE '2026-11-08', 9, 'L004');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0011', DATE '2026-11-09', DATE '2026-11-15', 7, 'L004');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0012', DATE '2026-08-01', DATE '2026-08-31', 73, 'L005');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0013', DATE '2026-09-01', DATE '2026-09-30', 11, 'L005');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0014', DATE '2026-10-01', DATE '2026-10-31', 41, 'L005');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0015', DATE '2026-09-01', DATE '2026-09-30', 27, 'L006');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0016', DATE '2026-10-01', DATE '2026-10-31', 13, 'L006');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0017', DATE '2026-11-09', DATE '2026-11-15', 6, 'L006');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0018', DATE '2026-11-02', DATE '2026-11-08', 9, 'L007');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0019', DATE '2026-11-09', DATE '2026-11-15', 14, 'L007');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0020', DATE '2026-08-01', DATE '2026-08-31', 30, 'L008');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0021', DATE '2026-10-01', DATE '2026-10-31', 35, 'L008');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0022', DATE '2026-11-09', DATE '2026-11-15', 2, 'L008');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0023', DATE '2026-10-01', DATE '2026-10-31', 51, 'L009');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0024', DATE '2026-11-02', DATE '2026-11-08', 7, 'L009');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0025', DATE '2026-11-09', DATE '2026-11-15', 15, 'L009');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0026', DATE '2026-08-01', DATE '2026-08-31', 56, 'L010');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0027', DATE '2026-09-01', DATE '2026-09-30', 19, 'L010');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0028', DATE '2026-10-01', DATE '2026-10-31', 60, 'L010');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0029', DATE '2026-11-02', DATE '2026-11-08', 6, 'L010');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0030', DATE '2026-08-01', DATE '2026-08-31', 15, 'L011');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0031', DATE '2026-09-01', DATE '2026-09-30', 13, 'L011');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0032', DATE '2026-10-01', DATE '2026-10-31', 25, 'L011');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0033', DATE '2026-11-02', DATE '2026-11-08', 10, 'L011');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0034', DATE '2026-11-09', DATE '2026-11-15', 8, 'L011');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0035', DATE '2026-08-01', DATE '2026-08-31', 8, 'L012');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0036', DATE '2026-10-01', DATE '2026-10-31', 7, 'L012');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0037', DATE '2026-11-09', DATE '2026-11-15', 6, 'L012');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0038', DATE '2026-10-01', DATE '2026-10-31', 45, 'L013');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0039', DATE '2026-11-02', DATE '2026-11-08', 8, 'L013');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0040', DATE '2026-11-09', DATE '2026-11-15', 3, 'L013');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0041', DATE '2026-08-01', DATE '2026-08-31', 29, 'L014');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0042', DATE '2026-09-01', DATE '2026-09-30', 38, 'L014');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0043', DATE '2026-10-01', DATE '2026-10-31', 21, 'L014');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0044', DATE '2026-11-02', DATE '2026-11-08', 13, 'L014');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0045', DATE '2026-11-09', DATE '2026-11-15', 14, 'L014');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0046', DATE '2026-08-01', DATE '2026-08-31', 3, 'L015');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0047', DATE '2026-09-01', DATE '2026-09-30', 13, 'L015');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0048', DATE '2026-11-02', DATE '2026-11-08', 5, 'L015');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0049', DATE '2026-11-09', DATE '2026-11-15', 2, 'L015');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0050', DATE '2026-08-01', DATE '2026-08-31', 13, 'L016');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0051', DATE '2026-09-01', DATE '2026-09-30', 16, 'L016');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0052', DATE '2026-10-01', DATE '2026-10-31', 17, 'L016');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0053', DATE '2026-11-02', DATE '2026-11-08', 8, 'L016');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0054', DATE '2026-09-01', DATE '2026-09-30', 11, 'L017');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0055', DATE '2026-11-02', DATE '2026-11-08', 4, 'L017');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0056', DATE '2026-11-09', DATE '2026-11-15', 6, 'L017');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0057', DATE '2026-09-01', DATE '2026-09-30', 13, 'L018');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0058', DATE '2026-10-01', DATE '2026-10-31', 42, 'L018');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0059', DATE '2026-11-02', DATE '2026-11-08', 10, 'L018');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0060', DATE '2026-11-09', DATE '2026-11-15', 6, 'L018');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0061', DATE '2026-11-02', DATE '2026-11-08', 13, 'L019');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0062', DATE '2026-08-01', DATE '2026-08-31', 36, 'L020');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0063', DATE '2026-11-02', DATE '2026-11-08', 4, 'L020');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0064', DATE '2026-08-01', DATE '2026-08-31', 36, 'L021');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0065', DATE '2026-10-01', DATE '2026-10-31', 15, 'L021');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0066', DATE '2026-11-02', DATE '2026-11-08', 9, 'L021');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0067', DATE '2026-11-09', DATE '2026-11-15', 4, 'L021');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0068', DATE '2026-08-01', DATE '2026-08-31', 13, 'L022');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0069', DATE '2026-09-01', DATE '2026-09-30', 9, 'L022');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0070', DATE '2026-11-02', DATE '2026-11-08', 8, 'L022');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0071', DATE '2026-11-09', DATE '2026-11-15', 15, 'L022');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0072', DATE '2026-08-01', DATE '2026-08-31', 40, 'L023');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0073', DATE '2026-09-01', DATE '2026-09-30', 23, 'L023');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0074', DATE '2026-10-01', DATE '2026-10-31', 33, 'L023');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0075', DATE '2026-11-02', DATE '2026-11-08', 8, 'L023');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0076', DATE '2026-11-09', DATE '2026-11-15', 3, 'L023');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0077', DATE '2026-10-01', DATE '2026-10-31', 6, 'L024');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0078', DATE '2026-11-09', DATE '2026-11-15', 1, 'L024');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0079', DATE '2026-08-01', DATE '2026-08-31', 27, 'L025');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0080', DATE '2026-09-01', DATE '2026-09-30', 5, 'L025');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0081', DATE '2026-11-09', DATE '2026-11-15', 6, 'L025');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0082', DATE '2026-08-01', DATE '2026-08-31', 30, 'L026');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0083', DATE '2026-09-01', DATE '2026-09-30', 17, 'L026');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0084', DATE '2026-11-09', DATE '2026-11-15', 6, 'L026');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0085', DATE '2026-11-09', DATE '2026-11-15', 10, 'L027');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0086', DATE '2026-11-02', DATE '2026-11-08', 5, 'L028');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0087', DATE '2026-11-09', DATE '2026-11-15', 13, 'L028');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0088', DATE '2026-10-01', DATE '2026-10-31', 10, 'L029');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0089', DATE '2026-11-09', DATE '2026-11-15', 17, 'L029');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0090', DATE '2026-08-01', DATE '2026-08-31', 12, 'L030');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0091', DATE '2026-09-01', DATE '2026-09-30', 23, 'L030');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0092', DATE '2026-11-02', DATE '2026-11-08', 17, 'L030');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0093', DATE '2026-11-09', DATE '2026-11-15', 12, 'L030');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0094', DATE '2026-09-01', DATE '2026-09-30', 37, 'L031');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0095', DATE '2026-10-01', DATE '2026-10-31', 25, 'L031');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0096', DATE '2026-11-02', DATE '2026-11-08', 9, 'L031');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0097', DATE '2026-11-09', DATE '2026-11-15', 14, 'L031');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0098', DATE '2026-08-01', DATE '2026-08-31', 20, 'L032');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0099', DATE '2026-09-01', DATE '2026-09-30', 13, 'L032');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0100', DATE '2026-10-01', DATE '2026-10-31', 9, 'L032');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0101', DATE '2026-11-09', DATE '2026-11-15', 3, 'L032');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0102', DATE '2026-08-01', DATE '2026-08-31', 3, 'L033');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0103', DATE '2026-09-01', DATE '2026-09-30', 5, 'L033');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0104', DATE '2026-10-01', DATE '2026-10-31', 13, 'L033');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0105', DATE '2026-11-02', DATE '2026-11-08', 1, 'L033');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0106', DATE '2026-09-01', DATE '2026-09-30', 34, 'L034');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0107', DATE '2026-10-01', DATE '2026-10-31', 10, 'L034');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0108', DATE '2026-11-02', DATE '2026-11-08', 15, 'L034');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0109', DATE '2026-09-01', DATE '2026-09-30', 62, 'L035');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0110', DATE '2026-10-01', DATE '2026-10-31', 22, 'L035');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0111', DATE '2026-11-02', DATE '2026-11-08', 21, 'L035');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0112', DATE '2026-11-09', DATE '2026-11-15', 12, 'L035');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0113', DATE '2026-08-01', DATE '2026-08-31', 41, 'L036');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0114', DATE '2026-10-01', DATE '2026-10-31', 39, 'L036');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0115', DATE '2026-11-02', DATE '2026-11-08', 12, 'L036');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0116', DATE '2026-11-09', DATE '2026-11-15', 11, 'L037');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0117', DATE '2026-08-01', DATE '2026-08-31', 7, 'L038');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0118', DATE '2026-09-01', DATE '2026-09-30', 47, 'L038');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0119', DATE '2026-10-01', DATE '2026-10-31', 68, 'L038');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0120', DATE '2026-11-02', DATE '2026-11-08', 22, 'L038');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0121', DATE '2026-11-09', DATE '2026-11-15', 13, 'L038');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0122', DATE '2026-08-01', DATE '2026-08-31', 17, 'L039');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0123', DATE '2026-09-01', DATE '2026-09-30', 8, 'L039');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0124', DATE '2026-10-01', DATE '2026-10-31', 63, 'L039');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0125', DATE '2026-11-02', DATE '2026-11-08', 7, 'L039');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0126', DATE '2026-11-09', DATE '2026-11-15', 20, 'L039');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0127', DATE '2026-08-01', DATE '2026-08-31', 18, 'L040');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0128', DATE '2026-10-01', DATE '2026-10-31', 46, 'L040');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0129', DATE '2026-11-09', DATE '2026-11-15', 3, 'L040');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0130', DATE '2026-08-01', DATE '2026-08-31', 7, 'L041');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0131', DATE '2026-09-01', DATE '2026-09-30', 6, 'L041');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0132', DATE '2026-10-01', DATE '2026-10-31', 10, 'L041');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0133', DATE '2026-11-02', DATE '2026-11-08', 2, 'L041');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0134', DATE '2026-11-09', DATE '2026-11-15', 4, 'L041');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0135', DATE '2026-09-01', DATE '2026-09-30', 27, 'L042');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0136', DATE '2026-10-01', DATE '2026-10-31', 24, 'L042');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0137', DATE '2026-11-09', DATE '2026-11-15', 5, 'L042');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0138', DATE '2026-11-02', DATE '2026-11-08', 5, 'L043');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0139', DATE '2026-11-09', DATE '2026-11-15', 10, 'L043');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0140', DATE '2026-08-01', DATE '2026-08-31', 5, 'L044');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0141', DATE '2026-10-01', DATE '2026-10-31', 33, 'L044');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0142', DATE '2026-11-09', DATE '2026-11-15', 2, 'L044');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0143', DATE '2026-08-01', DATE '2026-08-31', 32, 'L045');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0144', DATE '2026-09-01', DATE '2026-09-30', 9, 'L045');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0145', DATE '2026-10-01', DATE '2026-10-31', 7, 'L045');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0146', DATE '2026-11-02', DATE '2026-11-08', 6, 'L045');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0147', DATE '2026-11-02', DATE '2026-11-08', 6, 'L046');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0148', DATE '2026-11-09', DATE '2026-11-15', 6, 'L046');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0149', DATE '2026-10-01', DATE '2026-10-31', 17, 'L047');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0150', DATE '2026-11-09', DATE '2026-11-15', 5, 'L047');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0151', DATE '2026-08-01', DATE '2026-08-31', 16, 'L048');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0152', DATE '2026-11-09', DATE '2026-11-15', 3, 'L048');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0153', DATE '2026-08-01', DATE '2026-08-31', 25, 'L049');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0154', DATE '2026-09-01', DATE '2026-09-30', 20, 'L049');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0155', DATE '2026-11-02', DATE '2026-11-08', 3, 'L049');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0156', DATE '2026-11-02', DATE '2026-11-08', 4, 'L050');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0157', DATE '2026-10-01', DATE '2026-10-31', 27, 'L051');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0158', DATE '2026-11-09', DATE '2026-11-15', 5, 'L051');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0159', DATE '2026-08-01', DATE '2026-08-31', 22, 'L052');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0160', DATE '2026-09-01', DATE '2026-09-30', 34, 'L052');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0161', DATE '2026-10-01', DATE '2026-10-31', 21, 'L052');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0162', DATE '2026-11-02', DATE '2026-11-08', 3, 'L052');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0163', DATE '2026-11-09', DATE '2026-11-15', 9, 'L052');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0164', DATE '2026-08-01', DATE '2026-08-31', 45, 'L053');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0165', DATE '2026-10-01', DATE '2026-10-31', 40, 'L053');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0166', DATE '2026-11-02', DATE '2026-11-08', 10, 'L053');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0167', DATE '2026-11-09', DATE '2026-11-15', 1, 'L053');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0168', DATE '2026-08-01', DATE '2026-08-31', 47, 'L054');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0169', DATE '2026-09-01', DATE '2026-09-30', 46, 'L054');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0170', DATE '2026-10-01', DATE '2026-10-31', 21, 'L054');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0171', DATE '2026-11-09', DATE '2026-11-15', 9, 'L054');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0172', DATE '2026-11-02', DATE '2026-11-08', 11, 'L055');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0173', DATE '2026-10-01', DATE '2026-10-31', 18, 'L056');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0174', DATE '2026-11-02', DATE '2026-11-08', 5, 'L056');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0175', DATE '2026-11-09', DATE '2026-11-15', 5, 'L056');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0176', DATE '2026-11-02', DATE '2026-11-08', 2, 'L057');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0177', DATE '2026-11-09', DATE '2026-11-15', 10, 'L057');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0178', DATE '2026-08-01', DATE '2026-08-31', 47, 'L058');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0179', DATE '2026-09-01', DATE '2026-09-30', 16, 'L058');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0180', DATE '2026-10-01', DATE '2026-10-31', 68, 'L058');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0181', DATE '2026-11-02', DATE '2026-11-08', 21, 'L058');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0182', DATE '2026-11-09', DATE '2026-11-15', 7, 'L058');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0183', DATE '2026-08-01', DATE '2026-08-31', 17, 'L059');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0184', DATE '2026-09-01', DATE '2026-09-30', 28, 'L059');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0185', DATE '2026-10-01', DATE '2026-10-31', 11, 'L059');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0186', DATE '2026-11-02', DATE '2026-11-08', 12, 'L059');
INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id) VALUES ('S0187', DATE '2026-11-09', DATE '2026-11-15', 9, 'L059');

-- ---------------------------------------------------------------------
-- 12. COMMENTS (reseñas con calificación 1-5; solo sobre juegos de la propia biblioteca)
-- ---------------------------------------------------------------------
-- 39 registros
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C001', 'Historia y jugabilidad excelentes', 5, 'U005', 'G008');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C002', 'Muy bueno, vale cada peso', 4, 'U003', 'G001');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C003', 'Entretenido pero repetitivo', 3, 'U008', 'G006');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C004', 'Cumple, aunque esperaba más', 3, 'U001', 'G009');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C005', 'Divertido y bien pulido', 4, 'U010', 'G004');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C006', 'Divertido y bien pulido', 4, 'U004', 'G005');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C007', 'Demasiados errores técnicos', 2, 'U009', 'G009');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C008', 'Lo mejor que he jugado este año', 5, 'U002', 'G008');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C009', 'Cumple, aunque esperaba más', 3, 'U001', 'G007');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C010', 'Cumple, aunque esperaba más', 3, 'U011', 'G009');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C011', 'Gran juego, con detalles menores', 4, 'U006', 'G010');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C012', 'Entretenido pero repetitivo', 3, 'U009', 'G011');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C013', 'Lo mejor que he jugado este año', 5, 'U001', 'G004');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C014', 'Historia y jugabilidad excelentes', 5, 'U009', 'G005');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C015', 'Muy bueno, vale cada peso', 4, 'U007', 'G004');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C016', 'Entretenido pero repetitivo', 3, 'U007', 'G003');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C017', 'Bueno para pasar el rato', 3, 'U012', 'G003');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C018', 'Muy bueno, vale cada peso', 4, 'U004', 'G002');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C019', 'Divertido y bien pulido', 4, 'U008', 'G010');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C020', 'Gran juego, con detalles menores', 4, 'U010', 'G002');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C021', 'Cumple, aunque esperaba más', 3, 'U006', 'G006');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C022', 'Historia y jugabilidad excelentes', 5, 'U002', 'G004');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C023', 'Muy bueno, vale cada peso', 4, 'U006', 'G001');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C024', 'Lo mejor que he jugado este año', 5, 'U011', 'G007');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C025', 'Cumple, aunque esperaba más', 3, 'U003', 'G010');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C026', 'Gran juego, con detalles menores', 4, 'U010', 'G012');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C027', 'Demasiados errores técnicos', 2, 'U011', 'G011');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C028', 'Gran juego, con detalles menores', 4, 'U003', 'G004');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C029', 'Se me hizo largo y aburrido', 2, 'U004', 'G009');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C030', 'Injugable en mi equipo', 1, 'U007', 'G002');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C031', 'Cumple, aunque esperaba más', 3, 'U009', 'G003');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C032', 'Gran juego, con detalles menores', 4, 'U009', 'G008');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C033', 'Gran juego, con detalles menores', 4, 'U005', 'G007');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C034', 'Obra maestra, lo recomiendo totalmente', 5, 'U011', 'G001');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C035', 'Muy bueno, vale cada peso', 4, 'U001', 'G001');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C036', 'Divertido y bien pulido', 4, 'U001', 'G010');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C037', 'Bueno para pasar el rato', 3, 'U007', 'G008');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C038', 'Tiene buenas ideas mal ejecutadas', 2, 'U006', 'G012');
INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id) VALUES ('C039', 'Tiene buenas ideas mal ejecutadas', 2, 'U002', 'G006');

-- ---------------------------------------------------------------------
-- 13. FRIENDSHIPS (U001 tiene 10 amigos para el ranking; relación guardada en una sola dirección)
-- ---------------------------------------------------------------------
-- 17 registros
INSERT INTO FRIENDSHIPS (id, since_date, USERS_ID, USERS_FRIEND_ID) VALUES ('F001', DATE '2024-05-15', 'U001', 'U002');
INSERT INTO FRIENDSHIPS (id, since_date, USERS_ID, USERS_FRIEND_ID) VALUES ('F002', DATE '2025-11-30', 'U001', 'U003');
INSERT INTO FRIENDSHIPS (id, since_date, USERS_ID, USERS_FRIEND_ID) VALUES ('F003', DATE '2024-11-04', 'U001', 'U004');
INSERT INTO FRIENDSHIPS (id, since_date, USERS_ID, USERS_FRIEND_ID) VALUES ('F004', DATE '2026-08-01', 'U001', 'U005');
INSERT INTO FRIENDSHIPS (id, since_date, USERS_ID, USERS_FRIEND_ID) VALUES ('F005', DATE '2026-04-27', 'U001', 'U006');
INSERT INTO FRIENDSHIPS (id, since_date, USERS_ID, USERS_FRIEND_ID) VALUES ('F006', DATE '2024-07-22', 'U001', 'U007');
INSERT INTO FRIENDSHIPS (id, since_date, USERS_ID, USERS_FRIEND_ID) VALUES ('F007', DATE '2024-08-04', 'U001', 'U008');
INSERT INTO FRIENDSHIPS (id, since_date, USERS_ID, USERS_FRIEND_ID) VALUES ('F008', DATE '2025-01-25', 'U001', 'U009');
INSERT INTO FRIENDSHIPS (id, since_date, USERS_ID, USERS_FRIEND_ID) VALUES ('F009', DATE '2026-09-21', 'U001', 'U010');
INSERT INTO FRIENDSHIPS (id, since_date, USERS_ID, USERS_FRIEND_ID) VALUES ('F010', DATE '2025-11-29', 'U001', 'U011');
INSERT INTO FRIENDSHIPS (id, since_date, USERS_ID, USERS_FRIEND_ID) VALUES ('F011', DATE '2025-01-05', 'U002', 'U003');
INSERT INTO FRIENDSHIPS (id, since_date, USERS_ID, USERS_FRIEND_ID) VALUES ('F012', DATE '2024-09-12', 'U003', 'U004');
INSERT INTO FRIENDSHIPS (id, since_date, USERS_ID, USERS_FRIEND_ID) VALUES ('F013', DATE '2024-06-26', 'U005', 'U006');
INSERT INTO FRIENDSHIPS (id, since_date, USERS_ID, USERS_FRIEND_ID) VALUES ('F014', DATE '2025-12-10', 'U007', 'U012');
INSERT INTO FRIENDSHIPS (id, since_date, USERS_ID, USERS_FRIEND_ID) VALUES ('F015', DATE '2025-04-29', 'U008', 'U009');
INSERT INTO FRIENDSHIPS (id, since_date, USERS_ID, USERS_FRIEND_ID) VALUES ('F016', DATE '2024-11-01', 'U010', 'U011');
INSERT INTO FRIENDSHIPS (id, since_date, USERS_ID, USERS_FRIEND_ID) VALUES ('F017', DATE '2026-06-27', 'U004', 'U012');

COMMIT;
