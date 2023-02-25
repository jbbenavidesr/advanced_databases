SELECT p.program_name,
    SUM(cc.required_credits) AS total_credits
FROM program p
    JOIN curricular_component cc ON p.program_id = cc.program_id
GROUP BY p.program_id;