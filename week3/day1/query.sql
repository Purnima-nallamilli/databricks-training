-- ROW_NUMBER

-- 1
SELECT emp_name, salary,
ROW_NUMBER() OVER (ORDER BY salary DESC) rn
FROM employees;

-- 2
SELECT emp_name, department, salary,
ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) rn
FROM employees;

-- 3
SELECT emp_name, join_date,
ROW_NUMBER() OVER (ORDER BY join_date DESC) rn
FROM employees;

-- 4
SELECT emp_name, department, join_date,
ROW_NUMBER() OVER (PARTITION BY department ORDER BY join_date) rn
FROM employees;


-- RANK

-- 5
SELECT emp_name, salary,
RANK() OVER (ORDER BY salary DESC) rnk
FROM employees;

-- 6
SELECT emp_name, department, salary,
RANK() OVER (PARTITION BY department ORDER BY salary DESC) rnk
FROM employees;

-- 7
SELECT emp_name, join_date,
RANK() OVER (ORDER BY join_date DESC) rnk
FROM employees;


-- DENSE_RANK

-- 8
SELECT emp_name, salary,
DENSE_RANK() OVER (ORDER BY salary DESC) drnk
FROM employees;

-- 9
SELECT emp_name, department, salary,
DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) drnk
FROM employees;

-- 10
SELECT emp_name, join_date,
DENSE_RANK() OVER (ORDER BY join_date DESC) drnk
FROM employees;
