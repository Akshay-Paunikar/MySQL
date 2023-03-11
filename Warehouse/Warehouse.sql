CREATE DATABASE warehouse;
USE warehouse;

CREATE TABLE warehouses (
code INTEGER NOT NULL,
location VARCHAR(255) NOT NULL,
capacity INTEGER NOT NULL,
PRIMARY KEY(code)
);

INSERT INTO warehouses(code, location, capacity) VALUES
(1,'Chicago',3),
(2,'Chicago',4),
(3,'New York',7),
(4,'Los Angeles',2),
(5,'San Francisco',8);

CREATE TABLE boxes (
code VARCHAR(255) NOT NULL,
contents VARCHAR(255) NOT NULL,
value REAL NOT NULL,
warehouse INTEGER NOT NULL,
PRIMARY KEY(code),
FOREIGN KEY(warehouse) REFERENCES warehouses(code)
)ENGINE = InnoDB;

INSERT INTO boxes(code, contents, value, warehouse) VALUES
('0MN7','Rocks',180,3),
('4H8P','Rocks',250,1),
('4RT3','Scissors',190,4),
('7G3H','Rocks',200,1),
('8JN6','Papers',75,1),
('8Y6U','Papers',50,3),
('9J6F','Papers',175,2),
('LL08','Rocks',140,4),
('P0H6','Scissors',125,1),
('P2T6','Scissors',150,2),
('TU55','Papers',90,5);

-- 1. Select all warehouses.
SELECT * FROM warehouses;

-- 2. Select all boxes with a value larger than $150.
SELECT * FROM boxes WHERE value > 150;

-- 3. Select all distinct contents in all the boxes.
SELECT DISTINCT(contents) FROM boxes;

-- 4. Select the average value of all the boxes.
SELECT ROUND(AVG(value),2) AS avg_value FROM boxes;

-- 5. Select the warehouse code and the average value of the boxes in each warehouse.
SELECT W.code, AVG(B.value) AS avg_value
FROM warehouses AS W, boxes AS B
WHERE W.code = B.warehouse
GROUP BY W.code;

SELECT warehouse, AVG(value) AS avg_value FROM boxes
GROUP BY warehouse;

-- 6. Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
SELECT warehouse, AVG(value) AS avg_value FROM boxes
GROUP BY warehouse
HAVING avg_value > 150;

-- 7. Select the code of each box, along with the name of the city the box is located in.
SELECT B.code, W.location
FROM warehouses AS W, boxes AS B
WHERE W.code = B.warehouse;

SELECT B.code, W.location
FROM warehouses AS W
INNER JOIN boxes AS B
ON W.code = B.warehouse;

-- 8. Select the warehouse codes, along with the number of boxes in each warehouse. Optionally, take into account that some 
-- warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).
SELECT warehouse, COUNT(*) FROM boxes
GROUP BY warehouse;

SELECT W.code, COUNT(B.code)
FROM warehouses AS W
LEFT JOIN boxes AS B
ON W.code = B.warehouse
GROUP BY W.code;

-- 9. Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger 
-- than the warehouse's capacity).

SELECT W.code FROM warehouses AS W
WHERE capacity < (
	SELECT COUNT(*) FROM boxes AS B
    WHERE B.warehouse = W.code
);

SELECT W.code, W.capacity, COUNT(B.code) FROM warehouses AS W
JOIN boxes AS B
ON W.code = B.warehouse
GROUP BY W.code, W.capacity
HAVING COUNT(B.code) > W.capacity;

-- 10. Select the codes of all the boxes located in Chicago.
SELECT B.code, W.location
FROM warehouses AS W
RIGHT JOIN boxes AS B
ON W.code = B.warehouse
WHERE W.location = 'Chicago';

SELECT code FROM boxes
WHERE warehouse IN (
	SELECT code FROM warehouses
    WHERE location IN ('Chicago')
);

-- 11. Create a new warehouse in New York with a capacity for 3 boxes.
INSERT INTO warehouses(code, location, capacity) VALUES
(6,'New York', 3);

-- 12. Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
INSERT INTO boxes(code, contents, value, warehouse) VALUES
('H5RT','Papers',200,2);

-- 13. Reduce the value of all boxes by 15%.
UPDATE boxes
SET value = value*0.85;

-- 14. Apply a 20% value reduction to boxes with a value larger than the average value of all the boxes.
UPDATE boxes
SET boxes.value = boxes.value*0.80
WHERE boxes.code IN (
	SELECT * FROM (
		SELECT BX.code
        FROM boxes AS BX
        WHERE BX.value > (
			SELECT AVG(value)
            FROM boxes AS B
        ) 
    ) AS BXS
);

-- 15. Remove all boxes with a value lower than $100.
DELETE FROM boxes WHERE value < 100;

-- 16. Remove all boxes from saturated warehouses.
DELETE FROM boxes
WHERE warehouse IN (
	SELECT * FROM (
		SELECT code FROM warehouses
        WHERE capacity < (
			SELECT COUNT(*) FROM boxes
            WHERE warehouse = warehouses.code
        )
    ) AS BXS
);


















