# 🧾 Books (One-Table) — 30 SQL Queries (MySQL 8+)

Schema:
```sql
books(book_id, title, author, year_published, genre, sales_band, source)
```

---

## 15 Basic Queries

1) List all titles alphabetically
```sql
SELECT title FROM books ORDER BY title;
```

2) Books published since 2000
```sql
SELECT title, author, year_published
FROM books
WHERE year_published >= 2000
ORDER BY year_published, title;
```

3) Find all Fantasy books
```sql
SELECT title, author FROM books WHERE genre='Fantasy' ORDER BY title;
```

4) Books by 'Dan Brown'
```sql
SELECT title, year_published FROM books WHERE author='Dan Brown' ORDER BY year_published;
```

5) Titles containing 'Girl'
```sql
SELECT book_id, title FROM books WHERE title LIKE '%Girl%' ORDER BY title;
```

6) Count books per genre
```sql
SELECT genre, COUNT(*) AS num_titles
FROM books
GROUP BY genre
ORDER BY num_titles DESC;
```

7) Distinct authors
```sql
SELECT DISTINCT author FROM books ORDER BY author;
```

8) Earliest and latest publication year
```sql
SELECT MIN(year_published) AS first_year, MAX(year_published) AS last_year
FROM books;
```

9) Titles by decade
```sql
SELECT (year_published DIV 10)*10 AS decade, COUNT(*) AS titles
FROM books
GROUP BY decade
ORDER BY decade;
```

10) Top 10 most common author last names (rough heuristic)
```sql
SELECT SUBSTRING_INDEX(author, ' ', -1) AS last_name, COUNT(*) AS cnt
FROM books
GROUP BY last_name
ORDER BY cnt DESC, last_name
LIMIT 10;
```

11) Books with sales band '50M+'
```sql
SELECT title, author FROM books WHERE sales_band='50M+' ORDER BY title;
```

12) Books with sales band containing '40'
```sql
SELECT title, sales_band FROM books WHERE sales_band LIKE '%40%' ORDER BY title;
```

13) Genres represented (alphabetical)
```sql
SELECT DISTINCT genre FROM books ORDER BY genre;
```

14) Authors with multiple titles (>= 2)
```sql
SELECT author, COUNT(*) AS titles
FROM books
GROUP BY author
HAVING COUNT(*) >= 2
ORDER BY titles DESC, author;
```

15) Case-insensitive search for 'the' in title
```sql
SELECT title FROM books WHERE LOWER(title) LIKE '%the%' ORDER BY title;
```

---

## 10 Intermediate (CTEs, Grouping, Ranking)

1) Rank authors by number of titles
```sql
WITH A AS (
  SELECT author, COUNT(*) AS titles
  FROM books
  GROUP BY author
)
SELECT author, titles,
       RANK() OVER (ORDER BY titles DESC) AS author_rank
FROM A
ORDER BY author_rank, author;
```

2) Rank genres by number of titles
```sql
WITH G AS (
  SELECT genre, COUNT(*) AS num_titles
  FROM books
  GROUP BY genre
)
SELECT genre, num_titles,
       DENSE_RANK() OVER (ORDER BY num_titles DESC) AS genre_rank
FROM G
ORDER BY genre_rank, genre;
```

3) Top 3 authors by title count
```sql
WITH A AS (
  SELECT author, COUNT(*) AS titles
  FROM books
  GROUP BY author
)
SELECT author, titles
FROM (
  SELECT author, titles,
         RANK() OVER (ORDER BY titles DESC) AS rnk
  FROM A
) x
WHERE rnk <= 3
ORDER BY rnk, author;
```

4) Decade-level counts with running total (by decade)
```sql
WITH D AS (
  SELECT (year_published DIV 10)*10 AS decade, COUNT(*) AS titles
  FROM books
  GROUP BY decade
)
SELECT decade, titles,
       SUM(titles) OVER (ORDER BY decade) AS running_total
FROM D
ORDER BY decade;
```

5) Map sales_band to numeric score for ordering
```sql
WITH S AS (
  SELECT title, author, sales_band,
         CASE
           WHEN sales_band LIKE '50M%%' THEN 5
           WHEN sales_band LIKE '4%%' OR sales_band LIKE '30%%' THEN 4
           WHEN sales_band LIKE '20%%' THEN 3
           WHEN sales_band LIKE '10%%' THEN 2
           ELSE 1
         END AS band_score
  FROM books
)
SELECT title, author, sales_band, band_score,
       RANK() OVER (ORDER BY band_score DESC, title) AS band_rank
FROM S
ORDER BY band_rank
LIMIT 30;
```

