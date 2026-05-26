-- LEVEL 1: BASIC

-- Employees with NULL salary
SELECT * FROM Employees WHERE salary IS NULL;

-- Orders with discount NOT NULL
SELECT * FROM Orders WHERE discount IS NOT NULL;

-- Products where category is NULL
SELECT * FROM Products WHERE category IS NULL;

-- Count employees with NULL manager
SELECT COUNT(*) FROM Employees WHERE manager_id IS NULL;


-- LEVEL 2: IFNULL

-- Replace NULL salary with 0
SELECT name, IFNULL(salary, 0) AS salary FROM Employees;

-- Replace NULL bonus with 1000
SELECT name, IFNULL(bonus, 1000) AS bonus FROM Employees;

-- Replace NULL amount with 500
SELECT order_id, IFNULL(amount, 500) FROM Orders;

-- Replace NULL stock with 0
SELECT product_name, IFNULL(stock, 0) FROM Products;


-- LEVEL 3: COALESCE

-- Employee earnings (salary or bonus)
SELECT name, COALESCE(salary, bonus) AS earnings FROM Employees;

-- First available value
SELECT name, COALESCE(salary, bonus, 0) FROM Employees;

-- Product price with default
SELECT product_name, COALESCE(price, 1000) FROM Products;

-- Customer payment
SELECT order_id, COALESCE(amount, discount, 0) FROM Orders;


-- LEVEL 4: NULLIF

-- Convert salary to NULL if 0
SELECT NULLIF(salary, 0) FROM Employees;

-- Convert discount to NULL if 0
SELECT NULLIF(discount, 0) FROM Orders;

-- Avoid divide by zero
SELECT amount / NULLIF(discount, 0) FROM Orders;

-- Replace specific coupon
SELECT NULLIF(coupon_code, 'DISC10') FROM Orders;


-- LEVEL 5: REAL-TIME

-- Total earnings
SELECT name, IFNULL(salary, 0) + IFNULL(bonus, 0) AS total_income FROM Employees;

-- Employees with both salary and bonus NULL
SELECT * FROM Employees WHERE salary IS NULL AND bonus IS NULL;

-- Products with price NULL but category NOT NULL
SELECT * FROM Products WHERE price IS NULL AND category IS NOT NULL;

-- Orders where amount and discount both NULL
SELECT * FROM Orders WHERE amount IS NULL AND discount IS NULL;


-- LEVEL 6: ADVANCED

-- Employee income with fallback
SELECT name, COALESCE(salary, bonus, 1000) FROM Employees;

-- Final payable amount
SELECT order_id, IFNULL(amount, 0) - IFNULL(discount, 0) AS final_amount FROM Orders;

-- Employees with NULL salary but manager exists
SELECT * FROM Employees WHERE salary IS NULL AND manager_id IS NOT NULL;
