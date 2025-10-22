# Movies Table & 50 SQL Queries


## Scenario

	OK, assume that I am a student at a college, 
	and I have installed mysql database successfully. 
	Now I am wondering what are my next learning steps. 
	
	Here is an interesting table (MOVIES) with less than 
	10 columns, and about 100 rows of data. Then provide
	50 natural language queries (in English), then provide 
	an equivalent SQL (in MySQL), then provide the out put 
	of a query so that I can validate my queries. 

✅. set you up:

    1.    One interesting table (less than 10 columns, 
          but rich enough to ask many questions).
          
    2.    ~10,000 rows of sample data (I’ll generate a 
          dataset you can load easily).
          
    3.    50 natural language queries.
    
    4.    Equivalent MySQL queries.
   

⸻

## 1. Example Table: Movies

We’ll use a Movies table (fun + easy to reason about).

### Create a Database

~~~sql
CREATE DATABASE movie_db;
~~~

~~~

### Use a Created Database

~~~sql
USE movie_db;
~~~

~~~

### Create a Table

~~~sql
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(100),
    Genre VARCHAR(30),
    ReleaseYear INT,
    Director VARCHAR(100),
    Rating DECIMAL(3,1),
    Duration INT,         -- in minutes
    Country VARCHAR(50)
);
~~~


⸻

## 2. Example Data 

* 100 rows

~~~
movies_100.csv
movies_100.sql
~~~

* 2,000 rows

~~~
movies_2000.csv
movies_2000.sql
~~~

* 10,000 rows

~~~
movies_10000.csv
movies_10000.sql
~~~



## 3. 50 Natural Language Queries + SQL

Here’s a set grouped into categories:

## Basic Queries


### 1.    List all movies.

~~~sql
SELECT * 
FROM Movies;
~~~


### 2.    Show all movie titles and release years.

~~~sql
SELECT Title, ReleaseYear 
FROM Movies;
~~~


### 3.    Find all movies directed by Christopher Nolan.

~~~sql
SELECT * 
FROM Movies 
WHERE Director = 'Christopher Nolan';
~~~


### 4.    List movies released after 2015.

~~~sql
SELECT * 
FROM Movies 
WHERE ReleaseYear > 2015;
~~~



### 5.    Find all Sci-Fi movies.

~~~sql
SELECT * 
FROM Movies 
WHERE Genre = 'Sci-Fi';
~~~




⸻

## Aggregations Queries

    
### 6.    Count the number of movies.

~~~sql
SELECT COUNT(*) 
FROM Movies;
~~~

~~~sql
SELECT COUNT(*) as num_of_movies
FROM Movies;
~~~


### 7.    Count how many movies each director has.

~~~sql
SELECT 
       Director, 
       COUNT(*) as num_of_movies
FROM 
       Movies 
GROUP BY 
       Director;
~~~


### 8.    Find the average rating of Sci-Fi movies.

~~~sql
SELECT AVG(Rating) as avg_rating
FROM Movies 
WHERE Genre = 'Sci-Fi';
~~~



### 9.    Find the longest movie duration.

~~~sql
SELECT MAX(Duration) 
FROM Movies;
~~~

~~~sql
SELECT MAX(Duration) as longest_movie_duration
FROM Movies;
~~~

### 10.    Find the shortest movie and its title.

~~~sql
SELECT Title, Duration 
FROM Movies 
ORDER BY Duration ASC 
LIMIT 1;
~~~



⸻

## Sorting Queries

### 11.    List top 5 highest-rated movies.

~~~sql
SELECT 
       Title, 
       Rating 
FROM 
       Movies 
ORDER BY 
       Rating DESC 
LIMIT 
       5;
~~~


### 12.    Show 5 most recent movies.

~~~sql
SELECT 
       Title, 
       ReleaseYear 
FROM 
       Movies 
ORDER BY 
       ReleaseYear DESC 
LIMIT 
       5;
~~~


### 13.    Show all movies sorted by director, then release year.

~~~sql
SELECT * 
FROM Movies 
ORDER BY Director, ReleaseYear;
~~~


