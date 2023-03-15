CREATE DATABASE ecommerce_management;
USE ecommerce_management;

-- Creating Tables --
CREATE TABLE cart (
cart_id VARCHAR(10) NOT NULL,
PRIMARY KEY(cart_id)
)ENGINE=InnoDB;

INSERT INTO cart (cart_id) VALUES
("C012300001"),
("C012300002"),
("C012300003"),
("C012300004"),
("C012300005"),
("C012300006"),
("C012300007"),
("C012300008"),
("C012300009"),
("C012300010");

CREATE TABLE customer (
customer_id VARCHAR(10) NOT NULL,
c_pass VARCHAR(10) NOT NULL,
name VARCHAR(255) NOT NULL,
address VARCHAR(255) NOT NULL,
pincode INTEGER NOT NULL,
phone_number INTEGER NOT NULL,
cart_id VARCHAR(10) NOT NULL,
PRIMARY KEY (customer_id),
FOREIGN KEY (cart_id) REFERENCES cart(cart_id)
)ENGINE=InnoDB;

INSERT INTO customer (customer_id, c_pass, name, address, pincode, phone_number, cart_id) VALUES
("CNY0000001", "C0000001NY","Mike T", "New York", 10001, 212652138, "C012300010"),
("CNY0000002", "C0000002NY","Julie N", "New York", 10002, 315965235, "C012300009"),
("CMA0000001", "C0000001MA","Jacob S", "Massachusetts", 02301, 339023658, "C012300008"),
("CMA0000002", "C0000002MA","Lili K", "Massachusetts", 02148, 351783630, "C012300007"),
("CCA0000001", "C0000001CA","Charlie H", "California", 90011, 213452332, "C012300006"),
("CCA0000002", "C0000002CA","Vivian C", "California", 90650, 415236874, "C012300005"),
("CTX0000001", "C0000001TX","Sheldon K", "Texas", 77494, 806523124, "C012300004"),
("CTX0000002", "C0000002TX","Mary R", "Texas", 77494, 979231457, "C012300003"),
("CAZ0000001", "C0000001AZ","Peter Q", "Arizona", 85191, 480631235, "C012300002"),
("CAZ0000002", "C0000002AZ","Bernadette B", "Arizona", 85040, 928597843, "C012300001");

CREATE TABLE seller (
seller_id VARCHAR(10) NOT NULL,
s_pass VARCHAR(10) NOT NULL,
name VARCHAR(255) NOT NULL,
address VARCHAR(255) NOT NULL,
PRIMARY KEY(seller_id)
)ENGINE=InnoDB;

INSERT INTO seller (seller_id, s_pass, name, address) VALUES 
("SNY0000001", "S0000001NY", "Tapestry", "New York"),
("SNY0000002", "S0000002NY", "Hungryroot", "New York"),
("SMA0000001", "S0000001MA", "Chewy", "Massachusetts"),
("SMA0000002", "S0000002MA", "Invaluable", "Massachusetts"),
("SCA0000001", "S0000001CA", "Munchkin Inc", "California"),
("SCA0000002", "S0000002CA", "GOAT group", "California"),
("STX0000001", "S0000001TX", "Saatva", "Texas"),
("STX0000002", "S0000001TX", "Literati", "Texas"),
("SAZ0000001", "S0000001AZ", "Target", "Arizona"),
("SAZ0000002", "S0000001AZ", "PetSwag", "Arizona");


CREATE TABLE seller_phone_number (
phone_number INTEGER NOT NULL,
seller_id VARCHAR(10) NOT NULL,
PRIMARY KEY(phone_number, seller_id),
FOREIGN KEY (seller_id) REFERENCES seller(seller_id)
ON DELETE CASCADE
)ENGINE=InnoDB;

INSERT INTO seller_phone_number (phone_number, seller_id) VALUES
(212652178, "SNY0000001"),
(315965289, "SNY0000002"),
(339023650, "SMA0000001"),
(351783652, "SMA0000002"),
(213452312, "SCA0000001"),
(415236871, "SCA0000002"),
(806523165, "STX0000001"),
(979231485, "STX0000002"),
(480631212, "SAZ0000001"),
(928597846, "SAZ0000002");

CREATE TABLE payment (
payment_id VARCHAR(10) NOT NULL,
payment_date DATE NOT NULL,
payment_type VARCHAR(255) NOT NULL,
customer_id VARCHAR(10) NOT NULL,
cart_id VARCHAR(10) NOT NULL,
total_amount NUMERIC,
PRIMARY KEY(payment_id),
FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
FOREIGN KEY(cart_id) REFERENCES cart(cart_id)
)ENGINE=InnoDB;

