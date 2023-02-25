-- only show programs with male and female students and their respective counts
SELECT tm.m_name as program_name, tm.num_male, tf.num_female
FROM
    (SELECT p.program_name AS m_name, COUNT(*) AS num_male
        FROM program p
        JOIN academic_history ah ON ah.program_id = p.program_id
        JOIN student s ON s.student_id = ah.student_id
        JOIN person pe ON pe.person_id = s.person_id
        WHERE pe.sex LIKE 'Male'
    GROUP BY p.program_name) AS tm
JOIN
    (SELECT p.program_name AS f_name, COUNT(*) AS num_female
        FROM program p
        JOIN academic_history ah ON ah.program_id = p.program_id
        JOIN student s ON s.student_id = ah.student_id
        JOIN person pe ON pe.person_id = s.person_id
        WHERE pe.sex LIKE 'Female'
    GROUP BY p.program_name) AS tf
ON tm.m_name = tf.f_name;