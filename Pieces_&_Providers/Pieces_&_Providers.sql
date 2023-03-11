CREATE DATABASE pieces_and_providers;
USE pieces_and_providers;

CREATE TABLE pieces (
code INT PRIMARY KEY NOT NULL,
name VARCHAR(255) NOT NULL
);

INSERT INTO pieces (code, name) VALUES
(1,'Sprocket'),
(2,'Screw'),
(3,'Nut'),
(4,'Bolt');

CREATE TABLE providers (
code VARCHAR(255) PRIMARY KEY NOT NULL,
name VARCHAR(255) NOT NULL
);

INSERT INTO providers (code, name) VALUES 
('HAL','Clarke Enterprises'),
('RBT','Susan Calvin Corp.'),
('TNBC','Skellington Supplies');

CREATE TABLE provides (
piece INT,
FOREIGN KEY(piece) REFERENCES pieces(code),
provider VARCHAR(255),
FOREIGN KEY(provider) REFERENCES providers(code),
price INT NOT NULL,
PRIMARY KEY(piece, provider)
);

INSERT INTO provides (piece, provider, price) VALUES
(1,'HAL',10),
(1,'RBT',15),
(2,'HAL',20),
(2,'RBT',15),
(2,'TNBC',14),
(3,'RBT',50),
(3,'TNBC',45),
(4,'HAL',5),
(4,'RBT',7);

-- 1. Select the name of all the pieces.
SELECT name FROM pieces;

-- 2. Select all the providers' data.
SELECT * FROM providers;

-- 3. Obtain the average price of each piece (show only the piece code and the average price).
SELECT piece, AVG(price) AS avg_price
FROM provides
GROUP BY piece;

-- 4. Obtain the names of all providers who supply piece 1.
SELECT PVD.name FROM providers AS PVD
INNER JOIN provides AS PS
ON PVD.code = PS.provider
WHERE PS.piece = 1;

SELECT name FROM providers
WHERE code IN (
	SELECT provider FROM provides
    WHERE piece = 1
);

-- 5. Select the name of pieces provided by provider with code "HAL".
SELECT P.name FROM pieces AS P
INNER JOIN provides AS PS
ON P.code = PS.piece
AND PS.provider = 'HAL';

SELECT name FROM pieces
WHERE code IN (
	SELECT piece FROM provides
    WHERE provider = 'HAL'
);

SELECT name FROM pieces
WHERE EXISTS (
	SELECT * FROM provides
    WHERE provider = 'HAL'
    AND piece = pieces.code
);

-- 6. For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
-- (note that there could be two providers who supply the same piece at the most expensive price).
SELECT P.name, PVD.name, PS.price
FROM pieces AS P
INNER JOIN provides AS PS
ON P.code = PS.piece
INNER JOIN providers AS PVD
ON PVD.code = PS.provider
WHERE price = (
	SELECT MAX(PS.price) FROM provides AS PS
    WHERE PS.piece = P.code
);

-- 7. Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets 
-- (code "1") for 7 cents each.
INSERT INTO provides VALUES (1, 'TNBC', 7);

-- 8. Increase all prices by one cent.
UPDATE provides
SET price = price + 1;

-- 9. Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
DELETE FROM provides
WHERE provider = 'RBT'
AND piece = 4;

-- 10. Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces (the provider should 
-- still remain in the database).
DELETE FROM provides
WHERE provider = 'RBT';

















