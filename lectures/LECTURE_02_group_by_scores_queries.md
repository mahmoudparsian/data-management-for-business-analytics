# Understanding `GROUP BY` in SQL

		The GROUP BY clause in SQL is used to group 
		rows that have the same values in specified 
		columns into a summary row. 
		
		This clause is typically used in conjunction 
		with aggregate functions (like COUNT(), SUM(), 
		AVG(), MIN(), MAX()) to perform calculations on 
		each group of rows, rather than on the entire 
		result set.

		How it works:
		
			**Grouping**: The GROUP BY clause divides the 
			rows of a table into groups based on the 
			values in one or more specified columns. 
			All rows with  identical  values  in  the 
			GROUP BY columns will belong to the same 
			group.

			**Aggregation**: Once the groups are formed, 
			aggregate functions can be applied to each 
			group. These functions then return a single 
			summary value for each group. For example, 
			SUM() will calculate the total for each group, 
			AVG() will calculate the average for each group, 
			and so on.

## 1. Introduction

* There are 3 countries (`USA`, `CANADA`, `GERMANY`).

* There are 2 teams: `RED` and `BLUE`.

* Consider the following table (called `scores`) representing the 
scores for `RED` and `BLUE` teams.

## 2. Database `dom_db`

Create a database called `dom_db`.

If you have already created this database, then no action is required.

## 3. Table Definition

Assuming that you have created a database called: `dom_db`.

```sql
USE dom_db;

CREATE TABLE scores (
   country VARCHAR(20),
   team    VARCHAR(20),
   score   INT
);


mysql> CREATE TABLE scores (
    ->    country VARCHAR(20),
    ->    team    VARCHAR(20),
    ->    score   INT
    -> );
Query OK, 0 rows affected (0.008 sec)

```

## 4. Table Population

```sql
INSERT INTO scores(country, team, score) VALUES
('USA', 'RED', 10),
('USA', 'RED', 20),
('USA', 'RED', 30),
('USA', 'BLUE', 20),
('USA', 'BLUE', 40),
('USA', 'BLUE', 70),
('CANADA', 'RED', 30),
('CANADA', 'RED', 60),
('CANADA', 'RED', 80),
('CANADA', 'BLUE', 10),
('CANADA', 'BLUE', 40),
('CANADA', 'BLUE', 90),
('GERMANY', 'RED', 20),
('GERMANY', 'RED', 40),
('GERMANY', 'BLUE', 30),
('GERMANY', 'BLUE', 70);

mysql> INSERT INTO scores(country, team, score) VALUES
    -> ('USA', 'RED', 10),
    -> ('USA', 'RED', 20),
    -> ('USA', 'RED', 30),
    -> ('USA', 'BLUE', 20),
    -> ('USA', 'BLUE', 40),
    -> ('USA', 'BLUE', 70),
    -> ('CANADA', 'RED', 30),
    -> ('CANADA', 'RED', 60),
    -> ('CANADA', 'RED', 80),
    -> ('CANADA', 'BLUE', 10),
    -> ('CANADA', 'BLUE', 40),
    -> ('CANADA', 'BLUE', 90),
    -> ('GERMANY', 'RED', 20),
    -> ('GERMANY', 'RED', 40),
    -> ('GERMANY', 'BLUE', 30),
    -> ('GERMANY', 'BLUE', 70);
Query OK, 16 rows affected (0.001 sec)
Records: 16  Duplicates: 0  Warnings: 0

mysql> select * from scores;
+---------+------+-------+
| country | team | score |
+---------+------+-------+
| USA     | RED  |    10 |
| USA     | RED  |    20 |
| USA     | RED  |    30 |
| USA     | BLUE |    20 |
| USA     | BLUE |    40 |
| USA     | BLUE |    70 |
| CANADA  | RED  |    30 |
| CANADA  | RED  |    60 |
| CANADA  | RED  |    80 |
| CANADA  | BLUE |    10 |
| CANADA  | BLUE |    40 |
| CANADA  | BLUE |    90 |
| GERMANY | RED  |    20 |
| GERMANY | RED  |    40 |
| GERMANY | BLUE |    30 |
| GERMANY | BLUE |    70 |
+---------+------+-------+
16 rows in set (0.001 sec)

```

