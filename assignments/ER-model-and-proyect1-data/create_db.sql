create database university;
create table HEADQUARTER(
    headquarter_id int primary key,
    headquarter_name varchar(40)
);
create table FACULTY(
    faculty_id int primary key,
    faculty_name varchar(40),
    headquarter_id int,
    constraint fk_faculty_headquarter_id foreign key (headquarter_id) references HEADQUARTER(headquarter_id)
);
create table DEPARTMENT(
    department_id int primary key,
    department_name varchar(40),
    faculty_id int,
    constraint fk_department_faculty_id foreign key (faculty_id) references FACULTY(faculty_id)
);
create table PERSON (
    person_id int primary key,
    id_number varchar(10),
    id_type varchar(10),
    first_name varchar(40),
    middle_names varchar(40),
    first_surname varchar(40),
    second_surname varchar(40),
    birth_date date,
    sex char
);
create table STUDENT (
    student_id int primary key,
    person_id int,
    constraint fk_student_person_id foreign key (person_id) references PERSON(id_number)
);
create table PROFESSOR(
    professor_id int primary key,
    person_id int,
    department_id int,
    professor_type varchar(40),
    constraint fk_professor_person_id foreign key (person_id) references PERSON(id_number),
    constraint fk_professor_department_id foreign key (department_id) references DEPARTMENT(department_id)
);
create table PROGRAM(
    program_id int primary key,
    program_name varchar(40),
    department_id int,
    program_type varchar(40),
    constraint fk_program_department_id foreign key (department_id) references DEPARTMENT(department_id)
);
create table SUBJECT(
    subject_id int primary key,
    subject_name varchar(40),
    department_id int,
    constraint fk_subject_department_id foreign key (department_id) references DEPARTMENT(department_id)
);
create table COURSE(
    course_id int primary key,
    subject_id int,
    professor_id int,
    course_group varchar(100),
    year int,
    semester int,
    constraint fk_course_subject_id foreign key (subject_id) references SUBJECT(subject_id),
    constraint fk_course_professor_id foreign key (professor_id) references PROFESSOR(professor_id)
);
create table BUILDING(
    building_id int primary key,
    building_name varchar(40),
    campus varchar(40),
    headquarter_id int,
    constraint fk_building_headquarter_id foreign key (headquarter_id) references HEADQUARTER(headquarter_id)
);
create table CLASSROOM(
    classroom_id int primary key,
    classroom_no int,
    classroom_name varchar(40),
    building_id int,
    constraint fk_classroom_building_id foreign key (building_id) references BUILDING(building_id)
);
create table CLASS(
    class_id int primary key,
    course_id int,
    classroom_id int,
    weekday varchar(10),
    start_time time,
    duration int,
    constraint fk_class_course_id foreign key (course_id) references COURSE(course_id),
    constraint fk_class_classroom_id foreign key (classroom_id) references CLASSROOM(classroom_id)
);
create table CURRICULAR_COMPONENT(
    curricular_component_id int primary key,
    program_id int,
    curricular_component_name varchar(40),
    required_credits int,
    constraint fk_curricular_component_program_id foreign key (program_id) references PROGRAM(program_id)
);
create table ACADEMIC_HISTORY(
    academic_history_id int primary key,
    student_id int,
    program_id int,
    history_status varchar(40),
    history_type varchar(40),
    title varchar(40),
    constraint fk_academic_history_student_id foreign key (student_id) references STUDENT(student_id),
    constraint fk_academic_history_program_id foreign key (program_id) references PROGRAM(program_id)
);
create table COURSE_ENROLLMENT(
    course_enrollment_id int primary key,
    academic_history_id int,
    course_id int,
    curricular_component_id int,
    grade float,
    constraint fk_course_enrollment_academic_history_id foreign key (academic_history_id) references ACADEMIC_HISTORY(academic_history_id),
    constraint fk_course_enrollment_course_id foreign key (course_id) references COURSE(course_id),
    constraint fk_course_enrollment_curricular_component_id foreign key (curricular_component_id) references CURRICULAR_COMPONENT(curricular_component_id)
);