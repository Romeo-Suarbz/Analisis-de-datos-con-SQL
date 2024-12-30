## Contexto

El restaurante "Sabores del Mundo", es conocido por su auténtica cocina y su ambiente
acogedor.

Este restaurante lanzó un nuevo menú a principios de año y ha estado recopilando
información detallada sobre las transacciones de los clientes para identificar áreas de
oportunidad y aprovechar al máximo sus datos para optimizar las ventas.

## Objetivo

Identificar cuáles son los productos del menú que han tenido más éxito y cuales son los que
menos han gustado a los clientes.

Pasos a seguir
a) Crear la base de datos con el archivo create_restaurant_db.sql

b) Explorar la tabla “menu_items” para conocer los productos del menú.
● Encontrar el número de artículos en el menú.
● ¿Cuál es el artículo menos caro y el más caro en el menú?
● ¿Cuántos platos americanos hay en el menú?
● ¿Cuál es el precio promedio de los platos?

c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados.
● ¿Cuántos pedidos únicos se realizaron en total?
● ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
● ¿Cuándo se realizó el primer pedido y el último pedido?
● ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?

d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.
item_id(tabla order_details) y menu_item_id(tabla menu_items).
