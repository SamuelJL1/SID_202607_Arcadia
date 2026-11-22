-- =====================================================================
-- ARCADIA - Script DDL (creación del esquema)          Motor: Oracle 12c+
-- Archivo : sql/02_ddl.sql
-- Modelo  : docs/modeladoMR2.2.pdf (modelo relacional 2.2, en 3FN) y
--           docs/dependencias_funcionales.md
-- Requiere: haber ejecutado antes sql/01_drop.sql (o una base vacía).
--
-- CAMBIOS RESPECTO AL MODELO RELACIONAL 2.2 (sincronizar en Data Modeler):
--   1. COMMENTS.rating (NUMBER(1), 1..5): el reporte 4 "Reseñas y
--      calificaciones internas" necesita una puntuación; el MR 2.2 solo
--      tenía el texto de la reseña.
--   2. LIBVIDEOS.date -> LIBVIDEOS.acquisition_date: DATE es palabra
--      reservada de Oracle y no puede usarse como nombre de columna.
--   3. Correos ampliados a VARCHAR2(40) (20 caracteres no alcanzan para un
--      correo real).
--   4. Reglas CHECK/UNIQUE adicionales (precio, estado, horas, fechas,
--      calificación, amistad consigo mismo) documentadas en cada tabla.
--   El nombre LIB_ARCHIEVEMENTS se conserva tal cual está en el MR 2.2.
-- =====================================================================

-- ---------------------------------------------------------------------
-- SECUENCIAS: generan la parte numérica de los ids VARCHAR2 que crean los
-- procedimientos de sql/05_plsql.sql (p. ej. 'L1000'). Empiezan en 1000
-- para no chocar con los ids de ejemplo de sql/03_dml.sql.
-- ---------------------------------------------------------------------
CREATE SEQUENCE seq_libvideos   START WITH 1000 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_statistics  START WITH 1000 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_libach      START WITH 1000 INCREMENT BY 1 NOCACHE;

-- ---------------------------------------------------------------------
-- USERS: jugadores de la plataforma (rol "usuario").
-- Reglas: nickname y email únicos; el celular es obligatorio.
-- ---------------------------------------------------------------------
CREATE TABLE USERS (
    id              VARCHAR2(10)  NOT NULL,
    nickname        VARCHAR2(10)  NOT NULL,
    email           VARCHAR2(40)  NOT NULL,
    payment_method  VARCHAR2(10),
    profile_picture VARCHAR2(30),
    cellphone       NUMBER(10)    NOT NULL,
    CONSTRAINT pk_users          PRIMARY KEY (id),
    CONSTRAINT uq_users_nickname UNIQUE (nickname),
    CONSTRAINT uq_users_email    UNIQUE (email)
);

-- ---------------------------------------------------------------------
-- ADMINISTRATORS: administradores que publican/retiran videojuegos.
-- ---------------------------------------------------------------------
CREATE TABLE ADMINISTRATORS (
    id    VARCHAR2(10) NOT NULL,
    email VARCHAR2(40) NOT NULL,
    CONSTRAINT pk_administrators       PRIMARY KEY (id),
    CONSTRAINT uq_administrators_email UNIQUE (email)
);

-- ---------------------------------------------------------------------
-- GAME_STUDIOS: empresas desarrolladoras, identificadas por NIT.
-- ---------------------------------------------------------------------
CREATE TABLE GAME_STUDIOS (
    nit   VARCHAR2(10) NOT NULL,
    name  VARCHAR2(20) NOT NULL,
    email VARCHAR2(40),
    CONSTRAINT pk_game_studios PRIMARY KEY (nit)
);

-- ---------------------------------------------------------------------
-- GENRES: catálogo de géneros (Acción, RPG, ...).
-- ---------------------------------------------------------------------
CREATE TABLE GENRES (
    id   VARCHAR2(10) NOT NULL,
    name VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_genres      PRIMARY KEY (id),
    CONSTRAINT uq_genres_name UNIQUE (name)
);

