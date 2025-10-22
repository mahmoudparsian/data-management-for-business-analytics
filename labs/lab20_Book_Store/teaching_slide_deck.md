# 📚 Teaching Slide Deck — Books-on-Cities Labs

---
## 1) Welcome & Setup
- Realistic dataset: **stores**, **customers**, **books**, **transactions**
- Skills: SELECT → JOINs → GROUP BY → subqueries → window functions
- Steps:
  1. `CREATE DATABASE books_on_cities; USE books_on_cities;`
  2. Run: `SOURCE books_on_cities_schema.sql;`
  3. Import CSVs: `SOURCE load_data_infile.sql;`

---
## 2) Schema & ER Diagram
- `stores(store_id PK)` 1—∞ `transactions`
- `customers(customer_id PK)` 1—∞ `transactions`
- `books(book_id PK)` 1—∞ `transactions`
- `transactions(sale_id PK, store_id FK, book_id FK, customer_id FK)`

Teaching tip: Draw the 1-to-many relationships; emphasize why `price` belongs in `transactions`.

---
## 3) Lab 1 — Very Basic (30)
- Single-table queries across all 4 tables
- Focus: `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`, `DISTINCT`
- Example:
```sql
SELECT title, author FROM books WHERE category='Fiction' ORDER BY title LIMIT 10;
```

---
## 4) Lab 2 — Basics + Intro-Intermediate (30)
- Add simple JOINs & aggregates
- Examples:
```sql
-- Tx with store city + book title
SELECT t.sale_id, s.city, b.title, t.price
FROM transactions t
JOIN stores s ON t.store_id = s.store_id
JOIN books  b ON t.book_id  = b.book_id
LIMIT 20;

-- Avg price per category
SELECT b.category, AVG(t.price) AS avg_price
FROM transactions t JOIN books b ON t.book_id=b.book_id
GROUP BY b.category
ORDER BY avg_price DESC;
```

---
## 5) Lab 3 — Intermediate (30)
- GROUP BY + HAVING, subqueries with `WITH`, time filters
- Example:
```sql
WITH per_customer AS (
  SELECT customer_id, COUNT(*) AS cnt
  FROM transactions GROUP BY customer_id
)
SELECT c.customer_id, c.name, pc.cnt
FROM per_customer pc JOIN customers c ON c.customer_id=pc.customer_id
WHERE pc.cnt > (SELECT AVG(cnt) FROM per_customer);
```

---
## 6) Lab 4 — Intermediate+ (30)
- Window functions, multi-joins, cohort-style logic
- Example:
```sql
WITH store_rev AS (
  SELECT s.store_id, s.city, SUM(t.price) AS rev
  FROM stores s JOIN transactions t ON s.store_id=t.store_id
  GROUP BY s.store_id, s.city
)
SELECT *, RANK() OVER (ORDER BY rev DESC) AS rev_rank
FROM store_rev;
```

---
## 7) Lab 5 — Advanced (30)
- Business analytics: rankings per group, MoM growth, power users
- Example:
```sql
WITH m AS (
  SELECT DATE_FORMAT(purchase_date,'%Y-%m') AS ym, SUM(price) AS rev
  FROM transactions GROUP BY ym
), r AS (
  SELECT ym, rev, LAG(rev) OVER (ORDER BY ym) AS prev_rev FROM m
)
SELECT ym, rev, ROUND(100*(rev - prev_rev)/prev_rev,2) AS pct_growth
FROM r;
```

---
## 8) Wrap-up & Extensions
- Add inventory, suppliers, employees for advanced joins
- Introduce indexes and EXPLAIN plans
- Mini-project ideas: build a metrics dashboard from SQL outputs