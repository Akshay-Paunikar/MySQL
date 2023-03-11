USE simplilearn;
SELECT * FROM employee_data;

/* INSERTING DATA into TABLES */

INSERT INTO employee_data
VALUES
("E260", "Roy", "Collins", "M", "SENIOR DATA SCIENTIST", "RETAIL", "E583"),
("E620", "Katrina", "Allen", "F", "JUNIOR DATA SCIENTIST", "RETAIL", "E612"),
("E583", "Janet", "Hale", "F", "MANAGER", "RETAIL", "E002"),
("E612", "Tracy", "Norris", "F", "MANAGER", "RETAIL", "E002"),
("E002", "Cynthia", "Brooks", "F", "PRESIDENT", "ALL", "E001");

SELECT * FROM employee_data;

/* Filtering Data From Tables in MySQL
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

-- WHERE --
-- Find all the details related to ROLE - 'MANAGER'
SELECT * FROM employee_data
WHERE ROLE = "MANAGER";

SELECT * FROM employee_data
WHERE GENDER = 'M';

SELECT * FROM employee_data
WHERE DEPARTMENT = 'ALL';

-- DISTINCT --
-- Find distinct Job roles in the organization.
SELECT DISTINCT(ROLE) AS JOB_ROLES
FROM employee_data;

-- AND Operator --
-- Find details of manager in retail department.
SELECT * FROM employee_data
WHERE ROLE = 'MANAGER'
AND DEPARTMENT = 'RETAIL';

-- OR Operator --
-- Find Name of employees with Role = 'MANAGER' OR Role = 'JUNIOR DATA SCIENTIST'
SELECT FIRST_NAME, LAST_NAME, ROLE
FROM employee_data
WHERE ROLE = 'MANAGER'
OR ROLE = 'JUNIOR DATA SCIENTIST';

-- IN Operator --
-- Find details where role in ('JUNIOR DATA SCIENTIST', 'SENIOR DATA SCIENTIST')
SELECT * FROM employee_data
WHERE 
ROLE IN ('JUNIOR DATA SCIENTIST', 'SENIOR DATA SCIENTIST');

-- NOT IN Operator --
-- Find details without President and Manager.
SELECT * FROM employee_data
WHERE
ROLE NOT IN ('MANAGER', 'PRESIDENT');

-- BETWEEN Operator --
TRUNCATE TABLE employee_data;
SELECT * FROM employee_data;

ALTER TABLE employee_data
ADD EXPERIENCE INT;

INSERT INTO employee_data
VALUES
("E260", "Roy", "Collins", "M", "SENIOR DATA SCIENTIST", "RETAIL", "E583", 7),
("E620", "Katrina", "Allen", "F", "JUNIOR DATA SCIENTIST", "RETAIL", "E612", 2),
("E583", "Janet", "Hale", "F", "MANAGER", "RETAIL", "E002", 14),
("E612", "Tracy", "Norris", "F", "MANAGER", "RETAIL", "E002", 13),
("E002", "Cynthia", "Brooks", "F", "PRESIDENT", "ALL", "E001", 17);

SELECT * FROM employee_data;

-- Find employees with experience between 10 to 15 years.
SELECT * FROM employee_data
WHERE EXPERIENCE 
BETWEEN 10 AND 15;

-- LIKE Operators and Wildcards --
-- INSERT INTO employee_data
-- VALUES
-- ("E052", "Dianna", "Wilson", "F", "SENIOR DATA SCIENTIST", "HEALTHCARE", "E083", 6),
-- ("E505", "Chad", "Wilson", "M", "ASSOCIATE DATA SCIENTIST", "HEALTHCARE","E083", 5),
-- ("E083", "Patrick", "Voltz", "M", "MANAGER", "HEALTHCARE", "E002", 15);

-- Find employees with last name starting with W.
SELECT * FROM employee_data
WHERE
LAST_NAME LIKE 'W%';

SELECT * FROM employee_data
WHERE
LAST_NAME LIKE '%s';

SELECT * FROM employee_data
WHERE
FIRST_NAME LIKE 'Ro_';

-- LIMIT Operator --
-- First 3 employees with least experience.
SELECT * FROM employee_data
ORDER BY EXPERIENCE
LIMIT 3;

-- IS NULL Operator --
-- INSERT INTO employee_data
-- VALUES
-- ("E001", "Arthur", "Black", "M", "CEO", "ALL", null, 22),
-- ("E009", "Alfred", "Pennyworth", "F", "PRODUCT LEAD", "ALL", null, 18);

-- Find employees with no manager.
SELECT * FROM employee_data
WHERE
MANAGER_ID IS NULL;

-- IS NOT NULL Operator --
-- Find employees having a manager.
SELECT * FROM employee_data
WHERE
MANAGER_ID IS NOT NULL;

-- ORDER BY --
-- Order employees by descending order of experience.
SELECT * FROM employee_data
ORDER BY EXPERIENCE DESC;

-- GROUP BY --
-- What is the average experience according to department
SELECT DEPARTMENT, ROUND(AVG(EXPERIENCE),2) AS avg_exp
FROM employee_data
GROUP BY DEPARTMENT;

-- HAVING --
-- details of one employee from each department having five to ten years of experience.

SELECT * FROM employee_data
GROUP BY DEPARTMENT
HAVING EXPERIENCE >= 5 AND EXPERIENCE <= 10;














   













