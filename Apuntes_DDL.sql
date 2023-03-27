-- CREAR BASE DE DATOS
create database if not exists pruebas;
use pruebas;

create schema if not exists pruebas2 character set latin1 collate latin1_spanish_ci;
use pruebas2;

-- Para saber los juegos de carcateres y las colations (mirando en el diccionario de datos)
show character set;

show character set like 'utf%';
show collation where charset = 'utf8mb4';

select * from information_schema.schemata;

-- BORRAR BASE DE DATOS
drop database if exists pruebas2;

use pruebas;

-- TABALAS TEMPORALES
/*
--> Copias de bases de datos ya existentes 
--> Dura hasta que cierres sesión o la eliminas ( drop temporary ...)  
--> Tiene una finalidad de testeo/ pruebas
--> Para hacer consultas no se utilizan, para las modificaciones sí
*/

create table if not exists tabla_origen(
	id int auto_increment not null primary key,
    descripcion varchar(30),
    fecha timestamp default current_timestamp
);    

describe tabla_origen;

insert into tabla_origen (descripcion)
values 
('mesa'), ('silla'), ('armario');

select * from tabla_origen;

update tabla_origen set descripcion = 'mesita de noche' where id = 1;

-- EJERCICIO1

create table if not exists padre (
	id int not null,
    nombre varchar(30),
    primary key(id)
);

create table if not exists hijo (
	id int not null primary key,
    nombre varchar(30),
    id_padre int not null,
    index idx_padre (id_padre),
    constraint fk_mi_padre foreign key(id_padre) references padre(id)
    on update cascade 
    on delete restrict
);

-- EJERCICIO2

create table if not exists producto(
	referencia int not null,
    categoria int not null,
    precio decimal(8,2),  -- 5 números de la parte entera, 1 del punto y 2 de la parte decimal
    primary key (referencia, categoria)
);

create table if not exists factura(
	numero int not null auto_increment primary key,
    concepto varchar(100) not null,
    
    referencia_p int not null,
    categoria_p int not null,
    id_cliente int not null,
    
    index idx_producto (referencia_p, categoria_p),
    constraint fk_producto foreign key (referencia_p, categoria_p) references producto (referencia, categoria),
    
    index idx_cliente (id_cliente),
    constraint fk_cliente foreign key (id_cliente) references cliente (id)
);

create table if not exists cliente(
	id int not null primary key,
    nombre varchar(30) not null
);

-- CHECK CONSTRAINTS --> Restricciones
-- EJEMPLO --> constraint chk_cargo check (cargo in ('camarero', 'seguridad', 'limpieza');

create table if not exists libros3(
	id int unsigned not null primary key,
    titulo varchar(50),
    num_pag int check (num_pag > 10),
    editorial varchar(50) not null check (editorial in ('ALFAGUARA', 'SM', 'ANAYA')),
    precio int not null ,
    constraint chk_precio check (precio > 0 and precio < 60)
);

insert into libros3 
values
(1, 'La Regenta', 850, 'ALFAGUARA', 20);

insert into libros3 values (2, 'El buscón', 10, 'ALFAGUARA', 20);

select * from libros3;

create index idx_tit on libros3(titulo);

show index from libros3;


