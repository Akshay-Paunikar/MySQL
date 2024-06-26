SELECT VERSION();
SELECT SESSION_USER();

-- ------------------------
-- DATABASE MANIPULATION --
-- ------------------------ 

CREATE DATABASE IF NOT EXISTS revision_practice;
USE revision_practice;
SHOW DATABASES;
SELECT DATABASE(); -- Displays Current Database Selected
CREATE DATABASE deletethis;
DROP DATABASE IF EXISTS deletethis;

-- ------------------
-- STORAGE ENGINES --
-- ------------------
-- INNODB, MyISAM, MERGE (MRG_MyISAM), CSV 

SET DEFAULT_STORAGE_ENGINE = INNODB;

-- Setting default storage engine for a table --

CREATE TABLE IF NOT EXISTS engine(
emp_id VARCHAR(4) NOT NULL,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100),
gender VARCHAR(1),
role VARCHAR(100),
dept VARCHAR(100),
manager_id VARCHAR(4),
CHECK(gender IN ('M', 'F', 'O')) 
) ENGINE=INNODB;

ALTER TABLE engine ENGINE = MERGE; -- For changing the storage engine of table 

-- -----------------------------
-- CREATING & MANAGING TABLES --
-- -----------------------------

CREATE TABLE IF NOT EXISTS emp_records(
emp_id VARCHAR(4) NOT NULL,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100),
gender VARCHAR(1)
)ENGINE = INNODB;

SELECT * FROM engine;

/* CHECK Constraints */

CREATE TABLE IF NOT EXISTS emp_records_2(
emp_id VARCHAR(4) NOT NULL,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100),
gender VARCHAR(1),
role VARCHAR(100),
dept VARCHAR(100),
manager_id VARCHAR(4),
exp INTEGER NOT NULL CHECK(EXP >= 0) 
) ENGINE=INNODB;

SELECT * FROM revision_practice.emp_records_2;

CREATE TABLE IF NOT EXISTS emp_records_3(
emp_id VARCHAR(4) NOT NULL,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100),
gender VARCHAR(1),
role VARCHAR(100),
dept VARCHAR(100),
manager_id VARCHAR(4),
exp INTEGER NOT NULL CHECK(EXP >= 0),
CONSTRAINT gender_check CHECK(gender IN ('M', 'F', 'O'))
) ENGINE=INNODB;

SELECT * FROM emp_records_3;

SHOW TABLES; -- List all the existing table in the database
DESCRIBE emp_records; -- To analyze the structure of table
DESCRIBE emp_records_2;
DESCRIBE emp_records_3;

/* Modifying Table Structure - ALTER STATEMENT */

SELECT * FROM emp_records;

ALTER TABLE emp_records
ADD role VARCHAR(100); -- Adding columns (single)

ALTER TABLE emp_records
ADD department VARCHAR(100),
ADD manager_id VARCHAR(4); -- Adding multiple columns

DESCRIBE emp_records;

ALTER TABLE emp_records
MODIFY gender VARCHAR(1) NOT NULL; -- Modify single column

ALTER TABLE emp_records
MODIFY department VARCHAR(100) NOT NULL,
MODIFY manager_id VARCHAR(4) NOT NULL; -- Modify multiple columns

ALTER TABLE emp_records
CHANGE COLUMN role job_role VARCHAR(100); -- Rename column

ALTER TABLE emp_records
CHANGE COLUMN emp_id emp_key VARCHAR(5),
CHANGE COLUMN manager_id manager_key VARCHAR(5); -- Rename multiple columns

ALTER TABLE emp_records
CHANGE COLUMN emp_key emp_id VARCHAR(5),
CHANGE COLUMN manager_key manager_id VARCHAR(5); -- reverting to original names

ALTER TABLE emp_records
DROP COLUMN job_role; -- Drop single column

ALTER TABLE emp_records
DROP COLUMN department, 
DROP COLUMN manager_id; -- Drop multiple column

ALTER TABLE emp_records
RENAME TO emp_data; -- Rename table name

