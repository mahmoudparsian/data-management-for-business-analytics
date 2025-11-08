# Week 2 SQL Lecture Slides — JOIN Operations (Expanded)

## ✅ Slide 1 — Why JOINs Matter
Relational databases store data across multiple tables to reduce redundancy.  
JOINs allow us to reconnect/link these tables to perform meaningful analytics.

Why JOINs?

- Combine logically related data.
- Enable flexible queries across normalized tables.
- Prevent duplication and maintain data integrity.
- Critical for real-world applications (e-commerce, finance, healthcare, logistics).

---

## ✅ Slide 2 — Schema Used in All Examples

```sql
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(40),
  email VARCHAR(60),
  country VARCHAR(20)
);

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  product VARCHAR(40),
  category VARCHAR(20),
  quantity INT,
  price DECIMAL(10,2),
  order_date DATE
);
```

## Populate Tables

```sql
INSERT INTO customers 
(customer_id, name, email, country) 
VALUES
(1, 'Alice Brown',  'alice.brown@gmail.com',   'USA'),
(2, 'Daniel Smith', 'daniel.smith@yahoo.com',  'USA'),
(3, 'Maria Gomez',  'maria.gomez@hotmail.com', 'Mexico'),
(4, 'John Lee',     'john.lee@company.com',    'Canada'),
(5, 'Sophia Wang',  'sophia.wang@gmail.com',   'USA');
```

```sql
INSERT INTO orders 
(order_id, customer_id, product, category, quantity, price, order_date) 
VALUES
(1001, 1, 'Laptop',          'Electronics', 1, 899.00,  '2024-01-05'),
(1002, 1, 'Wireless Mouse',  'Electronics', 2, 25.00,   '2024-01-12'),
(1003, 1, 'USB-C Cable',     'Accessories', 3, 9.99,    '2024-01-20'),
(1004, 1, 'Office Chair',    'Furniture',   1, 159.00,  '2024-02-01'),

(1005, 2, 'Monitor 27-inch', 'Electronics', 1, 220.00,  '2024-02-10'),
(1006, 2, 'Desk Lamp',       'Furniture',   1, 45.00,   '2024-02-15'),
(1007, 2, 'Keyboard',        'Electronics', 1, 70.00,   '2024-02-20'),
(1008, 2, 'HDMI Cable',      'Accessories', 2, 12.00,   '2024-02-25'),

(1009, 3, 'Notebook Pack',   'Office',      5, 3.50,    '2024-03-01'),
(1010, 3, 'Desk Organizer',  'Office',      1, 22.00,   '2024-03-03'),
(1011, 3, 'Pen Set',         'Office',      4, 4.00,    '2024-03-05'),
(1012, 3, 'Water Bottle',    'Lifestyle',   1, 15.00,   '2024-03-10'),

(1013, 4, 'Keyboard',        'Electronics', 1, 70.00,   '2024-03-12'),
(1014, 4, 'Laptop Stand',    'Accessories', 1, 35.00,   '2024-03-18'),
(1015, 4, 'Backpack',        'Lifestyle',   1, 55.00,   '2024-03-20'),
(1016, 4, 'Portable SSD',    'Electronics', 1, 120.00,  '2024-03-25'),

(1017, 5, 'Tablet 10-inch',  'Electronics', 1, 299.00,  '2024-04-01'),
(1018, 5, 'Screen Protector','Accessories', 1, 12.00,   '2024-04-02'),
(1019, 5, 'Bluetooth Earbuds','Electronics',1, 59.00,   '2024-04-05'),
(1020, 5, 'Standing Desk',   'Furniture',   1, 250.00,  '2024-04-10');
```
---

## ✅ Slide 3 — INNER JOIN (Most Important JOIN)

```sql
SELECT c.name, o.product, o.price
FROM customers c
INNER JOIN orders o
  ON c.customer_id = o.customer_id;
```

---

## ✅ Slide 4 — LEFT JOIN (Show All Customers)

```sql
SELECT c.name, o.product, o.price
FROM customers c
LEFT JOIN orders o
  ON c.customer_id = o.customer_id;
```

---

## ✅ Slide 5 — RIGHT JOIN (Keep All Orders)

```sql
SELECT c.name, o.product
FROM customers c
RIGHT JOIN orders o
  ON c.customer_id = o.customer_id;
```

---

## ✅ Slide 6 — FULL OUTER JOIN (MySQL Simulation)

```sql
SELECT * FROM A LEFT JOIN B ON ...
UNION
SELECT * FROM A RIGHT JOIN B ON ...;
```

---

## ✅ Slide 7 — JOIN Diagram

CUSTOMERS → ORDERS (via customer_id)

---

## ✅ Slide 8 — JOIN + Aggregation

```sql
SELECT c.name,
       SUM(o.quantity * o.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;
```

---

## ✅ Slide 9 — JOIN + Filtering

```sql
SELECT c.name, o.product
FROM customers c
JOIN orders o 
  ON c.customer_id = o.customer_id
WHERE c.country = 'USA'
  AND o.category = 'Electronics';
```

---

## ✅ Slide 10 — JOIN + Sorting + LIMIT

```sql
SELECT c.name, o.product, o.price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
ORDER BY o.price DESC
LIMIT 3;
```

---

## ✅ Slide 11 — LEFT JOIN for Missing Data

```sql
SELECT c.name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

---

## ✅ Slide 12 — JOIN + Subquery

```sql
WITH spending AS (
    SELECT customer_id,
           SUM(price * quantity) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT c.name, s.total_spent
FROM spending s
JOIN customers c ON c.customer_id = s.customer_id
WHERE s.total_spent > (SELECT AVG(total_spent) FROM spending);
```

---

## ✅ Slide 13 — Multi-Condition JOIN

```sql
SELECT c.name, o.product, o.category
FROM customers c
JOIN orders o 
  ON c.customer_id = o.customer_id
WHERE o.category IN ('Electronics', 'Office');
```

---

## ✅ Slide 14 — Practice Problems

Simple, Intermediate, Advanced sets included in earlier version.  
(This slide intentionally shortened.)

---

## ✅ Slide 15 — Summary

INNER JOIN, LEFT JOIN, RIGHT JOIN, JOIN + Aggregations, JOIN + Filters, JOIN + Subqueries.

End of Week 2 SQL JOIN Lecture ✅
