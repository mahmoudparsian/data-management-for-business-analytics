# 50 Tasks After MySQL Installation

	Okay i have installed MySQL 9.0 on my MacBook 
	successfully. New let's create a data story 
	which will create 2 database tables and then 
	perform the next 50 tasks: starting simple, 
	then intermediate, then some sub queries and 
	ranking functions, also provide some sample 
	rows for the tables

	Let’s build a data story around a fictional online 
	bookstore called “BookVerse” 📚. We'll start by 
	creating two foundational tables: 
	
	          1. Authors 
	          2. Books
	          
	Then we’ll walk through 50 SQL tasks, progressing 
	from basic to advanced.

## 🏗️ Step 1: Create Tables

Table 1: Authors

~~~sql
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Country VARCHAR(50),
    BirthYear INT
);
~~~

Table 2: Books

~~~sql
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(150),
    Genre VARCHAR(50),
    PublishedYear INT,
    Price DECIMAL(6,2),
    AuthorID INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);
~~~

## 🧪 Step 2: Sample Data

#### Insert into Authors

~~~sql
INSERT INTO Authors VALUES

INSERT INTO Authors (AuthorID, Name, Country, BirthYear) 
VALUES
(1, 'George Orwell', 'United Kingdom', 1903),
(2, 'Jane Austen', 'United Kingdom', 1775),
(3, 'Mark Twain', 'United States', 1835),
(4, 'Gabriel Garcia Marquez', 'Colombia', 1927),
(5, 'Haruki Murakami', 'Japan', 1949),
(6, 'J.K. Rowling', 'United Kingdom', 1965),
(7, 'Ernest Hemingway', 'United States', 1899),
(8, 'Leo Tolstoy', 'Russia', 1828),
(9, 'Franz Kafka', 'Czech Republic', 1883),
(10, 'Chinua Achebe', 'Nigeria', 1930);
~~~

#### Insert into Books

~~~sql
INSERT INTO Books (BookID, Title, Genre, PublishedYear, Price, AuthorID) 
VALUES
### George Orwell
(1, '1984', 'Dystopian', 1949, 15.99, 1),
(2, 'Animal Farm', 'Political Satire', 1945, 9.99, 1),
(3, 'Homage to Catalonia', 'Memoir', 1938, 12.99, 1),
(4, 'Down and Out in Paris and London', 'Non-Fiction', 1933, 11.50, 1),

### Jane Austen
(5, 'Pride and Prejudice', 'Romance', 1813, 12.50, 2),
(6, 'Sense and Sensibility', 'Romance', 1811, 11.50, 2),
(7, 'Emma', 'Romance', 1815, 13.75, 2),
(8, 'Mansfield Park', 'Romance', 1814, 12.25, 2),

### Mark Twain
(9, 'Adventures of Huckleberry Finn', 'Adventure', 1884, 13.25, 3),
(10, 'The Adventures of Tom Sawyer', 'Adventure', 1876, 10.99, 3),
(11, 'A Connecticut Yankee in King Arthur''s Court', 'Satire', 1889, 14.50, 3),
(12, 'The Prince and the Pauper', 'Historical Fiction', 1881, 12.00, 3),

### Gabriel Garcia Marquez
(13, 'One Hundred Years of Solitude', 'Magical Realism', 1967, 18.75, 4),
(14, 'Love in the Time of Cholera', 'Romance', 1985, 16.00, 4),
(15, 'Chronicle of a Death Foretold', 'Mystery', 1981, 14.25, 4),
(16, 'The Autumn of the Patriarch', 'Magical Realism', 1975, 15.50, 4),

### Haruki Murakami
(17, 'Kafka on the Shore', 'Magical Realism', 2002, 14.50, 5),
(18, 'Norwegian Wood', 'Romance', 1987, 13.75, 5),
(19, 'The Wind-Up Bird Chronicle', 'Fiction', 1994, 17.00, 5),
(20, '1Q84', 'Fantasy', 2009, 19.99, 5),

### J.K. Rowling
(21, 'Harry Potter and the Sorcerer''s Stone', 'Fantasy', 1997, 19.99, 6),
(22, 'Harry Potter and the Chamber of Secrets', 'Fantasy', 1998, 20.99, 6),
(23, 'Harry Potter and the Prisoner of Azkaban', 'Fantasy', 1999, 21.99, 6),
(24, 'Harry Potter and the Goblet of Fire', 'Fantasy', 2000, 22.99, 6),

### Ernest Hemingway
(25, 'The Old Man and the Sea', 'Literary Fiction', 1952, 12.25, 7),
(26, 'A Farewell to Arms', 'War Fiction', 1929, 13.50, 7),
(27, 'For Whom the Bell Tolls', 'War Fiction', 1940, 14.50, 7),
(28, 'The Sun Also Rises', 'Literary Fiction', 1926, 12.75, 7),

