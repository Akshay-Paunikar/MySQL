CREATE DATABASE employees_management;
USE employees_management;

-- Create Department Table
CREATE TABLE department (
code INT PRIMARY KEY NOT NULL,
name VARCHAR(255) NOT NULL,
budget DECIMAL NOT NULL 
);

-- Insert data
INSERT INTO department(code, name, budget) VALUES
(14,'IT',65000),
(37,'Accounting',15000),
(59,'Human Resources',240000),
(77,'Research',55000);

-- Create Employee Table
CREATE TABLE employee (
SSN INT NOT NULL,
name VARCHAR(255) NOT NULL,
lastname VARCHAR(255) NOT NULL,
department INT NOT NULL,
FOREIGN KEY(department) REFERENCES department(code)
)ENGINE = InnoDB; 

-- Insert data
INSERT INTO employee(SSN, name, lastname, department) VALUES
('123234877','Michael','Rogers',14),
('152934485','Anand','Manikutty',14),
('222364883','Carol','Smith',37),
('326587417','Joe','Stevens',37),
('332154719','Mary-Anne','Foster',14),
('332569843','George','O''Donnell',77),
('546523478','John','Doe',59),
('631231482','David','Smith',77),
('654873219','Zacary','Efron',59),
('745685214','Eric','Goldsmith',59),
('845657245','Elizabeth','Doe',14),
('845657246','Kumar','Swamy',14);

/*************************************************************************************************************************/
-- 1. Select the last name of all employees.
SELECT lastname FROM employee;

-- 2. Select the last name of all employees, without duplicates.
SELECT DISTINCT(lastname) FROM employee;

-- 3. Select all the data of employees whose last name is "Smith".
SELECT * FROM employee
WHERE lastname = "Smith";

-- 4. Select all the data of employees whose last name is "Smith" or "Doe".
SELECT * FROM employee
WHERE lastname = "Smith" OR lastname = "Doe";

SELECT * FROM employee
WHERE lastname IN ("Smith", "Doe");

-- 5. Select all the data of employees that work in department 14.
SELECT * FROM employee
WHERE department = 14;

SELECT * FROM employee
WHERE department IN (14);

-- 6. Select all the data of employees that work in department 37 or department 77.
SELECT * FROM employee
WHERE department = 37 OR department = 77;

SELECT * FROM employee
WHERE department IN (37, 77);

-- 7. Select all the data of employees whose last name begins with an "S".
SELECT * FROM employee
WHERE lastname LIKE 'S%';

-- 8. Select the sum of all the departments' budgets.
SELECT SUM(budget) FROM department;

-- 9. Select the number of employees in each department (you only need to show the department code and the number of employees).
SELECT department, COUNT(*) FROM employee
GROUP BY department;

-- 10. Select all the data of employees, including each employee's department's data.
SELECT * FROM employee AS E
INNER JOIN department AS D
ON E.department = D.code;

-- 11. Select the name and last name of each employee, along with the name and budget of the employee's department.
SELECT E.name, E.lastname, D.name, D.budget
FROM employee AS E
INNER JOIN department AS D
ON E.department = D.code;

-- 12. Select the name and last name of employees working for departments with a budget greater than $60,000.
SELECT E.name, E.lastname FROM employee AS E
INNER JOIN department AS D
ON E.department = D.code
WHERE D.budget > 60000;

SELECT E.name, E.lastname FROM employee AS E
INNER JOIN department AS D
ON E.department = D.code
AND D.budget > 60000;

SELECT name, lastname FROM employee
WHERE department IN (
	SELECT code FROM department WHERE budget > 60000
);

-- 13. Select the departments with a budget larger than the average budget of all the departments.
SELECT name, budget FROM department
GROUP BY name
HAVING budget > (
	SELECT AVG(budget) FROM department
);

SELECT * FROM department
WHERE budget > (
	SELECT AVG(budget) FROM department
);

-- 14. Select the names of departments with more than two employees.
SELECT name FROM department AS D
WHERE 2 < (
	SELECT COUNT(*) FROM employee AS E
    WHERE E.department = D.code
);

SELECT name FROM department
WHERE code IN (
	SELECT department FROM employee
    GROUP BY department
    HAVING COUNT(*) > 2
);

SELECT D.name FROM employee AS E
INNER JOIN department AS D
ON E.department = D.code
GROUP BY D.name
HAVING COUNT(*) > 2;

-- 15. Select the name and last name of employees working for departments with second lowest budget.
SELECT E.name, E.lastname FROM employee AS E
WHERE E.department = (
	SELECT D1.code FROM(
		SELECT * FROM department ORDER BY budget LIMIT 2
    ) AS D1 ORDER BY D1.budget DESC LIMIT 1
);

SELECT E.name, E.lastname FROM employee AS E
WHERE E.department = (
	SELECT code FROM Department 
    GROUP BY code
    ORDER BY budget ASC LIMIT 1 OFFSET 1 
);

-- 16. Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. Add an employee 
-- called "Mary Moore" in that department, with SSN 847-21-9811.
INSERT INTO department(code, name, budget) VALUES(11, "Quality Assurance", 40000);
INSERT INTO employee(SSN, name, lastname, department) VALUES('847219811', 'Mary', 'Moore', 11);

-- 17. Reduce the budget of all departments by 10%.
UPDATE department
SET budget = budget * 0.9;

-- 18. Reassign all employees from the Research department (code 77) to the IT department (code 14).
UPDATE employee
SET department = 14
WHERE department = 77;

-- 19. Delete from the table all employees in the IT department (code 14).
DELETE FROM employee
WHERE department = 14;

-- 20. Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
DELETE FROM employee
WHERE department IN (
	SELECT code FROM department WHERE budget >= 60000
);

-- 21. Delete from the table all employees.
TRUNCATE employee;
DELETE FROM department;

describe department;



