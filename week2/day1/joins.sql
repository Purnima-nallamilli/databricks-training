-- 1. Retrieve the names of employees and their corresponding managers from the "employees" table.
SELECT e.emp_name AS employee_name, m.emp_name AS manager_name
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.emp_id;


-- 2. List the names of employees who report to a manager, along with their manager's name, from the "employees" table.
SELECT e.emp_name, m.emp_name AS manager_name
FROM employees e
JOIN employees m
ON e.manager_id = m.emp_id;


-- 3. Display a list of employees who do not belong to any department, even if the department data is missing.
SELECT e.emp_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL;


-- 4. Fetch the names of employees and the projects they are assigned to. For employees who are not assigned any projects, show NULL for the project.
SELECT e.emp_name, p.project_name
FROM employees e
LEFT JOIN projects p
ON e.emp_id = p.emp_id;


-- 5. List all employees who have completed at least one project, showing their names and the project names.
SELECT e.emp_name, p.project_name
FROM employees e
INNER JOIN projects p
ON e.emp_id = p.emp_id;


-- 6. Show the names of employees and their projects, ensuring that no project is omitted even if an employee is not assigned to it.
SELECT e.emp_name, p.project_name
FROM projects p
LEFT JOIN employees e
ON e.emp_id = p.emp_id;


-- 7. Retrieve the names of employees and their corresponding department names, including employees who are not in any department.
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;


-- 8. Find the names of all departments and employees, ensuring that departments with no employees are included.
SELECT d.dept_name, e.emp_name
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id;


-- 9. Show the names of employees and their department names, including employees not assigned to any department and departments without employees.
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
UNION
SELECT e.emp_name, d.dept_name
FROM employees e
RIGHT JOIN departments d
ON e.dept_id = d.dept_id;


-- 10. Find employees who have not completed any project, along with the project details where applicable.
SELECT e.emp_name, p.project_name
FROM employees e
LEFT JOIN projects p
ON e.emp_id = p.emp_id
WHERE p.project_name IS NULL;


-- 11. Retrieve the names of employees and the names of their projects, including employees who are not working on any project.
SELECT e.emp_name, p.project_name
FROM employees e
LEFT JOIN projects p
ON e.emp_id = p.emp_id;


-- 12. List all projects and the employees assigned to them, even for projects that have no employees.
SELECT e.emp_name, p.project_name
FROM projects p
LEFT JOIN employees e
ON e.emp_id = p.emp_id;


-- 13. Show the names of all employees who have both a manager and at least one project, listing the manager's name as well.
SELECT e.emp_name, m.emp_name AS manager_name, p.project_name
FROM employees e
JOIN employees m
ON e.manager_id = m.emp_id
JOIN projects p
ON e.emp_id = p.emp_id;


-- 14. List the names of employees and the corresponding department names, but exclude those employees who don't belong to a department.
SELECT e.emp_name, d.dept_name
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id;


-- 15. List the names of all departments and employees, ensuring that even if a department has no employees, it is included in the result.
SELECT d.dept_name, e.emp_name
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id;


-- 16. Retrieve employees who have worked on at least one project and do not belong to a department, listing their name and project details.
SELECT e.emp_name, p.project_name
FROM employees e
JOIN projects p
ON e.emp_id = p.emp_id
LEFT JOIN departments d
ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL;


-- 17. Find the total number of employees who belong to a department, ensuring the departments with no employees are still included.
SELECT d.dept_name, COUNT(e.emp_name) AS total_employees
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;


-- 18. Show the employees and their managers, displaying only those employees who report to a manager, excluding employees without managers.
SELECT e.emp_name, m.emp_name AS manager_name
FROM employees e
JOIN employees m
ON e.manager_id = m.emp_id;


-- 19. Display all employee names along with their corresponding managers' names, but include employees who do not have managers.
SELECT e.emp_name, m.emp_name AS manager_name
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.emp_id;


-- 20. Find the names of departments and the number of employees in each department, including departments that have no employees.
SELECT d.dept_name, COUNT(e.emp_name) AS total_employees
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;


-- 21. List all employees and the departments they belong to, ensuring that departments with no employees are also listed.
SELECT d.dept_name, e.emp_name
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id;


-- 22. Retrieve the names of employees and their project assignments, including employees who are not assigned to any projects.
SELECT e.emp_name, p.project_name
FROM employees e
LEFT JOIN projects p
ON e.emp_id = p.emp_id;


-- 23. List the names of all employees and their respective department and project assignments, including employees who are not assigned to a project or department.
SELECT e.emp_name, d.dept_name, p.project_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
LEFT JOIN projects p
ON e.emp_id = p.emp_id;


-- 24. Display the names of employees who belong to at least one department, with the department name listed, but include employees without a department as well.
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;
