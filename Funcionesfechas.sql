use pruebas2;
CREATE TABLE contactos
   (codigo int(3) zerofill not null auto_increment, 
    nombre VARCHAR(20),
    apellidos VARCHAR(30),
    fecha_nacimiento DATE,
    fecha_contratacion DATE,
    fecha_DNI DATETIME,
    fecha_registro TIMESTAMP DEFAULT now(), -- now() la convierte en CURRENT_TIMESTAMP, NO ADMITE curdate()
    fecha_alta timestamp, 
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(codigo)
    );
    
desc contactos;

select * from contactos;

insert into contactos (nombre, apellidos, fecha_nacimiento,fecha_contratacion,fecha_DNI) values ('juan','lopez','1975-03-12','2018-01-14','1999-12-22');

 SELECT * FROM contactos;   
insert into contactos
(nombre, apellidos, fecha_nacimiento,fecha_contratacion,fecha_DNI)
values
('juan','lopex','1975-03-12', '2000-10-22', '1999-12-22');
    
insert into contactos
(nombre, apellidos, fecha_nacimiento,fecha_contratacion,fecha_DNI, fecha_alta)
values
('Carmen','lopex','1975-03-12', curdate(), '1999-12-22', curtime());

insert into contactos
(nombre, apellidos, fecha_nacimiento,fecha_contratacion,fecha_DNI)
values
('Ana','lopex','1975-03-12', curdate(), now());

-- now, curdate, curtime, day name, dayofweek, dayofyear, date_add, datediff, date_format
-- where year, where motnh

select now();			-- fecha y hora del sistma
select curdate();		-- fecha del sistma
select curtime();		-- hora del sistma

select year('2023-02-15') anio;
select month('2023-02-15') mes;
select day('2023-02-15') dia;

select year(curdate()) anio;
select year(now()) anio;

select hour(now()) hora;
select minute(now()) minutos;

-- alumnos que nacieron en 1980
use colegio;
select * from alumnos where year(Fecha_nacimiento) = 1980;
select * from alumnos where month(Fecha_nacimiento) = 10; -- octubre

-- algunas funciones más
select dayname(curdate());  	-- nombre del día
select dayofweek(curdate()); 	
select dayofyear(curdate()); 	

select date_add(curdate(), INTERVAL 5 DAY);
select date_add(curdate(), INTERVAL 10 MONTH);

-- días de diferencia entre 2 fechas. EL PRIMER PARÁMETRO MAYOR QUE EL SEGUNDO
SELECT DATEDIFF(curdate(), '1998-12-03') AS diferencia;

-- ESTABLECE LA DIFERENCIA ENTRE DOS FECHAS
-- el intervalo establece la diferencia en días, meses o años (DAY, MONTH, YEAR..)
SELECT TIMESTAMPDIFF(DAY, '1998-12-03', CURDATE()) AS diferencia;

SELECT TIMESTAMPDIFF(YEAR, '1998-12-03', CURDATE()) AS diferencia;

USE COLEGIO;
-- CALCULAR LOS AÑOS DE UNA PERSONA
SELECT * , TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) AS edad from alumnos;

SELECT * , TIMESTAMPDIFF(minute, fecha_nacimiento, CURDATE()) AS minutos_vividos from alumnos;

select monthname(curdate());  -- nombre del mes


-- EJEMPLOS DE FORMATOS de date_format
SELECT date_format( CURDATE(), 'En Sevilla, a %a del día %d de %M de %Y') fecha;
SELECT date_format( '1980-03-12', 'En Sevilla, a %a del día %d de %M de %Y') fecha;

SELECT nombre, apellidos, date_format( fecha_nacimiento, 'Nacido el %a del día %d de %M de %Y') fecha from alumnos;