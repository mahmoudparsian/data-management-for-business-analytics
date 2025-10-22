# Lab-5 – Intermediate: WITH & Ranking Advanced (25 queries)

> Tables: `customers`, `products`, `orders`

### 1. Top 3 customers by total spend per country.
```sql
WITH spend AS (
  SELECT c.country, c.customer_id, c.name, SUM(o.amount) AS total
  FROM customers c JOIN orders o ON c.customer_id=o.customer_id
  GROUP BY c.country, c.customer_id, c.name
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY country ORDER BY total DESC) AS rn FROM spend
)
SELECT country, customer_id, name, total FROM r WHERE rn<=3 ORDER BY country, total DESC;
```

### 2. Customers with avg order > category avg in that category.
```sql
WITH cat_avg AS (
  SELECT p.category, AVG(o.amount) AS cavg
  FROM products p JOIN orders o ON p.product_id=o.product_id
  GROUP BY p.category
), cust_cat AS (
  SELECT c.customer_id, c.name, p.category, AVG(o.amount) AS avg_amt
  FROM customers c JOIN orders o ON c.customer_id=o.customer_id
  JOIN products p ON o.product_id=p.product_id
  GROUP BY c.customer_id, c.name, p.category
)
SELECT * FROM cust_cat cc JOIN cat_avg ca ON cc.category=ca.category
WHERE cc.avg_amt > ca.cavg;
```

### 3. Most popular product per country (by order count).
```sql
WITH pc AS (
  SELECT c.country, p.product_id, p.product_name, COUNT(*) AS cnt
  FROM orders o JOIN customers c ON o.customer_id=c.customer_id
  JOIN products p ON o.product_id=p.product_id
  GROUP BY c.country, p.product_id, p.product_name
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY country ORDER BY cnt DESC) AS rn FROM pc
)
SELECT country, product_id, product_name, cnt FROM r WHERE rn=1 ORDER BY country;
```

### 4. Per customer: top 5 orders by amount.
```sql
WITH r AS (
  SELECT o.*, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY amount DESC) AS rn
  FROM orders o
)
SELECT * FROM r WHERE rn<=5 ORDER BY customer_id, rn;
```

### 5. Customers with >= 100 orders and avg amount > 90.
```sql
WITH s AS (
  SELECT customer_id, COUNT(*) AS n, AVG(amount) AS avg_amt
  FROM orders
  GROUP BY customer_id
)
SELECT c.customer_id, c.name, s.n, s.avg_amt
FROM s JOIN customers c ON s.customer_id=c.customer_id
WHERE s.n >= 100 AND s.avg_amt > 90 ORDER BY s.avg_amt DESC;
```

### 6. Cumulative revenue by category within each country.
```sql
WITH rev AS (
  SELECT c.country, p.category, SUM(o.amount) AS rev
  FROM orders o JOIN customers c ON o.customer_id=c.customer_id
  JOIN products p ON o.product_id=p.product_id
  GROUP BY c.country, p.category
)
SELECT country, category, rev, SUM(rev) OVER (PARTITION BY country ORDER BY category) AS running
FROM rev ORDER BY country, category;
```

### 7. Categories with revenue share > 25% in a country.
```sql
WITH rev AS (
  SELECT c.country, p.category, SUM(o.amount) AS rev
  FROM orders o JOIN customers c ON o.customer_id=c.customer_id
  JOIN products p ON o.product_id=p.product_id
  GROUP BY c.country, p.category
), tot AS (
  SELECT country, SUM(rev) AS total FROM rev GROUP BY country
)
SELECT r.country, r.category, ROUND(r.rev*100.0/t.total,2) AS pct
FROM rev r JOIN tot t ON r.country=t.country
WHERE r.rev*100.0/t.total > 25;
```

### 8. Top 10 customers within each country by spend (DENSE_RANK).
```sql
WITH spend AS (
  SELECT c.country, c.customer_id, c.name, SUM(o.amount) AS total
  FROM customers c JOIN orders o ON c.customer_id=o.customer_id
  GROUP BY c.country, c.customer_id, c.name
), r AS (
  SELECT *, DENSE_RANK() OVER (PARTITION BY country ORDER BY total DESC) AS rnk FROM spend
)
SELECT country, customer_id, name, total FROM r WHERE rnk<=10 ORDER BY country, total DESC;
```

### 9. Customers who buy from exactly two categories.
```sql
WITH cats AS (
  SELECT c.customer_id, COUNT(DISTINCT p.category) AS n
  FROM customers c JOIN orders o ON c.customer_id=o.customer_id
  JOIN products p ON o.product_id=p.product_id
  GROUP BY c.customer_id
)
SELECT c.customer_id, c.name FROM cats x JOIN customers c ON x.customer_id=c.customer_id WHERE x.n=2;
```

### 10. Global top 1% orders by amount.
```sql
WITH r AS (
  SELECT amount,
         ROW_NUMBER() OVER (ORDER BY amount DESC) AS rn,
         COUNT(*) OVER () AS n
  FROM orders
)
SELECT * FROM orders WHERE amount >= (SELECT MIN(amount) FROM r WHERE rn <= CEIL(0.01*n));
```