## 5. The `GROUP_CONCAT()` function in MySQL

		To understand the GROUP BY in SQL, we will 
		use the GROUP_CONCAT() function.

		The GROUP_CONCAT() function in MySQL is an 
		aggregate function that concatenates strings 
		from a group of rows into a single string. 
		This function is particularly useful when 
		you need to combine related data from multiple 
		rows into a more concise format. 

## 6. SQL Queries using GROUP BY 


**1. Find the total score per country and order by total score**

```sql
SELECT country, 
       SUM(score) AS total_score
FROM scores
GROUP BY country
ORDER BY total_score;
```

output:

```
+---------+-------------+
| country | total_score |
+---------+-------------+
| GERMANY |         160 |
| USA     |         190 |
| CANADA  |         310 |
+---------+-------------+
3 rows in set (0.001 sec)
```

**2. Find the total score per country (sorted by total score) and show the grouped scores**

```sql
SELECT country, 
       SUM(score) AS total_score,
       GROUP_CONCAT(score)
FROM scores
GROUP BY country
ORDER BY total_score;
```

output:

```
+---------+-------------+---------------------+
| country | total_score | GROUP_CONCAT(score) |
+---------+-------------+---------------------+
| GERMANY |         160 | 20,40,30,70         |
| USA     |         190 | 10,20,30,20,40,70   |
| CANADA  |         310 | 30,60,80,10,40,90   |
+---------+-------------+---------------------+
3 rows in set (0.001 sec)
```




**3. Find the average score per team**

```sql
SELECT team, 
       AVG(score) AS avg_score
FROM scores
GROUP BY team;
```

output:

```
+------+-----------+
| team | avg_score |
+------+-----------+
| RED  |   36.2500 |
| BLUE |   46.2500 |
+------+-----------+
2 rows in set (0.001 sec)
```

**4. Find the rounded average score per team**

```sql
SELECT team, 
       ROUND(AVG(score)) AS avg_score
FROM scores
GROUP BY team;
```

output:

```
+------+-----------+
| team | avg_score |
+------+-----------+
| RED  |        36 |
| BLUE |        46 |
+------+-----------+
2 rows in set (0.001 sec)
```

**5. Find the rounded average score per team and list of scored grouped**

```sql
SELECT team, 
       ROUND(AVG(score)) AS avg_score,
       GROUP_CONCAT(score) AS list_of_scores
FROM scores
GROUP BY team;
```

output:

```
+------+-----------+-------------------------+
| team | avg_score | list_of_scores          |
+------+-----------+-------------------------+
| BLUE |        46 | 20,40,70,10,40,90,30,70 |
| RED  |        36 | 10,20,30,30,60,80,20,40 |
+------+-----------+-------------------------+
2 rows in set (0.001 sec)
```

------

**6. Count the number of games (rows) per country and team**

```sql
SELECT country, 
       team, 
       COUNT(*) AS games
FROM 
       scores
GROUP BY 
       country, 
       team;
```

output:

```
+---------+------+-------+
| country | team | games |
+---------+------+-------+
| USA     | RED  |     3 |
| USA     | BLUE |     3 |
| CANADA  | RED  |     3 |
| CANADA  | BLUE |     3 |
| GERMANY | RED  |     2 |
| GERMANY | BLUE |     2 |
+---------+------+-------+
6 rows in set (0.001 sec)
```


**7. Find the highest score recorded per country**

```sql
SELECT country, 
       MAX(score) AS max_score
FROM scores
GROUP BY country;
```

output:

```
+---------+-----------+
| country | max_score |
+---------+-----------+
| USA     |        70 |
| CANADA  |        90 |
| GERMANY |        70 |
+---------+-----------+
3 rows in set (0.001 sec)
```

**7.1 Find the highest score recorded per country and make sure the highest score is more than 80.**

```sql
SELECT country, 
       MAX(score) AS max_score
FROM scores
GROUP BY country
HAVING max_score > 80;
```

output:

```
+---------+-----------+
| country | max_score |
+---------+-----------+
| CANADA  |        90 |
+---------+-----------+
1 row in set (0.001 sec)
```


**8. Find the lowest score recorded per team**

```sql
SELECT team, 
       MIN(score) AS min_score
FROM scores
GROUP BY team;
```

output:

```
+------+-----------+
| team | min_score |
+------+-----------+
| RED  |        10 |
| BLUE |        10 |
+------+-----------+
2 rows in set (0.001 sec)
```

