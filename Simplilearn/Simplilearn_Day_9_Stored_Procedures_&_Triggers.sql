USE simplilearn;

/* Stored Procedures:
	-- A stored procedure is a collection of precompiled SQL commands in a database.
    -- When a procedure calls itself, then it is called a recursive stored procedure.
*/
/*
Stored Procedures: Example
	-- Problem Statement: You are a junior DB administrator in your company. Your manager has asked you to retrieve data on 
    employees with more than five years of experience, using a single command.
	-- Objective: Use a stored procedure to retrieve the required data anytime.
*/

DELIMITER &&
CREATE PROCEDURE get_experience()
BEGIN
SELECT * FROM hr_data
WHERE EXPERIENCE > 5;
END && 
DELIMITER ;

CALL get_experience();

/*
Declaring and Assigning Variables: Example
	-- Problem statement: You are a junior DB administrator, and your manager has asked you to identify the total number of 
    employees in the employee table created earlier. 
	-- Objectives: Use the stored procedure to view the number of employees anytime and also declare a variable for 
    total employees.
*/
DELIMITER &&
CREATE PROCEDURE total_employees()
BEGIN
DECLARE totalemployees INT DEFAULT 0;
SELECT COUNT(*) INTO totalemployee
FROM hr_data;
SELECT totalemployees;
END &&
DELIMITER ;

CALL total_employees();

/* 
Stored Procedures That Return Multiple Values: Example (IN):
	-- Problem Statement: You are a junior DB administrator in your organization. Your manager has asked you to list the 
    employee names in the automotive department.
	-- Objective: Create a stored procedure with an IN parameter to extract employee names by specifying the department name.
*/
DELIMITER &&
CREATE PROCEDURE find_name(IN dept VARCHAR(255))
BEGIN
SELECT FIRST_NAME
FROM hr_data
WHERE DEPARTMENT = dept;
END &&
DELIMITER ;

CALL find_name('RETAIL');

/*
Stored Procedures That Return Multiple Values: Example (OUT)
	-- Problem Statement: You are a junior DB administrator in your organization. Your manager has asked you to count the 
    employees in the retail department.
	-- Objective: Create a stored procedure with an OUT parameter and extract the required result.
*/
DELIMITER &&
CREATE PROCEDURE count_emp_dept(IN dept VARCHAR(255), OUT emp_count INT)
BEGIN
SELECT COUNT(*) INTO emp_count
FROM hr_data
WHERE DEPARTMENT = dept;
SELECT emp_count;
END &&
DELIMITER ;

CALL count_emp_dept('HEALTHCARE', @counts);
CALL count_emp_dept('FINANCE', @counts);

/*
Stored Procedures with One Parameter: Example
	-- Problem Statement: You are a junior DB administrator in your organization. Your manager wants to identify an 
    employee’s experience based on just the employee ID and decide whether to give them a hike or not. 
	-- Objective: Create a stored procedure with employee ID as the parameter.
*/

DELIMITER &&
CREATE PROCEDURE give_hike(IN id VARCHAR(10))
BEGIN
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXPERIENCE
FROM hr_data
WHERE EMP_ID = id;
END &&
DELIMITER ;

CALL give_hike('E083');

/* 
Stored Procedures with Two Parameter: Example 
	-- Problem Statement: You are a junior DB administrator in your organization. Your manager wants to identify employees 
    with less than 3 years of experience and salaries less than 30000.
	-- Objective: Create a stored procedure that takes the employee experience and salary as parameters.
*/
DELIMITER &&
CREATE PROCEDURE exp_sal(IN exp INT, IN sal INT)
BEGIN
SELECT *
FROM hr_data
WHERE EXPERIENCE < exp
AND SALARY < sal;
END &&
DELIMITER ;

CALL exp_sal(3, 6000);

SHOW PROCEDURE STATUS;

/* Use Case: Employee Data Analysis by HR 
Give increase in salary According to EXP or Rating
*/

DELIMITER &&
CREATE PROCEDURE sal_increment(IN exp INT, IN exp2 INT,IN rating INT, raise FLOAT)
BEGIN
SELECT EMP_ID, EXPERIENCE, SALARY, EMP_RATING, ROUND((SALARY*raise),2) AS new_salary
FROM hr_data
WHERE (EXPERIENCE > exp AND EXPERIENCE < exp2)
AND EMP_RATING > rating;
END &&
DELIMITER ;

CALL sal_increment(4,10,3,1.1);

