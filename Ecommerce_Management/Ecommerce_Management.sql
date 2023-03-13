CREATE DATABASE ecommerce_management;
USE ecommerce_management;

-- Creating Tables --
CREATE TABLE cart (
cart_id VARCHAR(10) NOT NULL,
PRIMARY KEY(cart_id)
)ENGINE=InnoDB;

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

CREATE TABLE seller (
seller_id VARCHAR(10) NOT NULL,
s_pass VARCHAR(10) NOT NULL,
name VARCHAR(255) NOT NULL,
address VARCHAR(255) NOT NULL,
PRIMARY KEY(seller_id)
)ENGINE=InnoDB;

CREATE TABLE seller_phone_number (
phone_number INTEGER NOT NULL,
seller_id VARCHAR(10) NOT NULL,
PRIMARY KEY(phone_number, seller_id),
FOREIGN KEY (seller_id) REFERENCES seller(seller_id)
ON DELETE CASCADE
)ENGINE=InnoDB;

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


















