DROP DATABASE IF EXISTS pruebas2;
CREATE DATABASE IF NOT EXISTS pruebas2 DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci ;
use pruebas2;

create table t1(
	a int,
	b char(10),
	c int,
	d int
);

-- renombrar la tabla:
alter table t1 rename t2;
show tables;

alter table t2 rename t1;
show tables;

-- renombrar campos:
-- CHANGE --> Se utiliza cuando queremos modificar el nombre
alter table t1 change a campoA int;  -- poner el tipo del campo es obligatorio
desc t1;

alter table t1 change b campoB varchar(10) not null;
alter table t1 change campoB campoB varchar(10) null; -- si no quieres cambiar el nombre del campo deberás de nombrarlo dos veces

-- MODIFY --> NO puedo cambiar el nombre de los campos, pero sí todas sus características --> este comando lo incorporó Oracle a mysql
alter table t1 modify campoB varchar(10) not null default 'default';
alter table t1 modify c decimal(5,2);

-- añadir campos: --> se puede usar tanto FIRST COMO AFTER para especificar en qué sitio lo queremos colocar
alter table t1 add nombre varchar(20) not null; -- se añade al final por defecto
desc t1;
alter table t1 add dni varchar(9) first; -- se añade al principio
alter table t1 add apellido varchar(20) after d; -- lo añadimos detrás del campo especificado

-- eliminar columnas: --> se pueden combinar varias sentencias pero sólo de la misma tabla
alter table t1 drop c, drop d; 
desc t1;

-- añadir índices: 
alter table t1 add primary key (dni), add index (apellido);
desc t1;
show index from t1;

-- eliminar ínidces: --> si se borra algún campo con el que se creó el index, se borrará también el index
alter table t1 drop index apellido;
alter table t1 drop primary key; -- para eliminar la pk no se especifica el nombre 

-- Práctica
create table t2(
a integer,
b char(10)

);
desc t2;

alter table t2 modify a int unsigned not null, change b campoB varchar(20);
alter table t2 add campoC timestamp;
alter table t2 add index (a) , add index (campoB); -- el nombre del índice es el mismo que el de la columna debido a que no estamos utilizando CONSTRAINT
show index from t2;
alter table t2 add id int not null auto_increment primary key first; 

-- añadir clave foránea:
-- alter table nombreTabla add constraint nombreFk foreign key (codigo) references nombreTabla (codigo2) on delete no action on update cascade;