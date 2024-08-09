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

-- ------------------------------------------------
-- Subqueries, Operators, and Derived Tables in SQL
-- ------------------------------------------------
CREATE DATABASE IF NOT EXISTS proj_db;
USE proj_db;
SET default_storage_engine = InnoDB;

CREATE TABLE IF NOT EXISTS emp_records(
emp_id  VARCHAR(4) NOT NULL PRIMARY KEY, 
first_name VARCHAR(100) NOT NULL, 
last_name VARCHAR(100) NOT NULL, 
gender VARCHAR(1) NOT NULL, 
role VARCHAR(100) NOT NULL, 
department VARCHAR(50) NOT NULL, 
experience INTEGER NOT NULL CHECK (experience >= 0), 
country VARCHAR(50) NOT NULL, 
continent VARCHAR(50) NOT NULL, 
salary INTEGER NOT NULL, 
rating INTEGER NOT NULL,
manager_id VARCHAR(4),
CONSTRAINT empid_check CHECK (SUBSTR(emp_id,1,1) = 'E'),
CONSTRAINT gender_check CHECK(gender in ('M', 'F', 'O'))
) ENGINE = InnoDB;

SELECT * FROM proj_db.emp_records;
DESCRIBE proj_db.emp_records;

INSERT INTO proj_db.emp_records(emp_id, first_name, last_name, gender, role, department, experience, country, continent, salary, rating, manager_id)
VALUES
('E260', 'Roy', 'Collins', 'M', 'SENIOR DATA SCIENTIST', 'RETAIL', 7, 'INDIA', 'ASIA', 7000, 3, 'E583'),
('E245', 'Nian', 'Zhen', 'M', 'SENIOR DATA SCIENTIST', 'RETAIL', 6, 'CHINA', 'ASIA', 6500, 2, 'E583'),
('E620', 'Katrina', 'Allen', 'F', 'JUNIOR DATA SCIENTIST', 'RETAIL', 2, 'INDIA', 'ASIA', 3000, 1, 'E612'),
('E640', 'Jenifer', 'Jhones', 'F', 'JUNIOR DATA SCIENTIST', 'RETAIL', 1, 'COLOMBIA', 'SOUTH AMERICA', 2800, 4, 'E612'),
('E403', 'Steve', 'Hoffman', 'M', 'ASSOCIATE DATA SCIENTIST', 'FINANCE', 4, 'USA', 'NORTH AMERICA', 5000, 3, 'E103'),
('E204', 'Karene', 'Nowak', 'F', 'SENIOR DATA SCIENTIST', 'AUTOMOTIVE', 8, 'GERMANY', 'EUROPE', 7500, 5, 'E428'),
('E057', 'Dorothy', 'Wilson', 'F', 'SENIOR DATA SCIENTIST', 'HEALTHCARE', 9, 'USA', 'NORTH AMERICA', 7700, 1, 'E083'),
('E010', 'William', 'Butler', 'M', 'LEAD DATA SCIENTIST', 'AUTOMOTIVE', 12, 'FRANCE', 'EUROPE', 9000, 2, 'E428'),
('E478', 'David', 'Smith', 'M', 'ASSOCIATE DATA SCIENTIST', 'RETAIL', 3, 'COLOMBIA', 'SOUTH AMERICA', 4000, 4, 'E583'),
('E005', 'Eric', 'Hoffman', 'M', 'LEAD DATA SCIENTIST', 'FINANCE', 11, 'USA', 'NORTH AMERICA', 8500, 3, 'E103'),
('E052', 'Dianna', 'Wilson', 'F', 'SENIOR DATA SCIENTIST', 'HEALTHCARE', 6, 'CANADA', 'NORTH AMERICA', 5500, 5, 'E083'),
('E505', 'Chad', 'Wilson', 'M', 'ASSOCIATE DATA SCIENTIST', 'HEALTHCARE', 5, 'CANADA', 'NORTH AMERICA', 5000, 2, 'E083'),
('E532', 'Claire', 'Brennan', 'F', 'ASSOCIATE DATA SCIENTIST', 'AUTOMOTIVE', 3, 'GERMANY', 'EUROPE', 4300, 1, 'E428'),
('E083', 'Patrick', 'Voltz', 'M', 'MANAGER', 'HEALTHCARE', 15, 'USA', 'NORTH AMERICA', 9500, 5, 'E001'),
('E583', 'Janet', 'Hale', 'F', 'MANAGER', 'RETAIL', 14, 'COLOMBIA', 'SOUTH AMERICA', 10000, 2, 'E001'),
('E103', 'Emily', 'Grove', 'F', 'MANAGER', 'FINANCE', 14, 'CANADA', 'NORTH AMERICA', 10500, 4, 'E001'),
('E612', 'Tracy', 'Norris', 'F', 'MANAGER', 'RETAIL', 13, 'INDIA', 'ASIA', 8500, 4, 'E001'),
('E428', 'Pete', 'Allen', 'M', 'MANAGER', 'AUTOMOTIVE', 14, 'GERMANY', 'EUROPE', 11000, 4, 'E001'),
('E001', 'Arthur', 'Black', 'M', 'PRESIDENT', 'ALL', 20, 'USA', 'NORTH AMERICA', 16500, 5, 'E001');

