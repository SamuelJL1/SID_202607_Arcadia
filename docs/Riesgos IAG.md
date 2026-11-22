# Riesgos del uso de IAG en un contexto profesional
 
**Proyecto Arcadia – Sistemas Intensivos en Datos**
 
## Riesgos
 
1. **Resultados incorrectos que parecen correctos.** El código generado puede ejecutarse sin errores y aun así dar resultados equivocados. En Arcadia, la consulta E3 calculaba mal el precio promedio por un JOIN, y solo lo notamos al revisar los números a mano.
2. **Comentarios que no coinciden con el código.** La IAG explica con seguridad cosas que el código no hace. Nos pasó con el comentario de E3, que decía que incluía empresas sin juegos cuando el `HAVING` las eliminaba.
3. **Errores que aparecen después.** La IAG no siempre piensa en los casos límite. Por ejemplo, la forma en que generábamos los ids deja de funcionar a partir del número 10000.
4. **Dependencia.** Si se copia el código sin entenderlo, después no se puede corregir ni explicar.
5. **Confidencialidad.** En una empresa, pegar el esquema o los datos en una IAG puede exponer información privada. En nuestro proyecto todos los datos son ficticios.
6. **Seguridad.** La IAG puede sugerir prácticas inseguras, como armar consultas uniendo textos que escribe el usuario (inyección SQL).
## Cómo lo manejamos
 
- Revisamos y probamos todo el código antes de usarlo.
- Comparamos los resultados de las consultas con cálculos hechos a mano.
- Usamos solo datos ficticios.
- Registramos el uso de IAG en la bitácora de prompts.
## Conclusión
 
La IAG nos ayudó a avanzar más rápido, pero la responsabilidad sobre el código sigue siendo nuestra: hay que validarlo, entenderlo y poder explicarlo.