SELECT * FROM emp_data;
DESCRIBE emp_data;

ALTER TABLE emp_data
ADD full_name VARCHAR(100)
GENERATED ALWAYS AS (CONCAT(first_name, ' ', last_name)); -- Generated Columns

TRUNCATE TABLE emp_data; -- To delete all records from table

SHOW TABLES;

DROP TABLE IF EXISTS engine; -- To drop single column

DROP TABLE IF EXISTS 
emp_records_2, 
emp_records_3; -- To drop multiple column

/* Inserting Data in Tables */

CREATE TABLE emp_info(
emp_id VARCHAR(4) NOT NULL,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100),
gender VARCHAR(1),
role VARCHAR(100),
dept VARCHAR(100),
manager_id VARCHAR(4),
CHECK(gender IN('M', 'F', 'O'))
)ENGINE = INNODB;

SHOW TABLES;
DESCRIBE emp_info;

INSERT INTO emp_info(
emp_id, first_name, last_name, gender, role, dept, manager_id)
VALUES
("E260", "Roy", "Collins", "M", "SENIOR DATA SCIENTIST", "RETAIL", "E583"),
("E620", "Katrina", "Allen", "F", "JUNIOR DATA SCIENTIST", "RETAIL", "E612"),
("E583", "Janet", "Hale", "F", "MANAGER", "RETAIL", "E002"),
("E612", "Tracy", "Norris", "F", "ASSISTANT MANAGER", "RETAIL", "E002"),
("E002", "Cynthia", "Brooks", "F", "PRESIDENT", "ALL", "E001");

SELECT * FROM emp_info;

-- -----------------------------
-- FILTERING DATA FROM TABLES --
-- -----------------------------
/*
Following are the most important SQL commands for filtering data from tables:
1. WHERE
2. SELECT DISTINCT
3. AND
4. OR
5. NOT
6. IN
7. NOT IN
8. BETWEEN
9. LIKE
10. LIMIT
11. IS NULL
*/

SELECT * FROM emp_info;

/* WHERE Clause */
-- Find all the details where role is manager --
SELECT * FROM emp_info
WHERE role = 'MANAGER';

/* DISTINCT Clause */ 
-- Find all the unique roles from emp_info table --
SELECT DISTINCT(role) AS unique_roles
FROM emp_info;

/* AND Operator */
-- Find out details of female employees working in retail department --
SELECT * FROM emp_info
WHERE gender = 'F'
AND dept = 'RETAIL';

/* OR Operator */
-- Find all the employees who are either Male or working in retail department --
SELECT * FROM emp_info
WHERE gender = 'M'
OR dept = 'RETAIL';

/* IN Operator */
-- Find the details of all junior and senior data scientist profiles --
SELECT * FROM emp_info
WHERE role 
IN ('JUNIOR DATA SCIENTIST', 'SENIOR DATA SCIENTIST');

/* NOT IN Operator */
-- Find the details of all except for junior and senior data scientist profiles --
SELECT * FROM emp_info
WHERE role 
NOT IN ('JUNIOR DATA SCIENTIST', 'SENIOR DATA SCIENTIST');

/* BETWEEN Operator */
-- Find employees having 7 to 14 years of experience --
TRUNCATE TABLE emp_info;
ALTER TABLE emp_info
ADD experience INTEGER;
INSERT INTO emp_info
VALUES
("E260", "Roy", "Collins", "M", "SENIOR DATA SCIENTIST", "RETAIL", "E583", 7),
("E620", "Katrina", "Allen", "F", "JUNIOR DATA SCIENTIST", "RETAIL", "E612", 2),
("E583", "Janet", "Hale", "F", "MANAGER", "RETAIL", "E002", 14),
("E612", "Tracy", "Norris", "F", "ASSISTANT MANAGER", "RETAIL", "E002", 13),
("E002", "Cynthia", "Brooks", "F", "PRESIDENT", "ALL", "E001", 17);
SELECT * FROM emp_info
WHERE experience
BETWEEN 7 AND 14;