SELECT * FROM proj_db.emp_records;

CREATE TABLE IF NOT EXISTS proj_records(
proj_id VARCHAR(4) NOT NULL PRIMARY KEY,
proj_name VARCHAR(200) NOT NULL,
domain VARCHAR(100) NOT NULL,
start_date DATE NOT NULL,
closure_date DATE NOT NULL,
dev_qtr VARCHAR(2) NOT NULL,
status VARCHAR(7),
CONSTRAINT projid_check CHECK (SUBSTR(proj_id,1,1) = 'P'),
CONSTRAINT check_start_date CHECK (start_date >= '2021-04-01'),
CONSTRAINT check_closure_date CHECK (closure_date <= '2022-03-30'),
CONSTRAINT chk_qtr CHECK (dev_qtr IN ('Q1', 'Q2', 'Q3', 'Q4')),
CONSTRAINT chk_status CHECK (status IN ('YTS', 'WIP', 'DONE', 'DELAYED'))
) ENGINE = InnoDB;

SELECT * FROM proj_db.proj_records;
DESCRIBE proj_db.proj_records;

INSERT INTO proj_db.proj_records (proj_id, proj_name, domain, start_date, closure_date, dev_qtr, status)
VALUES
('P103', 'Drug Discovery', 'HEALTHCARE', '2021-04-06', '2021-06-20', 'Q1', 'DONE'),
('P105', 'Fraud Detection', 'FINANCE', '2021-04-11', '2021-06-25', 'Q1', 'DONE'),
('P208', 'Algorithmic Trading', 'FINANCE', '2022-01-16', '2022-03-27', 'Q4', 'YTS'),
('P109', 'Market Basket Analysis', 'RETAIL', '2021-04-12', '2021-06-30', 'Q1', 'DELAYED'),
('P204', 'Supply Chain Management', 'AUTOMOTIVE', '2021-07-15', '2021-09-28', 'Q2', 'WIP'),
('P406', 'Customer Sentiment Analysis', 'RETAIL', '2021-07-09', '2021-09-24', 'Q2', 'WIP'),
('P302', 'Early Detection of Lung Cancer', 'HEALTHCARE', '2021-10-08', '2021-12-18', 'Q3', 'YTS'),
('P201', 'Self Driving Cars', 'AUTOMOTIVE', '2022-01-12', '2022-03-30', 'Q4', 'YTS'),
('P501', 'Financial Chatbot', 'FINANCE', '2021-06-01', '2021-08-31', 'Q2', 'YTS'),
('P601', 'Identify Shelf Life', 'RETAIL', '2021-04-01', '2021-06-30', 'Q1', 'DELAYED'),
('P701', 'Driver Drowsiness Detection', 'AUTOMOTIVE', '2021-10-01', '2021-12-31', 'Q3', 'YTS'),
('P801', 'Health Insurance Fraud Detection', 'HEALTHCARE', '2022-01-01', '2022-03-29', 'Q4', 'DELAYED');

