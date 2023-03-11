USE simplilearn;
SELECT * FROM emp_records;
SELECT * FROM proj_data;
SELECT * FROM proj_assign;

-- Alias in SQL --
-- Your manager expects you to identify the last and first names of all the employees from the healthcare department.

SELECT CONCAT_WS(', ', LAST_NAME, FIRST_NAME) AS FULL_NAME, DEPARTMENT
FROM emp_records
WHERE DEPARTMENT = 'HEALTHCARE';

-- Your manager expects you to identify the first and last names of all the employees separately 
-- from the healthcare department.

SELECT e.FIRST_NAME, e.LAST_NAME, e.DEPARTMENT
FROM emp_records AS e
WHERE e.DEPARTMENT = 'HEALTHCARE';

/* INTRODUCTION TO JOINS */
/* INNER JOIN:
	It returns only the matching rows from both tables. */
-- Your manager expects you to identify employees assigned to projects using ON and USING Keyword.
SELECT e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, e.DEPARTMENT, e.MANAGER_ID, p.PROJ_ID
FROM emp_records AS e
INNER JOIN proj_assign AS p
ON e.EMP_ID = p.EMP_ID
WHERE e.ROLE NOT IN ('MANAGER', 'PRESIDENT', 'CEO')
ORDER BY e.MANAGER_ID;

SELECT e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, e.DEPARTMENT, e.MANAGER_ID, p.PROJ_ID
FROM emp_records AS e
INNER JOIN proj_assign AS p
USING (EMP_ID)
WHERE e.ROLE NOT IN ('MANAGER', 'PRESIDENT', 'CEO')
ORDER BY e.MANAGER_ID;

/* LEFT JOIN:
	It returns all records from the LEFT table and matching records from RIGHT table.*/
-- Your manager wants the details of the ongoing projects along with the 
-- number of employees working on them.

SELECT p.PROJ_ID, p.PROJ_NAME, p.DOMAIN,
COUNT(DISTINCT(a.EMP_ID)) AS EMP_COUNT,
p.DEV_QTR, p.STATUS
FROM proj_data AS p
LEFT JOIN proj_assign AS a
ON p.PROJ_ID = a.PROJ_ID
WHERE p.STATUS IN ("DONE", "WIP")
GROUP BY p.PROJ_NAME
ORDER BY p.PROJ_ID;

SELECT p.PROJ_ID, p.PROJ_NAME, p.DOMAIN,
COUNT(DISTINCT(a.EMP_ID)) AS EMP_COUNT,
p.DEV_QTR, p.STATUS
FROM proj_data AS p
LEFT JOIN proj_assign AS a
USING(PROJ_ID)
WHERE p.STATUS IN ("DONE", "WIP")
GROUP BY p.PROJ_NAME
ORDER BY p.PROJ_ID;

/* RIGHT JOIN:
	It returns all records from RIGHT table and matching records from LEFT table.*/
-- Your manager wants the details of each employee along with the number of projects assigned to them.
SELECT e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, e.ROLE, e.DEPARTMENT, e.MANAGER_ID,
COUNT(DISTINCT(a.PROJ_ID)) AS PROJ_COUNT
FROM proj_assign AS a
RIGHT JOIN emp_records AS e
ON a.EMP_ID = e.EMP_ID
WHERE e.ROLE NOT IN ('MANAGER', 'PRESIDENT', 'CEO')
GROUP BY e.EMP_ID
ORDER BY e.MANAGER_ID;

SELECT e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, e.ROLE, e.DEPARTMENT, e.MANAGER_ID,
COUNT(DISTINCT(a.PROJ_ID)) AS PROJ_COUNT
FROM proj_assign AS a
RIGHT JOIN emp_records AS e
USING(EMP_ID)
WHERE e.ROLE NOT IN ('MANAGER', 'PRESIDENT', 'CEO')
GROUP BY e.EMP_ID
ORDER BY e.MANAGER_ID;

/* CROSS JOIN:
	The CROSS JOIN creates a cartesian product of the rows in the joined tables.*/
