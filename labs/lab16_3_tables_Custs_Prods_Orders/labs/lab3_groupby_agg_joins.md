# Lab-3 – Aggregations & Basic Joins (25 queries)

> Tables: `customers`, `products`, `orders`

### 1. Customers per country.
```sql
SELECT country, COUNT(*) AS cnt FROM customers GROUP BY country ORDER BY cnt DESC;
```

### 2. Average age by country.
```sql
SELECT country, AVG(age) AS avg_age FROM customers GROUP BY country ORDER BY avg_age DESC;
```

### 3. Products per category.
```sql
SELECT category, COUNT(*) AS cnt FROM products GROUP BY category ORDER BY cnt DESC;
```

### 4. Total revenue overall.
```sql
SELECT SUM(amount) AS total_revenue FROM orders;
```

### 5. Average order amount per product.
```sql
SELECT p.product_id, p.product_name, AVG(o.amount) AS avg_amt
FROM products p JOIN orders o ON p.product_id=o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY avg_amt DESC LIMIT 15;
```

### 6. Top 10 customers by total revenue.
```sql
SELECT c.customer_id, c.name, SUM(o.amount) AS total_spent
FROM customers c JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC LIMIT 10;
```

### 7. Top 5 categories by total revenue.
```sql
SELECT p.category, SUM(o.amount) AS revenue
FROM products p JOIN orders o ON p.product_id=o.product_id
GROUP BY p.category
ORDER BY revenue DESC LIMIT 5;
```

### 8. Countries with avg order amount > 80.
```sql
SELECT c.country, AVG(o.amount) AS avg_amt
FROM orders o JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.country
HAVING AVG(o.amount) > 80;
```

### 9. Products purchased by at least 30 distinct customers.
```sql
SELECT p.product_id, p.product_name, COUNT(DISTINCT o.customer_id) AS buyers
FROM products p JOIN orders o ON p.product_id=o.product_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(DISTINCT o.customer_id) >= 30;
```

### 10. Customers who bought from at least 4 categories.
```sql
SELECT c.customer_id, c.name, COUNT(DISTINCT p.category) AS cats
FROM customers c JOIN orders o ON c.customer_id=o.customer_id
JOIN products p ON o.product_id=p.product_id
GROUP BY c.customer_id, c.name
HAVING COUNT(DISTINCT p.category) >= 4
ORDER BY cats DESC;
```

### 11. Min/max amount per category.
```sql
SELECT p.category, MIN(o.amount) AS min_amt, MAX(o.amount) AS max_amt
FROM products p JOIN orders o ON p.product_id=o.product_id
GROUP BY p.category ORDER BY p.category;
```

### 12. Count (per country) of customers with > 20 orders.
```sql
WITH oc AS (
  SELECT customer_id, COUNT(*) AS n FROM orders GROUP BY customer_id
)
SELECT c.country, COUNT(*) AS heavy_buyers
FROM customers c JOIN oc ON c.customer_id=oc.customer_id
WHERE oc.n > 20
GROUP BY c.country ORDER BY heavy_buyers DESC;
```

### 13. Categories purchased by customers from CANADA.
```sql
SELECT DISTINCT p.category
FROM products p JOIN orders o ON p.product_id=o.product_id
JOIN customers c ON o.customer_id=c.customer_id
WHERE c.country='CANADA' ORDER BY p.category;
```

### 14. Average number of orders per active customer.
```sql
WITH oc AS (SELECT customer_id, COUNT(*) AS n FROM orders GROUP BY customer_id)
SELECT AVG(n) FROM oc;
```

### 15. Revenue per (country, category).
```sql
SELECT c.country, p.category, SUM(o.amount) AS revenue
FROM orders o JOIN customers c ON o.customer_id=c.customer_id
JOIN products p ON o.product_id=p.product_id
GROUP BY c.country, p.category
ORDER BY c.country, revenue DESC;
```

### 16. Share of total revenue by category (percentage).
```sql
WITH t AS (SELECT SUM(amount) AS total FROM orders)
SELECT p.category, SUM(o.amount)*100.0/(SELECT total FROM t) AS pct
FROM orders o JOIN products p ON o.product_id=p.product_id
GROUP BY p.category
ORDER BY pct DESC;
```

### 17. Top 10 products by revenue in 'Electronics'.
```sql
SELECT p.product_id, p.product_name, SUM(o.amount) AS revenue
FROM products p JOIN orders o ON p.product_id=o.product_id
WHERE p.category='Electronics'
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC LIMIT 10;
```

### 18. Top 10 customers by average order amount (min 5 orders).
```sql
WITH oc AS (
  SELECT customer_id, COUNT(*) AS n, AVG(amount) AS avg_amt
  FROM orders GROUP BY customer_id
)
SELECT c.customer_id, c.name, oc.avg_amt
FROM customers c JOIN oc ON c.customer_id=oc.customer_id
WHERE oc.n >= 5
ORDER BY oc.avg_amt DESC LIMIT 10;
```

### 19. Products with zero orders.
```sql
SELECT p.product_id, p.product_name
FROM products p LEFT JOIN orders o ON p.product_id=o.product_id
WHERE o.order_id IS NULL ORDER BY p.product_id DESC LIMIT 10;
```

### 20. Customers with zero orders.
```sql
SELECT c.customer_id, c.name
FROM customers c LEFT JOIN orders o ON c.customer_id=o.customer_id
WHERE o.order_id IS NULL ORDER BY c.customer_id DESC;
```

### 21. Per category: distinct countries purchasing it.
```sql
SELECT p.category, COUNT(DISTINCT c.country) AS countries
FROM products p JOIN orders o ON p.product_id=o.product_id
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY p.category ORDER BY countries DESC;
```

### 22. Avg order amount by age group.
```sql
SELECT CASE WHEN age<30 THEN 'YOUNG' WHEN age<=50 THEN 'MID' ELSE 'SENIOR' END AS grp,
       AVG(o.amount) AS avg_amt
FROM customers c JOIN orders o ON c.customer_id=o.customer_id
GROUP BY grp ORDER BY avg_amt DESC;
```

### 23. For each country, top category by revenue.
```sql
WITH cc AS (
  SELECT c.country, p.category, SUM(o.amount) AS rev
  FROM orders o JOIN customers c ON o.customer_id=c.customer_id
  JOIN products p ON o.product_id=p.product_id
  GROUP BY c.country, p.category
)
SELECT country, category, rev FROM (
  SELECT country, category, rev,
         ROW_NUMBER() OVER (PARTITION BY country ORDER BY rev DESC) AS rn
  FROM cc
) x WHERE rn=1;
```

### 24. Revenue distribution by 50-value buckets.
```sql
SELECT CONCAT(FLOOR(amount/50)*50,'-',FLOOR(amount/50)*50+49) AS bucket, COUNT(*) AS cnt
FROM orders GROUP BY bucket ORDER BY FLOOR(amount/50);
```

### 25. Per customer: min/avg/max amount.
```sql
SELECT c.customer_id, c.name, MIN(o.amount) AS min_amt, AVG(o.amount) AS avg_amt, MAX(o.amount) AS max_amt
FROM customers c JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY avg_amt DESC LIMIT 15;
```

