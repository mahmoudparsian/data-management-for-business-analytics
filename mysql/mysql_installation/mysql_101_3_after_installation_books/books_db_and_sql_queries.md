# Books database

	Simple interesting MySQL database with one table 
	for absolute beginners with 50 rows of data with 
	inserts, then 40 English/Sql queries from  very 
	basic to basic to intermediate all in markdown format 

	Here’s a complete MySQL 101 practice lab — all in 
	Markdown format, simple and interesting for absolute 
	beginners.

What is covered:

	🎯 A simple table (single table design)
	
	📥 50 sample INSERTs
	
	🧠 40 SQL + English queries, from very basic → basic → intermediate




## 1. 🗃️ Create Database 

```sql
CREATE DATABASE library_db;

USE library_db;
```


## 2. 🗃️ Create  Table

```sql
CREATE TABLE books (

    book_id INT PRIMARY KEY AUTO_INCREMENT,

    title VARCHAR(100),

    author VARCHAR(100),

    genre VARCHAR(50),

    year_published INT,

    price DECIMAL(6,2),

    rating DECIMAL(3,1)

);
```



## 3. Insert 50 Sample Rows


```sql
INSERT INTO books (title, author, genre, year_published, price, rating) 
VALUES

('The Silent Forest', 'Alice Green', 'Fiction', 2015, 12.99, 4.3),

('Journey to Mars', 'Tom Rivers', 'Science Fiction', 2020, 18.50, 4.7),

('Cooking with Love', 'Maria Lopez', 'Cooking', 2012, 24.00, 4.1),

('The Art of Zen', 'Ken Tanaka', 'Philosophy', 2010, 15.75, 4.6),

('Wildlife Wonders', 'Sarah Mills', 'Nature', 2018, 21.20, 4.2),

('Python for Kids', 'Jake Johnson', 'Education', 2022, 19.99, 4.8),

('History of Rome', 'Paul Marcus', 'History', 2005, 17.60, 4.0),

('The Hidden Garden', 'Emily Rose', 'Fiction', 2017, 14.50, 4.4),

('Digital Nomads', 'Chris Lee', 'Technology', 2021, 22.10, 4.5),

('Space Odyssey', 'Tom Rivers', 'Science Fiction', 2016, 16.80, 4.3),

('Baking 101', 'Maria Lopez', 'Cooking', 2018, 20.00, 4.0),

('Mindful Living', 'Ken Tanaka', 'Philosophy', 2014, 13.25, 4.7),

('Ocean Secrets', 'Sarah Mills', 'Nature', 2013, 18.90, 4.1),

('Data for Everyone', 'Jake Johnson', 'Education', 2021, 25.50, 4.9),

('Ancient Empires', 'Paul Marcus', 'History', 2011, 19.00, 4.2),

('The Lost Island', 'Alice Green', 'Fiction', 2019, 13.80, 4.5),

('Tech for Teens', 'Chris Lee', 'Technology', 2022, 18.75, 4.6),

('Beyond Earth', 'Tom Rivers', 'Science Fiction', 2023, 21.90, 4.8),

('Cooking Fast', 'Maria Lopez', 'Cooking', 2020, 16.40, 4.2),

('Inner Peace', 'Ken Tanaka', 'Philosophy', 2019, 14.20, 4.8),

('Nature’s Voice', 'Sarah Mills', 'Nature', 2015, 20.70, 4.3),

('SQL Simplified', 'Jake Johnson', 'Education', 2020, 23.00, 4.9),

('The Roman Wars', 'Paul Marcus', 'History', 2016, 17.10, 4.3),

('Lost in Space', 'Tom Rivers', 'Science Fiction', 2011, 12.50, 4.1),

('Flavors of Italy', 'Maria Lopez', 'Cooking', 2019, 26.00, 4.7),

('Deep Thinking', 'Ken Tanaka', 'Philosophy', 2018, 19.80, 4.9),

('Mountain Life', 'Sarah Mills', 'Nature', 2012, 15.30, 4.0),

('Learn Python', 'Jake Johnson', 'Education', 2018, 20.50, 4.6),

('Medieval Kings', 'Paul Marcus', 'History', 2019, 22.10, 4.4),

('AI Revolution', 'Chris Lee', 'Technology', 2023, 28.90, 4.9),

('Future Tech', 'Chris Lee', 'Technology', 2021, 24.60, 4.8),

('Healthy Meals', 'Maria Lopez', 'Cooking', 2021, 18.00, 4.5),

('Fictional Dreams', 'Alice Green', 'Fiction', 2018, 15.90, 4.3),

('Peaceful Mind', 'Ken Tanaka', 'Philosophy', 2022, 22.70, 4.9),

('Forest Whisper', 'Sarah Mills', 'Nature', 2023, 23.20, 4.8),

('Learning SQL', 'Jake Johnson', 'Education', 2023, 26.40, 5.0),

('War Stories', 'Paul Marcus', 'History', 2008, 16.30, 3.9),

('Tech Simplified', 'Chris Lee', 'Technology', 2017, 19.10, 4.3),

('Creative Cooking', 'Maria Lopez', 'Cooking', 2015, 25.70, 4.6),

('Hidden Truths', 'Alice Green', 'Fiction', 2014, 13.40, 4.0),

('Philosophy of Mind', 'Ken Tanaka', 'Philosophy', 2020, 20.60, 4.7),

('Planet Blue', 'Sarah Mills', 'Nature', 2017, 17.70, 4.4),

('History of Egypt', 'Paul Marcus', 'History', 2014, 18.90, 4.2),

('Coding for All', 'Jake Johnson', 'Education', 2017, 22.30, 4.7),

('Smart Homes', 'Chris Lee', 'Technology', 2018, 23.50, 4.6),

('Galactic Tales', 'Tom Rivers', 'Science Fiction', 2021, 24.90, 4.7),

('Vegan Life', 'Maria Lopez', 'Cooking', 2022, 21.60, 4.8),

('Simple Living', 'Ken Tanaka', 'Philosophy', 2013, 12.80, 4.2),

('Birds of Earth', 'Sarah Mills', 'Nature', 2020, 19.90, 4.5),

('Legends of Greece', 'Paul Marcus', 'History', 2013, 17.60, 4.1),

('Digital Future', 'Chris Lee', 'Technology', 2024, 29.50, 5.0);

```


