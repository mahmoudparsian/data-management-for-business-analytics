-- Demo Dataset: Customers & Orders

-- Drop tables if exist
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

-- Create Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    country VARCHAR(50)
);

-- Create Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    year INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert Customers
INSERT INTO customers VALUES
(1, 'Alice', 'alice@example.com', 'USA'),
(2, 'Bob', 'bob@example.com', 'Canada'),
(3, 'Charlie', 'charlie@example.com', 'UK'),
(4, 'Diana', 'diana@example.com', 'Germany'),
(5, 'Ethan', 'ethan@example.com', 'France');

-- Insert Orders
INSERT INTO orders VALUES
(101, 1, 250.75, 2021),
(102, 1, 300.50, 2022),
(103, 2, 150.00, 2021),
(104, 3, 500.25, 2023),
(105, 3, 75.99, 2022),
(106, 4, 400.00, 2021),
(107, 5, 220.00, 2023),
(108, 5, 330.50, 2022);
