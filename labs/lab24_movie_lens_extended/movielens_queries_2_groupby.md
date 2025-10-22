# MovieLens SQL Intermediate Queries (GROUP BY & Aggregation)

#### Q1. Count ratings per movie

```sql
SELECT movieId, COUNT(*) 
FROM ratings 
GROUP BY movieId;
```

#### Q2. Average rating per movie

```sql
SELECT movieId, AVG(rating) 
FROM ratings 
GROUP BY movieId;
```

#### Q3. Average rating per user

```sql
SELECT userId, AVG(rating) 
FROM ratings 
GROUP BY userId;
```

#### Q4. Number of movies rated per user

```sql
SELECT userId, COUNT(*) 
FROM ratings 
GROUP BY userId;
```

#### Q5. Number of tags per user

```sql
SELECT userId, COUNT(*) 
FROM tags 
GROUP BY userId;
```

#### Q6. Number of tags per movie

```sql
SELECT movieId, COUNT(*) 
FROM tags 
GROUP BY movieId;
```

#### Q7. Average rating per genre

solution-1:

```sql
SELECT genres, AVG(rating) 
FROM movies 
JOIN ratings USING(movieId) 
GROUP BY genres;
```

solution-2:

```sql
SELECT genres, AVG(rating) 
FROM movies m
JOIN ratings r on m.movieId = r.movieId
GROUP BY genres;
```

#### Q8. Count of ratings per genre

solution-1:

```sql
SELECT genres, COUNT(rating) 
FROM movies 
JOIN ratings USING(movieId) 
GROUP BY genres;
```

solution-2:

```sql
SELECT genres, COUNT(rating) 
FROM movies m
JOIN ratings r on m.movieId = r.movieId
GROUP BY genres;
```

#### Q9. Find most tagged movies

```sql
SELECT movieId, COUNT(*) as tag_count 
FROM tags 
GROUP BY movieId 
ORDER BY tag_count DESC;
```

#### Q10. Find most active users by ratings

```sql
SELECT userId, COUNT(*) as cnt 
FROM ratings 
GROUP BY userId 
ORDER BY cnt DESC;
```

#### Q11. Find most active users by tags

```sql
SELECT userId, COUNT(*) as cnt 
FROM tags 
GROUP BY userId 
ORDER BY cnt DESC;
```

#### Q12. Find highest average rating per user

```sql
SELECT userId, AVG(rating) as avg_rating 
FROM ratings 
GROUP BY userId 
ORDER BY avg_rating DESC;
```

#### Q13. Find lowest average rating per user

```sql
SELECT userId, AVG(rating) as avg_rating 
FROM ratings 
GROUP BY userId 
ORDER BY avg_rating ASC;
```

#### Q14. Find movies with average rating > 4

```sql
SELECT movieId, AVG(rating) as avg_rating 
FROM ratings 
GROUP BY movieId 
HAVING avg_rating > 4;
```

#### Q15. Find movies with more than 50 ratings

```sql
SELECT movieId, COUNT(*) as cnt 
FROM ratings 
GROUP BY movieId 
HAVING cnt > 50;
```

#### Q16. Average ratings by year (from timestamp)

```sql
SELECT YEAR(FROM_UNIXTIME(timestamp)) as year, 
       AVG(rating) as avg_rating 
FROM ratings 
GROUP BY year;
```

#### Q17. Count ratings by year

```sql
SELECT YEAR(FROM_UNIXTIME(timestamp)) as year, 
       COUNT(*) as cnt
FROM ratings 
GROUP BY year;
```

#### Q18. Average ratings per tag

solution-1:

```sql
SELECT tag, AVG(rating) as avg_rating
FROM tags 
JOIN ratings USING(userId, movieId) 
GROUP BY tag;
```

solution-2:

```sql
SELECT tag, AVG(rating) as avg_rating
FROM tags t
JOIN ratings r ON (t.userId = r.userId) AND (t.movieId = r.movieId)
GROUP BY tag;
```


#### Q19. Count tags per genre

solution-1:

```sql
SELECT genres, COUNT(tag) AS cnt
FROM movies 
JOIN tags USING(movieId) 
GROUP BY genres;
```

solution-2:

```sql
SELECT genres, COUNT(tag) AS cnt
FROM movies m
JOIN tags t ON m.movieId = t.movieId
GROUP BY genres;
```

#### Q20. Find users with both ratings and tags

You want users who have done both:
	•	given at least one rating (in ratings)
	•	and applied at least one tag (in tags).
	
✅ Solution 1: Using INNER JOIN

```sql
SELECT DISTINCT r.userId
FROM ratings r
JOIN tags t USING (userId);
```

✅ Solution 2: Using IN Subquery

```sql
SELECT DISTINCT userId
FROM ratings
WHERE userId IN (SELECT DISTINCT userId FROM tags);
```

✅ Solution 3: Using EXISTS

```sql
SELECT DISTINCT r.userId
FROM ratings r
WHERE EXISTS (
    SELECT 1
    FROM tags t
    WHERE r.userId = t.userId
);
```

✅ If you want counts of how many ratings & tags each such user has:

```sql
SELECT r.userId, 
       COUNT(DISTINCT r.movieId) AS num_ratings, 
       COUNT(DISTINCT t.movieId) AS num_tags
FROM ratings r
JOIN tags t USING (userId)
GROUP BY r.userId;
```