/* Compound Statement:
	-- Compound statement is a block that contains declarations of variables, condition handlers, cursors, loops, and 
    conditional tests.
*/
/*
Compound Statement: Example
	-- Problem Statement: The HR department wants to extract the manager’s details along with the number of employees 
    reporting to the manager by using the manager’s employee ID.
	-- Objective: Create a stored procedure that takes the manager's employee ID as input and returns the manager's 
    basic information as well as the number of employees reporting to the manager
*/

DELIMITER &&
CREATE PROCEDURE manager_emp_count(IN man_id VARCHAR(10))
BEGIN
SELECT m.EMP_ID, m.FIRST_NAME, m.LAST_NAME, m.GENDER, m.ROLE, m.DEPARTMENT, (e.EMP_ID) AS EMP_COUNT
FROM hr_data AS m
LEFT JOIN hr_data AS e
ON m.EMP_ID = e.MANAGER_ID
WHERE m.ROLE IN ('MANAGER')
AND m.EMP_ID = man_id
GROUP BY m.EMP_ID
ORDER BY m.EMP_ID;
END &&
DELIMITER ;

CALL manager_emp_count('E583');
CALL manager_emp_count('E083');

/*
CONDITIONAL STATEMENTS:
	-- Conditional statements are used to regulate the flow of an SQL query's execution by describing the logic that 
    will be executed if a condition is satisfied.
*/
/*
IF Statement:
	-- It is a type of control-flow statement that determines whether to execute a block of SQL code based on a specified 
    condition.
    -- In the IF condition, a block of SQL code is specified between the IF and END IF keywords.
    -- IF-THEN
    -- IF-THEN-ELSE
    -- IF-THEN-ELSEIF-ELSE
*/
/* IF-THEN Statement:
	-- The IF-THEN statement executes a set of SQL statements based on a specified condition.
*/
/*
IF-THEN Statement: Example
	-- Problem Statement: The HR department wants to identify the employees who have a rating below three and are not 
    performing well.
	-- Objective: Create a stored procedure to determine if an employee's performance is bad depending on the rating, 
    where a rating below three indicates bad performance.
*/
USE simplilearn;
DELIMITER &&
CREATE PROCEDURE bad_performance(IN eid VARCHAR(10), OUT performance VARCHAR(10))
BEGIN
DECLARE score INT DEFAULT 0;
SELECT EMP_RATING INTO score
FROM hr_data
WHERE EMP_ID = eid;
IF score < 3 THEN
SET performance = "BAD";
END IF;
SELECT performance;
END &&
DELIMITER ;

CALL bad_performance('E245',@performance);
CALL bad_performance('E640', @performance);

/*
IF-THEN-ELSE Statement:
	-- The IF-THEN-ELSE statement executes another set of SQL statements when the condition in the IF branch does not 
    evaluate to TRUE.
*/
/*
IF-THEN-ELSE Statement
	-- Problem Statement: The HR department needs to know the employees who have a rating below three and are not doing well 
    as well as the ones with a rating of three or more and are performing well.
	-- Objective: Create a stored procedure to determine if an employee's performance is good or bad depending on the rating, 
    where a rating below three indicates bad performance and three or above indicates good performance
*/
DELIMITER &&
CREATE PROCEDURE emp_performance(IN eid VARCHAR(10), OUT performance VARCHAR(10))
BEGIN
DECLARE score INT DEFAULT 0;
SELECT EMP_RATING INTO score
FROM hr_data
WHERE EMP_ID = eid;
IF score < 3 THEN
	SET performance = "BAD";
ELSE
	SET performance = "GOOD";
END IF;
SELECT performance;
END &&
DELIMITER ;

CALL emp_performance('E245', @performance);
CALL emp_performance('E640', @performance);

/* 
IF-THEN-ELSEIF-ELSE Statement
	-- The IF-THEN-ELSEIF-ELSE statement conditionally executes a set of SQL statements based on multiple conditions.
*/
/*
IF-THEN-ELSEIF-ELSE Statement: Example
	-- Problem Statement: The HR department needs to know how each employee is performing by categorizing them based on their 
    ratings, which vary from one to five. They want to grade each employee's performance as Overachiever, Excellent Performance, 
    Meeting Expectations, Below Expectations, and Not Achieving Any Goals.
	-- Objective: Create a stored procedure to determine the performance of an employee based on the employee rating with an 
    additional criteria for identifying an invalid rating using the IF-THEN-ELSEIF-ELSE statement
*/
DELIMITER &&
CREATE PROCEDURE employee_performance_data(IN eid VARCHAR(10), OUT performance VARCHAR(100))
BEGIN
DECLARE score INT DEFAULT 0;
SELECT EMP_RATING INTO score
FROM hr_data
WHERE EMP_ID = eid;
IF score = 5 THEN
	SET performance = "Overachiever";
