
---------------------------
-- MySQL CREATE DATABASE --
---------------------------

/*The "CREATE DATABASE" statement is used to create a new database in SQL. It is also used in MySQL and other relational database management systems (RDBMS) 
to create databases.*/

CREATE DATABASE testDB;

CREATE DATABASE testDB2;

-----------------------------
-- List Databases in MySQL --
-----------------------------

/*We use the SHOW DATABASES command and it will return a list of databases that exist in our system (FOR MYSQL)*/

SHOW DATABASES;

---------------------------
-- USE Database in MySQL --
---------------------------

/*To use a specific database in MySQL, we use the USE Statement.*/

USE testDB;

USE testDB2;

-------------------------
-- MySQL Drop Database --
-------------------------

/*In MySQL, sometimes there is a need to delete or drop the database on which you are working. Deleting a database means deleting everything which includes all 
the data such as tables, views, indexes, schemas, constraints, etc. In order to delete a database we use the DROP DATABASE command. We generally delete a 
database when the database is no longer required and we want to free the memory that the database is consuming.*/

CREATE DATABASE deleteDB;

CREATE DATABASE deleteDB2;

SHOW DATABASES;

DROP DATABASE deleteDB;
DROP DATABASE deleteDB2;

SHOW DATABASES;

---------------------------
-- MySQL RENAME DATABASE --
---------------------------

/*You can use the RENAME TABLE command within a MySQL prompt to effectively change the database name of a particular table while keeping the table name intact. 
However, doing so requires that the database with the new name already exists, so begin by creating a new database.*/

CREATE DATABASE transportDB;

SHOW DATABASES;

/*Now connect to the mysql prompt and issue the following MySQL RENAME TABLE statement for a table of your choice:*/

RENAME TABLE car_sales.car_sales TO transportDB.car_sales;

SHOW DATABASES;

/*Please note that above method copies the data from old database to new database. It does not delete or rename the old database.*/