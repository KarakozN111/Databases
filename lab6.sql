--1
create database lab_courses;
--2
create table courses(
    course_id serial primary key,
    course_name varchar(50),
    course_code varchar(10),
    credits integer
);
create table professors(
    professor_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    department varchar(50)
);
create table students(
    student_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    major varchar(50),
    year_enrolled integer
);
create table enrollments(
    enrollment_id serial primary key,
    student_id integer references students,
    course_id integer references courses,
    professor_id integer references professors,
    enrollment_date date
);
--3
select students.first_name, students.last_name, courses.course_name, professors.last_name
from enrollments
join students on enrollments.student_id=students.student_id
join courses on enrollments.course_id=courses.course_id
join professors on enrollments.professor_id=professors.professor_id;

create index idx_enrollments_student_id on enrollments(student_id);
create index idx_enrollments_course_id on enrollments(course_id);
create index idx_enrollments_professor_id on enrollments(professor_id);
--4
select students.first_name, students.last_name from enrollments
join students on enrollments.student_id = students.student_id
join courses on enrollments.course_id=courses.course_id
where credits>3;

create index idx_course_credits on courses(credits);
--5
select courses.course_name, count(enrollments.student_id) from courses
left join enrollments on courses.course_id=enrollments.course_id
group by courses.course_name;

create index idx_enrollments_course_id on enrollments(course_id);
--6
select distinct professors.first_name, professors.last_name from professors
join enrollments on professors.professor_id =enrollments.professor_id;

create index idx_professor_id on enrollments(professor_id);
--7
select students.first_name, students.last_name from enrollments
join students on enrollments.student_id=students.student_id
join professors on enrollments.professor_id=professors.professor_id
where professors.department='Computer Science';

create index idx_prof_department on professors(department);

--8
select courses.course_name, professors.last_name, sum(courses.credits) from enrollments
join courses on enrollments.course_id=courses.course_id
join professors on enrollments.professor_id=professors.professor_id
where professors.last_name like 'S%'
group by courses.course_name, professors.last_name;

create index idx_last_name on professors(last_name);

--9
select students.first_name, students.last_name from enrollments
join students on enrollments.student_id=students.student_id
where enrollments.enrollment_date< '2020-01-01';

create index idx_date on enrollments(enrollment_date);

--10
select courses.course_name from courses
left join enrollments on courses.course_id=enrollments.course_id
where enrollments.enrollment_id is null;

create index idx_null on enrollments(course_id);
