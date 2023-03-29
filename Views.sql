use pruebas2;

-- VIEWS

create table tabla1(
cantidad int,
precio int
);

insert into tabla1
values 
(3,50),
(4,80);

select * from tabla1;

-- vista1
create view vista1
as
select cantidad, precio, (cantidad * precio) total from tabla1;

select * from vista1;
show create view vista1; -- ver el código de la vista

-- vista 2 --> cambiar el nombre de los campos de la tabla --> debes de introducir el mismo número de campos que en la tabla de referencia, en el orden que te convenga
create or replace view vista2 (cantidad_almacen, precio_venta, subtotal)
as
select cantidad, precio, (cantidad * precio) total from tabla1;

select * from vista2;

-- vista 3 --> vista creada desde otra vista con el total de los subtotales
create or replace view vista3
as
select sum(subtotal) total from vista2;

select * from vista3;


use world;

-- vista con los códigos y nombres de ciudades
create or replace view vistaciudades (codigo, ciudad)
as
select id, name from city;

select * from vistaciudades;

-- vista con el nombre de los países y sus ciudades 
select country.name, city.name
from country
inner join city on code = countryCode;

create or replace view paisesYciudades (pias, ciudad)
as
select country.name, city.name
from country
inner join city on code = countryCode;

select * from paisesYciudades;

-- 
select code, name, continent, language, isOfficial
from country
inner join countryLanguage on code = countrycode;

create or replace view paises_idiomas (cod_pais, nombre_pais, continente, idioma, es_oficial)
as
select code, name, continent, language, if(isOfficial like 'T', 'es oficial', 'NO oficial') oficial
from country
inner join countryLanguage on code = countrycode;

select * from paises_idiomas;

-- vista con el número de países que tiene cada continente
select distinct continent, count(continent) num_paises_continente
from country group by continent;

create or replace view num_pais_conti
as
select distinct continent continente, count(continent) num_paises_continente   -- el alias de la vista puesto en el select al lado del nombre del campo de la tabla de referencia
from country group by continent;

select * from num_pais_conti
