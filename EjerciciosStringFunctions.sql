use usuarios_telefono;
/*
EJERCICIOS
1. obtener únicamente la inicial de los nombres de los usuarios.

2. Obtener el identificador del nombre de usuario. Ejem: BRE2271 , hay que obtener 2271

3. Obtener los caracteres del nombre de usuario, . Ejem: BRE2271 , hay que obtener BRE. De aquellos usuarios varones.
- Realizar la consulta igual, pero para los que no son varones.

4. Realiza una consulta que Imprima los registros con el siguiente formato: Ejem:
El usuario: HUG5441, se llama HUGO, tiene el correo: hugo@live.com y usa un MOTOROLA

5. Devolver la letra inicial más la letra final y longitud del nombre de los usuarios

6. Localizar la posición donde existe el primer espacio en el campo nombre

7 Imprimir hombre o mujer según sea el caso, seguido del nombre del usuario

8- Aumenta el saldo de los usuarios de la compañía MOVISTAR en un 25%. Redondea el resultado. Realiza la actualización en la base de datos.

9 Muestra el nombre del usuario y el dominio en el que tienen el correo electrónico.

10. Indica quiénes son los usuarios activos e inactivos en nuestra web, indicándolo con un texto identificador, 
muestra además los campos que nos servirían para ponernos en contacto con ellos.

11. Muestra los datos de los usuarios con saldo cero e indica si están activos o inactivos.

*/

-- 1
SELECT LEFT(nombre, 1) AS inicial_nombre
FROM Usuarios;

-- 2
SELECT SUBSTRING(usuario, 4) AS identificador_usuario
FROM Usuarios;

-- 3
-- Para usuarios varones
SELECT SUBSTRING(usuario, 1, 3) AS caracteres_usuario_varones
FROM Usuarios
WHERE sexo = 'H';
-- Para usuarios no varones
SELECT SUBSTRING(usuario, 1, 3) AS caracteres_usuario_no_varones
FROM Usuarios
WHERE sexo <> 'H';

-- 4
SELECT CONCAT('El usuario: ', usuario, ', se llama ', nombre, ', tiene el correo: ', email, ' y usa un ', marca) AS registro_formato
FROM Usuarios;

-- 5
SELECT CONCAT(LEFT(nombre, 1), RIGHT(nombre, 1)) AS letras_iniciales_finales, LENGTH(nombre) AS longitud_nombre
FROM Usuarios;

-- 6
SELECT LOCATE(' ', nombre) AS posicion_primer_espacio
FROM Usuarios;

-- 7
SELECT 
  CONCAT(
    CASE 
      WHEN sexo = 'H' THEN 'hombre'
      WHEN sexo = 'M' THEN 'mujer'
      ELSE 'desconocido'
    END,
    ': ',
    nombre
  ) AS genero_y_nombre
FROM Usuarios;

-- 8
UPDATE Usuarios
SET saldo = ROUND(saldo * 1.25)
WHERE compañia = 'MOVISTAR';

-- 9
SELECT 
  nombre,
  SUBSTRING_INDEX(email, '@', -1) AS dominio_correo
FROM Usuarios;

-- 10
SELECT 
  CASE
    WHEN activo = 1 THEN 'Usuario activo'
    WHEN activo = 0 THEN 'Usuario inactivo'
    ELSE 'Estado desconocido'
  END AS estado,
  nombre,
  email,
  telefono
FROM Usuarios;

-- 11
SELECT 
  CASE
    WHEN saldo = 0 THEN 'Saldo cero'
    ELSE 'Saldo no cero'
  END AS estado_saldo,
  CASE
    WHEN activo = 1 THEN 'Usuario activo'
    WHEN activo = 0 THEN 'Usuario inactivo'
    ELSE 'Estado desconocido'
  END AS estado,
  nombre,
  email,
  telefono
FROM Usuarios
WHERE saldo = 0;
