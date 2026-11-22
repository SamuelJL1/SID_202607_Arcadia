SET SERVEROUTPUT ON;
-- =====================================================================
-- ARCADIA - Script PL/SQL                               Motor: Oracle 12c+
-- Archivo : sql/05_plsql.sql
-- Requiere: 02_ddl.sql (tablas y secuencias) y 03_dml.sql.
-- Ejecutar completo (cada bloque termina con "/").
-- Contenido:
--   Procedimientos: sp_agregar_juego_biblioteca, sp_registrar_horas,
--                   sp_desbloquear_logro
--   Funciones     : fn_porcentaje_logros, fn_horas_totales_usuario
--   Triggers      : trg_comments_biblioteca, trg_lib_ach_coherencia
-- Códigos de error propios (RAISE_APPLICATION_ERROR): -20001 a -20013.
-- Pruebas: sql/06_pruebas_plsql.sql
-- =====================================================================

-- =====================================================================
-- PROCEDIMIENTO sp_agregar_juego_biblioteca  (historia de usuario 8)
-- Funcionalidad: agrega un videojuego a la biblioteca de un usuario.
-- Se invoca: cuando el usuario adquiere o añade un juego.
-- Operaciones: valida que el usuario exista, que el juego exista y esté
--   ACTIVO, y que el usuario no lo tenga ya; genera el id con la
--   secuencia seq_libvideos e inserta en LIBVIDEOS.
-- Necesidad que resuelve: centralizar las reglas de negocio para que
--   ninguna aplicación inserte juegos retirados o repetidos.
-- Parámetros: p_user_id, p_game_id (IN); p_lib_id (OUT, id creado);
--   p_fecha (IN, por defecto hoy).
-- =====================================================================
CREATE OR REPLACE PROCEDURE sp_agregar_juego_biblioteca (
    p_user_id IN  USERS.id%TYPE,
    p_game_id IN  VIDEO_GAMES.id%TYPE,
    p_lib_id  OUT LIBVIDEOS.id%TYPE,
    p_fecha   IN  DATE DEFAULT TRUNC(SYSDATE)
) IS
    v_usuarios NUMBER;
    v_estado   VIDEO_GAMES.status%TYPE;
    v_repetido NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_usuarios FROM USERS WHERE id = p_user_id;
    IF v_usuarios = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El usuario no existe: ' || p_user_id);
    END IF;

    BEGIN
        SELECT status INTO v_estado FROM VIDEO_GAMES WHERE id = p_game_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'El videojuego no existe: ' || p_game_id);
    END;

    IF v_estado <> 'ACTIVO' THEN
        RAISE_APPLICATION_ERROR(-20003,
            'El videojuego ' || p_game_id || ' no está disponible (estado ' || v_estado || ')');
    END IF;

    SELECT COUNT(*) INTO v_repetido
    FROM   LIBVIDEOS
    WHERE  USER_ID = p_user_id AND VIDEO_GAME_ID = p_game_id;
    IF v_repetido > 0 THEN
        RAISE_APPLICATION_ERROR(-20004,
            'El usuario ' || p_user_id || ' ya tiene el juego ' || p_game_id);
    END IF;

    p_lib_id := 'L' || LPAD(seq_libvideos.NEXTVAL, 4, '0');
    INSERT INTO LIBVIDEOS (id, acquisition_date, USER_ID, VIDEO_GAME_ID)
    VALUES (p_lib_id, p_fecha, p_user_id, p_game_id);
END sp_agregar_juego_biblioteca;
/

-- =====================================================================
-- PROCEDIMIENTO sp_registrar_horas  (historias de usuario 6 y 7)
-- Funcionalidad: suma horas jugadas a un periodo de una biblioteca.
-- Se invoca: al cerrar una sesión de juego o al sincronizar el tiempo.
-- Operaciones: valida biblioteca, horas > 0 y fechas coherentes; si ya
--   existe el periodo (misma biblioteca y mismo inicio) acumula las
--   horas con UPDATE, y si no, crea el registro con seq_statistics.
--   Verifica que el acumulado no pase de 999 (límite de NUMBER(3)).
-- Necesidad que resuelve: mantener el tiempo acumulado sin duplicar
--   periodos (regla UNIQUE de STATISTICS).
-- Parámetros: p_libvideo_id, p_period_start, p_period_end, p_horas.
-- =====================================================================
CREATE OR REPLACE PROCEDURE sp_registrar_horas (
    p_libvideo_id  IN LIBVIDEOS.id%TYPE,
    p_period_start IN DATE,
    p_period_end   IN DATE,
    p_horas        IN NUMBER
) IS
    v_existe NUMBER;
    v_actual STATISTICS.hours_played%TYPE;
