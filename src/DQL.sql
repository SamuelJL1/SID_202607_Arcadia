
-- =====================================================================
-- =====================================================================
--  CONSULTAS POR HISTORIA DE USUARIO (HU-1 a HU-31)
--  Convenciones: las consultas están escritas para un caso concreto de
--  los datos de ejemplo. Para otro caso se cambia el literal:
--    'U001' = usuario que consulta ("yo")   'U002' = otro usuario
--    'G004' = juego consultado              '900111222' = NIT de la empresa
--  En la aplicación esos literales serían parámetros (variables de enlace).
-- =====================================================================
-- =====================================================================


-- =====================================================================
-- HU-3. INFORMACIÓN DETALLADA DE MI BIBLIOTECA
-- Descripción: devuelve en una sola fila la cantidad de juegos del
-- usuario, las horas jugadas en total y los logros desbloqueados, para
-- decidir qué comprar. (E2 hace lo mismo para todos los usuarios.)
-- Técnicas: subconsultas escalares, JOIN, COUNT, SUM, NVL, tabla DUAL.
-- =====================================================================
SELECT (SELECT COUNT(*)
        FROM   LIBVIDEOS l
        WHERE  l.USER_ID = 'U001')                         AS cantidad_juegos,
       (SELECT NVL(SUM(s.hours_played), 0)
        FROM   STATISTICS s
               INNER JOIN LIBVIDEOS l ON l.id = s.LIBVIDEO_id
        WHERE  l.USER_ID = 'U001')                         AS horas_jugadas,
       (SELECT COUNT(*)
        FROM   LIB_ARCHIEVEMENTS la
               INNER JOIN LIBVIDEOS l ON l.id = la.LIBVIDEOS_id
        WHERE  l.USER_ID = 'U001')                         AS logros_desbloqueados
FROM   dual;

-- =====================================================================
-- HU-5. VER LA INFORMACIÓN DETALLADA DE OTRO USUARIO
-- Descripción: muestra la biblioteca de otro usuario (U002): cada juego
-- con la fecha en que lo adquirió, sus horas, sus logros (obtenidos de
-- los totales del juego) y la calificación que le dio, si reseñó. Sirve
-- para decidir qué juegos tener en la propia biblioteca.
-- Técnicas: INNER JOIN, LEFT OUTER JOIN (horas, logros y reseña pueden
-- no existir), subconsultas agregadas, NVL, concatenación, ORDER BY.
-- =====================================================================
SELECT u.nickname                                        AS usuario,
       vg.name                                           AS videojuego,
       l.acquisition_date                                AS adquirido,
       NVL(h.horas, 0)                                   AS horas_jugadas,
       NVL(a.logros, 0) || ' de ' || t.total_logros      AS logros,
       c.rating                                          AS su_calificacion
FROM   USERS u
       INNER JOIN LIBVIDEOS   l  ON l.USER_ID = u.id
       INNER JOIN VIDEO_GAMES vg ON vg.id = l.VIDEO_GAME_ID
       INNER JOIN (SELECT VIDEO_GAME_ID, COUNT(*) AS total_logros
                   FROM ACHIEVEMENTS GROUP BY VIDEO_GAME_ID) t ON t.VIDEO_GAME_ID = vg.id
       LEFT OUTER JOIN (SELECT LIBVIDEO_id, SUM(hours_played) AS horas
                        FROM STATISTICS GROUP BY LIBVIDEO_id) h ON h.LIBVIDEO_id = l.id
       LEFT OUTER JOIN (SELECT LIBVIDEOS_id, COUNT(*) AS logros
                        FROM LIB_ARCHIEVEMENTS GROUP BY LIBVIDEOS_id) a ON a.LIBVIDEOS_id = l.id
       LEFT OUTER JOIN COMMENTS c ON c.USERS_ID = u.id AND c.VIDEO_GAMES_id = vg.id
WHERE  u.id = 'U002'
ORDER BY horas_jugadas DESC, vg.name;

