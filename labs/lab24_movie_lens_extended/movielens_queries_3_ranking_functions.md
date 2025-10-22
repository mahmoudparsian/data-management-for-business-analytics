# MovieLens SQL Intermediate Queries (GROUP BY + WITH + Ranking)

#### Q1. Find top 5 movies by average rating

```sql
WITH avg_ratings AS 
(
  SELECT movieId, AVG(rating) as avg_rating 
  FROM ratings 
  GROUP BY movieId
) 
SELECT * 
FROM avg_ratings 
ORDER BY avg_rating DESC 
LIMIT 5;
```

#### Q2. Find bottom 5 movies by average rating

```sql
WITH avg_ratings AS 
(
  SELECT movieId, AVG(rating) as avg_rating 
  FROM ratings 
  GROUP BY movieId
) 
SELECT * 
FROM avg_ratings 
ORDER BY avg_rating ASC 
LIMIT 5;
```

#### Q3. Rank users by number of ratings

```sql
SELECT userId, 
       COUNT(*) as cnt, 
       RANK() OVER (ORDER BY COUNT(*) DESC) as rnk 
FROM ratings 
GROUP BY userId;
```

#### Q4. Rank movies by number of ratings

```sql
SELECT movieId, 
       COUNT(*) as cnt, 
       RANK() OVER (ORDER BY COUNT(*) DESC) as rnk 
FROM ratings 
GROUP BY movieId;
```

#### Q5. Find 2nd most rated movie

```sql
WITH counts AS 
(
  SELECT movieId, 
         COUNT(*) as cnt 
  FROM ratings 
  GROUP BY movieId
) 
SELECT movieId 
FROM counts 
ORDER BY cnt DESC 
LIMIT 1 OFFSET 1;
```

#### Q6. Find 2nd most active user

```sql
WITH counts AS 
(
  SELECT userId, COUNT(*) as cnt 
  FROM ratings 
  GROUP BY userId
) 
SELECT userId 
FROM counts 
ORDER BY cnt DESC 
LIMIT 1 
OFFSET 1;
```

#### Q7. Find users with above-average number of ratings

```sql
WITH counts AS 
(
  SELECT userId, 
         COUNT(*) as cnt 
  FROM ratings 
  GROUP BY userId
) 
SELECT * 
FROM counts 
WHERE cnt > (SELECT AVG(cnt) FROM counts);
```

#### Q8. Find movies with above-average number of ratings

```sql
WITH counts AS 
(
  SELECT movieId, 
         COUNT(*) as cnt 
  FROM ratings 
  GROUP BY movieId
) 
SELECT * 
FROM counts 
WHERE cnt > (SELECT AVG(cnt) FROM counts);
```

#### Q9. Rank movies by average rating

```sql
SELECT movieId, 
       AVG(rating) as avg_rating,
       RANK() OVER (ORDER BY AVG(rating) DESC) as rnk 
FROM ratings 
GROUP BY movieId;
```

#### Q10. Rank users by average rating

```sql
SELECT userId, 
       AVG(rating) as avg_rating, 
       RANK() OVER (ORDER BY AVG(rating) DESC) as rnk 
FROM ratings 
GROUP BY userId;
```

#### Q11. Find movies with rating above overall average

```sql
WITH overall AS 
(
  SELECT AVG(rating) as avg_overall 
  FROM ratings
) 
SELECT movieId, 
       AVG(rating) as avg_rating 
FROM ratings, overall 
GROUP BY movieId 
HAVING AVG(rating) > avg_overall;
```

#### Q12. Find users who gave rating above global average

```sql
WITH overall AS 
(
  SELECT AVG(rating) as avg_overall 
  FROM ratings
) 
SELECT userId, 
       rating 
FROM ratings, overall 
WHERE rating > avg_overall;
```

#### Q13. Find top 3 genres by average rating

```sql
WITH avg_ratings AS 
(
  SELECT genres, 
         AVG(rating) as avg_rating 
  FROM movies 
  JOIN ratings USING(movieId) 
  GROUP BY genres
) 
SELECT * 
FROM avg_ratings 
ORDER BY avg_rating DESC 
LIMIT 3;
```

#### Q14. Find bottom 3 genres by average rating

```sql
WITH avg_ratings AS 
(
  SELECT genres, AVG(rating) as avg_rating 
  FROM movies 
  JOIN ratings USING(movieId) 
  GROUP BY genres
) 
SELECT * 
FROM avg_ratings 
ORDER BY avg_rating ASC 
LIMIT 3;
```

#### Q15. Rank tags by frequency

```sql
SELECT tag, 
       COUNT(*) as cnt, 
       RANK() OVER (ORDER BY COUNT(*) DESC) as rnk 
FROM tags 
GROUP BY tag;
```

#### Q16. Find second most common tag

```sql
WITH counts AS 
(
  SELECT tag, COUNT(*) as cnt 
  FROM tags 
  GROUP BY tag
) 
SELECT tag 
FROM counts 
ORDER BY cnt DESC 
LIMIT 1 
OFFSET 1;
```

#### Q17. Find movies tagged above-average times

```sql
WITH counts AS 
(
  SELECT movieId, COUNT(*) as cnt 
  FROM tags 
  GROUP BY movieId
) 
SELECT * 
FROM counts 
WHERE cnt > (SELECT AVG(cnt) FROM counts);
```

#### Q18. Rank tags by count (dense rank)

```sql
SELECT tag, 
       COUNT(*) as cnt, 
       DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) as rnk 
FROM tags 
GROUP BY tag;
```

#### Q19. Find top 5 users by number of tags

```sql
WITH counts AS 
(
  SELECT userId, COUNT(*) as cnt 
  FROM tags 
  GROUP BY userId
) 
SELECT * 
FROM counts 
ORDER BY cnt DESC 
LIMIT 5;
```

