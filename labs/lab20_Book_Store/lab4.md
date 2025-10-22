# Lab 4 — Intermediate+

## Schema (simplified):

```sql
  stores(store_id, store_location, city, country)

  customers(customer_id, name, email, gender, age, city, country)

  books(book_id, ISBN, title, author, category, published_date)

  transactions(sale_id, store_id, book_id, customer_id, purchase_date, price)
```

## Customer Value & Cohorts

**1. Top 10 customers by spend.**

```sql
SELECT c.customer_id, c.name, SUM(t.price) AS total_spent
FROM customers c JOIN transactions t ON c.customer_id=t.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 10;
```

**2. Avg spend per transaction by country (store location).**

```sql
SELECT s.country, AVG(t.price) AS avg_ticket
FROM transactions t JOIN stores s ON t.store_id=s.store_id
GROUP BY s.country
ORDER BY avg_ticket DESC;
```

**3. Customer age buckets and average spend.**

```sql
WITH bucket AS (
  SELECT c.customer_id, CASE
    WHEN age < 25 THEN 'Under 25'
    WHEN age BETWEEN 25 AND 39 THEN '25-39'
    WHEN age BETWEEN 40 AND 59 THEN '40-59'
    ELSE '60+'
  END AS age_bucket
  FROM customers c
), spend AS (
  SELECT t.customer_id, SUM(t.price) AS total_spent FROM transactions t GROUP BY customer_id
)
SELECT b.age_bucket, AVG(s.total_spent) AS avg_spent
FROM bucket b LEFT JOIN spend s ON b.customer_id=s.customer_id
GROUP BY b.age_bucket
ORDER BY avg_spent DESC;
```

**4. Repeat purchasers (2+ transactions).**

```sql
SELECT c.customer_id, c.name, COUNT(*) AS num_tx
FROM customers c JOIN transactions t ON c.customer_id=t.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(*) >= 2
ORDER BY num_tx DESC;
```

**5. Churn proxy: customers with no purchases since 2024-01-01.**

```sql
SELECT c.customer_id, c.name
FROM customers c LEFT JOIN (
  SELECT customer_id, MAX(purchase_date) AS last_dt
  FROM transactions GROUP BY customer_id
) x ON c.customer_id=x.customer_id
WHERE x.last_dt IS NULL OR x.last_dt < '2024-01-01';
```

**6. Most popular category per city (by units).**

```sql
WITH cat_city AS (
  SELECT s.city, b.category, COUNT(*) AS units
  FROM transactions t JOIN stores s ON t.store_id=s.store_id
  JOIN books b ON t.book_id=b.book_id
  GROUP BY s.city, b.category
), ranked AS (
  SELECT city, category, units,
         ROW_NUMBER() OVER (PARTITION BY city ORDER BY units DESC) AS rn
  FROM cat_city
)
SELECT * FROM ranked WHERE rn=1 ORDER BY city;
```

## Supply & Pricing

**7. Price distribution per category (avg, min, max).**

```sql
SELECT b.category, AVG(t.price) AS avg_p, MIN(t.price) AS min_p, MAX(t.price) AS max_p
FROM transactions t JOIN books b ON t.book_id=b.book_id
GROUP BY b.category
ORDER BY avg_p DESC;
```

**8. High-priced transactions (> 30) with details.**

```sql
SELECT t.sale_id, s.city, b.title, c.name, t.price
FROM transactions t
JOIN stores s ON t.store_id=s.store_id
JOIN books b ON t.book_id=b.book_id
JOIN customers c ON t.customer_id=c.customer_id
WHERE t.price > 30
ORDER BY t.price DESC;
```

**9. Month-over-month revenue growth (company-wide).**

```sql
WITH m AS (
  SELECT DATE_FORMAT(purchase_date,'%Y-%m') AS month, SUM(price) AS rev
  FROM transactions GROUP BY month
), r AS (
  SELECT month, rev, LAG(rev) OVER (ORDER BY month) AS prev_rev FROM m
)
SELECT month, rev, ROUND(100*(rev - prev_rev)/prev_rev,2) AS pct_growth
FROM r;
```

**10. Store share of revenue by country.**

```sql
WITH srev AS (
  SELECT s.country, s.store_id, s.city, SUM(t.price) AS rev
  FROM stores s LEFT JOIN transactions t ON s.store_id=t.store_id
  GROUP BY s.country, s.store_id, s.city
), tot AS (
  SELECT country, SUM(rev) AS total_rev FROM srev GROUP BY country
)
SELECT s.country, s.city, s.rev, ROUND(100*s.rev/t.total_rev,2) AS pct_of_country
FROM srev s JOIN tot t ON s.country=t.country
ORDER BY s.country, pct_of_country DESC;
```

**11. Authors ranked by revenue within category.**

```sql
WITH ar AS (
  SELECT b.category, b.author, SUM(t.price) AS rev
  FROM books b JOIN transactions t ON b.book_id=t.book_id
  GROUP BY b.category, b.author
)
SELECT *, RANK() OVER (PARTITION BY category ORDER BY rev DESC) AS rnk
FROM ar
ORDER BY category, rnk;
```

**12. Best-selling book per store (by units).**

```sql
WITH u AS (
  SELECT s.store_id, s.city, b.title, COUNT(*) AS units
  FROM transactions t JOIN stores s ON t.store_id=s.store_id
  JOIN books b ON t.book_id=b.book_id
  GROUP BY s.store_id, s.city, b.title
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY store_id ORDER BY units DESC) AS rn FROM u
)
SELECT store_id, city, title, units FROM r WHERE rn=1 ORDER BY city;
```

