# MovieLens Complex Queries with WITH and Ranking

### 1. Find top 10 movies with more than 100 ratings, ranked by average rating
```sql
WITH MovieStats AS (
  SELECT m.title, COUNT(r.rating) AS cnt, AVG(r.rating) AS avg_rating
  FROM movies m JOIN ratings r ON m.movieId = r.movieId
  GROUP BY m.title
  HAVING COUNT(r.rating) > 100
)
SELECT title, avg_rating,
       RANK() OVER (ORDER BY avg_rating DESC) AS ranking
FROM MovieStats
LIMIT 10;
```

### 2. Find top 10 users with highest average rating (min 50 ratings)
```sql
WITH UserStats AS (
  SELECT userId, COUNT(*) AS cnt, AVG(rating) AS avg_rating
  FROM ratings
  GROUP BY userId
  HAVING COUNT(*) >= 50
)
SELECT userId, avg_rating,
       RANK() OVER (ORDER BY avg_rating DESC) AS ranking
FROM UserStats
LIMIT 10;
```

### 3. Find top 10 most common tags with ranking
```sql
WITH TagCounts AS (
  SELECT tag, COUNT(*) AS cnt
  FROM tags
  GROUP BY tag
)
SELECT tag, cnt,
       RANK() OVER (ORDER BY cnt DESC) AS ranking
FROM TagCounts
LIMIT 10;
```

### 4. Find top 10 movies with both Action and Comedy genres ranked by avg rating
```sql
WITH MovieAvg AS (
  SELECT m.title, AVG(r.rating) AS avg_rating
  FROM movies m JOIN ratings r ON m.movieId = r.movieId
  WHERE m.genres LIKE '%Action%' AND m.genres LIKE '%Comedy%'
  GROUP BY m.title
)
SELECT title, avg_rating,
       RANK() OVER (ORDER BY avg_rating DESC) AS ranking
FROM MovieAvg
LIMIT 10;
```

### 5. Find top 10 movies with most distinct users tagging them
```sql
WITH MovieTags AS (
  SELECT m.title, COUNT(DISTINCT t.userId) AS user_cnt
  FROM movies m JOIN tags t ON m.movieId = t.movieId
  GROUP BY m.title
)
SELECT title, user_cnt,
       RANK() OVER (ORDER BY user_cnt DESC) AS ranking
FROM MovieTags
LIMIT 10;
```

### 6. Find top 10 movies whose avg rating is above overall avg
```sql
WITH Overall AS (
  SELECT AVG(rating) AS overall_avg FROM ratings
),
MovieAvg AS (
  SELECT m.title, AVG(r.rating) AS avg_rating
  FROM movies m JOIN ratings r ON m.movieId = r.movieId
  GROUP BY m.title
)
SELECT title, avg_rating
FROM MovieAvg, Overall
WHERE avg_rating > overall_avg
LIMIT 10;
```

### 7. Find top 10 users who used the most distinct tags
```sql
WITH UserTagCounts AS (
  SELECT userId, COUNT(DISTINCT tag) AS cnt
  FROM tags
  GROUP BY userId
)
SELECT userId, cnt,
       RANK() OVER (ORDER BY cnt DESC) AS ranking
FROM UserTagCounts
LIMIT 10;
```

### 8. Find top 10 movies by weighted rating (average rating * count)
```sql
WITH MovieStats AS (
  SELECT m.title, COUNT(r.rating) AS cnt, AVG(r.rating) AS avg_rating
  FROM movies m JOIN ratings r ON m.movieId = r.movieId
  GROUP BY m.title
)
SELECT title, avg_rating * cnt AS weighted_score
FROM MovieStats
ORDER BY weighted_score DESC
LIMIT 10;
```

### 9. Find top 10 tags applied to movies with average rating > 4.0
```sql
WITH HighRatedMovies AS (
  SELECT m.movieId
  FROM movies m JOIN ratings r ON m.movieId = r.movieId
  GROUP BY m.movieId
  HAVING AVG(r.rating) > 4.0
)
SELECT t.tag, COUNT(*) AS cnt
FROM tags t JOIN HighRatedMovies h ON t.movieId = h.movieId
GROUP BY t.tag
ORDER BY cnt DESC
LIMIT 10;
```

### 10. Find top 10 movies tagged as 'classic' ranked by avg rating
```sql
WITH ClassicMovies AS (
  SELECT DISTINCT m.movieId, m.title
  FROM movies m JOIN tags t ON m.movieId = t.movieId
  WHERE t.tag LIKE '%classic%'
),
MovieAvg AS (
  SELECT m.movieId, AVG(r.rating) AS avg_rating
  FROM ratings r JOIN ClassicMovies m ON r.movieId = m.movieId
  GROUP BY m.movieId
)
SELECT c.title, avg_rating,
       RANK() OVER (ORDER BY avg_rating DESC) AS ranking
FROM ClassicMovies c JOIN MovieAvg a ON c.movieId = a.movieId
LIMIT 10;
```
