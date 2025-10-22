# 🗝️ MySQL Homework: Movies Table (Answer Key)

## Part A: Basic Queries
```sql
-- Q1
SELECT * FROM movies;

-- Q2
SELECT title, release_year FROM movies;

-- Q3
SELECT * FROM movies WHERE release_year > 2010;

-- Q4
SELECT * FROM movies WHERE genre = 'Sci-Fi';

-- Q5
SELECT title, rating FROM movies ORDER BY rating DESC;
```

---

## Part B: Intermediate Queries
```sql
-- Q6
SELECT genre, COUNT(*) AS num_movies
FROM movies
GROUP BY genre;

-- Q7
SELECT AVG(rating) AS avg_rating FROM movies;

-- Q8
SELECT SUM(box_office) AS total_revenue FROM movies;

-- Q9
SELECT title, box_office
FROM movies
ORDER BY box_office DESC
LIMIT 1;

-- Q10
SELECT genre, AVG(rating) AS avg_rating
FROM movies
GROUP BY genre;
```

---

## Part C: Advanced Queries (WITH + Ranking)
```sql
-- Q11
WITH ranked_movies AS (
    SELECT title, box_office,
           RANK() OVER (ORDER BY box_office DESC) AS rank_position
    FROM movies
)
SELECT * FROM ranked_movies WHERE rank_position <= 3;

-- Q12
WITH ranked_by_rating AS (
    SELECT title, rating,
           RANK() OVER (ORDER BY rating DESC) AS rank_position
    FROM movies
)
SELECT * FROM ranked_by_rating;

-- Q13
WITH genre_ranking AS (
    SELECT genre, title, rating,
           RANK() OVER (PARTITION BY genre ORDER BY rating DESC) AS rank_position
    FROM movies
)
SELECT genre, title, rating
FROM genre_ranking
WHERE rank_position = 1;

-- Q14
WITH genre_revenue AS (
    SELECT genre, AVG(box_office) AS avg_revenue
    FROM movies
    GROUP BY genre
)
SELECT genre, avg_revenue,
       RANK() OVER (ORDER BY avg_revenue DESC) AS rank_position
FROM genre_revenue;

-- Q15
WITH ranked_modern_movies AS (
    SELECT title, release_year, rating,
           RANK() OVER (ORDER BY rating DESC) AS rank_position
    FROM movies
    WHERE release_year > 2000
)
SELECT * FROM ranked_modern_movies
WHERE rank_position <= 5;
```
