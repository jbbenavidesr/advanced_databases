-- number of students per class
SELECT su.subject_name, COUNT(*)
FROM subject su
    JOIN course c ON su.subject_id = c.subject_id
    JOIN course_enrollment ce ON ce.course_id = c.course_id
    JOIN academic_history ah ON ah.academic_history_id = ce.academic_history_id
    JOIN student st ON ah.student_id = st.student_id
    JOIN person p ON st.person_id = p.person_id
GROUP BY su.subject_name;