**9. Find the total scores grouped by country and team**

```sql
SELECT country, team, SUM(score) AS total_score
FROM scores
GROUP BY country, team;
```

output:

```
+---------+------+-------------+
| country | team | total_score |
+---------+------+-------------+
| USA     | RED  |          60 |
| USA     | BLUE |         130 |
| CANADA  | RED  |         170 |
| CANADA  | BLUE |         140 |
| GERMANY | RED  |          60 |
| GERMANY | BLUE |         100 |
+---------+------+-------------+
6 rows in set (0.001 sec)
```


**10. Find the average score grouped by country and team**

```sql
SELECT country, team, AVG(score) AS avg_score
FROM scores
GROUP BY country, team;
```

output:

```
+---------+------+-----------+
| country | team | avg_score |
+---------+------+-----------+
| USA     | RED  |   20.0000 |
| USA     | BLUE |   43.3333 |
| CANADA  | RED  |   56.6667 |
| CANADA  | BLUE |   46.6667 |
| GERMANY | RED  |   30.0000 |
| GERMANY | BLUE |   50.0000 |
+---------+------+-----------+
6 rows in set (0.001 sec)
```


**11. Find the ROUNDED average score grouped by country and team**

```sql
SELECT country, team, ROUND(AVG(score)) AS avg_score
FROM scores
GROUP BY country, team;
```

output:

```
+---------+------+-----------+
| country | team | avg_score |
+---------+------+-----------+
| USA     | RED  |        20 |
| USA     | BLUE |        43 |
| CANADA  | RED  |        57 |
| CANADA  | BLUE |        47 |
| GERMANY | RED  |        30 |
| GERMANY | BLUE |        50 |
+---------+------+-----------+
6 rows in set (0.001 sec)
```


**12. Count how many scores are greater than 50 per country**

```sql
SELECT country, COUNT(*) AS scores_above_50
FROM scores
WHERE score > 50
GROUP BY country;
```

output:

```
+---------+-----------------+
| country | scores_above_50 |
+---------+-----------------+
| USA     |               1 |
| CANADA  |               3 |
| GERMANY |               1 |
+---------+-----------------+
3 rows in set (0.000 sec)
```

**12.1 Count how many scores are greater than 50 per country and make sure the number of scores are greater than 2 (per country).**

```sql
SELECT country, COUNT(*) AS scores_above_50
FROM scores
WHERE score > 50
GROUP BY country
HAVING scores_above_50 > 2;
```

output:

```
+---------+-----------------+
| country | scores_above_50 |
+---------+-----------------+
| CANADA  |               3 |
+---------+-----------------+
1 row in set (0.001 sec)
```


**13. Find the country with the maximum average score**

```sql
SELECT country, AVG(score) AS avg_score
FROM scores
GROUP BY country
ORDER BY avg_score DESC
LIMIT 1;
```

output:

```
+---------+-----------+
| country | avg_score |
+---------+-----------+
| CANADA  |   51.6667 |
+---------+-----------+
1 row in set (0.001 sec)
```


**14. Compare RED vs BLUE average scores per country**

```sql
SELECT country, team, AVG(score) AS avg_score
FROM scores
GROUP BY country, team;
```

output:

```
+---------+------+-----------+
| country | team | avg_score |
+---------+------+-----------+
| USA     | RED  |   20.0000 |
| USA     | BLUE |   43.3333 |
| CANADA  | RED  |   56.6667 |
| CANADA  | BLUE |   46.6667 |
| GERMANY | RED  |   30.0000 |
| GERMANY | BLUE |   50.0000 |
+---------+------+-----------+
6 rows in set (0.001 sec)
```


**15. Compare RED vs BLUE average scores (ROUNDED) per country**

```sql
SELECT country, team, ROUND(AVG(score)) AS avg_score
FROM scores
GROUP BY country, team;
```

output:

```
+---------+------+-----------+
| country | team | avg_score |
+---------+------+-----------+
| USA     | RED  |        20 |
| USA     | BLUE |        43 |
| CANADA  | RED  |        57 |
| CANADA  | BLUE |        47 |
| GERMANY | RED  |        30 |
| GERMANY | BLUE |        50 |
+---------+------+-----------+
6 rows in set (0.001 sec)
```

**16. Compare RED vs BLUE average scores (ROUNDED) per country and list all scores per country and team**