### Leo Tolstoy
(29, 'War and Peace', 'Historical Fiction', 1869, 25.00, 8),
(30, 'Anna Karenina', 'Literary Fiction', 1877, 23.50, 8),
(31, 'Resurrection', 'Philosophical Fiction', 1899, 19.50, 8),
(32, 'The Death of Ivan Ilyich', 'Philosophical Fiction', 1886, 11.50, 8),

### Franz Kafka
(33, 'The Metamorphosis', 'Existentialism', 1915, 9.75, 9),
(34, 'The Trial', 'Philosophical Fiction', 1925, 11.99, 9),
(35, 'The Castle', 'Philosophical Fiction', 1926, 12.50, 9),
(36, 'Amerika', 'Literary Fiction', 1927, 13.00, 9),

### Chinua Achebe
(37, 'Things Fall Apart', 'Historical Fiction', 1958, 14.00, 10),
(38, 'No Longer at Ease', 'Historical Fiction', 1960, 13.25, 10),
(39, 'Arrow of God', 'Historical Fiction', 1964, 15.00, 10),
(40, 'Anthills of the Savannah', 'Political Fiction', 1987, 16.50, 10);

~~~

## 🧠 Step 3: 50 SQL Tasks

### 🔹 Basic Queries (1–10)

~~~
List all authors.
List all books.
Find books priced above $13.
Find books published after 2000.
Count total books.
Count books per genre.
Find distinct genres.
Get books by Haruki Murakami.
Get books from UK authors.
Find the oldest book.
~~~

### 🔸 Intermediate Queries (11–30)

~~~
Get average book price.
Get max and min book price.
List books with their author names.
Count books per author.
Find authors with more than 1 book.
List books sorted by price descending.
List authors born before 1950.
Find books not in the “Fantasy” genre.
Find books with titles containing “Harry”.
Get books grouped by genre with average price.
Find authors from Asia.
Get books published between 1990 and 2010.
List books with price between $12 and $15.
Get authors and their number of books.
Find authors with books published after 2000.
Get total revenue if all books sold once.
Find books with title length > 20 characters.
Get books ordered by published year.
Find authors with no books (add one dummy author).
Get books with price rounded to nearest dollar.
~~~

### 🔹 Subqueries & Joins (31–40)

~~~
Find authors who wrote books in “Fiction”.
Get books by authors born after 1960.
Find books by authors from Nigeria.
Get books with price above average.
Find authors with books below average price.
List books with genre and author country.
Find books by authors with more than 1 book.
Get authors whose books span multiple genres.
Find books by youngest author.
Get authors with highest-priced book.
~~~

### 🔸 Advanced: Ranking, Window Functions, CTEs (41–50)

~~~
Rank books by price.
Rank books within each genre by price.
Get top 2 most expensive books per genre.
Use CTE to find average price per genre.
Use CTE to find authors with books above genre average.
Use window function to get running total of book prices.
Use window function to get percent rank of books by price.
Use CTE to find genre with most books.
Use dense rank to rank authors by number of books.
Use CTE to find authors with books in both “Fiction” and “Fantasy”.
~~~

## SQL for all 50 tasks based on the Authors and Books tables 

# 🔹 Basic Queries (1–10)

###  1. List all authors

~~~sql
SELECT * 
FROM Authors;
~~~

### 2. List all books

~~~sql
SELECT * 
FROM Books;
~~~

### 3. Find books priced above `$13`

~~~sql
SELECT * 
FROM Books 
WHERE Price > 13;
~~~

### 4. Find books published after 2000

~~~sql
SELECT * 
FROM Books 
WHERE PublishedYear > 2000;
~~~

### 5. Count total books

~~~sql
SELECT COUNT(*) AS TotalBooks 
FROM Books;
~~~

### 6. Count books per genre

~~~sql
SELECT Genre, COUNT(*) AS BookCount 
FROM Books 
GROUP BY Genre;
~~~

### 7. Find distinct genres
~~~sql
SELECT DISTINCT Genre 
FROM Books;
~~~

### 8. Get books by George Orwell

~~~sql
SELECT * 
FROM Books 
WHERE Name = 'George Orwell';
~~~

### 9. Get books from UK authors

~~~sql
SELECT B.* 
FROM Books B 
JOIN Authors A ON B.AuthorID = A.AuthorID 
WHERE A.Country = 'United Kingdom';
~~~

### 10. Find the oldest book

~~~sql
SELECT * 
FROM Books 
ORDER BY PublishedYear ASC   
LIMIT 1;
~~~

