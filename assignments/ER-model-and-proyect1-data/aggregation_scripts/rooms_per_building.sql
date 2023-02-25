-- rooms per building
SELECT b.building_name, COUNT(*) as "n_classrooms"
FROM building b
    JOIN classroom c ON c.building_id = b.building_id
GROUP BY b.building_name;