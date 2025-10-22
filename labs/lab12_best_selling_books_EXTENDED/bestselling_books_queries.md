# 📚 Best-Selling Books — SQL Query Pack

**Schema**

```sql
books(book_id, title, author, year_published, genre, sales_band, source)
book_sales(snapshot_id, book_id, year, market, channel, units_sold_thousands)
```

---

## 15 Basic Queries

1) 21st-century titles
```sql
SELECT title, author, year_published FROM books WHERE year_published >= 2000 ORDER BY year_published, title;
```

2) All Fantasy titles
```sql
SELECT title, author FROM books WHERE genre='Fantasy' ORDER BY title;
```

3) Titles by 'Dan Brown'
```sql
SELECT title, year_published FROM books WHERE author='Dan Brown' ORDER BY year_published;
```

4) Count by genre
```sql
SELECT genre, COUNT(*) AS num_titles FROM books GROUP BY genre ORDER BY num_titles DESC;
```

5) Min/Max publication year
```sql
SELECT MIN(year_published) AS first_year, MAX(year_published) AS last_year FROM books;
```

6) Distinct sales bands
```sql
SELECT DISTINCT sales_band FROM books ORDER BY sales_band;
```

7) Find 'Girl' in title
```sql
SELECT book_id, title FROM books WHERE title LIKE '%Girl%' ORDER BY title;
```

8) Snapshots per title (top 10)
```sql
SELECT b.title, COUNT(*) AS snapshots FROM book_sales s JOIN books b ON b.book_id=s.book_id GROUP BY b.title ORDER BY snapshots DESC LIMIT 10;
```

9) Units by market
```sql
SELECT market, SUM(units_sold_thousands) AS total_k FROM book_sales GROUP BY market ORDER BY total_k DESC;
```

10) Units by channel
```sql
SELECT channel, SUM(units_sold_thousands) AS total_k FROM book_sales GROUP BY channel ORDER BY total_k DESC;
```

11) Snapshot year range
```sql
SELECT MIN(year) AS start_year, MAX(year) AS end_year FROM book_sales;
```

12) Snapshots for 'The Hobbit'
```sql
SELECT s.year, s.market, s.channel, s.units_sold_thousands FROM book_sales s JOIN books b ON b.book_id=s.book_id WHERE b.title='The Hobbit' ORDER BY s.year, s.market;
```

13) Titles per decade
```sql
SELECT (year_published DIV 10)*10 AS decade, COUNT(*) AS titles FROM books GROUP BY decade ORDER BY decade;
```

14) Markets used
```sql
SELECT DISTINCT market FROM book_sales ORDER BY market;
```

15) Channels used
```sql
SELECT DISTINCT channel FROM book_sales ORDER BY channel;
```

---

## 10 Intermediate (WITH + Ranking)

1) Rank titles by total units
```sql
WITH Totals AS (
  SELECT b.book_id, b.title, SUM(s.units_sold_thousands) AS total_k
  FROM book_sales s JOIN books b ON b.book_id = s.book_id
  GROUP BY b.book_id, b.title
)
SELECT title, total_k, RANK() OVER (ORDER BY total_k DESC) AS sales_rank
FROM Totals ORDER BY sales_rank LIMIT 30;
```

2) Rank within genre
```sql
WITH G AS (
  SELECT b.book_id, b.title, b.genre, SUM(s.units_sold_thousands) AS total_k
  FROM book_sales s JOIN books b ON b.book_id = s.book_id
  GROUP BY b.book_id, b.title, b.genre
)
SELECT genre, title, total_k,
       RANK() OVER (PARTITION BY genre ORDER BY total_k DESC) AS rnk_in_genre
FROM G ORDER BY genre, rnk_in_genre LIMIT 50;
```

3) Yearly totals + running total
```sql
WITH Y AS (
  SELECT year, SUM(units_sold_thousands) AS total_k FROM book_sales GROUP BY year
)
SELECT year, total_k, SUM(total_k) OVER (ORDER BY year) AS running_k FROM Y ORDER BY year;
```

4) Top 3 per market
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
SELECT market, title, total_k FROM R WHERE rnk <= 3 ORDER BY market, rnk;
```

5) Best year per title
```sql
WITH BY AS (
  SELECT s.book_id, b.title, s.year, SUM(s.units_sold_thousands) AS k
  FROM book_sales s JOIN books b ON b.book_id = s.book_id
  GROUP BY s.book_id, b.title, s.year
),
MX AS ( SELECT book_id, MAX(k) AS kmax FROM BY GROUP BY book_id )
SELECT BY.title, BY.year, BY.k
FROM BY JOIN MX ON BY.book_id = MX.book_id AND BY.k = MX.kmax
ORDER BY BY.title;
```

6) Authors with most titles
```sql
WITH C AS ( SELECT author, COUNT(*) AS titles FROM books GROUP BY author )
SELECT author, titles, RANK() OVER (ORDER BY titles DESC) AS author_rank FROM C ORDER BY author_rank;
```

7) Genre share per year
```sql
WITH YG AS (
  SELECT s.year, b.genre, SUM(s.units_sold_thousands) AS k
  FROM book_sales s JOIN books b ON b.book_id = s.book_id
  GROUP BY s.year, b.genre
),
YT AS ( SELECT year, SUM(k) AS total_k FROM YG GROUP BY year )
SELECT y.year, y.genre, y.k,
       ROUND(100.0 * y.k / t.total_k, 2) AS pct_of_year
FROM YG y JOIN YT t ON y.year = t.year
ORDER BY y.year, pct_of_year DESC;
```

8) Most improved YoY
```sql
WITH YB AS (
  SELECT s.book_id, b.title, s.year, SUM(s.units_sold_thousands) AS k
  FROM book_sales s JOIN books b ON b.book_id = s.book_id
  GROUP BY s.book_id, b.title, s.year
),
D AS (
  SELECT y1.title, y1.year AS year_curr, (y1.k - y0.k) AS delta_k
  FROM YB y1 JOIN YB y0 ON y1.book_id = y0.book_id AND y1.year = y0.year + 1
)
SELECT title, year_curr, delta_k FROM D ORDER BY delta_k DESC LIMIT 20;
```

9) Top authors by units
```sql
WITH A AS (
  SELECT b.author, SUM(s.units_sold_thousands) AS total_k
  FROM book_sales s JOIN books b ON b.book_id = s.book_id
  GROUP BY b.author
)
SELECT author, total_k, DENSE_RANK() OVER (ORDER BY total_k DESC) AS author_rank
FROM A ORDER BY author_rank LIMIT 30;
```

10) Age vs. units
```sql
WITH T AS (
  SELECT b.title, (YEAR(CURDATE()) - b.year_published) AS age_years,
         SUM(s.units_sold_thousands) AS total_k
  FROM books b JOIN book_sales s ON s.book_id = b.book_id
  GROUP BY b.title, b.year_published
)
SELECT title, age_years, total_k,
       RANK() OVER (ORDER BY total_k DESC) AS rank_by_units
FROM T ORDER BY rank_by_units LIMIT 30;
```
