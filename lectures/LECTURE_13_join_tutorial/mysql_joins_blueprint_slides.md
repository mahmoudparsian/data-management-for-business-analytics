# 🎓 A Practical Blueprint for **JOIN Operations** in MySQL (Slide-Style, Self‑Contained)

> **Focus:** INNER JOIN (with clear LEFT/RIGHT JOIN examples)  
> **What you’ll do:** Create small schemas ➜ insert realistic data ➜ run queries ➜ understand results  
> **Pre‑req:** MySQL installed, basics of SELECT/WHERE/GROUP BY

---

## Slide 1 — Learning Goals

By the end, you will be able to:

- Explain **why** joins exist and when to use them
- Use **INNER JOIN** to combine related tables
- Use **LEFT/RIGHT JOIN** to keep unmatched rows
- Write multi-table joins with clear `ON` conditions
- Avoid common pitfalls (accidental cartesian joins, double counting)
- Read/compose queries that aggregate **after** joins (e.g., totals per customer/product)

---

## Slide 2 — Core Mental Model of a JOIN

- Think of each table as a **set of rows** with keys.
- A **JOIN** matches rows across tables using a **join condition** (usually PK ↔ FK).
- **INNER JOIN:** keep **matches only**.  
- **LEFT JOIN:** keep **all left rows**, add matches from right; unmatched become **NULLs**.  
- **RIGHT JOIN:** mirror of LEFT JOIN.  
- Join order matters for **LEFT/RIGHT** in terms of which side is preserved.

```
Customers (left)          Orders (right)

   c1  ── matches ──>   o1
   c2  ── matches ──>   o2
   c3  ── no match ──>  (NULLs if LEFT JOIN)
```

---

## Slide 3 — Schema A: Customers & Orders (1:N)

```sql
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  name        VARCHAR(40),
  country     VARCHAR(20)
);

CREATE TABLE orders (
  order_id    INT PRIMARY KEY,
  customer_id INT,
  order_date  DATE,
  total_amt   DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
```

### Sample Data
```sql
INSERT INTO customers VALUES
(1,'Alice','USA'),
(2,'Bob','Canada'),
(3,'Carla','Germany'),
(4,'Dinesh','USA');  -- has no orders initially

INSERT INTO orders VALUES
(101,1,'2024-01-05',120.00),
(102,1,'2024-01-09', 80.00),
(103,2,'2024-01-11', 35.50);
```

---

## Slide 4 — INNER JOIN: Only Matched Rows

**Goal:** List each order with the customer’s name.

```sql
SELECT o.order_id, o.order_date, c.name AS customer_name, o.total_amt
FROM orders o
INNER JOIN customers c
  ON o.customer_id = c.customer_id
ORDER BY o.order_id;
```

**Why it works:** Orders reference customers via `customer_id`. Only orders with a valid customer appear.  
**Result (conceptual):**
```
order_id | order_date  | customer_name | total_amt
--------------------------------------------------
101      | 2024-01-05  | Alice         | 120.00
102      | 2024-01-09  | Alice         |  80.00
103      | 2024-01-11  | Bob           |  35.50
```
(CarLa and Dinesh do not appear because INNER keeps matches only; Carla has no order match.)

---

## Slide 5 — LEFT JOIN: Keep All From Left

**Goal:** List **all customers** with their latest order (if any).

```sql
SELECT c.customer_id, c.name, MAX(o.order_date) AS last_order_date
FROM customers c
LEFT JOIN orders o
  ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY c.customer_id;
```

**Key idea:** Customers **without orders** still appear with `last_order_date = NULL`.  
This is how you spot **“no activity yet”** rows.

---

## Slide 6 — RIGHT JOIN: Mirror of LEFT

**Goal:** Show all orders, even if a customer row is missing (rare; but possible in dirty data).

```sql
SELECT o.order_id, c.customer_id, c.name, o.total_amt
FROM customers c
RIGHT JOIN orders o
  ON o.customer_id = c.customer_id
ORDER BY o.order_id;
```

**Note:** In well‑designed schemas with FK constraints, orphan orders shouldn’t exist. If they do, RIGHT JOIN reveals them.

---

## Slide 7 — Schema B: Products & Order Items (M:N via Bridge)

```sql
CREATE TABLE products (
  product_id   INT PRIMARY KEY,
  product_name VARCHAR(40),
  category     VARCHAR(20),
  unit_price   DECIMAL(10,2)
);

CREATE TABLE order_items (
  order_id   INT,
  product_id INT,
  quantity   INT,
  PRIMARY KEY(order_id, product_id),
  FOREIGN KEY (order_id)  REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
```

