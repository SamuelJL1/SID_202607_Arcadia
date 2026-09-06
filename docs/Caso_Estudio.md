# ARCADIA

## Sistema de Información para la Gestión Personal de Bibliotecas de Videojuegos

### Entrega 0 - Caso de estudio

En este documento presentamos la propuesta de nuestro proyecto **Arcadia**, correspondiente a la **Entrega 0**, donde describiremos la necesidad que identificamos, el objetivo del sistema, los reportes de interés, las entidades, historias de usuario y los acuerdos de trabajo en equipo.

---

## Caso de estudio

**Tipo:** Adaptado

**Fuente:** Steam (Valve Corporation)
https://store.steampowered.com/

En Steam, los usuarios acumulan bibliotecas grandes de videojuegos a lo largo del tiempo, pero la plataforma no les ofrece herramientas para llevar un control organizado de esa actividad: no pueden almacenar estadísticas propias de uso, comparar su progreso con el de otros jugadores dentro de su grupo de amigos, guardar reseñas personales detalladas ni hacer seguimiento a su comportamiento como jugadores período a período, por eso se desea implementar un sistema que permita adicionar estas herramientas faltante llamado Arcadia.

Detrás de cada juego que un usuario adquiere hay una empresa desarrolladora responsable de crearlo y de dar seguimiento a las reseñas que recibe, como insumo para el diseño de sus próximos títulos. A su vez, cada juego solo llega a la biblioteca de los usuarios porque un administrador de la plataforma lo publicó, y ese mismo administrador tiene la potestad de retirarlo si deja de cumplir con los estándares de Steam; para tomar esas decisiones, también se apoya en las reseñas y calificaciones que los usuarios registran.

Un usuario, entonces, no solo posee juegos: acumula tiempo jugado en cada uno, avanza en logros que puede tener alcanzados o pendientes, y puede compararse con otros usuarios de su círculo cercano. Esta falta de visibilidad, tanto para el jugador individual como para quienes están detrás del juego, dificulta que exista una visión clara y organizada de la actividad, el progreso y la inversión en videojuegos dentro del ecosistema. Nuestro objetivo es desarrollar un sistema que cubra estas necesidades para los tres roles involucrados: usuarios, empresas desarrolladoras y administradores de la plataforma.


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