/* LIKE Operator & WILDCARDS */
-- MySQL Supports 2 wildcards: 
-- 1. Percentage (%): It matches any string of zero or more characters
-- 2. Underscore (_): It matches any single character

INSERT INTO emp_info(
emp_id, first_name, last_name, gender, role, dept, manager_id, experience)
VALUES
("E052", "Dianna", "Wilson", "F", "SENIOR DATA SCIENTIST", "HEALTHCARE", "E083", 6),
("E505", "Chad", "Wilson", "M", "ASSOCIATE DATA SCIENTIST", "HEALTHCARE","E083", 5),
("E083", "Patrick", "Voltz", "M", "MANAGER", "HEALTHCARE", "E002", 15);

-- Find the employees whose first name begins with letter 'C'
SELECT * FROM emp_info
WHERE first_name
LIKE 'C%';

-- Find the employees whose last name ends with letter 'n'
SELECT * FROM emp_info
WHERE last_name
LIKE '%n';

-- Find the employees whose last name starts with letter 'w' and ends with letter 'n'
SELECT * FROM emp_info
WHERE last_name
LIKE 'W%%n';

SELECT * FROM emp_info
WHERE first_name
LIKE '__y';

SELECT * FROM emp_info
WHERE last_name
LIKE 'W%___on';

/* LIMIT Operator */
-- Find the details of the first three employees with the least experience from the employee table.
SELECT * FROM emp_info
ORDER BY experience ASC
LIMIT 3;

/* IS NULL Operator */
INSERT INTO emp_info(
emp_id, first_name, last_name, gender, role, dept, experience)
VALUES
("E001", "Arthur", "Black", "M", "CEO", "ALL", 10);

SELECT * FROM emp_info
WHERE manager_id IS NULL;

/* IS NOT NULL Operator */

SELECT * FROM emp_info
WHERE manager_id IS NOT NULL;

-- ----------------------
-- SORTING TABLE DATA --
-- ----------------------

/* ORDER BY Clause */
-- Provide details of all employees with their experience in a descending order.
SELECT * FROM emp_info
ORDER BY dept DESC;

-- ----------------------
-- GROUPING TABLE DATA --
-- ----------------------

/* GROUP BY Clause */
SELECT * FROM emp_info
GROUP BY dept;

SELECT gender, AVG(experience) AS avg_exp
FROM emp_info
GROUP BY gender;

/* HAVING Clause */
SELECT * FROM emp_info
GROUP BY dept
HAVING experience >= 5 
AND experience <= 10;

-- ---------
-- ROLLUP --
-- ---------
/*
The GROUP BY clause permits a WITH ROLLUP modifier that causes summary output to include extra rows that represent higher-level 
(that is, super-aggregate) summary operations. ROLLUP thus enables you to answer questions at multiple levels of analysis with a single query.

ROLLUP does not create all possible groupings based on the dimensions columns.
ROLLUP provides a shorthand for defining multiple grouping sets.alter

An extension of GROUP BY Clause
Multiple Sets generation
Extra rows represent subtotals
*/
CREATE TABLE sales(
year INTEGER,
country VARCHAR(10),
product VARCHAR(10),
profit INT
) ENGINE = InnoDB;

