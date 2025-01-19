--1 create an index for queries like:
--select * from products where product_name ='string';
create index idx_product_name on products(name);

--2 create a composite index for queries like:
--select * from customers where first_name ='string' and last_name='string'
create index idx_first_last_name on customers(first_name, last_name);

--3 create a unique index fro queries like:
--select * from orders where order_total between value1 and value 2;
create index idx_order_total on orders(order_total)
;
--4 create a functional index for queries like:
-- select * from customers where lower(email)= 'string';
create index idx_email on customers(lower(email));

--5 create an index for queries like:
-- select * from orders
--join order_items on orders.order_id= order_items.order_id
-- where orders.order_total> value and orders.quantity<value2 ;
create index  idx_orders_order_id on orders (order_id);
create index idx_orders_total_quantity on orders (order_total, quantity);
create index idx_order_items_order_id on order_items(order_id);






























