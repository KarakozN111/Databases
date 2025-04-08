
create database lab_2;

--2 create table employees
create table employees(
    employee_id serial primary key,
    first_name varchar(100),
    last_name varchar(100),
    department_id integer,
    salary integer
);
 --3 insert a row into table with sample values
 insert into employees(first_name, last_name, department_id, salary)
 values ('Karakoz','Nurgaliyeva',1,100000);

--4 insert a row providing valuers only for id,  first name, last name columns
insert into employees(employee_id, first_name, last_name)
values(2, 'Nurdana', 'Niyat');

--5 insert a row where department_id is set to null
insert into employees(first_name, last_name,  salary)
values ('Riana', 'Mukhtar', 50000);

--6 insert 5 rows at once into the employees table using a single insert statement
insert into employees(first_name, last_name, department_id,salary)
values('Ayala','Nurakyn',3,10),
      ('Kusya','Nur', 5, 3232322),
      ('Asya', 'Nur',6, 898989989),
      ('Olivia','Rodrigo',7,50),
      ('Abay', 'Kunanbayev',8,898989890);

--7 set a default value for first_name as 'John'
alter table employees
alter column first_name set default 'John';

--8 insert a new row  using default value for first name column
insert into employees(last_name, department_id, salary)
values('Rou',10,545664);

--9 insert a row where only default values are used for all columns
insert into employees default values;

--10 create a duplicate of employees table named employees_archive including all its structure using LIKE keyword
create table employees_archive (like employees including all);

--11 copy all records from the employees table into yhe employees_archive table
insert into employees_archive select * from employees;

--12 update for employees who belong to department_id=null to set their od to 1
update employees set department_id=1 where department_id is null;

--13 increase the salary of every employee by 15% and return updated salary
SELECT first_name, last_name, salary FROM employees;
UPDATE employees
SET salary = salary * 1.15
WHERE salary > 0;
SELECT first_name, last_name, salary AS Updated_Salary FROM employees;

--14 delete all employees whp have a salary of less than 50000
delete from employees where salary<50000;

--15 delete rows from employees_archive table if employee_id is present in employee table, return deleted rows
delete from employees_archive
where employee_id in (select employee_id from employees);

--16 delete all rows from the employees table and return deleted records
truncate table employees; --truncate is a fast way to delete all rows
select * from employees;
