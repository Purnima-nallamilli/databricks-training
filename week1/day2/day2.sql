-- 📘 SQL Joins Practice Queries

-- Assumed Tables:
-- students(student_id, student_name)
-- courses(course_id, course_name, instructor_id)
-- enrollments(student_id, course_id)
-- instructors(instructor_id, instructor_name)


-- 1. Display all students and the courses they are enrolled in (include non-enrolled students)
SELECT s.student_name, c.course_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id;


-- 2. Find all courses that currently have no students enrolled
SELECT c.course_name
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE e.student_id IS NULL;


-- 3. Display all instructors and the courses they teach (include unassigned instructors)
SELECT i.instructor_name, c.course_name
FROM instructors i
LEFT JOIN courses c ON i.instructor_id = c.instructor_id;


-- 4. Find all courses that do not have an instructor assigned
SELECT c.course_name
FROM courses c
LEFT JOIN instructors i ON c.instructor_id = i.instructor_id
WHERE i.instructor_id IS NULL;


-- 5. Display all students and enrollment information using RIGHT JOIN
SELECT s.student_name, e.course_id
FROM students s
RIGHT JOIN enrollments e ON s.student_id = e.student_id;


-- 6. Find students who are not enrolled in any course
SELECT s.student_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.course_id IS NULL;


-- 7. Use a FULL OUTER JOIN to display all students and enrollments
SELECT s.student_name, e.course_id
FROM students s
FULL OUTER JOIN enrollments e ON s.student_id = e.student_id;


-- 8. Find all courses that have never appeared in the enrollments table
SELECT c.course_name
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE e.course_id IS NULL;


-- 9. Display all instructors and courses using FULL OUTER JOIN and identify unmatched rows
SELECT i.instructor_name, c.course_name
FROM instructors i
FULL OUTER JOIN courses c ON i.instructor_id = c.instructor_id
WHERE i.instructor_id IS NULL OR c.course_id IS NULL;


-- 10. Report: student name, course name, instructor name (include missing data)
SELECT s.student_name, c.course_name, i.instructor_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id
LEFT JOIN instructors i ON c.instructor_id = i.instructor_id;


--  Bonus: List every student and every course (no relationship needed)
SELECT s.student_name, c.course_name
FROM students s
CROSS JOIN courses c;
