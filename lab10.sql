CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255),
    genre VARCHAR(50),
    price_per_day DECIMAL(5, 2),
    available_copies INT
);
INSERT INTO Movies (movie_id, title, genre, price_per_day, available_copies)
VALUES
(1, 'The Matrix', 'Sci-Fi', 5.00, 8),
(2, 'Titanic', 'Romance', 3.50, 12),
(3, 'Avengers: Endgame', 'Action', 6.00, 5);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255)
);
INSERT INTO Customers (customer_id, name, email)
VALUES
(201, 'Alice Johnson', 'alice.j@example.com'),
(202, 'Bob Smith', 'bob.smith@example.com');

CREATE TABLE Rentals (
    rental_id INT PRIMARY KEY,
    movie_id INT,
    customer_id INT,
    rental_date DATE,
    quantity INT,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
INSERT INTO Rentals (rental_id, movie_id, customer_id, rental_date, quantity)
VALUES
(1, 1, 201, '2024-11-01', 2),
(2, 2, 202, '2024-11-03', 1),
(3, 3, 201, '2024-11-05', 3);


--1 Transaction for renting a movie
begin transaction;
-- Шаг 1: Вставка записи об аренде в таблицу Rentals
insert into rentals (rental_id, movie_id, customer_id, rental_date, quantity)
values (4, 1, 201, '2024-11-27', 2);

update movies
set available_copies = available_copies - 2
where movie_id = 1;

commit;

--2  Transaction with rollback
begin transaction;

insert into rentals(rental_id, movie_id, customer_id, rental_date, quantity)
values(4,3,202,'2024-11-28',10);

do $$
declare
    available int;

begin
select available_copies into available from movies
                                       where movie_id=3;
if available< 10 then
raise exception 'not enough';
end if;
end $$;

commit;

--3 Demonstration of Isolation levels;
set transaction isolation level read committed ;
begin transaction;

update movies
set price_per_day=7
where movie_id=1;

set transaction isolation level read committed;
begin transaction;
select price_per_day from movies
where movie_id=1;

commit;

select price_per_day from movies
where movie_id=1;

commit;

--4 Durability check;
begin transaction;

update customers
set email='kusya@exampl.meow'
where customer_id=201;

commit;
 select * from customers where customer_id= 201;

