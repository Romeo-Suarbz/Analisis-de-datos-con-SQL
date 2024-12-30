--a) Crear la base de datos con el archivo create_restaurant_db.sql
--b) Explorar la tabla “menu_items” para conocer los productos del menú.

--exploramos las tabla
select * from menu_items --cols = menu_item_id, item_name, category, price

-- Encontrar el número de artículos en el menú.
-- 32 ITEMS
select count(distinct(menu_item_id)) from menu_items

--¿Cuál es el artículo menos caro y el más caro en el menú?
-- el mas caro "Shrimp Scampi"
-- el menos caro "Edamame"

select item_name, max(price) as producto_mas_caro from menu_items
group by 1
order by 2 desc
limit 1

select item_name, min(price) as producto_menos_caro from menu_items
group by 1
order by 2 asc
limit 1

--¿Cuántos platos americanos hay en el menú?
-- 6 platillos
select category, count(distinct(menu_item_id)) from menu_items
group by 1
having category ilike 'American'

--¿Cuál es el precio promedio de los platos?
--el promedio es 13.29 
select round(avg(price), 2) from menu_items


--c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados.
--exploramos las tabla
select * from order_details --cols = order_details_id, oder_ir, order_date, order_time, item_id

--¿Cuántos pedidos únicos se realizaron en total?
-- total de pedidos unicos 5370
select count(distinct(order_id)) from order_details

--¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
-- pedidos numero = 5200, 5066, 4836, 4482, 4305
select order_id, sum(order_details_id) as cantidad_productos from order_details
group by 1
order by 2 desc
limit 5

--¿Cuándo se realizó el primer pedido y el último pedido?
--primer pedido = "2023-01-01"
--ultimo pedido = "2023-03-31"
select min(order_date) from order_details
select max(order_date) from order_details

--¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
--308 pedidos
select count(distinct(order_id)) from order_details
where order_date between '2023-01-01' and '2023-01-05'

--d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.
select * from order_details --cols = order_details_id, oder_id, order_date, order_time, item_id
select * from menu_items --cols = menu_item_id, item_name, category, price

--columnas a igualar item_id, menu_item_id
select o.order_id, o.item_id, o.order_date, o.order_time, m.item_name, m.category, m.price
from order_details as o
left join menu_items as m
on o.item_id = m.menu_item_id

--1) top 3 de categorias mas vendidas:
-- ASIATICA, ITALITANA Y MEXICANA
select count(distinct(o.order_id)), m.category
from order_details as o
left join menu_items as m
on o.item_id = m.menu_item_id
group by 2
order by count(distinct(o.order_id)) desc
limit 3

--2) top 5 prodcutos mas vendidos
-- "Edamame", "Hamburger", "Korean Beef Bowl", "Cheeseburger", "French Fries"
select count(distinct(o.order_id)), m.item_name
from order_details as o
left join menu_items as m
on o.item_id = m.menu_item_id
group by 2
order by count(distinct(o.order_id)) desc
limit 5

--3) cuantos pedidos se realizó en cada mes
--ENERO 1845, FEBRERO 1685, MARZO 1840
SELECT 
    SUM(CASE WHEN o.order_date BETWEEN '2023-01-01' AND '2023-01-31' THEN 1 ELSE 0 END) AS "Enero",
    SUM(CASE WHEN o.order_date BETWEEN '2023-02-01' AND '2023-02-28' THEN 1 ELSE 0 END) AS "Febrero",
    SUM(CASE WHEN o.order_date BETWEEN '2023-03-01' AND '2023-03-31' THEN 1 ELSE 0 END) AS "Marzo"
FROM (
    SELECT DISTINCT o.order_id, o.order_date
    FROM order_details AS o
) AS o;

--4) Cual es el horario mas activo
--Vespertino con 5080 pedidos al contrario de Matutino con 290 pedidos
SELECT 
    SUM(CASE WHEN o.order_time BETWEEN '09:00:00' AND '11:59:59' THEN 1 ELSE 0 END) AS "Matutino",
    SUM(CASE WHEN o.order_time BETWEEN '12:00:00' AND '23:59:59' THEN 1 ELSE 0 END) AS "Vespertino"
FROM (
    SELECT DISTINCT o.order_id, o.order_time
    FROM order_details AS o
) AS o;


--5) Ticket con el monto mas alto
-- Orden 4836 con un monto de 177.20
SELECT o.order_id, sum (m.price) as total_ticket
from 
(select distinct o.order_id, o.item_id
from order_details as o) as o
left join menu_items as m
on o.item_id = m.menu_item_id
group by 1
having sum (m.price) is not null
order by 2 desc
limit 1






