/*
Las subconsultas son SELECTS DENTRO DE SELECTS
Permiten consultas estructuradas y un modo alternativo de realizar operaciones que de otro modo necesitarían joins y uniones complejos 
*/
use world;
select * from city;
select * from country;
select * from countrylanguage;

-- SUBCONSULTA ESCALAR -->

-- Muestra el país con la ciudad más poblada del mundo
select id, name, countryCode, population from city where population= 10500000;

select id, name, countryCode, population from city where population= (select max(population) from city);

-- Ratio de la población en ciudades con la población en los países en su totalidad
select sum(population) from city;
select sum(population) from country;

select (select sum(population) from city) / (select sum(population) from country) as ratio;

-- Variables
set @a = (select sum(population) from city);
set @b = (select sum(population) from country);
select round(@a/@b, 4) as ratio;

create or replace view ratios
as
select (select sum(population) from city) / (select sum(population) from country) as ratio;

select * from ratios;
select ratio into @ra from ratios;
select 2589/@ra;

-- paso a variable el nombre, codigo pais y distrito de ciudades
select name, countryCode, district into @ciudad, @pais, @distrito from city where id = 15;
select @ciudad, @pais, @distrito;

-- SUBCONSULTA DE COLUMNA -->

-- Muestra las lenguas que se hablan en Finlandia

select code from country where name like 'FINLAND';

select countryCode, language, isOfficial from countryLanguage where countryCode = (select code from country where name like 'FINLAND');

-- Ejemplo con JOINS, SIN SUBCONSULTA --> si se puede hacer con join mejor optar por ello

select language 
from countryLanguage
inner join country on countrycode = code and country.name like 'Finland';

-- SUBCONSULTA DE FILA -->

-- Capital de España
select capital, code from country where name like 'Spain';

select id, name, district from city where (id, countryCode) = (select capital, code from country where name like 'Spain');

/*
Ejemplo de subconsulta como CAMPO de un select.
Número de idiomas que se hablan en cada país, HAY QUE MOSTRAR EL NOMBRE DEL PAÍS
*/

select name, (select count(language) from countryLanguage where countryCode = code) as numLenguas from country;

/*
SUBCONSULTA CORRELACIONADA: referencian la consulta externa y no puede evaluarse por separado
país más poblado de cada continente
*/

select continent, max(population) from country group by continent;

select continent continente, name pais, population poblacion
from country 
where population = (select max(population) from country as C2 
					where country.continent = C2.continent and C2.population > 0);