-- Your manager expects you to perform the cartesian product of the 
-- rows in both the employee and project records tables.
SELECT e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, e.DEPARTMENT, e.MANAGER_ID,
a.PROJ_ID
FROM proj_assign AS a
CROSS JOIN emp_records AS e
WHERE e.ROLE NOT IN ('MANAGER', 'PRESIDENT', 'CEO')
ORDER BY e.FIRST_NAME;

/* SELF JOIN:
	The SELF JOIN clause joins a table to itself using the INNER JOIN or LEFT JOIN.
    The SELF JOIN is often used to query hierarchical data or to compare rows within the same table.
    To perform a SELF JOIN, table aliases must be used to avoid repeating the same table name in a single query.
    MySQL throws an error if a table is referenced twice or more in a query without utilizing table aliases.
*/
-- Your manager wants you to identify the number of employees reporting to each manager including 
-- the President and the CEO.

SELECT m.EMP_ID, m.FIRST_NAME, m.LAST_NAME, m.ROLE, m.EXPERIENCE, m.DEPARTMENT,
COUNT(e.EMP_ID) AS EMP_COUNT
FROM emp_records AS m
INNER JOIN emp_records AS e
ON m.EMP_ID = e.MANAGER_ID
AND e.EMP_ID != e.MANAGER_ID
WHERE m.ROLE IN ('MANAGER', 'PRESIDENT', 'CEO')
GROUP BY m.EMP_ID
ORDER BY m.EMP_ID;

SELECT m.EMP_ID, m.FIRST_NAME, m.LAST_NAME, m.ROLE, m.EXPERIENCE, m.DEPARTMENT,
COUNT(e.EMP_ID) AS EMP_COUNT
FROM emp_records AS m
LEFT JOIN emp_records AS e
ON m.EMP_ID = e.MANAGER_ID
AND e.EMP_ID != e.MANAGER_ID
WHERE m.ROLE IN ('MANAGER', 'PRESIDENT', 'CEO')
GROUP BY m.EMP_ID
ORDER BY m.EMP_ID;

/* SET OPERATOR */
-- UNION OPERATOR:
	-- The UNION operator is used to combine two or more result sets from multiple SELECT 
	-- statements into a single result set.
    -- By default, the UNION operator eliminates duplicate rows even if the DISTINCT operator is 
	-- not explicitly provided.
	-- In all SELECT statements, the number of columns and their order must be the same.
    -- The data type of columns must be compatible or same.

-- Your manager wants you to provide the full names and departments of the employees along with the name and domain 
-- of projects as name and department from both the employee and project records tables.

SELECT e.EMP_ID, CONCAT_WS(' ', e.FIRST_NAME, e.LAST_NAME) AS FULL_NAME, e.DEPARTMENT
FROM emp_records AS e
WHERE e.ROLE IN ('MANAGER')
UNION
SELECT p.PROJ_ID, p.PROJ_NAME, p.DOMAIN
FROM proj_data AS p
ORDER BY DEPARTMENT, EMP_ID;

-- UNION ALL --
	-- The UNION operator can be substituted by the UNION ALL operator to maintain the duplicate 
	-- rows in the result set.
    -- The UNION ALL operator performs the same functions as the UNION operator, but it is significantly faster since 
    -- it does not have to deal with duplicate rows.

-- Your manager wants you to provide all the available entries with the full names of all employees and projects along 
-- with their department or domain as their domain in both the employee and project records tables together.

SELECT e.EMP_ID, CONCAT_WS(' ', e.FIRST_NAME, e.LAST_NAME) AS FULL_NAME, e.DEPARTMENT
FROM emp_records AS e
WHERE e.ROLE IN ('MANAGER')
UNION ALL
SELECT p.PROJ_ID, p.PROJ_NAME, p.DOMAIN
FROM proj_data AS p
ORDER BY DEPARTMENT, EMP_ID;

-- INTERSECT OPERATOR --
	-- The INTERSECT operator compares the result sets of two or more queries and returns only the distinct rows 
    -- produced by both queries.
    -- Unlike the UNION operator, the INTERSECT operator returns the intersection between two circles.
	-- The number of columns and their order in the SELECT statement of all the SQL queries must be the same.
    -- The data types of the corresponding columns must be compatible or same.