INSERT INTO sales (year, country, product, profit)
VALUES
(2019, 'Germany', 'Laptop', FLOOR(RAND() * 1000) + 500),
(2019, 'Germany', 'Desktop', FLOOR(RAND() * 1000) + 400),
(2019, 'Germany', 'Tablet', FLOOR(RAND() * 1000) + 300),
(2019, 'France', 'Laptop', FLOOR(RAND() * 1000) + 600),
(2019, 'France', 'Desktop', FLOOR(RAND() * 1000) + 450),
(2019, 'France', 'Tablet', FLOOR(RAND() * 1000) + 350),
(2019, 'Italy', 'Laptop', FLOOR(RAND() * 1000) + 550),
(2019, 'Italy', 'Desktop', FLOOR(RAND() * 1000) + 420),
(2019, 'Italy', 'Tablet', FLOOR(RAND() * 1000) + 320),
(2020, 'Germany', 'Laptop', FLOOR(RAND() * 1000) + 510),
(2020, 'Germany', 'Desktop', FLOOR(RAND() * 1000) + 410),
(2020, 'Germany', 'Tablet', FLOOR(RAND() * 1000) + 320),
(2020, 'France', 'Laptop', FLOOR(RAND() * 1000) + 620),
(2020, 'France', 'Desktop', FLOOR(RAND() * 1000) + 460),
(2020, 'France', 'Tablet', FLOOR(RAND() * 1000) + 370),
(2020, 'Italy', 'Laptop', FLOOR(RAND() * 1000) + 530),
(2020, 'Italy', 'Desktop', FLOOR(RAND() * 1000) + 430),
(2020, 'Italy', 'Tablet', FLOOR(RAND() * 1000) + 340),
(2021, 'Germany', 'Laptop', FLOOR(RAND() * 1000) + 520),
(2021, 'Germany', 'Desktop', FLOOR(RAND() * 1000) + 420),
(2021, 'Germany', 'Tablet', FLOOR(RAND() * 1000) + 330),
(2021, 'France', 'Laptop', FLOOR(RAND() * 1000) + 630),
(2021, 'France', 'Desktop', FLOOR(RAND() * 1000) + 470),
(2021, 'France', 'Tablet', FLOOR(RAND() * 1000) + 380),
(2021, 'Italy', 'Laptop', FLOOR(RAND() * 1000) + 540),
(2021, 'Italy', 'Desktop', FLOOR(RAND() * 1000) + 440),
(2021, 'Italy', 'Tablet', FLOOR(RAND() * 1000) + 350),
(2022, 'Germany', 'Laptop', FLOOR(RAND() * 1000) + 530),
(2022, 'Germany', 'Desktop', FLOOR(RAND() * 1000) + 430),
(2022, 'Germany', 'Tablet', FLOOR(RAND() * 1000) + 340),
(2022, 'France', 'Laptop', FLOOR(RAND() * 1000) + 640),
(2022, 'France', 'Desktop', FLOOR(RAND() * 1000) + 480),
(2022, 'France', 'Tablet', FLOOR(RAND() * 1000) + 390),
(2022, 'Italy', 'Laptop', FLOOR(RAND() * 1000) + 550),
(2022, 'Italy', 'Desktop', FLOOR(RAND() * 1000) + 450),
(2022, 'Italy', 'Tablet', FLOOR(RAND() * 1000) + 360),
(2023, 'Germany', 'Laptop', FLOOR(RAND() * 1000) + 540),
(2023, 'Germany', 'Desktop', FLOOR(RAND() * 1000) + 440),
(2023, 'Germany', 'Tablet', FLOOR(RAND() * 1000) + 350),
(2023, 'France', 'Laptop', FLOOR(RAND() * 1000) + 650),
(2023, 'France', 'Desktop', FLOOR(RAND() * 1000) + 490),
(2023, 'France', 'Tablet', FLOOR(RAND() * 1000) + 400),
(2023, 'Italy', 'Laptop', FLOOR(RAND() * 1000) + 560),
(2023, 'Italy', 'Desktop', FLOOR(RAND() * 1000) + 460),
(2023, 'Italy', 'Tablet', FLOOR(RAND() * 1000) + 370);

SELECT * FROM sales;

-- determine the total profit summed over all years
SELECT year, SUM(profit) AS profit
FROM sales
GROUP BY year WITH ROLLUP;

-- 1. Query to Calculate Total Profit by Year and Country
SELECT year, country, SUM(profit) AS total_profit
FROM sales
GROUP BY year, country WITH ROLLUP;

-- 2. Query to Calculate Total Profit by Year and Product
SELECT year, product, SUM(profit) AS total_profit
FROM sales
GROUP BY year, product WITH ROLLUP;

