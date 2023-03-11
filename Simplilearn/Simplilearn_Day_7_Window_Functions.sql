USE simplilearn;

/* WINDOW FUNCTION:
	-- The window functions is like an SQL function that takes input values from a window of one or more rows of 
    a SELECT statement’s result set.
    -- The window functions perform various operations on a group of rows and provide an aggregated value for each 
    row with a unique identity.
*/

/* Partition Clause:
	-- The partition clause is used to divide or split the rows into partitions, and the partition boundary is used 
    to split two partitions.
   Order By Clause:
	-- Order By clause is an arrangement of rows inside a partition. It performs partitions using multiple keys 
    where each key has an expression.
   Frame Clause:
	-- Frame clause is defined as subset of the current position. It allows to move the subset within a 
    partition based on the position of the current row in its partition.
*/

/* Use Case of Window Function:
	-- Problem Scenario:
		-- The HR of a company wants to calculate the performance of employees department-wise based on the employee ratings. 
	   Objective:
		-- You are required to retrieve the employee ID, first name, role, department, and employee rating by calculating the 
        maximum employee rating using PARTITION BY and MAX function on department and employee rating fields respectively.
*/
SELECT * FROM hr_data;
SELECT EMP_ID, FIRST_NAME, ROLE, DEPARTMENT, EMP_RATING, MAX(EMP_RATING) OVER (PARTITION BY DEPARTMENT) AS MAX_EMP_RATING
FROM hr_data;

/* Aggregate Window Functions:
	-- The aggregate window functions perform on a particular set of rows and provide the result in a single row.
    -- MIN()
    -- MAX()
    -- SUM()
    -- AVG()
    -- COUNT()
*/
/* Use Case for MIN and MAX:
	-- Problem Scenario:
		-- The HR of a company wants to identify the minimum and the maximum salary of the employees in a role.
	-- Objective:
		-- You are required to display the employee’s ID, first name, role, and salary by finding the minimum and maximum 
        salary of the employees using PARTITION BY clause, MIN, and MAX functions on role and salary fields respectively.
*/
SELECT EMP_ID, FIRST_NAME, ROLE, SALARY, MIN(SALARY) OVER (PARTITION BY ROLE) AS MIN_SALARY,
MAX(SALARY) OVER (PARTITION BY ROLE) AS MAX_SALARY
FROM hr_data;

/* Use Case for AVG and COUNT:
	-- Problem Scenario:
		-- The HR of a company wants to identify the average performance of the employee's departmen-wise and also find the 
        total number of records in a department.
	-- Objective:
		-- You are required to display the employee’s ID, first name, department, and employee rating by calculating the 
        average employee rating and the total number of records in a department using PARTITION BY clause, AVG, and COUNT 
        functions on department and employee rating fields respectively.
*/
SELECT EMP_ID, FIRST_NAME, DEPARTMENT, EMP_RATING, AVG(EMP_RATING) OVER (PARTITION BY DEPARTMENT) AS AVG_EMP_RATING,
COUNT(*) OVER (PARTITION BY DEPARTMENT) AS TOTAL_NO_OF_RECORDS
FROM hr_data;

/* Use Case for SUM:
	-- Problem Scenario:
		-- The HR of a company wants to calculate the total employee rating in a department.
	-- Objective:
		-- You are required to display the employee’s Id, first name, department, and employee rating by calculating the 
        total employee rating in a department using PARTITION BY clause and SUM function on the department and the 
        employee rating fields respectively.
*/
SELECT EMP_ID, FIRST_NAME, DEPARTMENT, EMP_RATING, SUM(EMP_RATING) OVER (PARTITION BY DEPARTMENT) AS TOTAL_EMP_RATING
FROM hr_data;

