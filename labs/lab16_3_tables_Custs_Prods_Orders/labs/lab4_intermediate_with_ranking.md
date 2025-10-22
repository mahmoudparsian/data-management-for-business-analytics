# Lab-4 – Intermediate: Joins, WITH, Ranking (25 queries)

> Tables: `customers`, `products`, `orders`

### 1. Orders with customer & product (first 15).
```sql
SELECT o.order_id, c.name, p.product_name, o.amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
JOIN products p ON o.product_id=p.product_id
LIMIT 15;
```

### 2. All customers with total orders (LEFT JOIN).
```sql
SELECT c.customer_id, c.name, COALESCE(SUM(o.amount),0) AS total_spent
FROM customers c LEFT JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC LIMIT 15;
```

### 3. All products with total revenue (RIGHT JOIN).
```sql
SELECT p.product_id, p.product_name, COALESCE(SUM(o.amount),0) AS revenue
FROM orders o RIGHT JOIN products p ON o.product_id=p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY p.product_id DESC LIMIT 15;
```

### 4. Top-3 products by revenue per category (ROW_NUMBER).
```sql
WITH prod_rev AS (
  SELECT p.category, p.product_id, p.product_name, SUM(o.amount) AS revenue
  FROM products p LEFT JOIN orders o ON p.product_id=o.product_id
  GROUP BY p.category, p.product_id, p.product_name
), ranked AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY category ORDER BY revenue DESC) AS rn
  FROM prod_rev
)
SELECT * FROM ranked WHERE rn<=3 ORDER BY category, revenue DESC;
```

### 5. Top-5 customers by total spending (CTE).
```sql
WITH spend AS (
  SELECT customer_id, SUM(amount) AS total
  FROM orders GROUP BY customer_id
)
SELECT c.customer_id, c.name, s.total
FROM customers c JOIN spend s ON c.customer_id=s.customer_id
ORDER BY s.total DESC LIMIT 5;
```

### 6. Customers whose average order > their country average.
```sql
WITH country_avg AS (
  SELECT c.country, AVG(o.amount) AS avg_amt
  FROM customers c JOIN orders o ON c.customer_id=o.customer_id
  GROUP BY c.country
), cust_avg AS (
  SELECT c.customer_id, c.name, c.country, AVG(o.amount) AS cust_avg
  FROM customers c JOIN orders o ON c.customer_id=o.customer_id
  GROUP BY c.customer_id, c.name, c.country
)
SELECT ca.customer_id, ca.name, ca.cust_avg, co.avg_amt
FROM cust_avg ca JOIN country_avg co ON ca.country=co.country
WHERE ca.cust_avg > co.avg_amt;
```

### 7. Rank countries by total revenue (DENSE_RANK).
```sql
WITH cnt_rev AS (
  SELECT c.country, SUM(o.amount) AS rev
  FROM customers c JOIN orders o ON c.customer_id=o.customer_id
  GROUP BY c.country
)
SELECT country, rev,
       DENSE_RANK() OVER (ORDER BY rev DESC) AS rnk
FROM cnt_rev ORDER BY rnk;
```

### 8. Top buyer per country (RANK ties allowed).
```sql
WITH buyers AS (
  SELECT c.country, c.customer_id, c.name, SUM(o.amount) AS total
  FROM customers c JOIN orders o ON c.customer_id=o.customer_id
  GROUP BY c.country, c.customer_id, c.name
), ranked AS (
  SELECT *, RANK() OVER (PARTITION BY country ORDER BY total DESC) AS rnk
  FROM buyers
)
SELECT * FROM ranked WHERE rnk=1 ORDER BY country;
```

### 9. Product with the highest average amount per category.
```sql
WITH a AS (
  SELECT p.category, p.product_id, p.product_name, AVG(o.amount) AS avg_amt
  FROM products p LEFT JOIN orders o ON p.product_id=o.product_id
  GROUP BY p.category, p.product_id, p.product_name
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY category ORDER BY avg_amt DESC) AS rn FROM a
)
SELECT category, product_id, product_name, avg_amt FROM r WHERE rn=1;
```

### 10. Customers with zero orders (LEFT anti-join).
```sql
SELECT c.customer_id, c.name
FROM customers c LEFT JOIN orders o ON c.customer_id=o.customer_id
WHERE o.order_id IS NULL;
```

### 11. Unpurchased products (RIGHT join with HAVING).
```sql
SELECT p.product_id, p.product_name, COUNT(o.order_id) AS times
FROM orders o RIGHT JOIN products p ON o.product_id=p.product_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(o.order_id)=0
ORDER BY p.product_id DESC;
```