## 🔸 Intermediate Queries (11–30)

###  11. Get average book price

~~~sql
SELECT AVG(Price) AS AvgPrice 
FROM Books;
~~~

### 12. Get max and min book price

~~~sql
SELECT MAX(Price) AS MaxPrice, 
       MIN(Price) AS MinPrice 
FROM Books;
~~~

### 13. List books with their author names

~~~sql
SELECT B.Title, A.Name 
FROM Books B 
JOIN Authors A ON B.AuthorID = A.AuthorID;
~~~

### 14. Count books per author

~~~sql
SELECT AuthorID, COUNT(*) AS BookCount 
FROM Books 
GROUP BY AuthorID;
~~~

### 15. Find authors with more than 1 book

~~~sql
SELECT AuthorID 
FROM Books 
GROUP BY AuthorID 
HAVING COUNT(*) > 1;
~~~

### 16. List books sorted by price descending (highest to lowest)

~~~sql
SELECT * 
FROM Books 
ORDER BY Price DESC;
~~~

### 17. List authors born before 1950

~~~sql
SELECT * 
FROM Authors 
WHERE BirthYear < 1950;
~~~

### 18. Find books not in the “Fantasy” genre

~~~sql
SELECT * 
FROM Books 
WHERE Genre != 'Fantasy';
~~~

### 19. Find books with titles containing “Harry”

~~~sql
SELECT * 
FROM Books 
WHERE Title LIKE '%Harry%';
~~~

### 20. Get books grouped by genre with average price

~~~sql
SELECT 
       Genre, 
       AVG(Price) AS AvgPrice 
FROM 
       Books 
GROUP BY 
       Genre;
~~~

### 21. Find authors from Asia
~~~sql
SELECT * 
FROM Authors 
WHERE Country IN ('Japan', 'China', 'India');
~~~

### 22. Get books published between 1990 and 2010
~~~sql
SELECT * 
FROM Books 
WHERE PublishedYear 
BETWEEN 1990 AND 2010;
~~~

### 23. List books with price between $12 and $15

~~~sql
SELECT * 
FROM Books 
WHERE Price BETWEEN 12 AND 15;
~~~

### 24. Get authors and their number of books
~~~sql
SELECT A.Name, COUNT(B.BookID) AS BookCount 
FROM Authors A 
LEFT JOIN Books B ON A.AuthorID = B.AuthorID 
GROUP BY A.Name;
~~~

### 25. Find authors with books published after 2000
~~~sql
SELECT DISTINCT A.* 
FROM Authors A 
JOIN Books B ON A.AuthorID = B.AuthorID 
WHERE B.PublishedYear > 2000;
~~~

### 26. Get total revenue if all books sold once
~~~sql
SELECT SUM(Price) AS TotalRevenue 
FROM Books;
~~~

### 27. Find books with title length > 20 characters

~~~sql
SELECT * 
FROM Books 
WHERE LENGTH(Title) > 20;
~~~

### 28. Get books ordered by published year

~~~sql
SELECT * 
FROM Books 
ORDER BY PublishedYear;
~~~

### 29. Find authors with no books (add one dummy author first)

**Step-1: add one dummy author first:**

~~~sql
INSERT INTO Authors (AuthorID, Name, Country, BirthYear) 
VALUES 
(5, 'Isabel Allende', 'Chile', 1942);
~~~

**then find authors with no books:**

~~~sql
SELECT * 
FROM Authors 
WHERE AuthorID NOT IN (SELECT DISTINCT AuthorID FROM Books);
~~~

### 30. Get books with price rounded to nearest dollar

~~~sql
SELECT Title, ROUND(Price) AS RoundedPrice 
FROM Books;
~~~

##🔹 Subqueries & Joins (31–40)

### 31. Find authors who wrote books in “Fiction”

~~~sql
SELECT DISTINCT A.* 
FROM Authors A JOIN Books B ON A.AuthorID = B.AuthorID 
WHERE B.Genre = 'Fiction';
~~~

### 32. Get books by authors born after 1960

~~~sql
SELECT B.* 
FROM Books B 
JOIN Authors A ON B.AuthorID = A.AuthorID 
WHERE A.BirthYear > 1960;
~~~

### 33. Find books by authors from Nigeria

~~~sql
SELECT B.* 
FROM Books B JOIN Authors A ON B.AuthorID = A.AuthorID 
WHERE A.Country = 'Nigeria';
~~~

### 34. Get books with price above average

~~~sql
SELECT * 
FROM Books 
WHERE Price > (SELECT AVG(Price) FROM Books);
~~~

### 35. Find authors with books below average price

