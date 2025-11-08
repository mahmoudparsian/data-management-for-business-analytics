# SQL JOINs for Beginners

source: https://learnsql.com/blog/sql-joins-made-easy

**What are SQL JOINs?**

	1. Databases usually have more than one table. 
	
	2. JOINs are an SQL construction used to join 
	   data from two or more tables. 
	
	3. When you want to use columns from two tables 
	   in a result table, the easiest way to do it 
	   is to write a JOIN query.


**The syntax of an SQL JOIN is:**

```sql
		SELECT *
		FROM table1
		JOIN table2
		  ON table1.id1 = table2.id2
```

OR

```sql
		SELECT *
		FROM table1 t1
		JOIN table2 t2
		  ON t1.id1 = t2.id2
```  
  
## INNER JOIN

	Let’s continue with our SQL JOINs for beginners guide. 
	We’ll see how SQL JOINs work in a simple example. Suppose 
	we want to find out which artist recorded a certain song. 
	In this basic data model, there are only two tables: 
	 
	      songs and artists
	      
	The songs table contains the columns 
	
	     song_id, song_title, artist_id. 
	     
	The artist table consists of 
	
	     artist_id, artist_name. 
	     
	As we can see, artist_id is in both tables; 
	we can use it to join them.

## Artists Table

```sql
CREATE TABLE artists (
    artist_id INT PRIMARY KEY,
    artist_name VARCHAR(64)
);

INSERT INTO artists (artist_id, artist_name)
VALUES
(1, 'Gloria Gaynor'),
(2, 'John Lennon'),
(3, 'Aretha Franklin'),
(4, 'ABBA'),
(5, 'Michael Jackson');

mysql> select * from artists;
+-----------+-----------------+
| artist_id | artist_name     |
+-----------+-----------------+
|         1 | Gloria Gaynor   |
|         2 | John Lennon     |
|         3 | Aretha Franklin |
|         4 | ABBA            |
|         5 | Michael Jackson |
+-----------+-----------------+
5 rows in set (0.001 sec)
```

## Songs Table

```sql
CREATE TABLE songs (
    song_id INT PRIMARY KEY,
    song_title VARCHAR(64),
    artist_id INT
    -- FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);

INSERT INTO songs (song_id, song_title, artist_id)
VALUES
(100, 'Dancing Queen', 4),
(101, 'Imagine', 2),
(102, 'I will Survive', 1),
(103, 'Rolling in the deep', 6),
(104, 'Respect', 3),
(105, 'Mamma Mia', 4);

mysql> select * from songs;
+---------+---------------------+-----------+
| song_id | song_title          | artist_id |
+---------+---------------------+-----------+
|     100 | Dancing Queen       |         4 |
|     101 | Imagine             |         2 |
|     102 | I will Survive      |         1 |
|     103 | Rolling in the deep |         6 |
|     104 | Respect             |         3 |
|     105 | Mamma Mia           |         4 |
+---------+---------------------+-----------+
6 rows in set (0.000 sec)
```

## JOIN without matching IDs: CROSS JOIN

	A cross join is a SQL operation that combines 
	every row from one table with every row from 
	another table, creating a "Cartesian product" 
	of all possible combinations. 
	
	Unlike other joins, it does not require a 
	join condition and is often used for generating 
	large datasets, performing exploratory analysis.


```sql
mysql> select count(*) from products;
+----------+
| count(*) |
+----------+
|        7 |
+----------+

mysql> select count(*) from stocks;
+----------+
| count(*) |
+----------+
|        5 |
+----------+

select p.product_name AS product_name,
       p.product_id AS p_product_id,  
       s.product_id AS s_product_id, 
       s.quantity AS quantity 
FROM products p, 
     stocks s;

+--------------+--------------+--------------+----------+
| product_name | p_product_id | s_product_id | quantity |
+--------------+--------------+--------------+----------+
| orange juice |          101 |          107 |       35 |
| orange juice |          101 |          105 |       13 |
| orange juice |          101 |          104 |        1 |
| orange juice |          101 |          102 |        4 |
| orange juice |          101 |          100 |        7 |
| white bread  |          102 |          107 |       35 |
| white bread  |          102 |          105 |       13 |
| white bread  |          102 |          104 |        1 |
| white bread  |          102 |          102 |        4 |
| white bread  |          102 |          100 |        7 |
| coffee       |          103 |          107 |       35 |
| coffee       |          103 |          105 |       13 |
| coffee       |          103 |          104 |        1 |
| coffee       |          103 |          102 |        4 |
| coffee       |          103 |          100 |        7 |
| eggs         |          105 |          107 |       35 |
| eggs         |          105 |          105 |       13 |
| eggs         |          105 |          104 |        1 |
| eggs         |          105 |          102 |        4 |
| eggs         |          105 |          100 |        7 |
| cereals      |          106 |          107 |       35 |
| cereals      |          106 |          105 |       13 |
| cereals      |          106 |          104 |        1 |
| cereals      |          106 |          102 |        4 |
| cereals      |          106 |          100 |        7 |
| chocolate    |          107 |          107 |       35 |
| chocolate    |          107 |          105 |       13 |
| chocolate    |          107 |          104 |        1 |
| chocolate    |          107 |          102 |        4 |
| chocolate    |          107 |          100 |        7 |
| tea          |          108 |          107 |       35 |
| tea          |          108 |          105 |       13 |
| tea          |          108 |          104 |        1 |
| tea          |          108 |          102 |        4 |
| tea          |          108 |          100 |        7 |
+--------------+--------------+--------------+----------+
35 rows in set (0.001 sec)
```