### 14.    Find the top 3 longest movies.

~~~sql
SELECT 
       Title, 
       Duration 
FROM 
       Movies 
ORDER BY 
       Duration DESC 
LIMIT 
       3;
~~~


### 15. Show movies from Japan sorted by rating.

~~~sql
SELECT Title, Rating 
FROM Movies 
WHERE Country = 'Japan' 
ORDER BY Rating DESC;
~~~



⸻

## Conditions

### 16. List movies with rating above 8.5.

~~~sql
SELECT * 
FROM Movies 
WHERE Rating > 8.5;
~~~


### 17. Find movies between 2000 and 2010.

~~~sql
SELECT * 
FROM Movies 
WHERE ReleaseYear BETWEEN 2000 AND 2010;
~~~


### 18. Show all movies NOT from USA.

~~~sql
SELECT * 
FROM Movies 
WHERE Country <> 'USA';
~~~


### 19. Show all movies with duration between 100 and 120 minutes.

~~~sql
SELECT * 
FROM Movies 
WHERE Duration BETWEEN 100 AND 120;
~~~


### 20. Find all movies where the title contains “War”.

~~~sql
SELECT * 
FROM Movies 
WHERE Title LIKE '%War%';
~~~



⸻

## Joins (self join style)
    
### 21. Find pairs of movies with the same director.

~~~sql
SELECT   
        a.Title AS Movie1, 
        b.Title AS Movie2, 
        a.Director
FROM 
        Movies a
JOIN Movies b ON a.Director = b.Director AND 
                 a.MovieID < b.MovieID;
~~~


### 22. Find how many countries have produced movies.

~~~sql
SELECT COUNT(DISTINCT Country) 
FROM Movies;
~~~


### 23. Count movies per country.

~~~sql
SELECT Country, 
       COUNT(*) as movies_count
FROM Movies 
GROUP BY Country;
~~~


### 24. Find the country with the highest average rating.

~~~sql
SELECT 
       Country, 
       AVG(Rating) AS AvgRating
FROM 
       Movies 
GROUP BY 
       Country
ORDER BY 
       AvgRating DESC
LIMIT 
       1;
~~~


### 25. Find the average duration of movies per director.

~~~sql
SELECT 
        Director, 
        AVG(Duration) 
FROM 
        Movies 
GROUP BY 
        Director;
~~~



⸻

## More Complex Queries

### 26. Find movies released in the same year as “Inception”.

~~~sql
SELECT Title 
FROM Movies 
WHERE ReleaseYear = (
                       SELECT ReleaseYear 
                       FROM Movies 
                       WHERE Title = 'Inception'
                    );
~~~


### 27. List directors who have more than 2 movies.

~~~sql
SELECT 
       Director, 
       COUNT(*) 
FROM 
       Movies 
GROUP BY 
       Director 
HAVING 
       COUNT(*) > 2;
~~~


### 28. Find the best-rated movie per country.

* Solution by Join:

~~~sql
SELECT 
       m1.Country, 
       m1.Title, 
       m1.Rating
FROM 
       Movies m1
WHERE 
       m1.Rating = (
                    SELECT MAX(m2.Rating) 
                    FROM Movies m2 
                    WHERE m1.Country = m2.Country
                  );
~~~

* Solution with WITH (CTE + subquery):

~~~sql
WITH max_ratings_per_country AS 
(
    SELECT Country, MAX(Rating) AS max_rating
    FROM Movies
    GROUP BY Country
)
SELECT 
      m.Country, 
      m.Title, 
      m.Rating
FROM 
      Movies m
WHERE 
      (m.Country, m.Rating) IN (
                                 SELECT 
                                        Country, 
                                        max_rating 
                                 FROM 
                                        max_ratings_per_country
                               );
~~~

### 29. Rank movies by rating (top 10).

~~~sql
SELECT 
       Title, 
       Rating,
       RANK() OVER (ORDER BY Rating DESC) AS rank_number
FROM 
       Movies
LIMIT 
       10;
