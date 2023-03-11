-- Performance Optimization and Best Practices in SQL --
/* Execution Plan in SQL 
	-- Unlike other database solutions, MySQL does not generate byte-code to execute a query result. Instead, the query execution 
    plan is used.
    -- The query execution plan is a list of instructions that the query execution must follow to produce the query result.
    -- It converts the source code (SQL query) into an executable program.
*/ 
/*
Problem Scenario:
	A data analyst of a company wants to check the execution plan for a query to view the performance and cost of the query.
Objective: 
	View the execution plan and create an index on the query to improve efficiency of the query.
*/
USE simplilearn;

CREATE TABLE execution_plan (
ID INT NOT NULL,
NAME VARCHAR(255),
DESIGNATION VARCHAR(255),
CITY VARCHAR(255)
);

INSERT INTO execution_plan VALUES
(3, 'Steve', 'LD', 'Paris');

SELECT * FROM execution_plan;

SELECT * FROM execution_plan
WHERE NAME = "Steve";

/* 
	-- The image shows the execution plan, and the red box which is in the image is due to the Performance and high 
    cost of the query.
    -- Query cost is a metric used in MySQL to determine how expensive a query is in terms of the overall cost of query 
    execution
*/

-- Creating an index to enhance the query performance
CREATE INDEX idx_word ON execution_plan(NAME);
SELECT * FROM execution_plan WHERE NAME = 'Steve';

-- Index Guidelines --
/* Choosing the right columns and types for an index is a crucial part of building a useful index.
	-- Keep index keys as short as possible:
		-- The larger an index key gets, the harder it is for a database to use it. An integer key is smaller than a 
        character field that can carry 100 characters. Keep clustered indexes as short as possible.

    -- Keep separate index keys
		-- Indexes with a limited percentage of duplicated values are the most effective. With a decent index, the database 
        will be able to ignore as many records as possible.
        
    -- Keep selective indexes
		-- A selective index has a lot of unique values. A unique index is the most selective of all the indexes, because 
        there are no duplicate values.
        
    -- Keep indexes up-to-date
		-- You will need to see existing indexes as well as delete or rename them, in addition to generating new ones. As 
        the schema or even naming standards change, this is part of the database's continual maintenance cycle.
*/
/* Clustered Index in SQL:
	-- A clustered index is an index that reorders the actual storage of entries in a table.
    -- Each table can only have one clustered index    
Following are the essential characteristics of a clustered index:
	-- It allows us to store both data and indexes at the same time.
    -- It only has one manner of storing data, which is dependent on the key values.
    -- It's an excellent choice for range or group queries that return min, max, or count values.
    -- It always takes one or more columns to create an index.
*/
/* Covering Queries With Indexes in SQL:
	-- A covered query is a query where all the columns in the query's result set are pulled from non-clustered indexes.
    -- The careful placement of indexes transforms a query into a covered query.
*/
/*
Problem Scenario:
	-- A data analyst wants to sort a table in order, with the help of a clustered index. Create a primary key which acts as a 
    clustered index in that table.
Objective:
	-- Implement the clustered index to obtain the result. 
Instructions:
	-- Refer the emp_data table created before and perform the objectives.
*/

/* Problem Statement: You are required to create the temperature as unique, add new index columns, and view the index of the 
weather table for data integrity.
*/

CREATE TABLE weather (
temp INT NOT NULL,
windspeed VARCHAR(255) NOT NULL,
vapour VARCHAR(255) NOT NULL,
climate VARCHAR(255) NOT NULL
);

INSERT INTO weather VALUES
(35, '120 Km/Hr', '21', 'Summer');

CREATE UNIQUE INDEX temp_index ON weather(temp);

ALTER TABLE weather ADD INDEX
index_col1_col2 (windspeed, vapour, climate);

SHOW INDEX FROM weather;

/* Common Table Expression:
	-- Each statement or query in MySQL generates a temporary result or relation. CREATE, INSERT, SELECT, UPDATE, DELETE, and 
    other statements employ a common table expression (CTE) to name the temporary results sets that exist within the execution 
    scope of that statement.
	-- WITH clause is used to define CTE 
    -- WITH clause allows you to define several CTEs in a single query.
    -- CTE makes code maintainability easier.
    -- The execution scope of CTE exists within the statement in which it is used.
*/
/*
Problem Scenario:
	-- A data analyst wants to apply a CTE to the table with first name, last name, and the country of the person whose salary 
    is greater than or equal to 4000.
Objective: 
	-- Implement the CTE to obtain the required result.
Instructions:
	Refer the emp_data table which was created and shown before. Perform the objectives mentioned above
*/

WITH emp_in_germany AS (
	SELECT * FROM emp_records WHERE COUNTRY = "GERMANY"
)
 SELECT FIRST_NAME, SALARY, COUNTRY FROM emp_in_germany WHERE SALARY >= 4000 ORDER BY FIRST_NAME;

