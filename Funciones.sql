-- MATHEMATICAL FUNCTIONS:
-- https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html
/*
MATHEMATICAL FUNCTIONS: mod, sqrt, pi, round, ceil, floor, pow, round
STRING FUNCTIONS: char_length, length, instr, strcmp, concat, right, left, reverse, upper, trim
*/

-- MOD() --> Resto de una división
select mod(6,5) resto;

-- DIVISIÓN:
-- Decimal
select 6/5 cociente; 
-- Entera
select 6 div 5 cociente;

-- SQRT() --> Raíz cuadrada
select sqrt(9) raizCuadrada;

-- PI() --> Número Pi
select pi();

-- ROUND() --> Redondeo --> segundo número (cantidad de decimales)
select round(12.564);
select round(12.564,1);

-- CEIL() Y FLOOR() --> Redondeo hacia arriba o hacia abajo
select ceil(12.1);
select floor(12.9);

-- POW() --> Potencia de un número 
select pow(3,3);

-- ÁREA DEL CÍRCULO
set @radio = 30;
select round((2* pi() * @radio),2) area_circulo;

-- STRING FUNCTIONS
-- https://dev.mysql.com/doc/refman/8.0/en/string-functions.html

-- LENGTH() --> Longitud de una cadena
select char_length('cañón'); -- la longitud medida en caracteres 
select length('cañón'); -- la longitud medida en bytes, por lo tanto una tilde ocuparía un hueco

-- INSTR(cadena,subcadena) --> Devuelve el índice de la primera ocurrencia de la subcadena en la cadena
select instr('MySQL','SQL');

-- STRCMP(cad1,cad2) --> Compara dos cadenas: Si las dos cadenas son iguales devuelve 0, cad1 > cad2 en longitud devuelve -1, cad1 < cad2 en longitud devuelve 1
select strcmp('á','a');
use world;
select name, if(strcmp('kabul',name) = 0, 'son iguales', 'son distintos') comparo from city;

-- CONCAT() --> Concatenar cadenas
select concat('ciudad: ', name) ciudades from city;

-- RIGHT(cadena, num_caracteres) --> Devuelve el número de caracteres que indiques sobre la cadena empezando desde la derecha
-- LEFT(cadena, num_caracteres) --> Devuelve el número de caracteres que indiques sobre la cadena empezando desde la izquierda
select right('holaMundo',5);
select left('holaMundo',4);

-- REVERSE(cadena) --> Devuelve la cadena invertida
select reverse('ivaj');

-- UPPER(cadena) LOWER(cadena) 
select upper('cadena');
select lower('CADENA');

-- TRIM() LTRIM() RTRIM() --> Recorta los espacios en blanco
select trim('          cadena             ') cadenaEspacios;

-- SUBSTRING(cadena, posicion(desde qué posición), longitud(cúantos caracteres)) --> Devuelve subcadena con posicion(inicio) y longitud(fin). Si no especificamos longitud devuelve hasta el final, con -1 empieza desde el final
select substring('holaMundo',1,4);
select substring('holaMundo',5);

-- SUBSTRING_INDEX(cadena, delimitador, número de posición del delimitador) --> Mostrar la cadena hasta el delimitador indicado
select substring_index('gato-perro-pato','-',2);
select substring_index('gato-perro-pato','-',-1);

-- REPLACE(cadena, cadenaBuscar, cadenaReemplazar) --> Buscar una cadena y sustituirla por otra
select replace('mysql.com','com','es');

-- GROUP_CONCAT(expresión) --> Agrupo todos los registros en uno sólo
-- GROUP_CONCAT([distinct] expresion [order by expresion] [separator sep])
use colegio;
select group_concat(departamento) from asignaturas;
select group_concat(departamento separator '---') separa from asignaturas;