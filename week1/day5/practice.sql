-- 1. List all students along with their department names.
SELECT s.student_name, d.department_name
FROM Student s
JOIN Department d ON s.department_id = d.department_id;

-- 2. Display all staff members and their department names, including staff without departments.
SELECT s.staff_name, d.department_name
FROM Staff s
LEFT JOIN Department d ON s.department_id = d.department_id;

-- 3. Find all departments that currently have no students assigned.
SELECT d.department_name
FROM Department d
LEFT JOIN Student s ON d.department_id = s.department_id
WHERE s.department_id IS NULL;

-- 4. Show students who do not have any marks recorded.
SELECT s.student_name
FROM Student s
LEFT JOIN Mark m ON s.student_id = m.student_id
WHERE m.student_id IS NULL;

-- 5. Display subjects that are not assigned to any staff member.
SELECT sub.subject_name
FROM Subject sub
LEFT JOIN Staff st ON sub.subject_id = st.subject_id
WHERE st.subject_id IS NULL;

-- 6. Find the average CGPA department-wise.
SELECT d.department_name, AVG(s.cgpa) AS avg_cgpa
FROM Student s
JOIN Department d ON s.department_id = d.department_id
GROUP BY d.department_name;

-- 7. Display departments where the average CGPA is greater than 8.0.
SELECT d.department_name, AVG(s.cgpa) AS avg_cgpa
FROM Student s
JOIN Department d ON s.department_id = d.department_id
GROUP BY d.department_name
HAVING AVG(s.cgpa) > 8.0;

-- 8. Find the total number of students in each department.
SELECT d.department_name, COUNT(s.student_id) AS total_students
FROM Department d
LEFT JOIN Student s ON d.department_id = s.department_id
GROUP BY d.department_name;

-- 9. Display the highest and lowest marks scored in each subject.
SELECT subject_id, MAX(marks) AS highest, MIN(marks) AS lowest
FROM Mark
GROUP BY subject_id;

-- 10. Find students who scored more than 90 in any exam.
SELECT DISTINCT s.student_name
FROM Student s
JOIN Mark m ON s.student_id = m.student_id
WHERE m.marks > 90;

-- 11. Display the names of students who belong to the Computer Science department.
SELECT s.student_name
FROM Student s
JOIN Department d ON s.department_id = d.department_id
WHERE d.department_name = 'Computer Science';

-- 12. Find the number of subjects handled by each staff member.
SELECT st.staff_name, COUNT(sub.subject_id) AS subject_count
FROM Staff st
LEFT JOIN Subject sub ON st.staff_id = sub.staff_id
GROUP BY st.staff_name;

-- 13. Display students along with the total marks they obtained across all subjects.
SELECT s.student_name, SUM(m.marks) AS total_marks
FROM Student s
JOIN Mark m ON s.student_id = m.student_id
GROUP BY s.student_name;

-- 14. Find departments with more than 2 staff members.
SELECT d.department_name, COUNT(st.staff_id) AS staff_count
FROM Department d
JOIN Staff st ON d.department_id = st.department_id
GROUP BY d.department_name
HAVING COUNT(st.staff_id) > 2;

-- 15. Display students whose CGPA is above the average CGPA.
SELECT student_name
FROM Student
WHERE cgpa > (SELECT AVG(cgpa) FROM Student);

-- 16. Find staff members earning more than the average salary of their department.
SELECT st.staff_name
FROM Staff st
WHERE st.salary > (
    SELECT AVG(salary)
    FROM Staff
    WHERE department_id = st.department_id
);

-- 17. Display the second highest salary among staff members.
SELECT MAX(salary) AS second_highest_salary
FROM Staff
WHERE salary < (SELECT MAX(salary) FROM Staff);

-- 18. Find students who scored the highest marks in each subject.
SELECT s.student_name, m.subject_id, m.marks
FROM Student s
JOIN Mark m ON s.student_id = m.student_id
WHERE (m.subject_id, m.marks) IN (
    SELECT subject_id, MAX(marks)
    FROM Mark
    GROUP BY subject_id
);

-- 19. Display all students and their marks, including students without marks.
SELECT s.student_name, m.marks
FROM Student s
LEFT JOIN Mark m ON s.student_id = m.student_id;

-- 20. Find subjects where the average marks are below 70.
SELECT subject_id, AVG(marks) AS avg_marks
FROM Mark
GROUP BY subject_id
HAVING AVG(marks) < 70;
