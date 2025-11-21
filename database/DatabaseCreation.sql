create database university_db;

\c university_db;

create schema core;

--User that will implement the model's creation

create user university_app with encrypted password '$#University2025$#';

grant connect on database university_db to university_app;
grant create on database university_db to university_app;
grant create, usage on schema core to university_app;
alter user university_app set search_path to core;

--User that the backend will connect to

create user university_usr with encrypted password '$#UniversityBackend2025$#';

grant connect on database university_db to university_usr;
grant usage on schema core to university_usr;
alter default privileges for user university_app in schema core grant insert, update, delete, select on tables to university_usr;
alter default privileges for user university_app in schema core grant execute on routines TO university_usr;
alter user university_usr set search_path to core;

create table core.admins
(
    id integer generated always as identity constraint admin_pk primary key,
	admin_login varchar(10) not null constraint admin_login_uk unique,
    admin_password varchar(100) not null,
    is_first_login boolean not null
);

create table core.professors
(
    id integer generated always as identity constraint professor_pk primary key,
    email varchar(70) not null constraint professor_email_uk unique,
    full_name varchar(70) not null,
    highest_education varchar(70) not null,
    is_first_login boolean not null
);

create table core.students
(
    id integer generated always as identity constraint student_pk primary key,
    email varchar(70) not null constraint student_email_uk unique,
    full_name varchar(70) not null,
    is_first_login boolean not null
);

create table core.subjects
(
    id integer generated always as identity constraint subject_pk primary key,
    name varchar(100) not null,
    description varchar(500) not null
);

create table core.periods
(
    id integer generated always as identity constraint core_pk primary key,
    name varchar(50),
    start_date date,
    end_date date,
    constraint period_uk unique (start_date, end_date)
);

create table core.courses
(
    id integer generated always as identity constraint course_pk primary key,
    name varchar(100) not null,
    description varchar(500) not null,
    id_subject integer not null constraint course_subject_fk references core.subjects,
    id_period integer not null constraint course_period_fk references core.periods,
    id_professor integer not null constraint course_professor_fk references core.professors
);


create table core.enrollments
(
    id integer generated always as identity constraint enrollment_pk primary key,
    final_grade real, --Must be calculated,
    enrollment_date date not null,
    id_course integer not null constraint enrollment_course_fk references core.courses,
    id_student integer not null constraint enrollment_student_fk references core.students
);

create table core.grades
(
    id integer generated always as identity constraint grade_pk primary key,
    name varchar(150) not null,
    percentage real not null, 
    id_course integer not null constraint grade_course_fk references core.courses,
    constraint course_grade_uk unique (id_course, name)
);

create table core.student_grades
(
    id integer generated always as identity constraint student_grade_pk primary key,
    grade real,
    id_grade integer not null constraint student_grade_grade_fk references core.grades,
    id_enrollment integer not null constraint student_grade_enrollment_fk references core.enrollments,
    constraint student_grade_uk unique (id_grade, id_enrollment)
);