ELSEIF score = 4 THEN
	SET performance = "Excellent Performance";
ELSEIF score = 3 THEN
	SET performance = "Meeting Expectations";
ELSEIF score = 2 THEN
	SET performance = "Below Expectations";
ELSEIF score = 1 THEN
	SET performance = "Not Achieving Any Goals";
ELSE
	SET performance = "INVALID";
END IF;
SELECT performance;
END &&
DELIMITER ;

CALL employee_performance_data("E620",@performance);
CALL employee_performance_data("E245",@performance);
CALL employee_performance_data("E260",@performance);
CALL employee_performance_data("E640",@performance);
CALL employee_performance_data("E204",@performance);

/* CASE Statement:
	-- It is a type of control-flow statement used in stored procedures to create conditional statements that make the code 
	more readable and efficient.
    -- It extends the functionality of the IF statement.
*/
/*
Simple CASE Statement
	-- It checks for equality; however, it cannot be used to check for equality with NULL because NULL returns FALSE.
    -- It only allows a value to be compared to a set of distinct values.
    -- MySQL raises an error in absence of the ELSE clause if no conditions are satisfied.
    -- The ELSE clause utilizes an empty BEGIN...END block to prevent any errors.
*/
/* 
Simple CASE Statement: Example
	-- Problem Statement: The HR department needs to know how each employee is performing by categorizing them based on their 
    ratings, which vary from one to five. They want to grade each employee's performance as Overachiever, Excellent Performance, 
    Meeting Expectations, Below Expectations, and Not Achieving Any Goals.
	-- Objective: Create a stored procedure to determine the performance of an employee based on the employee rating with an 
    additional criteria for identifying an invalid rating using the Simple CASE statement.
*/
DELIMITER &&
CREATE PROCEDURE case_performance_review(IN eid VARCHAR(10), OUT performance VARCHAR(100))
BEGIN
DECLARE score INT DEFAULT 0;
SELECT EMP_RATING INTO score
FROM hr_data
WHERE EMP_ID = eid;
CASE score
	WHEN 5 THEN
		SET performance = "Overachiever";
	WHEN 4 THEN
		SET performance = "Excellent Performance";
	WHEN 3 THEN
		SET performance = "Meeting Expectations";
	WHEN 2 THEN
		SET performance = "Below Expectations";
	WHEN 1 THEN
		SET performance = "Not Achieving Any Goals";
	ELSE
		BEGIN
			SET performance = "INVALID";
		END;
END CASE;
SELECT performance;
END &&
DELIMITER ;

CALL case_performance_review("E620",@performance);
CALL case_performance_review("E245",@performance);
CALL case_performance_review("E260",@performance);
CALL case_performance_review("E640",@performance);
CALL case_performance_review("E204",@performance);

/*
Searched CASE Statement
	-- It is similar to the IF statement; however, it is considerably more readable.
    -- It is used for performing more complex matching such as ranges.
    -- MySQL raises an error in absence of the ELSE clause if no condition evaluates to TRUE.
    -- The ELSE clause utilizes an empty BEGIN...END block to prevent errors.
*/
/*
Searched CASE Statement: Example
	-- Problem Statement: The HR department needs to know how each employee is performing by categorizing them based on their 
    ratings, which vary from one to five. They want to grade each employee's performance as Overachiever, Excellent Performance, 
    Meeting Expectations, Below Expectations, and Not Achieving Any Goals.
	-- Objective: Create a stored procedure to determine the performance of an employee based on the employee rating with an 
    additional criteria for identifying an invalid rating using the Searched CASE statement.
*/
DELIMITER &&
CREATE PROCEDURE searched_case_performance_review(IN eid VARCHAR(10), OUT performance VARCHAR(100))
BEGIN
DECLARE score INT DEFAULT 0;
SELECT EMP_RATING INTO score
FROM hr_data
WHERE EMP_ID = eid;
CASE
	WHEN score = 5 THEN
		SET performance = "Overachiever";
	WHEN score = 4 THEN
		SET performance = "Excellent Performance";
	WHEN score = 3 THEN
		SET performance = "Meeting Expectations";
	WHEN score = 2 THEN
		SET performance = "Below Expectations";
	WHEN score = 1 THEN
		SET performance = "Not Achieving Any Goals";
	ELSE
		BEGIN
			SET performance = "INVALID";
		END;
END CASE;
SELECT performance;
END &&
DELIMITER ;

