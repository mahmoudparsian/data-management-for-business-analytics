# Comprehensive MySQL JOINs Tutorial  
A complete, expanded learning module with diagrams, examples, explanations, and practice questions.

---

# ✅ Slide 1 — Introduction to JOINs  
Relational databases store related data in multiple tables.  
JOIN operations let us *combine* these tables logically.

### Why JOINs matter
- Break down large systems into small, clean tables  
- Avoid redundant data  
- Enable flexible analytics  
- Form the core of SQL-based data modeling

---

# ✅ Slide 2 — Sample Schema (Realistic & Clean)

We will use two simple but realistic tables:

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

### Sample Data (Customers)
| customer_id | name           | email               | country |
|-------------|----------------|---------------------|---------|
| 1           | Alice Brown    | alice@gmail.com     | USA     |
| 2           | Daniel Smith   | daniel@yahoo.com    | USA     |
| 3           | Maria Gomez    | maria@hotmail.com   | Mexico  |
| 4           | John Lee       | john@company.com    | Canada  |

### Sample Data (Orders)
| order_id | customer_id | product    | quantity | price | order_date |
|----------|-------------|------------|----------|-------|------------|
| 101      | 1           | Laptop     | 1        | 899   | 2024-02-10 |
| 102      | 1           | Mouse      | 2        | 40    | 2024-02-18 |
| 103      | 2           | Monitor    | 1        | 220   | 2024-03-01 |
| 104      | 4           | Keyboard   | 1        | 70    | 2024-03-12 |

---

# ✅ Slide 3 — JOIN Diagram

```
+-------------+        +---------------+
|  CUSTOMERS  |        |    ORDERS     |
+-------------+        +---------------+
| customer_id |<------>| customer_id   |
| name        |        | product       |
| email       |        | price         |
+-------------+        +---------------+
```

JOINs combine rows *when the join condition matches*.

---

# ✅ Slide 4 — INNER JOIN (Most Important)

### English  
Return rows where customers **have at least one order**.

### SQL  
```sql
SELECT c.name, c.country, o.product, o.price
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id;
```

### Result
| name        | country | product | price |
|-------------|---------|---------|-------|
| Alice Brown | USA     | Laptop  | 899   |
| Alice Brown | USA     | Mouse   | 40    |
| Daniel Smith| USA     | Monitor | 220   |
| John Lee    | Canada  | Keyboard| 70    |

✅ Only customers with matching orders appear.  
✅ Maria (ID=3) is not shown.

---

# ✅ Slide 5 — LEFT JOIN (Keep all customers)

### English  
Return *all customers*, even if they bought nothing.

### SQL  
```sql
SELECT c.name, o.product, o.price
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id;
```

### Note  
Missing orders become **NULL**.

### Example
| name        | product | price |
|-------------|---------|-------|
| Alice Brown | Laptop  | 899   |
| Alice Brown | Mouse   | 40    |
| Daniel Smith| Monitor | 220   |
| John Lee    | Keyboard| 70    |
| Maria Gomez | NULL    | NULL  |

Maria shows up ✅

---

# ✅ Slide 6 — RIGHT JOIN (Keep all orders)

### SQL  
```sql
SELECT c.name, o.product, o.price
FROM customers c
RIGHT JOIN orders o
    ON c.customer_id = o.customer_id;
```

Same as LEFT JOIN but keeps all orders, even if customer missing (rare case).

---

# ✅ Slide 7 — Aggregation + JOIN (Intermediate)

### English  
Find total spending per customer.

### SQL  
```sql
SELECT c.name,
       SUM(o.quantity * o.price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.name;
```

---

# ✅ Slide 8 — Filtering + JOIN (WHERE)

### English  
Find US customers who bought electronics.

### SQL  
```sql
SELECT c.name, o.product
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE c.country = 'USA'
  AND o.category = 'Electronics';
```

---

# ✅ Slide 9 — Handling Missing Data (LEFT JOIN + WHERE)

### English  
List customers who made **no purchases**.

### SQL  
```sql
SELECT c.name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

✅ Classic “find missing children” query.

---

# ✅ Slide 10 — Multi-Condition JOIN (Intermediate)

### English  
Join on customer_id *and limit to specific category.*

### SQL  
```sql
SELECT c.name, o.product, o.category
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.category IN ('Electronics', 'Office');
```

---

# ✅ Slide 11 — JOINs + ORDER BY

### English  
List customers and their last purchase date.

### SQL  
```sql
SELECT c.name, MAX(o.order_date) AS last_purchase
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY last_purchase DESC;
```

---

# ✅ Slide 12 — JOIN and LIMIT

### English  
Find the top 3 most expensive purchases.

```sql
SELECT c.name, o.product, o.price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
ORDER BY o.price DESC
LIMIT 3;
```

---

# ✅ Slide 13 — Realistic Scenario Example

**Question:**  
Show the total revenue by country.

### SQL  
```sql
SELECT c.country,
       SUM(o.quantity * o.price) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.country
ORDER BY revenue DESC;
```

---

# ✅ Slide 14 — Harder Example (JOIN + Subquery)

### English  
Find customers whose spending is above **average spending**.

### SQL  
```sql
WITH total_spending AS (
    SELECT c.customer_id,
           SUM(o.quantity * o.price) AS spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
)
SELECT c.name, t.spent
FROM total_spending t
JOIN customers c ON c.customer_id = t.customer_id
WHERE t.spent > (SELECT AVG(spent) FROM total_spending);
```

---

# ✅ Slide 15 — Practice Questions (Simple → Intermediate)

### Simple (1–3)
1. List customer names and the products they purchased.  
2. Show all customers (even with no orders).  
3. Retrieve all orders (even if customer missing).

### Intermediate (4–8)
4. Total revenue per customer.  
5. Count number of orders per country.  
6. Find customers with more than 2 orders.  
7. List last purchase date for each customer.  
8. Revenue per category.  

### Advanced (9–12)
9. Customers with spending above average.  
10. Country with highest total revenue.  
11. Customers who bought *multiple categories*.  
12. Products bought by customers in Canada only.

---

# ✅ Slide 16 — Summary

You learned:

✅ INNER JOIN  
✅ LEFT JOIN  
✅ RIGHT JOIN  
✅ Aggregations + JOIN  
✅ Filtering and Ordering  
✅ Subqueries using JOIN  
✅ Realistic analytics queries  

JOINs are the foundation of SQL-based analytics and the heart of data modeling.

---

End of Tutorial ✅
