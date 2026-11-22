-- =====================================================================
-- ARCADIA - Script de borrado del esquema               Motor: Oracle 12c+
-- Archivo : sql/01_drop.sql
-- Objetivo: eliminar tablas, secuencias y subprogramas para poder
--           reconstruir la base desde cero.
-- Orden   : de tablas hijas a tablas padre. CASCADE CONSTRAINTS elimina
--           además las llaves foráneas que apunten a cada tabla; PURGE
--           evita dejarlas en la papelera de reciclaje. Los triggers
--           (trg_comments_biblioteca y trg_lib_ach_coherencia) y los
--           índices se borran junto con su tabla.
-- Nota    : la primera vez que se ejecuta sobre una base vacía, cada
--           DROP mostrará ORA-00942 / ORA-02289 / ORA-04043 (el objeto
--           no existe). Es normal: el script continúa con el siguiente.
-- ADVERTENCIA: borra TODOS los datos. No ejecutar en producción.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. Tablas (de hijas a padres)
-- ---------------------------------------------------------------------
DROP TABLE COMMENTS             CASCADE CONSTRAINTS PURGE;
DROP TABLE FRIENDSHIPS          CASCADE CONSTRAINTS PURGE;
DROP TABLE STATISTICS           CASCADE CONSTRAINTS PURGE;
DROP TABLE LIB_ARCHIEVEMENTS    CASCADE CONSTRAINTS PURGE;
DROP TABLE ACHIEVEMENTS         CASCADE CONSTRAINTS PURGE;
DROP TABLE LIBVIDEOS            CASCADE CONSTRAINTS PURGE;
DROP TABLE VIDEO_GAMES_GENRES   CASCADE CONSTRAINTS PURGE;
DROP TABLE STUDIOS_VIDEO_GAMES  CASCADE CONSTRAINTS PURGE;
DROP TABLE VIDEO_GAMES          CASCADE CONSTRAINTS PURGE;
DROP TABLE GENRES               CASCADE CONSTRAINTS PURGE;
DROP TABLE GAME_STUDIOS         CASCADE CONSTRAINTS PURGE;
DROP TABLE ADMINISTRATORS       CASCADE CONSTRAINTS PURGE;
DROP TABLE USERS                CASCADE CONSTRAINTS PURGE;

-- ---------------------------------------------------------------------
-- 2. Secuencias
-- ---------------------------------------------------------------------
DROP SEQUENCE seq_libvideos;
DROP SEQUENCE seq_statistics;
DROP SEQUENCE seq_libach;

-- ---------------------------------------------------------------------
-- 3. Procedimientos y funciones (05_plsql.sql)
-- ---------------------------------------------------------------------
DROP PROCEDURE sp_agregar_juego_biblioteca;
DROP PROCEDURE sp_registrar_horas;
DROP PROCEDURE sp_desbloquear_logro;
DROP FUNCTION  fn_porcentaje_logros;
DROP FUNCTION  fn_horas_totales_usuario;

