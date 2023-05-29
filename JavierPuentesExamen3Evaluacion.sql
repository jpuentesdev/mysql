-- Javier Puentes Cabrerizo

USE VentasEx_Ev3;


-- EJERCICIO 1:

-- 1) Añade el campo correo entre ciudad y categoría a la tabla cliente, tendrá 100 caracteres. Comprueba despúes si está bien.
ALTER TABLE cliente ADD correo VARCHAR(100) AFTER ciudad;

DESCRIBE cliente;

-- 2) Rellena los correos concatenando el id y las 4 primeras letras del nombre del cliente y como dominio pon javier.es, el correo debe ir en minúsculas. Realiza pruebas antes de actualizar. Comprueba despúes si está bien.
SELECT id, nombre, CONCAT(LOWER(SUBSTRING(nombre, 1, 4)), id, '@javier.es') AS correo FROM cliente;

-- Desactictivo el modo seguro de Mysql y luego lo vuelvo a activar:
 SET SQL_SAFE_UPDATES= 0;
 SET SQL_SAFE_UPDATES= 1;

UPDATE cliente SET correo = CONCAT(LOWER(SUBSTRING(nombre, 1, 4)), id, '@javier.es');

SELECT id, nombre, correo FROM cliente;

-- 3) Modifica el campo nombre, apellido1, apellido2 a 60 caracteres, todo en la misma sentencia. Comprueba despúes si está bien.
ALTER TABLE cliente
MODIFY nombre VARCHAR(60),
MODIFY apellido1 VARCHAR(60),
MODIFY apellido2 VARCHAR(60);

DESCRIBE cliente;

-- 4) Crea una copia de la tabla cliente llamada cliente2 sólo con los clientes de Sevilla. Añade un nuevo sevillano a cliente2. Comprueba despúes si está bien.
CREATE TABLE cliente2 AS SELECT * FROM cliente
WHERE ciudad = 'Sevilla';

INSERT INTO cliente2 (nombre, apellido1, apellido2, ciudad, categoria)
VALUES ('Javier', 'Puentes', 'Cabrerizo', 'Sevilla', 150);

DESCRIBE cliente2;
SELECT * FROM cliente2 WHERE nombre LIKE 'Javier';

-- 5) Crea una VISTA llamada vistaClientes que una las tablas cliente y cliente2, sin repetición de registros. Y otra vista llamada vistaClientesTodos que una ambas tablas con todos los registros. Comprueba despúes si está bien.
-- Vista 1:
CREATE VIEW vistaClientes AS SELECT * FROM cliente
UNION
SELECT * FROM cliente2;

-- Comprobación Vista 1:
SELECT * FROM vistaClientes;

-- Vista 2:
CREATE VIEW vistaClientesTodos AS SELECT * FROM cliente
UNION ALL
SELECT * FROM cliente2;

-- Comprobación Vista 2:
SELECT * FROM vistaClientesTodos;


-- EJERCICIO 2

-- 1) Crea una vista llamada v_pedidos con la siguinete consulta. ¿Cánto se ha ingresado de los pedidos del cliente Aarón Rivero? Muestra todos los datos necesarios.
CREATE VIEW v_pedidos AS SELECT p.id, p.total, p.fecha, c.nombre, c.apellido1, c.apellido2 FROM pedido AS p
JOIN cliente AS c ON p.id_cliente = c.id;

-- Comprobación:
SELECT SUM(total) AS ingreso_total FROM v_pedidos
WHERE nombre = 'Aarón' AND apellido1 = 'Rivero';

-- 2) Crea una vista v_cuentaAnio. En la misma consulta, cuenta el número de pedidos por año, media de pedidos por año y total de ingresos por año.
CREATE VIEW v_cuentaAnio AS
SELECT YEAR(fecha) AS anio, COUNT(*) AS num_pedidos, AVG(total) AS media_pedidos, SUM(total) AS total_ingresos FROM pedido
GROUP BY YEAR(fecha);

-- Comprobación:
SELECT anio, num_pedidos, media_pedidos, total_ingresos FROM v_cuentaAnio;

-- 3) Crea una vista v_totalAnio (Utiliza la vista anterior). Muestra el número total de pedidos, el dinero total ingresado por pedidos, y la media total de ingresos.
CREATE VIEW v_totalAnio AS
SELECT 
    SUM(num_pedidos) AS total_pedidos,
    SUM(total_ingresos) AS total_ingresos,
    AVG(total_ingresos) AS media_ingresos
FROM v_cuentaAnio;