## INNER Join

	The simplest JOIN (also called an INNER JOIN) 
	takes the left table and matches information 
	for each row from the right table using artist_id. 
	
	Thus, the first song, “Dancing Queen”, has an 
	artist_id equal to “4”; in the artist table, 
	“4” is assigned to “ABBA”.

	As you can see in the artist table, there is 
	no artist_id equal to “6”, which is assigned 
	to the song “Rolling in the Deep”. 
	
	In the result table, only songs matched with an 
	artist_name are shown. There also aren’t any 
	Michael Jackson songs in the result table, as 
	there is no such song in the song table.

	Remember that INNER JOIN selects all rows from 
	both tables as long as there is a match between 
	the columns in both tables.

Here’s the SQL code:

```sql
SELECT *
FROM songs s
JOIN artists a
  ON s.artist_id = a.artist_id;
  
mysql> SELECT *
    -> FROM songs s
    -> JOIN artists a
    ->   ON s.artist_id = a.artist_id;
+---------+----------------+-----------+-----------+-----------------+
| song_id | song_title     | artist_id | artist_id | artist_name     |
+---------+----------------+-----------+-----------+-----------------+
|     100 | Dancing Queen  |         4 |         4 | ABBA            |
|     101 | Imagine        |         2 |         2 | John Lennon     |
|     102 | I will Survive |         1 |         1 | Gloria Gaynor   |
|     104 | Respect        |         3 |         3 | Aretha Franklin |
|     105 | Mamma Mia      |         4 |         4 | ABBA            |
+---------+----------------+-----------+-----------+-----------------+
5 rows in set (0.001 sec)  
```

## LEFT Join

	The second type of join we’re gonna mention in 
	this SQL JOINs tutorial for beginners is the 
	LEFT JOIN. 
	
	It always takes the first table (meaning the table 
	just after the FROM keyword) as a whole (all the 
	records in the first table). It takes only matching 
	records from the second table. If there is no matching 
	information, a NULL value is returned. This means that 
	there is no information available for that particular ID.

	Take another look at the artist table. 
	There is no artist_name with an artist_id 
	equal to “6”. This is why the song 
	“Rolling in the deep” did not occur in 
	the INNER JOIN query result. While it is 
	listed in the LEFT JOIN example below, it 
	has NULL values for artist_id and artist_name.

Here’s the SQL LEFT JOIN statement:

```sql
SELECT *
FROM songs s
LEFT JOIN artists a
  ON s.artist_id = a.artist_id;
  
+---------+---------------------+-----------+-----------+-----------------+
| song_id | song_title          | artist_id | artist_id | artist_name     |
+---------+---------------------+-----------+-----------+-----------------+
|     100 | Dancing Queen       |         4 |         4 | ABBA            |
|     101 | Imagine             |         2 |         2 | John Lennon     |
|     102 | I will Survive      |         1 |         1 | Gloria Gaynor   |
|     103 | Rolling in the deep |         6 |      NULL | NULL            |
|     104 | Respect             |         3 |         3 | Aretha Franklin |
|     105 | Mamma Mia           |         4 |         4 | ABBA            |
+---------+---------------------+-----------+-----------+-----------------+
6 rows in set (0.001 sec) 
```