BEGIN
    SELECT COUNT(*) INTO v_existe FROM LIBVIDEOS WHERE id = p_libvideo_id;
    IF v_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'La biblioteca no existe: ' || p_libvideo_id);
    END IF;
    IF p_horas IS NULL OR p_horas <= 0 THEN
        RAISE_APPLICATION_ERROR(-20006, 'Las horas deben ser mayores que cero');
    END IF;
    IF p_period_end < p_period_start THEN
        RAISE_APPLICATION_ERROR(-20007, 'El fin del periodo es anterior a su inicio');
    END IF;

    BEGIN
        SELECT hours_played INTO v_actual
        FROM   STATISTICS
        WHERE  LIBVIDEO_id = p_libvideo_id AND period_start = p_period_start;

        IF v_actual + p_horas > 999 THEN
            RAISE_APPLICATION_ERROR(-20008, 'El acumulado del periodo superaría 999 horas');
        END IF;
        UPDATE STATISTICS
        SET    hours_played = hours_played + p_horas
        WHERE  LIBVIDEO_id = p_libvideo_id AND period_start = p_period_start;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            IF p_horas > 999 THEN
                RAISE_APPLICATION_ERROR(-20008, 'Las horas superan 999');
            END IF;
            INSERT INTO STATISTICS (id, period_start, period_end, hours_played, LIBVIDEO_id)
            VALUES ('S' || LPAD(seq_statistics.NEXTVAL, 4, '0'),
                    p_period_start, p_period_end, p_horas, p_libvideo_id);
    END;
END sp_registrar_horas;
/

-- =====================================================================
-- PROCEDIMIENTO sp_desbloquear_logro  (historia de usuario 23)
-- Funcionalidad: registra un logro como desbloqueado en una biblioteca.
-- Se invoca: cuando el usuario consigue un logro en el juego.
-- Operaciones: inserta en LIB_ARCHIEVEMENTS con id de seq_libach. Si el
--   logro ya estaba desbloqueado (UNIQUE) lanza un error claro. La
--   coherencia logro-juego y la fecha las valida el trigger
--   trg_lib_ach_coherencia.
-- Parámetros: p_libvideo_id, p_achievement_id, p_fecha (por defecto hoy).
-- =====================================================================
CREATE OR REPLACE PROCEDURE sp_desbloquear_logro (
    p_libvideo_id    IN LIBVIDEOS.id%TYPE,
    p_achievement_id IN ACHIEVEMENTS.id%TYPE,
    p_fecha          IN DATE DEFAULT TRUNC(SYSDATE)
) IS
BEGIN
    INSERT INTO LIB_ARCHIEVEMENTS (id, unlock_date, ACHIEVEMENTS_id, LIBVIDEOS_id)
    VALUES ('LA' || LPAD(seq_libach.NEXTVAL, 4, '0'),
            p_fecha, p_achievement_id, p_libvideo_id);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(-20009,
            'El logro ' || p_achievement_id || ' ya estaba desbloqueado en ' || p_libvideo_id);
END sp_desbloquear_logro;
/

-- =====================================================================
-- FUNCIÓN fn_porcentaje_logros  (historia de usuario 15)
-- Funcionalidad: devuelve el porcentaje (0-100, un decimal) de logros
--   desbloqueados de una biblioteca respecto al total del juego.
-- Se invoca: dentro de un SELECT, p. ej.
--   SELECT id, fn_porcentaje_logros(id) FROM LIBVIDEOS;
-- Retorna 0 si el juego no tiene logros definidos y NULL si la
--   biblioteca no existe.
-- =====================================================================
CREATE OR REPLACE FUNCTION fn_porcentaje_logros (
    p_libvideo_id IN LIBVIDEOS.id%TYPE
) RETURN NUMBER IS
    v_juego       LIBVIDEOS.VIDEO_GAME_ID%TYPE;
    v_total       NUMBER;
    v_desbloqueo  NUMBER;
BEGIN
    SELECT VIDEO_GAME_ID INTO v_juego FROM LIBVIDEOS WHERE id = p_libvideo_id;

    SELECT COUNT(*) INTO v_total FROM ACHIEVEMENTS WHERE VIDEO_GAME_ID = v_juego;
    IF v_total = 0 THEN
        RETURN 0;
    END IF;

    SELECT COUNT(*) INTO v_desbloqueo
    FROM   LIB_ARCHIEVEMENTS WHERE LIBVIDEOS_id = p_libvideo_id;

    RETURN ROUND(100 * v_desbloqueo / v_total, 1);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END fn_porcentaje_logros;
/

