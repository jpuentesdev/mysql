-- MATHEMATICAL FUNCTIONS

-- MOD() --> Resto de una división
select mod(6,5) resto;

-- DIVISIÓN:
-- Decimal
select 6/5 cociente; 
-- Entera
select 6 div 5 cociente;

-- SQRT() --> Raíz cuadrada
select sqrt(9) raizCuadrada;

-- PI() --> Número Pi
select pi();

-- ROUND() --> Redondeo --> segundo número (cantidad de decimales)
select round(12.564);
select round(12.564,1);

-- CEIL() Y FLOOR() --> Redondeo hacia arriba o hacia abajo
select ceil(12.1);
select floor(12.9);

-- POW() --> Potencia de un número 
select pow(3,3);

-- ÁREA DEL CÍRCULO
set @radio = 30;
select round((2* pi() * @radio),2) area_circulo;