-- ---------------------------------------------------------------------
-- VIDEO_GAMES: catálogo de videojuegos publicados por un administrador.
-- Reglas: precio >= 0 (en pesos), duración > 0 (horas aprox. para
-- completarlo) y estado en ACTIVO / RETIRADO / REVISION.
-- ---------------------------------------------------------------------
CREATE TABLE VIDEO_GAMES (
    id                VARCHAR2(10) NOT NULL,
    name              VARCHAR2(25) NOT NULL,
    game_release_date DATE         NOT NULL,
    price             NUMBER(7)    NOT NULL,
    image             VARCHAR2(40),
    duration          NUMBER(3)    NOT NULL,
    status            VARCHAR2(8)  NOT NULL,
    ADMINISTRATORS_id VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_video_games        PRIMARY KEY (id),
    CONSTRAINT ck_vg_price           CHECK (price >= 0),
    CONSTRAINT ck_vg_duration        CHECK (duration > 0),
    CONSTRAINT ck_vg_status          CHECK (status IN ('ACTIVO','RETIRADO','REVISION')),
    CONSTRAINT fk_vg_administrators  FOREIGN KEY (ADMINISTRATORS_id)
        REFERENCES ADMINISTRATORS (id)
);

-- ---------------------------------------------------------------------
-- STUDIOS_VIDEO_GAMES: relación N:M entre estudios y videojuegos
-- (permite coproducciones). Un estudio no se repite en un mismo juego.
-- ---------------------------------------------------------------------
CREATE TABLE STUDIOS_VIDEO_GAMES (
    id              VARCHAR2(10) NOT NULL,
    VIDEO_GAME_id   VARCHAR2(10) NOT NULL,
    GAME_STUDIO_nit VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_studios_vg        PRIMARY KEY (id),
    CONSTRAINT uq_studios_vg        UNIQUE (VIDEO_GAME_id, GAME_STUDIO_nit),
    CONSTRAINT fk_svg_video_game    FOREIGN KEY (VIDEO_GAME_id)
        REFERENCES VIDEO_GAMES (id),
    CONSTRAINT fk_svg_game_studio   FOREIGN KEY (GAME_STUDIO_nit)
        REFERENCES GAME_STUDIOS (nit)
);

-- ---------------------------------------------------------------------
-- VIDEO_GAMES_GENRES: relación N:M entre videojuegos y géneros.
-- ---------------------------------------------------------------------
CREATE TABLE VIDEO_GAMES_GENRES (
    id             VARCHAR2(10) NOT NULL,
    VIDEO_GAMES_id VARCHAR2(10) NOT NULL,
    GENRES_id      VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_vg_genres      PRIMARY KEY (id),
    CONSTRAINT uq_vg_genres      UNIQUE (VIDEO_GAMES_id, GENRES_id),
    CONSTRAINT fk_vgg_video_game FOREIGN KEY (VIDEO_GAMES_id)
        REFERENCES VIDEO_GAMES (id),
    CONSTRAINT fk_vgg_genre      FOREIGN KEY (GENRES_id)
        REFERENCES GENRES (id)
);

-- ---------------------------------------------------------------------
-- LIBVIDEOS: biblioteca personal. Cada fila = un juego que posee un
-- usuario. Un usuario no puede tener el mismo juego dos veces.
-- ---------------------------------------------------------------------
CREATE TABLE LIBVIDEOS (
    id               VARCHAR2(10) NOT NULL,
    acquisition_date DATE         NOT NULL,
    USER_ID          VARCHAR2(10) NOT NULL,
    VIDEO_GAME_ID    VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_libvideos     PRIMARY KEY (id),
    CONSTRAINT uq_libvideos     UNIQUE (USER_ID, VIDEO_GAME_ID),
    CONSTRAINT fk_lib_user      FOREIGN KEY (USER_ID)
        REFERENCES USERS (id),
    CONSTRAINT fk_lib_video_game FOREIGN KEY (VIDEO_GAME_ID)
        REFERENCES VIDEO_GAMES (id)
);

-- ---------------------------------------------------------------------
-- ACHIEVEMENTS: logros definidos por la empresa para cada videojuego.
-- ---------------------------------------------------------------------
CREATE TABLE ACHIEVEMENTS (
    id            VARCHAR2(10) NOT NULL,
    description   VARCHAR2(30) NOT NULL,
    VIDEO_GAME_ID VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_achievements   PRIMARY KEY (id),
    CONSTRAINT fk_ach_video_game FOREIGN KEY (VIDEO_GAME_ID)
        REFERENCES VIDEO_GAMES (id)
);