CALL searched_case_performance_review("E620",@performance);
CALL searched_case_performance_review("E245",@performance);
CALL searched_case_performance_review("E260",@performance);
CALL searched_case_performance_review("E640",@performance);
CALL searched_case_performance_review("E204",@performance);

/*
Loops in Stored Procedures:
	-- Loops, also known as iterative control statements, are a programming structure that repeats a set of instructions 
    until a specific condition is satisfied.
    -- They are crucial for saving time and reducing errors.
There are three types of loops supported by MySQL:
	-- LOOP:
		-- Executes one or more statements repeatedly for an infinite number of times.
	-- REPEAT:
		-- Executes one or more statements repeatedly until a condition is satisfied.
	-- WHILE :
		-- Executes one or more statements repeatedly as long as a condition is TRUE.
*/
/* LOOP Statement:
	-- DEFINITION: Executes one or more statements repeatedly for an infinite number of times.
    -- FUNCTIONALITY: Extends the functionality of IF statement.
*/
/*
LOOP Statement: Example
	-- Problem Statement: Your manager expects you to write a simple infinite loop in MySQL that counts even integers and adds 
    them one after the other in a string separated by a comma.
	-- Objective: Create a stored procedure with a simple infinite loop in MySQL that counts even integers from 1 and adds 
    them one after the other in a string separated by a comma.
*/
DELIMITER &&
CREATE PROCEDURE InfiniteEvenLoop()
BEGIN
DECLARE num INT;
DECLARE msg VARCHAR(100);
SET num = 1;
SET msg = "";
loop_label: LOOP
	SET num = num + 1;
    IF (num MOD 2) THEN
		ITERATE loop_label;
	ELSE
		SET msg = CONCAT(msg, num, ',');
	END IF;
END LOOP;
SELECT msg;
END &&
DELIMITER ;

-- CALL InfiniteEvenLoop();

/*
WHILE Loop:
	-- DEFINITION: Executes one or more statements repeatedly as long as a condition is TRUE.
    -- FUNCTIONALITY: Also known as a pretest loop because it checks the search condition before executing the statement(s).
*/
/*
WHILE Loop: Example
	-- Problem Statement: Your manager expects you to write a loop in MySQL that counts integers till 10 and adds them one 
    after the other in a string separated by a comma.
	-- Objective: Create a stored procedure with a while loop in MySQL that counts integers till 10 and adds them one after 
    the other in a string separated by a comma
*/
DELIMITER &&
CREATE PROCEDURE while_loop()
BEGIN
	DECLARE num INT;
	DECLARE msg VARCHAR(100);
	SET num = 1;
    SET msg = "";
WHILE num <= 10 DO
	SET msg = CONCAT(msg, num, ",");
    SET num = num + 1;
END WHILE;
SELECT msg;
END &&
DELIMITER ;

CALL while_loop();

/*
REPEAT Loop:
	-- DEFINITION: Executes one or more statements repeatedly until a condition is satisfied.
    -- FUNCTIONALITY: Also known as a post-test loop because it checks the search condition after the execution of the 
    statement(s)
*/
/*
REPEAT Loop: Example
	-- Problem Statement: Your manager expects you to write a loop in MySQL that counts integers till 10 and adds them one 
    after the other in a string separated by a comma.
	-- Objective: Create a stored procedure with a repeat loop in MySQL that counts integers till 10 and adds them one after 
    the other in a string separated by a comma.
*/
DELIMITER &&
CREATE PROCEDURE repeat_loop()
BEGIN
DECLARE num INT DEFAULT 0;
DECLARE msg VARCHAR(100) DEFAULT "";
REPEAT
	SET msg = CONCAT(msg, num, ",");
    SET num = num + 1;
UNTIL num > 10
END REPEAT;
SELECT msg;
END &&
DELIMITER ;

CALL repeat_loop();

/* Terminating Stored Procedures and Loops */
/* LEAVE Statement:
	-- The LEAVE statement is used to exit a flow control which has a specific label, such as stored programs or loops.
*/
/* Using LEAVE With Stored Procedure:
	-- A LEAVE statement is used to terminate a stored procedure or function.
*/
/*
Using LEAVE With Stored Procedure: Example
-- Problem Statement: The HR department wants to find the employees with a rating above 3 along with their basic information.
-- Objective: Create a stored procedure for the basic information of an employee only if the rating is above 3.
*/
DELIMITER &&
CREATE PROCEDURE GoodEmployee(IN eid VARCHAR(10))
sp: BEGIN
DECLARE rating INT DEFAULT 0;
SELECT EMP_RATING INTO rating
FROM hr_data
WHERE EMP_ID = eid;
IF rating < 3
THEN LEAVE sp;
END IF;
SELECT EMP_ID, FIRST_NAME, LAST_NAME, DEPARTMENT, SALARY
FROM hr_data
WHERE EMP_ID = eid;
END &&
DELIMITER ;