-- 3. Query to Calculate Total Profit by Country and Product
SELECT country, product, SUM(profit) AS total_profit
FROM sales
GROUP BY country, product WITH ROLLUP;

-- 4. Query to Calculate Grand Total Profit Across All Combinations
SELECT year, country, product, SUM(profit) AS profit
FROM sales
GROUP BY year, country, product WITH ROLLUP;

-- 5. Query to Filter and Calculate Subtotals
SELECT year, country, product, SUM(profit) AS profit
FROM sales
WHERE year IN (2020, 2021)
GROUP BY year, country, product WITH ROLLUP;

-- ----------------
-- GROUPING SETS --
-- ----------------
/*
GROUPING SETS is another SQL feature that allows you to specify multiple groupings within a single query, producing multiple levels of grouping and subtotals.
A grouping set is a set of columns by which you group using the GROUP BY clause. 
Normally, a single aggregate query defines a single grouping set. 
The GROUPING SETS option defines multiple grouping sets within the same query.

NOTE: In MySQL, you typically achieve similar functionality using UNION ALL to combine results from multiple GROUP BY queries or by using GROUP BY with ROLLUP 
for hierarchical aggregation.
*/

SELECT 
    year,
    country,
    SUM(profit) AS total_profit
FROM 
    sales
GROUP BY year, country
UNION ALL
SELECT 
    country,
    product,
    SUM(profit) AS total_profit
FROM 
    sales
GROUP BY country, product;

-- ---------------------------------------------------
-- WORKING WITH OPERATORS, CONSTRAINTS & DATA TYPES --
-- ---------------------------------------------------
/* SQL OPERATORS */
/*
An operator is a reserved word or character used with the WHERE clause of an SQL statement.
It specifies a condition in the SQL statement.
*/
/* ARITHMETIC OPERATORS */
/*
+ Addition, - Subtraction, * Multiplication, / Division, % Modulus
*/

CREATE TABLE emp_table(
emp_id INTEGER NOT NULL,
first_name VARCHAR(10),
last_name VARCHAR(10),
salary INTEGER NOT NULL,
bonus INTEGER NOT NULL,
PRIMARY KEY(emp_id)
) ENGINE = InnoDB;

SELECT * FROM emp_table;
DESCRIBE emp_table;

INSERT INTO emp_table(emp_id, first_name, last_name, salary, bonus)
VALUES
(1134, 'Mark', 'Jacobs', 20000, 1500),
(1256, 'John', 'Barter', 25000, 1000),
(1277, 'Michael', 'Scar', 22000, 1000),
(1300, 'Dan', 'Harris', 30000, 2000);

-- ADDITION --
SELECT emp_id, first_name, last_name, salary + bonus AS total_income
FROM emp_table;

SELECT *, salary + bonus AS total_income
FROM emp_table;

-- SUBTRACTION --
SELECT *, salary + bonus - (salary * 0.05) AS total_income
FROM emp_table;

-- MULTIPLICATION --
SELECT *, salary + (salary * 0.25) + bonus AS total_income
FROM emp_table;

-- DIVISION --
SELECT *, salary - (salary / 2) + bonus AS total_income
FROM emp_table;

/* BITWISE OPERATORS */
/*
& - AND
│ - OR
^ - Exclusive OR
*/
SELECT salary & bonus FROM emp_table;
SELECT salary | bonus FROM emp_table;
SELECT salary ^ bonus FROM emp_table;

/* COMPARISON OPERATORS */
/*
= ==> Equal to
> ==> Greater than
< ==> Less than
>= ==> Greater than or equal to
<= ==> Less than or equal to
<> ==> Not equal to
*/

-- Salary more than 25000 --
SELECT * FROM emp_table
WHERE salary > 25000;

SELECT * FROM emp_table
WHERE salary < 25000;

SELECT * FROM emp_table
WHERE salary >= 25000;

SELECT * FROM emp_table
WHERE bonus <= 1500;

