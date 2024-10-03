--1
create database lab3;

--2
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50)
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE,
    course_name VARCHAR(100),
    credits INT
);

CREATE TABLE registration (
    registration_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    registration_date DATE,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

INSERT INTO students (first_name, last_name, date_of_birth, email, city) VALUES
('Alice', 'Johnson', '2001-05-14', 'alice.johnson@example.com', 'Almaty'),
('Bob', 'Smith', '2000-09-20', 'bob.smith@example.com', 'New York'),
('Cathy', 'Williams', '2002-01-10', 'cathy.williams@example.com', 'Almaty'),
('David', 'Brown', '1999-03-22', 'david.brown@example.com', 'Los Angeles');

INSERT INTO courses (course_code, course_name, credits) VALUES
('CS101', 'Introduction to Computer Science', 4),
('MATH201', 'Calculus I', 3),
('PHYS301', 'General Physics', 3),
('HIST101', 'World History', 2);

INSERT INTO registration (student_id, course_id, registration_date, grade) VALUES
(1, 1, '2023-09-01', NULL),  -- Alice registered for CS101
(2, 2, '2023-09-01', NULL),  -- Bob registered for MATH201
(3, 3, '2023-09-01', NULL),  -- Cathy registered for PHYS301
(4, 1, '2023-09-01', NULL),  -- David registered for CS101
(1, 4, '2023-09-01', NULL);  -- Alice registered for HIST101

--3 select the last name of all students
select last_name from students;

--4 select the last name of all students without dublicates
select distinct last_name from students;

--5 select all data of students whose last name is "Johnson"
select * from students where last_name='Johnson';

--6 select all data of students whose last name is 'Johnson' or 'Smith'
select * from students where last_name in ('Johnson', 'Smith');

--7 select all data of students who are registered in the 'CS101' course
select students.* from students
join registration on students.student_id= registration.student_id
join courses on registration.course_id= courses.course_id
where courses.course_code='CS101';

--8 select all data of students who are registered in the MATH201 or PHYS301 courses
select students.* from students
join registration on students.student_id=registration.student_id
join courses on registration.course_id=courses.course_id
where courses.course_code in ('MATH201', 'PHYS301');

--9 select the total number of credits for all courses
select sum(credits) as total_credits from courses;

--10 select the number of students registered  for each course
select course_id, count(student_id) as number_of_students
from registration
group by course_id;

--11 select the course id with more than 2 students registered
select course_id
from registration
group by course_id
having count(student_id)>2;

--12 select the course name with the second-highest number of credits
select course_name
from courses
order by credits desc
offset 1 limit 1;

--13 select the first and last names of students registered in the course with the fewest credits
select students.first_name, students.last_name from students
join registration on students.student_id = registration.student_id
join courses on registration.course_id=courses.course_id
where courses.credits=(select min(credits) from courses);

--14 select the first and last names of all students from almaty
select first_name, last_name
from students
where city='Almaty';

--15 select all courses with more than 3 credits , sorted by increasing credits and decreasing course ID
select * from courses
where credits> 3
order by credits asc, course_id desc;

--16 decrease the number of credits for the course with the fewest credits by 1
update courses
set credits = credits-1
where credits= (select min(credits) from courses);

--17 reassign all students from the 'MATH201' course to the CS101 course
update registration
set course_id= (select course_id from courses where course_code='CS101')
where course_id=(select course_id from courses where course_code ='MATH201');

--18 delete from the table all students registered for the CS101 course
delete from students
where student_id in (
    select student_id
    from registration
    where course_id=(select course_id from courses where course_code ='CS101')
    );
--19 delete all students from the database
delete from students;