```sql
SELECT country, 
       team, 
       ROUND(AVG(score)) AS avg_score,
       GROUP_CONCAT(score) AS list_of_scores
FROM scores
GROUP BY country, 
         team;
```

output:

```
+---------+------+-----------+----------------+
| country | team | avg_score | list_of_scores |
+---------+------+-----------+----------------+
| CANADA  | BLUE |        47 | 10,40,90       |
| CANADA  | RED  |        57 | 30,60,80       |
| GERMANY | BLUE |        50 | 30,70          |
| GERMANY | RED  |        30 | 20,40          |
| USA     | BLUE |        43 | 20,40,70       |
| USA     | RED  |        20 | 10,20,30       |
+---------+------+-----------+----------------+
6 rows in set (0.001 sec)
```


---

## 7. Advanced Queries using WITH + Ranking Functions

**1. Find the highest score per country (using ROW_NUMBER)**

```sql
WITH ranked AS 
(
  SELECT country, team, score,
         ROW_NUMBER() OVER (PARTITION BY country 
                            ORDER BY score DESC) AS row_num
  FROM scores
)
SELECT * 
FROM ranked 
WHERE row_num = 1;
```

output:

```
+---------+------+-------+---------+
| country | team | score | row_num |
+---------+------+-------+---------+
| CANADA  | BLUE |    90 |       1 |
| GERMANY | BLUE |    70 |       1 |
| USA     | BLUE |    70 |       1 |
+---------+------+-------+---------+
3 rows in set (0.001 sec)
```


**2. Find the top 2 scores per country**

```sql
WITH ranked AS 
(
  SELECT country, score,
         RANK() OVER (PARTITION BY country
                      ORDER BY score DESC) AS rnk
  FROM scores
)
SELECT * 
FROM ranked 
WHERE rnk <= 2;
```

output:

```
+---------+-------+-----+
| country | score | rnk |
+---------+-------+-----+
| CANADA  |    90 |   1 |
| CANADA  |    80 |   2 |
| GERMANY |    70 |   1 |
| GERMANY |    40 |   2 |
| USA     |    70 |   1 |
| USA     |    40 |   2 |
+---------+-------+-----+
6 rows in set (0.001 sec)
```

**3. Compare RED vs BLUE average per country with ranking**

```sql
WITH avg_scores AS 
(
  SELECT country, team, AVG(score) AS avg_score
  FROM scores
  GROUP BY country, team
)
SELECT country, team, avg_score,
       RANK() OVER (PARTITION BY country 
                    ORDER BY avg_score DESC) AS rnk
FROM avg_scores;
```

output:

```
+---------+------+-----------+-----+
| country | team | avg_score | rnk |
+---------+------+-----------+-----+
| CANADA  | RED  |   56.6667 |   1 |
| CANADA  | BLUE |   46.6667 |   2 |
| GERMANY | BLUE |   50.0000 |   1 |
| GERMANY | RED  |   30.0000 |   2 |
| USA     | BLUE |   43.3333 |   1 |
| USA     | RED  |   20.0000 |   2 |
+---------+------+-----------+-----+
6 rows in set (0.001 sec)
```


**4. Rank countries by their total scores**
```sql
WITH totals AS 
(
  SELECT country, SUM(score) AS total_score
  FROM scores
  GROUP BY country
)
SELECT country, total_score,
       DENSE_RANK() OVER (ORDER BY total_score DESC) 
         AS country_rank
FROM totals;
```

output:

```
+---------+-------------+--------------+
| country | total_score | country_rank |
+---------+-------------+--------------+
| CANADA  |         310 |            1 |
| USA     |         190 |            2 |
| GERMANY |         160 |            3 |
+---------+-------------+--------------+
3 rows in set (0.001 sec)
```


**5. Find the best performing team overall**

```sql
WITH team_totals AS (
  SELECT team, SUM(score) AS total_score
  FROM scores
  GROUP BY team
)
SELECT team, total_score,
       RANK() OVER (ORDER BY total_score DESC) 
         AS rank_overall
FROM team_totals;
```

output:

```
+------+-------------+--------------+
| team | total_score | rank_overall |
+------+-------------+--------------+
| BLUE |         370 |            1 |
| RED  |         290 |            2 |
+------+-------------+--------------+
2 rows in set (0.001 sec)
```
---