## 4. Practice Queries (English + SQL + Sample Results)


## 🟢 Very Basic Queries (1–10)



#### 1. Show all books.

```sql
SELECT * 
FROM books;
```

#### 2. Show only titles of all books.

```sql
SELECT title 
FROM books;
```

#### 3. Show titles and authors for all books

```sql
SELECT title, author 
FROM books;
```

#### 4. Count total books.

```sql
SELECT COUNT(*) 
FROM books;
```

#### 5. List unique genres.

```sql
SELECT DISTINCT genre 
FROM books;
```

#### 6. Show all books written by ‘Maria Lopez’.

```sql
SELECT * 
FROM books 
WHERE author = 'Maria Lopez';
```

#### 7. Show all books published after 2020.

```sql
SELECT * 
FROM books 
WHERE year_published > 2020;
```

#### 8. Find books cheaper than $20.

```sql
SELECT * 
FROM books 
WHERE price < 20;
```

#### 9. Find books with rating above 4.5.

```sql
SELECT * 
FROM books 
WHERE rating > 4.5;
```

#### 10. Sort all books by price ascending.

```sql
SELECT * 
FROM books 
ORDER BY price ASC;
```



## 🟡 Basic Queries (11–25)



#### 11. Show top 5 most expensive books.

```sql
SELECT * 
FROM books 
ORDER BY price DESC 
LIMIT 5;
```

#### 12. Count how many books per genre.

```sql
SELECT genre, COUNT(*) FROM books GROUP BY genre;
```

#### 13. Average price of all books.

```sql
SELECT AVG(price) 
FROM books;
```

#### 14. Average rating per author.

solution-1:

```sql
SELECT author, AVG(rating) 
FROM books 
GROUP BY author;
```

solution-1:

```sql
SELECT author, AVG(rating) AS avg_rating
FROM books 
GROUP BY author;
```

#### 15. Find books with “Tech” in title.

```sql
SELECT * 
FROM books 
WHERE title LIKE '%Tech%';
```

#### 16. Books between $15 and $25.

solution-1:

```sql
SELECT * 
FROM books 
WHERE price BETWEEN 15 AND 25;
```

solution-2:

```sql
SELECT * 
FROM books 
WHERE (price >= 15) AND (price <= 25);
```

#### 17. Count books published after 2018.

solution-1:

```sql
SELECT COUNT(*) 
FROM books 
WHERE year_published > 2018;
```

solution-2:

```sql
SELECT COUNT(*) AS book_counts
FROM books 
WHERE year_published > 2018;
```


#### 18. Show 3 cheapest books.

```sql
SELECT * 
FROM books 
ORDER BY price ASC 
LIMIT 3;
```