CALL GoodEmployee('E245');

/* Using LEAVE With LOOP Statement:
	-- The LEAVE statement is used in a LOOP statement when a set of statements needs to be executed at least once before 
    the termination of the loop.
*/
/*
Using LEAVE With LOOP Statement: Example
	-- Problem Statement: Your manager expects you to write a simple infinite loop in MySQL that counts even integers to add 
    them one after the other in a string separated by a comma and terminate when the integer exceeds 10.
	-- Objective: Create a stored procedure with a simple infinite LOOP in MySQL that counts even integers till 10 and adds 
    them one after the other in a string separated by a comma, terminating the loop when the integer count exceeds 10
*/

DROP PROCEDURE IF EXISTS EvenLoop;
DELIMITER &&
CREATE PROCEDURE EvenLoop()
BEGIN
DECLARE num INT DEFAULT 0;
DECLARE msg VARCHAR(100) DEFAULT '';
loop_label: LOOP
	IF num > 10 THEN
		LEAVE loop_label;
    END IF;
SET num = num + 1;
IF (num MOD 2) THEN
	ITERATE loop_label;
ELSE
	SET msg = CONCAT(msg, num, ',');
END IF;
END LOOP loop_label;
SELECT msg;
END &&
DELIMITER ;

CALL EvenLoop();

/* Using LEAVE With WHILE Loop 
	-- A LEAVE statement is used to terminate a WHILE loop when a specific condition is satisfied before its loop condition 
    becomes FALSE.
*/
/* 
Using LEAVE With WHILE Loop: Example
	-- Problem Statement: Your manager expects you to write a loop in MySQL that produces the sum of first 20 even integers.
	-- Objective: Create a stored procedure with a WHILE Loop in MySQL that counts first 20 even integers and adds them one 
    by one, terminating the loop when the integer count exceeds the 20th even integer and return the sum.
*/
DROP PROCEDURE IF EXISTS EvenLoopWhile;

DELIMITER &&
CREATE PROCEDURE EvenLoopWhile()
BEGIN
DECLARE num INT DEFAULT 0;
DECLARE sum INT DEFAULT 0;
while_label: WHILE num < 20 DO
	IF num > 20 THEN
		LEAVE while_label;
	END IF;
    SET sum = sum + 2;
    SET num = num + 1;
END WHILE while_label;
SELECT SUM;
END &&
DELIMITER ;

CALL EvenLoopWhile();

/* Using LEAVE With REPEAT Loop:
	-- A LEAVE statement is used to terminate a REPEAT loop when a specific condition is satisfied before its loop condition 
    becomes TRUE.
*/
/*
Using LEAVE With WHILE Loop: Example
	-- Problem Statement: Your manager expects you to write a loop in MySQL that produces the sum of first 20 even integers.
	-- Objective: Create a stored procedure with a REPEAT Loop in MySQL that counts first 20 even integers and adds them one by 
    one, terminating the loop when the integer count exceeds the 20th even integer and return the sum.
*/
DROP PROCEDURE IF EXISTS EvenLoopRepeat;

DELIMITER &&
CREATE PROCEDURE EvenLoopRepeat()
BEGIN
DECLARE num INT DEFAULT 0;
DECLARE sum INT DEFAULT 0;
repeat_label: REPEAT
	SET sum = sum + 2;
    SET num = num + 1;
    IF num > 20 THEN
		LEAVE repeat_label;
    END IF;
UNTIL num > 20
END REPEAT repeat_label;
SELECT sum;
END &&
DELIMITER ;

CALL EvenLoopRepeat();

/* Error Handling in Stores Prpcedures */
	-- Modifying the flow of code is known as error handling. 
    -- When an error occurs, you either continue or exit the current execution.
    -- When an error occurs, you must ensure that there is an error message displayed.
    -- Handlers refer to code that performs specified actions when an error occurs.
-- CONTINUE: 
	-- Code continues to execute after error instance.
-- EXIT:
	-- Code terminates execution from the point of error.
-- MySQL error code handler, SQLSTATE error handler, and SQLEXCEPTION handler are ranked first, second, and third.

