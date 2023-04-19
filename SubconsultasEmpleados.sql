use bd_empleados;

-- 0) Mostrar los datos de los empleados que pertenezcan al mismo departamento que 'GIL'.
SELECT * FROM emple WHERE dept_no = (SELECT dept_no FROM emple WHERE apellido = 'GIL');

-- 1) Mostrar los datos de los empleados que tengan el mismo oficio que 'CEREZO'. El resultado debe ir ordenado por apellido.
SELECT * FROM emple WHERE oficio = (SELECT oficio FROM emple WHERE apellido = 'CEREZO') ORDER BY apellido;

-- 2) Mostrar los empleados (nombre, oficio, salario y fecha de alta) que desempeñen el mismo oficio que 'JIMÉNEZ' o que tengan un salario mayor o igual que 'FERNÁNDEZ'.
SELECT nombre, oficio, salario, fecha_alt FROM emple WHERE oficio = (SELECT oficio FROM emple WHERE apellido = 'JIMÉNEZ') OR salario >= (SELECT salario FROM emple WHERE apellido = 'FERNÁNDEZ');

-- 3) Mostrar en pantalla el apellido, oficio y salario de los empleados del departamento de 'FERNÁNDEZ' que tengan su mismo salario.
SELECT apellido, oficio, salario
FROM emple
WHERE dept_no = (SELECT dept_no FROM emple WHERE apellido = 'FERNÁNDEZ')
AND salario = (SELECT salario FROM emple WHERE apellido = 'FERNÁNDEZ');


-- 4) Mostrar los datos de los empleados que tengan un salario mayor que 'GIL' y que pertenezcan al departamento número 10.
SELECT * FROM emple WHERE salario > (SELECT salario FROM emple WHERE apellido = 'GIL') AND dept_no = 10;

-- 5) Mostrar los apellidos, oficios y localizaciones de los departamentos de cada uno de los empleados.
SELECT emple.apellido, emple.oficio, depart.loc FROM emple INNER JOIN depart ON emple.dept_no = depart.dept_no;

-- 6) Seleccionar el apellido, el oficio y la localidad de los departamentos donde trabajan los ANALISTAS.
SELECT e.apellido, e.oficio, d.loc 
FROM emple e 
JOIN depart d ON e.dept_no = d.dept_no 
WHERE e.oficio = 'ANALISTA';

-- 7) Seleccionar el apellido, el oficio y salario de los empleados que trabajan en Madrid.
SELECT apellido, oficio, salario
FROM emple
WHERE dept_no = (
  SELECT dept_no
  FROM depart
  WHERE loc = 'Madrid'
);

-- 8) Seleccionar el apellido, salario y localidad donde trabajan los empleados que tengan un salario entre 2000 y 3000.
SELECT apellido, salario, loc
FROM emple
JOIN depart ON emple.dept_no = depart.dept_no
WHERE salario BETWEEN 2000 AND 3000;


-- 9) Mostrar el apellido, salario y nombre del departamento de los empleados que tengan el mismo oficio que 'GIL'.
SELECT apellido, salario, dnombre
FROM emple
JOIN depart ON emple.dept_no = depart.dept_no
WHERE oficio = (
  SELECT oficio
  FROM emple
  WHERE apellido = 'GIL'
);

-- 10) Mostrar el apellido, salario y nombre del departamento de los empleados que tengan el mismo oficio que 'GIL' y que no tengan comisión.
SELECT apellido, salario, dnombre
FROM emple
JOIN depart ON emple.dept_no = depart.dept_no
WHERE oficio = (
  SELECT oficio
  FROM emple
  WHERE apellido = 'GIL'
)
AND comision IS NULL;

-- 11) Mostrar los datos de los empleados que trabajan en el departamento de contabilidad, ordenados por apellidos.
SELECT *
FROM emple
WHERE dept_no = (
  SELECT dept_no
  FROM depart
  WHERE dnombre = 'Contabilidad'
)
ORDER BY apellido;

