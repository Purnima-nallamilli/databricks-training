CREATE TABLE regex_practice (
    id INT,
    full_text VARCHAR(200),
    email VARCHAR(100),
    phone VARCHAR(30),
    mixed_value VARCHAR(100)
);

INSERT INTO regex_practice VALUES
(1,'EMP001_IN_91','karthik@gmail.com','+91-9876543210','abc123xyz'),
(2,'EMP002_US_01','rahul@yahoo.com','+1-7654321098','test45done'),
(3,'EMP003_UK_44','john@outlook.com','+44-9988776655','run9fast'),
(4,'EMP004_AU_61','steve@gmail.com','+61-8899776655','go88home'),
(5,'EMP005_IN_91','arjun@company.in','+91-7788996655','data77lake');
