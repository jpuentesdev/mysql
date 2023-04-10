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

