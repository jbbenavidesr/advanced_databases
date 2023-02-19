# Sistema de información académica

De los temas disponibles para trabajar, decidimos trabajar con el sistema académico universitatio.

## Modelo conceptual de un sistema académico universitario

Un modelo de este tipo debe cumplir varios propositos que hacen parte de la
funcionalidad académica de una universidad. Para comenzar es importante considerar
la estructura académica de la universidad, esta es información que en general se
mantiene constante y tiene un esquema jerarquico. Usando el ejemplo de la Universidad
Nacional, vemos que la universidad se divide en sedes, que a su vez se dividen en
facultades e institutos, y estos se dividen en departamentos y otros institutos.
Cada departamento ofrece diferentes programas académicos de diferentes niveles y estos
programas tienen una malla curricular que establece las asignaturas que se deben
tomar para obtener el título. Las mallas curriculares se dividen en componentes para los
que se define un número de créditos que se deben aprobar de dicho componente y unos
grupos de posibles asignaturas que se pueden tomar para cumplir con los créditos.
Existen grupos en los que las materias son optativas por lo que cada estudiante elige
de las opciones disponibles. Finalmente, existe un componente de libre elección en el
que el estudiante puede tomar asignaturas de cualquier departamento o instituto para
cumplir con los créditos.

Por otro lado, la universidad tiene profesores que están asociados a un departamento o
instituto, y cada semestre los profesores dictan cursos correspondientes a alguna
asignatura. Los cursos pueden ser tomados por estudiantes que pueden estar matriculados
en diferentes programas académicos y cada curso entra a la historia académica de un
estudiante bajo alguna tipología y tiene una calificación.

Finalmente, existe un componente práctico en la que cada curso se dicta en una serie de
clases que tienen un horario y una duración, y estas clases se dictan en un aula de
clase que está ubicada en un edificio dentro de alguno de los campus de la universidad.

### Modelo simplificado

Una vez ya tenemos como una imágen global de como funciona un sistema académico, vamos a
desarrollar un modelo simplificado que nos permita empezar a trabajar y que, en caso de
ser necesario, se pueda ir ampliando según las necesidades del proyecto.

En este modelo simplificado, vamos a considerar que la universidad tiene una sola sede.
Adicional, consideraremos que la universidad se divide unicamente en
facultades que son quienes ofrecen los programas académicos. Los programas van a tener
una malla curricular con componentes que tienen un número requerido de créditos, pero
no especifican que materias pueden ser tomadas como parte del componente, esto lleva a
que en este modelo, cada componente funcione como si fuera de libre elección para el que
cualquier materia se puede clasificar como parte del componente en la historia de los
estudiantes.
Finalmente, cada estudiante tiene su historia académica de los programas en los que se
ha matriculado y cada semestre se matricula en un conjunto de cursos que se toman para
cumplir con los créditos de cada componente de la malla curricular. Los profesores
dictan los cursos y cada curso tiene una calificación que se registra en la historia
académica del estudiante. Los cursos se dictan en clases que tienen un horario y una
duración, y estas clases se dictan en un aula de clase que está ubicada en un edificio
de la universidad.

## Modelo relacional

A partir de este modelo simplificado, vamos a desarrollar un modelo relacional que nos
permita implementar el sistema de información académico.

```mermaid
---
title: Modelo relacional de un sistema académico universitario
---

erDiagram
    FACULTY ||--|{ PROGRAM : "offers"
    FACULTY ||--|{ SUBJECT : "offers"
    FACULTY ||--|{ PROFESSOR : "has associated"
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

    FACULTY {
        varchar faculty_id PK
        varchar faculty_name
    }

    STUDENT {
        varchar id_number PK
        varchar id_type "cedula, pasaporte, etc"
        varchar first_name
        varchar middle_names
        varchar first_surname
        varchar second_surname
    }

    PROFESSOR {
        varchar id_number PK
        varchar id_type "cedula, pasaporte, etc"
        varchar first_name
        varchar middle_names
        varchar first_surname
        varchar second_surname
        int faculty_id FK
    }

    PROGRAM {
        int program_id PK
        varchar program_name
        varchar faculty_id FK
        varchar program_type "pregrado, especializacion, maestria, doctorado, etc"
    }

    SUBJECT {
        int subject_id PK
        varchar subject_name
        int faculty_id FK
    }

    COURSE {
        int course_id PK
        int subject_id FK
        int professor_id FK
        varchar group "grupo 1, grupo 2, etc, o titulo de trabajo o pasantia"
        int year
        int semester
        varchar course_type "teorico, practico, trabajo de grado, etc"
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
        int room_id PK
        varchar room_name "Algunos salones tienen nombre"
        int room_no "El número dentro del edificio"
        int building_id FK
    }

    BUILDING {
        int building_id PK
        varchar building_name
        varchar campus
    }

    CURRICULAR_COMPONENT {
        int curricular_component_id PK
        int program_id FK
        varchar component_name
        int credits "créditos que se deben aprobar"
    }

    COURSE_ENROLLMENT {
        int enrollment_id PK
        int academic_history_id FK
        int course_id FK
        int curricular_component_id FK
        float grade "nota obtenida en el curso"
    }

    ACADEMIC_HISTORY {
        int academic_history_id PK
        int student_id FK
        int program_id FK
        varchar status "activo, graduado, retirado, etc"
        varchar student_type "regular, especial, etc"
        varchar title "titulo obtenido, si status es graduado"
    }
```
