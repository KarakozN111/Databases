--1
create database lab4;
--2
create table warehouses(
    id serial primary key,
    code integer,
    location varchar(255),
    capacity integer
);
create table boxes(
   id serial primary key,
    code char(4),
    contents varchar(255),
    value real,
   warehouse integer
);
--3
 INSERT INTO Warehouses(code, location, capacity) VALUES(1, 'Chicago', 3);
 INSERT INTO Warehouses(code, location, capacity) VALUES(2, 'Rocks', 4);
 INSERT INTO Warehouses(code, location, capacity) VALUES(3, 'New York', 7);
 INSERT INTO Warehouses(code, location, capacity) VALUES(4, 'Los Angeles', 2);
 INSERT INTO Warehouses(code, location, capacity) VALUES(5, 'San Francisko', 8);

 INSERT INTO boxes(code, contents, value, warehouse) VALUES ('0MN7', 'Rocks', 180, 3);
 INSERT INTO boxes(code, contents, value, warehouse) VALUES ('4H8P', 'Rocks', 250, 1);
 INSERT INTO boxes(code, contents, value, warehouse) VALUES ('4RT3', 'Scissors', 190, 4);
 INSERT INTO boxes(code, contents, value, warehouse) VALUES ('7G3H', 'Rocks', 200, 1);
 INSERT INTO boxes(code, contents, value, warehouse) VALUES ('8JN6', 'Papers', 75, 1);
 INSERT INTO boxes(code, contents, value, warehouse) VALUES ('8Y6U', 'Papers', 50, 3);
 INSERT INTO boxes(code, contents, value, warehouse) VALUES ('9J6F', 'Papers', 175, 2);
 INSERT INTO boxes(code, contents, value, warehouse) VALUES ('LL08', 'Rocks', 140, 4);
 INSERT INTO boxes(code, contents, value, warehouse) VALUES ('P0H6', 'Scissors', 125, 1);
 INSERT INTO boxes(code, contents, value, warehouse) VALUES ('P2T6', 'Scissors', 150, 2);
INSERT INTO boxes(code, contents, value, warehouse) VALUES ('TU55', 'Papers', 90, 5);
--4
select * from warehouses;
--5
select * from boxes
where value>150;
--6
select distinct contents from boxes;
--7
select warehouses.code, count(boxes.id)  as box_count from warehouses
left join boxes on warehouses.id= boxes.warehouse
group by warehouses.code;
--8
select warehouses.code, count(boxes.id) as box_count from warehouses
left join boxes on warehouses.id= boxes.warehouse
group by warehouses.code
having count(boxes.id)>2;
--9
insert into warehouses(code,location,capacity)
values(6, 'New York',3);
--10
insert into boxes(code, contents,value, warehouse)
values('H5RT','Papers',200,2);
--11
update boxes
set value =value*0.85
where id =(
    select id from boxes
    order by value desc
    offset 2 limit 1
    );
--12
delete from boxes where value<150;
--13
delete from boxes
using warehouses
where boxes.warehouse =warehouses.id
and warehouses.location='New York'
returning boxes.*;