-- =====================================================================
-- FUNCIÓN fn_horas_totales_usuario  (historias de usuario 3 y 7)
-- Funcionalidad: devuelve las horas jugadas por un usuario en todas sus
--   bibliotecas, opcionalmente limitadas a un rango de fechas (se cuenta
--   un periodo si su inicio cae dentro del rango).
-- Se invoca: en reportes o por otros procedimientos, p. ej.
--   SELECT fn_horas_totales_usuario('U001') FROM dual;
-- Parámetros: p_user_id; p_desde y p_hasta (opcionales, NULL = sin límite).
-- Retorna 0 si el usuario no tiene horas.
-- =====================================================================
CREATE OR REPLACE FUNCTION fn_horas_totales_usuario (
    p_user_id IN USERS.id%TYPE,
    p_desde   IN DATE DEFAULT NULL,
    p_hasta   IN DATE DEFAULT NULL
) RETURN NUMBER IS
    v_horas NUMBER;
BEGIN
    SELECT NVL(SUM(s.hours_played), 0) INTO v_horas
    FROM   STATISTICS s
           INNER JOIN LIBVIDEOS l ON l.id = s.LIBVIDEO_id
    WHERE  l.USER_ID = p_user_id
    AND    (p_desde IS NULL OR s.period_start >= p_desde)
    AND    (p_hasta IS NULL OR s.period_start <= p_hasta);
    RETURN v_horas;
END fn_horas_totales_usuario;
/

-- =====================================================================
-- TRIGGER trg_comments_biblioteca  (historia de usuario 17)
-- Funcionalidad: solo se puede reseñar un juego que esté en la
--   biblioteca del usuario.
-- Se ejecuta: BEFORE INSERT o UPDATE de USERS_ID / VIDEO_GAMES_id en
--   COMMENTS, por cada fila.
-- Operaciones: busca la pareja (usuario, juego) en LIBVIDEOS; si no
--   existe, cancela la operación con el error -20010.
-- =====================================================================
CREATE OR REPLACE TRIGGER trg_comments_biblioteca
BEFORE INSERT OR UPDATE OF USERS_ID, VIDEO_GAMES_id ON COMMENTS
FOR EACH ROW
DECLARE
    v_tiene NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_tiene
    FROM   LIBVIDEOS
    WHERE  USER_ID = :NEW.USERS_ID AND VIDEO_GAME_ID = :NEW.VIDEO_GAMES_id;

    IF v_tiene = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'El usuario ' || :NEW.USERS_ID || ' no tiene el juego ' ||
            :NEW.VIDEO_GAMES_id || ' en su biblioteca; no puede reseñarlo');
    END IF;
END trg_comments_biblioteca;
/

-- =====================================================================
-- TRIGGER trg_lib_ach_coherencia  (historia de usuario 23)
-- Funcionalidad: garantiza que un logro desbloqueado pertenezca al
--   mismo juego de la biblioteca y que no se haya desbloqueado antes de
--   que el usuario adquiriera el juego.
-- Se ejecuta: BEFORE INSERT o UPDATE en LIB_ARCHIEVEMENTS, por fila.
-- Operaciones: compara el juego del logro (ACHIEVEMENTS) con el de la
--   biblioteca (LIBVIDEOS) y la fecha de desbloqueo con la de
--   adquisición; errores -20011 y -20012.
-- Necesidad que resuelve: el modelo relacional por sí solo permitiría
--   asociar a una biblioteca un logro de otro juego.
-- =====================================================================
CREATE OR REPLACE TRIGGER trg_lib_ach_coherencia
BEFORE INSERT OR UPDATE ON LIB_ARCHIEVEMENTS
FOR EACH ROW
DECLARE
    v_juego_logro  ACHIEVEMENTS.VIDEO_GAME_ID%TYPE;
    v_juego_lib    LIBVIDEOS.VIDEO_GAME_ID%TYPE;
    v_adquisicion  LIBVIDEOS.acquisition_date%TYPE;
BEGIN
    SELECT VIDEO_GAME_ID INTO v_juego_logro
    FROM   ACHIEVEMENTS WHERE id = :NEW.ACHIEVEMENTS_id;

    SELECT VIDEO_GAME_ID, acquisition_date INTO v_juego_lib, v_adquisicion
    FROM   LIBVIDEOS WHERE id = :NEW.LIBVIDEOS_id;

    IF v_juego_logro <> v_juego_lib THEN
        RAISE_APPLICATION_ERROR(-20011,
            'El logro ' || :NEW.ACHIEVEMENTS_id || ' pertenece a otro juego (' ||
            v_juego_logro || '), no a ' || v_juego_lib);
    END IF;

    IF :NEW.unlock_date < v_adquisicion THEN
        RAISE_APPLICATION_ERROR(-20012,
            'El logro no puede desbloquearse antes de adquirir el juego');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20013, 'El logro o la biblioteca indicada no existe');
END trg_lib_ach_coherencia;
/
