drop DATABASE IF EXISTS Bares;
CREATE DATABASE IF NOT EXISTS Bares DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci ;
use Bares;

CREATE TABLE empleado (
	cod_empleado INT unsigned NOT NULL Check (cod_empleado > 0),
	dni_empleado VARCHAR(9) NOT NULL,
	nombre VARCHAR(60) NOT NULL,
	domicilio VARCHAR(60),
	PRIMARY KEY (cod_empleado),
    INDEX idx_nombreE (nombre(10)),
	UNIQUE INDEX idxUQ_dni_Emp (dni_empleado)
) ;

-- show index from empleado;

CREATE TABLE localidad (
	cod_postal varchar(5) NOT NULL ,
	nombre_loc VARCHAR(60) NOT NULL,
    provincia VARCHAR(60) NOT NULL,
	PRIMARY KEY (cod_postal),
    INDEX idx_loc_prov (nombre_loc, provincia),
    CONSTRAINT ck_cp CHECK ((cod_postal >1000 and cod_postal < 60000)) 
) ;

CREATE TABLE pub (
	cod_pub VARCHAR(5) NOT NULL,
	nombre VARCHAR(60) NOT NULL,
	licencia_fiscal VARCHAR(60) NOT NULL,
	domicilio VARCHAR(60) ,
	fecha_apertura DATE NOT NULL,
	horario VARCHAR(60) NOT NULL CHECK (horario in ('HOR1','HOR2','HOR3')) ,
	cod_localidad varchar(5) NOT NULL,
	PRIMARY KEY (cod_pub),
    INDEX idx_nombrePub (nombre(10)),
	INDEX idx_cp (cod_localidad),  -- indice para la foranea
	CONSTRAINT fk_pub_localidad FOREIGN KEY (cod_localidad) REFERENCES localidad (cod_postal) ON UPDATE CASCADE
) ;
-- CONSTRAINT ck_horario CHECK ((horario in ('HOR1','HOR2','HOR3'))) 

CREATE TABLE titular (
	cod_titular INT unsigned NOT NULL Check (cod_titular > 0),
	dni_titular VARCHAR(8) NOT NULL,
	nombre VARCHAR(60) NOT NULL,
	domicilio VARCHAR(60) ,
	cod_pub VARCHAR(5) NOT NULL,
	PRIMARY KEY (cod_titular),
	INDEX idx_nombreTitu (nombre(10)),
    UNIQUE INDEX idxUQ_dni_Titu (dni_titular),
	INDEX idx_pub (cod_pub),
	CONSTRAINT fk_titular_pu FOREIGN KEY (cod_pub) REFERENCES pub (cod_pub) ON UPDATE CASCADE
) ;

CREATE TABLE existencias (
	cod_articulo VARCHAR(10) NOT NULL,
	nombre VARCHAR(60) NOT NULL,
	cantidad INT UNSIGNED NOT NULL,
	precio DECIMAL UNSIGNED NOT NULL CHECK ((precio > 0)) ,
	cod_pub VARCHAR(5) NOT NULL ,
	PRIMARY KEY (cod_articulo),
    INDEX idx_nombreEx (nombre(10)),
	INDEX (cod_pub),
	CONSTRAINT fk_existencias_pub FOREIGN KEY (cod_pub) REFERENCES pub (cod_pub) ON UPDATE CASCADE
) ;
-- CONSTRAINT ck_precio CHECK ((precio <> 0))


CREATE TABLE pub_empleado (
cod_pub VARCHAR(5) NOT NULL,
cod_empleado INT unsigned NOT NULL,
funcion VARCHAR(9) NOT NULL CHECK( funcion in ('CAMARERO','SEGURIDAD','LIMPIEZA')),
 PRIMARY KEY (cod_pub,cod_empleado,funcion),
  INDEX (cod_empleado),
  INDEX (cod_pub),
  CONSTRAINT fk_pubemple_empleado FOREIGN KEY (cod_empleado) REFERENCES empleado (cod_empleado) ON UPDATE CASCADE,
  CONSTRAINT fk_pubemple_pub FOREIGN KEY (cod_pub) REFERENCES pub (cod_pub) ON UPDATE CASCADE
 );

-- CONSTRAINT ck_funcion CHECK ((funcion in ('CAMARERO','SEGURIDAD','LIMPIEZA')))
-- -----------------------------
