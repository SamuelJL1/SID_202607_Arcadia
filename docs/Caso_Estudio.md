# ARCADIA

## Sistema de Información para la Gestión Personal de Bibliotecas de Videojuegos

### Entrega 0 - Caso de estudio

En este documento presentamos la propuesta de nuestro proyecto **Arcadia**, correspondiente a la **Entrega 0**, donde describiremos la necesidad que identificamos, el objetivo del sistema, los reportes de interés, las entidades, historias de usuario y los acuerdos de trabajo en equipo.

---

## Caso de estudio

**Tipo:** Adaptado

**Fuente:** Steam (Valve Corporation)
https://store.steampowered.com/

En Steam, los usuarios tienden a tener bibliotecas grandes de videojuegos, pero la plataforma no ofrece herramientas que les permitan almacenar sus propias estadísticas de uso general, comparar su progreso con otros usuarios, guardar reseñas personales detalladas o analizar su comportamiento como jugadores a lo largo del tiempo.

Esto dificulta que el usuario tenga una visión clara y organizada de su actividad e inversión en videojuegos. Nuestro objetivo es desarrollar un sistema que supla con estas necesidades.

---

## Reportes

1. **Tiempo de juego por período:**
   Muestra el tiempo dedicado por un usuario a cada juego en un rango semanal o mensual.

2. **Logros alcanzados vs. pendientes:**
   Mide el porcentaje de progreso de un usuario en cada título, comparando logros obtenidos y faltantes.

3. **Ranking de amigos:**
   Compara el tiempo jugado o los logros obtenidos entre los usuarios de un mismo grupo de amigos.

4. **Reseñas y calificaciones internas:**
   Presenta los juegos mejor valorados según las reseñas y puntuaciones registradas por los usuarios.

---

## Entidades

1. **Usuario:**
   Datos personales, nombre de perfil, ID de plataforma, fecha de registro y tiempo de juego.

2. **Juego:**
   Título, género, desarrollador, fecha de lanzamiento y precio.

3. **Biblioteca:**
   Relación entre usuario y los juegos que posee; fecha de adquisición.

4. **Logro:**
   Nombre, descripción, estado (alcanzado / no alcanzado) y juego asociado.

5. **Reseña:**
   Comentario, calificación numérica, fecha, usuario y juego asociados.

---