/*
Error Handling (Continue): Example 
	-- Problem Statement: You are a junior DB administrator in your organization. The HR wants to extract distinct employee data 
    that is ordered by department and employee ID. HR also wants to extract distinct department names. 
	-- Objective: Create a stored procedure to extract these requirements. Also, create an error handler that continues to 
    execute in case of any wrong data input
*/
DELIMITER &&
CREATE PROCEDURE GetTable()
BEGIN
	DECLARE CONTINUE HANDLER FOR SQLSTATE '42S02'
    SELECT 'SQLSTATE - Handler - Table not found' AS msg;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
		GET DIAGNOSTICS CONDITION 1
        @sqlstate = returned_sqlstate,
        @errno = mysql_errno,
        @text = message_text;
	SET @full_error = CONCAT("SQLEXCEPTION Handler - ERROR", @errno, " (", @sqlstate, "): ", @text);
    SELECT @full_error AS msg;
END;
SELECT DISTINCT(ROLE) FROM hr_datas
ORDER BY DEPARTMENT, EMP_ID;
SELECT DISTINCT DEPARTMENT FROM hr_data;
END &&
DELIMITER ;

CALL GetTable();

/*
Error Handling (Exit): Example
	-- Problem Statement: You are a junior DB administrator in your organization. The HR wants to extract distinct employee 
    data that is ordered by department and employee ID. HR also wants to extract distinct department names. 
	-- Objective: Create a stored procedure to extract these requirements. Also, create an error handler that will exit 
    to execute in case of any wrong data input.
*/
DELIMITER &&
CREATE PROCEDURE GetTableorExit()
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			GET DIAGNOSTICS CONDITION 1
            @sqlstate = returned_sqlstate,
            @errno = mysql_errno,
            @text = message_text;
	SET @full_error = CONCAT("SQLEXCEPTION Handler - ERROR", " (" , @sqlstate, "): ", @text);
    SELECT @full_error AS msg;
    END;
-- MySQL Query 1
SELECT DISTINCT ROLE FROM hr_datas
ORDER BY DEPARTMENT, EMP_ID;
-- MySQL Query 2
SELECT DISTINCT DEPARTMENT FROM hr_data;
END &&
DELIMITER ;

CALL GetTableorExit();

/* Error Handling:
	-- SIGNAL and RESIGNAL statements are used to raise error conditions inside stored procedures.
Signal Statement:
	-- Used to return an error or warning to the caller from a stored program.
Resignal Statement:
	-- Used to raise a warning or error in terms of functionality and syntax.
*/
/*
SIGNAL Statement:
	-- SIGNAL statement provides control over information for returning value and message SQLSTATE. SQLSTATE is a code that 
    identifies SQL error conditions.
    -- The condition_information_item_name can be MESSAGE_TEXT, MYSQL_ERRORNO, or CURSOR_NAME.
*/
/*
Error Handling (Signal): Example
	-- Problem Statement: You are a junior DB administrator in your organization. The HR wants to extract the employees 
    reporting to a manager.
	-- Objective: Create a stored procedure to extract this requirement and indicate error if there are no employees reporting.
*/
DELIMITER &&
CREATE PROCEDURE GetEmpRecords(IN mid VARCHAR(10))
BEGIN
DECLARE ecount INT DEFAULT 0;
SELECT COUNT(EMP_ID) INTO ecount
FROM hr_data
WHERE MANAGER_ID = mid;
IF ecount < 1 THEN
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = "No Reporting Employees Found!!";
END IF;
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT
FROM hr_data
WHERE MANAGER_ID = mid;
SELECT ecount;
END &&
DELIMITER ;

CALL GetEmpRecords('E103');
CALL GetEmpRecords('E583');

/*
RESIGNAL Statement:
	-- RESIGNAL is similar to the SIGNAL statement, in terms of functionality and syntax.
	-- It must be used within an error handler; else you will receive an error message RESIGNAL when the handler is not active.
    -- All the attributes of the RESIGNAL statement can be omitted.
*/
/*
Error Handling (Resignal): Example 
	-- Problem Statement: You are a junior DB administrator in your organization. The HR wants to extract the employees 
    reporting to a manager.
	-- Objective: Create a stored procedure to extract this requirement and indicate an error if no employees are reporting 
    and customize the error using resignal.
*/
DELIMITER &&
CREATE PROCEDURE GetEmpRecords2(IN mid VARCHAR(10))
BEGIN
DECLARE ecount INT DEFAULT 0;
DECLARE MANAGER_WITHOUT_TEAM CONDITION FOR SQLSTATE '45000';
DECLARE CONTINUE HANDLER FOR MANAGER_WITHOUT_TEAM
RESIGNAL SET MESSAGE_TEXT = "No Reporting Employees Found!!";
SELECT COUNT(EMP_ID) INTO ecount
FROM hr_data
WHERE MANAGER_ID = mid;
IF ecount<1 THEN
	SIGNAL MANAGER_WITHOUT_TEAM;
