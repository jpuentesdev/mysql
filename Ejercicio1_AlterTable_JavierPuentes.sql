-- EJERCICIOS ALTER TABLE.

-- Utiliza la Base de Datos Colegio de 2 tablas.
use colegio;
desc alumnos;
desc asignaturas;

-- 1) Modifica el nombre del campo telefono_movil a telefonoM.
alter table alumnos change telefono_movil telefonoM varchar(45);

-- 2) Modifica el campo nombre a varchar(60) caracteres.
alter table alumnos modify Nombre varchar(60);

-- 3) Añade un nuevo campo sexo, el tipo es un char de un caracter, por defectos es &#39;F&#39; y
-- con una restriccion ckeck que sólo permita los valores M o F; además debe ir antes de la dirección.
alter table alumnos add sexo char(1) default 'F' not null check (sexo in('M','F')) after apellidos;

-- 4) Modifica el campo cp a CodigoPostal (es un número de 5 dígitos) cambia al valor que creas más oportuno, debe ser sin signo.
alter table alumnos change CP CodigoPostal int unsigned;

-- 5) Modifica el campo nombre y apellidos a un varchar(100) caracteres y provincia a varchar(30) caracteres. En la misma sentencia.
alter table alumnos modify nombre varchar(100), modify apellidos varchar(100), modify provincia varchar(30);

-- 6) Inserta un nuevo campo correoContacto, varchar(150) no nulo. Irá después del campo telefonoM.
alter table alumnos add correoContacto varchar(150) not null after telefonoM;

-- 7) El campo correoContacto se llamará correoPersonal.
alter table alumnos change correoContacto correoPersonal varchar(150) not null;

-- 8) Inserta los correos de cada alumno.
select Nombre, apellidos, lcase(concat(nombre,dni,'@gmail.com')) as email from alumnos;
SET sql_safe_updates=0;
update alumnos set correoPersonal = lcase(concat(nombre,dni,'@gmail.com'));
SET sql_safe_updates=1;

-- 11) Carmen Moreno García ha cambiado su domicilio a C/ Arganzuela, 32 de Madrid, CP=28021 cambiar los datos necesarios.
select * from alumnos where Codigo_alumno = 101;
update alumnos set Direccion = 'C/Arganzuela, 32' where Codigo_alumno = 101;
update alumnos set Localidad = 'Madrid' where Codigo_alumno = 101;
update alumnos set CodigoPostal = 28021 where Codigo_alumno = 101;

-- 12) Elimina la clave foránea que tiene alumnos con asignaturas.
show index from alumnos;
alter table alumnos drop foreign key Codigo_asignatura;
 
-- 13) Elimina las claves principales de las tablas alumnos y asignaturas.
alter table alumnos drop primary key;
alter table asignaturas drop primary key;

-- 14) Vuelve a crear las claves principales.
alter table alumnos add primary key (Codigo_alumno);
alter table asignaturas add primary key (Codigo);

-- 15) Vuelve a crear las claves foráneas.
alter table alumnos add constraint fk_codigoAsig foreign key (Codigo_asignatura) references asignaturas (codigo) on delete no action on update cascade;

-- 16) Inserta 2 nuevos alumnos.
select * from alumnos;
insert into alumnos (Codigo_alumno, DNI, nombre,apellidos,sexo,Direccion,Localidad,provincia,correoPersonal,Codigo_asignatura)
values (116, '29583456G', 'Roberto', 'López Mina', 'M', 'C/ Tendillas, 5', 'Córdoba', 'Córdoba', 'roberto29583456g@gmail.com',1),
(117, '21337458F', 'Mar', 'Puentes Cabrerizo', 'F', 'C/ Tendillas, 11', 'Córdoba', 'Córdoba', 'mar21337458f@gmail.com',2);

-- **** Añade los siguientes índices: Utiliza ALTER TABLE.

-- 17) Indexa el campo DNI. Decide qué índice es el más adecuado.
alter table alumnos add UNIQUE INDEX idxUQ_dni_alumn (DNI);

-- 18) Indexa los campos nombre y apellidos en un índice compuesto.
alter table alumnos add INDEX idx_nomAp_alumn (nombre,apellidos);

-- 19) Crea el índice provincias.
alter table alumnos add INDEX idx_prov_alumn (provincia);

-- 20) Elimina el índice provincias.
alter table alumnos drop index idx_prov_alumn;

-- 21) Crea un índice con los 4 primeros caracteres de la localidad.
alter table alumnos add index idx_localidad_alumn ((left(localidad, 4)));

-- 22) Elimina los índices anteriores con ALTER TABLE
alter table alumnos drop index idxUQ_dni_alumn, drop index idx_nomAp_alumn, drop index idx_localidad_alumn; 

-- Crea todos los índices anteriores con CREATE INDEX. Luego los eliminas con DROP INDEX.
create unique index idxUQ_dni_alumn on alumnos(DNI);
create index idx_nomAp_alumn on alumnos(nombre, apellidos);
create index idx_prov_alumn on alumnos(provincia);

drop index idxUQ_dni_alumn on alumnos;
drop index idx_nomAp_alumn on alumnos;
drop index idx_prov_alumn on alumnos;
