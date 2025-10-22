# MovieLens Basic Queries (Set 2)

### 1. Find 10 movies starting with letter 'A'
```sql
SELECT title FROM movies
WHERE title LIKE 'A%'
LIMIT 10;
```

### 2. Find 10 movies starting with letter 'B'
```sql
SELECT title FROM movies
WHERE title LIKE 'B%'
LIMIT 10;
```

### 3. List 10 users who have tagged movies
```sql
SELECT DISTINCT userId FROM tags LIMIT 10;
```

### 4. Show 10 movies tagged with 'romantic'
```sql
SELECT m.title, t.tag
FROM movies m JOIN tags t ON m.movieId = t.movieId
WHERE t.tag LIKE '%romantic%'
LIMIT 10;
```

### 5. Show 10 ratings with timestamp
```sql
SELECT userId, movieId, rating, timestamp
FROM ratings
LIMIT 10;
```

### 6. Show 10 movies with both Comedy and Drama in genre
```sql
SELECT title, genres FROM movies
WHERE genres LIKE '%Comedy%' AND genres LIKE '%Drama%'
LIMIT 10;
```

### 7. Show 10 distinct tags
```sql
SELECT DISTINCT tag FROM tags LIMIT 10;
```

### 8. Find 10 users who gave rating <= 2
```sql
SELECT userId, movieId, rating
FROM ratings
WHERE rating <= 2
LIMIT 10;
```

### 9. Show 10 movies without genre 'Comedy'
```sql
SELECT title, genres FROM movies
WHERE genres NOT LIKE '%Comedy%'
LIMIT 10;
```

### 10. Show 10 movies with IMDBId available
```sql
SELECT m.title, l.imdbId
FROM movies m JOIN links l ON m.movieId = l.movieId
WHERE l.imdbId IS NOT NULL
LIMIT 10;
```
