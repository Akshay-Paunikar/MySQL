USE simplilearn;

CREATE TABLE IF NOT EXISTS emp_data (
Emp_ID INT NOT NULL,
Emp_F_Name VARCHAR(100),
Emp_L_Name VARCHAR(100),
Emp_Salary INT,
Emp_Location VARCHAR(50),
Emp_Annual_Bonus INT
) ENGINE = InnoDB;

INSERT INTO emp_data VALUES
(1134, 'Mark', 'Jacobs', 20000, 'California', 1500),
(1256, 'John', 'Barter', 25000, 'Texas' , 1000),
(1277, 'Michael', 'Scar', 22000, 'Los Angeles', 1000),
(1300, 'Dan', 'Harris', 30000, 'New York', 2000);

SELECT * FROM emp_data;

-- Add salary and bonus to get this months total salary --
SELECT Emp_ID, Emp_Salary, Emp_Annual_Bonus, (Emp_Salary + Emp_Annual_Bonus) AS Total_Salary
FROM emp_data;

-- Due to losses the bonus is decreased by 10%.

SELECT Emp_ID, Emp_Salary, Emp_Annual_Bonus, (Emp_Annual_Bonus *0.1) AS Reductions,
(Emp_Annual_Bonus - (Emp_Annual_Bonus *0.1)) AS Actual_Bonus, 
(Emp_Salary + (Emp_Annual_Bonus - (Emp_Annual_Bonus *0.1))) AS Total_Salary
FROM emp_data;

-- Now we are back on track so we doubled the salary keeping bonus constant, find total salary.
SELECT Emp_ID, Emp_Salary, (Emp_Salary * 2) AS new_salary, Emp_Annual_Bonus, 
((Emp_Salary*2) + Emp_Annual_Bonus) AS total_salary
FROM emp_data;

-- Due to recession the salaries are decreased by 50% or halved.
SELECT Emp_ID, Emp_Salary, ROUND((Emp_Salary/2),0) AS revised_salary, Emp_Annual_Bonus,
(ROUND((Emp_Salary/2),0) + Emp_Annual_Bonus) AS total_salary
FROM emp_data;

-- Find employees whose salary is higher than the average salary.
SELECT * FROM emp_data
WHERE Emp_Salary >= (SELECT AVG(Emp_Salary)
					FROM emp_data);

-- Find employees with salary between 20000 and 40000
SELECT * FROM emp_data
WHERE Emp_Salary BETWEEN 25000 AND 40000;

-- Employee salary GT 25000 and location is 'New York'.
SELECT * FROM emp_data
WHERE Emp_Salary > 25000
AND Emp_Location = 'New York';

-- Emp_Salary > 22000 OR Emp_Annual_Bonus < 1000
SELECT * FROM emp_data
WHERE Emp_Salary > 22000 OR Emp_Annual_Bonus < 1000;

-- Employee location not California.
SELECT * FROM emp_data
WHERE NOT Emp_Location = 'California';

-- Employee whose first name starts with 'M'
SELECT * FROM emp_data
WHERE Emp_F_Name LIKE 'M%';

-- INDEXING in MySQL --
 
CREATE TABLE IF NOT EXISTS HR_DATA (
EMP_ID VARCHAR(10) NOT NULL,
FIRST_NAME VARCHAR(100),
LAST_NAME VARCHAR(100),
GENDER VARCHAR(10),
ROLE VARCHAR(50),
DEPARTMENT VARCHAR(50),
EXPERIENCE INT,
COUNTRY VARCHAR(50),
CONTINENT VARCHAR(50),
SALARY INT,
EMP_RATING INT,
MANAGER_ID VARCHAR(10)
) ENGINE = InnoDB;