## RIGHT JOIN

	The next type of join in our SQL JOINs tutorial for 
	beginners is the RIGHT JOIN. 
	
	Unlike LEFT JOIN, it takes all the records from 
	the second table (the one immediately after the 
	JOIN keyword) and only those records from the 
	first table that have matching artist_ids. 
	
	In this case, there are no 	Michael Jackson songs 
	in the database, so there are NULLs placed for 
	those song_ids, song_titles and artist_ids. 
	And now “Rolling in the Deep” has disappeared, 
	as in the right (artist) table there is no artist_id 
	equal to “6”.

Here’s the SQL code:

```sql
SELECT *
FROM songs s
RIGHT JOIN artists a
  ON s.artist_id = a.artist_id;
  
+---------+----------------+-----------+-----------+-----------------+
| song_id | song_title     | artist_id | artist_id | artist_name     |
+---------+----------------+-----------+-----------+-----------------+
|     102 | I will Survive |         1 |         1 | Gloria Gaynor   |
|     101 | Imagine        |         2 |         2 | John Lennon     |
|     104 | Respect        |         3 |         3 | Aretha Franklin |
|     105 | Mamma Mia      |         4 |         4 | ABBA            |
|     100 | Dancing Queen  |         4 |         4 | ABBA            |
|    NULL | NULL           |      NULL |         5 | Michael Jackson |
+---------+----------------+-----------+-----------+-----------------+
6 rows in set (0.001 sec)
```

## FULL JOIN

	The last type of JOIN we’re gonna discuss in our 
	SQL JOINs for beginners guide is the FULL JOIN. 
	It is a combination of LEFT JOIN and RIGHT JOIN, 
	as it takes all the records from both tables and 
	places NULL values where the information from the 
	matching table is missing. In the example below, 
	you can see NULLs for artist_id equal to “6” (yes, 
	it should be Adele!) and NULLs for Michael Jackson 
	songs with artist_id equal to “5”. (Yes, “Billie Jean” 
	exists, but SQL does not know it!)

```sql
-- NOTE: MySQL does NOT support FULL OUTER JOIN directly.
SELECT *
FROM songs s
FULL JOIN artists a
  ON s.artist_id = a.artist_id;
```  

Solution in MySQL:

```sql
SELECT *
FROM artists a
LEFT JOIN songs s ON a.artist_id = s.artist_id

UNION

SELECT *
FROM artists a
RIGHT JOIN songs s ON a.artist_id = s.artist_id;

+-----------+-----------------+---------+---------------------+-----------+
| artist_id | artist_name     | song_id | song_title          | artist_id |
+-----------+-----------------+---------+---------------------+-----------+
|         1 | Gloria Gaynor   |     102 | I will Survive      |         1 |
|         2 | John Lennon     |     101 | Imagine             |         2 |
|         3 | Aretha Franklin |     104 | Respect             |         3 |
|         4 | ABBA            |     105 | Mamma Mia           |         4 |
|         4 | ABBA            |     100 | Dancing Queen       |         4 |
|         5 | Michael Jackson |    NULL | NULL                |      NULL |
|      NULL | NULL            |     103 | Rolling in the deep |         6 |
+-----------+-----------------+---------+---------------------+-----------+
7 rows in set (0.001 sec)
```

------

# Real Life Examples: `products` and `stocks`

Real Life Example: Stores and Products

	Now we will show you how to use SQL JOINs 
	in a real business example. This time, our 
	SQL JOINs tutorial for beginners will use 
	an example from the retail industry. 
	
	Imagine you run a store and you want to see 
	which products are out of stock. You also want 
	to check if your database manager keeps things 
	in order. 
	
	Let’s assume the database has only two tables: 
	
	         products and stocks


CREATE TABLE products (
   product_id    INT, 
   product_name  VARCHAR(40)
);

CREATE TABLE stocks (
   product_id    INT, 
   quantity      INT
);

INSERT INTO products (product_id, product_name)
VALUES
(101, 'orange juice'),
(102, 'white bread'),
(103, 'coffee'),
(105, 'eggs'),
(106, 'cereals'),
(107, 'chocolate'),
(108, 'tea');

mysql> select * from products;
+------------+--------------+
| product_id | product_name |
+------------+--------------+
|        101 | orange juice |
|        102 | white bread  |
|        103 | coffee       |
|        105 | eggs         |
|        106 | cereals      |
|        107 | chocolate    |
|        108 | tea          |
+------------+--------------+
7 rows in set (0.001 sec)

INSERT INTO stocks (product_id, quantity)   
VALUES
(100, 7),
(102, 4),
(104, 1),
(105, 13),
(107, 35);

