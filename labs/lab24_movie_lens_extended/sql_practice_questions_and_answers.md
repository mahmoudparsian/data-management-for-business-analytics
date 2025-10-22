# 🎬 MovieLens SQL Queries (MySQL)

Schema reminder:

- **movies(movieId, title, genres)**
- **ratings(userId, movieId, rating, timestamp)**
- **tags(userId, movieId, tag, timestamp)**
- **links(movieId, imdbId, tmdbId)**

---

# 1. Basic SELECT & Filtering

1. List all movies released after 2015.  
```sql
SELECT * FROM movies
WHERE title LIKE '%(2016)%' OR title LIKE '%(2017)%' OR title LIKE '%(2018)%'
   OR title LIKE '%(2019)%' OR title LIKE '%(2020)%' OR title LIKE '%(2021)%'
   OR title LIKE '%(2022)%' OR title LIKE '%(2023)%' OR title LIKE '%(2024)%';
```

2. Find all movies in the "Comedy" genre.  
```sql
SELECT * FROM movies
WHERE genres LIKE '%Comedy%';
```

3. Display movies with a rating higher than 4.5.  
```sql
SELECT DISTINCT m.title
FROM movies m
JOIN ratings r ON m.movieId = r.movieId
WHERE r.rating > 4.5;
```

---

# 2. Aggregation & GROUP BY

1. Count how many movies exist in each genre.  
```sql
SELECT genres, COUNT(*) AS movie_count
FROM movies
GROUP BY genres;
```

2. Find the average rating of each movie.  
```sql
SELECT m.title, AVG(r.rating) AS avg_rating
FROM movies m JOIN ratings r ON m.movieId = r.movieId
GROUP BY m.title;
```

3. Find the total number of ratings given by each user.  
```sql
SELECT userId, COUNT(*) AS num_ratings
FROM ratings
GROUP BY userId;
```

---

# 3. Sorting & LIMIT

1. List the top 10 movies with the highest average rating.  
```sql
SELECT m.title, AVG(r.rating) AS avg_rating
FROM movies m JOIN ratings r ON m.movieId = r.movieId
GROUP BY m.title
ORDER BY avg_rating DESC
LIMIT 10;
```

2. List the top 5 users who rated the most movies.  
```sql
SELECT userId, COUNT(*) AS rating_count
FROM ratings
GROUP BY userId
ORDER BY rating_count DESC
LIMIT 5;
```

3. List movies with the longest runtime, in descending order.  
*(Assuming runtime column exists; otherwise skip)*  
```sql
SELECT title, runtime
FROM movies
ORDER BY runtime DESC
LIMIT 10;
```

---

# 4. JOINs

1. List all movies along with their ratings.  
```sql
SELECT m.title, r.rating
FROM movies m JOIN ratings r ON m.movieId = r.movieId;
```

2. Show movies with their corresponding tags applied by users.  
```sql
SELECT m.title, t.tag, t.userId
FROM movies m JOIN tags t ON m.movieId = t.movieId;
```

3. Find movies and the number of times each has been tagged.  
```sql
SELECT m.title, COUNT(t.tag) AS tag_count
FROM movies m JOIN tags t ON m.movieId = t.movieId
GROUP BY m.title;
```

4. Find movies along with IMDb links.  
```sql
SELECT m.title, l.imdbId
FROM movies m JOIN links l ON m.movieId = l.movieId;
```

---

# 5. Filtering with JOINs

1. Find all Comedy movies rated higher than 4.  
```sql
SELECT DISTINCT m.title
FROM movies m
JOIN ratings r ON m.movieId = r.movieId
WHERE m.genres LIKE '%Comedy%' AND r.rating > 4;
```

2. Find users who have rated the movie “Toy Story (1995)”.  
```sql
SELECT DISTINCT r.userId
FROM ratings r
JOIN movies m ON r.movieId = m.movieId
WHERE m.title = 'Toy Story (1995)';
```

3. List all movies rated by user with userId = 1 along with their ratings.  
```sql
SELECT m.title, r.rating
FROM ratings r JOIN movies m ON r.movieId = m.movieId
WHERE r.userId = 1;
```

---

# 6. Window Functions & Ranking

1. Rank movies by average rating within each genre.  
```sql
WITH MovieAvg AS (
  SELECT m.movieId, m.title, m.genres, AVG(r.rating) AS avg_rating
  FROM movies m JOIN ratings r ON m.movieId = r.movieId
  GROUP BY m.movieId, m.title, m.genres
)
SELECT title, genres, avg_rating,
       RANK() OVER (PARTITION BY genres ORDER BY avg_rating DESC) AS genre_rank
FROM MovieAvg;
```

2. Show the top 3 movies per genre based on average rating.  
```sql
WITH MovieAvg AS (
  SELECT m.movieId, m.title, m.genres, AVG(r.rating) AS avg_rating
  FROM movies m JOIN ratings r ON m.movieId = r.movieId
  GROUP BY m.movieId, m.title, m.genres
)
SELECT * FROM (
  SELECT title, genres, avg_rating,
         RANK() OVER (PARTITION BY genres ORDER BY avg_rating DESC) AS genre_rank
  FROM MovieAvg
) ranked
WHERE genre_rank <= 3;
```

3. Calculate a running total of ratings per user.  
```sql
SELECT userId, rating,
       SUM(rating) OVER (PARTITION BY userId ORDER BY timestamp) AS running_total
FROM ratings;
```

---

# 7. Subqueries

1. Find movies with rating higher than the overall average rating.  
```sql
SELECT m.title, AVG(r.rating) AS avg_rating
FROM movies m JOIN ratings r ON m.movieId = r.movieId
GROUP BY m.title
HAVING AVG(r.rating) > (SELECT AVG(rating) FROM ratings);
```

2. Find users who rated more than 50 movies.  
```sql
SELECT userId, COUNT(*) AS num_ratings
FROM ratings
GROUP BY userId
HAVING COUNT(*) > 50;
```

3. List movies that have never received a rating of 5.  
```sql
SELECT m.title
FROM movies m
WHERE m.movieId NOT IN (
  SELECT DISTINCT r.movieId
  FROM ratings r
  WHERE r.rating = 5
);
```

---

# 8. Advanced / Combined

1. Find the most popular tag (used the most by users).  
```sql
SELECT tag, COUNT(*) AS tag_count
FROM tags
GROUP BY tag
ORDER BY tag_count DESC
LIMIT 1;
```

2. Find the genre with the highest average movie rating.  
```sql
WITH GenreAvg AS (
  SELECT m.genres, AVG(r.rating) AS avg_rating
  FROM movies m JOIN ratings r ON m.movieId = r.movieId
  GROUP BY m.genres
)
SELECT * FROM GenreAvg
ORDER BY avg_rating DESC
LIMIT 1;
```

3. Find the average rating given per year of release.  
*(Assuming year can be parsed from movie title)*  
```sql
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(title, '(', -1), ')', 1) AS release_year,
       AVG(r.rating) AS avg_rating
FROM movies m JOIN ratings r ON m.movieId = r.movieId
GROUP BY release_year
ORDER BY release_year;
```

4. Find movies with at least 50 ratings and an average rating above 4.  
```sql
SELECT m.title, COUNT(r.rating) AS num_ratings, AVG(r.rating) AS avg_rating
FROM movies m JOIN ratings r ON m.movieId = r.movieId
GROUP BY m.title
HAVING COUNT(r.rating) >= 50 AND AVG(r.rating) > 4;
```

---
