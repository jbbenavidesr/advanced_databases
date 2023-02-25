-- average grade per subject
SELECT subject_name as "materia",
    AVG(grade) as "nota promedio"
FROM course_enrollment
    JOIN course ON course_enrollment.course_id = course.course_id
    JOIN subject ON course.subject_id = subject.subject_id
GROUP BY subject.subject_id;