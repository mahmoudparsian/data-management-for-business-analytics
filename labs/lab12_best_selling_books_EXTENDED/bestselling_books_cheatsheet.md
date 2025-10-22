# 📘 Best-Selling Books SQL Cheat Sheet

## 📐 Schema

**Books Table**
```sql
books(
  book_id INT PRIMARY KEY,
  title VARCHAR(200),
  author VARCHAR(120),
  year_published INT,
  genre VARCHAR(60),
  sales_band VARCHAR(20),
  source VARCHAR(255)
);
```

**Sales Snapshots Table**
```sql
book_sales(
  snapshot_id INT PRIMARY KEY,
  book_id INT,
  year INT,
  market VARCHAR(10),   -- US, UK, EU, APAC, LATAM
  channel VARCHAR(10),  -- Retail, Online
  units_sold_thousands INT
);
```

---

## 🔹 Basic Queries

- List all 21st-century titles:
```sql
SELECT title, author, year_published
FROM books
WHERE year_published >= 2000;
```

- Count titles by genre:
```sql
SELECT genre, COUNT(*) AS num_titles
FROM books
GROUP BY genre;
```

- Find titles with 'Girl' in the name:
```sql
SELECT title FROM books WHERE title LIKE '%Girl%';
```

- Total units sold by market:
```sql
SELECT market, SUM(units_sold_thousands) AS total_k
FROM book_sales
GROUP BY market;
```

---

## 🔹 Intermediate Queries (WITH + Ranking)

- Rank titles by total units sold:
```sql
WITH Totals AS (
  SELECT b.title, SUM(s.units_sold_thousands) AS total_k
  FROM book_sales s JOIN books b ON b.book_id = s.book_id
  GROUP BY b.title
)
SELECT title, total_k,
       RANK() OVER (ORDER BY total_k DESC) AS sales_rank
FROM Totals;
```

- Top 3 titles per market:
```sql
WITH M AS (
  SELECT b.title, s.market, SUM(s.units_sold_thousands) AS total_k
  FROM book_sales s JOIN books b ON b.book_id = s.book_id
  GROUP BY b.title, s.market
),
R AS (
  SELECT market, title, total_k,
         RANK() OVER (PARTITION BY market ORDER BY total_k DESC) AS rnk
  FROM M
)
SELECT * FROM R WHERE rnk <= 3;
```

---

## 📌 Tips

- Use **`LIKE '%keyword%'`** for flexible title search.  
- Use **`GROUP BY`** for aggregation (count, sum, avg).  
- Use **CTEs (`WITH`) + window functions** for advanced analytics.  
- Large datasets (50k rows) are best for performance testing.

---