/* Problem Statement: 
	-- You are required to calculate the total, average, maximum, and minimum salary of the employee by grouping the 
    departments from the employee table.
*/
SELECT EMP_ID, CONCAT_WS(' ', FIRST_NAME, LAST_NAME) AS EMP_NAME, GENDER, ROLE, DEPARTMENT, EXPERIENCE, SALARY,
SUM(SALARY) OVER (PARTITION BY DEPARTMENT) AS TOTAL_SALARY, AVG(SALARY) OVER (PARTITION BY DEPARTMENT) AS AVG_SALARY,
MIN(SALARY) OVER (PARTITION BY DEPARTMENT) AS MIN_SALARY, MAX(SALARY) OVER (PARTITION BY DEPARTMENT) AS MAX_SALARY
FROM hr_data;

/* Ranking Window Functions and Its Types:
	-- Ranking window functions specify the rank for individual fields as per the categorization.
    -- Dense Rank:
		-- It assigns the same rank for equal values & It has no gaps if two or more rows have a similar rank.
	-- RANK:
		-- Same rank for the same value and there will be a gap if two or more rows have the same rank.
*/
/* Use Case for Rank and Dense Rank:
	-- Problem Scenario:
		-- The HR of a company wants to assign a rank for each employee based on their employee rating.
	-- Objective:
		-- You are required to display the employee’s ID, first name, department, and employee rating by assigning a rank 
        to all the employees based on their employee rating using ORDER BY clause, RANK, and DENSE RANK functions on 
        the employee rating field.
*/
SELECT EMP_ID, FIRST_NAME, DEPARTMENT, EMP_RATING, RANK() OVER (ORDER BY EMP_RATING DESC) AS EMP_RATING_RANK,
DENSE_RANK() OVER (ORDER BY EMP_RATING DESC) AS EMP_RATING_DENSE_RANK
FROM hr_data;

/* Row Number:
	-- Row number retrieves the unique sequential number of each row for the specified data.
    -- Similar values will have different ranks.
*/
/* Use Case for Row Number:
	-- Problem Scenario:
		-- The IT department of a company wants to assign an asset number for each employee based on their employee 
        ID in ascending order.
	-- Objective:
		-- You are required to display the employee’s ID, first name, role, and department by assigning a number to each 
        employee in ascending order of their employee ID using ORDER BY clause and ROW NUMBER function on the 
        employee ID field.
*/
SELECT EMP_ID, FIRST_NAME, ROLE, DEPARTMENT, ROW_NUMBER() OVER (ORDER BY EMP_ID ASC) AS ASSET_NO
FROM hr_data;

/* Percent Rank:
	-- Percent rank helps to evaluate the percentile rank of a value in a partition or result set.
    -- It returns a value between zero to one.
*/
/* Use Case for Percent Rank:
	-- Problem Scenario:
		-- The HR of a company wants to calculate the overall percentile of the employee rating in a department.
	-- Objective:
		-- You are required to display employee’s ID, first name, role, department, and employee rating by calculating 
        the percentile of the employee rating in a department using ORDER BY clause and PERCENT RANK function on an 
        employee rating field.
*/
SELECT EMP_ID, FIRST_NAME, ROLE, DEPARTMENT, EMP_RATING, ROUND(PERCENT_RANK() OVER (ORDER BY EMP_RATING ASC),2) AS OVERALL_PERCENTILE
FROM hr_data;

/* Miscellaneous Window Functions:*/
/* First Value Function:
		-- First value function returns the value of the expression from the first row of the window frame.
*/
/* Use Case for First Value Function:
	-- Problem Scenario:
		-- The HR department of an organization aims to find the employee ID of the employee with the highest experience 
        by sorting their experience in descending order.
	-- Objective:
		-- You are required to display the employee ID, first name, and experience, as well as identify the employee ID 
        of the first employee by sorting the experience in descending order using the ORDER BY clause and first value 
        function on the experience and employee ID fields respectively.
*/
SELECT EMP_ID, FIRST_NAME, EXPERIENCE, FIRST_VALUE(EMP_ID) OVER (ORDER BY EXPERIENCE DESC) AS HIGHEST_EXPERIENCE
FROM hr_data;

