-- =====================================================================
-- ARCADIA - Pruebas de los elementos PL/SQL              Motor: Oracle 12c+
-- Archivo : sql/06_pruebas_plsql.sql
-- Requiere: 02_ddl.sql, 03_dml.sql y 05_plsql.sql ejecutados.
-- Qué hace: ejecuta casos correctos y casos con error esperado e
--   imprime el resultado con DBMS_OUTPUT. Al final hace ROLLBACK, por lo
--   que NO modifica los datos de ejemplo. Valores esperados entre [ ]
--   calculados con los datos de 03_dml.sql.
-- =====================================================================
SET SERVEROUTPUT ON

DECLARE
    v_lib VARCHAR2(10);
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== FUNCIONES (antes de modificar datos) ===');
    DBMS_OUTPUT.PUT_LINE('fn_horas_totales_usuario(U001)          = ' ||
        fn_horas_totales_usuario('U001') || '   [474]');
    DBMS_OUTPUT.PUT_LINE('fn_horas_totales_usuario(U001, octubre) = ' ||
        fn_horas_totales_usuario('U001', DATE '2026-10-01', DATE '2026-10-31') || '   [156]');
    DBMS_OUTPUT.PUT_LINE('fn_porcentaje_logros(L001)              = ' ||
        fn_porcentaje_logros('L001') || '   [25]');
    DBMS_OUTPUT.PUT_LINE('fn_porcentaje_logros(L999 inexistente)  = ' ||
        NVL(TO_CHAR(fn_porcentaje_logros('L999')), 'NULL') || '   [NULL]');

    DBMS_OUTPUT.PUT_LINE('=== sp_agregar_juego_biblioteca ===');
    sp_agregar_juego_biblioteca('U012', 'G001', v_lib);
    DBMS_OUTPUT.PUT_LINE('OK: U012 agregó G001, id de biblioteca = ' || v_lib || '   [L1000]');

    BEGIN
        sp_agregar_juego_biblioteca('U012', 'G001', v_lib);
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado (repetido): ' || SQLERRM || '   [-20004]');
    END;
    BEGIN
        sp_agregar_juego_biblioteca('U012', 'G013', v_lib);
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado (en REVISION): ' || SQLERRM || '   [-20003]');
    END;
    BEGIN
        sp_agregar_juego_biblioteca('U012', 'G999', v_lib);
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado (juego inexistente): ' || SQLERRM || '   [-20002]');
    END;
    BEGIN
        sp_agregar_juego_biblioteca('U999', 'G001', v_lib);
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado (usuario inexistente): ' || SQLERRM || '   [-20001]');
    END;

    DBMS_OUTPUT.PUT_LINE('=== sp_registrar_horas ===');
    -- L001 no tiene registro para la semana del 16/11: se crea con 5 horas
    sp_registrar_horas('L001', DATE '2026-11-16', DATE '2026-11-22', 5);
    -- segunda llamada al mismo periodo: acumula 3 horas más -> 8
    sp_registrar_horas('L001', DATE '2026-11-16', DATE '2026-11-22', 3);
    FOR r IN (SELECT hours_played FROM STATISTICS
              WHERE LIBVIDEO_id = 'L001' AND period_start = DATE '2026-11-16') LOOP
        DBMS_OUTPUT.PUT_LINE('Horas acumuladas del periodo = ' || r.hours_played || '   [8]');
    END LOOP;
    BEGIN
        sp_registrar_horas('L001', DATE '2026-11-16', DATE '2026-11-22', 0);
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado (0 horas): ' || SQLERRM || '   [-20006]');
    END;
    BEGIN
        sp_registrar_horas('L999', DATE '2026-11-16', DATE '2026-11-22', 2);
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado (biblioteca inexistente): ' || SQLERRM || '   [-20005]');
    END;

    DBMS_OUTPUT.PUT_LINE('=== sp_desbloquear_logro y trigger trg_lib_ach_coherencia ===');
    sp_desbloquear_logro('L001', 'AC001', DATE '2026-11-20');
    DBMS_OUTPUT.PUT_LINE('OK: AC001 desbloqueado en L001; porcentaje ahora = ' ||
        fn_porcentaje_logros('L001') || '   [50]');
    BEGIN
        sp_desbloquear_logro('L001', 'AC001', DATE '2026-11-20');
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado (ya desbloqueado): ' || SQLERRM || '   [-20009]');
    END;
    BEGIN
        sp_desbloquear_logro('L001', 'AC005', DATE '2026-11-20');   -- AC005 es de G002
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado (logro de otro juego): ' || SQLERRM || '   [-20011]');
    END;
    BEGIN
        sp_desbloquear_logro('L001', 'AC002', DATE '2025-01-01');   -- antes de adquirir el juego
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado (fecha anterior a la adquisición): ' || SQLERRM || '   [-20012]');
    END;

    DBMS_OUTPUT.PUT_LINE('=== trigger trg_comments_biblioteca ===');
    INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id)
    VALUES ('C900', 'Reseña de prueba válida', 4, 'U012', 'G005');   -- U012 sí tiene G005
    DBMS_OUTPUT.PUT_LINE('OK: reseña insertada sobre un juego de la biblioteca');
    BEGIN
        INSERT INTO COMMENTS (id, message, rating, USERS_ID, VIDEO_GAMES_id)
        VALUES ('C901', 'Reseña sin tener el juego', 3, 'U012', 'G002');   -- U012 no tiene G002
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado (juego fuera de la biblioteca): ' || SQLERRM || '   [-20010]');
    END;

    ROLLBACK;   -- deja los datos como estaban
    DBMS_OUTPUT.PUT_LINE('=== ROLLBACK ejecutado: los datos de ejemplo no cambian ===');
END;
/

