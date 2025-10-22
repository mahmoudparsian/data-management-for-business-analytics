# First Set of 20 Basic SQL Tasks


	OK, I just installed mysql on my macbook, 
	can you provide a first set of tasks to do 
	to learn sql command. provide 20 basic tasks 
	with database, tables, and queries

	Since you just installed MySQL on your MacBook, 
	let’s build a hands-on learning roadmap with 20 
	basic tasks. These will give you a foundation 
	in SQL commands, covering databases, tables, and 
	queries.

⸻

✅ First Set of 20 Basic SQL Tasks

👉 These 20 tasks will teach you the core SQL skills:

    •    Creating databases and tables
    •    Inserting data
    •    Selecting and filtering
    •    Sorting and aggregation
    •    Joining tables

⸻


## Database & Table Setup
    
### 1.    Create a new database

~~~sql
CREATE DATABASE shopdb;
~~~

### 2.    Switch to that database

~~~sql
USE shopdb;
~~~

### 3.    Create a customers table

~~~sql
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50)
);
~~~
    
### 4.    Create a products table

~~~sql
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(8,2)
);
~~~

### 5.    Create a orders table with foreign keys

~~~sql
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
~~~

⸻

## Insert Sample Data
    
### 6.    Insert customers

~~~sql
INSERT INTO customers (name, email, city)
VALUES ('Alice', 'alice@email.com', 'New York'),
       ('Bob', 'bob@email.com', 'Chicago'),
       ('Carol', 'carol@email.com', 'San Francisco');
~~~

### 7.    Insert products

~~~sql
INSERT INTO products (product_name, category, price)
VALUES ('Laptop', 'Electronics', 1200.00),
       ('Phone', 'Electronics', 800.00),
       ('Desk', 'Furniture', 300.00);
~~~

### 8.    Insert orders

~~~sql
INSERT INTO orders (customer_id, product_id, quantity, order_date)
VALUES (1, 1, 1, '2025-09-01'),
       (2, 2, 2, '2025-09-05'),
       (3, 3, 1, '2025-09-10');
~~~


⸻

## Basic Queries
    
### 9.    Show all customers

~~~sql
SELECT * FROM customers;
~~~

### 10.    Select only names and cities

~~~sql
SELECT name, city 
FROM customers;
~~~

### 11.    Find customers from Chicago

~~~sql
SELECT * 
FROM customers 
WHERE city = 'Chicago';
~~~

### 12.    Get products cheaper than $1000

~~~sql
SELECT * 
FROM products 
WHERE price < 1000;
~~~

### 13.    Order products by price (low to high)

~~~sql
SELECT * 
FROM products 
ORDER BY price ASC;
~~~
    
### 14.    Count how many products you have

~~~sql
SELECT COUNT(*) 
FROM products;
~~~
    
### 15.    Show distinct cities from customers

~~~sql
SELECT DISTINCT city 
FROM customers;
~~~

⸻

## Joins and Aggregates
    
### 16.    Join customers with their orders

~~~sql
SELECT c.name, 
       o.order_id, 
       o.order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;
~~~

### 17.    Find total sales per customer

~~~sql
SELECT c.name, SUM(p.price * o.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.name;
~~~

### 18.    Find the most expensive product

~~~sql
SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 1;
~~~
    
### 19.    Show number of orders per customer

~~~sql
SELECT c.name, COUNT(o.order_id) AS num_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;
~~~

### 20.    Show orders made in September 2025

~~~sql
SELECT * 
FROM orders
WHERE order_date BETWEEN '2025-09-01' AND '2025-09-30';
~~~

⸻

