-- 1. List all students along with their department names
SELECT s.student_name, d.department_name
FROM students s
JOIN departments d ON s.department_id = d.department_id;


-- 2. Display all staff members and their department names, including staff without departments
SELECT st.staff_name, d.department_name
FROM staff st
LEFT JOIN departments d ON st.department_id = d.department_id;


-- 3. Find all departments that currently have no students assigned
SELECT d.department_name
FROM departments d
LEFT JOIN students s ON d.department_id = s.department_id
WHERE s.student_id IS NULL;


-- 4. Show students who do not have any marks recorded
SELECT s.student_name
FROM students s
LEFT JOIN marks m ON s.student_id = m.student_id
WHERE m.student_id IS NULL;


-- 5. Display subjects that are not assigned to any staff member
SELECT sub.subject_name
FROM subjects sub
LEFT JOIN staff_subjects ss ON sub.subject_id = ss.subject_id
WHERE ss.staff_id IS NULL;


-- 6. Find the average CGPA department-wise
SELECT d.department_name, AVG(s.cgpa) AS avg_cgpa
FROM students s
JOIN departments d ON s.department_id = d.department_id
GROUP BY d.department_name;


-- 7. Display departments where the average CGPA is greater than 8.0
SELECT d.department_name, AVG(s.cgpa) AS avg_cgpa
FROM students s
JOIN departments d ON s.department_id = d.department_id
GROUP BY d.department_name
HAVING AVG(s.cgpa) > 8.0;


-- 8. Find the total number of students in each department
SELECT d.department_name, COUNT(s.student_id) AS total_students
FROM departments d
LEFT JOIN students s ON d.department_id = s.department_id
GROUP BY d.department_name;


-- 9. Display the highest and lowest marks scored in each subject
SELECT subject_id, MAX(marks) AS highest, MIN(marks) AS lowest
FROM marks
GROUP BY subject_id;


-- 10. Find students who scored more than 90 in any exam
SELECT DISTINCT s.student_name
FROM students s
JOIN marks m ON s.student_id = m.student_id
WHERE m.marks > 90;

-- 11. Display names of students in Computer Science department
SELECT s.student_name
FROM students s
JOIN departments d ON s.department_id = d.department_id
WHERE d.department_name = 'Computer Science';


-- 12. Number of subjects handled by each staff
SELECT staff_id, COUNT(subject_id) AS subject_count
FROM staff_subjects
GROUP BY staff_id;


-- 13. Students with total marks
SELECT s.student_name, SUM(m.marks) AS total_marks
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_name;


-- 14. Departments with more than 2 staff
SELECT department_id, COUNT(*) AS staff_count
FROM staff
GROUP BY department_id
HAVING COUNT(*) > 2;


-- 15. Students with CGPA above average
SELECT student_name
FROM students
WHERE cgpa > (SELECT AVG(cgpa) FROM students);


-- 16. Staff earning more than department average
SELECT s.staff_name
FROM staff s
WHERE salary > (
    SELECT AVG(salary)
    FROM staff
    WHERE department_id = s.department_id
);


-- 17. Second highest salary
SELECT DISTINCT salary
FROM staff
ORDER BY salary DESC
LIMIT 1 OFFSET 1;


-- 18. Students with highest marks in each subject
SELECT student_id, subject_id, marks
FROM marks m
WHERE marks = (
    SELECT MAX(m2.marks)
    FROM marks m2
    WHERE m.subject_id = m2.subject_id
);


-- 19. All students with marks (including no marks)
SELECT s.student_name, m.marks
FROM students s
LEFT JOIN marks m ON s.student_id = m.student_id;


-- 20. Subjects with avg marks < 70
SELECT subject_id, AVG(marks) AS avg_marks
FROM marks
GROUP BY subject_id
HAVING AVG(marks) < 70;


-- 21. Students ordered by CGPA desc
SELECT * FROM students
ORDER BY cgpa DESC;


-- 22. Total salary department-wise
SELECT department_id, SUM(salary) AS total_salary
FROM staff
GROUP BY department_id;


-- 23. Departments where salary > 200000
SELECT department_id, SUM(salary)
FROM staff
GROUP BY department_id
HAVING SUM(salary) > 200000;


-- 24. Students admitted after 2021 with CGPA > 7.5
SELECT *
FROM students
WHERE admission_year > 2021 AND cgpa > 7.5;


-- 25. Students admitted each year
SELECT admission_year, COUNT(*) 
FROM students
GROUP BY admission_year;


-- 26. City with max students
SELECT city
FROM students
GROUP BY city
ORDER BY COUNT(*) DESC
LIMIT 1;