-- The INTERSECT operator in MySQL can be emulated in two ways:
	-- 1. Using DISTINCT and INNER JOIN clause
	-- 2. Using IN and Subquery
-- INTERSECT Using DISTINCT and INNER JOIN --
-- Your manager wants you to list the employee IDs of all the managers who are involved with at least one project.

SELECT DISTINCT e.EMP_ID
FROM emp_records AS e
INNER JOIN proj_assign AS a
USING(EMP_ID)
WHERE e.ROLE IN ('MANAGER')
ORDER BY e.EMP_ID;

-- INTERSECT Using IN and Subquery --

SELECT DISTINCT e.EMP_ID
FROM emp_records AS e
WHERE e.EMP_ID IN (SELECT a.EMP_ID
				   FROM proj_assign AS a)
AND e.ROLE IN ('MANAGER')
ORDER BY e.EMP_ID;

-- MINUS OPERATOR --
	-- The MINUS operator compares the results of two queries. It returns distinct rows from the result set of the first 
    -- query that does not appear in the result set of the second query.
	-- The number of columns and their order in the SELECT statement of all the SQL queries must be the same.
    -- The data types of the corresponding columns must be compatible or same.
-- The MINUS operator is not supported by MySQL; however, it can be emulated using the JOIN clause.
-- MINUS Using LEFT JOIN --
-- Your manager wants you to list the project IDs of the projects that are not yet assigned to any manager or employee

SELECT p.PROJ_ID
FROM proj_data AS p
LEFT JOIN proj_assign AS a
USING (PROJ_ID)
WHERE a.PROJ_ID IS NULL;

/* Subquery in SQL:
	A subquery is a query nested within another query such as SELECT, INSERT, UPDATE, or DELETE.
    It is also called an Inner Query or Inner Select while the statement that contains the subquery is called an 
    outer query or outer select.
    It can be used anywhere an expression is used and must be closed in parentheses.
    A subquery can also be nested within another subquery
*/

-- SubQuery as Expressions --
-- Suppose you need to determine the count of managers and the total team strength excluding them in 
-- the retail domain in MySQL.
SELECT m.DEPARTMENT, COUNT(DISTINCT(m.EMP_ID)) AS MANAGER_COUNT,
	(SELECT COUNT(DISTINCT(e.EMP_ID))
    FROM emp_records AS e
    WHERE e.ROLE NOT IN ('MANAGER', 'PRESIDENT', 'CEO')
    AND e.DEPARTMENT IN ('RETAIL')) AS TEAM_STRENGTH
FROM emp_records AS m
WHERE m.ROLE IN ('MANAGER')
AND m.DEPARTMENT IN ('RETAIL');

-- Subquery With WHERE Clause --
-- Suppose you need to determine the list of upcoming projects with no manager and team member assigned to them in MySQL.
SELECT p.PROJ_ID, p.PROJ_NAME, p.DOMAIN
FROM proj_data AS p
WHERE PROJ_ID NOT IN (
	SELECT DISTINCT a.PROJ_ID
    FROM proj_assign AS a
)
AND p.STATUS IN ('YTS'); 

-- Subquery With Comparison Operators --
-- Suppose you need to determine the employee with the highest experience in the organization in MySQL.
SELECT e.EMP_ID, CONCAT_WS(' ', e.FIRST_NAME, e.LAST_NAME) AS FULL_NAME, e.ROLE, e.DEPARTMENT, e.EXPERIENCE
FROM emp_records AS e
WHERE e.EXPERIENCE = (
	SELECT MAX(EXPERIENCE)
    FROM emp_records
);

-- Subquery With IN and NOT IN Operators --
-- Suppose you need to determine the list of all managers who have not been assigned to any projects in 
-- the organization in MySQL.

SELECT e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, e.ROLE, e.DEPARTMENT
FROM emp_records AS e
WHERE e.EMP_ID NOT IN (
	SELECT DISTINCT a.EMP_ID
    FROM proj_assign AS a
)
AND e.ROLE IN ('MANAGER');

