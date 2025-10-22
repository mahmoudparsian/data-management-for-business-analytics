# MovieLens SQL Warm-up Queries

#### Q1. Show all movies

```sql
SELECT * 
FROM movies;
```

#### Q2. Show first 10 ratings

```sql
SELECT * 
FROM ratings 
LIMIT 10;
```

#### Q3. Show all tags

```sql
SELECT * 
FROM tags;
```

#### Q4. Find distinct genres

```sql
SELECT DISTINCT genres 
FROM movies;
```

#### Q5. Count number of movies

```sql
SELECT COUNT(*) 
FROM movies;
```

#### Q6. Count number of ratings

```sql
SELECT COUNT(*) 
FROM ratings;
```

#### Q7. Count number of tags

```sql
SELECT COUNT(*) 
FROM tags;
```

#### Q8. Find all movies with genre 'Comedy'

```sql
SELECT * 
FROM movies 
WHERE genres LIKE '%Comedy%';
```

#### Q9. Find all movies with genre 'Drama'

```sql
SELECT * 
FROM movies 
WHERE genres LIKE '%Drama%';
```

#### Q10. Find ratings for movieId=1

```sql
SELECT * 
FROM ratings 
WHERE movieId = 1;
```

#### Q11. Find tags for movieId=1

```sql
SELECT * 
FROM tags 
WHERE movieId = 1;
```

#### Q12. Find all movies rated by userId=5

```sql
SELECT * 
FROM ratings 
WHERE userId = 5;
```

#### Q13. List all distinct users who rated

```sql
SELECT DISTINCT userId 
FROM ratings;
```

#### Q14. List all distinct users who tagged

```sql
SELECT DISTINCT userId 
FROM tags;
```

#### Q15. Find all ratings > 4

```sql
SELECT * 
FROM ratings 
WHERE rating > 4;
```

#### Q16. Find all ratings < 2

```sql
SELECT * 
FROM ratings 
WHERE rating < 2;
```

#### Q17. Find the maximum rating value

```sql
SELECT MAX(rating) 
FROM ratings;
```

#### Q18. Find the minimum rating value

```sql
SELECT MIN(rating) 
FROM ratings;
```

#### Q19. Find all movies containing 'Toy Story'

```sql
SELECT * 
FROM movies 
WHERE title LIKE '%Toy Story%';
```

#### Q20. Find all tags containing 'funny'

```sql
SELECT * 
FROM tags 
WHERE tag LIKE '%funny%';
```