~~~


### 30. Find the second highest-rated movie overall.

~~~sql
SELECT 
       Title, 
       Rating 
FROM 
       Movies 
ORDER BY 
       Rating DESC 
LIMIT 
       1 
OFFSET 
       1;
~~~



⸻

👉 That’s 30 queries so far. I’ll expand with 20 more covering:
    •    subqueries (WITH)
    •    window functions
    •    filtering by multiple criteria
    •    group/having with averages
    •    pattern matching

⸻

⸻

## Using CTEs (WITH)
  
### 31.  Find movies with ratings above the overall average.

~~~sql
WITH avg_rating AS 
(    
  SELECT AVG(Rating) AS avg_value
  FROM Movies
)
SELECT 
       Title, 
       Rating 
FROM 
       Movies, 
       avg_rating
WHERE 
       Rating > avg_rating.avg_value;
~~~


### 32. Find the longest movie per genre.

~~~sql
WITH max_durations AS 
(    
  SELECT Genre, MAX(Duration) AS max_duration
  FROM Movies
  GROUP BY Genre
)
SELECT 
       m.Title, 
       m.Genre, 
       m.Duration
FROM 
       Movies m
JOIN 
       max_durations d ON m.Genre = d.Genre  AND 
                          m.Duration = max_duration;
~~~


### 33.  Find movies released in the same year as the highest-rated movie.

~~~sql
WITH top_movie AS 
(
    SELECT ReleaseYear 
    FROM Movies 
    ORDER BY Rating DESC 
    LIMIT 1
)
SELECT  Title, 
        ReleaseYear 
FROM 
        Movies 
WHERE 
        ReleaseYear = (SELECT ReleaseYear FROM top_movie);
~~~


### 34.  Count movies by decade.

~~~sql
WITH decades AS 
(
    SELECT 
           (ReleaseYear DIV 10) * 10 AS decade, 
           COUNT(*) AS movie_count
    FROM Movies
    GROUP BY decade
)
SELECT * 
FROM decades 
ORDER BY decade;
~~~


### 35. List directors who have average ratings above 8.5.

~~~sql
WITH director_avg AS 
(
    SELECT Director, AVG(Rating) AS avg_rating
    FROM Movies
    GROUP BY Director
)
SELECT * 
FROM director_avg 
WHERE avg_rating > 8.5;
~~~



⸻

## Ranking Functions
    
### 36.  Rank movies within each genre by rating.

~~~sql
SELECT 
       Title, 
       Genre, 
       Rating,
       RANK() OVER (PARTITION BY Genre ORDER BY Rating DESC) AS RankInGenre
FROM 
       Movies;
~~~


### 37.  Find the top 3 movies per country by rating.

* Solution-1:

~~~sql
SELECT Title, Country, Rating
FROM (
       SELECT 
             Title, 
             Country, 
             Rating,
             RANK() OVER (PARTITION BY Country ORDER BY Rating DESC) AS rnk
       FROM Movies
) t
WHERE rnk <= 3;
~~~



* Solution-2:

~~~sql
WITH ranked_movies AS 
(
   SELECT 
          Title, 
          Country, 
          Rating,
          RANK() OVER (PARTITION BY Country ORDER BY Rating DESC) AS rnk
   FROM Movies
)
SELECT Title, Country, Rating, rnk
FROM ranked_movies
WHERE rnk <= 3;
~~~



### 38. Dense rank movies globally by duration.

~~~sql
SELECT 
       Title, 
       Duration,
       DENSE_RANK() OVER (ORDER BY Duration DESC) AS duration_rank
FROM 
       Movies;
~~~


### 39.   Find the 5th highest-rated movie overall.

~~~sql
WITH ranked_movies As
(
    SELECT 
           Title, 
           Rating, 
           RANK() OVER (ORDER BY Rating DESC) AS rnk
    FROM Movies
) 
SELECT Title, Rating, rnk
FROM ranked_movies
WHERE rnk = 5;
~~~


### 40. Rank directors by the number of movies they directed.