CREATE TABLE IF NOT EXISTS proj_assign(
emp_id VARCHAR(4) NOT NULL,
manager_id VARCHAR(4) NOT NULL,
proj_id VARCHAR(4) NOT NULL,
CONSTRAINT empid_check_2 CHECK (SUBSTR(emp_id,1,1) = 'E'),
CONSTRAINT projid_check_2 CHECK (SUBSTR(proj_id,1,1) = 'P'),
FOREIGN KEY(emp_id) REFERENCES proj_db.emp_records(emp_id),
FOREIGN KEY(proj_id) REFERENCES proj_db.proj_records(proj_id)
) ENGINE = InnoDB;

SELECT * FROM proj_db.proj_assign;
DESCRIBE proj_db.proj_assign;

INSERT INTO proj_db.proj_assign (emp_id, manager_id, proj_id)
VALUES
('E260', 'E583', 'P103'),
('E245', 'E583', 'P105'),
('E620', 'E612', 'P208'),
('E640', 'E612', 'P109'),
('E403', 'E103', 'P204'),
('E204', 'E428', 'P406'),
('E057', 'E083', 'P302'),
('E010', 'E428', 'P201'),
('E478', 'E583', 'P103'),
('E005', 'E103', 'P105'),
('E052', 'E083', 'P208'),
('E505', 'E083', 'P109'),
('E532', 'E428', 'P204'),
('E083', 'E001', 'P406'),
('E583', 'E001', 'P302'),
('E103', 'E001', 'P201'),
('E612', 'E001', 'P103'),
('E428', 'E001', 'P105'),
('E001', 'E001', 'P208');

-- Alias in SQL --
/*
An alias is a temporary name assigned to a table, column, or expression for the purpose of an SQL query, and it exists only for the duration of the query.
The AS keyword is used to make an alias.
If an alias contains space, it must be enclosed in quotation marks.
Aliases are typically used to make column names easier to comprehend.

Types of Alias:
Column alias: A column alias is a temporary name assigned to a column having a long or descriptive technical name in order to simplify the query output.
Note: A column alias cannot be used in the WHERE clause because the WHERE clause is evaluated before the values of columns specified in the SELECT 
statement during query execution in MySQL

Table alias: A table alias is a temporary name assigned to a table that has a descriptive technical name to simplify the query output.
Table aliases are preferred when there are multiple tables involved in an SQL query. It helps in collecting data and connecting the tables via field relations.
*/

SELECT CONCAT_WS(', ', last_name, first_name) 
AS full_name
FROM proj_db.emp_records;

SELECT e.first_name, e.last_name
FROM proj_db.emp_records AS e
WHERE e.department = 'HEALTHCARE';

-- ---------------------
-- Introduction to Joins
-- ---------------------
/*
Joins in MySQL:
A JOIN is a method of linking data between one (self-join) or more tables based on a related column between them.
Joins are frequently used in SELECT, UPDATE, and DELETE statements. It is also used in subqueries to join multiple tables.

Types of Joins:
INNER JOIN
LEFT (OUTER) JOIN
RIGHT (OUTER) JOIN
CROSS JOIN
*/

-- INNER JOIN --
/*
The INNER JOIN clause joins two tables based on a condition which is known as a join predicate.
It returns only the matching rows from both tables.
The column names are enclosed in the USING clause if the JOIN condition utilizes the equal operator (=) and the column names in both 
tables, used for matching, are the same.
*/
-- Problem: Your manager expects you to identify employees assigned to projects.--
SELECT er.emp_id, er.first_name, er.last_name, er.department, er.manager_id
FROM proj_db.emp_records AS er
INNER JOIN proj_db.proj_assign AS pa
ON er.emp_id = pa.emp_id
WHERE er.role NOT IN ("MANAGER", "PRESIDENT", "CEO")
ORDER BY er.manager_id;

