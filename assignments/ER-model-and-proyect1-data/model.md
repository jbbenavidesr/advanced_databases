# Sistema de información académica

De los temas disponibles para trabajar, decidimos trabajar con el sistema académico universitatio.

## Modelo conceptual de un sistema académico universitario

Un modelo de este tipo debe cumplir varios propositos que hacen parte de la
funcionalidad académica de una universidad. Para comenzar es importante considerar
la estructura académica de la universidad, esta es información que en general se
mantiene constante y tiene un esquema jerarquico. Usando el ejemplo de la Universidad
Nacional, vemos que la universidad se divide en sedes, que a su vez se dividen en
facultades, y estas se dividen en departamentos.
Cada departamento ofrece diferentes programas académicos de diferentes niveles y estos
programas tienen una malla curricular que establece las asignaturas que se deben
tomar para obtener el título. Las mallas curriculares se dividen en componentes para los
que se define un número de créditos que se deben aprobar de dicho componente y unos
grupos de posibles asignaturas que se pueden tomar para cumplir con los créditos.
Existen grupos en los que las materias son optativas por lo que cada estudiante elige
de las opciones disponibles. Finalmente, existe un componente de libre elección en el
que el estudiante puede tomar asignaturas de cualquier departamento o instituto para
cumplir con los créditos.

Por otro lado, la universidad tiene profesores que están asociados a un departamento y
cada semestre los profesores dictan cursos correspondientes a alguna
asignatura. Los cursos pueden ser tomados por estudiantes que pueden estar matriculados
en diferentes programas académicos y cada curso entra a la historia académica de un
estudiante bajo alguna tipología y tiene una calificación.

Finalmente, existe un componente práctico en la que cada curso se dicta en una serie de
clases que tienen un horario y una duración, y estas clases se dictan en un aula de
clase que está ubicada en un edificio dentro de alguno de los campus de la universidad.

## Modelo relacional

A partir de este modelo simplificado, vamos a desarrollar un modelo relacional que nos
permita implementar el sistema de información académico.

```mermaid
---
title: Modelo relacional de un sistema académico universitario
---

erDiagram
    HEADQUARTER ||--|{ FACULTY : "has"
    HEADQUARTER ||--|{ BUILDING : "has"
    FACULTY ||--|{ DEPARTMENT : "has"
    DEPARTMENT ||--|{ PROGRAM : "offers"
    DEPARTMENT ||--|{ SUBJECT : "offers"
    DEPARTMENT ||--|{ PROFESSOR : "has associated"
    PROGRAM ||--|{ CURRICULAR_COMPONENT : "curriculum composed by"
    PROGRAM ||--|{ ACADEMIC_HISTORY : "is studied by"
    STUDENT ||--|{ ACADEMIC_HISTORY : "studies"
    SUBJECT ||--|{ COURSE : "is taught in"
    PROFESSOR ||--|{ COURSE : teaches
    COURSE ||--|{ COURSE_ENROLLMENT : "is taken by"
    CURRICULAR_COMPONENT ||--|{ COURSE_ENROLLMENT : "is fulfilled by"
    ACADEMIC_HISTORY ||--|{ COURSE_ENROLLMENT : "has taken"
    COURSE ||--|{ CLASS : "is organized in"
    CLASS }|--|| CLASSROOM : "happens in"
    BUILDING ||--|{ CLASSROOM : "has"
    PERSON ||--|{ STUDENT : "is"
    PERSON ||--|{ PROFESSOR : "is"

    HEADQUARTER {
        int headquarter_id PK
        varchar headquarter_name
    }

    FACULTY {
        varchar faculty_id PK
        varchar faculty_name
        int headquarter_id FK
    }

    DEPARTMENT {
        int department_id PK
        varchar department_name
        int faculty_id FK
    }

    PERSON {
        int person_id PK
        varchar id_number
        varchar id_type "cedula, pasaporte, etc"
        varchar first_name
        varchar middle_names
        varchar first_surname
        varchar second_surname
        date birth_date
        char sex "M, F"
    }

    STUDENT {
        int student_id PK
        int person_id FK
    }

    PROFESSOR {
        int professor_id PK
        int person_id FK
        int department_id FK
        varchar professor_type "titular, asociado, etc"
    }

    PROGRAM {
        int program_id PK
        varchar program_name
        varchar department_id FK
        varchar program_type "pregrado, especializacion, maestria, doctorado, etc"
    }

    SUBJECT {
        int subject_id PK
        varchar subject_name
        int department_id FK
    }

    COURSE {
        int course_id PK
        int subject_id FK
        int professor_id FK
        varchar course_group "grupo 1, grupo 2, etc, o titulo de trabajo o pasantia"
        int year
        int semester
    }

    CLASS {
        int class_id PK
        int course_id FK
        int classroom_id FK
        varchar weekday
        time start_time
        int duration "en minutos"
    }

    CLASSROOM {
        int classroom_id PK
        varchar classroom_name "Algunos salones tienen nombre"
        int classroom_no "El número dentro del edificio"
        int building_id FK
    }

    BUILDING {
        int building_id PK
        varchar building_name
        varchar campus
        int headquarter_id FK
    }

    CURRICULAR_COMPONENT {
        int curricular_component_id PK
        int program_id FK
        varchar curricular_component_name
        int required_credits "créditos que se deben aprobar"
    }

    COURSE_ENROLLMENT {
        int course_enrollment_id PK
        int academic_history_id FK
        int course_id FK
        int curricular_component_id FK
        float grade "nota obtenida en el curso"
        varchar status "aprobado, reprobado, pendiente, etc"
    }

    ACADEMIC_HISTORY {
        int academic_history_id PK
        int student_id FK
        int program_id FK
        date start_date
        date end_date
        varchar status "activo, graduado, retirado, etc"
        varchar history_type "regular, especial, etc"
        varchar title "titulo obtenido, si status es graduado"
    }
```
