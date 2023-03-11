USE simplilearn;

-- Functions in SQL --
-- Numeric Functions --
-- ABS Function --
SELECT ABS(-123.23); 

-- CEIL Function --
SELECT CEIL(121.23);

-- FLOOR Function --
SELECT FLOOR(121.34);

-- TRUNCATE FUNCTION --
SELECT TRUNCATE(121.369,2);

-- MOD Function --
SELECT MOD(8,3);

SELECT Round(Profit, 1) as Profit_per_delivery_Round_off, Format(Profit, 3) as 
Profit_per_delivery_Format, Truncate(Profit,2) as Profit_per_delivery_Truncate, ABS(Profit) 
as Profiit_per_delivery_Absolute_Value, Ceil(Profit) as Profiit_per_delivery_Ceiling, 
Floor(Profit) as Profiit_per_delivery_Floor
FROM superstore;

SELECT Sales, Quantity, Discount, Profit,TRUNCATE((MOD(profit,(sales-profit+Discount))*100),2) as 
Profit_percentage
FROM superstore;

CREATE TABLE bill (
S_No INT NOT NULL,
Name VARCHAR(255) NOT NULL,
AMOUNT DECIMAL NOT NULL
) ENGINE=InnoDB;

INSERT INTO bill VALUES
(1, 'Oliver', 2753.3491),
(2, 'George', 2532.4082), 
(3, 'Arthur', 2021.5541), 
(4, 'Muhammad', 1934.9436), 
(5, 'Leo', 1846.2651), 
(6, 'Jack', 1244.0034), 
(7, 'Harry', 1187.0017);

SELECT * FROM bill;

SELECT ROUND(amount,2)
FROM bill;

SELECT CEIL(amount)
FROM bill;

SELECT FLOOR(amount)
FROM bill;

-- DATE & TIME FUNCTIONS --
SELECT DATE('2013-02-12 01:02:03');

SELECT TIME('2013-02-12 01:02:03');

SELECT EXTRACT(YEAR_MONTH FROM '2019-07-02 01:02:03');

SELECT DATE_FORMAT('2007-10-04 22:23:00', '%H:%i:%s');

-- Handling Duplicate Records --

SELECT COUNT(DISTINCT(category)) AS Unique_Category
FROM superstore;

SELECT category, SUM(Sales) AS Total_sales,
SUM(profit) as Total_profit, COUNT(*) as Total_counts
FROM superstore
GROUP BY category;

SELECT city, AVG(sales) AS Avg_Sales, AVG(profit) AS Avg_Profit, count(*) as counts
FROM superstore
GROUP BY city
HAVING AVG(Profit)>0;

-- Coalesce function -- 
/* Coalesce function returns the first non-null value from a list of expressions.*/
SELECT COALESCE(NULL,'121','AAA',NULL);

SELECT ISNULL(OrderDate) AS Check_Null, IFNULL(OrderDate,"Missing") AS Missing_Date
FROM superstore;

SELECT Convert(Quantity, Decimal(10,2)) as Decimal_Conversion, Profit, 
IF(Profit<0, 'LOSS', 'Profit') as Profit_LOSS
FROM superstore;
 
-- ASCII function --
-- returns the ASCII value of the specified character.
SELECT ASCII('A');
SELECT ASCII(CustomerName) as ASCII_CODE
From simplilearn.superstore;

-- Version function --
-- returns the current version of the MySQL database --
SELECT VERSION();

-- Session user function 
-- returns the current username and host name for the MySQL connection
SELECT SESSION_USER();
 



 








