# MovieLens Intermediate Queries with WITH and Ranking

### 1. Top 10 movies by average rating using WITH
```sql
WITH MovieAvg AS (
  SELECT m.movieId, m.title, AVG(r.rating) AS avg_rating
  FROM movies m JOIN ratings r ON m.movieId = r.movieId
  GROUP BY m.movieId, m.title
)
SELECT * FROM MovieAvg ORDER BY avg_rating DESC LIMIT 10;
```

### 2. Top 10 users by rating count using WITH
```sql
WITH UserCounts AS (
  SELECT userId, COUNT(*) AS cnt
  FROM ratings
  GROUP BY userId
)
SELECT * FROM UserCounts ORDER BY cnt DESC LIMIT 10;
```

### 3. Rank movies by number of ratings
```sql
WITH MovieCounts AS (
  SELECT m.movieId, m.title, COUNT(r.rating) AS cnt
  FROM movies m JOIN ratings r ON m.movieId = r.movieId
  GROUP BY m.movieId, m.title
)
SELECT m.title, cnt,
       RANK() OVER (ORDER BY cnt DESC) AS ranking
FROM MovieCounts
LIMIT 10;
```

### 4. Rank movies by average rating
```sql
WITH MovieAvg AS (
  SELECT m.movieId, m.title, AVG(r.rating) AS avg_rating
  FROM movies m JOIN ratings r ON m.movieId = r.movieId
  GROUP BY m.movieId, m.title
)
SELECT m.title, avg_rating,
       RANK() OVER (ORDER BY avg_rating DESC) AS ranking
FROM MovieAvg
LIMIT 10;
```

### 5. Find top 10 most tagged movies
```sql
WITH TagCounts AS (
  SELECT m.movieId, m.title, COUNT(*) AS cnt
  FROM movies m JOIN tags t ON m.movieId = t.movieId
  GROUP BY m.movieId, m.title
)
SELECT * FROM TagCounts ORDER BY cnt DESC LIMIT 10;
```

### 6. Rank users by number of tags
```sql
WITH UserTags AS (
  SELECT userId, COUNT(*) AS cnt
  FROM tags
  GROUP BY userId
)
SELECT userId, cnt,
       RANK() OVER (ORDER BY cnt DESC) AS ranking
FROM UserTags
LIMIT 10;
```

### 7. Find 10 movies with avg rating and rank between 3 and 5
```sql
WITH MovieAvg AS (
  SELECT m.title, AVG(r.rating) AS avg_rating
  FROM movies m JOIN ratings r ON m.movieId = r.movieId
  GROUP BY m.title
)
SELECT m.title, avg_rating,
       RANK() OVER (ORDER BY avg_rating DESC) AS ranking
FROM MovieAvg m
LIMIT 10;
```

### 8. Top 10 tags by frequency using WITH
```sql
WITH TagCounts AS (
  SELECT tag, COUNT(*) AS cnt
  FROM tags
  GROUP BY tag
)
SELECT * FROM TagCounts ORDER BY cnt DESC LIMIT 10;
```

### 9. Rank regions of movies by rating count (mock example: by first letter of title)
```sql
WITH RegionCounts AS (
  SELECT LEFT(m.title,1) AS region, COUNT(r.rating) AS cnt
  FROM movies m JOIN ratings r ON m.movieId = r.movieId
  GROUP BY LEFT(m.title,1)
)
SELECT region, cnt,
       RANK() OVER (ORDER BY cnt DESC) AS ranking
FROM RegionCounts
LIMIT 10;
```

### 10. Rank users by average rating given
```sql
WITH UserAvg AS (
  SELECT userId, AVG(rating) AS avg_rating
  FROM ratings
  GROUP BY userId
)
SELECT userId, avg_rating,
       RANK() OVER (ORDER BY avg_rating DESC) AS ranking
FROM UserAvg
LIMIT 10;
```
