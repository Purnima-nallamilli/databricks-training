-- 21. Create a CTE to calculate total sales per employee
WITH EmployeeSales AS (
    SELECT employee_id, SUM(sales_amount) AS total_sales
    FROM sales
    GROUP BY employee_id
)
SELECT * FROM EmployeeSales;


-- 22. Use a CTE to find employees whose sales exceed the company average
WITH EmployeeSales AS (
    SELECT employee_id, SUM(sales_amount) AS total_sales
    FROM sales
    GROUP BY employee_id
),
AvgSales AS (
    SELECT AVG(total_sales) AS avg_sales FROM EmployeeSales
)
SELECT e.*
FROM EmployeeSales e, AvgSales a
WHERE e.total_sales > a.avg_sales;


-- 23. Create multiple CTEs to calculate customer total spending and rankings
WITH CustomerSpending AS (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
CustomerRank AS (
    SELECT customer_id, total_spent,
           RANK() OVER (ORDER BY total_spent DESC) AS rank
    FROM CustomerSpending
)
SELECT * FROM CustomerRank;


-- 24. Write a recursive CTE to generate numbers from 1 to 10
WITH RECURSIVE Numbers AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num + 1 FROM Numbers WHERE num < 10
)
SELECT * FROM Numbers;


-- 25. Use a recursive CTE to display employee hierarchy data
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT employee_id, manager_id, name
    FROM employees
    WHERE manager_id IS NULL
    UNION ALL
    SELECT e.employee_id, e.manager_id, e.name
    FROM employees e
    INNER JOIN EmployeeHierarchy eh
    ON e.manager_id = eh.employee_id
)
SELECT * FROM EmployeeHierarchy;


-- 26. Create a CTE that filters orders above the average order amount
WITH AvgOrder AS (
    SELECT AVG(amount) AS avg_amount FROM orders
)
SELECT o.*
FROM orders o, AvgOrder a
WHERE o.amount > a.avg_amount;


-- 27. Use a CTE and window function together to rank customers by total spending
WITH CustomerSpending AS (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT customer_id, total_spent,
       DENSE_RANK() OVER (ORDER BY total_spent DESC) AS rank
FROM CustomerSpending;


-- 28. Find the second-highest salary in each department
WITH SalaryRank AS (
    SELECT employee_id, department_id, salary,
           DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rnk
    FROM employees
)
SELECT * FROM SalaryRank WHERE rnk = 2;


-- 29. Display the difference between each employee salary and the department maximum salary
SELECT employee_id, department_id, salary,
       MAX(salary) OVER (PARTITION BY department_id) - salary AS salary_diff
FROM employees;


-- 30. Combine CTEs and window functions to find the top-performing employee in each department based on total sales
WITH EmployeeSales AS (
    SELECT employee_id, department_id, SUM(sales_amount) AS total_sales
    FROM sales
    GROUP BY employee_id, department_id
),
RankedEmployees AS (
    SELECT *,
           RANK() OVER (PARTITION BY department_id ORDER BY total_sales DESC) AS rnk
    FROM EmployeeSales
)
SELECT * FROM RankedEmployees WHERE rnk = 1;
