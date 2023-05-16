use world;

-- 1) Crea un procedimiento llamado saludo, que reciba como parámetro en nombre de una persona (por ejemplo PEPE) 
-- y muestre por pantalla "BIENVENIDO A CLASE PEPE".
DELIMITER //

CREATE PROCEDURE saludo (IN nombre VARCHAR(50))
BEGIN
  SET @mensaje = CONCAT('BIENVENIDO A CLASE ', nombre);
  SELECT @mensaje;
END //

DELIMITER ;

CALL saludo('PEPE');

-- 2) Crea un procedimiento llamado datosPersona  que reciba tres parámetros de entrada con el nombre, apellidos y edad de una persona 
-- y muestre por pantalla las tres variables concatenadas con un texto de tu invención.
DELIMITER //

CREATE PROCEDURE datosPersona (IN nombre VARCHAR(50), IN apellidos VARCHAR(50), IN edad INT)
BEGIN
  SET @mensaje = CONCAT('Nombre completo: ', nombre, ' ', apellidos, '. Edad: ', edad);
  SELECT @mensaje;
END //

DELIMITER ;

CALL datosPersona('Juan', 'Pérez', 30);

-- 3) Crea un procedimiento llamado areaRectangulo que reciba dos parámetros de entrada (base y altura) y calcule el área de
-- un rectángulo (base*altura) y lo muestre por pantalla .
DELIMITER //

CREATE PROCEDURE areaRectangulo (IN base FLOAT, IN altura FLOAT)
BEGIN
  DECLARE resultado FLOAT;
  SET resultado = base * altura;
  SELECT CONCAT('El área del rectángulo es: ', resultado);
END //

DELIMITER ;

CALL areaRectangulo(5.5, 3.2);

-- Modificar el procedimiento, lo llamas areaRectangulo_2 que reciba dos parámetros de entrada (base y altura) y uno de salida llamado resultado. 
-- calcule el área de un rectángulo (base*altura)   y lo devuelva en la variable de salida resultado.
 DELIMITER //

CREATE PROCEDURE areaRectangulo_2 (IN base FLOAT, IN altura FLOAT, OUT resultado FLOAT)
BEGIN
  SET resultado = base * altura;
END //

DELIMITER ;

SET @resultado = 0;
CALL areaRectangulo_2(5.5, 3.2, @resultado);
SELECT CONCAT('El área del rectángulo es: ', @resultado);

-- 4) Escribe un procedimiento llamado positivoNegativo que reciba un número real de entrada y muestre un mensaje indicando si el número es positivo o
-- negativo. Prueba con los tres valores requeridos. ( hay que usar IF / ELSE)
DELIMITER //

CREATE PROCEDURE positivoNegativo (IN numero FLOAT)
BEGIN
  IF numero > 0 THEN
    SELECT 'El número es positivo.';
  ELSEIF numero < 0 THEN
    SELECT 'El número es negativo.';
  ELSE
    SELECT 'El número es cero.';
  END IF;
END //

DELIMITER ;

CALL positivoNegativo(10.5);
CALL positivoNegativo(-5.2);
CALL positivoNegativo(0);

-- 5) Utiliza la BD world. 
-- Crea un procedimiento llamado datosCiudad que reciba un parámetro de entrada con el código de una ciudad y devuelva 3 parámetros de salida con los datos de la ciudad que tú prefieras.
DELIMITER //

CREATE PROCEDURE datosCiudad (IN codigo_ciudad CHAR(3), OUT nombre_ciudad VARCHAR(255), OUT pais_ciudad VARCHAR(255), OUT poblacion_ciudad INT)
BEGIN
  SELECT Name, CountryCode, Population INTO nombre_ciudad, pais_ciudad, poblacion_ciudad
  FROM city
  WHERE ID = codigo_ciudad;
END //

DELIMITER ;

SET @nombre = '';
SET @pais = '';
SET @poblacion = 0;

CALL datosCiudad('XXX', @nombre, @pais, @poblacion);

SELECT CONCAT('Nombre de la ciudad: ', @nombre) AS Informacion,
       CONCAT('País de la ciudad: ', @pais) AS Informacion,
       CONCAT('Población de la ciudad: ', @poblacion) AS Informacion;

-- 6) Utiliza la BD world. Crea un procedimiento llamado contarIdiomasPais que reciba un parámetro de entrada con el código de un país y devuelva 2parámetros de salida, 
-- uno con el nombre del pais y otro con el número de lenguas que se hablan en él.
DELIMITER //

CREATE PROCEDURE contarIdiomasPais (IN codigo_pais CHAR(3), OUT nombre_pais VARCHAR(255), OUT num_idiomas INT)
BEGIN
  SELECT Name INTO nombre_pais
  FROM country
  WHERE Code = codigo_pais;
  
  SELECT COUNT(*) INTO num_idiomas
  FROM countrylanguage
  WHERE CountryCode = codigo_pais;
END //

DELIMITER ;

SET @nombre = '';
SET @num_idiomas = 0;

CALL contarIdiomasPais('XXX', @nombre, @num_idiomas);

SELECT CONCAT('Nombre del país: ', @nombre) AS Informacion,
       CONCAT('Número de idiomas: ', @num_idiomas) AS Informacion;