-- =====================================================================
-- HU-6. TIEMPO DE JUEGO ACUMULADO, EN TOTAL Y POR JUEGO
-- Descripción: para el usuario U001, las horas acumuladas en cada juego,
-- qué porcentaje del total representa y el total de horas de la cuenta
-- (se repite en cada fila). El registro y la actualización del tiempo
-- los hace el procedimiento sp_registrar_horas (05_plsql.sql).
-- Técnicas: INNER JOIN, GROUP BY, SUM, función analítica sobre un
-- agregado SUM(SUM()) OVER (), ROUND, ORDER BY.
-- =====================================================================
SELECT vg.name                                                         AS videojuego,
       SUM(s.hours_played)                                             AS horas_acumuladas,
       ROUND(100 * SUM(s.hours_played) / SUM(SUM(s.hours_played)) OVER (), 1) AS porcentaje_del_total,
       SUM(SUM(s.hours_played)) OVER ()                                AS horas_totales_cuenta
FROM   STATISTICS s
       INNER JOIN LIBVIDEOS   l  ON l.id  = s.LIBVIDEO_id
       INNER JOIN VIDEO_GAMES vg ON vg.id = l.VIDEO_GAME_ID
WHERE  l.USER_ID = 'U001'
GROUP BY vg.name
ORDER BY horas_acumuladas DESC;

-- =====================================================================
-- HU-7. MI TIEMPO DE JUEGO EN UN RANGO DE FECHAS
-- Descripción: lista los periodos (semanales o mensuales) de U001 que
-- están completos dentro del rango 01/09/2026 - 15/11/2026, con las
-- horas de cada uno y el acumulado en el orden cronológico. (R1 hace el
-- resumen mensual de todos los usuarios.)
-- Técnicas: INNER JOIN, filtro por rango de fechas, función analítica
-- SUM() OVER (ORDER BY) para el acumulado, ORDER BY.
-- =====================================================================
SELECT s.period_start                                              AS desde,
       s.period_end                                                AS hasta,
       vg.name                                                     AS videojuego,
       s.hours_played                                              AS horas,
       SUM(s.hours_played) OVER (ORDER BY s.period_start, vg.name) AS horas_acumuladas
FROM   STATISTICS s
       INNER JOIN LIBVIDEOS   l  ON l.id  = s.LIBVIDEO_id
       INNER JOIN VIDEO_GAMES vg ON vg.id = l.VIDEO_GAME_ID
WHERE  l.USER_ID = 'U001'
AND    s.period_start >= DATE '2026-09-01'
AND    s.period_end   <= DATE '2026-11-15'
ORDER BY s.period_start, vg.name;


-- =====================================================================
-- HU-10. LISTADO DE MI BIBLIOTECA CON FECHA DE ADQUISICIÓN
-- Descripción: todos los juegos del usuario U001 con la fecha en que los
-- incorporó, del más reciente al más antiguo.
-- Técnicas: INNER JOIN, ORDER BY por fecha.
-- =====================================================================
SELECT vg.name              AS videojuego,
       l.acquisition_date   AS fecha_adquisicion,
       vg.status            AS estado_del_juego
FROM   LIBVIDEOS l
       INNER JOIN VIDEO_GAMES vg ON vg.id = l.VIDEO_GAME_ID
WHERE  l.USER_ID = 'U001'
ORDER BY l.acquisition_date DESC, vg.name;

-- =====================================================================
-- HU-11a. FILTRAR MI BIBLIOTECA POR GÉNERO
-- Descripción: los juegos de U001 que pertenecen al género 'RPG'.
-- Técnicas: INNER JOIN, subconsulta correlacionada con EXISTS.
-- =====================================================================
SELECT vg.name AS videojuego, l.acquisition_date AS fecha_adquisicion
FROM   LIBVIDEOS l
       INNER JOIN VIDEO_GAMES vg ON vg.id = l.VIDEO_GAME_ID
WHERE  l.USER_ID = 'U001'
AND    EXISTS (SELECT 1
               FROM   VIDEO_GAMES_GENRES vgg
                      INNER JOIN GENRES g ON g.id = vgg.GENRES_id
               WHERE  vgg.VIDEO_GAMES_id = vg.id
               AND    g.name = 'RPG')
ORDER BY vg.name;