-- 12) Apellido de los empleados que trabajan en Sevilla y cuyo oficio sea analista o empleado.
SELECT apellido
FROM emple
JOIN depart ON emple.dept_no = depart.dept_no
WHERE loc = 'Sevilla'
AND (oficio = 'Analista' OR oficio = 'Empleado');

-- 13) Calcula el salario mínimo de los empleados del departamento 'VENTAS'.
SELECT MIN(salario) AS salario_minimo
FROM emple
WHERE dept_no = (
    SELECT dept_no
    FROM depart
    WHERE dnombre = 'VENTAS'
);

-- 14) Calcula la media de salarios de los empleados del departamento de 'CONTABILIDAD'.
SELECT AVG(salario) AS media_salarios
FROM emple
WHERE dept_no = (
    SELECT dept_no
    FROM depart
    WHERE dnombre = 'CONTABILIDAD'
);

-- 15) Mostrar los datos de los empleados cuyo salario sea mayor que la media de todos los salarios.
SELECT *
FROM emple
WHERE salario > (
    SELECT AVG(salario)
    FROM emple
);

-- 16) ¿Cuántos empleados hay en el departamento de 'VENTAS'?
SELECT COUNT(*) AS num_empleados_ventas
FROM emple
WHERE dept_no = (
    SELECT dept_no
    FROM depart
    WHERE dnombre = 'VENTAS'
);

-- 17) Calcula el número de empleados que hay que no tienen comisión.
SELECT COUNT(*) AS num_empleados_sin_comision
FROM emple
WHERE comision IS NULL OR comision = 0;

-- 18) Seleccionar el apellido del empleado que tiene máximo salario.
SELECT apellido
FROM emple
WHERE salario = (
    SELECT MAX(salario)
    FROM emple
);

-- 19) Mostrar los apellidos del empleado que tiene el salario más bajo.
SELECT apellido 
FROM emple
WHERE salario = (SELECT MIN(salario) FROM emple);

-- 20) Mostrar los datos del empleado que tiene el salario más alto en el departamento de 'VENTAS'.
SELECT COUNT(*) AS "Cantidad de apellidos que empiezan por A"
FROM emple
WHERE apellido LIKE 'A%';

-- 21) A partir de la tabla EMPLE visualizar cuántos apellidos de los empleados empiezan por la letra 'A'.
SELECT COUNT(*) AS "Cantidad de apellidos que empiezan por A"
FROM emple
WHERE apellido LIKE 'A%';

-- 22) Dada la tabla EMPLE, obtener el sueldo medio, el número de comisiones no nulas, el máximo sueldo y el sueldo mínimo de los empleados del departamento 30.
SELECT 
  AVG(salario) AS "Sueldo medio",
  COUNT(comision) AS "Cantidad de comisiones no nulas",
  MAX(salario) AS "Máximo sueldo",
  MIN(salario) AS "Mínimo sueldo"
FROM emple
WHERE dept_no = 30;

-- 23) Mostrar los departamentos cuya media de salarios sea mayor que la media de salarios de todos los empleados.
SELECT dnombre, AVG(salario) AS "Media de salarios"
FROM depart d
JOIN emple e ON d.dept_no = e.dept_no
GROUP BY d.dept_no
HAVING AVG(salario) > (SELECT AVG(salario) FROM emple);

-- 24) Visualizar el número de departamento que tenga más empleados cuyo oficio sea empleado.
SELECT dept_no, COUNT(*) AS "Cantidad de empleados"
FROM emple
WHERE oficio = 'empleado'
GROUP BY dept_no
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 25) Mostrar el número de oficios distintos de cada departamento.
SELECT d.dept_no, COUNT(DISTINCT(e.oficio)) AS "Cantidad de oficios distintos"
FROM depart d
LEFT JOIN emple e ON d.dept_no = e.dept_no
GROUP BY d.dept_no;
