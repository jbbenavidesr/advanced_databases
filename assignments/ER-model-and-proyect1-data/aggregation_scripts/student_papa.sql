-- current grade of students in their program
SELECT p.first_name || ' ' || p.first_surname as "nombre",
    ROUND(
        (SUM(c.grade * su.credits) / SUM(su.credits))::numeric,
        2
    ) as "PAPA"
FROM course_enrollment c
    JOIN academic_history ah ON c.academic_history_id = ah.academic_history_id
    JOIN course co ON c.course_id = co.course_id
    JOIN subject su ON co.subject_id = su.subject_id
    JOIN student s ON ah.student_id = s.student_id
    JOIN person p ON s.person_id = p.person_id
GROUP BY p.person_id;