-- ---------------------------------------------------------------------
-- LIB_ARCHIEVEMENTS: logros desbloqueados en una biblioteca. Un logro
-- solo se desbloquea una vez por biblioteca. (El trigger
-- trg_lib_ach_coherencia, en 05_plsql.sql, valida que el logro
-- pertenezca al juego de esa biblioteca.)
-- ---------------------------------------------------------------------
CREATE TABLE LIB_ARCHIEVEMENTS (
    id              VARCHAR2(10) NOT NULL,
    unlock_date     DATE         NOT NULL,
    ACHIEVEMENTS_id VARCHAR2(10) NOT NULL,
    LIBVIDEOS_id    VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_lib_ach          PRIMARY KEY (id),
    CONSTRAINT uq_lib_ach          UNIQUE (ACHIEVEMENTS_id, LIBVIDEOS_id),
    CONSTRAINT fk_libach_ach       FOREIGN KEY (ACHIEVEMENTS_id)
        REFERENCES ACHIEVEMENTS (id),
    CONSTRAINT fk_libach_libvideos FOREIGN KEY (LIBVIDEOS_id)
        REFERENCES LIBVIDEOS (id)
);

-- ---------------------------------------------------------------------
-- STATISTICS: horas jugadas por biblioteca y periodo (semanal o mensual).
-- Reglas: horas >= 0, fin de periodo >= inicio, y un solo registro por
-- (biblioteca, inicio de periodo).
-- ---------------------------------------------------------------------
CREATE TABLE STATISTICS (
    id           VARCHAR2(10) NOT NULL,
    period_start DATE         NOT NULL,
    period_end   DATE         NOT NULL,
    hours_played NUMBER(3)    NOT NULL,
    LIBVIDEO_id  VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_statistics      PRIMARY KEY (id),
    CONSTRAINT uq_statistics      UNIQUE (LIBVIDEO_id, period_start),
    CONSTRAINT ck_stat_hours      CHECK (hours_played >= 0),
    CONSTRAINT ck_stat_period     CHECK (period_end >= period_start),
    CONSTRAINT fk_stat_libvideo   FOREIGN KEY (LIBVIDEO_id)
        REFERENCES LIBVIDEOS (id)
);

-- ---------------------------------------------------------------------
-- COMMENTS: reseña de un usuario sobre un juego (una por usuario y
-- juego) con calificación de 1 a 5. (El trigger trg_comments_biblioteca
-- exige que el juego esté en la biblioteca del usuario.)
-- ---------------------------------------------------------------------
CREATE TABLE COMMENTS (
    id             VARCHAR2(10) NOT NULL,
    message        VARCHAR2(50) NOT NULL,
    rating         NUMBER(1)    NOT NULL,
    USERS_ID       VARCHAR2(10) NOT NULL,
    VIDEO_GAMES_id VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_comments       PRIMARY KEY (id),
    CONSTRAINT uq_comments       UNIQUE (USERS_ID, VIDEO_GAMES_id),
    CONSTRAINT ck_comments_rating CHECK (rating BETWEEN 1 AND 5),
    CONSTRAINT fk_comments_users FOREIGN KEY (USERS_ID)
        REFERENCES USERS (id),
    CONSTRAINT fk_comments_vg    FOREIGN KEY (VIDEO_GAMES_id)
        REFERENCES VIDEO_GAMES (id)
);

-- ---------------------------------------------------------------------
-- FRIENDSHIPS: amistad entre dos usuarios (se guarda en una dirección;
-- las consultas la tratan como simétrica). Nadie puede ser amigo de sí
-- mismo.
-- ---------------------------------------------------------------------
CREATE TABLE FRIENDSHIPS (
    id              VARCHAR2(10) NOT NULL,
    since_date      DATE         NOT NULL,
    USERS_ID        VARCHAR2(10) NOT NULL,
    USERS_FRIEND_ID VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_friendships   PRIMARY KEY (id),
    CONSTRAINT uq_friendships   UNIQUE (USERS_ID, USERS_FRIEND_ID),
    CONSTRAINT ck_friend_self   CHECK (USERS_ID <> USERS_FRIEND_ID),
    CONSTRAINT fk_friend_user   FOREIGN KEY (USERS_ID)
        REFERENCES USERS (id),
    CONSTRAINT fk_friend_friend FOREIGN KEY (USERS_FRIEND_ID)
        REFERENCES USERS (id)
);