SELECT er.emp_id, er.first_name, er.last_name, er.department, er.manager_id
FROM proj_db.emp_records AS er
INNER JOIN proj_db.proj_assign AS pa
USING (emp_id)
WHERE er.role NOT IN ("MANAGER", "PRESIDENT", "CEO")
ORDER BY er.manager_id;

-- LEFT JOIN --
/*
Similar to INNER JOIN clause, the LEFT JOIN clause also requires a join predicate to join two tables.
The LEFT JOIN keyword returns all records from the left table (table1), and the matching records 
from the right table (table 2). If there is no match on the right side, the outcome is 0 records.
The LEFT JOIN also supports the USING clause.
*/
-- Problem: Your manager wants the details of the ongoing projects along with the number of employees working on them. --
SELECT pr.proj_id, pr.proj_name, pr.domain, COUNT(DISTINCT pa.emp_id) AS emp_count, pr.dev_qtr, pr.status
FROM proj_db.proj_records AS pr
LEFT JOIN proj_db.proj_assign AS pa
ON pr.proj_id = pa.proj_id
WHERE pr.status IN ("DONE", "WIP")
GROUP BY pr.proj_name
ORDER BY pr.proj_id;

SET sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

SELECT pr.proj_id, pr.proj_name, pr.domain, COUNT(DISTINCT pa.emp_id) AS emp_count, pr.dev_qtr, pr.status
FROM proj_db.proj_records AS pr
LEFT JOIN proj_db.proj_assign AS pa
USING (proj_id)
WHERE pr.status IN ("DONE", "WIP")
GROUP BY pr.proj_name
ORDER BY pr.proj_id;

-- RIGHT JOIN --
/*
The RIGHT JOIN is just the opposite of the LEFT JOIN and requires a join predicate to join two tables.
The RIGHT JOIN keyword returns all records from the right table (table 1), and the matching 
records from the left table (table 2). The result is 0 records from the left side if there is no match.
The RIGHT JOIN also supports the USING clause.
*/
-- Problem: Your manager wants the details of each employee along with the number of projects assigned to them. --
SELECT er.emp_id, er.first_name, er.last_name, er.gender, er.role, er.department, er.manager_id,
COUNT(DISTINCT pa.proj_id) AS proj_count
FROM proj_db.proj_assign AS pa
RIGHT JOIN proj_db.emp_records AS er
ON pa.emp_id = er.emp_id
WHERE er.role NOT IN ("MANAGER", "PRESIDENT", "CEO")
GROUP BY er.emp_id
ORDER BY er.manager_id;

SELECT er.emp_id, er.first_name, er.last_name, er.gender, er.role, er.department, er.manager_id,
COUNT(DISTINCT pa.proj_id) AS proj_count
FROM proj_db.proj_assign AS pa
RIGHT JOIN proj_db.emp_records AS er
USING (emp_id)
WHERE er.role NOT IN ("MANAGER", "PRESIDENT", "CEO")
GROUP BY er.emp_id
ORDER BY er.manager_id;

-- CROSS JOIN --
/*
Unlike the INNER JOIN, LEFT JOIN, and RIGHT JOIN clauses, the CROSS JOIN clause lacks a join condition.
The CROSS JOIN creates a Cartesian product of the rows in the joined tables.
To create the result set, the CROSS JOIN combines every row from the left table with every row from the right table.
*/
-- Problem: Perform the cartesian product of the rows in both the employee and project records tables. --
SELECT 
	er.emp_id, er.first_name, er.last_name, er.department, er.manager_id, pa.proj_id
FROM
	proj_db.emp_records AS er
CROSS JOIN
	proj_db.proj_assign AS pa
WHERE
	er.role NOT IN ("MANAGER", "PRESIDENT", "CEO")
ORDER BY
	er.first_name;
    