-- 27. Departments with staff count (including empty)
SELECT d.department_name, COUNT(s.staff_id)
FROM departments d
LEFT JOIN staff s ON d.department_id = s.department_id
GROUP BY d.department_name;


-- 28. Students who failed (marks < 50)
SELECT DISTINCT s.student_name
FROM students s
JOIN marks m ON s.student_id = m.student_id
WHERE m.marks < 50;


-- 29. Staff hired before 2018
SELECT *
FROM staff
WHERE hire_date < '2018-01-01';


-- 30. Departments with no NULL salary
SELECT department_id
FROM staff
GROUP BY department_id
HAVING COUNT(*) = COUNT(salary);


-- 31. Row number by CGPA
SELECT student_name, cgpa,
ROW_NUMBER() OVER (ORDER BY cgpa DESC) AS row_num
FROM students;


-- 32. Rank students by CGPA
SELECT student_name, cgpa,
RANK() OVER (ORDER BY cgpa DESC) AS rank_val
FROM students;


-- 33. Dense rank staff salaries
SELECT staff_name, salary,
DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank
FROM staff;


-- 34. Top 3 students
SELECT *
FROM (
    SELECT student_name, cgpa,
    RANK() OVER (ORDER BY cgpa DESC) AS rnk
    FROM students
) t
WHERE rnk <= 3;


-- 35. Running total of marks
SELECT student_id, marks,
SUM(marks) OVER (PARTITION BY student_id ORDER BY subject_id) AS running_total
FROM marks;


-- 36. Avg marks per subject (window)
SELECT subject_id,
AVG(marks) OVER (PARTITION BY subject_id) AS avg_marks
FROM marks;


-- 37. Previous marks using LAG
SELECT student_id, marks,
LAG(marks) OVER (PARTITION BY student_id ORDER BY subject_id) AS prev_marks
FROM marks;


-- 38. Next marks using LEAD
SELECT student_id, marks,
LEAD(marks) OVER (PARTITION BY student_id ORDER BY subject_id) AS next_marks
FROM marks;


-- 39. Highest marks per subject (window)
SELECT subject_id, marks,
MAX(marks) OVER (PARTITION BY subject_id) AS max_marks
FROM marks;


-- 40. Cumulative average
SELECT student_id, marks,
AVG(marks) OVER (ORDER BY subject_id) AS cumulative_avg
FROM marks;


-- 41. First student per department
SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY admission_year) rn
    FROM students
) t
WHERE rn = 1;


-- 42. Latest hired staff per department
SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY hire_date DESC) rn
    FROM staff
) t
WHERE rn = 1;


-- 43. CGPA quartiles
SELECT student_name, cgpa,
NTILE(4) OVER (ORDER BY cgpa DESC) AS quartile
FROM students;


-- 44. Percentage rank
SELECT student_name, cgpa,
PERCENT_RANK() OVER (ORDER BY cgpa) AS pct_rank
FROM students;


-- 45. Cumulative salary distribution
SELECT staff_name, salary,
CUME_DIST() OVER (ORDER BY salary) AS cum_dist
FROM staff;


-- 46. Marks above subject average
SELECT *
FROM marks m
WHERE marks > (
    SELECT AVG(m2.marks)
    FROM marks m2
    WHERE m.subject_id = m2.subject_id
);


-- 47. Departments with avg salary > overall avg
SELECT department_id
FROM staff
GROUP BY department_id
HAVING AVG(salary) > (SELECT AVG(salary) FROM staff);


-- 48. Students above department avg marks
SELECT s.student_name
FROM students s
JOIN marks m ON s.student_id = m.student_id
WHERE m.marks > (
    SELECT AVG(m2.marks)
    FROM marks m2
    JOIN students s2 ON m2.student_id = s2.student_id
    WHERE s2.department_id = s.department_id
);


-- 49. 3rd highest mark
SELECT marks
FROM (
    SELECT marks,
    DENSE_RANK() OVER (ORDER BY marks DESC) rnk
    FROM marks
) t
WHERE rnk = 3;


-- 50. Final report
SELECT 
    s.student_name,
    d.department_name,
    sub.subject_name,
    m.exam_type,
    m.marks,
    AVG(m.marks) OVER (PARTITION BY d.department_id) AS dept_avg,
    RANK() OVER (ORDER BY m.marks DESC) AS overall_rank
FROM students s
JOIN departments d ON s.department_id = d.department_id
JOIN marks m ON s.student_id = m.student_id
JOIN subjects sub ON m.subject_id = sub.subject_id;
