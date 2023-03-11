CREATE DATABASE Computer_Store;
USE Computer_Store;

CREATE TABLE manufacturers(
code INTEGER,
name VARCHAR(255) NOT NULL,
PRIMARY KEY(code));

INSERT INTO manufacturers(code, name) VALUES
(1,'Sony'),
(2,'Creative Labs'),
(3,'Hewlett-Packard'),
(4,'Iomega'),
(5,'Fujitsu'),
(6,'Winchester');

CREATE TABLE products (
code INTEGER,
name VARCHAR(255) NOT NULL,
price DECIMAL NOT NULL,
manufacturer INTEGER NOT NULL,
PRIMARY KEY(code),
FOREIGN KEY(manufacturer) REFERENCES manufacturers(code)
)ENGINE = InnoDB;

INSERT INTO products(code, name, price, manufacturer) VALUES
(1,'Hard drive',240,5),
(2,'Memory',120,6),
(3,'ZIP drive',150,4),
(4,'Floppy disk',5,6),
(5,'Monitor',240,1),
(6,'DVD drive',180,2),
(7,'CD drive',90,2),
(8,'Printer',270,3),
(9,'Toner cartridge',66,3),
(10,'DVD burner',180,2);

-- 1. Select the names of all the products in the store.
SELECT name FROM products;

-- 2. Select the names and the prices of all the products in the store.
SELECT name, price FROM products;

-- 3. Select the name of the products with a price less than or equal to $200.
SELECT name FROM products
WHERE price <= 200;

-- 4. Select all the products with a price between $60 and $120.
SELECT * FROM products
WHERE price >= 60 AND price <= 120;

SELECT * FROM products
WHERE price BETWEEN 60 AND 120;

-- 5. Select the name and price in cents (i.e., the price must be multiplied by 100).
SELECT name, (price*100) AS price_in_cents FROM products;

-- 6. Compute the average price of all the products.
SELECT AVG(price) AS avg_price FROM products;

-- 7. Compute the average price of all products with manufacturer code equal to 2.
SELECT AVG(price) AS avg_price FROM products
WHERE manufacturer = 2;

-- 8. Compute the number of products with a price larger than or equal to $180.
SELECT COUNT(*) FROM products
WHERE price >= 180;

-- 9. Select the name and price of all products with a price larger than or equal to $180, and sort first by price 
-- (in descending order), and then by name (in ascending order).
SELECT name, price FROM products
WHERE price >= 180
ORDER BY price DESC, name ASC;

-- 10. Select all the data from the products, including all the data for each product's manufacturer.
SELECT * FROM products, manufacturers
WHERE products.manufacturer = manufacturers.code;

SELECT * FROM products
LEFT JOIN manufacturers
ON products.manufacturer = manufacturers.code;

-- 11. Select the product name, price, and manufacturer name of all the products.
SELECT P.name, P.price, M.name
FROM products AS P, manufacturers AS M
WHERE P.manufacturer = M.code;

SELECT P.name, P.price, M.name
FROM products AS P
INNER JOIN manufacturers AS M
on P.manufacturer = M.code;

-- 12. Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT manufacturer, AVG(price) AS avg_price
FROM products
GROUP BY manufacturer;

-- 13. Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT M.name, AVG(P.price) AS avg_price
FROM products AS P, manufacturers AS M
WHERE P.manufacturer = M.code
GROUP BY M.name;

SELECT M.name, AVG(P.price) AS avg_price
FROM products AS P
INNER JOIN manufacturers AS M
ON P.manufacturer = M.code
GROUP BY M.name;

-- 14. Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT M.name, AVG(P.price) AS avg_price FROM manufacturers AS M, products AS P
WHERE P.manufacturer = M.code
GROUP BY M.name
HAVING AVG(P.price) >= 150;

SELECT M.name, AVG(P.price) AS avg_price
FROM products AS P
INNER JOIN manufacturers AS M
ON P.manufacturer = M.code
GROUP BY M.name
HAVING avg_price >= 150;

-- 15. Select the name and price of the cheapest product.
SELECT name, price
FROM products
ORDER BY price ASC
LIMIT 1;

SELECT name, price
FROM products
WHERE price = (
	SELECT MIN(price) FROM products
);

-- 16. Select the name of each manufacturer along with the name and price of its most expensive product.
SELECT M.name, P.name, P.price
FROM products AS P, Manufacturers AS M
WHERE P.manufacturer = M.code
AND P.price = (
	SELECT MAX(P.price) FROM products AS P
    WHERE P.manufacturer = M.code
);

SELECT M.name, P.name, P.price
FROM products AS P
INNER JOIN manufacturers AS M
ON P.manufacturer = M.code
AND P.price = (
	SELECT MAX(P.price) FROM products AS P
    WHERE P.manufacturer = M.code
);

-- 17. Select the name of each manufacturer which have an average price above $145 and contain at least 2 different products.
SELECT M.name, AVG(P.price) AS avg_price, COUNT(P.manufacturer) AS num_products
FROM products AS P, manufacturers AS M
WHERE P.manufacturer = M.code
GROUP BY M.name, P.manufacturer
HAVING avg_price > 145 AND num_products >= 2;

-- 18. Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT INTO products(code, name, price, manufacturer) VALUES(
11, 'Loudspeakers', 70, 2
);

-- 19. Update the name of product 8 to "Laser Printer".
UPDATE products
SET name = 'Laser Printer'
WHERE code = 8;

-- 20. Apply a 10% discount to all products.
UPDATE products
SET price = price * 0.9;

-- 21. Apply a 10% discount to all products with a price larger than or equal to $120.
UPDATE products
SET price = price * 0.9
WHERE price >= 120;



