INSERT INTO HR_DATA VALUES
('E260', 'Roy', 'Collins', 'M', 'SENIOR DATA SCIENTIST', 'RETAIL', 7, 'INDIA', 'ASIA', 7000, 3, 'E583'),
('E245', 'Nian', 'Zhen', 'M', 'SENIOR DATA SCIENTIST', 'RETAIL', 6, 'CHINA', 'ASIA', 6500, 2, 'E583'),
('E620', 'Katrina', 'Allen', 'F', 'JUNIOR DATA SCIENTIST', 'RETAIL', 2, 'INDIA', 'ASIA', 3000, 1, 'E612'),
('E640', 'Jenifer', 'Jhones', 'F', 'JUNIOR DATA SCIENTIST', 'RETAIL', 1, 'COLOMBIA', 'SOUTH AMERICA', 2800, 4, 'E612'),
('E403', 'Steve', 'Hoffman', 'M', 'ASSOCIATE DATA SCIENTIST', 'FINANCE', 4, 'USA', 'NORTH AMERICA', 5000, 3, 'E103'),
('E204', 'Karene', 'Nowak', 'F', 'SENIOR DATA SCIENTIST', 'AUTOMOTIVE', 8, 'GERMANY', 'EUROPE', 7500, 5, 'E428'),
('E057', 'Dorothy', 'Wilson', 'F', 'SENIOR DATA SCIENTIST', 'HEALTHCARE', 9, 'USA', 'NORTH AMERICA', 7700, 1, 'E083'),
('E010', 'William', 'Butler', 'M', 'LEAD DATA SCIENTIST', 'AUTOMOTIVE', 12, 'FRANCE', 'EUROPE', 9000, 2, 'E428'),
('E478', 'David', 'Smith',	'M', 'ASSOCIATE DATA SCIENTIST', 'RETAIL', 3, 'COLOMBIA', 'SOUTH AMERICA', 4000, 4, 'E583'),
('E005', 'Eric', 'Hoffman', 'M', 'LEAD DATA SCIENTIST', 'FINANCE', 11, 'USA', 'NORTH AMERICA', 8500, 3, 'E103'),
('E052', 'Dianna', 'Wilson', 'F', 'SENIOR DATA SCIENTIST',	'HEALTHCARE', 6, 'CANADA', 'NORTH AMERICA', 5500, 5, 'E083'),
('E505', 'Chad', 'Wilson', 'M', 'ASSOCIATE DATA SCIENTIST', 'HEALTHCARE', 5, 'CANADA', 'NORTH AMERICA', 5000, 2, 'E083'),
('E532', 'Claire', 'Brennan', 'F', 'ASSOCIATE DATA SCIENTIST', 'AUTOMOTIVE', 3, 'GERMANY', 'EUROPE', 4300, 1, 'E428'),
('E083', 'Patrick', 'Voltz', 'M', 'MANAGER', 'HEALTHCARE', 15, 'USA', 'NORTH AMERICA', 9500, 5, 'E002'),
('E583', 'Janet', 'Hale', 'F', 'MANAGER', 'RETAIL', 14, 'COLOMBIA', 'SOUTH AMERICA', 10000, 2, 'E002'),
('E103', 'Emily', 'Grove', 'F', 'MANAGER', 'FINANCE', 14, 'CANADA', 'NORTH AMERICA', 10500, 4, 'E002'),
('E612', 'Tracy', 'Norris', 'F', 'MANAGER', 'RETAIL', 13, 'INDIA', 'ASIA', 8500, 4, 'E002'),
('E428', 'Pete', 'Allen', 'M', 'MANAGER', 'AUTOMOTIVE', 14, 'GERMANY', 'EUROPE', 11000, 4, 'E002'),
('E002', 'Cynthia', 'Brooks', 'F', 'PRESIDENT', 'ALL', 17, 'CANADA', 'NORTH AMERICA', 14500, 5, 'E001'),
('E001', 'Arthur', 'Black', 'M', 'CEO', 'ALL', 20, 'USA', 'NORTH AMERICA', 16500, 5, 'E001');

SELECT * FROM HR_DATA;

-- Find managers in the data
SELECT * FROM HR_DATA
WHERE ROLE = 'MANAGER';

EXPLAIN SELECT * FROM HR_DATA
WHERE ROLE = 'MANAGER';

CREATE INDEX INDX ON HR_DATA(ROLE);

EXPLAIN SELECT * FROM HR_DATA
WHERE ROLE = 'MANAGER';

SHOW INDEXES FROM HR_DATA;
DROP INDEX INDX ON HR_DATA;































 