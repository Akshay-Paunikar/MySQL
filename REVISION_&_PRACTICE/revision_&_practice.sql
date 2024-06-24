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