-- Subquery With ANY Operator --
-- Suppose you need to determine any five employees with more than or equal to the average experience of all 
-- employees in the organization in MySQL.

SELECT e.EMP_ID, CONCAT_WS(' ', e.FIRST_NAME, e.LAST_NAME) AS FULL_NAME, e.ROLE, e.DEPARTMENT, e.EXPERIENCE
FROM emp_records AS e
WHERE e.EXPERIENCE >= ANY (
	SELECT AVG(EXPERIENCE)
    FROM emp_records
)
ORDER BY e.EXPERIENCE DESC
LIMIT 5;

-- Subquery With ALL Operator --
-- Suppose you need to determine all the employees with less than the average experience of all employees in MySQL.
SELECT e.EMP_ID, CONCAT_WS(' ', e.FIRST_NAME, e.LAST_NAME) AS FULL_NAME, e.ROLE, e.DEPARTMENT, e.EXPERIENCE
FROM emp_records AS e
WHERE e.EXPERIENCE < ALL (
	SELECT AVG(EXPERIENCE)
    FROM emp_records
)
ORDER BY e.EXPERIENCE DESC;

-- Subquery With EXISTS or NOT EXISTS Operators --
-- Suppose you need to print the names of all the projects only if even one project is assigned to any employee in MySQL.

SELECT PROJ_ID, PROJ_NAME
FROM proj_data
WHERE EXISTS (
	SELECT PROJ_ID
    FROM proj_assign
)
ORDER BY PROJ_ID;

-- Subquery in the FROM Clause --
-- Suppose you need to determine the maximum, minimum, and average employee experience in the organization in MySQL.

SELECT MIN(EXPERIENCE) AS MIN_EXP, MAX(EXPERIENCE) AS MAX_EXP, CEIL(AVG(EXPERIENCE)) AS AVG_EXP
FROM (
	SELECT EMP_ID, EXPERIENCE 
    FROM emp_records
	GROUP BY EXPERIENCE 
    ORDER BY EXPERIENCE
) AS TOTAL_EXPERIENCE;

-- Subquery With SELECT Statement --
-- Suppose you need to determine all those projects that are assigned to at least one of the employees in MySQL.

SELECT PROJ_ID, PROJ_NAME, DOMAIN, STATUS
FROM proj_data
WHERE PROJ_ID IN (
	SELECT DISTINCT PROJ_ID 
    FROM proj_assign
)
ORDER BY PROJ_ID, DOMAIN;

-- Subquery With INSERT Statement --
DESCRIBE proj_data;

/* CREATE TABLE proj_data_backup (
PROJ_ID VARCHAR(10) PRIMARY KEY NOT NULL,
PROJ_NAME VARCHAR(100) NOT NULL,
DOMAIN VARCHAR(50) NOT NULL,
START_DATE VARCHAR(20) NOT NULL,
CLOSURE_DATE VARCHAR(20) NOT NULL,
DEV_QTR VARCHAR(5) NOT NULL,
STATUS VARCHAR(10) NOT NULL
)ENGINE=InnoDB;

INSERT INTO proj_data_backup
SELECT * FROM proj_data AS p
WHERE p.PROJ_ID IN (
	SELECT DISTINCT PROJ_ID
    FROM proj_assign
); */

SELECT * FROM proj_data_backup;

-- Subquery With UPDATE Statemen --
-- Suppose you need to change the development quarter along with its start and closure dates for one of the projects in the 
-- PROJ_RECORDS_BKUP table in MySQL.

UPDATE proj_data_backup
SET DEV_QTR = 'Q2'
WHERE START_DATE = (
	SELECT START_DATE FROM proj_data
    WHERE DEV_QTR = 'Q3'
)
AND CLOSURE_DATE = (
	SELECT CLOSURE_DATE FROM proj_data
    WHERE DEV_QTR = 'Q3'
);

-- Subquery With DELETE Statement --
-- Let us say you need to remove a project from the PROJ_RECORDS_BKUP table that has the status YTS in 
-- the PROJ_RECORDS table in MySQL.
DELETE FROM proj_data_backup
WHERE PROJ_ID IN (
	SELECT p.PROJ_ID FROM proj_data AS p
    WHERE p.STATUS = 'YTS'
);