SELECT * FROM emp_info
WHERE dept = 'HEALTHCARE';

SELECT * FROM emp_info
WHERE dept <> 'ALL';

/* COMPOUND OPERATORS */
/*
+= --> Add equals,
-= --> Subtract equals,
*= --> Multiply equals
/= --> Divide equals
%= --> Modulo equals
&= --> Bitwise AND equals
^-= --> Bitwise exclusive equals
|*= --> Bitwise exclusive OR equals
*/

/* LOGICAL OPERATORS */
/* AND, OR, BETWEEN, NOT, LIKE */

SELECT * FROM emp_info
WHERE gender = 'F'
AND experience >= 10;

SELECT * FROM emp_info
WHERE gender = 'F'
OR dept = 'RETAIL';

SELECT * FROM emp_info
WHERE experience
BETWEEN 10 AND 15;

SELECT * FROM emp_info
WHERE NOT dept = 'ALL';

SELECT * FROM emp_info
WHERE first_name 
LIKE 'C%';

-- --------------------
-- INDEXING in MySQL --
-- --------------------
/*
MySQL indexes sort data in a sequential and logical order.
Indexes are used to find rows with specific column values quickly.

There are two ways to create an INDEX:
- Before the table is created
- After the table is created
*/
-- extract employees who are manager from hr_data
SELECT emp_id, first_name, last_name
FROM hr_data
WHERE role = 'MANAGER';

-- If you want to check how MySQL performs the previous query internally, execute the following query:
EXPLAIN SELECT emp_id, first_name, last_name
FROM hr_data
WHERE role = 'MANAGER';

-- create an index for columns role and emp_id
ALTER TABLE revision_practice.hr_data
MODIFY role VARCHAR(100),
MODIFY emp_id VARCHAR(100),
MODIFY first_name VARCHAR(100),
MODIFY last_name VARCHAR(100),
MODIFY gender VARCHAR(10),
MODIFY dept VARCHAR(100),
MODIFY exp INTEGER,
MODIFY country  VARCHAR(100),
MODIFY continent VARCHAR(100),
MODIFY salary INTEGER,
MODIFY emp_rating INTEGER;


CREATE INDEX role_idx ON revision_practice.hr_data (role);
CREATE INDEX id_idx ON revision_practice.hr_data (emp_id);

EXPLAIN SELECT emp_id, first_name, last_name
FROM hr_data
WHERE role = 'MANAGER';

SHOW INDEXES FROM revision_practice.hr_data;

DROP INDEX id_idx ON revision_practice.hr_data;

-- ----------------------------
-- ORDER of EXECUTION in SQL --
-- ----------------------------
/*
 - FROM
 - JOIN
 - WHERE
 - GROUP BY
 - HAVING
 - SELECT
 - DISTINCT
 - ORDER BY
 - LIMIT
 - OFFSET
*/

-- --------------------
-- MySQL CONSTRAINTS --
-- --------------------
/*
Constraint is a condition that specifies the type of data that can be entered into a table
There are 2 types of constraints in MySQL:
	- Column Level restriction
    - Table Level restriction
*/
/* NOT NULL CONSTRAINT */
/* NOT NULL constraint prevents the column from having NULL or empty values */
CREATE TABLE constraint1(
id INTEGER,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
city VARCHAR(50)) ENGINE = InnoDB;
SELECT * FROM constraint1;
DESCRIBE constraint1;

/* PRIMARY CONSTRAINT */
/*
Primary constraint provides a distinct identity to each record in a table. 
A table can only have one primary key.
*/
CREATE TABLE constraint2(
id INTEGER PRIMARY KEY,
name VARCHAR(100) NOT NULL,
age INTEGER NOT NULL) ENGINE = InnoDB;
SELECT * FROM revision_practice.constraint2;
DESCRIBE revision_practice.constraint2;

