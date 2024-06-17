CREATE DATABASE simplilearn;
USE simplilearn;
SHOW DATABASES;
SHOW tables;

CREATE TABLE IF NOT EXISTS employee (
EMP_ID VARCHAR(50) NOT NULL,
FIRST_NAME VARCHAR(100) NOT NULL,
LAST_NAME VARCHAR(100),
GENDER VARCHAR(10),
ROLE VARCHAR(30),
DEPARTMENT VARCHAR(30),
MANAGER_ID VARCHAR(15),
CHECK (GENDER IN('M', 'F', 'O', 'Male', 'Female', 'Other')) 
) ENGINE = INNODB;

SELECT * FROM employee;
describe employee;

-- Changing the Storage Engine of the table --
-- ALTER TABLE employee ENGINE = MERGE;
-- ALTER TABLE employee ENGINE = InnoDB;

-- Changing the column name --
-- ALTER TABLE employee
-- CHANGE COLUMN JOB ROLE VARCHAR(30);  

-- Changing the Table Name --
ALTER TABLE employee
RENAME TO employee_data;

-- Generated Columns in MySQL --
ALTER TABLE employee_data
ADD FULL_NAME VARCHAR(100)
GENERATED ALWAYS AS (CONCAT(FIRST_NAME, ' ', LAST_NAME));

SELECT * FROM employee_data;
ALTER TABLE employee_data
DROP COLUMN FULL_NAME; 













  