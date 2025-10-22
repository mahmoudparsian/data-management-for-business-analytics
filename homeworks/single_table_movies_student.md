# 📝 MySQL Homework: Movies Table

## Table Definition
```sql
CREATE TABLE movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50),
    release_year INT,
    rating DECIMAL(3,1),   -- IMDb-style rating
    box_office DECIMAL(10,2) -- revenue in millions
);
```

## Sample Data
```sql
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
```

---

## Part A: Basic Queries (Write the SQL)
1. List all movies.  
2. Show only titles and release years.  
3. Find all movies released after 2010.  
4. Show all Sci-Fi movies.  
5. List movies ordered by rating (highest first).  

---

## Part B: Intermediate Queries (Write the SQL)
6. Count how many movies are in each genre.  
7. Find the average rating of all movies.  
8. Find the total box office revenue for all movies.  
9. Find the highest-grossing movie.  
10. Show the average rating per genre.  

---

## Part C: Advanced Queries (WITH + Ranking)
11. Find the top 3 highest-grossing movies.  
12. Rank movies by rating.  
13. Find the best movie (highest rating) per genre.  
14. Find the average revenue per genre and rank genres by revenue.  
15. Find movies released after 2000 that are in the top 5 by rating.  
