create database Assignment2_0;

use Assignment2_0;



create table students(
id bigint not null auto_increment,
firstName varchar(50) not null,
secondName varchar(50) not null,
GPA int ,
primary key(id),
CHECK (GPA >= 0 AND GPA <= 100)
);

ALTER TABLE students
DROP CONSTRAINT students_chk_1;
ALTER TABLE students
RENAME COLUMN GPA TO grade;
ALTER TABLE students
ADD CONSTRAINT students_chk_1 CHECK (grade >= 0 AND grade <= 100);




create table courses(
id bigint not null auto_increment,
courseName varchar(50),
lecturer varchar(50),
credits int,
primary key(id),
CHECK (credits > 0 AND credits <= 10)
);


create table enrollment(
id bigint not null auto_increment,
semester varchar(50),
student_id bigint,
course_id bigint,
primary key(id),
foreign key(student_id) references students(id),
foreign key (course_id) references courses(id)
);