ELSE
	SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT
    FROM hr_data
    WHERE MANAGER_ID = mid;
END IF;
SELECT ecount;
END &&
DELIMITER ;

CALL GetEmpRecords2('E083');
CALL GetEmpRecords('E052');

/* Assisted Practice: Error Handling:
	-- Problem Statement: Declare an error handler in MySQL to handle errors encountered in stored procedures due to duplication 
    of primary keys.
*/
-- 1. Create a table named dataproject with columns named emp_id and project_id.
CREATE TABLE IF NOT EXISTS dataproject (
project_id INT NOT NULL,
emp_id INT NOT NULL,
PRIMARY KEY(emp_id)
);
-- 2. Insert values in the dataproject table.
INSERT INTO dataproject VALUES 
(90,1),
(91,2),
(92,3),
(93,4),
(94,5),
(95,6);
-- 3. Create a stored procedure named product, and declare the EXIT handler for MySQL
DROP PROCEDURE IF EXISTS Product;
DELIMITER &&
CREATE PROCEDURE PRODUCT(IN inprojectid INT, IN inempid INT)
BEGIN
DECLARE EXIT HANDLER FOR 1062
SELECT "Duplicate Keys Error Encountered" AS MESSAGE;
INSERT INTO dataproject VALUES (inprojectid,inempid);
SELECT COUNT(*) FROM dataproject
WHERE project_id = inprojectid;
END &&
DELIMITER ;

CALL PRODUCT(96,7);

/*
Cursors in Stored Procedures:
	-- A database cursor is a control structure that allows users to access records in a database.
    -- Database programmers utilize cursors to process individual rows returned by database system queries
Functions of cursors:
	-- Enabling manipulation
    -- Performing complex operations
    -- Returning to client application
Steps to use cursors:
	-- Declaration, Opening, Data fetching, Closing
*/
/*
Problem Statement
	-- Problem Scenario: You are working as a junior database administrator. Your manager has asked you to perform different 
    operations using cubes on the project_details table with the schema named as sys. 
	-- Objective: You are required to extract the first record of the project_details table using CUBES, where status is marked 
    as DONE.
*/
DELIMITER &&
CREATE PROCEDURE abcd()
BEGIN
DECLARE a VARCHAR(255);
DECLARE b VARCHAR(255);
DECLARE cursor_1 CURSOR FOR 
SELECT status, proj_name FROM proj_data
WHERE status = 'Done';
OPEN cursor_1;
REPEAT FETCH cursor_1 INTO a,b;
UNTIL b = 0
END REPEAT;
SELECT a AS status, b AS name;
CLOSE cursor_1;
END &&
DELIMITER ;

CALL abcd();

/* 
Stored Functions in Stored Procedures:
	-- A stored function is a stored program that returns a single value.
    -- It is a subroutine that may be accessed by programs that use a relational database management system.
*/
DELIMITER &&
CREATE FUNCTION no_of_years(date1 DATE)
RETURNS INT DETERMINISTIC
BEGIN
DECLARE date2 DATE;
SELECT CURRENT_DATE() INTO date2;
RETURN YEAR(date2) - YEAR(date1);
END &&
DELIMITER ;

SELECT no_of_years("1994-03-29");

-- Syntax for listing stored function using the data dictionary:

SELECT 
routine_name
FROM
information_schema.routines
WHERE
routine_type = 'FUNCTION'
AND routine_schema = 'simplilearn';

/*
Problem Statement
	-- Problem Scenario: You are a junior database administrator. Your manager has asked you to perform different operations 
    using stored function on the emp_details table with the schema named as sys. 
	 -- Objective: You are required to extract the first and last names, department, and designation based on the experience 
     of the employees.
*/
DELIMITER &&
CREATE FUNCTION emp_details(experience INT)
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
DECLARE emp_designation VARCHAR(255);
IF experience > 0 AND experience <=2 THEN
	SET emp_designation = "Junior Data Scientist";
ELSEIF experience > 2 AND experience <= 5 THEN
	SET emp_designation = "Associate Data Scientist";
ELSEIF experience > 5 AND experience <= 10 THEN
	SET emp_designation = "Senior Data Scientist";
