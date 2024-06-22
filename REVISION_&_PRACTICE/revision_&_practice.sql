---------------------------
-- DATABASE MANIPULATION --
--------------------------- 

CREATE DATABASE IF NOT EXISTS revision_practice;
USE revision_practice;
SHOW DATABASES;
SELECT DATABASE(); -- Displays Current Database Selected
CREATE DATABASE deletethis;
DROP DATABASE IF EXISTS deletethis;

---------------------
-- STORAGE ENGINES --
---------------------
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

--------------------------------
-- CREATING & MANAGING TABLES --
--------------------------------

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

--------------------------------
-- FILTERING DATA FROM TABLES --
--------------------------------

