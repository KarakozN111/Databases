--1
create table reviewer(
    reviewerID serial primary key,
    name varchar(100)
);
create table review(
    reviewerID serial primary key,
    movieID integer,
    rating integer,
    reviewDate date
);
create table movie(
    movieID serial primary key,
    title varchar(100),
    releaseYear integer,
    director varchar(100)
);
INSERT INTO reviewer (reviewerID, name)
VALUES
    (301, 'Alex Johnson'),
    (302, 'Maria Gomez'),
    (303, 'John Doe'),
    (304, 'Linda Brown'),
    (305, 'Michael Thompson'),
    (306, 'Emily Davis'),
    (307, 'Daniel White'),
    (308, 'Sophia Lee');
INSERT INTO review (reviewerID, movieID, rating, reviewDate)
VALUES
    (301, 401, 5, '2024-02-15'),
    (301, 402, 4, '2024-02-20'),
    (302, 403, 5, '2024-01-11'),
    (303, 404, 3, '2024-01-23'),
    (304, 405, 4, '2024-01-15'),
    (305, 406, 2, '2024-03-05'),
    (306, 407, 5, '2024-05-02'),
    (307, 408, 4, '2024-03-12');
INSERT INTO movie (movieID, title, releaseYear, director)
VALUES
    (401, 'Future World', 2024, 'Alice Smith'),
    (402, 'The Last Adventure', 2024, 'John Black'),
    (403, 'New Horizons', 2024, 'Maria Johnson'),
    (404, 'Time Capsule', 2024, 'Chris Martin'),
    (405, 'Beyond the Stars', 2024, NULL),
    (406, 'The Silent Valley', 2024, 'Laura Green'),
    (407, 'Lost in the Echo', 2024, 'Daniel White'),
    (408, 'Shadow of Destiny', 2024, 'James Clarke');


--2 create a view that lists all unique release years of movies that received a rating of 4 or higher, sorted by year in asc order
create view movie_years
as select distinct movie.releaseYear from movie
join review on movie.movieID=review.movieID
where review.rating>=4
order by movie.releaseYear asc;

--3. Add indexes to improve the performance of queries that use the view created in the previous step.
create index idx_movieID on movie(movieID);
create index idx_review on review(movieID);
create index idx_review_rating on review(rating);
create index idx_movie_releaseYear on movie(releaseYear);

--4 Define a new role with privileges to log in and create additional roles.
create role new_role with login password 'password';
alter role new_role with createdb;
alter role new_role with createrole;

--5 Grant this new role all permissions that are typically available to a default user role.
grant all privileges on all tables in schema public to new_role;
grant all privileges on all sequences in schema public to new_role;
grant all privileges on all functions in schema public to new_role;

--6 transfer ownership of all created tables from the root user to the new role.
alter table reviewer owner to new_role;
alter table review owner to new_role;
alter table movie owner to new_role;

--7 Create a view that shows the titles of all movies reviewed in 2024 with a rating of 5, along with the reviewer's name. Sort the results alphabetically by the movie title.
create view  top_movies
as select movie.title,review.rating, reviewer.name from movie
join review on movie.movieID=review.movieID
join reviewer on review.reviewerID=reviewer.reviewerID
where review.rating=5 and extract(year from review.reviewDate)=2024
order by movie.title;
