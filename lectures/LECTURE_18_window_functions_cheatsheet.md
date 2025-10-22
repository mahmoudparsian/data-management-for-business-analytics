
# 📑 MySQL Window Functions Cheat Sheet

Window functions operate over a set of rows (a *window*) and return a value for each row, without collapsing rows like aggregate functions.

---

## 🔹 General Syntax

```sql
function_name(expression) 
OVER (
    PARTITION BY column_name
    ORDER BY column_name
)
```

- **PARTITION BY** → divides the result set into groups (like GROUP BY, but rows remain separate).  
- **ORDER BY** → defines ordering within each partition.  

---

## 🔹 1. ROW_NUMBER()

- Assigns a unique sequential number to each row within a partition.  
- No ties → every row gets a different number.  

### Example: Number movies by average rating
```sql
WITH MovieAvg AS (
  SELECT m.title, AVG(r.rating) AS avg_rating
  FROM movies m JOIN ratings r ON m.movieId = r.movieId
  GROUP BY m.title
)
SELECT title, avg_rating,
       ROW_NUMBER() OVER (ORDER BY avg_rating DESC) AS rownum
FROM MovieAvg
LIMIT 10;
```

✅ Output (illustrative):

| title          | avg_rating | rownum |
|----------------|------------|--------|
| Movie A        | 4.9        | 1      |
| Movie B        | 4.8        | 2      |
| Movie C        | 4.7        | 3      |

---

## 🔹 2. RANK()

- Assigns ranks with **gaps** if there are ties.  

### Example: Rank movies by number of ratings
```sql
WITH MovieCounts AS (
  SELECT m.title, COUNT(r.rating) AS cnt
  FROM movies m JOIN ratings r ON m.movieId = r.movieId
  GROUP BY m.title
)
SELECT title, cnt,
       RANK() OVER (ORDER BY cnt DESC) AS ranking
FROM MovieCounts
LIMIT 10;
```

✅ Output (illustrative):

| title   | cnt | ranking |
|---------|-----|---------|
| Movie A | 500 | 1       |
| Movie B | 500 | 1       |
| Movie C | 450 | 3       |

Notice: **rank 2 is skipped** because of a tie.

---

## 🔹 3. DENSE_RANK()

- Similar to RANK(), but **no gaps** in ranking.  

### Example: Rank genres by average rating
```sql
WITH GenreAvg AS (
  SELECT m.genres, AVG(r.rating) AS avg_rating
  FROM movies m JOIN ratings r ON m.movieId = r.movieId
  GROUP BY m.genres
)
SELECT genres, avg_rating,
       DENSE_RANK() OVER (ORDER BY avg_rating DESC) AS ranking
FROM GenreAvg
LIMIT 10;
```

✅ Output (illustrative):

| genres       | avg_rating | ranking |
|--------------|------------|---------|
| Comedy       | 4.8        | 1       |
| Action       | 4.8        | 1       |
| Drama        | 4.7        | 2       |

No gap → next rank is **2**.

---

## 🔹 4. NTILE(N)

- Divides rows into `N` buckets of nearly equal size.  
- Useful for quartiles, deciles, etc.  

### Example: Split movies into 4 groups by avg rating
```sql
WITH MovieAvg AS (
  SELECT m.title, AVG(r.rating) AS avg_rating
  FROM movies m JOIN ratings r ON m.movieId = r.movieId
  GROUP BY m.title
)
SELECT title, avg_rating,
       NTILE(4) OVER (ORDER BY avg_rating DESC) AS quartile
FROM MovieAvg
LIMIT 10;
```

✅ Output (illustrative):

| title    | avg_rating | quartile |
|----------|------------|----------|
| Movie A  | 4.9        | 1        |
| Movie B  | 4.7        | 1        |
| Movie C  | 4.5        | 2        |

---

## 🔹 5. LEAD() and LAG()

- **LEAD()** → access value from the next row.  
- **LAG()** → access value from the previous row.  

### Example: Compare a movie’s avg rating with the previous movie
```sql
WITH MovieAvg AS (
  SELECT m.title, AVG(r.rating) AS avg_rating
  FROM movies m JOIN ratings r ON m.movieId = r.movieId
  GROUP BY m.title
)
SELECT title, avg_rating,
       LAG(avg_rating, 1) OVER (ORDER BY avg_rating DESC) AS prev_rating,
       LEAD(avg_rating, 1) OVER (ORDER BY avg_rating DESC) AS next_rating
FROM MovieAvg
LIMIT 10;
```

✅ Output (illustrative):

| title    | avg_rating | prev_rating | next_rating |
|----------|------------|-------------|-------------|
| Movie A  | 4.9        | NULL        | 4.8         |
| Movie B  | 4.8        | 4.9         | 4.7         |
| Movie C  | 4.7        | 4.8         | 4.6         |

---

# 📝 Key Takeaways

- `ROW_NUMBER()` → unique sequence.  
- `RANK()` → ranking with gaps on ties.  
- `DENSE_RANK()` → ranking without gaps.  
- `NTILE(N)` → divide into buckets.  
- `LEAD()` / `LAG()` → look ahead or behind rows.  

These functions are powerful for **analytics, leaderboards, comparisons, and reporting**.

---
