-- EJERCICIOS CON VISTAS

/*
Ejercicios 1:
1) Crea una vista de la tabla Country llamada Paises, que muestre todos los países 
cambiando el nombre de los campos a castellano

2) Crea una vista VistaEuropa de la tabla City, que muestre todos los datos de las ciudades 
del continente europeo (cambiar el código del país por su nombre), cambiando el nombre
de los campos al castellano

3) Crea una vista VISTA_CAPITALES en la que aparezca el código, nombre, continente y region
de los paises junto con el nombre de su capital. Los campos de la vista en castellano
*/
use world;
select * from country;
select * from city;

-- 1.1)
CREATE VIEW Paises AS
SELECT Code Codigo, Name Nombre, Continent Continente, Region Region,
SurfaceArea Area, IndepYear Anio_Independencia, Population Poblacion,
LifeExpectancy Esperanza_Vida, GNP PIB, GNPOld PIB_Anterior,
LocalName Nombre_Local, GovernmentForm Forma_Gobierno, HeadOfState Jefe_Estado,
Capital Capital, Code2
FROM Country;

-- 1.2)
CREATE VIEW VistaEuropa AS
SELECT City.Name Nombre, Country.Name Pais, District Distrito, City.Population Poblacion,
Country.Code Codigo_Pais, Continent Continente
FROM City
INNER JOIN Country ON CountryCode = Code
WHERE Continent = 'Europe';

-- 1.3)
CREATE VIEW VISTA_CAPITALES AS
SELECT Country.Code Codigo, Country.Name Pais, Country.Continent Continente, 
Country.Region Region, City.Name Capital
FROM Country
INNER JOIN City ON Capital = ID;


-- Ejercicios 2:

-- 1. Crea una vista llamada iberia, basada en la table city que solo tenga el nombre, la región
-- y la población de las ciudades españolas.
CREATE VIEW iberia AS 
SELECT Name, Region, Population FROM city 
WHERE CountryCode = 'ESP';

-- 2. Vuelve a crear la vista iberia, pero solamente con las ciudades andaluzas.
-- a. ¿Qué ocurre?
-- b. ¿Cómo se soluciona?
CREATE VIEW iberia AS 
SELECT Name, Region, Population FROM city 
WHERE CountryCode = 'ESP' AND Region = 'Andalucía';
/*
a. Al ejecutar esta consulta se reemplaza la vista anteriormente creada "iberia".
b. Para solucionar este problema se puede añadir IF NOT EXISTS antes del CREATE VIEW.
*/

-- 3. ¿Se pueden crear vistas basadas en INNER JOINS? Pon un ejemplo
CREATE VIEW orders_with_customer_info AS
SELECT o.order_id, o.order_date, c.customer_name, c.customer_address
FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id = c.customer_id;

-- 4. Crea una vista llamada “nocapital” que obtenga el nombre, el continente y la población
-- de los países que no tienen capital.
CREATE VIEW nocapital AS 
SELECT Name, Continent, Population FROM country 
WHERE Capital IS NULL;

-- 4-b Crea una vista llamada “nocapital” que obtenga
-- el nombre, el continente y la población de las ciudades que no sean capital.
CREATE VIEW nocapital AS 
SELECT Name, CountryCode, Population FROM city 
WHERE ID NOT IN (SELECT Capital FROM country);

-- 5. Obtén una vista llamada “capitales” que muestre el nombre de la ciudad, el nombre del
-- país y el continente de las ciudades que son capital de algún país.
CREATE VIEW capitales AS 
SELECT city.Name, country.Name AS Country, country.Continent 
FROM city 
INNER JOIN country ON city.ID = country.Capital;

-- 6. Crea una vista llamada “ciudades_esp” con el nombre del país, el nombre de la ciudad y
-- el continente de las ciudades de España que no son capital.
CREATE VIEW ciudades_esp AS 
SELECT country.Name, city.Name AS City, country.Continent 
FROM city 
INNER JOIN country ON city.CountryCode = country.Code 
WHERE city.CountryCode = 'ESP' AND city.ID NOT IN (SELECT Capital FROM country);

-- 7. Cree la vista ciudades_esp2, basada en la vista ciudades_esp.
CREATE VIEW ciudades_esp2 AS 
SELECT * FROM ciudades_esp;

-- 8. Elimine la vista base de ciudades_esp2.
DROP VIEW ciudades_esp;

-- Compruebe qué ocurre en la vista ciudades_esp2.

-- Al eliminar la vista base de "ciudades_esp", la vista "ciudades_esp2" 
-- ya no tendrá una fuente de datos, por lo que se volverá inválida y no se podrá utilizar 
-- hasta que se actualice su definición.


/*
Ejercicios 3
1) Utiliza la BD colegio y crea 5 vista HAZ PRUEBAS Y DOCUMENTA TODO EL
PROCESO.
2) Utiliza la BD tienda_informatica y crea 5 HAZ PRUEBAS Y DOCUMENTA TODO EL
PROCESO.
*/
-- 1)
-- a) Vista que muestre el nombre y la edad de los estudiantes que tengan más de 15 años:
CREATE VIEW estudiantes_mayores_de_15 AS
SELECT nombre, edad
FROM estudiantes
WHERE edad > 15;

-- b) Vista que muestre el nombre y la nota media de los estudiantes ordenados de mayor a menor nota:
CREATE VIEW notas_estudiantes AS
SELECT nombre, (nota_mate + nota_lengua + nota_historia) / 3 AS nota_media
FROM estudiantes
ORDER BY nota_media DESC;

