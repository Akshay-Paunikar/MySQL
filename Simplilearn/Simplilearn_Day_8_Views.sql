USE simplilearn;
SELECT * FROM emp_data;
/* SQL VIEWS:
	-- In SQL, a view refers to a virtual table. It can be created by selecting fields from one or more tables.
*/
/* Problem Scenario: 
	-- You are a data analyst in your company, and you are asked to create a temporary table of employees with salary 
    more than 22000.
   Objective: 
	-- Use the view command to create a temporary table for the condition mentioned above.
*/
CREATE VIEW Emp_View AS
SELECT Emp_ID, Emp_F_NAME, Emp_Location
FROM emp_data
WHERE Emp_Salary > 22000;

SELECT * FROM emp_view;

/* Deleting or Dropping a View */
-- DROP VIEW emp_view;
 
/* Updating or Modifying a View */
-- Suppose you want to display different columns in the same view name created earlier, then you can use the replace 
-- view command.
CREATE OR REPLACE VIEW emp_view AS
SELECT Emp_ID, Emp_Location
FROM emp_data
WHERE Emp_Salary > 22000;

SELECT * FROM emp_view;

/* Altering a View */
-- If you want to change the columns of a created Emp_View, then you use the alter command.
ALTER VIEW emp_view AS
SELECT Emp_ID, Emp_Salary
FROM emp_data
WHERE Emp_Salary > 22000;

SELECT * FROM emp_view;

/* Renaming a View */
-- Consider the same employee records table and its view Emp view. If you want to rename the view name that 
-- focuses more on the salary aspect, you can use the following syntax:
RENAME TABLE emp_view
TO emp_sal_view;

SELECT * FROM emp_sal_view;

/* View Processing Algorithms:
	-- In CREATE VIEW command, there is an optional clause called ALGORITHM. This specifies how the view must be processed.
    -- In MERGE, the text of a statement is merged in such a way that parts of the view definition replace the corresponding 
    parts of the statement.
*/

/* Workflow of View Processing Algorithms (Merge): Example:
	-- Problem Statement: 
		-- You are the junior DB administrator in your organization, and your manager has asked you to change the column 
        headers of the employee table and create a new view.
	-- Objective: Create a view with the merge algorithm and specify the column headers with the changes.
*/
CREATE ALGORITHM = MERGE VIEW e_view (
Emp_Name, R_Name, D_Name, Ex_p) AS
SELECT FIRST_NAME, ROLE, DEPARTMENT, EXPERIENCE
FROM employee_data;

SELECT * FROM e_view
WHERE Emp_Name LIKE '%R%';

-- In TEMPTABLE, the results from the view are retrieved into a temporary table, which is then used to execute the statement.
-- The TEMPTABLE algorithm is less efficient than the MERGE algorithm, as MySQL creates a temporary table to store data 
-- from the base table.
-- UNDEFINED is the default algorithm applied when you create a view without specifying the ALGORITHM clause.
-- MySQL decides to go either with MERGE or TEMPTABLE but prefers MERGE as it is more efficient.
-- Updatable in MySQL refers to the ability of executing UPDATE and DELETE queries in the database view.
/*
Problem Statement: You are a junior DB administrator in your organization. After appraisals, your designation has been 
changed to Lead Data Scientist. Your Manager has asked you to update the role change in the created view. 

Objective: Create a view for employees, using the employee table, and update the record for the employee named Roy.
*/

CREATE VIEW ROLE_NAME AS
SELECT EMP_ID, FIRST_NAME, ROLE
FROM employee_data;

UPDATE ROLE_NAME
SET ROLE = 'Lead Data Scientist'
WHERE FIRST_NAME = 'Roy';

SELECT * FROM ROLE_NAME; 

