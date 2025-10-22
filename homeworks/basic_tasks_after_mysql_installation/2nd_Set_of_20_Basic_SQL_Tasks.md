
Perfect — since you already covered the first 20 basics, the next 20 tasks will take you a bit deeper. These cover updates, deletes, constraints, functions, subqueries, indexing, and more advanced queries.

⸻

✅ Next 20 SQL Tasks (Intermediate)

Data Modification
    21.    Update a customer’s city

UPDATE customers SET city = 'Los Angeles' WHERE name = 'Bob';

    22.    Increase all product prices by 10%

UPDATE products SET price = price * 1.10;

    23.    Delete an order

DELETE FROM orders WHERE order_id = 1;

    24.    Delete all customers in San Francisco

DELETE FROM customers WHERE city = 'San Francisco';


⸻

Table Alterations
    25.    Add a new column to customers (phone number)

ALTER TABLE customers ADD phone VARCHAR(20);

    26.    Rename a column (product_name → name)

ALTER TABLE products CHANGE product_name name VARCHAR(100);

    27.    Add a UNIQUE constraint on customer email

ALTER TABLE customers ADD CONSTRAINT unique_email UNIQUE (email);

    28.    Drop a column (phone)

ALTER TABLE customers DROP COLUMN phone;


⸻

Functions & Aggregations
    29.    Find the average product price

SELECT AVG(price) AS avg_price FROM products;

    30.    Find the maximum order quantity

SELECT MAX(quantity) AS max_qty FROM orders;

    31.    Find the earliest order date

SELECT MIN(order_date) AS first_order FROM orders;

    32.    Round prices to whole numbers

SELECT name, ROUND(price,0) AS rounded_price FROM products;


⸻

Subqueries
    33.    Find customers who placed at least 1 order

SELECT * FROM customers
WHERE customer_id IN (SELECT DISTINCT customer_id FROM orders);

    34.    Find products never ordered

SELECT * FROM products
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM orders);

    35.    Find the customer who spent the most

SELECT name FROM customers
WHERE customer_id = (
  SELECT o.customer_id
  FROM orders o
  JOIN products p ON o.product_id = p.product_id
  GROUP BY o.customer_id
  ORDER BY SUM(p.price * o.quantity) DESC
  LIMIT 1
);

    36.    Find orders with quantity greater than the average quantity

SELECT * FROM orders
WHERE quantity > (SELECT AVG(quantity) FROM orders);


⸻

Advanced Joins
    37.    Find customers who haven’t placed any orders

SELECT c.name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

    38.    List all products and who bought them (if any)

SELECT p.name AS product, c.name AS customer
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
LEFT JOIN customers c ON o.customer_id = c.customer_id;

    39.    Self join (customers in the same city)

SELECT a.name AS customer1, b.name AS customer2, a.city
FROM customers a
JOIN customers b ON a.city = b.city AND a.customer_id < b.customer_id;

    40.    Join orders with product price and compute total per order

SELECT o.order_id, c.name, p.name AS product, (o.quantity * p.price) AS total
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;


⸻

👉 These next 20 tasks bring you from basic CRUD and joins into subqueries, constraints, and functions. Together, you’ll cover most of what’s needed to be comfortable with SQL in real projects.

⸻

Would you like me to design the final 20 advanced tasks (tasks 41–60), focusing on views, indexes, transactions, stored procedures, and window functions — so you’ll have a full 60-task SQL learning roadmap?
