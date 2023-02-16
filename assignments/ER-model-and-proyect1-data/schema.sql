create database university;
create table STUDENT (
    first_name varchar(40),
    middles_name varchar(40),
    surname varchar(40),
    id_number varchar(10) primary key,
    id_type varchar(10),
    birth_date date,
    sex char,
    program_id int
);
insert into STUDENT
values (
        "Fabio",
        "Juan",
        "Gonzales",
        "8394026574",
        "Cedula",
        1989 -11 -25,
        "M",
        1
    );
create table PROFESSOR(
    first_name varchar(40),
    middles_name varchar(40),
    surname varchar(40),
    id_number varchar(10) primary key,
    id_type varchar(10),
    birth_date date,
    sex char,
    faculty_id int
);
create table COURSE(
    c_name varchar(40),
    c_id int primary key,
    prof_id varchar(40),
    semester varchar(40)
);
create table CLASS(
    class_id int primary key,
    course_id int,
    room_no int,
    weekday varchar(10),
    start_time time,
    duration int
);
create table BUILDING(
    building_no int primary key,
    building_name varchar(40),
    campus varchar(40)
);
create table ROOM(
    room_id int primary key,
    room_no int,
    room_name varchar(40),
    building_no int
);
create table ENROLLMENT(
    enrollment_id int primary key,
    student_id int,
    course_id int,
    grade float
);
create table STUDENT_OF(
    study_id int primary key,
    student_id int,
    program_id int
);
create table PROGRAM(
    program_id int,
    program_name varchar(40),
    faculty_id int,
    program_type varchar(40)
);
create table FACULTY(
    faculty_id int primary key,
    faculty_name varchar(40)
);
select *
from STUDENT;