6) Most frequent author last names (ranked)
```sql
WITH L AS (
  SELECT SUBSTRING_INDEX(author, ' ', -1) AS last_name, COUNT(*) AS cnt
  FROM books
  GROUP BY last_name
)
SELECT last_name, cnt,
       DENSE_RANK() OVER (ORDER BY cnt DESC) AS name_rank
FROM L
ORDER BY name_rank, last_name
LIMIT 20;
```

7) Genre mix per half-century (pre/post 1950)
```sql
WITH B AS (
  SELECT CASE WHEN year_published < 1950 THEN 'Pre-1950' ELSE '1950+' END AS era,
         genre, COUNT(*) AS titles
  FROM books
  GROUP BY era, genre
)
SELECT era, genre, titles,
       RANK() OVER (PARTITION BY era ORDER BY titles DESC) AS rnk_in_era
FROM B
ORDER BY era, rnk_in_era, genre;
```

8) Authors with consecutive-decade publications (by presence)
```sql
WITH D AS (
  SELECT author, DISTINCTROW (year_published DIV 10)*10 AS decade
  FROM books
),
J AS (
  SELECT d1.author, d1.decade AS decade1, d2.decade AS decade2
  FROM D d1 JOIN D d2
    ON d1.author = d2.author AND d2.decade = d1.decade + 10
)
SELECT author, decade1, decade2
FROM J
ORDER BY author, decade1;
```

9) Titles per century with share
```sql
WITH C AS (
  SELECT CASE
           WHEN year_published < 1800 THEN 'Pre-1800'
           WHEN year_published < 1900 THEN '1800s'
           WHEN year_published < 2000 THEN '1900s'
           ELSE '2000s'
         END AS century_bucket,
         COUNT(*) AS titles
  FROM books
  GROUP BY century_bucket
),
T AS ( SELECT SUM(titles) AS total FROM C )
SELECT c.century_bucket, c.titles,
       ROUND(100.0 * c.titles / t.total, 2) AS pct
FROM C c CROSS JOIN T t
ORDER BY c.century_bucket;
```

10) Longest titles (by character length) with rank
```sql
WITH L AS (
  SELECT title, CHAR_LENGTH(title) AS len
  FROM books
)
SELECT title, len,
       RANK() OVER (ORDER BY len DESC) AS len_rank
FROM L
ORDER BY len_rank
LIMIT 20;
```

---

## 5 Advanced (optional)

1) “Vintage” leaders: rank pre-1950 authors by count
```sql
WITH B AS (
  SELECT author, COUNT(*) AS titles
  FROM books
  WHERE year_published < 1950
  GROUP BY author
)
SELECT author, titles,
       DENSE_RANK() OVER (ORDER BY titles DESC) AS vintage_rank
FROM B
ORDER BY vintage_rank, author;
```

2) Genre diversity per author (number of distinct genres)
```sql
WITH G AS (
  SELECT author, COUNT(DISTINCT genre) AS genre_count
  FROM books
  GROUP BY author
)
SELECT author, genre_count,
       RANK() OVER (ORDER BY genre_count DESC, author) AS diversity_rank
FROM G
ORDER BY diversity_rank
LIMIT 20;
```

3) Best-seller band histogram
```sql
WITH S AS (
  SELECT sales_band, COUNT(*) AS cnt
  FROM books
  GROUP BY sales_band
)
SELECT sales_band, cnt,
       RANK() OVER (ORDER BY cnt DESC) AS band_popularity
FROM S
ORDER BY band_popularity, sales_band;
```

4) Rolling 3-decade window of titles
```sql
WITH D AS (
  SELECT (year_published DIV 10)*10 AS decade, COUNT(*) AS titles
  FROM books
  GROUP BY decade
)
SELECT decade, titles,
       SUM(titles) OVER (ORDER BY decade ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS titles_3dec
FROM D
ORDER BY decade;
```

5) “Evergreen” authors: at least one title in both eras
```sql
WITH E AS (
  SELECT author,
         MAX(year_published < 1950) AS has_pre1950,
         MAX(year_published >= 1950) AS has_1950plus
  FROM books
  GROUP BY author
)
SELECT author
FROM E
WHERE has_pre1950 = 1 AND has_1950plus = 1
ORDER BY author;
```
