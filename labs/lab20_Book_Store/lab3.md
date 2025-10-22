# Lab 3 — Intermediate

# Schema (simplified):

```sql
  stores(store_id, store_location, city, country)

  customers(customer_id, name, email, gender, age, city, country)

  books(book_id, ISBN, title, author, category, published_date)

  transactions(sale_id, store_id, book_id, customer_id, purchase_date, price)
```

## Subqueries & Filters

**1. Books priced above overall average sale price.**

```sql
SELECT DISTINCT b.title
FROM books b JOIN transactions t ON b.book_id=t.book_id
WHERE t.price > (SELECT AVG(price) FROM transactions);
```

**2. Customers who purchased more than the average number of books.**

```sql
WITH per_customer AS (
  SELECT customer_id, COUNT(*) AS cnt FROM transactions GROUP BY customer_id
)
SELECT c.customer_id, c.name, pc.cnt
FROM per_customer pc JOIN customers c ON c.customer_id=pc.customer_id
WHERE pc.cnt > (SELECT AVG(cnt) FROM per_customer)
ORDER BY pc.cnt DESC;
```

**3. Top 10 books by units sold.**

```sql
SELECT b.title, COUNT(*) AS units
FROM transactions t JOIN books b ON t.book_id=b.book_id
GROUP BY b.title
ORDER BY units DESC
LIMIT 10;
```

**4. Customers who only bought 'Fiction'.**

```sql
WITH cust_cat AS (
  SELECT c.customer_id, COUNT(DISTINCT b.category) AS cats
  FROM customers c
  JOIN transactions t ON c.customer_id=t.customer_id
  JOIN books b ON t.book_id=b.book_id
  GROUP BY c.customer_id
)
SELECT c.customer_id, c.name
FROM cust_cat cc JOIN customers c ON c.customer_id=cc.customer_id
WHERE cc.cats = 1;
```

**5. Stores with zero transactions in 2025.**

```sql
SELECT s.store_id, s.city
FROM stores s
LEFT JOIN (
  SELECT store_id FROM transactions WHERE purchase_date BETWEEN '2025-01-01' AND '2025-12-31' GROUP BY store_id
) t ON t.store_id=s.store_id
WHERE t.store_id IS NULL;
```

**6. Authors never sold in Spain.**

```sql
SELECT DISTINCT b.author
FROM books b
WHERE b.author NOT IN (
  SELECT DISTINCT b2.author FROM books b2
  JOIN transactions t ON b2.book_id=t.book_id
  JOIN stores s ON t.store_id=s.store_id
  WHERE s.country='Spain'
)
ORDER BY b.author;
```

## Ranking & Time

**7. Rank stores by total revenue.**

```sql
WITH store_rev AS (
  SELECT s.store_id, s.city, SUM(t.price) AS rev
  FROM stores s JOIN transactions t ON s.store_id=t.store_id
  GROUP BY s.store_id, s.city
)
SELECT *, RANK() OVER (ORDER BY rev DESC) AS rev_rank
FROM store_rev
ORDER BY rev_rank;
```

**8. Top 3 categories by units per country.**

```sql
WITH cat_country AS (
  SELECT s.country, b.category, COUNT(*) AS units
  FROM transactions t
  JOIN stores s ON t.store_id=s.store_id
  JOIN books b ON t.book_id=b.book_id
  GROUP BY s.country, b.category
), ranked AS (
  SELECT country, category, units,
         RANK() OVER (PARTITION BY country ORDER BY units DESC) AS rnk
  FROM cat_country
)
SELECT * FROM ranked WHERE rnk <= 3
ORDER BY country, rnk;
```

**9. Running monthly revenue (company-wide).**

```sql
WITH m AS (
  SELECT DATE_FORMAT(purchase_date,'%Y-%m') AS month, SUM(price) AS rev
  FROM transactions GROUP BY month
)
SELECT month, rev, SUM(rev) OVER (ORDER BY month) AS running_rev
FROM m ORDER BY month;
```

**10. Newest 5 customers who purchased in Tokyo.**

```sql
SELECT c.customer_id, c.name, MAX(t.purchase_date) AS last_purchase
FROM customers c JOIN transactions t ON c.customer_id=t.customer_id
JOIN stores s ON t.store_id=s.store_id
WHERE s.city='Tokyo'
GROUP BY c.customer_id, c.name
ORDER BY last_purchase DESC
LIMIT 5;
```

**11. Most recent sale per store.**

```sql
WITH last_sale AS (
  SELECT store_id, MAX(purchase_date) AS last_dt FROM transactions GROUP BY store_id
)
SELECT s.store_id, s.city, l.last_dt
FROM stores s LEFT JOIN last_sale l ON s.store_id=l.store_id
ORDER BY s.city;
```

**12. Books with above-average price in 2024.**

```sql
WITH avg24 AS (
  SELECT AVG(price) AS a FROM transactions WHERE purchase_date BETWEEN '2024-01-01' AND '2024-12-31'
)
SELECT DISTINCT b.title
FROM transactions t JOIN books b ON t.book_id=b.book_id, avg24
WHERE t.purchase_date BETWEEN '2024-01-01' AND '2024-12-31' AND t.price > avg24.a;
```

