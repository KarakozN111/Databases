--1 create database lab1
create database lab1;

--2 create table "users"
create table users(
    id serial primary key,
    firstname varchar(50),
    lastname varchar(50)
);

--3 add integer column (0 or 1) "isadmin) to "users" table
alter table users
add column isadmin integer check (isadmin in (0,1));

--4 change type of "isadmin"  column to boolean
alter table users
alter column isadmin type boolean using isadmin :: boolean;-- команда изменяющая тип данных

--5 set default value as false to "isadmin" column
alter table users
alter column isadmin set default false;

--6 add primary key constraint to id column
alter table users
add constraint pk_users_id primary key (id);

--7 create table "tasks"
create table tasks(
    id serial primary key,
    name varchar(50),
    user_id integer
);

--8 delete 'tasks' table
drop table if exists tasks;

--9 delete 'lab1' database
drop database if exists lab1;






