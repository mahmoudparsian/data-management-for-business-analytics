# Lab 5 — Intermediate to Advanced

## Schema (simplified):

```sql
  stores(store_id, store_location, city, country)

  customers(customer_id, name, email, gender, age, city, country)

  books(book_id, ISBN, title, author, category, published_date)

  transactions(sale_id, store_id, book_id, customer_id, purchase_date, price)
```

## Profitability & Strategy

**1. Most profitable store overall.**

```sql
WITH rev AS (
  SELECT s.store_id, s.city, SUM(t.price) AS revenue
  FROM stores s LEFT JOIN transactions t ON s.store_id=t.store_id
  GROUP BY s.store_id, s.city
)
SELECT * FROM rev ORDER BY revenue DESC LIMIT 1;
```

**2. Most valuable customer (overall spend).**

```sql
WITH spend AS (
  SELECT c.customer_id, c.name, SUM(t.price) AS total_spent
  FROM customers c JOIN transactions t ON c.customer_id=t.customer_id
  GROUP BY c.customer_id, c.name
)
SELECT * FROM spend ORDER BY total_spent DESC LIMIT 1;
```

**3. Category with highest average price.**

```sql
WITH p AS (
  SELECT b.category, AVG(t.price) AS avg_price
  FROM books b JOIN transactions t ON b.book_id=t.book_id
  GROUP BY b.category
)
SELECT * FROM p ORDER BY avg_price DESC LIMIT 1;
```

**4. Customers who bought in more than one country.**

```sql
WITH cc AS (
  SELECT c.customer_id, COUNT(DISTINCT s.country) AS countries
  FROM transactions t JOIN customers c ON t.customer_id=c.customer_id
  JOIN stores s ON t.store_id=s.store_id
  GROUP BY c.customer_id
)
SELECT c.customer_id, c.name
FROM cc JOIN customers c ON c.customer_id=cc.customer_id
WHERE cc.countries > 1;
```

**5. Books that sell in at least 5 different cities.**

```sql
WITH bc AS (
  SELECT b.book_id, COUNT(DISTINCT s.city) AS cities
  FROM transactions t JOIN stores s ON t.store_id=s.store_id
  JOIN books b ON t.book_id=b.book_id
  GROUP BY b.book_id
)
SELECT b.book_id, b.title
FROM bc JOIN books b ON b.book_id=bc.book_id
WHERE bc.cities >= 5;
```

**6. Top 3 authors per country by revenue.**

```sql
WITH ar AS (
  SELECT s.country, b.author, SUM(t.price) AS rev
  FROM transactions t
  JOIN stores s ON t.store_id=s.store_id
  JOIN books b ON t.book_id=b.book_id
  GROUP BY s.country, b.author
), r AS (
  SELECT country, author, rev,
         RANK() OVER (PARTITION BY country ORDER BY rev DESC) AS rnk
  FROM ar
)
SELECT * FROM r WHERE rnk <= 3 ORDER BY country, rnk;
```

## Time & Trend

**7. Best quarter in 2024 by revenue.**

```sql
WITH m AS (
  SELECT DATE_FORMAT(purchase_date,'%Y-%m') AS ym, SUM(price) AS rev
  FROM transactions WHERE purchase_date BETWEEN '2024-01-01' AND '2024-12-31'
  GROUP BY ym
), q AS (
  SELECT CONCAT(SUBSTRING(ym,1,4),' Q', CEIL(SUBSTRING(ym,6,2)/3)) AS qtr, SUM(rev) AS rev
  FROM m GROUP BY qtr
)
SELECT * FROM q ORDER BY rev DESC LIMIT 1;
```

**8. Month with the largest drop vs previous month.**

```sql
WITH m AS (
  SELECT DATE_FORMAT(purchase_date,'%Y-%m') AS ym, SUM(price) AS rev
  FROM transactions GROUP BY ym
), r AS (
  SELECT ym, rev, LAG(rev) OVER (ORDER BY ym) AS prev_rev FROM m
)
SELECT ym, (rev - prev_rev) AS delta
FROM r ORDER BY delta ASC LIMIT 1;
```

**9. Customers with 3+ purchases in a single month (power users).**

```sql
WITH m AS (
  SELECT customer_id, DATE_FORMAT(purchase_date,'%Y-%m') AS ym, COUNT(*) AS cnt
  FROM transactions GROUP BY customer_id, ym
)
SELECT c.customer_id, c.name, m.ym, m.cnt
FROM m JOIN customers c ON c.customer_id=m.customer_id
WHERE m.cnt >= 3
ORDER BY m.cnt DESC, m.ym;
```

**10. Stores with continuous revenue growth over any 3-month window.**

```sql
WITH m AS (
  SELECT s.store_id, s.city, DATE_FORMAT(t.purchase_date,'%Y-%m') AS ym, SUM(t.price) AS rev
  FROM transactions t JOIN stores s ON t.store_id=s.store_id
  GROUP BY s.store_id, s.city, ym
), r AS (
  SELECT store_id, city, ym, rev,
         LAG(rev,1) OVER (PARTITION BY store_id ORDER BY ym) AS p1,
         LAG(rev,2) OVER (PARTITION BY store_id ORDER BY ym) AS p2
  FROM m
)
SELECT store_id, city, ym
FROM r
WHERE p2 IS NOT NULL AND p2 < p1 AND p1 < rev;
```

**11. Top 5 books by revenue in the last 365 days.**

```sql
WITH recent AS (
  SELECT * FROM transactions WHERE purchase_date >= DATE_SUB(CURDATE(), INTERVAL 365 DAY)
)
SELECT b.title, SUM(r.price) AS rev
FROM recent r JOIN books b ON r.book_id=b.book_id
GROUP BY b.title
ORDER BY rev DESC
LIMIT 5;
```

**12. Average time between purchases per customer (days).**

```sql
WITH seq AS (
  SELECT customer_id, purchase_date,
         LAG(purchase_date) OVER (PARTITION BY customer_id ORDER BY purchase_date) AS prev_dt
  FROM transactions
), gaps AS (
  SELECT customer_id, DATEDIFF(purchase_date, prev_dt) AS gap_days
  FROM seq WHERE prev_dt IS NOT NULL
)
SELECT c.customer_id, c.name, AVG(g.gap_days) AS avg_days_between
FROM gaps g JOIN customers c ON c.customer_id=g.customer_id
GROUP BY c.customer_id, c.name
ORDER BY avg_days_between;
```

