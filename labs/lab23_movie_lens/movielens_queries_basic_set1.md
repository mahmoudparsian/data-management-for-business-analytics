# MovieLens Basic Queries (Set 1)

## Schema Reminder
- movies(movieId, title, genres)
- ratings(userId, movieId, rating, timestamp)
- tags(userId, movieId, tag, timestamp)
- links(movieId, imdbId, tmdbId)

---

### 1. List first 10 movies
```sql
SELECT * FROM movies LIMIT 10;
```

### 2. Show 10 distinct genres
```sql
SELECT DISTINCT genres FROM movies LIMIT 10;
```

### 3. Find first 10 users who rated movies
```sql
SELECT DISTINCT userId FROM ratings LIMIT 10;
```

### 4. Show 10 ratings of movies with their userId
```sql
SELECT userId, movieId, rating FROM ratings LIMIT 10;
```

### 5. Show 10 tags assigned by users
```sql
SELECT userId, movieId, tag FROM tags LIMIT 10;
```

### 6. Find 10 movies with their IMDB and TMDB links
```sql
SELECT m.title, l.imdbId, l.tmdbId
FROM movies m JOIN links l ON m.movieId = l.movieId
LIMIT 10;
```

### 7. Show 10 movies with genre 'Comedy'
```sql
SELECT title, genres FROM movies
WHERE genres LIKE '%Comedy%'
LIMIT 10;
```

### 8. Show 10 movies with genre 'Action'
```sql
SELECT title, genres FROM movies
WHERE genres LIKE '%Action%'
LIMIT 10;
```

### 9. Show 10 ratings where rating >= 4.0
```sql
SELECT userId, movieId, rating
FROM ratings
WHERE rating >= 4.0
LIMIT 10;
```

### 10. Show 10 tags containing word 'funny'
```sql
SELECT * FROM tags
WHERE tag LIKE '%funny%'
LIMIT 10;
```