-- SELF JOIN --
/*
The SELF JOIN clause joins a table to itself using the INNER JOIN or LEFT JOIN.
The SELF JOIN is often used to query hierarchical data or to compare rows within the same table.
To perform a SELF JOIN, table aliases must be used to avoid repeating the same table name in a single query.
MySQL throws an error if a table is referenced twice or more in a query without utilizing table aliases.
*/
-- Problem: identify the number of employees reporting to each manager including the President and the CEO. --
SELECT
	a.emp_id, a.first_name, a.last_name, a.role, a.experience, a.department, COUNT(b.emp_id) AS emp_count
FROM
	proj_db.emp_records AS a
INNER JOIN
	proj_db.emp_records AS b
	ON a.emp_id = b.emp_id
    AND b.emp_id != b.manager_id
WHERE 
	a.role IN ("MANAGER", "PRESIDENT", "CEO")
GROUP BY
	a.emp_id
ORDER BY
	a.emp_id;
    
SELECT
	a.emp_id, a.first_name, a.last_name, a.role, a.experience, a.department, COUNT(b.emp_id) AS emp_count
FROM
	proj_db.emp_records AS a
LEFT JOIN
	proj_db.emp_records AS b
	ON a.emp_id = b.emp_id
    AND b.emp_id != b.manager_id
WHERE 
	a.role IN ("MANAGER", "PRESIDENT", "CEO")
GROUP BY
	a.emp_id
ORDER BY
	a.emp_id;

-- ----------------
-- SET OPERATORS --
-- ----------------
/*
Set operators combine the results of two component queries into a single result.
Set operators are used to get meaningful results from data stored in the table under different special conditions.
*/

-- UNION OPERATOR --
/*
The UNION operator is used to combine two or more result sets from multiple SELECT statements into a single result set.
By default, the UNION operator eliminates duplicate rows even if the DISTINCT operator is not explicitly provided.

In all SELECT statements, the number of columns and their order must be the same.
The data type of columns must be compatible or same.
*/
-- Problem: provide the full names and departments of the employees along with the name and domain of projects as name and department from 
-- both the employee and project records tables.
SELECT
	er.emp_id, CONCAT(er.first_name, " ", er.last_name) AS full_name, er.department
FROM
	proj_db.emp_records AS er
WHERE 
	er.role IN ("MANAGER")
UNION
SELECT 
	pr.proj_id, pr.proj_name, pr.domain
FROM
	proj_db.proj_records AS pr
ORDER BY
	department, emp_id;

-- UNION ALL --
/*
The UNION operator can be substituted by the UNION ALL operator to maintain the duplicate rows in the result set.
The UNION ALL operator performs the same functions as the UNION operator, but it is significantly faster since it does not have to deal with duplicate rows.
*/
SELECT
	er.emp_id, CONCAT(er.first_name, " ", er.last_name) AS full_name, er.department
FROM
	proj_db.emp_records AS er
WHERE 
	er.role IN ("MANAGER")
UNION ALL
SELECT 
	pr.proj_id, pr.proj_name, pr.domain
FROM
	proj_db.proj_records AS pr
ORDER BY
	department, emp_id;
    
-- INTERSECT --
/*
The INTERSECT operator compares the result sets of two or more queries and returns only the distinct rows produced by both queries.
Unlike the UNION operator, the INTERSECT operator returns the intersection between two circles.

The INTERSECT operator is not supported by MySQL; however, it can be emulated.
The INTERSECT operator in MySQL can be emulated in two ways:
	1. Using DISTINCT and INNER JOIN clause
	2. Using IN and Subquery
*/
-- list the employee IDs of all the managers who are involved with at least one project. --
SELECT
	DISTINCT er.emp_id
FROM
	proj_db.emp_records AS er
INNER JOIN
	proj_db.proj_assign AS pa
USING(emp_id)
WHERE
	er.role IN ("MANAGER")
ORDER BY
	er.emp_id;
    
SELECT
	DISTINCT er.emp_id
FROM
	proj_db.emp_records AS er
WHERE
	er.emp_id IN (
    SELECT 
		pa.emp_id
    FROM
		proj_db.proj_assign AS pa)
	AND
		er.role IN ("MANAGER")
ORDER BY
	er.emp_id;
    
