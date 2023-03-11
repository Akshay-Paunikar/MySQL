CREATE DATABASE planetexpress;
USE planetexpress;

CREATE TABLE employee (
employeeid INT PRIMARY KEY NOT NULL,
name VARCHAR(255) NOT NULL,
position VARCHAR(255) NOT NULL,
salary REAL NOT NULL,
remarks VARCHAR(255)
)ENGINE=InnoDB;

INSERT INTO employee(employeeid, name, position, salary, remarks) VALUES
(1, 'Phillip J. Fry', 'Delivery boy', 7500.0, 'Not to be confused with the Philip J. Fry from Hovering Squid World 97a'),
(2, 'Turanga Leela', 'Captain', 10000.0, NULL),
(3, 'Bender Bending Rodriguez', 'Robot', 7500.0, NULL),
(4, 'Hubert J. Farnsworth', 'CEO', 20000.0, NULL),
(5, 'John A. Zoidberg', 'Physician', 25.0, NULL),
(6, 'Amy Wong', 'Intern', 5000.0, NULL),
(7, 'Hermes Conrad', 'Bureaucrat', 10000.0, NULL),
(8, 'Scruffy Scruffington', 'Janitor', 5000.0, NULL);

CREATE TABLE planet (
planetid INT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
coordinates REAL NOT NULL
)ENGINE=InnoDB;

INSERT INTO planet (planetid, name, coordinates) VALUES
(1, 'Omicron Persei 8', 89475345.3545),
(2, 'Decapod X', 65498463216.3466),
(3, 'Mars', 32435021.65468),
(4, 'Omega III', 98432121.5464),
(5, 'Tarantulon VI', 849842198.354654),
(6, 'Cannibalon', 654321987.21654),
(7, 'DogDoo VII', 65498721354.688),
(8, 'Nintenduu 64', 6543219894.1654),
(9, 'Amazonia', 65432135979.6547);

CREATE TABLE shipment (
shipmentid INT PRIMARY KEY,
date DATE,
manager INT NOT NULL,
planet INT NOT NULL,
FOREIGN KEY(manager) REFERENCES employee(employeeid),
FOREIGN KEY(planet) REFERENCES planet(planetid)
)ENGINE=InnoDB;

INSERT INTO shipment (shipmentid, date, manager, planet) VALUES 
(1, '3004/05/11', 1, 1),
(2, '3004/05/11', 1, 2),
(3, NULL, 2, 3),
(4, NULL, 2, 4),
(5, NULL, 7, 5);

CREATE TABLE has_clearance (
employee INT NOT NULL,
planet INT NOT NULL,
level INT NOT NULL,
FOREIGN KEY(employee) REFERENCES employee(employeeid),
FOREIGN KEY(planet) REFERENCES planet(planetid)
)ENGINE=InnoDB;

INSERT INTO has_clearance (employee, planet, level) VALUES
(1, 1, 2),
(1, 2, 3),
(2, 3, 2),
(2, 4, 4),
(3, 5, 2),
(3, 6, 4),
(4, 7, 1);

CREATE TABLE client (
accountnumber INT PRIMARY KEY,
name VARCHAR(255) NOT NULL
)ENGINE=InnoDB;

INSERT INTO client (accountnumber, name) VALUES
(1, 'Zapp Brannigan'),
(2, "Al Gore's Head"),
(3, 'Barbados Slim'),
(4, 'Ogden Wernstrom'),
(5, 'Leo Wong'),
(6, 'Lrrr'),
(7, 'John Zoidberg'),
(8, 'John Zoidfarb'),
(9, 'Morbo'),
(10, 'Judge John Whitey'),
(11, 'Calculon');

CREATE TABLE package (
shipment INT NOT NULL,
packagenumber INT NOT NULL,
contents VARCHAR(255) NOT NULL,
weight REAL NOT NULL,
sender INT NOT NULL,
recipient INT NOT NULL,
PRIMARY KEY (shipment, packagenumber),
FOREIGN KEY (shipment) REFERENCES shipment(shipmentid),
FOREIGN KEY (sender) REFERENCES client(accountnumber),
FOREIGN KEY (recipient) REFERENCES client(accountnumber)
)ENGINE=InnoDB;

INSERT INTO package (shipment, packagenumber, contents, weight, sender, recipient) VALUES
(1, 1, 'Undeclared', 1.5, 1, 2),
(2, 1, 'Undeclared', 10.0, 2, 3),
(2, 2, 'A bucket of krill', 2.0, 8, 7),
(3, 1, 'Undeclared', 15.0, 3, 4),
(3, 2, 'Undeclared', 3.0, 5, 1),
(3, 3, 'Undeclared', 7.0, 2, 3),
(4, 1, 'Undeclared', 5.0, 4, 5),
(4, 2, 'Undeclared', 27.0, 1, 2),
(5, 1, 'Undeclared', 100.0, 5, 1);

-- 1. Who received a 1.5kg package?
SELECT C.name FROM client AS C
INNER JOIN package AS P
ON C.accountnumber = P.recipient
WHERE P.weight = 1.5;

-- 2 What is the total weight of all the packages that he sent?
SELECT SUM(P.weight) FROM package AS P
INNER JOIN client AS C
ON P.sender = C.accountnumber
WHERE name = "Al Gore's Head";

-- 3. Which pilots transported those packages?
SELECT E.name FROM employee AS E
INNER JOIN shipment AS S
ON E.employeeid = S.manager
INNER JOIN package AS P
ON S.shipmentid = P.shipment
WHERE S.shipmentid IN (
	SELECT P.shipment FROM package AS P
    INNER JOIN client AS C
    ON P.sender = C.accountnumber
    WHERE C.accountnumber = (
	SELECT C.accountnumber FROM client AS C
	INNER JOIN package AS P
    ON C.accountnumber = P.recipient
    WHERE P.weight = 1.5
    )
)
GROUP BY E.name;
