ELSEIF experience > 10 AND experience <= 12 THEN
	SET emp_designation = "Lead Data Scientist";
ELSEIF experience > 12 THEN
	SET emp_designation = "Manager";
END IF;
RETURN emp_designation;
END &&
DELIMITER ;

SELECT FIRST_NAME, LAST_NAME, DEPARTMENT, EXPERIENCE, emp_details(EXPERIENCE) AS DESIGNATION
FROM hr_data;

/*
Stored Object Access Control:
	-- MySQL uses DEFINER and SQL SECURITY characteristics to control the privileges that apply to the execution of a stored 
    object.
    -- You can specify the DEFINER attribute, which is the name of a MySQL account, when defining a stored routine such as a 
    stored procedure or function.
    -- An SQL SECURITY clause with a value of DEFINER or INVOKER can be used in stored routines (stored procedures and 
    functions) and views.
    -- The object definition can include an SQL SECURITY characteristic with a value of DEFINER or INVOKER to specify whether 
    the object executes in definer or invoker context.
*/
/*
Use Case for Stored Object Access Control:
	-- Problem Scenario:
		-- Consider a senior DBA wants to create a stored procedure and a new user named junior DBA with access to perform 
        operations on the securitydb database.
	-- Objective:
		-- The senior DBA is required to create a stored procedure, a new user named junior DBA, and grant access to the 
        junior DBA with the help of DEFINER and INVOKER.
Instructions: 
Create a new securitydb database and a new projectdetails table to perform the above objectives
*/

-- 1. create a database securitydb
CREATE DATABASE securitydb;
USE securitydb;

-- 2. create table projectdetails
CREATE TABLE projectdetails (
id INT AUTO_INCREMENT,
message VARCHAR(100) NOT NULL,
PRIMARY KEY(id)
);

-- 3. Create a stored procedure using DEFINER
DELIMITER &&
CREATE DEFINER = root@localhost PROCEDURE InsertsMessages(IN msg VARCHAR(100))
SQL SECURITY DEFINER
BEGIN
INSERT INTO projectdetails (message) VALUES (msg);
END &&
DELIMITER ;

-- 4. create new user junior
CREATE USER junior@localhost
IDENTIFIED BY 'junior123';

-- 5. grant access for new user
GRANT EXECUTE ON securitydb.*
TO junior@localhost;

-- 6. create a stored procedure using INVOKER
DELIMITER &&
CREATE DEFINER = root@localhost PROCEDURE UpdateMessage(IN msgID INT, IN msg VARCHAR(100))
SQL SECURITY INVOKER
BEGIN
UPDATE projectdetails
SET message = msg
WHERE id = msgID;
END &&
DELIMITER ;

CALL InsertsMessages("Hi, My Name is Alex");
CALL InsertsMessages("Hi, My Name is Alfred");

SELECT * FROM projectdetails;

CALL UpdateMessage(1, "Alex");

/*
SQL Triggers:
	-- When a specific change operation (SQL INSERT, UPDATE, or DELETE statement) is done on a specific table, a trigger is 
    executed automatically. It is a collection of actions.

There are two types of triggers:
	-- Data Definition Language (DDL) command events that begin with Create, Alter, or Drop, such as Create table, Create view,
    Drop table, Drop view, and Alter table, fire the DDL triggers.
    -- DML triggers are activated when Data Manipulation Language (DML) command events begin with Insert, Update, or Delete. 
    Insert table, Update view, and Delete table are examples of such functions

Triggers can be used to:
	-- 1. Enforce business rules
    -- 2. Validate input data
    -- 3. Create a unique value for a newly entered row in another file
    -- 4. Write to additional files for auditing
    -- 5. Perform a cross-reference query from other files
    -- 6. Achieve data consistency, putting duplicate data to separate files
*/ 
/*
Use Case for Triggers
	-- Problem Scenario: Consider an HR of a company wants to update the salary of employees based on their experience using 
    triggers.
	-- Objective: You are required to retrieve the employee ID, first name, role, experience, and salary by creating a 
    trigger to update the salary of the employee to 20000 if the years of experience are greater than 15.
	Instructions: Refer to the payroll dataset given in the course resource section in LMS to create a payroll table using 
    fields mentioned in the dataset and insert the values accordingly to perform the above objectives.
*/

DELIMITER &&
CREATE TRIGGER Salary_Update
BEFORE INSERT ON hr_data
FOR EACH ROW
IF NEW.EXPERIENCE > 15 THEN
	SET NEW.SALARY = 20000;
END IF;
END &&
DELIMITER ;

DROP TRIGGER Salary_Update;