### 11. Z-score of product avg amount within category.
```sql
WITH a AS (
  SELECT p.category, p.product_id, p.product_name, AVG(o.amount) AS avg_amt
  FROM products p LEFT JOIN orders o ON p.product_id=o.product_id
  GROUP BY p.category, p.product_id, p.product_name
), s AS (
  SELECT category, AVG(avg_amt) AS a, STDDEV_POP(avg_amt) AS sd FROM a GROUP BY category
)
SELECT a.category, a.product_id, a.product_name,
       (a.avg_amt - s.a)/NULLIF(s.sd,0) AS z
FROM a JOIN s ON a.category=s.category;
```

### 12. Customers whose total spend is above global average spend.
```sql
WITH cust_sum AS (
  SELECT customer_id, SUM(amount) AS total FROM orders GROUP BY customer_id
), g AS (
  SELECT AVG(total) AS gavg FROM cust_sum
)
SELECT c.customer_id, c.name, cs.total
FROM cust_sum cs CROSS JOIN g JOIN customers c ON cs.customer_id=c.customer_id
WHERE cs.total > g.gavg ORDER BY cs.total DESC;
```

### 13. Rank countries by revenue for each product (top 2 per product).
```sql
WITH pc AS (
  SELECT p.product_id, p.product_name, c.country, SUM(o.amount) AS rev
  FROM orders o JOIN customers c ON o.customer_id=c.customer_id
  JOIN products p ON o.product_id=p.product_id
  GROUP BY p.product_id, p.product_name, c.country
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY rev DESC) AS rn FROM pc
)
SELECT product_id, product_name, country, rev FROM r WHERE rn<=2 ORDER BY product_id, rev DESC;
```

### 14. Category that contributes most to each customer's spend.
```sql
WITH cc AS (
  SELECT c.customer_id, p.category, SUM(o.amount) AS rev
  FROM customers c JOIN orders o ON c.customer_id=o.customer_id
  JOIN products p ON o.product_id=p.product_id
  GROUP BY c.customer_id, p.category
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY rev DESC) AS rn FROM cc
)
SELECT customer_id, category, rev FROM r WHERE rn=1;
```

### 15. Countries where >10% of orders exceed 120 amount.
```sql
WITH c AS (
  SELECT c.country AS country, COUNT(*) AS n,
         SUM(CASE WHEN o.amount>120 THEN 1 ELSE 0 END) AS big
  FROM customers c JOIN orders o ON c.customer_id=c.customer_id
  GROUP BY c.country
)
SELECT country, big*100.0/n AS pct_big FROM c WHERE big*100.0/n > 10;
```

### 16. Customer with most big orders (>100) per country.
```sql
WITH b AS (
  SELECT c.country, c.customer_id, COUNT(*) AS big
  FROM customers c JOIN orders o ON c.customer_id=o.customer_id
  WHERE o.amount>100
  GROUP BY c.country, c.customer_id
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY country ORDER BY big DESC) AS rn FROM b
)
SELECT country, customer_id, big FROM r WHERE rn=1;
```

### 17. Categories with at least 3 products in top 100 by revenue.
```sql
WITH pr AS (
  SELECT p.product_id, p.product_name, p.category, SUM(o.amount) AS rev
  FROM products p LEFT JOIN orders o ON p.product_id=o.product_id
  GROUP BY p.product_id, p.product_name, p.category
), top100 AS (
  SELECT * FROM (
    SELECT *, ROW_NUMBER() OVER (ORDER BY rev DESC) AS rn FROM pr
  ) x WHERE rn<=100
)
SELECT category, COUNT(*) AS cnt
FROM top100 GROUP BY category HAVING COUNT(*) >= 3;
```

### 18. Above/below overall average order size per customer.
```sql
WITH g AS (SELECT AVG(amount) AS gavg FROM orders), a AS (
  SELECT customer_id, AVG(amount) AS avg_amt FROM orders GROUP BY customer_id
)
SELECT c.customer_id, c.name,
       CASE WHEN a.avg_amt > g.gavg THEN 'ABOVE' ELSE 'BELOW' END AS cmp
FROM a JOIN g JOIN customers c ON a.customer_id=c.customer_id;
```

### 19. Most loyal customer per category (highest order count in category).
```sql
WITH cc AS (
  SELECT p.category, c.customer_id, c.name, COUNT(*) AS cnt
  FROM customers c JOIN orders o ON c.customer_id=o.customer_id
  JOIN products p ON o.product_id=p.product_id
  GROUP BY p.category, c.customer_id, c.name
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY category ORDER BY cnt DESC) AS rn FROM cc
)
SELECT category, customer_id, name, cnt FROM r WHERE rn=1;
```

### 20. Top 3 country shares per product.
```sql
WITH pc AS (
  SELECT p.product_id, p.product_name, c.country, SUM(o.amount) AS rev
  FROM orders o JOIN customers c ON o.customer_id=c.customer_id
  JOIN products p ON o.product_id=p.product_id
  GROUP BY p.product_id, p.product_name, c.country
), tot AS (
  SELECT product_id, SUM(rev) AS total FROM pc GROUP BY product_id
), share AS (
  SELECT pc.product_id, pc.product_name, pc.country, pc.rev*100.0/tot.total AS pct
  FROM pc JOIN tot ON pc.product_id=tot.product_id
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY pct DESC) AS rn FROM share
)
SELECT product_id, product_name, country, ROUND(pct,2) AS pct FROM r WHERE rn<=3 ORDER BY product_id, pct DESC;
```

