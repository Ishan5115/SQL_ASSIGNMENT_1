use lms;
# 1.-------------------------------------
SELECT 
    co.course_name, c.category_id
FROM
    courses co
        JOIN
    categories c ON co.category_id = c.category_id;
    
#2----------------------------------------
     SELECT 
    c.category_id, COUNT(co.course_name)
FROM
    courses co
        JOIN
    categories c ON co.category_id = c.category_id
GROUP BY category_id;
    
#3----------------------------------------
SELECT 
    first_name, last_name
FROM
    user
WHERE
    role LIKE 'student';
    
#4----------------------------------------
    SELECT 
    module_id, module_name, course_id, module_order
FROM
    modules
WHERE
    course_id = 1
ORDER BY module_order ASC;
    
#5-------------------------------------
   SELECT 
    m.module_name, c.content_id, c.title, c.content_type
FROM
    modules m
        JOIN
    content c ON m.module_id = c.module_id
WHERE
    m.module_id = 2;
    
#6------------------------------------------
    SELECT 
    assessment_id, AVG(score) AS avg_score
FROM
    assessment_submission
GROUP BY assessment_id
HAVING assessment_id = 1;

#7-------------------------------------------------------------
SELECT 
    u.first_name, u.last_name, c.course_name, e.enrolled_at
FROM
    user u
        JOIN
    enrollments e ON u.user_id = e.user_id
        JOIN
    courses c ON e.course_id = c.course_id
WHERE
    u.role LIKE 'student'
ORDER BY u.first_name;
    
#8--------------------------------------------------
    SELECT 
    first_name, last_name
FROM
    user
WHERE
    role LIKE 'instructor';

#9
SELECT 
    a.assessment_id, COUNT(ab.submission_id) AS number_assessment
from
    assessments a
        left JOIN
    assessment_submission ab ON a.assessment_id = ab.assessment_id
   group by assessment_id; 
   
#10 -------------------------------
   SELECT 
    a.assessment_name, ab.score
FROM
    assessments a
        JOIN
    assessment_submission ab ON a.assessment_id = ab.assessment_id
ORDER BY ab.score DESC;

#11-----------------------------------------------------------
SELECT 
    course_id, course_name, description, created_at
FROM
    courses
WHERE
    created_at > '2023-04-01';
    
#12-----------------------------------------------------------
    SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS student_full_name
FROM
    `user` u
        LEFT JOIN
    assessment_submission s ON u.user_id = s.user_id
WHERE
    s.submission_id IS NULL;
    
#13-----------------------------------------------------------
    SELECT 
    c.content_id,
    c.module_id,
    c.title,
    c.content_type,
    c.url
FROM
    content c
        JOIN
    modules m ON c.module_id = m.module_id
        JOIN
    courses co ON m.course_id = co.course_id
        JOIN
    categories ca ON co.category_id = ca.category_id
    where ca.category_name = 'Programming';
    
#14----------------------------------------------------
    SELECT 
    m.module_id,
    m.module_name,
    m.course_id
FROM 
    modules m
LEFT JOIN 
    content c ON m.module_id = c.module_id
WHERE 
    c.content_id IS NULL;
    
#15----------------------------------------------------------
SELECT 
    c.course_name, COUNT(e.enrollment_id) AS enrollment_count
FROM
    courses c
        LEFT JOIN
    enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name , c.course_id
ORDER BY enrollment_count DESC;

#16----------------------------------------------------------
SELECT 
    c.course_id,
    c.course_name,
    AVG(s.score) AS avg_submission_score
FROM 
    courses c
JOIN 
    modules m ON c.course_id = m.course_id
JOIN 
    assessments a ON m.module_id = a.module_id
JOIN 
    assessment_submission s ON a.assessment_id = s.assessment_id
GROUP BY 
    c.course_id, c.course_name
ORDER BY 
    avg_submission_score DESC;

#17----------------------------------------------------------
SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_full_name,
    COUNT(e.enrollment_id) AS total_enrollments
FROM
    user u
        LEFT JOIN
    enrollments e ON u.user_id = e.user_id
GROUP BY u.user_id , u.first_name , u.last_name
ORDER BY total_enrollments DESC;

#18----------------------------------------------
SELECT 
    ab.assessment_id, a.assessment_name, AVG(score) AS avg_score
FROM
    assessment_submission ab
        JOIN
    assessments a ON ab.assessment_id = a.assessment_id
GROUP BY ab.assessment_id, a.assessment_name
ORDER BY avg_score DESC
LIMIT 1;

#19------------------------------------------------
SELECT 
    c.course_name,
    m.module_order,
    m.module_name,
    ct.content_id,
    ct.title AS content_title,
    ct.content_type,
    ct.url
FROM
    courses c
        JOIN
    modules m ON c.course_id = m.course_id
        LEFT JOIN
    content ct ON m.module_id = ct.module_id
ORDER BY c.course_name , m.module_order , ct.title;

#20-------------------------------------------------------------
SELECT 
    c.course_id,
    c.course_name,
    COUNT(a.assessment_id) AS total_assessments
FROM 
    courses c
JOIN 
    modules m ON c.course_id = m.course_id
LEFT JOIN 
    assessments a ON m.module_id = a.module_id
GROUP BY 
    c.course_id, c.course_name
ORDER BY 
    total_assessments DESC;

#21-------------------------------------
SELECT 
    e.enrollment_id,
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS student_full_name,
    c.course_name,
    e.enrolled_at
FROM
    enrollments e
        JOIN
    `user` u ON e.user_id = u.user_id
        JOIN
    courses c ON e.course_id = c.course_id
WHERE
    MONTH(e.enrolled_at) = 5
        AND YEAR(e.enrolled_at) = 2023
ORDER BY e.enrolled_at;

#22-------------------------------------------------------------
SELECT 
    s.submission_id,
    s.submitted_at,
    s.score,
    a.assessment_name,
    c.course_name,
    CONCAT(u.first_name, ' ', u.last_name) AS student_full_name
FROM
    assessment_submission s
        JOIN
    assessments a ON s.assessment_id = a.assessment_id
        JOIN
    modules m ON a.module_id = m.module_id
        JOIN
    courses c ON m.course_id = c.course_id
        JOIN
    `user` u ON s.user_id = u.user_id
ORDER BY c.course_name , a.assessment_name , s.submitted_at;

#23------------------------------------------------------------
SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    u.role
FROM
    `user` u
ORDER BY u.role , full_name;

#24-------------------------------------------------------------
SELECT 
    a.assessment_id,
    a.assessment_name,
    COUNT(s.submission_id) AS total_submissions,
    SUM(CASE
        WHEN s.score >= 60 THEN 1
        ELSE 0
    END) AS passing_submissions,
    ROUND((SUM(CASE
                WHEN s.score >= 60 THEN 1
                ELSE 0
            END) * 100.0) / COUNT(s.submission_id),
            2) AS passing_percentage
FROM
    assessments a
        JOIN
    assessment_submission s ON a.assessment_id = s.assessment_id
GROUP BY a.assessment_id , a.assessment_name
ORDER BY passing_percentage DESC;

#25----------------------------------------------
SELECT 
    c.course_id, c.course_name
FROM
    courses c
        LEFT JOIN
    enrollments e ON c.course_id = e.course_id
WHERE
    e.enrollment_id IS NULL;





    
    