-- ---------------------------------------------------------------------
-- ÍNDICES sobre llaves foráneas que se usan en joins de los reportes.
-- (Oracle no los crea automáticamente.)
-- ---------------------------------------------------------------------
CREATE INDEX ix_stat_libvideo  ON STATISTICS (LIBVIDEO_id);
CREATE INDEX ix_libach_lib     ON LIB_ARCHIEVEMENTS (LIBVIDEOS_id);
CREATE INDEX ix_lib_video_game ON LIBVIDEOS (VIDEO_GAME_ID);
CREATE INDEX ix_comments_vg    ON COMMENTS (VIDEO_GAMES_id);
CREATE INDEX ix_ach_video_game ON ACHIEVEMENTS (VIDEO_GAME_ID);

-- ---------------------------------------------------------------------
-- DOCUMENTACIÓN EN EL DICCIONARIO DE DATOS
-- (consultable en USER_TAB_COMMENTS / USER_COL_COMMENTS)
-- ---------------------------------------------------------------------
COMMENT ON TABLE USERS               IS 'Jugadores de la plataforma Arcadia';
COMMENT ON TABLE ADMINISTRATORS      IS 'Administradores que publican y retiran videojuegos';
COMMENT ON TABLE GAME_STUDIOS        IS 'Empresas desarrolladoras de videojuegos (NIT)';
COMMENT ON TABLE GENRES              IS 'Catálogo de géneros de videojuegos';
COMMENT ON TABLE VIDEO_GAMES         IS 'Catálogo de videojuegos publicados en la plataforma';
COMMENT ON TABLE STUDIOS_VIDEO_GAMES IS 'Relación N:M estudio - videojuego (coproducciones)';
COMMENT ON TABLE VIDEO_GAMES_GENRES  IS 'Relación N:M videojuego - género';
COMMENT ON TABLE LIBVIDEOS           IS 'Biblioteca personal: juegos que posee cada usuario';
COMMENT ON TABLE ACHIEVEMENTS        IS 'Logros definidos por la empresa para cada videojuego';
COMMENT ON TABLE LIB_ARCHIEVEMENTS   IS 'Logros desbloqueados por cada biblioteca, con fecha';
COMMENT ON TABLE STATISTICS          IS 'Horas jugadas por biblioteca y periodo (semanal o mensual)';
COMMENT ON TABLE COMMENTS            IS 'Reseñas con calificación 1-5 de un usuario sobre un juego de su biblioteca';
COMMENT ON TABLE FRIENDSHIPS         IS 'Amistades entre usuarios, usadas para el ranking de amigos';

COMMENT ON COLUMN VIDEO_GAMES.price             IS 'Precio en pesos colombianos';
COMMENT ON COLUMN VIDEO_GAMES.duration          IS 'Horas aproximadas para completar el juego';
COMMENT ON COLUMN VIDEO_GAMES.status            IS 'ACTIVO, RETIRADO (sacado por un admin) o REVISION (pendiente de publicar)';
COMMENT ON COLUMN LIBVIDEOS.acquisition_date    IS 'Fecha en que el usuario agregó el juego a su biblioteca';
COMMENT ON COLUMN LIB_ARCHIEVEMENTS.unlock_date IS 'Fecha en que se desbloqueó el logro';
COMMENT ON COLUMN STATISTICS.period_start       IS 'Primer día del periodo (semana o mes)';
COMMENT ON COLUMN STATISTICS.period_end         IS 'Último día del periodo';
COMMENT ON COLUMN STATISTICS.hours_played       IS 'Horas jugadas acumuladas en el periodo';
COMMENT ON COLUMN COMMENTS.rating               IS 'Calificación de 1 (muy malo) a 5 (excelente)';
COMMENT ON COLUMN FRIENDSHIPS.since_date        IS 'Fecha desde la que son amigos';
