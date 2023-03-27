use comercio;

select * from cliente;
select * from vendedor;
select * from pedido;

-- INNER JOIN

-- Método tradicional
select cliente.*, pedido.*
from cliente
inner join pedido on cliente.id_cliente = pedido.id_cliente;

-- Posibilidad si la primary key y la foreign key se llaman igual
select cliente.*, pedido.*
from cliente
inner join pedido using (id_cliente);

-- Cambiando on por where
select cliente.*, pedido.*
from cliente
inner join pedido where cliente.id_cliente = pedido.id_cliente;

-- LEFT JOIN

select cliente.*, pedido.*
from cliente
left join pedido on cliente.id_cliente = pedido.id_cliente;

-- RIGHT JOIN

select cliente.*, pedido.*
from cliente
right join pedido on cliente.id_cliente = pedido.id_cliente;

-- ANIDACIONES
-- Uses el tipo de join que elijas, todos deben de ser del mismo.

select cliente.*, pedido.*, vendedor.*
from cliente
inner join pedido using (id_cliente)
inner join vendedor on pedido.id_vendedor = vendedor.id;

select cliente.*, pedido.*, vendedor.*
from cliente
right join pedido using (id_cliente)
right join vendedor on pedido.id_vendedor = vendedor.id; 