~~~sql
SELECT 
       Director, 
       COUNT(*) AS num_of_movies,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS rank_director
FROM 
       Movies
GROUP BY 
       Director;
~~~



⸻

## Advanced CTE + Ranking
    
### 41. Find movies that are in the top 2 per director by rating.

~~~sql
WITH ranked_rating AS (
(
    SELECT 
           Title, 
           Director, 
           Rating,
           RANK() OVER (PARTITION BY Director ORDER BY Rating DESC) AS rnk
    FROM 
           Movies
)

SELECT * 
FROM ranked_rating 
WHERE rnk <= 2;
~~~


### 42. Find the highest-rated movie for each year.

~~~sql
WITH yearly AS 
(
    
    SELECT 
           Title, 
           ReleaseYear, 
           Rating,
           RANK() OVER (PARTITION BY ReleaseYear ORDER BY Rating DESC) AS rnk
    FROM 
           Movies
)
SELECT * 
FROM yearly 
WHERE rnk = 1;
~~~


### 43. List countries ranked by their average movie rating.

~~~sql
WITH country_avg AS 
(
    SELECT 
            Country, 
            AVG(Rating) AS avg_rating
    FROM 
            Movies
    GROUP BY 
            Country
)
SELECT  
        Country, 
        avg_rating,
        RANK() OVER (ORDER BY avg_rating DESC) AS rank_country
FROM 
        country_avg;
~~~


### 44. Find movies in the same genre as the longest movie overall.

~~~sql
WITH longest AS 
(
    SELECT Genre 
    FROM Movies 
    ORDER BY Duration DESC 
    LIMIT 1
)
SELECT 
       Title, 
       Genre, 
       Duration 
FROM 
       Movies 
WHERE 
       Genre = (SELECT Genre FROM longest);
~~~


### 45. Find the director with the highest average rating.

~~~sql
WITH director_avg AS 
(
    SELECT 
           Director, 
           AVG(Rating) AS avg_rating
    FROM 
           Movies
    GROUP BY 
           Director
)
SELECT 
       Director, 
       avg_rating
FROM 
       director_avg
ORDER BY 
       avg_rating DESC
LIMIT 
       1;
~~~



⸻

## Mixed Window Functions

### 46.  Show the cumulative count of movies by release year.

~~~sql
SELECT 
       ReleaseYear,
       COUNT(*) AS yearly_count,
       SUM(COUNT(*)) OVER (ORDER BY ReleaseYear) AS cumulative_count
FROM 
       Movies
GROUP BY 
       ReleaseYear
ORDER BY 
       ReleaseYear;
~~~


### 47. Show the moving average of ratings by release year.

~~~sql
SELECT 
       ReleaseYear, 
       AVG(Rating) AS avg_rating,
       AVG(AVG(Rating)) OVER (ORDER BY ReleaseYear ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) 
         AS moving_avg
FROM 
       Movies
GROUP BY 
       ReleaseYear
ORDER BY 
       ReleaseYear;
~~~


### 48. Find the median duration of movies.

~~~sql
WITH ordered AS 
(
    SELECT 
           Duration, 
           ROW_NUMBER() OVER (ORDER BY Duration) AS rn,
           COUNT(*) OVER() AS total_count
    FROM 
           Movies
)
SELECT Duration
FROM ordered
WHERE rn IN (total_count/2, total_count/2+1);
~~~


### 49. List movies whose rating ranks in the top 10% overall.

~~~sql
WITH ranked AS 
(
    SELECT 
           Title, 
           Rating,
           PERCENT_RANK() OVER (ORDER BY Rating DESC) AS pct_rank
    FROM 
           Movies
)
SELECT Title, Rating, pct_rank
FROM ranked
WHERE pct_rank <= 0.10;
~~~


### 50.  Show the difference in rating between each movie and the best movie in its genre.

~~~sql
SELECT 
       Title, 
       Genre, 
       Rating,
       MAX(Rating) OVER (PARTITION BY Genre) - Rating AS rating_gap
FROM 
       Movies;
~~~