-- MINUS OPERATOR --
/* 
The MINUS operator compares the results of two queries. It returns distinct rows from the result set of the first query that does not appear in the result set of the 
second query.

The MINUS operator is not supported by MySQL; however, it can be emulated using the JOIN clause.
*/
-- project IDs of the projects that are not yet assigned to any manager or employee. --
SELECT
	pr.proj_id
FROM proj_db.proj_records AS pr
LEFT JOIN
	proj_db.proj_assign AS pa
USING(proj_id)
WHERE
	pa.proj_id IS NULL;

-- SUBQUERY in SQL --
/*
A subquery is a query nested within another query such as SELECT, INSERT, UPDATE, or DELETE.
It is also called an Inner Query or Inner Select while the statement that contains the subquery is called an outer query or outer select.
It can be used anywhere an expression is used and must be closed in parentheses.
A subquery can also be nested within another subquery
*/
-- Subquery as Expressions --
/* A subquery that returns a single value can be used as an expression. */
-- Suppose you need to determine the count of managers and the total team strength excluding them in the retail domain in MySQL --
SELECT
	m.department, COUNT(DISTINCT m.emp_id) AS manager_count,
		(SELECT COUNT(DISTINCT e.emp_id)
		FROM proj_db.emp_records AS e
		WHERE e.role NOT IN ("MANAGER", "PRESIDENT", "CEO")
        AND e.department IN ("RETAIL")) AS team_strength
FROM proj_db.emp_records AS m
WHERE m.role IN ("MANAGER")
AND m.department IN ("RETAIL");

-- Subquery with WHERE Clause --
-- Suppose you need to determine the list of upcoming projects with no manager and team member assigned to them in MySQL --
SELECT
	pr.proj_id, pr.proj_name, pr.domain, pr.status
FROM 
	proj_db.proj_records AS pr
WHERE 
	pr.proj_id NOT IN
		(SELECT DISTINCT pa.proj_id
		FROM proj_db.proj_assign AS pa)
AND
	pr.status IN ("YTS");
    
-- Subquery with Comparison Operators --
-- Suppose you need to determine the employee with the highest experience in the organization in MySQL. --
SELECT
	er.emp_id, CONCAT(er.first_name, ' ', er.last_name) AS full_name, er.role, er.department
FROM 
	proj_db.emp_records AS er
WHERE
	er.experience = (SELECT MAX(experience) FROM proj_db.emp_records);
    
-- Subquery With IN and NOT IN Operators --
-- Suppose you need to determine the list of all managers who have not been assigned to any projects in the organization in MySQL. --
SELECT
	er.emp_id, er.first_name, er.last_name, er.role, er.department
FROM
	proj_db.emp_records AS er
WHERE 
	er.emp_id NOT IN
		(SELECT DISTINCT pa.emp_id FROM proj_db.proj_assign AS pa)
AND
	er.role IN ("MANAGER");

-- Subquery With ANY Operator --
-- Suppose you need to determine any five employees with more than or equal to the average experience of all employees in the organization in MySQL. --
SELECT
	er.emp_id, CONCAT(er.first_name, ' ', er.last_name) AS full_name, er.role, er.department, er.experience
FROM 
	proj_db.emp_records AS er
WHERE
	er.experience >= ANY (SELECT AVG(experience) FROM proj_db.emp_records)
LIMIT 5;

-- Subquery With ALL Operator --
-- Suppose you need to determine all the employees with less than the average experience of all employees in MySQL. --
SELECT
	er.emp_id, CONCAT(er.first_name, ' ', er.last_name) AS full_name, er.role, er.department, er.experience
FROM 
	proj_db.emp_records AS er
WHERE
	er.experience <= ALL (SELECT AVG(experience) FROM proj_db.emp_records);

-- Subquery With EXISTS or NOT EXISTS Operators --
-- Suppose you need to print the names of all the projects only if even one project is assigned to any employee in MySQL. --
SELECT 
	proj_name
FROM 
	proj_db.proj_records
WHERE 
	EXISTS (
		SELECT proj_id FROM proj_db.proj_assign)
	ORDER BY proj_id;

