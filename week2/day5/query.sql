-- Q1: Extract numbers at beginning
SELECT REGEXP_SUBSTR(mixed_value, '^[0-9]+') FROM regex_practice;

-- Q2: Extract numbers at end
SELECT REGEXP_SUBSTR(mixed_value, '[0-9]+$') FROM regex_practice;

-- Q3: First character
SELECT SUBSTRING(mixed_value,1,1) FROM regex_practice;

-- Q4: Last character
SELECT RIGHT(mixed_value,1) FROM regex_practice;

-- Q5: Exactly two digits
SELECT REGEXP_SUBSTR(mixed_value, '[0-9]{2}') FROM regex_practice;

-- Q6: Single digit
SELECT REGEXP_SUBSTR(mixed_value, '[0-9]') FROM regex_practice;

-- Q7: Country code from phone
SELECT REGEXP_SUBSTR(phone, '[0-9]+') FROM regex_practice;

-- Q8: Numbers between alphabets
SELECT REGEXP_SUBSTR(mixed_value, '[a-zA-Z]+([0-9]+)[a-zA-Z]+') FROM regex_practice;

-- Q9: Email before @
SELECT SUBSTRING_INDEX(email,'@',1) FROM regex_practice;

-- Q10: After @
SELECT SUBSTRING_INDEX(email,'@',-1) FROM regex_practice;

-- Q11: Domain only
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(email,'@',-1),'.',1) FROM regex_practice;

-- Q12: After last dot
SELECT SUBSTRING_INDEX(email,'.',-1) FROM regex_practice;

-- Q13: Alphabets sequence
SELECT REGEXP_SUBSTR(mixed_value, '[a-zA-Z]+') FROM regex_practice;

-- Q14: Numeric sequence
SELECT REGEXP_SUBSTR(mixed_value, '[0-9]+') FROM regex_practice;

-- Q15: First 3 chars
SELECT LEFT(full_text,3) FROM regex_practice;

-- Q16: Last 2 chars
SELECT RIGHT(full_text,2) FROM regex_practice;

-- Q17: Employee number
SELECT REGEXP_SUBSTR(full_text, '[0-9]+') FROM regex_practice;

-- Q18: Country code at end
SELECT REGEXP_SUBSTR(full_text, '[0-9]+$') FROM regex_practice;

-- Q19: Text between underscores
SELECT REGEXP_SUBSTR(full_text, '_([A-Za-z]+)_',1,1,NULL,1) FROM regex_practice;

-- Q20: Country code after +
SELECT REGEXP_SUBSTR(phone, '(?<=\\+)[0-9]+') FROM regex_practice;
