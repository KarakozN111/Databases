--1 create database lab1
create database lab1;

--2 create table "clients"
create table clients(
    client_id serial primary key,
    first_name varchar(60),
    last_name varchar(60),
    email varchar(100),
    date_joined date
);

--3 add integer column (0 or 1) "status" to "clients" table
alter table clients
add column status integer check (status in (0,1));

--4 change type of "status"  column to boolean
alter table clients
alter column status type boolean using status :: boolean;-- команда изменяющая тип данных

--5 set default value as trueto "status" column
alter table clients
alter column status set default true;

--6 add primary key constraint to client_ id column
alter table clients
add constraint pk_clients_id primary key (client_id);

--7 create table named "orders"
create table orders(
    order_id serial primary key,
    order_name varchar(100),
    client_id integer references clients(client_id )
);

--8 delete 'orders' table
drop table if exists orders;

--9 delete 'lab1' database
drop database if exists lab1;