### Sample Data
```sql
INSERT INTO products VALUES
(1001,'Laptop','Electronics',900.00),
(1002,'Mouse','Electronics', 25.00),
(1003,'Notebook','Stationery',3.50),
(1004,'Mug','Kitchen',8.99);

INSERT INTO order_items VALUES
(101,1001,1),   -- Alice bought 1 Laptop
(101,1002,2),   -- and 2 Mice
(102,1003,5),   -- Alice bought 5 Notebooks
(103,1004,3);   -- Bob bought 3 Mugs
```

---

## Slide 8 — Multi‑Table INNER JOIN

**Goal:** Show order lines with product names and extended price (`quantity * unit_price`).

```sql
SELECT o.order_id, c.name AS customer, p.product_name, oi.quantity,
       (oi.quantity * p.unit_price) AS line_total
FROM orders o
JOIN customers c  ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p  ON oi.product_id = p.product_id
ORDER BY o.order_id, p.product_name;
```

**Why this is powerful:** We merge **four** tables to compute business‑ready **line totals**.

---

## Slide 9 — Aggregation After JOIN

**Goal:** Total revenue per **customer**.

```sql
SELECT c.name AS customer,
       SUM(oi.quantity * p.unit_price) AS total_revenue
FROM customers c
JOIN orders o      ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id   = o.order_id
JOIN products p    ON p.product_id   = oi.product_id
GROUP BY c.name
ORDER BY total_revenue DESC;
```

**Watch out:** If you join orders to order_items, **aggregate at the right level** (group by the customer).

---

## Slide 10 — LEFT JOIN to Find “No Purchases” Customers

**Goal:** Find customers who **never placed an order**.

```sql
SELECT c.customer_id, c.name, c.country
FROM customers c
LEFT JOIN orders o
  ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;
```

**Pattern:** **Anti‑join** via `LEFT JOIN ... WHERE right.key IS NULL`.

---

## Slide 11 — LEFT JOIN to Find Products Never Ordered

```sql
SELECT p.product_id, p.product_name, p.category
FROM products p
LEFT JOIN order_items oi
  ON oi.product_id = p.product_id
WHERE oi.order_id IS NULL;
```

Useful for **catalog coverage** and pruning unused SKUs.

---

## Slide 12 — RIGHT JOIN Example (Symmetry Check)

**Goal:** Orders with missing customers. (Shouldn’t happen with FK.)

```sql
SELECT o.order_id, o.customer_id, c.name
FROM customers c
RIGHT JOIN orders o
  ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
```

---

## Slide 13 — USING vs ON (When Column Names Match)

If both tables share the **same column name** (e.g., `customer_id`):
```sql
SELECT o.order_id, c.name
FROM orders o
JOIN customers c USING (customer_id);
```

**Equivalent to:** `... ON o.customer_id = c.customer_id`  
`USING(col)` also **removes duplicate column output** for `col`.

---

## Slide 14 — Filtering Before vs After Joins

**Goal:** 2024 orders only, then join to items/products.

```sql
SELECT c.name, p.product_name, oi.quantity
FROM (SELECT * FROM orders WHERE YEAR(order_date)=2024) o
JOIN customers c  USING (customer_id)
JOIN order_items oi USING (order_id)
JOIN products p    USING (product_id)
ORDER BY c.name, p.product_name;
```

**Benefit:** Smaller intermediate join sets = **faster**.

---

## Slide 15 — Common Pitfalls & How to Avoid

1) **Missing ON condition** ➜ accidental cartesian product (`N×M` rows)  
2) **Wrong join key** ➜ mismatches or duplicates  
3) **Double counting** after joining detail tables ➜ aggregate carefully  
4) **Ambiguous column names** ➜ always alias tables/columns  
5) **LEFT JOIN + WHERE on right table column (not NULL-safe)** ➜ may turn into INNER JOIN unintentionally. Prefer `WHERE right.col IS NULL` for “no match”.

---

## Slide 16 — Performance Tips (Intro level)

- Add indexes on **FK columns** used in joins (`orders.customer_id`, `order_items.order_id`, `order_items.product_id`).  
- Filter early (subselect with WHERE) to reduce rows before joins.  
- Project only needed columns (avoid `SELECT *` in production).  
- Watch `EXPLAIN` to inspect join strategy.

---

## Slide 17 — Practice Set (Hands‑On)

> Use the schema & data from Slides 3 & 7.

1) List all **orders** with the **customer country** and **order total** (sum of line totals).  
2) Show **total quantity** sold per **product** (product_name).  
3) Show **Electronics** category revenue per **customer**.  
4) List **customers with no orders** and their country.  
5) Show **top 2 customers** by total revenue.  
6) Show **products never ordered**.  
7) Show each **customer’s last order date**.  
8) Show all **order lines** for orders in **2024‑01**.  
9) For each **country**, count **distinct customers** who placed an order.  
10) For each **order**, show the **number of distinct products** in that order.

---

## Slide 18 — Suggested Answers (Reference)

