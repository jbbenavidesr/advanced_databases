# University academic system

From the available topics we selected to develop an academic system for a university.

```mermaid
---
title: University Academic Model
---

erDiagram
		STUDENT }|--|{ PROGRAM: studies
		STUDENT ||--|{ ENROLLMENT : has
		STUDENT ||--|{ STUDENT_OF: is
		PROGRAM ||--|{ STUDENT_OF: a
		COURSE ||--o{ ENROLLMENT : has
		COURSE }|--|| PROFESSOR: teaches
		CLASSROOM }|--|| BUILDING: "is in"
		COURSE ||--|{ CLASS: has
		CLASS }o--|| CLASSROOM: "happens in"
		PROFESSOR }|--|| FACULTY: "member of"
		PROGRAM }|--|| FACULTY: "offered by"
		COURSE }|--|| PROGRAM: "part of"

    STUDENT {
			varchar id_number PK
			varchar id_type
			varchar first_name
			varchar middle_name
			varchar surnames
			date birthdate
			char sex
			int program_id FK
		}
		PROFESSOR {
			varchar id_number PK
			varchar id_type
			varchar first_name
			varchar middle_name
			varchar surnames
			date birthdate
			char sex
			int faculty_id FK
		}
		COURSE {
			int course_id PK
			varchar course_name
			varchar prof_id FK
			varchar semester
			varchar course_type
		}
		CLASS {
			int class_id PK
			int course_id FK
			int room_no FK
			varchar weekday
			time start_time
			int duration
		}
		CLASSROOM {
			int room_id PK
			varchar room_name
			int room_no
			int building_id FK
		}
		BUILDING {
			int building_id PK
			varchar building_name
			varchar campus
		}
		PROGRAM {
			int program_id PK
			varchar program_name
			int faculty_id FK
			varchar program_type
		}
		ENROLLMENT {
			int enrollment_id PK
			int student_id FK
			int course_id FK
			float grade
		}
		STUDENT_OF {
			int study_id PK
			int student_id FK
			int program_id FK
		}
		FACULTY {
			int faculty_id PK
			varchar faculty_name
		}
```