-- =====================================================================
-- HU-11b. FILTRAR MI BIBLIOTECA POR DESARROLLADOR
-- Descripción: los juegos de U001 desarrollados (o coproducidos) por la
-- empresa 'Pixel Forge'.
-- Técnicas: INNER JOIN, subconsulta correlacionada con EXISTS.
-- =====================================================================
SELECT vg.name AS videojuego, l.acquisition_date AS fecha_adquisicion
FROM   LIBVIDEOS l
       INNER JOIN VIDEO_GAMES vg ON vg.id = l.VIDEO_GAME_ID
WHERE  l.USER_ID = 'U001'
AND    EXISTS (SELECT 1
               FROM   STUDIOS_VIDEO_GAMES svg
                      INNER JOIN GAME_STUDIOS gs ON gs.nit = svg.GAME_STUDIO_nit
               WHERE  svg.VIDEO_GAME_id = vg.id
               AND    gs.name = 'Pixel Forge')
ORDER BY vg.name;

-- =====================================================================
-- HU-11c. FILTRAR MI BIBLIOTECA POR ESTADO DE LOGROS
-- Descripción: clasifica cada juego de U001 como SIN EMPEZAR (0 logros),
-- EN PROGRESO o COMPLETO (todos los logros) y muestra solo los que están
-- EN PROGRESO. Cambiar el valor del filtro para ver los otros estados.
-- Técnicas: subconsulta en el FROM, INNER JOIN, LEFT OUTER JOIN,
-- GROUP BY, COUNT, CASE, filtro sobre el resultado calculado.
-- =====================================================================
SELECT x.videojuego, x.desbloqueados, x.total_logros, x.estado_logros
FROM (
    SELECT vg.name        AS videojuego,
           COUNT(la.id)   AS desbloqueados,
           t.total_logros AS total_logros,
           CASE WHEN COUNT(la.id) = 0               THEN 'SIN EMPEZAR'
                WHEN COUNT(la.id) = t.total_logros  THEN 'COMPLETO'
                ELSE 'EN PROGRESO' END AS estado_logros
    FROM   LIBVIDEOS l
           INNER JOIN VIDEO_GAMES vg ON vg.id = l.VIDEO_GAME_ID
           INNER JOIN (SELECT VIDEO_GAME_ID, COUNT(*) AS total_logros
                       FROM ACHIEVEMENTS GROUP BY VIDEO_GAME_ID) t ON t.VIDEO_GAME_ID = vg.id
           LEFT OUTER JOIN LIB_ARCHIEVEMENTS la ON la.LIBVIDEOS_id = l.id
    WHERE  l.USER_ID = 'U001'
    GROUP BY vg.name, t.total_logros
) x
WHERE  x.estado_logros = 'EN PROGRESO'
ORDER BY x.videojuego;

-- =====================================================================
-- HU-12. ORDENAR MI BIBLIOTECA (por tiempo jugado, fecha o nombre)
-- Descripción: los juegos de U001 con sus horas y fecha de adquisición,
-- ordenados por tiempo jugado de mayor a menor. Para los otros criterios
-- se reemplaza el ORDER BY por uno de estos:
--    ORDER BY l.acquisition_date DESC     (fecha de adquisición)
--    ORDER BY vg.name                     (nombre)
-- Técnicas: INNER JOIN, LEFT OUTER JOIN con subconsulta agregada, NVL.
-- =====================================================================
SELECT vg.name              AS videojuego,
       NVL(h.horas, 0)      AS horas_jugadas,
       l.acquisition_date   AS fecha_adquisicion
FROM   LIBVIDEOS l
       INNER JOIN VIDEO_GAMES vg ON vg.id = l.VIDEO_GAME_ID
       LEFT OUTER JOIN (SELECT LIBVIDEO_id, SUM(hours_played) AS horas
                        FROM STATISTICS GROUP BY LIBVIDEO_id) h ON h.LIBVIDEO_id = l.id
WHERE  l.USER_ID = 'U001'
ORDER BY horas_jugadas DESC, vg.name;

