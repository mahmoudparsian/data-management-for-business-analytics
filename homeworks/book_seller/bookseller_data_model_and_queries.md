let's create a simple data model for a book seller: a book seller has 8 stores (each store is in a different location). The book seller has customers (separate table), which buy books, we want books in a separate table; books can be bought online or in store. The book seller wants to keep track of all daily transactions, but he wants to see the bottom line on a weekly/monthly/yearly basis. Can you come up with a datamodel in MySQL, with some sample rows for all tables, then provide: 6 simple queries, 6 intermediate queries, 6 queries with using sub-queries (using WITH clasuse) and ranking functions. For each query, express it in English and SQL. If you want to add some other basic things to make it real, then go a head please.

Excellent exercise 🙌 Let’s carefully design a data model for a book seller and then provide sample rows + queries in 3 levels (simple, intermediate, advanced with WITH and ranking).

⸻

📘 Step 1. Requirements → Entities

From your description, the book seller needs:
    1.    Stores (8 total, each in a unique location).
    2.    Customers (buy books, both online and in-store).
    3.    Books (sold in stores or online).
    4.    Transactions (daily purchases, recording who bought what, where, when, and how).

⸻

📘 Step 2. MySQL Data Model

CREATE DATABASE bookseller_db;
USE bookseller_db;

-- Stores
CREATE TABLE stores (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    store_name VARCHAR(50),
    location VARCHAR(100)
);

-- Customers
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

-- Books
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    price DECIMAL(10,2)
);

-- Transactions
CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    store_id INT,             -- NULL if online
    book_id INT,
    quantity INT,
    total_amount DECIMAL(10,2),
    purchase_date DATE,
    channel ENUM('Online','In-Store'),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);


⸻

📘 Step 3. Sample Data

-- Stores (8 stores)
INSERT INTO stores (store_name, location) VALUES
('Store A', 'New York'),
('Store B', 'Los Angeles'),
('Store C', 'Chicago'),
('Store D', 'Houston'),
('Store E', 'Miami'),
('Store F', 'Seattle'),
('Store G', 'Boston'),
('Store H', 'Denver');

-- Customers
INSERT INTO customers (name, email) VALUES
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com'),
('Charlie Davis', 'charlie@example.com'),
('Diana Evans', 'diana@example.com');

-- Books
INSERT INTO books (title, author, price) VALUES
('Data Science 101', 'John Miller', 45.00),
('SQL Basics', 'Jane Doe', 30.00),
('AI for Everyone', 'Andrew Ng', 55.00),
('Deep Learning Made Easy', 'Ian Goodfellow', 70.00);

-- Transactions
INSERT INTO transactions (customer_id, store_id, book_id, quantity, total_amount, purchase_date, channel) VALUES
(1, 1, 1, 1, 45.00, '2024-03-01', 'In-Store'),
(2, NULL, 2, 2, 60.00, '2024-03-02', 'Online'),
(3, 2, 3, 1, 55.00, '2024-03-02', 'In-Store'),
(4, 3, 4, 1, 70.00, '2024-03-03', 'In-Store'),
(1, NULL, 2, 1, 30.00, '2024-03-05', 'Online'),
(2, 4, 1, 2, 90.00, '2024-03-06', 'In-Store');


⸻

📘 Step 4. Queries

🟢 6 Simple Queries
    1.    List all stores and their locations.

SELECT * FROM stores;

    2.    Show all books with title and price.

SELECT title, price FROM books;

    3.    Find all customers.

SELECT name, email FROM customers;

    4.    List all transactions with date and total amount.

SELECT transaction_id, purchase_date, total_amount FROM transactions;

    5.    Find all online purchases.

SELECT * FROM transactions WHERE channel = 'Online';

    6.    Show all books purchased in Store A.

SELECT b.title
FROM transactions t
JOIN books b ON t.book_id = b.book_id
JOIN stores s ON t.store_id = s.store_id
WHERE s.store_name = 'Store A';


⸻

🟡 6 Intermediate Queries
    7.    Find the total sales (sum of total_amount).

SELECT SUM(total_amount) AS total_sales FROM transactions;

    8.    Find the number of transactions per channel.

SELECT channel, COUNT(*) AS num_transactions
FROM transactions
GROUP BY channel;

    9.    Find the total revenue per store.

SELECT s.store_name, SUM(t.total_amount) AS store_revenue
FROM transactions t
JOIN stores s ON t.store_id = s.store_id
GROUP BY s.store_name;

    10.    Find the most expensive book sold.

SELECT title, price
FROM books
ORDER BY price DESC
LIMIT 1;

    11.    Find the average order value.

SELECT AVG(total_amount) AS avg_order_value
FROM transactions;

    12.    Find the number of books sold per customer.

SELECT c.name, SUM(t.quantity) AS total_books
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
GROUP BY c.name;


⸻

🔵 6 Advanced Queries (WITH + Ranking Functions)
    13.    Find total monthly sales using WITH.

WITH monthly_sales AS (
    SELECT DATE_FORMAT(purchase_date, '%Y-%m') AS month,
           SUM(total_amount) AS total_sales
    FROM transactions
    GROUP BY DATE_FORMAT(purchase_date, '%Y-%m')
)
SELECT * FROM monthly_sales;

    14.    Rank stores by revenue.

WITH store_revenue AS (
    SELECT s.store_name, SUM(t.total_amount) AS revenue
    FROM transactions t
    JOIN stores s ON t.store_id = s.store_id
    GROUP BY s.store_name
)
SELECT store_name, revenue,
       RANK() OVER (ORDER BY revenue DESC) AS rank_position
FROM store_revenue;

    15.    Find top customer by total spending.

WITH customer_spending AS (
    SELECT c.name, SUM(t.total_amount) AS spending
    FROM transactions t
    JOIN customers c ON t.customer_id = c.customer_id
    GROUP BY c.name
)
SELECT name, spending,
       RANK() OVER (ORDER BY spending DESC) AS rank_position
FROM customer_spending;

    16.    Find best-selling book by quantity.

WITH book_sales AS (
    SELECT b.title, SUM(t.quantity) AS total_sold
    FROM transactions t
    JOIN books b ON t.book_id = b.book_id
    GROUP BY b.title
)
SELECT title, total_sold,
       RANK() OVER (ORDER BY total_sold DESC) AS rank_position
FROM book_sales;

    17.    Find weekly revenue trends.

WITH weekly_sales AS (
    SELECT YEARWEEK(purchase_date, 1) AS week,
           SUM(total_amount) AS weekly_total
    FROM transactions
    GROUP BY YEARWEEK(purchase_date, 1)
)
SELECT * FROM weekly_sales ORDER BY week;

    18.    Find customer who bought the most distinct books.

WITH customer_books AS (
    SELECT c.name, COUNT(DISTINCT t.book_id) AS distinct_books
    FROM transactions t
    JOIN customers c ON t.customer_id = c.customer_id
    GROUP BY c.name
)
SELECT name, distinct_books,
       RANK() OVER (ORDER BY distinct_books DESC) AS rank_position
FROM customer_books;


⸻

✅ This design is realistic but simple:
    •    4 main tables (stores, customers, books, transactions)
    •    Sample data for testing
    •    18 queries (6 simple, 6 intermediate, 6 advanced with WITH + ranking)

Would you like me to package this as Markdown homework sheets (student + instructor), similar to the earlier MySQL 101 assignments?