**1) Orders with country + order total**
```sql
SELECT o.order_id, c.country,
       SUM(oi.quantity * p.unit_price) AS order_total
FROM orders o
JOIN customers c  ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p  ON p.product_id = oi.product_id
GROUP BY o.order_id, c.country
ORDER BY o.order_id;
```

**2) Total qty per product**
```sql
SELECT p.product_name, SUM(oi.quantity) AS total_qty
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_qty DESC, p.product_name;
```

**3) Electronics revenue per customer**
```sql
SELECT c.name, SUM(oi.quantity * p.unit_price) AS revenue
FROM customers c
JOIN orders o      ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id   = o.order_id
JOIN products p    ON p.product_id   = oi.product_id
WHERE p.category = 'Electronics'
GROUP BY c.name
ORDER BY revenue DESC;
```

**4) Customers with no orders**
```sql
SELECT c.customer_id, c.name, c.country
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;
```

**5) Top 2 customers by revenue**
```sql
SELECT c.name, SUM(oi.quantity * p.unit_price) AS revenue
FROM customers c
JOIN orders o      ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id   = o.order_id
JOIN products p    ON p.product_id   = oi.product_id
GROUP BY c.name
ORDER BY revenue DESC
LIMIT 2;
```

**6) Products never ordered**
```sql
SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.product_id
WHERE oi.order_id IS NULL;
```

**7) Customer last order date**
```sql
SELECT c.name, MAX(o.order_date) AS last_order
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.name
ORDER BY c.name;
```

**8) Order lines in January 2024**
```sql
SELECT o.order_id, p.product_name, oi.quantity
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p     ON p.product_id = oi.product_id
WHERE o.order_date BETWEEN '2024-01-01' AND '2024-01-31'
ORDER BY o.order_id, p.product_name;
```

**9) Distinct purchasing customers per country**
```sql
SELECT c.country, COUNT(DISTINCT c.customer_id) AS buyers
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.country
ORDER BY buyers DESC, c.country;
```

**10) Distinct products per order**
```sql
SELECT o.order_id, COUNT(DISTINCT oi.product_id) AS num_products
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id
ORDER BY num_products DESC, o.order_id;
```

---

## Slide 19 — Mini “RIGHT JOIN” Drill (Optional)

1) Show all orders and attempt to show customer name; reveal missing customer rows.  
```sql
SELECT o.order_id, c.name
FROM customers c
RIGHT JOIN orders o ON o.customer_id = c.customer_id;
```
2) Show orders that **do not** have a matching customer row.  
```sql
SELECT o.*
FROM customers c
RIGHT JOIN orders o ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
```

---

## Slide 20 — Recap & Next Steps

- **INNER JOIN**: matched rows only (most common)  
- **LEFT/RIGHT JOIN**: preserve all rows from one side; use to find **missing orphans**  
- Use **USING(col)** when column names match on both sides  
- Aggregate after joins to answer business questions  
- Next: **JOINs with subqueries**, **self-joins**, **window functions**

---

### Appendix A — Full Setup Script (Copy/Paste Friendly)

```sql
-- Drop & recreate for clean runs
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  name        VARCHAR(40),
  country     VARCHAR(20)
);

CREATE TABLE orders (
  order_id    INT PRIMARY KEY,
  customer_id INT,
  order_date  DATE,
  total_amt   DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE products (
  product_id   INT PRIMARY KEY,
  product_name VARCHAR(40),
  category     VARCHAR(20),
  unit_price   DECIMAL(10,2)
);

CREATE TABLE order_items (
  order_id   INT,
  product_id INT,
  quantity   INT,
  PRIMARY KEY(order_id, product_id),
  FOREIGN KEY (order_id)  REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1,'Alice','USA'),
(2,'Bob','Canada'),
(3,'Carla','Germany'),
(4,'Dinesh','USA');

INSERT INTO orders VALUES
(101,1,'2024-01-05',120.00),
(102,1,'2024-01-09', 80.00),
(103,2,'2024-01-11', 35.50);

INSERT INTO products VALUES
(1001,'Laptop','Electronics',900.00),
(1002,'Mouse','Electronics', 25.00),
(1003,'Notebook','Stationery',3.50),
(1004,'Mug','Kitchen',8.99);

INSERT INTO order_items VALUES
(101,1001,1),
(101,1002,2),
(102,1003,5),
(103,1004,3);
```

---

### Appendix B — Quick Syntax Cheatsheet

```sql
-- INNER JOIN
SELECT ...
FROM A
JOIN B ON A.key = B.key;

-- LEFT JOIN
SELECT ...
FROM A
LEFT JOIN B ON A.key = B.key;

-- RIGHT JOIN
SELECT ...
FROM A
RIGHT JOIN B ON A.key = B.key;

-- USING (when the join column has the same name on both sides)
SELECT ...
FROM A
JOIN B USING (key);
```
