-- 1. Assign a row number to employees ordered by salary descending
SELECT *,
ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;


-- 2. Rank employees by salary (allow gaps in ranking)
SELECT *,
RANK() OVER (ORDER BY salary DESC) AS rank_val
FROM employees;


-- 3. Rank employees by salary (no gaps in ranking)
SELECT *,
DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank_val
FROM employees;


-- 4. Find the top 3 highest-paid employees
SELECT *
FROM (
    SELECT *,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
    FROM employees
) t
WHERE rn <= 3;


-- 5. Rank employees within each department by salary
SELECT *,
RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
FROM employees;


-- 6. Display the highest salary in each department
SELECT *,
MAX(salary) OVER (PARTITION BY department_id) AS max_salary
FROM employees;


-- 7. Calculate running total of order amounts by date
SELECT *,
SUM(amount) OVER (ORDER BY order_date) AS running_total
FROM orders;


-- 8. Calculate cumulative sales amount for each employee
SELECT *,
SUM(amount) OVER (PARTITION BY employee_id ORDER BY order_date) AS cumulative_sales
FROM orders;


-- 9. Show previous order amount for each customer
SELECT *,
LAG(amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_amount
FROM orders;


-- 10. Show next order amount for each customer
SELECT *,
LEAD(amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS next_amount
FROM orders;


-- 11. Find difference between current and previous order amount
SELECT *,
amount - LAG(amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS diff
FROM orders;


-- 12. Calculate moving average of last 3 orders
SELECT *,
AVG(amount) OVER (
    ORDER BY order_date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS moving_avg
FROM orders;


-- 13. Divide employees into 4 salary quartiles
SELECT *,
NTILE(4) OVER (ORDER BY salary DESC) AS quartile
FROM employees;


-- 14. Find the first order placed by each customer
SELECT *
FROM (
    SELECT *,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS rn
    FROM orders
) t
WHERE rn = 1;

-- 15. Find the latest order placed by each customer
SELECT *
FROM (
    SELECT *,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn
    FROM orders
) t
WHERE rn = 1;


-- 16. Display employee salaries along with department average salary
SELECT *,
AVG(salary) OVER (PARTITION BY department_id) AS dept_avg_salary
FROM employees;


-- 17. Find employees earning above their department average salary
SELECT *
FROM (
    SELECT *,
    AVG(salary) OVER (PARTITION BY department_id) AS dept_avg_salary
    FROM employees
) t
WHERE salary > dept_avg_salary;


-- 18. Calculate department payroll using SUM() OVER(PARTITION BY department)
SELECT *,
SUM(salary) OVER (PARTITION BY department_id) AS dept_payroll
FROM employees;


-- 19. Find percentage contribution of each employee salary within their department
SELECT *,
(salary * 100.0 / SUM(salary) OVER (PARTITION BY department_id)) AS salary_percentage
FROM employees;


-- 20. Show total number of employees alongside each row
SELECT *,
COUNT(*) OVER () AS total_employees
FROM employees;
