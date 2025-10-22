using mysql, to teach basics of SQL queries to students (they are new to the database world), can you come up with a single table, which has interesting queries:  1. table definition , 2. Table population with sample rows, 3. FIVE basic queries, 4. FIVE intermediate queries, 5. FIVE sub-queries using WITH and ranking functions

Great idea 🎉 — let’s design a single, simple-yet-interesting table that will allow beginners to explore basic, intermediate, and advanced SQL queries.

⸻

📘 Step 1. Table Definition

We’ll use a table called movies, because students usually find entertainment data more fun and relatable.

CREATE TABLE movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50),
    release_year INT,
    rating DECIMAL(3,1),   -- e.g., IMDb rating
    box_office DECIMAL(10,2) -- revenue in millions
);


⸻

📘 Step 2. Table Population with Sample Rows

INSERT INTO movies (title, genre, release_year, rating, box_office) VALUES
('Inception', 'Sci-Fi', 2010, 8.8, 829.9),
('The Dark Knight', 'Action', 2008, 9.0, 1004.6),
('Titanic', 'Romance', 1997, 7.9, 2187.5),
('The Avengers', 'Action', 2012, 8.0, 1518.8),
('Interstellar', 'Sci-Fi', 2014, 8.6, 677.5),
('Joker', 'Drama', 2019, 8.5, 1074.3),
('Frozen', 'Animation', 2013, 7.4, 1280.0),
('Avatar', 'Sci-Fi', 2009, 7.9, 2923.7),
('Parasite', 'Drama', 2019, 8.6, 263.1),
('The Lion King', 'Animation', 1994, 8.5, 968.5);


⸻

📘 Step 3. Five Basic Queries
    1.    List all movies.

SELECT * FROM movies;

    2.    Show only titles and release years.

SELECT title, release_year FROM movies;

    3.    Find all movies released after 2010.

SELECT * FROM movies WHERE release_year > 2010;

    4.    Show all Sci-Fi movies.

SELECT * FROM movies WHERE genre = 'Sci-Fi';

    5.    List movies ordered by rating (highest first).

SELECT title, rating FROM movies ORDER BY rating DESC;


⸻

📘 Step 4. Five Intermediate Queries
    6.    Count how many movies are in each genre.

SELECT genre, COUNT(*) AS num_movies
FROM movies
GROUP BY genre;

    7.    Find the average rating of all movies.

SELECT AVG(rating) AS avg_rating FROM movies;

    8.    Find the total box office revenue for all movies.

SELECT SUM(box_office) AS total_revenue FROM movies;

    9.    Find the highest-grossing movie.

SELECT title, box_office
FROM movies
ORDER BY box_office DESC
LIMIT 1;

    10.    Show the average rating per genre.

SELECT genre, AVG(rating) AS avg_rating
FROM movies
GROUP BY genre;


⸻

📘 Step 5. Five Sub-Queries with WITH + Ranking
    11.    Find the top 3 highest-grossing movies.

WITH ranked_movies AS (
    SELECT title, box_office,
           RANK() OVER (ORDER BY box_office DESC) AS rank_position
    FROM movies
)
SELECT * FROM ranked_movies WHERE rank_position <= 3;

    12.    Rank movies by rating.

WITH ranked_by_rating AS (
    SELECT title, rating,
           RANK() OVER (ORDER BY rating DESC) AS rank_position
    FROM movies
)
SELECT * FROM ranked_by_rating;

    13.    Find the best movie (highest rating) per genre.

WITH genre_ranking AS (
    SELECT genre, title, rating,
           RANK() OVER (PARTITION BY genre ORDER BY rating DESC) AS rank_position
    FROM movies
)
SELECT genre, title, rating
FROM genre_ranking
WHERE rank_position = 1;

    14.    Find the average revenue per genre and rank genres by revenue.

WITH genre_revenue AS (
    SELECT genre, AVG(box_office) AS avg_revenue
    FROM movies
    GROUP BY genre
)
SELECT genre, avg_revenue,
       RANK() OVER (ORDER BY avg_revenue DESC) AS rank_position
FROM genre_revenue;

    15.    Find movies released after 2000 that are in the top 5 by rating.

WITH ranked_modern_movies AS (
    SELECT title, release_year, rating,
           RANK() OVER (ORDER BY rating DESC) AS rank_position
    FROM movies
    WHERE release_year > 2000
)
SELECT * FROM ranked_modern_movies
WHERE rank_position <= 5;


⸻

✅ With just one movies table, students can practice:
    •    Basics → SELECT, WHERE, ORDER BY
    •    Intermediate → COUNT, AVG, SUM, GROUP BY
    •    Advanced → WITH, window functions (RANK, PARTITION BY)

⸻

Would you like me to package this into Markdown files (student + instructor versions) like the earlier homeworks, so you can drop them straight into your GitHub repo?

