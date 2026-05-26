-- LENGTH / CHAR_LENGTH
SELECT full_name, LENGTH(full_name) FROM employees;
SELECT full_name, CHAR_LENGTH(full_name) FROM employees;

-- UPPER / LOWER
SELECT UPPER(department), LOWER(city) FROM employees;

-- TRIM / LTRIM / RTRIM
SELECT TRIM(full_name), LTRIM(full_name), RTRIM(full_name) FROM employees;

-- CONCAT
SELECT CONCAT(full_name, ' - ', department) AS emp_details FROM employees;

-- CONCAT_WS
SELECT CONCAT_WS(' | ', emp_id, full_name, city) FROM employees;

-- SUBSTRING
SELECT SUBSTRING(email, 1, 7) FROM employees;

-- LEFT / RIGHT
SELECT LEFT(full_name, 4), RIGHT(city, 3) FROM employees;

-- INSTR
SELECT email, INSTR(email, '@') FROM employees;

-- LOCATE
SELECT email, LOCATE('.', email) FROM employees;

-- REPLACE
SELECT REPLACE(department, 'Data', 'Big Data') FROM employees;

-- REVERSE
SELECT full_name, REVERSE(full_name) FROM employees;

-- LPAD / RPAD
SELECT LPAD(emp_id, 5, '0') FROM employees;
SELECT RPAD(city, 15, '*') FROM employees;

-- TRIM + REPLACE
SELECT TRIM(REPLACE(city, ' ', '')) FROM employees;

-- IFNULL
SELECT full_name, IFNULL(remarks, 'No remarks') FROM employees;

-- COALESCE
SELECT full_name, COALESCE(remarks, 'N/A') FROM employees;

-- FIND_IN_SET
SELECT FIND_IN_SET('Analytics', 'Data,Analytics,AI');