CREATE TABLE product_details(
prod_id INTEGER PRIMARY KEY,
prod_name VARCHAR(100) NOT NULL,
order_date DATE) ENGINE = InnoDB;
SELECT * FROM revision_practice.product_details;
DESCRIBE revision_practice.product_details;
INSERT INTO revision_practice.product_details(prod_id, order_date)
VALUES
(001, "2024-06-25");

/* FOREIGN KEY */
/* Foreign key constraint is used to connect two tables. It corresponds to the primary key of a different table. */
/* 
You are the sales manager of a store. You have data of your customers and their orders in two different tables. 
You must ensure that the customer data added to the table on orders is not different from the original data.
Use a foreign key to specify the column that must contain only the data present in the primary table.
*/
CREATE TABLE customer_data(
cust_id INTEGER PRIMARY KEY,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
age INTEGER NOT NULL
) ENGINE = InnoDB;
SELECT * FROM revision_practice.customer_data;
DESCRIBE revision_practice.customer_data;

CREATE TABLE orders_data(
order_id INTEGER PRIMARY KEY,
order_num INTEGER NOT NULL,
cust_id INTEGER,
FOREIGN KEY (cust_id) REFERENCES revision_practice.customer_data(cust_id)
);
SELECT * FROM revision_practice.orders_data;
DESCRIBE revision_practice.orders_data;

INSERT INTO customer_data (cust_id, first_name, last_name, age)
VALUES
(1,'Mark', 'Bouncer',23),
(2,'Max','Hussey',34),
(3,'Harry','James',44);

INSERT INTO orders_data (order_id, order_num, cust_id)
VALUES
(1,7765,3),
(2,7734,3),
(3,7789,2);

INSERT INTO orders_data (order_id, order_num, cust_id)
VALUES
(4,7765,4),
(5,7734,5),
(6,7789,6);

/* UNIQUE CONSTRAINT */
/* Unique constraint ensures that there are no entries with the same value in a column. */
CREATE TABLE constraint3(
id INTEGER NOT NULL,
name VARCHAR(100),
age INTEGER,
UNIQUE(id)
) ENGINE = InnoDB;
SELECT * FROM revision_practice.constraint3;
DESCRIBE revision_practice.constraint3;

INSERT INTO constraint3 (ID, Name, Age) 
VALUES 
(1, 'George', 35),
(2, 'Lily', 28);

INSERT INTO constraint3 (ID, Name, Age) 
VALUES 
(2, 'George', 35),
(1, 'Lily', 28);

/* CHECK CONSTRAINT */
/* Check constraint can be used to verify the value being entered into a record. */
CREATE TABLE users(
id INTEGER PRIMARY KEY,
name VARCHAR(100) NOT NULL,
age INTEGER NOT NULL,
CHECK (age >= 18)
) ENGINE = InnoDB;
SELECT * FROM revision_practice.users;
DESCRIBE revision_practice.users;
INSERT INTO users (id, name, age)
VALUES
(1, 'Mark Jenson', 22);

INSERT INTO users (id, name, age)
VALUES
(2, 'Julia Cliff', 17);

-- -------------------
-- FUNCTIONS IN SQL --
-- -------------------
/*
SQL functions are basic subprograms used extensively to handle or manipulate data.
SQL functions enhance database speed and performance.
SQL functions are short programs with one or more input parameters but just one output value.

 - Advantages of SQL Functions
 Boost the database's efficiency and productivity
 Are compiled and cached
 Are complicated mathematical logic that can be broken down into simpler functions.
*/
USE ecommerce_management;
SELECT * FROM ecommerce_management.product;

UPDATE ecommerce_management.product
SET p_size = 'Small'
WHERE p_size = 'Samll';

/* AGGREGATE FUNCTIONS */
/*
The aggregate functions allow performing the calculation on a set of values to return a single scalar value.
*/
/* COUNT FUNCTION */
/* Count function returns the total number of rows in a specified column or a table. */
SELECT COUNT(product_id)
FROM ecommerce_management.product
WHERE cost > 400;

