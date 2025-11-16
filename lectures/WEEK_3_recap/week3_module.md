# Week 3 — SQL Join Operations (MySQL)

Environment: **MySQL Database**  
Format: **Markdown**

---

# 1. Schema: Three Related Tables (PK–FK Linked)

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    country VARCHAR(30)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
```

---

# 2. Populate Tables with Example Rows

```sql
INSERT INTO customers VALUES
(1, 'Alice', 'USA'),
(2, 'Bob', 'CANADA'),
(3, 'Carol', 'GERMANY'),
(4, 'David', 'USA');


INSERT INTO orders VALUES
(101, 1, '2024-01-05', 80.00),    -- Alice
(102, 1, '2024-02-10', 90.00),    -- Alice
(103, 2, '2024-02-12', 150.00),   -- Bob
(104, 3, '2024-03-01', 200.00);   -- Carol


INSERT INTO order_items VALUES
(1001, 101, 'Laptop Bag', 1, 40.00),
(1002, 101, 'Mouse',      2, 20.00),
(1003, 102, 'Keyboard',   1, 90.00),
(1004, 103, 'Monitor',    1, 150.00),
(1005, 104, 'Desk',       1, 200.00);
```

---

# 3. English + SQL Queries for All Concepts

---

# 4. GROUP BY with Aggregation Functions

### ✅ Total spending per customer
```sql
SELECT c.customer_name, 
       SUM(o.total_amount) AS total_spent
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;
```

### ✅ Number of orders per country
```sql
SELECT c.country, 
       COUNT(*) AS order_count
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.country;
```

---

# 5. GROUP BY with WHERE and HAVING

### ✅ WHERE before GROUP BY
```sql
SELECT c.customer_name, 
       SUM(o.total_amount) AS total_spent
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE c.country = 'USA'
GROUP BY c.customer_name;
```

### ✅ HAVING after GROUP BY
```sql
SELECT c.customer_name, 
       SUM(o.total_amount) AS total_spent
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING total_spent > 150;
```

### ✅ Combined WHERE + HAVING
```sql
SELECT c.customer_name, 
       SUM(o.total_amount) AS total_spent
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE c.country = 'USA'
GROUP BY c.customer_name
HAVING total_spent > 100;
```

---

# 6. Ranking Using ROW_NUMBER()

### ✅ Rank each customer’s orders by date
```sql
SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    ROW_NUMBER() OVER (PARTITION BY c.customer_id 
                       ORDER BY o.order_date) 
      AS order_rank
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id, order_rank;
```

---

# 7. Join Operations (Main Focus)

---

## ✅ INNER JOIN
```sql
SELECT 
    c.customer_name,
    o.order_id,
    oi.product_name,
    oi.quantity
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id;
```

---

## ✅ LEFT JOIN
```sql
SELECT 
    c.customer_name,
    o.order_id,
    o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;
```

---

## ✅ RIGHT JOIN
```sql
SELECT 
    o.order_id,
    c.customer_name,
    o.total_amount
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;
```

---

## ✅ FULL JOIN (MySQL workaround)

MySQL does **not** support FULL JOIN directly.

```sql
SELECT 
    c.customer_name,
    o.order_id,
    o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id

UNION

SELECT 
    c.customer_name,
    o.order_id,
    o.total_amount
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;
```

---

# ✅ END OF WEEK 3 MODULE