/* Creating Views Using WITH CHECK OPTION:
	-- Is an optional clause .
    -- Specifies the level of checking when data is inserted or updated through a view.
    -- If specified, every row that is inserted or updated through the view must conform to the definition of the view.
	-- If it is not specified, insert and update operations that are performed on the view are not checked for conformance 
    to view the definition
*/
/* Creating Views Using WITH CHECK OPTION: Example
	-- Problem Statement: You are the junior DB administrator in your organization, and your Manger has asked you to 
    create a view that displays the Lead Data Scientist role from the employee table created earlier. The view must only 
    allow the addition of employee with the Lead designation. Any other designation entered must prompt an error.
    
	-- Objective: Create a view using the WITH CHECK OPTION to avoid addition of other designations.
*/
CREATE OR REPLACE VIEW LEAD_DS AS
SELECT EMP_ID, FIRST_NAME, Role, Department, Experience
FROM employee_data
WHERE ROLE LIKE 'Lead%'
WITH CHECK OPTION;

INSERT INTO LEAD_DS VALUES (
333, 'Mike', 'Senior Data Scientist', 'Finance', 6
);

/* Creating Views Using WITH CASCADED CHECK OPTION:
	-- This clause specifies that every row that is inserted or updated through a view must conform to the 
    definition of the view.
	-- A row cannot be retrieved through the view if it does not conform to the definition of view.
*/
CREATE TABLE T1 (C INT);
CREATE VIEW V1 AS SELECT C
FROM T1 WHERE C >10;
INSERT INTO V1 (C) VALUES (5);

CREATE VIEW V2 AS 
SELECT C FROM V1
WITH CASCADED CHECK OPTION;
INSERT INTO V2(C) VALUES (5);

CREATE VIEW V3 AS 
SELECT C
FROM V2
WHERE C < 20;
INSERT INTO V3(C) VALUES (8);

INSERT INTO V3(C) VALUES (30);

/*
Creating Views Using WITH LOCAL CHECK OPTION:
	-- WITH LOCAL CHECK OPTION clause is same as WITH CASCADED CHECK OPTION clause, except that you can update a row in such 
    a way that it cannot be retrieved through the view.
	-- This occurs when the view is directly or indirectly dependent on a view that is defined without a WITH CHECK OPTION.
*/
ALTER VIEW V2 AS
SELECT C
FROM V1
WITH LOCAL CHECK OPTION;

INSERT INTO V2(C) VALUES (5);
INSERT INTO V3(C) VALUES (8);
SHOW FULL TABLES WHERE TABLE_TYPE = 'VIEW';

/* Assisted Practice: VIEWS:
	-- Problem Statement: Design a VIEW in MySQL which displays the employee’s name, location, and project name from 
    two different tables: data_scientist and project.
*/
CREATE TABLE data_scientist (
emp_code INT NOT NULL,
name VARCHAR(255) NOT NULL,
location VARCHAR(255) NOT NULL,
experience INT NOT NULL,
designation VARCHAR(50) NOT NULL,
PRIMARY KEY(emp_code)
);

INSERT INTO data_scientist VALUES 
(01, 'ram', 'India', 1, 'Jr'),
(02, 'robert', 'USA', 6, 'Lead'),
(03, 'tim', 'China', 2, 'Sr'),
(04, 'william', 'Paris', 5, 'Lead'),
(05, 'maggie', 'UK', 9, 'Lead');

CREATE TABLE PROJECT (
emp_code INT NOT NULL,
project_name VARCHAR(255) NOT NULL,
project_status VARCHAR(15),
PRIMARY KEY(emp_code)
);

INSERT INTO project VALUES
(01, 'C++', 'Done'),
(02, 'C', 'Done'),
(03, 'Java', 'Done'),
(04, 'MySQL', 'Done'),
(05, 'Python', 'Done');
DROP VIEW display;
CREATE VIEW display AS
SELECT ds.name, ds. location, p.project_name
FROM data_scientist AS ds, project AS p
WHERE ds.emp_code = p.emp_code;

SELECT * FROM display; 











