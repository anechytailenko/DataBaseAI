Explain analyze ( WITH Grade_course_Lecturer AS (
    SELECT
        AVG(s.grade) AS Average_grade,
        c.coursesName AS Course_Name,
        c.lecturer AS Lecturer,
        COUNT(s.id) AS Amount_of_students
    FROM
        students s
    JOIN
        enrollment e ON e.student_id = s.id
    JOIN
        courses c ON c.id = e.course_id
    WHERE
        e.semester IN ('Fall Semester 2024', 'Winter Semester 2024', 'Spring Semester 2025', 'Summer Semester 2025')
    GROUP BY
        c.coursesName, c.lecturer
    HAVING
        COUNT(s.id) > 5
),
Max_Grade_per_Course AS (
    SELECT
        Course_Name,
        MAX(Average_grade) AS Max_Average_grade
    FROM
        Grade_course_Lecturer
    GROUP BY
        Course_Name
)
SELECT
    g.Course_Name,
    GROUP_CONCAT(g.Lecturer) AS Lecturers_With_Highest_Average_Grade,
    g.Average_grade
FROM
    Grade_course_Lecturer g
JOIN
    Max_Grade_per_Course m
ON
    g.Course_Name = m.Course_Name
    AND g.Average_grade = m.Max_Average_grade
   GROUP BY
    g.Course_Name
   order by g.Course_Name);