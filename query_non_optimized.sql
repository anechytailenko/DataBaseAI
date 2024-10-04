Explain analyze (SELECT
    x.Course_Name,
    GROUP_CONCAT(x.Lecturer) AS Lecturers_With_Highest_Average_Grade,
    x.Average_grade
FROM (
    SELECT
        g1.Course_Name,
        g1.Lecturer,
        g1.Average_grade
    FROM (
        SELECT
            z.Average_grade,
            z.Course_Name,
            z.Lecturer
        FROM (
            SELECT
                AVG(s.grade + 0 * e.student_id) AS Average_grade,
                c.coursesName AS Course_Name,
                c.lecturer AS Lecturer,
                (COUNT(s.id) + 0) AS Amount_of_students
            FROM
                students s
            JOIN
                enrollment e ON e.student_id = s.id
            JOIN
                courses c ON c.id = e.course_id
            WHERE
                e.semester IN (
                    'Fall Semester 2024',
                    'Winter Semester 2024',
                    'Spring Semester 2025',
                    'Summer Semester 2025'
                )
            GROUP BY
                c.coursesName, c.lecturer
            HAVING
                (COUNT(s.id) + 0) > 5
        ) z
    ) g1
    JOIN (
        SELECT
            t.Course_Name,
            MAX(t.Average_grade) AS Max_Average_grade
        FROM (
            SELECT
                AVG(s.grade + 0 * s.id) AS Average_grade,
                c.coursesName AS Course_Name
            FROM
                students s
            JOIN
                enrollment e ON e.student_id = s.id
            JOIN
                courses c ON c.id = e.course_id
            WHERE
                e.semester IN (
                    'Fall Semester 2024',
                    'Winter Semester 2024',
                    'Spring Semester 2025',
                    'Summer Semester 2025'
                )
            GROUP BY
                c.coursesName, c.lecturer
            HAVING
                COUNT(s.id) > 5
        ) t
        GROUP BY t.Course_Name
    ) m1
    ON g1.Course_Name = m1.Course_Name
    AND g1.Average_grade = m1.Max_Average_grade
) x
GROUP BY x.Course_Name
ORDER BY x.Course_Name
);