/* SUM FUNCTON */
/* Sum function returns the sum of values from a particular column. */
SELECT p_size, SUM(quantity) AS total
FROM ecommerce_management.product
GROUP BY p_size;

/* AVERAGE FUNCTION */
/* Average function returns the average value of a particular column. */
SELECT AVG(quantity) AS avg_purchase_quantity
FROM ecommerce_management.product
WHERE gender = 'Male';

SELECT p_size, AVG(cost) AS avg_cost
FROM ecommerce_management.product
GROUP BY p_size;

/* LIMIT FUNCTION */
SELECT * FROM ecommerce_management.product
ORDER BY cost ASC
LIMIT 1;

SELECT * FROM ecommerce_management.product
ORDER BY cost DESC
LIMIT 1;

/* MIN FUNCTION */
SELECT MIN(commission) AS min_commission
FROM ecommerce_management.product;

SELECT MIN(cost) AS min_cost
FROM ecommerce_management.product;

/* MAX FUNCTION */
SELECT MAX(commission) AS max_commission
FROM ecommerce_management.product;

SELECT MAX(cost) AS max_cost
FROM ecommerce_management.product;

/* SCALAR FUNCTIONS */

-- ROUND --
SELECT ROUND(2.372891,3);

-- LENGTH --
SELECT length(phone_number) AS Length_phone_number 
FROM ecommerce_management.customer;

-- FORMAT --
SELECT FORMAT(121.234,2);

-- MID --
SELECT MID(product_id,1,4) AS new_product_id, COUNT(quantity)
FROM ecommerce_management.product
GROUP BY new_product_id;

-- NOW --
SELECT NOW();

-- UPPERCASE --
SELECT UCASE(name) FROM 
ecommerce_management.customer;

-- LOWERCASE --
SELECT LCASE(address) FROM 
ecommerce_management.customer;

/* STRING FUNCTIONS */

-- CONCAT --
SELECT CONCAT(address,' ', 'zipcode', '-', pincode) AS address
FROM ecommerce_management.customer;

-- TRIM --
SELECT TRIM(' JESSICA ');

/* NUMERIC FUNCTIONS */

-- ABS --
SELECT ABS(-121.23);

-- CEIL --
SELECT CEIL(121.34);

-- FLOOR --
SELECT FLOOR(121.34);

-- TRUNCATE --
SELECT TRUNCATE(1345.32,1);

-- MOD --
SELECT MOD(8,3);

/* DATE & TIME FUNCTIONS */
-- DATE FUNCTION --
SELECT DATE('2024-06-25 01:02:03');

-- TIME FUNCTION --
SELECT TIME('2024-06-25 01:02:03');

-- EXTRACT --
SELECT EXTRACT(YEAR FROM '2024-06-25 01:02:03');
SELECT EXTRACT(MONTH FROM '2024-06-25 01:02:03');
SELECT EXTRACT(DAY FROM '2024-06-25 01:02:03');

-- DATE FORMAT --
SELECT DATE_FORMAT('2007-10-04 22:23:00', '%H:%i:%s');
SELECT DATE_FORMAT('2007-10-04 22:23:00', '%M %D %Y');

/* Handling Duplicate Records */
/* The duplicate records can be handled in two ways: 
 - Using DISTINCT and COUNT keywords to fetch the number of unique records
 - Using COUNT and GROUPBY keywords to eliminate duplicate records
*/
SELECT COUNT(DISTINCT(address)) AS unique_address
FROM ecommerce_management.customer;

SELECT ANY_VALUE(address), pincode, COUNT(*) AS num_records
FROM ecommerce_management.customer
GROUP BY pincode
HAVING num_records = 1;

/* Miscellaneous Functions */

-- CONVERT --
SELECT CONVERT('11:52:35',TIME);

-- IF --
SELECT IF(200<100,'YES','NO');

-- ISNULL --
SELECT ISNULL('1213');

-- IFNULL --
SELECT IFNULL('121','Happy life');

-- COALESCE --
SELECT COALESCE(NULL,'121','AAA',NULL);