mysql> select * from stocks;
+------------+----------+
| product_id | quantity |
+------------+----------+
|        100 |        7 |
|        102 |        4 |
|        104 |        1 |
|        105 |       13 |
|        107 |       35 |
+------------+----------+
5 rows in set (0.001 sec)

## INNER Join

```sql
SELECT
  p.product_id,
  p.product_name,
  s.quantity
FROM products p
INNER JOIN stocks s
  ON p.product_id = s.product_id;
```

output:

```
+------------+--------------+----------+
| product_id | product_name | quantity |
+------------+--------------+----------+
|        102 | white bread  |        4 |
|        105 | eggs         |       13 |
|        107 | chocolate    |       35 |
+------------+--------------+----------+
3 rows in set (0.001 sec)
```

## Which Products Should Be Ordered? LEFT JOIN

	Suppose we want to check which products are out 
	of stock and need to be reordered. 
	
	To do that, we will use a LEFT JOIN to match records 
	from the products table to the stocks table. We can 
	visualize this as putting the products table on the 
	left and the stocks table on the right. 
	
	Then we look for records in both tables that match by 
	product_id. Records without matching product_id fields 
	are given a NULL. (See the result table below.)

```sql
SELECT
  p.product_id,
  p.product_name,
  s.quantity
FROM products p
LEFT JOIN stocks s
  ON p.product_id = s.product_id;
  
+------------+--------------+----------+
| product_id | product_name | quantity |
+------------+--------------+----------+
|        101 | orange juice |     NULL |
|        102 | white bread  |        4 |
|        103 | coffee       |     NULL |
|        105 | eggs         |       13 |
|        106 | cereals      |     NULL |
|        107 | chocolate    |       35 |
|        108 | tea          |     NULL |
+------------+--------------+----------+
7 rows in set (0.001 sec)
```

## Do We Know What We Sell? RIGHT JOIN

	The role of the database manager is to keep 
	everything in our databases in order. Let’s 
	say we want to verify if he or she is doing 
	a good job. We’ll check if the products table 
	is being updated with new products. 
	
	For this, we will use a RIGHT JOIN.

	RIGHT JOIN takes all the records from the 
	stocks table and puts it to the right (just 
	as the RIGHT JOIN would suggest). 
	
	Then, it displays only the products table 
	records that have a matching product_id.

```sql
SELECT
  p.product_name,
  p.product_id,  
  s.product_id,
  s.quantity
FROM products p
RIGHT JOIN stocks s
  ON p.product_id = s.product_id;
  
+--------------+------------+------------+----------+
| product_name | product_id | product_id | quantity |
+--------------+------------+------------+----------+
| NULL         |       NULL |        100 |        7 |
| white bread  |        102 |        102 |        4 |
| NULL         |       NULL |        104 |        1 |
| eggs         |        105 |        105 |       13 |
| chocolate    |        107 |        107 |       35 |
+--------------+------------+------------+----------+
5 rows in set (0.001 sec)
```

## Show Everything Available

	To get a full picture of the situation, 
	we may want to see all product names and 
	all their quantities in both tables. 
	
	Then we can see which products need to be 
	reordered and which product_ids are missing 
	a product_name. 
	
	For this, FULL JOIN comes in handy! 
	It takes all records from the left table 
	(products) and all records from the right table 
	(stocks) and matches only the records that have 
	the same id (product_id); it inserts a NULL on 
	the right if there is a missing product_name or 
	on the left if there are no items in stocks.

```sql
-- NOTE: MySQL does NOT support FULL OUTER JOIN directly.
SELECT *
FROM products p
FULL JOIN stocks s
  ON p.product_id = s.product_id;
```  

**Solution in MySQL:**

```sql
SELECT *
FROM products p
LEFT JOIN stocks s ON p.product_id = s.product_id

UNION

SELECT *
FROM products p
RIGHT JOIN stocks s ON p.product_id = s.product_id;

+------------+--------------+------------+----------+
| product_id | product_name | product_id | quantity |
+------------+--------------+------------+----------+
|        101 | orange juice |       NULL |     NULL |
|        102 | white bread  |        102 |        4 |
|        103 | coffee       |       NULL |     NULL |
|        105 | eggs         |        105 |       13 |
|        106 | cereals      |       NULL |     NULL |
|        107 | chocolate    |        107 |       35 |
|        108 | tea          |       NULL |     NULL |
|       NULL | NULL         |        100 |        7 |
|       NULL | NULL         |        104 |        1 |
+------------+--------------+------------+----------+
9 rows in set (0.002 sec)
```