-- =====================================================================
-- HU-13. RESUMEN GENERAL DE MIS LOGROS (TODA LA CUENTA)
-- Descripción: en una fila, el total de logros obtenidos por U001
-- sumando todos sus juegos, cuántos logros existen en esos juegos,
-- cuántos le faltan, el porcentaje global y cuántos juegos completó al
-- 100 %.
-- Técnicas: INNER JOIN, LEFT OUTER JOIN con subconsultas agregadas, SUM,
-- COUNT, CASE dentro de SUM, ROUND, NVL.
-- =====================================================================
SELECT COUNT(l.id)                                                      AS juegos,
       NVL(SUM(a.logros), 0)                                            AS logros_obtenidos,
       SUM(t.total_logros)                                              AS logros_posibles,
       SUM(t.total_logros) - NVL(SUM(a.logros), 0)                      AS logros_pendientes,
       ROUND(100 * NVL(SUM(a.logros), 0) / SUM(t.total_logros), 1)      AS porcentaje_global,
       SUM(CASE WHEN NVL(a.logros, 0) = t.total_logros THEN 1 ELSE 0 END) AS juegos_al_100
FROM   LIBVIDEOS l
       INNER JOIN (SELECT VIDEO_GAME_ID, COUNT(*) AS total_logros
                   FROM ACHIEVEMENTS GROUP BY VIDEO_GAME_ID) t ON t.VIDEO_GAME_ID = l.VIDEO_GAME_ID
       LEFT OUTER JOIN (SELECT LIBVIDEOS_id, COUNT(*) AS logros
                        FROM LIB_ARCHIEVEMENTS GROUP BY LIBVIDEOS_id) a ON a.LIBVIDEOS_id = l.id
WHERE  l.USER_ID = 'U001';

-- =====================================================================
-- HU-14. LOGROS DE OTRO USUARIO EN UN JUEGO ESPECÍFICO
-- Descripción: para el juego G004, lista cada logro y la fecha en que lo
-- desbloqueó el otro usuario (U002) y la fecha en que lo hizo el usuario
-- que consulta (U001), con una columna que dice quién lo tiene. Los
-- logros sin desbloquear salen con fecha vacía.
-- Técnicas: doble LEFT OUTER JOIN contra subconsultas filtradas por
-- usuario, CASE, ORDER BY.
-- =====================================================================
SELECT a.description   AS logro,
       o.unlock_date   AS fecha_otro_usuario,
       m.unlock_date   AS fecha_mia,
       CASE WHEN o.unlock_date IS NOT NULL AND m.unlock_date IS NOT NULL THEN 'AMBOS'
            WHEN o.unlock_date IS NOT NULL THEN 'SOLO EL OTRO USUARIO'
            WHEN m.unlock_date IS NOT NULL THEN 'SOLO YO'
            ELSE 'NINGUNO' END AS comparacion
FROM   ACHIEVEMENTS a
       LEFT OUTER JOIN (SELECT la.ACHIEVEMENTS_id, la.unlock_date
                        FROM   LIB_ARCHIEVEMENTS la
                               INNER JOIN LIBVIDEOS l ON l.id = la.LIBVIDEOS_id
                        WHERE  l.USER_ID = 'U002') o ON o.ACHIEVEMENTS_id = a.id
       LEFT OUTER JOIN (SELECT la.ACHIEVEMENTS_id, la.unlock_date
                        FROM   LIB_ARCHIEVEMENTS la
                               INNER JOIN LIBVIDEOS l ON l.id = la.LIBVIDEOS_id
                        WHERE  l.USER_ID = 'U001') m ON m.ACHIEVEMENTS_id = a.id
WHERE  a.VIDEO_GAME_ID = 'G004'
ORDER BY a.id;

-- =====================================================================
-- HU-16. ORDENAR MI BIBLIOTECA POR LOGROS PENDIENTES
-- Descripción: los juegos de U001 con sus logros pendientes y el
-- porcentaje completado, empezando por el que más logros le falta
-- (el que más permite avanzar).
-- Técnicas: INNER JOIN, LEFT OUTER JOIN, subconsulta en el FROM,
-- GROUP BY, COUNT, ROUND, ORDER BY.
-- =====================================================================
SELECT vg.name                                          AS videojuego,
       t.total_logros,
       COUNT(la.id)                                     AS desbloqueados,
       t.total_logros - COUNT(la.id)                    AS pendientes,
       ROUND(100 * COUNT(la.id) / t.total_logros, 1)    AS porcentaje