### 12. Most popular category by country.
```sql
WITH cc AS (
  SELECT c.country, p.category, COUNT(*) AS cnt
  FROM orders o JOIN customers c ON o.customer_id=c.customer_id
  JOIN products p ON o.product_id=p.product_id
  GROUP BY c.country, p.category
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY country ORDER BY cnt DESC) AS rn FROM cc
)
SELECT country, category, cnt FROM r WHERE rn=1;
```

### 13. Running total of revenue by country (alpha order).
```sql
WITH rev AS (
  SELECT c.country AS country, SUM(o.amount) AS rev
  FROM customers c JOIN orders o ON c.customer_id=c.customer_id
  GROUP BY c.country
)
SELECT country, rev, SUM(rev) OVER (ORDER BY country) AS running_total
FROM rev ORDER BY country;
```

### 14. Largest 10 orders with names.
```sql
SELECT o.order_id, c.name, p.product_name, o.amount
FROM orders o JOIN customers c ON o.customer_id=c.customer_id
JOIN products p ON o.product_id=p.product_id
ORDER BY o.amount DESC LIMIT 10;
```

### 15. Customers who buy only one category.
```sql
WITH cats AS (
  SELECT c.customer_id, COUNT(DISTINCT p.category) AS n_cats
  FROM customers c JOIN orders o ON c.customer_id=o.customer_id
  JOIN products p ON o.product_id=p.product_id
  GROUP BY c.customer_id
)
SELECT c.customer_id, c.name
FROM cats x JOIN customers c ON x.customer_id=c.customer_id
WHERE x.n_cats=1;
```

### 16. Percent revenue by category (global).
```sql
WITH t AS (SELECT SUM(amount) AS total FROM orders)
SELECT p.category, ROUND(SUM(o.amount)*100.0/(SELECT total FROM t),2) AS pct
FROM products p JOIN orders o ON p.product_id=o.product_id
GROUP BY p.category ORDER BY pct DESC;
```

### 17. Top 3 customers by orders in 'Books'.
```sql
WITH b AS (
  SELECT o.customer_id, COUNT(*) AS cnt
  FROM orders o JOIN products p ON o.product_id=p.product_id
  WHERE p.category='Books'
  GROUP BY o.customer_id
)
SELECT c.customer_id, c.name, b.cnt
FROM b JOIN customers c ON b.customer_id=c.customer_id
ORDER BY b.cnt DESC LIMIT 3;
```

### 18. Orders above customer's average (CTE).
```sql
WITH ca AS (
  SELECT customer_id, AVG(amount) AS avg_amt FROM orders GROUP BY customer_id
)
SELECT o.order_id, c.name, o.amount, ca.avg_amt
FROM orders o JOIN ca ON o.customer_id=ca.customer_id
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.amount > ca.avg_amt
ORDER BY o.amount DESC LIMIT 15;
```

### 19. Top product by revenue (single row).
```sql
WITH pr AS (
  SELECT p.product_id, p.product_name, SUM(o.amount) AS rev
  FROM products p LEFT JOIN orders o ON p.product_id=o.product_id
  GROUP BY p.product_id, p.product_name
)
SELECT * FROM pr ORDER BY rev DESC LIMIT 1;
```

### 20. Top 5 categories by average order amount (min 50 orders).
```sql
WITH cat_stats AS (
  SELECT p.category, COUNT(*) AS n, AVG(o.amount) AS avg_amt
  FROM products p JOIN orders o ON p.product_id=o.product_id
  GROUP BY p.category
)
SELECT category, avg_amt FROM cat_stats WHERE n >= 50 ORDER BY avg_amt DESC LIMIT 5;
```

### 21. Second most purchased product per category.
```sql
WITH freq AS (
  SELECT p.category, p.product_id, p.product_name, COUNT(*) AS cnt
  FROM products p LEFT JOIN orders o ON p.product_id=o.product_id
  GROUP BY p.category, p.product_id, p.product_name
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY category ORDER BY cnt DESC) AS rn FROM freq
)
SELECT category, product_id, product_name, cnt FROM r WHERE rn=2;
```

### 22. All products & purchased status (RIGHT JOIN).
```sql
SELECT p.product_id, p.product_name,
       CASE WHEN o.product_id IS NULL THEN 'NEVER' ELSE 'PURCHASED' END AS status
FROM orders o RIGHT JOIN products p ON o.product_id=p.product_id
GROUP BY p.product_id, p.product_name, status
ORDER BY p.product_id;
```

### 23. All customers & number of distinct products (LEFT JOIN).
```sql
SELECT c.customer_id, c.name, COUNT(DISTINCT o.product_id) AS distinct_products
FROM customers c LEFT JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY distinct_products DESC, c.customer_id ASC;
```

