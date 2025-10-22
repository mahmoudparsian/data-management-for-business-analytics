# MovieLens Intermediate Queries

### 1. Find top 10 movies with most ratings
```sql
SELECT m.title, COUNT(r.rating) AS rating_count
FROM movies m JOIN ratings r ON m.movieId = r.movieId
GROUP BY m.title
ORDER BY rating_count DESC
LIMIT 10;
```

### 2. Find top 10 movies with highest average rating
```sql
SELECT m.title, AVG(r.rating) AS avg_rating
FROM movies m JOIN ratings r ON m.movieId = r.movieId
GROUP BY m.title
ORDER BY avg_rating DESC
LIMIT 10;
```

### 3. Find 10 users with most ratings
```sql
SELECT userId, COUNT(*) AS cnt
FROM ratings
GROUP BY userId
ORDER BY cnt DESC
LIMIT 10;
```

### 4. Find 10 most common tags
```sql
SELECT tag, COUNT(*) AS tag_count
FROM tags
GROUP BY tag
ORDER BY tag_count DESC
LIMIT 10;
```

### 5. Find average rating per genre (first 10)
```sql
SELECT m.genres, AVG(r.rating) AS avg_rating
FROM movies m JOIN ratings r ON m.movieId = r.movieId
GROUP BY m.genres
LIMIT 10;
```

### 6. Find 10 movies with more than 50 ratings
```sql
SELECT m.title, COUNT(r.rating) AS rating_count
FROM movies m JOIN ratings r ON m.movieId = r.movieId
GROUP BY m.title
HAVING COUNT(r.rating) > 50
LIMIT 10;
```

### 7. Find 10 users who used the most tags
```sql
SELECT userId, COUNT(*) AS tag_count
FROM tags
GROUP BY userId
ORDER BY tag_count DESC
LIMIT 10;
```

### 8. Find top 10 movies tagged as 'thriller'
```sql
SELECT m.title, COUNT(*) AS cnt
FROM movies m JOIN tags t ON m.movieId = t.movieId
WHERE t.tag LIKE '%thriller%'
GROUP BY m.title
ORDER BY cnt DESC
LIMIT 10;
```

### 9. Find 10 movies with rating average between 3.5 and 4.5
```sql
SELECT m.title, AVG(r.rating) AS avg_rating
FROM movies m JOIN ratings r ON m.movieId = r.movieId
GROUP BY m.title
HAVING avg_rating BETWEEN 3.5 AND 4.5
LIMIT 10;
```

### 10. Find 10 movies linked with tmdbId
```sql
SELECT m.title, l.tmdbId
FROM movies m JOIN links l ON m.movieId = l.movieId
WHERE l.tmdbId IS NOT NULL
LIMIT 10;
```