FROM   LIBVIDEOS l
       INNER JOIN VIDEO_GAMES vg ON vg.id = l.VIDEO_GAME_ID
       INNER JOIN (SELECT VIDEO_GAME_ID, COUNT(*) AS total_logros
                   FROM ACHIEVEMENTS GROUP BY VIDEO_GAME_ID) t ON t.VIDEO_GAME_ID = vg.id
       LEFT OUTER JOIN LIB_ARCHIEVEMENTS la ON la.LIBVIDEOS_id = l.id
WHERE  l.USER_ID = 'U001'
GROUP BY vg.name, t.total_logros
ORDER BY pendientes DESC, vg.name;


-- =====================================================================
-- HU-21 y HU-22. MI LISTA DE AMIGOS CON LA FECHA DESDE LA QUE SOMOS AMIGOS
-- Descripción: los amigos de U001 (la amistad se guarda en una sola
-- dirección, por eso se busca en ambas), con la fecha de inicio y los
-- juegos que tienen en común. Incluye el id de la amistad, que es el que
-- se usa para eliminarla (DELETE FROM FRIENDSHIPS WHERE id = ...).
-- Técnicas: INNER JOIN con CASE para elegir "el otro" usuario, subconsulta
-- escalar correlacionada, ORDER BY.
-- =====================================================================
SELECT f.id                AS amistad,
       u.nickname          AS amigo,
       f.since_date        AS amigos_desde,
       (SELECT COUNT(*)
        FROM   LIBVIDEOS l1
               INNER JOIN LIBVIDEOS l2 ON l2.VIDEO_GAME_ID = l1.VIDEO_GAME_ID
        WHERE  l1.USER_ID = 'U001'
        AND    l2.USER_ID = u.id)   AS juegos_en_comun
FROM   FRIENDSHIPS f
       INNER JOIN USERS u ON u.id = CASE WHEN f.USERS_ID = 'U001'
                                         THEN f.USERS_FRIEND_ID
                                         ELSE f.USERS_ID END
WHERE  f.USERS_ID = 'U001' OR f.USERS_FRIEND_ID = 'U001'
ORDER BY f.since_date, u.nickname;


-- =====================================================================
-- HU-26. CONSULTAR LAS RESEÑAS RECIBIDAS POR MIS JUEGOS
-- Descripción: todas las reseñas de los juegos de 'Pixel Forge', con el
-- autor, la calificación, el texto y el promedio de ese juego, empezando
-- por los mejor valorados (fortalezas) y terminando por los peor
-- valorados (debilidades).
-- Técnicas: INNER JOIN (5 tablas), función analítica
-- AVG() OVER (PARTITION BY), ROUND, ORDER BY.
-- =====================================================================
SELECT vg.name                                            AS videojuego,
       ROUND(AVG(c.rating) OVER (PARTITION BY vg.id), 2)  AS promedio_del_juego,
       u.nickname                                         AS autor,
       c.rating                                           AS calificacion,
       c.message                                          AS texto
FROM   GAME_STUDIOS gs
       INNER JOIN STUDIOS_VIDEO_GAMES svg ON svg.GAME_STUDIO_nit = gs.nit
       INNER JOIN VIDEO_GAMES vg          ON vg.id = svg.VIDEO_GAME_id
       INNER JOIN COMMENTS c              ON c.VIDEO_GAMES_id = vg.id
       INNER JOIN USERS u                 ON u.id = c.USERS_ID
WHERE  gs.nit = '900111222'
ORDER BY promedio_del_juego DESC, vg.name, c.rating DESC;

-- =====================================================================
-- R2. LOGROS ALCANZADOS VS. PENDIENTES
-- Descripción: para cada juego de cada biblioteca muestra cuántos logros
-- tiene el juego, cuántos ha desbloqueado el usuario, cuántos le faltan y
-- el porcentaje de progreso. Aparecen también las bibliotecas con 0
-- logros (por eso el LEFT JOIN). Ordena de mayor a menor progreso.
-- Técnicas: INNER JOIN, LEFT OUTER JOIN, subconsulta en el FROM,
-- GROUP BY, COUNT, ROUND, ORDER BY.
-- =====================================================================
SELECT u.nickname                                         AS usuario,
       vg.name                                            AS videojuego,
       t.total_logros,
       COUNT(la.id)                                       AS desbloqueados,
       t.total_logros - COUNT(la.id)                      AS pendientes,
       ROUND(100 * COUNT(la.id) / t.total_logros, 1)      AS porcentaje