-- Comprobación:
SELECT total_pedidos, total_ingresos, media_ingresos FROM v_totalAnio;


-- EJERCICIO 3 -SUBCONSULTAS

-- 1)Devuelve los datos del cliente y del pedido del cliente que realizó el pedido más caro en el año 2019.
SELECT c.id, c.nombre, c.apellido1, c.apellido2, p.id AS id_pedido, p.total FROM cliente AS c
JOIN pedido AS p ON c.id = p.id_cliente
WHERE p.total = (
    SELECT MAX(total) FROM pedido
    WHERE YEAR(fecha) = 2019
);

-- 2) Devuelve un listado de los datos de los comerciales que no han realizado ningún pedido.
SELECT id, nombre, apellido1, apellido2, comision FROM comercial
WHERE id NOT IN (
    SELECT DISTINCT id_comercial
    FROM pedido
);

-- 3) Devuelve un listado con los datos de los clientes y los pedidos, de todos los clientes que han realizado un pedido durante el año 2017 con un valor mayor o igual al valor medio de los 
-- pedidos realizados durante ese mismo año.
SELECT c.id, c.nombre, c.apellido1, c.apellido2, p.id AS id_pedido, p.total FROM cliente AS c
JOIN pedido AS p ON c.id = p.id_cliente
WHERE YEAR(p.fecha) = 2017
  AND p.total >= (
    SELECT AVG(total)
    FROM pedido
    WHERE YEAR(fecha) = 2017
  );


-- EJERCICIO 4 - PROCEDIMIENTOS ALMACENADOS

-- 1) Crea un procedimiento pedidosPorFechas que reciba una fecha y muestre por pantalla los pedidos realizados en dicha fecha, si no hay ningún pedido, mostrará por pantalla 'No se han registrado pedidos en la fecha indicada'.
-- Realiza todas las pruebas necesarias para tener en cuenta todos los casos.
DELIMITER //

CREATE PROCEDURE pedidosPorFechas(IN fecha_param DATE)
BEGIN
    DECLARE pedidos_count INT;
    
    SELECT COUNT(*) INTO pedidos_count FROM pedido
    WHERE fecha = fecha_param;
    
    IF pedidos_count > 0 THEN
        SELECT * FROM pedido
        WHERE fecha = fecha_param;
    ELSE
        SELECT 'No se han registrado pedidos en la fecha indicada';
    END IF;
END //

DELIMITER ;

-- Testeo 1 (Donde si se encuentran pedidos)
CALL pedidosPorFechas('2016-09-10');
-- Testeo 2 (Donde no se encuentran pedidos)
CALL pedidosPorFechas('2022-01-01');


-- 2) Crea un procedimiento cobroComerciales que reciba el nombre y apellido1 de un comercial y devuelva el VALOR total de comisiones recibidas de todos sus pedidos. Si el comercial no ha realizado pedidos, 
-- el procedimiento devolverá 0.
-- La devolución del parámetro de salida se interpreta fuera del procedimiento. Realizar todas las pruebas necesarias para tener en cuenta todos los casos.
DROP PROCEDURE IF EXISTS cobroComerciales;

DELIMITER //

CREATE PROCEDURE cobroComerciales(IN nombre_param VARCHAR(100), IN apellido1_param VARCHAR(100), OUT total_comision FLOAT)
BEGIN
    DECLARE comerciales_count INT;
    
    SELECT COUNT(*) INTO comerciales_count FROM comercial
    WHERE nombre = nombre_param AND apellido1 = apellido1_param;
    
    IF comerciales_count > 0 THEN
        SELECT SUM(p.total * c.comision) INTO total_comision FROM pedido AS p
        JOIN comercial AS c ON p.id_comercial = c.id
        WHERE c.nombre = nombre_param AND c.apellido1 = apellido1_param;
    ELSE
        SET total_comision = 0;
    END IF;
END //

DELIMITER ;

-- Testeo del procedimiento:

SELECT * FROM COMERCIAL WHERE nombre = 'Daniel';
CALL cobroComerciales('Daniel', 'Sáez', @comision_total);
SELECT @comision_total;

SELECT * FROM COMERCIAL WHERE nombre = 'Juan';
SET @comision_total = 0;
CALL cobroComerciales('Juan', 'Gómez', @comision_total);
SELECT @comision_total;

SELECT * FROM COMERCIAL WHERE nombre = 'Pedro';
SET @comision_total = 0;
CALL cobroComerciales('Pedro', 'López', @comision_total);
SELECT @comision_total;
