create database holamundo;
show databases;
use holamundo;
create table animales(
	id int not null auto_increment,
    tipo varchar(255) not null,
    estado varchar(255) not null,
    PRIMARY KEY (id)
);

-- 1.INSERTS
insert into animales (tipo, estado)
values ('chanchito', 'feliz'),
('dragon', 'feliz'),
('felipe', 'triste');

-- 2.SELECT, UPDATE, DELETE
select * from animales;
select * from animales where id = 1;
select * from animales where estado = 'feliz' and tipo = 'chanchito';
select * from animales where estado = 'feliz' or tipo = 'chanchito';

-- El modo seguro sólo permite usar UPDATE Y DELETE si se hace referencia al id
/*
1) Desactivar el modo seguro con la variable. SET sql_safe_updates=0;
2) Ejecutar la sentencia de ACTUALIZACIÓN o ELIMINACIÓN.
3) Volver a activar el modo seguro. SET sql_safe_updates=1;
*/
update animales set estado = 'feliz' where id = 3;
delete from animales where id = 3;

-- 3.CONDICIONES EN PROFUNIDAD

create table user(
	id int not null auto_increment,
    name varchar(50) not null,
    edad int not null,
    email varchar(100) not null,
    primary key (id)
);

insert into user (name, edad, email)
values ('Oscar', 25, 'oscar@gmail.com'),
('Layla', 15, 'layla@gmail.com'),
('Nicolas', 36, 'nicolas@gmail.com'),
('Chanchito', 7, 'chanchito@gmail.com');

-- LIMIT
select * from user limit 1; -- Devuelve el primer registro

-- WHERE
select * from user where edad >= 15 and email = 'nicolas@gmail.com';
select * from user where edad >= 15 or email = 'nicolas@gmail.com';
select * from user where email != 'chanchito@gmail.com';

-- BETWEEN
select * from user where edad between 15 and 30;

-- LIKE
select * from user where email like '%gmail%'; -- Que contenga gmail
select * from user where email like 'chanchito%'; -- Que comience con chanchito

-- ORDER BY
select * from user order by edad asc;
select * from user order by edad desc;

select max(edad) as mayor from user;
select min(edad) as menor from user;

-- 4.JOINS
create table products(
	id int not null auto_increment,
    name varchar(50) not null,
	created_by int not null,
    marca varchar(50) not null,
    primary key (id),
    foreign key (created_by) references user(id)
);

rename table products to product;

insert into product (name, created_by, marca)
values 
	('ipad', 1, 'apple'),
	('iphone', 1, 'apple'),
	('watch', 2, 'apple'),
	('macbook', 1, 'apple'),
    ('imac', 3, 'apple'),
    ('ipad mini', 2, 'apple');
    
select * from product;
-- LEFT JOIN
select u.id, email, p.name from user u left join product p on u.id = p.created_by;

-- RIGHT JOIN
select u.id, email, p.name from user u right join product p on u.id = p.created_by;

-- INNER JOIN
select u.id, email, p.name from user u inner join product p on u.id = p.created_by;

-- 5.GROUP BY, HAVING, DROP TABLE

-- Gracias al group by el conteo se hace de manera uniforme
select count(id), marca from product group by marca;
-- Saber cuantos productos ha creado cada usuario
select count(p.id), u.name from product p left join user u on p.created_by = u.id group by p.created_by;
-- Having es el where para group by
select count(p.id), u.name from product p left join user u on p.created_by = u.id group by p.created_by having count(p.id) >=2; 

-- Borrar una tabla
drop table animales;



