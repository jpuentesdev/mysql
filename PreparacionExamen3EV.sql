-- FUNCIONES:

-- MATHEMATICAL FUNCTIONS:
-- https://dev.mysql.com/doc/refman/8.0/en/mathematical-functions.html
-- STRING FUNCTIONS
-- https://dev.mysql.com/doc/refman/8.0/en/string-functions.html

/*
MATHEMATICAL FUNCTIONS: mod, sqrt, pi, round, ceil, floor, pow, round
STRING FUNCTIONS: char_length, length, instr, strcmp, concat, right, left, reverse, upper, trim
DATE FUNCTIONS: now, curdate, curtime, day name, dayofweek, dayofyear, date_add, datediff, date_format
-- where year, where motnh
*/


-- SUBCONSULTAS: 

/*
Las subconsultas son SELECTS DENTRO DE SELECTS
Permiten consultas estructuradas y un modo alternativo de realizar operaciones que de otro modo necesitarían joins y uniones complejos 
*/

/*
TIPOS DE SUBCONSULTAS
1. Subconsultas escalares devuelven un solo valor, es decir, una fila con una columna
de datos.
2. Subconsultas de columna devuelven una sola columna con una o más filas de datos.
3. Subconsultas de registro devuelven una única fila con una o más columnas de datos.
4. Tabla de subconsultas devuelven un resultado con una o más filas que contienen una
o más columnas de datos.
*/

/*
Operadores para subconsultas:
1) Uso de ALL, ANY y SOME
2) Uso de operadores IN , NOT IN
3) Uso de operadores EXISTS , NOT EXISTS
*/


-- PROCEDURES / PROCEDIMIENTOS

/*
Un procedimiento almacenado MySQL es una porción de código que se puede
guardar y reutilizar. Es útil cuando repites la misma tarea repetidas veces, siendo un
buen método para encapsular el código.
*/

/*
DELIMITER
Mysql toma como delimitador de sentencias SQL el punto y coma. Cada vez
que encuentra un punto y coma intenta ejecutar la orden SQL.
*/

/*
EJECUCIÓN DE PROCEDIMIENTOS

CALL nombre_procedimiento (param1, param2, paramN);

PARÁMETROS
1) IN
2) OUT
3) INOUT
*/

/*
VARIABLES LOCALES.

Podemos declarar locales variable utilizando DECLARE

Asignación de valores con SET
- Con una sentencia SET podemos hacer asignación simple o múltiple.

Asignación de valores con SELECT ... INTO
- The SELECT ... INTO statement assigns the result of a SELECT statement to
variables.
*/


-- CONTROL DE FLUJO:
-- IF, CASE Y WHILE