/* NTH Value Function:
	-- The NTH value function acquires a value from the Nth row of an ordered group of rows.
*/
/* Use Case for NTH Value Function:
	-- Problem Scenario:
		-- The HR of a company wants to identify the third-highest experience among employees in thecompany.
	-- Objective:
		-- You are required to display the employee’s ID, first name, and experience by calculating the third-highest 
        experience among employees using ORDER BY clause and NTH value function in descending order of experience field.
*/
SELECT EMP_ID, FIRST_NAME, EXPERIENCE, NTH_VALUE(EXPERIENCE, 3) OVER (ORDER BY EXPERIENCE DESC) AS THIRD_HIGHEST_EXPERIENCE
FROM hr_data;

/* NTILE Function:
	-- NTILE function breaks the rows into a sorted partition in a certain number of groups.
*/
/* Use Case for NTILE Function:
	-- Problem Scenario:
		-- The HR of a company wants to sort the employee table in ascending based on their experience in four partitions.
	-- Objective:
		-- You are required to display all the details by sorting the experience into four partitions in ascending order 
        using the ORDER BY clause and NTILE function on an experience field.
*/
SELECT *, NTILE(4) OVER (ORDER BY EXPERIENCE) AS EXPERIENCE_PARTITION
FROM hr_data;

/* Cume Dist Function:
	-- The Cume Dist function calculates the cumulative distribution of a number in a group of values.
*/
/* Use Case for Cume Dist Function:
	-- Problem Scenario:
		-- The HR of a company wants to sort the employee data based on their experience in ascending order and 
        calculate the cumulative distribution on the employee table.
	-- Objective:
		-- You are required to display the employee’s ID, first name, and experience by calculating the cumulative 
        distribution of the experience with the help of ROW NUMBER using ORDER BY, ROW NUMBER, and CUME DIST function 
        on an experience field.
*/
SELECT EMP_ID, FIRST_NAME, EXPERIENCE, ROW_NUMBER() OVER (ORDER BY EXPERIENCE) AS EXPERIENCE_ROW_NUMBER,
CUME_DIST() OVER (ORDER BY EXPERIENCE) AS CUM_DIST_EXP
FROM hr_data;

/* Lead Function:
	-- Lead function is used to retrieve the values from the next N rows.
*/
/* Lag Function:
	-- Lag function is used to retrieve the values from previous N rows.
*/
/* Use Case for Lead and Lag Function:
	-- Problem Scenario:
		-- The HR of a company wants to ignore the two lowest and highest experiences of the employees.
	-- Objective:
		-- You are required to display the employee’s ID, first name, experience and sort the employees in ascending order of 
        their experience. Ignore the two lowest experiences using LEAD and two highest experiences using LAG to determine 
        the median of the employee experience.
*/
SELECT EMP_ID, FIRST_NAME, EXPERIENCE, LAG(EXPERIENCE,2) OVER (ORDER BY EXPERIENCE) AS LOWEST_EXP,
LEAD(EXPERIENCE,2) OVER (ORDER BY EXPERIENCE) AS HIGHEST_EXP
FROM hr_data;

/* Last Value Function:
	-- Last value function returns the last value of a specific column in an ordered sequence.
*/
/* Use Case for Last Value Function:
	-- Problem Scenario:
		-- The HR of a company wants to determine the last employee ID by sorting the experience in ascending order.
	-- Objective:
		-- You are required to display the employee’s ID, first name, and experience and determine the last employee ID 
        by sorting the experience in ascending order using ORDER BY clause and last value function on the experience and 
        employee ID field respectively.
*/
SELECT EMP_ID, FIRST_NAME, EXPERIENCE, LAST_VALUE(EMP_ID) OVER (ORDER BY EXPERIENCE) AS LASTVALUE
FROM hr_data;

/* Assisted Practice: Ranking and Miscellaneous Window Functions:
	-- Problem Statement: You are required to identify the rank and row number and calculate the cumulative distribution 
    and percentile score based on the student score from the marksheet table.
*/
SELECT s_id, score, RANK() OVER (ORDER BY score DESC) AS FINAL_RANK,
ROUND(PERCENT_RANK() OVER (ORDER BY score),2) AS RANK_PERCENT,
ROW_NUMBER() OVER (ORDER BY score) AS RowNumber,
ROUND(CUME_DIST() OVER (ORDER BY score),2) AS Cum_Dist_Score
FROM marksheet;

