/* DERIVED TABLES:
	-- A derived table is a virtual table returned by a SELECT statement.
    -- A derived table is created byusing a stand-alone subquery in the FROM clause of a SELECT statement.
    -- It is mandatory for a derived table to have an alias so that it can be referenced in the query.
*/
-- Your manager wants you to find the total number of managers in the organization.
SELECT COUNT(DISTINCT(EMP_ID)) AS MANAGER_COUNT
FROM (
	SELECT DISTINCT EMP_ID
    FROM emp_records
    WHERE ROLE IN ('MANAGER')
) AS employees
WHERE EMP_ID = employees.EMP_ID;

-- Your manager wants you to find the total number of LEAD DATA SCIENTIST in the organization.
SELECT COUNT(DISTINCT(EMP_ID)) AS LEAD_DATA_SCIENTIST_COUNT
FROM emp_records
WHERE ROLE IN ('LEAD DATA SCIENTIST');

-- Your manager wants you to find the total number of SENIOR DATA SCIENTIST in the organization.
SELECT COUNT(DISTINCT(EMP_ID)) AS SENIOR_DATA_SCIENTIST_COUNT
FROM emp_records
WHERE ROLE IN ('SENIOR DATA SCIENTIST');

-- Your manager wants you to find the total number of ASSOCIATE DATA SCIENTIST in the organization.
SELECT COUNT(DISTINCT(EMP_ID)) AS ASSOCIATE_DATA_SCIENTIST_COUNT
FROM emp_records
WHERE ROLE IN ('ASSOCIATE DATA SCIENTIST');

-- Your manager wants you to find the total number of JUNIOR DATA SCIENTIST in the organization.
SELECT COUNT(DISTINCT(EMP_ID)) AS JUNIOR_DATA_SCIENTIST_COUNT
FROM emp_records
WHERE ROLE IN ('JUNIOR DATA SCIENTIST');

SELECT JUNIOR_DATA_SCIENTIST_COUNT AS JDS_COUNT, ASSOCIATE_DATA_SCIENTIST_COUNT AS ADS_COUNT, 
SENIOR_DATA_SCIENTIST_COUNT AS SDS_COUNT, LEAD_DATA_SCIENTIST_COUNT AS LDS_COUNT
FROM (
	(SELECT COUNT(DISTINCT(EMP_ID)) AS JUNIOR_DATA_SCIENTIST_COUNT
	FROM emp_records
	WHERE ROLE IN ('JUNIOR DATA SCIENTIST')) AS JDS_COUNT,
    (SELECT COUNT(DISTINCT(EMP_ID)) AS ASSOCIATE_DATA_SCIENTIST_COUNT
	FROM emp_records
	WHERE ROLE IN ('ASSOCIATE DATA SCIENTIST')) AS ADS_COUNT,
    (SELECT COUNT(DISTINCT(EMP_ID)) AS SENIOR_DATA_SCIENTIST_COUNT
	FROM emp_records
	WHERE ROLE IN ('SENIOR DATA SCIENTIST')) AS SDS_COUNT,
    (SELECT COUNT(DISTINCT(EMP_ID)) AS LEAD_DATA_SCIENTIST_COUNT
	FROM emp_records
	WHERE ROLE IN ('LEAD DATA SCIENTIST')) AS LDS_COUNT
);

-- EXISTS OPERATOR --
-- Write an SQL query using the EXISTS operator to verify the existence of managers and return their 
-- details if available from the EMP_RECORDS tables in MySQL.

SELECT * FROM emp_records AS e
WHERE EXISTS (
	SELECT 1 FROM emp_records
    WHERE ROLE IN ('MANAGER')
)
AND e.ROLE IN ('MANAGER');

-- NOT EXISTS Operator --
-- Your manager wants you to provide the basic information of all the employees with one year or less than 
-- one year of experience in the organization.

SELECT * FROM emp_records AS e
WHERE NOT EXISTS (
	SELECT 1 FROM emp_records
    WHERE EXPERIENCE < 0
)
AND e.EXPERIENCE <= 1;






















 