-- Subquery in the FROM Clause --
-- Suppose you need to determine the maximum, minimum, and average employee experience in the organization in MySQL. --
SELECT
	MAX(experience) AS max_exp, MIN(experience) AS min_exp, FLOOR(AVG(experience)) AS avg_exp
FROM 
	(SELECT emp_id, experience FROM proj_db.emp_records
	GROUP BY experience ORDER BY experience) AS total_exp;

-- Subquery With SELECT Statement --
-- Suppose you need to determine all those projects that are assigned to at least one of the employees in MySQL --
SELECT
	proj_id, proj_name, domain, status
FROM
	proj_db.proj_records
WHERE
	proj_id IN (
		SELECT DISTINCT proj_id FROM proj_db.proj_assign)
ORDER BY proj_id, domain;

-- Subquery With INSERT Statement --
-- Suppose you need to back up the data of all those projects which have no employee assigned into the new PROJ_RECORDS_BKUP table in MySQL. --
-- First we will create a backup table to store our results --
CREATE TABLE IF NOT EXISTS proj_db.proj_records_bkup (
	PROJ_ID VARCHAR(4) NOT NULL CHECK (SUBSTR(PROJ_ID,1,1) = 'P'),
	PROJ_NAME VARCHAR(200) NOT NULL,
	DOMAIN VARCHAR(100) NOT NULL,
	START_DATE DATE NOT NULL CHECK (START_DATE >= '2021-04-01'),
	CLOSURE_DATE DATE NOT NULL CHECK (CLOSURE_DATE <= '2022-03-30'),
	DEV_QTR VARCHAR(2) NOT NULL,
	STATUS VARCHAR(7),
	CONSTRAINT chk_qtr_2 CHECK (DEV_QTR IN ('Q1', 'Q2', 'Q3', 'Q4')),
	CONSTRAINT chk_status_2 CHECK (STATUS IN ('YTS', 'WIP', 'DONE', 'DELAYED'))
) ENGINE=INNODB;

DESCRIBE proj_db.proj_records_bkup;

INSERT INTO proj_db.proj_records_bkup
SELECT * FROM proj_db.proj_records AS pr
WHERE pr.proj_id NOT IN (
	SELECT DISTINCT pa.proj_id FROM proj_db.proj_assign AS pa);

SELECT * FROM proj_db.proj_records_bkup;

-- Subquery With UPDATE Statement --
-- Suppose you need to change the development quarter along with its start and closure dates for one of the projects in the PROJ_RECORDS_BKUP table in MySQL. --
UPDATE proj_db.proj_records_bkup
	SET DEV_QTR = "Q1"
WHERE
	START_DATE = (
		SELECT start_date FROM proj_db.proj_records WHERE proj_id = "P103")
	AND CLOSURE_DATE = (
		SELECT closure_date FROM proj_db.proj_records WHERE proj_id = "P103");

-- Subquery With DELETE Statement --
-- Let us say you need to remove a project from the PROJ_RECORDS_BKUP table that has the status YTS in the PROJ_RECORDS table in MySQL. --

DELETE FROM proj_db.proj_records_bkup
WHERE proj_id IN (
	SELECT pr.proj_id FROM proj_db.proj_records AS pr
    WHERE pr.status = "YTS"
    GROUP BY pr.status);

SELECT * FROM proj_db.proj_records_bkup;

-- -------------- --
-- Derived Tables --
-- -------------- --
/*
A derived table is a virtual table returned by a SELECT statement.
A derived table is created by using a stand-alone subquery in the FROM clause of a SELECT statement.
It is mandatory for a derived table to have an alias so that it can be referenced in the query.
MySQL raises an error in the absence of an alias for a derived table.
*/

-- Your manager wants you to find the total number of managers in the organization. --
SELECT
	COUNT(DISTINCT emp_id) AS manager_count
FROM
	(SELECT DISTINCT emp_id FROM proj_db.emp_records
    WHERE role IN ("MANAGER")) AS employees
WHERE
	emp_id = employees.emp_id;