INSERT INTO payment (payment_id, payment_date, payment_type, customer_id, cart_id, total_amount) VALUES
("PNY0000001", '2023-01-01', 'CARD', "CNY0000001", "C012300010", 150.32),
("PNY0000002", '2023-01-01', 'CASH', "CNY0000002", "C012300009", 248.23),
("PMA0000001", '2023-01-02', 'CARD', "CMA0000001", "C012300008", 562.54),
("PMA0000002", '2023-01-02', 'CASH', "CMA0000002", "C012300007", 623.23),
("PCA0000001", '2023-01-03', 'CARD', "CCA0000001", "C012300006", 237.12),
("PCA0000002", '2323-01-03', 'CASH', "CCA0000002", "C012300005", 79.25),
("PTX0000001", '2023-01-04', 'CARD', "CTX0000001", "C012300004", 321.52),
("PTX0000002", '2023-01-04', 'CASH', "CTX0000002", "C012300003", 669.25),
("PAZ0000001", '2023-01-05', 'CARD', "CAZ0000001", "C012300002", 841.27),
("PAZ0000002", '2023-01-05', 'CASH', "CAZ0000002", "C012300001", 630.24);


CREATE TABLE product (
product_id VARCHAR(10) NOT NULL,
type VARCHAR(10) NOT NULL,
color VARCHAR(20) NOT NULL,
p_size VARCHAR(10) NOT NULL,
gender VARCHAR(6) NOT NULL,
commission NUMERIC NOT NULL,
cost NUMERIC NOT NULL,
quantity INTEGER NOT NULL,
seller_id VARCHAR(10),
PRIMARY KEY(product_id),
FOREIGN KEY (seller_id) REFERENCES seller(seller_id)
ON DELETE SET NULL
)ENGINE=InnoDB;

INSERT INTO product (product_id, type, color, p_size, gender, commission, cost, quantity, seller_id) VALUES
("PDNY000001", 'ABC', 'Violet', 'Medium', 'Male', 12, 241, 3, "SNY0000001"),
("PDNY000002", 'DEF', 'Blue', 'Large', 'Female', 45, 324, 5, "SNY0000002"),
("PDMA000001", 'GHI', 'Indigo', 'Small', 'Male', 78, 859, 4, "SMA0000001"),
("PDMA000002", 'JKL', 'Red', 'Medium', 'Female', 21, 542, 8, "SMA0000002"),
("PDCA000001", 'MNO', 'Green', 'Large', 'Male', 74, 129, 2, "SCA0000001"),
("PDCA000002", 'PQR', 'Purple', 'Samll', 'Female', 65, 456, 7, "SCA0000002"),
("PDTX000001", 'STU', 'Orange', 'Medium', 'Male', 67, 419, 3, "STX0000001"),
("PDTX000002", 'VWX', 'White', 'Large', 'Female', 35, 318, 5, "STX0000002"),
("PDAZ000001", 'YZA', 'Black', 'Small', 'Male', 47, 857, 6, "SAZ0000001"),
("PDAZ000002", 'BCD', 'Grey', 'Medium', 'Female', 87, 745, 2, "SAZ0000002");

CREATE TABLE cart_item (
quantity_wished INTEGER NOT NULL,
date_added DATE NOT NULL,
cart_id VARCHAR(10) NOT NULL,
product_id VARCHAR(10) NOT NULL,
purchased VARCHAR(3) DEFAULT 'NO',
PRIMARY KEY (cart_id, product_id),
FOREIGN KEY (cart_id) REFERENCES cart(cart_id),
FOREIGN KEY (product_id) REFERENCES product(product_id)
)ENGINE=InnoDB;

INSERT INTO cart_item (quantity_wished, date_added, cart_id, product_id, purchased) VALUES
(3, '2022-12-01', "C012300010", "PDNY000001", "Yes"),
(5, '2022-12-02', "C012300009", "PDNY000002", "No"),
(4, '2022-12-03', "C012300008", "PDMA000001", "Yes"),
(8, '2022-12-04', "C012300007", "PDMA000002", "No"),
(2, '2022-12-05', "C012300006", "PDCA000001", "Yes"),
(7, '2022-12-06', "C012300005", "PDCA000002", "No"),
(3, '2022-12-07', "C012300004", "PDTX000001", "Yes"),
(5, '2022-12-08', "C012300003", "PDTX000002", "No"),
(6, '2022-12-09', "C012300002", "PDAZ000001", "Yes"),
(2, '2022-12-10', "C012300001", "PDAZ000002", "No");





