FROM   LIBVIDEOS l
       INNER JOIN USERS       u  ON u.id  = l.USER_ID
       INNER JOIN VIDEO_GAMES vg ON vg.id = l.VIDEO_GAME_ID
       INNER JOIN (SELECT VIDEO_GAME_ID, COUNT(*) AS total_logros
                   FROM   ACHIEVEMENTS
                   GROUP BY VIDEO_GAME_ID) t ON t.VIDEO_GAME_ID = vg.id
       LEFT OUTER JOIN LIB_ARCHIEVEMENTS la ON la.LIBVIDEOS_id = l.id
GROUP BY u.nickname, vg.name, t.total_logros
ORDER BY porcentaje DESC, u.nickname, vg.name;

-- =====================================================================
-- R3. RANKING DE AMIGOS
-- Descripción: arma el círculo de amigos del usuario U001 (él mismo y
-- todos sus amigos, sin importar quién agregó a quién) y los ordena por
-- horas jugadas en total, mostrando también cuántos logros tiene cada
-- uno. Quien empata en horas comparte la misma posición. Para otro
-- círculo, cambiar 'U001' en las tres apariciones.
-- Técnicas: CTE (WITH), UNION, LEFT OUTER JOIN, GROUP BY, SUM, COUNT,
-- función analítica RANK, NVL.
-- =====================================================================
WITH circulo AS (
    SELECT USERS_FRIEND_ID AS user_id FROM FRIENDSHIPS WHERE USERS_ID = 'U001'
    UNION
    SELECT USERS_ID        AS user_id FROM FRIENDSHIPS WHERE USERS_FRIEND_ID = 'U001'
    UNION
    SELECT id              AS user_id FROM USERS       WHERE id = 'U001'
),
horas AS (
    SELECT l.USER_ID AS user_id, SUM(s.hours_played) AS total_horas
    FROM   LIBVIDEOS l
           INNER JOIN STATISTICS s ON s.LIBVIDEO_id = l.id
    GROUP BY l.USER_ID
),
logros AS (
    SELECT l.USER_ID AS user_id, COUNT(la.id) AS total_logros
    FROM   LIBVIDEOS l
           INNER JOIN LIB_ARCHIEVEMENTS la ON la.LIBVIDEOS_id = l.id
    GROUP BY l.USER_ID
)
SELECT RANK() OVER (ORDER BY NVL(h.total_horas, 0) DESC) AS posicion,
       u.nickname                                        AS usuario,
       NVL(h.total_horas, 0)                             AS horas_jugadas,
       NVL(g.total_logros, 0)                            AS logros_obtenidos
FROM   circulo c
       INNER JOIN USERS u ON u.id = c.user_id
       LEFT OUTER JOIN horas  h ON h.user_id = c.user_id
       LEFT OUTER JOIN logros g ON g.user_id = c.user_id
ORDER BY posicion, u.nickname;

-- =====================================================================
-- R4. RESEÑAS Y CALIFICACIONES INTERNAS  (usa TOP)
-- Descripción: los 10 juegos ACTIVOS mejor valorados por los usuarios:
-- calificación promedio y número de reseñas. Los juegos sin reseñas
-- también entran (LEFT JOIN) y quedan al final. Desempata por más
-- reseñas y luego por nombre.
-- Técnicas: LEFT OUTER JOIN, GROUP BY, COUNT, AVG, ROUND, ORDER BY,
-- TOP-N con FETCH FIRST 10 ROWS ONLY (equivalente a TOP 10).
-- =====================================================================
SELECT vg.name                  AS videojuego,
       COUNT(c.id)              AS numero_resenas,
       ROUND(AVG(c.rating), 2)  AS calificacion_promedio
FROM   VIDEO_GAMES vg
       LEFT OUTER JOIN COMMENTS c ON c.VIDEO_GAMES_id = vg.id
WHERE  vg.status = 'ACTIVO'
GROUP BY vg.name
ORDER BY calificacion_promedio DESC NULLS LAST, numero_resenas DESC, vg.name
FETCH FIRST 10 ROWS ONLY;