#### 19. Find books whose rating is between 4.5 and 4.8.

solution-1:

```sql
SELECT * 
FROM books 
WHERE rating BETWEEN 4.5 AND 4.8;
```

solution-2:

```sql
SELECT * 
FROM books 
WHERE (rating >= 4.5) AND 
      (rating <= 4.8);
```

#### 20

Get total number of unique authors.

solution-1:

```sql
SELECT COUNT(DISTINCT author) 
FROM books;
```

solution-2:

```sql
SELECT COUNT(DISTINCT author) AS number_of_unique_authors
FROM books;
```

#### 21. Find books where author name starts with “K”.

```sql
SELECT * 
FROM books WHERE 
author LIKE 'K%';
```

#### 22. Find average rating for “Science Fiction” books.

solution-1:

```sql
SELECT AVG(rating) 
FROM books 
WHERE genre='Science Fiction';
```

solution-2:

```sql
SELECT AVG(rating) AS avg_rating
FROM books 
WHERE genre='Science Fiction';
```

#### 23

Show all books sorted by year newest first.

```sql
SELECT * 
FROM books 
ORDER BY year_published DESC;
```

#### 24. Find minimum and maximum prices.

solution-1:

```sql
SELECT MIN(price), 
       MAX(price) 
FROM books;
```

solution-2:

```sql
SELECT MIN(price) AS min_price, 
       MAX(price) AS max_price
FROM books;
```

#### 25. Find number of books per year.

solution-1:

```sql
SELECT year_published, COUNT(*) 
FROM books 
GROUP BY year_published;
```

solution-2:

```sql
SELECT year_published, COUNT(*) AS number_of_books_per_year
FROM books 
GROUP BY year_published;
```

## 🟠 Intermediate Queries (26–40)



#### 26. Find the highest rated book overall.

```sql
SELECT * 
FROM books 
ORDER BY rating DESC 
LIMIT 1;
```

#### 27. Find top 3 highest rated books per genre.

```sql
SELECT genre, title, rating 
FROM books 
WHERE (genre, rating) IN (
                           SELECT genre, MAX(rating) 
                           FROM books 
                           GROUP BY genre
                         );
```

#### 28. Show authors with average book price > $20.

```sql
SELECT author, AVG(price) AS avg_price 
FROM books 
GROUP BY author 
HAVING avg_price > 20;
```

#### 29. Find all books published between 2015 and 2020.

solution-1:

```sql
SELECT * 
FROM books 
WHERE year_published BETWEEN 2015 AND 2020;
```

solution-2:

```sql
SELECT * 
FROM books 
WHERE (year_published >= 2015) AND  
      (year_published <= 2020);
```

#### 30. List all books with “Life” in title, sorted by rating.

```sql
SELECT * 
FROM books 
WHERE title LIKE '%Life%' 
ORDER BY rating DESC;
```

#### 31. Find total revenue (sum of prices) of all books.

```sql
SELECT SUM(price) AS total_revenue 
FROM books;
```


#### 32. Show genre with highest average rating.

```sql
SELECT genre, AVG(rating) AS avg_rating 
FROM books 
GROUP BY genre 
ORDER BY avg_rating DESC 
LIMIT 1;
```

#### 33. Count books per author and sort by count descending.

```sql
SELECT author, COUNT(*) AS total_books 
FROM books 
GROUP BY author 
ORDER BY total_books DESC;
```

#### 34. Show authors who wrote more than 4 books.

```sql
SELECT author, COUNT(*) AS book_count 
FROM books 
GROUP BY author 
HAVING book_count > 4;
```

#### 35. Find all books with titles containing SQL or Python.

```sql
SELECT * 
FROM books 
WHERE (title LIKE '%SQL%')   OR 
      (title LIKE '%Python%');
```

#### 36. Show all books with rating >= 4.8 and price < 25.

```sql
SELECT * 
FROM books 
WHERE (rating >= 4.8) AND 
      (price < 25);
```

#### 37. Show the most recent book by each author.

```sql
SELECT author, MAX(year_published) AS latest_year 
FROM books 
GROUP BY author;
```

#### 38. Show total books and average price per genre.

```sql
SELECT genre, 
       COUNT(*) AS total_books, 
       AVG(price) AS avg_price 
FROM books 
GROUP BY genre;
```

#### 39. Find all books whose author is not Maria Lopez.

```sql
SELECT * 
FROM books 
WHERE author <> 'Maria Lopez';
```

#### 40. Delete all books older than 2010.

```sql
DELETE 
FROM books 
WHERE year_published < 2010;
```

