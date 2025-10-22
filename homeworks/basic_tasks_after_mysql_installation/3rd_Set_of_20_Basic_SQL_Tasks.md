Perfect 👍 Let’s wrap up your SQL learning roadmap with the final 20 advanced tasks (41–60).
These tasks will take you into views, indexing, transactions, stored procedures, window functions, and performance tuning — the advanced features you’ll eventually need in real-world projects.

⸻

✅ Final 20 Advanced SQL Tasks

Views
    41.    Create a view for customer order totals

CREATE VIEW customer_totals AS
SELECT c.name, SUM(p.price * o.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.name;

    42.    Query the view

SELECT * FROM customer_totals;

    43.    Update a view to show only customers spending > 1000

CREATE OR REPLACE VIEW customer_totals AS
SELECT c.name, SUM(p.price * o.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.name
HAVING total_spent > 1000;

    44.    Drop the view

DROP VIEW customer_totals;


⸻

Indexes
    45.    Create an index on customer email

CREATE INDEX idx_email ON customers(email);

    46.    Create a composite index on orders (customer_id, product_id)

CREATE INDEX idx_orders ON orders(customer_id, product_id);

    47.    Check if an index is used (EXPLAIN query)

EXPLAIN SELECT * FROM customers WHERE email = 'alice@email.com';

    48.    Drop an index

DROP INDEX idx_email ON customers;


⸻

Transactions
    49.    Start a transaction and insert an order

START TRANSACTION;
INSERT INTO orders (customer_id, product_id, quantity, order_date)
VALUES (1, 2, 3, '2025-09-23');

    50.    Rollback a transaction

ROLLBACK;

    51.    Commit a transaction

COMMIT;

    52.    Demonstrate transaction with multiple updates

START TRANSACTION;
UPDATE products SET price = price - 100 WHERE category = 'Electronics';
UPDATE customers SET city = 'Boston' WHERE name = 'Alice';
COMMIT;


⸻

Stored Procedures & Functions
    53.    Create a stored procedure to get total spent by a customer

DELIMITER //
CREATE PROCEDURE GetCustomerTotal(IN cust_id INT)
BEGIN
  SELECT c.name, SUM(p.price * o.quantity) AS total_spent
  FROM customers c
  JOIN orders o ON c.customer_id = o.customer_id
  JOIN products p ON o.product_id = p.product_id
  WHERE c.customer_id = cust_id
  GROUP BY c.name;
END //
DELIMITER ;

    54.    Call the stored procedure

CALL GetCustomerTotal(1);

    55.    Create a user-defined function to apply discount

DELIMITER //
CREATE FUNCTION ApplyDiscount(price DECIMAL(8,2), discount DECIMAL(5,2))
RETURNS DECIMAL(8,2)
DETERMINISTIC
RETURN price - (price * discount/100);
//
DELIMITER ;

    56.    Use the function

SELECT name, ApplyDiscount(price, 10) AS discounted_price FROM products;


⸻

Window Functions
    57.    Rank customers by total spent

SELECT c.name,
       SUM(p.price * o.quantity) AS total_spent,
       RANK() OVER (ORDER BY SUM(p.price * o.quantity) DESC) AS rank_position
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.name;

    58.    Find running total of sales by date

SELECT order_date,
       SUM(p.price * o.quantity) OVER (ORDER BY order_date) AS running_total
FROM orders o
JOIN products p ON o.product_id = p.product_id;

    59.    Find average sales per customer using PARTITION

SELECT c.city,
       c.name,
       AVG(p.price * o.quantity) OVER (PARTITION BY c.city) AS city_avg
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id;

    60.    Find the previous order amount per customer (LAG)

SELECT c.name, o.order_date,
       SUM(p.price * o.quantity) AS order_total,
       LAG(SUM(p.price * o.quantity)) OVER (PARTITION BY c.customer_id ORDER BY o.order_date) AS prev_order
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.name, c.customer_id, o.order_date;


⸻

✅ By now, with 60 tasks, you’ve touched nearly every important SQL concept:
    •    Basics (1–20) → Create, insert, select, joins, filters.
    •    Intermediate (21–40) → Updates, deletes, subqueries, constraints, aggregations.
    •    Advanced (41–60) → Views, indexes, transactions, procedures, window functions.

⸻

Would you like me to bundle all 60 tasks into a single structured SQL “learning workbook” file (with clear sections and comments), so you can run everything step by step inside MySQL?