-- c) Vista que muestre el nombre y la asignatura que mejor nota ha sacado cada estudiante:
CREATE VIEW mejor_nota_por_estudiante AS
SELECT nombre, 
CASE
   WHEN nota_mate >= nota_lengua AND nota_mate >= nota_historia THEN 'Matemáticas'
   WHEN nota_lengua >= nota_mate AND nota_lengua >= nota_historia THEN 'Lengua'
   WHEN nota_historia >= nota_mate AND nota_historia >= nota_lengua THEN 'Historia'
END AS mejor_asignatura
FROM estudiantes;

-- d) Vista que muestre el nombre y la edad de los profesores que imparten más de una asignatura:
CREATE VIEW profesores_con_varias_asignaturas AS
SELECT p.nombre, p.edad
FROM profesores p
INNER JOIN clases c ON c.id_profesor = p.id_profesor
GROUP BY p.id_profesor
HAVING COUNT(c.id_asignatura) > 1;

-- e) Vista que muestre el nombre y la edad de los profesores que imparten alguna asignatura a estudiantes mayores de 15 años:
CREATE VIEW profesores_de_estudiantes_mayores_de_15 AS
SELECT DISTINCT p.nombre, p.edad
FROM profesores p
INNER JOIN clases c ON c.id_profesor = p.id_profesor
INNER JOIN estudiantes e ON c.id_estudiante = e.id_estudiante
WHERE e.edad > 15;

-- 2)
-- a) Vista que muestre el nombre y el precio de los productos ordenados de mayor a menor precio:
CREATE VIEW productos_por_precio AS
SELECT nombre, precio
FROM productos
ORDER BY precio DESC;

-- b) Vista que muestre el nombre de los clientes que han realizado alguna compra en la tienda en los últimos 30 días:
CREATE VIEW clientes_ultimos_30_dias AS
SELECT DISTINCT c.nombre
FROM clientes c
INNER JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.fecha > DATE_SUB(NOW(), INTERVAL 30 DAY);

-- c) Vista que muestre el nombre y la cantidad de stock de los productos que tienen menos de 10 unidades en stock:
CREATE VIEW productos_poco_stock AS
SELECT nombre, stock
FROM productos
WHERE stock < 10;

-- d) Vista que muestre el nombre y el precio de los productos que tienen algún descuento aplicado:
CREATE VIEW productos_con_descuento AS
SELECT nombre, precio
FROM productos
WHERE descuento > 0;

-- e) Vista que muestre el nombre y la dirección de los proveedores que han suministrado algún producto en los últimos 90 días:
CREATE VIEW proveedores_ultimos_90_dias AS

/*
EJERCICIO 4
Crea dos ejercicios de UNION para cada una de las BD de este ejercicio. Es decir, una con
UNION Y OTRA CON UNION ALL , para cada una de las BD.
*/

-- Ejercicio 1 - BD colegio:
/*
Ejemplo 1 - UNION:
Supongamos que queremos obtener una lista completa de los estudiantes, tanto de primaria como de secundaria, con sus nombres y edades. 
Podríamos hacerlo con una consulta UNION de la siguiente manera:
*/
SELECT nombre, edad, 'Primaria' AS nivel FROM primaria
UNION
SELECT nombre, edad, 'Secundaria' AS nivel FROM secundaria;
/*
Esta consulta mostrará una lista de todos los estudiantes, con sus nombres, edades y el nivel al que pertenecen (primaria o secundaria), 
eliminando cualquier duplicado.
*/

/*
Ejemplo 2 - UNION ALL:
Supongamos que queremos obtener una lista de los profesores de todas las asignaturas, tanto de primaria como de secundaria, con sus nombres 
y salarios. Podríamos hacerlo con una consulta UNION ALL de la siguiente manera:
*/
SELECT nombre, salario, 'Primaria' AS nivel FROM primaria_profesores
UNION ALL
SELECT nombre, salario, 'Secundaria' AS nivel FROM secundaria_profesores;
/*
Esta consulta mostrará una lista de todos los profesores, con sus nombres, salarios y el nivel al que pertenecen (primaria o secundaria), 
incluyendo cualquier duplicado.
*/


-- Ejercicio 2 - BD tienda_informatica:
/*
Ejemplo 1 - UNION:
Supongamos que queremos obtener una lista completa de todos los productos de la tienda, tanto hardware como software, con sus nombres y precios. 
Podríamos hacerlo con una consulta UNION de la siguiente manera:
*/
SELECT nombre, precio, 'Hardware' AS tipo FROM hardware
UNION
SELECT nombre, precio, 'Software' AS tipo FROM software;
/*
Esta consulta mostrará una lista de todos los productos, con sus nombres, precios y el tipo al que pertenecen (hardware o software), 
eliminando cualquier duplicado.
*/

/*
Ejemplo 2 - UNION ALL:
Supongamos que queremos obtener una lista de los clientes de la tienda que han realizado compras en los últimos 3 meses, 
tanto en la tienda física como en la tienda online, con sus nombres y correos electrónicos. Podríamos hacerlo con 
una consulta UNION ALL de la siguiente manera:
*/
SELECT nombre, correo_electronico, 'Tienda física' AS tipo_compra FROM clientes_tienda_fisica
WHERE fecha_ultima_compra >= DATE_SUB(NOW(), INTERVAL 3 MONTH)
UNION ALL
SELECT nombre, correo_electronico, 'Tienda online' AS tipo_compra FROM clientes_tienda_online
WHERE fecha_ultima_compra >= DATE_SUB(NOW(), INTERVAL 3 MONTH);
/*
Esta consulta mostrará una lista de todos los clientes que han realizado compras en los últimos 3 meses, con sus nombres, 
correos electrónicos y el tipo de compra que realizaron (tienda física o tienda online), incluyendo cualquier duplicado.
*/