~~~sql
SELECT DISTINCT A.* 
FROM Authors A 
JOIN Books B ON A.AuthorID = B.AuthorID 
WHERE B.Price < (SELECT AVG(Price) FROM Books);
~~~

### 36. List books with genre and author country
~~~sql
SELECT B.Title, B.Genre, A.Country 
FROM Books B 
JOIN Authors A ON B.AuthorID = A.AuthorID;
~~~

### 37. Find books by authors with more than 1 book
~~~sql
SELECT B.* 
FROM Books B 
WHERE AuthorID IN 
   (SELECT AuthorID FROM Books GROUP BY AuthorID HAVING COUNT(*) > 1);
~~~

### 38. Get authors whose books span multiple genres
~~~sql
SELECT A.* 
FROM Authors A 
JOIN Books B ON A.AuthorID = B.AuthorID 
GROUP BY A.AuthorID 
HAVING COUNT(DISTINCT B.Genre) > 1;
~~~

### 39. Find books by youngest author

~~~sql
SELECT B.* 
FROM Books B 
WHERE AuthorID = (SELECT AuthorID FROM Authors ORDER BY BirthYear DESC LIMIT 1);
~~~

### 40. Get authors with highest-priced book

~~~sql
SELECT A.* 
FROM Authors A 
JOIN Books B ON A.AuthorID = B.AuthorID 
WHERE B.Price = (SELECT MAX(Price) FROM Books);
~~~

## 🔸 Advanced: Ranking, Window Functions, CTEs (41–50)

### 41. Rank books by price

~~~sql
SELECT 
      Title, 
      Price, 
      RANK() OVER (ORDER BY Price DESC) AS PriceRank 
FROM 
      Books;
~~~

### 42. Rank books within each genre by price

~~~sql
SELECT 
       Title, 
       Genre, 
       Price, 
       RANK() OVER (PARTITION BY Genre ORDER BY Price DESC) AS GenrePriceRank 
FROM 
       Books;
~~~

### 43. Get top 2 most expensive books per genre

~~~sql
WITH ranked_books as 
(
  SELECT *, 
         RANK() OVER (PARTITION BY Genre ORDER BY Price DESC) AS rnk 
  FROM Books
) 
SELECT * 
FROM ranked_books
WHERE rnk <= 2;
~~~

### 44. Use CTE (common-table-expression) to find average price per genre
~~~sql
WITH GenreAvg AS 
(
  SELECT Genre, AVG(Price) AS AvgPrice 
  FROM Books 
  GROUP BY Genre
)
SELECT * 
FROM GenreAvg;
~~~

### 45. Use CTE to find authors with books above genre average

~~~sql
WITH GenreAvg AS 
(
  SELECT Genre, AVG(Price) AS AvgPrice 
  FROM Books 
  GROUP BY Genre
)
SELECT DISTINCT A.* 
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
JOIN GenreAvg G ON B.Genre = G.Genre
WHERE B.Price > G.AvgPrice;
~~~

### 46. Use window function to get running total of book prices

~~~sql
SELECT 
      Title, 
      Price, 
      SUM(Price) OVER (ORDER BY PublishedYear) AS RunningTotal 
FROM 
      Books;
~~~

### 47. Use window function to get percent rank of books by price

~~~sql
SELECT 
       Title, 
       Price, 
       PERCENT_RANK() OVER (ORDER BY Price DESC) AS PricePercentRank 
FROM 
       Books;
~~~

### 48. Use CTE to find genre with most books

~~~sql
WITH GenreCount AS 
(
  SELECT Genre, COUNT(*) AS Count 
  FROM Books 
  GROUP BY Genre
)
SELECT * 
FROM GenreCount 
ORDER BY Count DESC 
LIMIT 1;
~~~

### 49. Use dense rank to rank authors by number of books

~~~sql
WITH  Author_Stats as
(
  SELECT A.Name, COUNT(B.BookID) AS BookCount 
  FROM Authors A 
  LEFT JOIN Books B ON A.AuthorID = B.AuthorID 
  GROUP BY A.Name
) 
SELECT 
       Name, 
       BookCount, 
       DENSE_RANK() OVER (ORDER BY BookCount DESC) AS AuthorRank
FROM 
       Author_Stats;
~~~

### 50. Use CTE to find authors with books in both “Fiction” and “Fantasy”

~~~sql
WITH GenreAuthors AS (
  SELECT AuthorID, Genre 
  FROM Books 
  GROUP BY AuthorID, Genre
)
SELECT A.* 
FROM Authors A
WHERE AuthorID IN (
  SELECT AuthorID FROM GenreAuthors WHERE Genre = 'Fiction'
  INTERSECT
  SELECT AuthorID FROM GenreAuthors WHERE Genre = 'Fantasy';
);
~~~

