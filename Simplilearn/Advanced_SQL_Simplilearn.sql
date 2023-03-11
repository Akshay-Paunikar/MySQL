USE sql_intro;

SELECT * FROM emp_details;

-- Subqueries in SQL -- 
-- Q1. Find the employees who have salary higher than the average of all employee salaries.

SELECT Name, salary
FROM emp_details
WHERE salary > (SELECT AVG(salary)
				FROM emp_details);

-- Q2. Find all employees whose salaries are higher than the salary of employee named Sara

SELECT Name, salary
FROM emp_details
WHERE salary > (SELECT salary
				FROM emp_details
                WHERE Name = 'Sara');

USE classicmodels;
SELECT * FROM products;
SELECT * FROM orderdetails;

-- Q3 Product code Product Name and the MSRP of the products whose price is less than $100.
SELECT productCode, productName, MSRP
FROM products
WHERE productCode IN (SELECT productCode
						FROM orderdetails 
                        WHERE priceEach < 100);

/* STORED PROCEDURES */
-- The customer who has credit limit more than 75000 
USE classicmodels;

SELECT * FROM customers;

DELIMITER &&
CREATE PROCEDURE top_customer()
BEGIN
SELECT customerName, city, country, creditLimit
FROM customers
WHERE creditLimit > 75000;
END &&
DELIMITER ;

CALL top_customer();

-- Stored Procudures using IN Parameter
-- Top records of products according to their MSRP.
DELIMITER //
CREATE PROCEDURE sort_product(IN var INT)
BEGIN
SELECT productName, productLine, MSRP
FROM products
ORDER BY MSRP DESC LIMIT var;
END //
DELIMITER ;

CALL sort_product(10);

-- Update the priceEach where it is 214.30 to 215

DELIMITER //
CREATE PROCEDURE update_price(IN temp_name INT, IN new_price FLOAT)
BEGIN
UPDATE orderdetails
SET priceEach = new_price * 1.1
WHERE orderNumber = temp_name;
END //
DELIMITER ;

CALL update_price(10103,215);

CREATE TABLE students(
student_ID INT NOT NULL,
student_Name VARCHAR(50),
student_Age INT,
student_Gender VARCHAR(10),
student_City VARCHAR(50),
student_TotalMarks INT,
PRIMARY KEY (student_ID));

INSERT INTO students VALUES
(001, 'Akshay Paunikar', 15, 'Male', 'Nagpur', 95),
(002, 'Ankita Tawale', 19, 'Female', 'Pune', 85),
(003, 'Kautuka Tawale', 5, 'Female', 'Pune', 90),
(004, 'Darpan Tawale', 23, 'Male', 'Pune', 98),
(005, 'Pushpa Paunikar', 30, 'Female', 'Nagpur', 100);

 SELECT * FROM students;
 
 -- Create a stored procedure which will update marks when we specify name
 
 DELIMITER &&
 CREATE PROCEDURE update_marks(IN temp_name VARCHAR(50), IN new_marks INT)
 BEGIN
 UPDATE students
 SET student_TotalMarks = new_marks
 WHERE student_Name = temp_name;
 END &&
 DELIMITER ;

CALL update_marks('Ankita Tawale', 92);
CALL update_marks('Pushpa Paunikar', 75);
CALL update_marks('Darpan Tawale', 85);

-- STORED PROCEDURE USING OUT PARAMETER --
-- Total female students in our data

DELIMITER &&
CREATE PROCEDURE count_students(OUT total_students INT, IN temp_Gender VARCHAR(50))
BEGIN
SELECT COUNT(student_Name) INTO total_students
FROM students
WHERE student_Gender = temp_Gender;
END &&
DELIMITER ;
 
CALL count_students(@employee,'Female');
SELECT @employee AS female_employee;
CALL count_students(@emp_male, 'Male');
SELECT @emp_male AS male_employee;

-- TRIGGERS in SQL --
-- A Trigger is a special type of SQL procudure which runs automatically when an event occurs in the database servers.
-- There are 3 types of Triggers in SQL
-- Data Manipulation Trigger
-- Data Definition Trigger
-- Logon Triggers

DELIMITER &&
CREATE TRIGGER verify_marks
BEFORE INSERT ON students
FOR EACH ROW
IF new.student_TotalMarks < 0 THEN SET new.student_TotalMarks = 35;
END IF; &&
DELIMITER ;

INSERT INTO students VALUES
(006, 'Pandurang Paunikar', 35, 'Male', 'Nagpur', -10),
(007, 'Aniket Paunikar', 35, 'Male', 'Pune', -22.5); 

SELECT * FROM students;

DELIMITER &&
CREATE TRIGGER valid_age
BEFORE INSERT ON students
FOR EACH ROW
IF new.student_Age < 3 THEN 
SET new.student_Age = 5;
END IF; &&
DELIMITER ;

INSERT INTO students VALUES
(008, 'Anay Prachand', 2, 'Male', 'Kharbi', 99),
(009, 'Arin Kumbhare', 3, 'Male', 'Kalyan', 75),
(010, 'Nishita Kumbhare', 4, 'Female', 'Kalyan', 88);  

DROP TRIGGER valid_age;

# Views in SQL

USE classicmodels;

SELECT * FROM customers;

CREATE VIEW cust_details
AS
SELECT customerName, phone, city
FROM customers;

SELECT * FROM cust_details;

-- Join 2 differnet tables and create a view
CREATE VIEW product_description
AS
SELECT productName, quantityInStock, MSRP, textDescription
FROM products as P
INNER JOIN productlines as PL
ON P.productLine = PL.productLine; 

SELECT * FROM product_description;

-- RENAME the VIEWS
RENAME TABLE product_description
TO vehicle_description;

-- Display Views
SHOW FULL TABLES
WHERE table_type = 'VIEW';  

# Delete View
DROP VIEW cust_details;

-- Window Function in SQL

USE sql_intro;
SELECT * FROM emp_details;
-- Total combine salary by Gender
SELECT Name, Age, sex, City, salary,
SUM(salary) OVER (PARTITION BY sex) AS Total_Salary
FROM emp_details;

-- Row Number --  
SELECT ROW_NUMBER() OVER (ORDER BY salary) AS row_num,
Name, salary FROM emp_details
ORDER BY salary DESC; 

-- To find duplicates
CREATE TABLE demo (
st_id INT NOT NULL,
st_name VARCHAR(50),
st_age INT
);

INSERT INTO demo VALUES
(101, 'Shane Watson', 39),
(102, 'Ricky Ponting', 42),
(102, 'Ricky Ponting', 42),
(103, 'Pravin Tambe', 48),
(101, 'Shane Watson', 39);

SELECT * FROM demo;

SELECT st_id, st_name, st_age, ROW_NUMBER() OVER 
(PARTITION BY st_id, st_name, st_age ORDER BY st_id) AS row_num
FROM demo; 

-- RANK Function --
CREATE TABLE demo1 (var_a INT);

INSERT INTO demo1
VALUES
(101),
(102),
(103),
(103),
(104),
(104),
(105),
(106),
(106),
(107); 

SELECT * FROM demo1;

SELECT var_a,
RANK() OVER (ORDER BY var_a) AS test_rank
FROM demo1;

-- First Value() --  
SELECT Name, Age, sex, City, salary, FIRST_VALUE(Name)
OVER (ORDER BY salary DESC) AS highest_salary
FROM emp_details;

SELECT Name, Age, sex, City, salary, FIRST_VALUE(Name)
OVER (PARTITION BY sex ORDER BY salary DESC) AS highest_salary
FROM emp_details;





 