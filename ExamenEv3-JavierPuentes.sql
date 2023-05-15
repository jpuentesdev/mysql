-- EXAMEN Ev3 --> Javier Puentes Cabrerizo

-- Partiendo de la Base de datos Baloncesto realiza las siguientes funciones.
-- use baloncesto


-- 1. Muestra los nombres y apellidos de todos los jugadores nacidos en enero, en
-- mayúsculas, ordenados por apellido y nombre
SELECT UPPER(nombre) AS nombre, UPPER(apellidos) AS apellidos
FROM JUGADORES
WHERE MONTH(fechaNac) = 1
ORDER BY apellidos, nombre;

-- 2.Muestra los datos de los jugadores españoles de la siguiente forma:
-- Pau Gasol -- Selección: España -- Juega de: Pivot
SELECT CONCAT(JUGADORES.nombre, ' ', apellidos, ' -- Selección: ', SELECCION.nombre, ' -- Juega de: ', posicion) AS nombre
FROM JUGADORES
JOIN SELECCION ON JUGADORES.codigo_seleccion = SELECCION.codigo
WHERE SELECCION.nombre = 'España';

-- 3. Muestra el nombre del jugador hasta la primera letra 'i' que aparezca en su
-- nombre y si no tienen letra 'i' el nombre completo
SELECT CASE
         WHEN INSTR(nombre, 'i') > 0 THEN SUBSTRING(nombre, 1, INSTR(nombre, 'i') - 1)
         ELSE nombre
         END AS nombre_sin_i
FROM JUGADORES;

-- 4. Muestra los nombres, apellidos de todos los jugadores ( reemplazando "Ricky" por
-- "Ricardo") y el año de su nacimiento. Ordena por año de nacimiento.
SELECT REPLACE(nombre, 'Ricky', 'Ricardo') AS nombre_modificado, apellidos, YEAR(fechaNac) AS año_nacimiento
FROM JUGADORES
ORDER BY fechaNac;

-- 5 Muestra los jugadores ordenados por edades (no es el año de nacimiento).
SELECT nombre, apellidos, FLOOR(DATEDIFF(CURDATE(), fechaNac) / 365) AS edad
FROM JUGADORES
ORDER BY edad;

-- 6 Muestra nombre, apellido, nombre selección, seguido de su fecha de nacimiento
-- formateada de la siguiente forma ' Nacido el día: 31 de January de 1990'. Utiliza
-- date_format.
SELECT jugadores.nombre, jugadores.apellidos, seleccion.nombre AS nombre_seleccion, 
DATE_FORMAT(jugadores.fechaNac, 'Nacido el día: %d de %M de %Y') AS fecha_nacimiento_formateada
FROM JUGADORES 
JOIN SELECCION ON jugadores.codigo_seleccion = seleccion.codigo;

-- 7 PUEDES UTILIZAR VARIABLES. Cuántos años de diferencia hay entre el jugador
 -- más joven y el más viejo
 
 -- AÑOS CON PARTE DECIMAL:
SELECT CONCAT(DATEDIFF(MAX(fechaNac), MIN(fechaNac))/ 365,' años') AS diferencia
FROM JUGADORES;

-- AÑOS SIN PARTE DECIMAL:
SELECT TIMESTAMPDIFF(YEAR, MIN(fechaNac), MAX(fechaNac)) AS diferencia FROM JUGADORES;

-- 8. Muestra el nombre, apellidos y selección de todos los jugadores cuyo país
 -- empiece por E.
SELECT jugadores.nombre, jugadores.apellidos, seleccion.nombre AS seleccion
FROM JUGADORES 
JOIN SELECCION  ON jugadores.codigo_seleccion = seleccion.codigo
WHERE seleccion.nombre LIKE 'E%';


-- SUBCONSULTAS:

-- 9) ¿Quien es el jugador más joven?. Muestra sus datos.
SELECT codigo, nombre, apellidos, posicion, fechaNac, codigo_seleccion
FROM JUGADORES
WHERE fechaNac = (SELECT MAX(fechaNac) FROM JUGADORES);

-- 10) Muestra los jugadores de la misma selección a la que pertenece Luis Scola. Debe
-- aparecer código, nombre y apellido del jugador y el nombre de la selección.
SELECT jugadores.codigo, jugadores.nombre, jugadores.apellidos, (SELECT nombre FROM SELECCION WHERE codigo = jugadores.codigo_seleccion) AS nombre_seleccion
FROM JUGADORES 
WHERE jugadores.codigo_seleccion = (SELECT codigo_seleccion FROM JUGADORES WHERE apellidos = 'Scola' AND nombre = 'Luis');





