-- 21. Display students ordered by CGPA in descending order.
SELECT * FROM students
ORDER BY cgpa DESC;

-- 22. Find the total salary expenditure department-wise.
SELECT department_id, SUM(salary) AS total_salary
FROM staff
GROUP BY department_id;

-- 23. Display departments where the total salary exceeds 200000.
SELECT department_id, SUM(salary) AS total_salary
FROM staff
GROUP BY department_id
HAVING SUM(salary) > 200000;

-- 24. Find students admitted after 2021 and having CGPA above 7.5.
SELECT * FROM students
WHERE admission_year > 2021 AND cgpa > 7.5;

-- 25. Display the number of students admitted each year.
SELECT admission_year, COUNT(*) AS total_students
FROM students
GROUP BY admission_year;

-- 26. Find the city with the maximum number of students.
SELECT city
FROM students
GROUP BY city
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 27. Display all departments and their staff count, including empty departments.
SELECT d.department_id, COUNT(s.staff_id) AS staff_count
FROM departments d
LEFT JOIN staff s ON d.department_id = s.department_id
GROUP BY d.department_id;

-- 28. Find students who have failed in at least one subject (marks < 50).
SELECT DISTINCT student_id
FROM marks
WHERE marks < 50;

-- 29. Display staff hired before 2018.
SELECT * FROM staff
WHERE hire_date < '2018-01-01';

-- 30. Find departments where no staff salary is recorded as NULL.
SELECT department_id
FROM staff
GROUP BY department_id
HAVING COUNT(*) = COUNT(salary);

-- 31. Assign a row number to students ordered by CGPA.
SELECT student_id, cgpa,
ROW_NUMBER() OVER (ORDER BY cgpa DESC) AS row_num
FROM students;

-- 32. Rank students based on their CGPA.
SELECT student_id, cgpa,
RANK() OVER (ORDER BY cgpa DESC) AS rank
FROM students;

-- 33. Display dense rank of staff salaries.
SELECT staff_id, salary,
DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank
FROM staff;

-- 34. Find the top 3 highest scoring students using window functions.
SELECT * FROM (
    SELECT student_id, SUM(marks) AS total_marks,
    RANK() OVER (ORDER BY SUM(marks) DESC) AS rnk
    FROM marks
    GROUP BY student_id
) t
WHERE rnk <= 3;

-- 35. Display running total of marks for each student.
SELECT student_id, marks,
SUM(marks) OVER (PARTITION BY student_id ORDER BY exam_date) AS running_total
FROM marks;

-- 36. Find the average marks for each subject using window functions.
SELECT subject_id, marks,
AVG(marks) OVER (PARTITION BY subject_id) AS avg_marks
FROM marks;

-- 37. Display previous exam marks for each student using LAG().
SELECT student_id, exam_date, marks,
LAG(marks) OVER (PARTITION BY student_id ORDER BY exam_date) AS prev_marks
FROM marks;

-- 38. Display next exam marks for each student using LEAD().
SELECT student_id, exam_date, marks,
LEAD(marks) OVER (PARTITION BY student_id ORDER BY exam_date) AS next_marks
FROM marks;

-- 39. Find the highest marks within each subject using MAX() OVER().
SELECT subject_id, marks,
MAX(marks) OVER (PARTITION BY subject_id) AS max_marks
FROM marks;

-- 40. Display cumulative average marks ordered by exam date.
SELECT student_id, exam_date, marks,
AVG(marks) OVER (PARTITION BY student_id ORDER BY exam_date) AS cum_avg
FROM marks;

-- 41. Find the first student admitted in each department.
SELECT * FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY admission_year) AS rn
    FROM students
) t
WHERE rn = 1;

-- 42. Display the latest hired staff member in each department.
SELECT * FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY hire_date DESC) AS rn
    FROM staff
) t
WHERE rn = 1;

-- 43. Divide students into 4 CGPA quartiles using NTILE().
SELECT student_id, cgpa,
NTILE(4) OVER (ORDER BY cgpa DESC) AS quartile
FROM students;

-- 44. Find percentage rank of students based on CGPA.
SELECT student_id, cgpa,
PERCENT_RANK() OVER (ORDER BY cgpa) AS percent_rank
FROM students;

-- 45. Display cumulative distribution of salaries.
SELECT staff_id, salary,
CUME_DIST() OVER (ORDER BY salary) AS cum_dist
FROM staff;

-- 46. Find subjects where a student's marks are above the subject average.
SELECT student_id, subject_id, marks
FROM (
    SELECT *,
    AVG(marks) OVER (PARTITION BY subject_id) AS avg_marks
    FROM marks
) t
WHERE marks > avg_marks;

-- 47. Find departments whose average staff salary is higher than overall average salary.
SELECT department_id
FROM staff
GROUP BY department_id
HAVING AVG(salary) > (SELECT AVG(salary) FROM staff);

-- 48. Display students who scored above department average marks.
SELECT student_id, marks
FROM (
    SELECT m.*, s.department_id,
    AVG(marks) OVER (PARTITION BY s.department_id) AS dept_avg
    FROM marks m
    JOIN students s ON m.student_id = s.student_id
) t
WHERE marks > dept_avg;

-- 49. Find the 3rd highest mark using DENSE_RANK().
SELECT marks FROM (
    SELECT marks,
    DENSE_RANK() OVER (ORDER BY marks DESC) AS rnk
    FROM marks
) t
WHERE rnk = 3;

-- 50. Report: student name, department, subject, exam type, marks, department avg, overall rank.
SELECT s.name, s.department_id, m.subject_id, m.exam_type, m.marks,
AVG(m.marks) OVER (PARTITION BY s.department_id) AS dept_avg,
RANK() OVER (ORDER BY m.marks DESC) AS overall_rank
FROM students s
JOIN marks m ON s.student_id = m.student_id;
