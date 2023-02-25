SELECT faculty.faculty_name,
    COUNT(*) AS num_students
FROM student
    JOIN academic_history ON student.student_id = academic_history.student_id
    JOIN program ON academic_history.program_id = program.program_id
    JOIN department ON program.department_id = department.department_id
    JOIN faculty ON department.faculty_id = faculty.faculty_id
GROUP BY faculty.faculty_id;