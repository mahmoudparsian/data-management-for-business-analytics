1. Cats with zero tricks (CTE).

solution-1:

```sql
SELECT * 
FROM cats 
WHERE num_of_tricks=0;
```

solution-2:

```sql
WITH z AS 
(
 SELECT * 
 FROM cats 
 WHERE num_of_tricks=0
) 
SELECT * 
FROM z;
```

2. Breeds never seen in GERMANY (CTE + anti-join).

```sql
WITH g AS 
(
  SELECT DISTINCT breed 
  FROM cats 
  WHERE country='GERMANY'
)
SELECT b.breed 
FROM breeds b 
LEFT JOIN g ON b.breed=g.breed 
WHERE g.breed IS NULL;
```

3. Top breed per country by count (CTE + rank).

```sql
WITH cnts AS 
(
  SELECT country, breed, COUNT(*) AS cnt 
  FROM cats 
  GROUP BY country, breed
)
SELECT country, breed, cnt FROM 
(
  SELECT cnts.*, 
         RANK() OVER (PARTITION BY country ORDER BY cnt DESC) AS rnk 
  FROM cnts
) t WHERE rnk=1;
```

4. Countries where avg tricks exceeds global avg.

```sql
WITH g AS 
(
  SELECT AVG(num_of_tricks) AS gavg 
  FROM cats
)
SELECT country, 
       AVG(num_of_tricks) AS avg_tricks 
FROM cats 
GROUP BY country 
HAVING avg_tricks > (SELECT gavg FROM g);
```

output:

```
+---------+------------+
| country | avg_tricks |
+---------+------------+
| USA     |     5.3488 |
| CHINA   |     5.7273 |
| FRANCE  |     5.4091 |
| GERMANY |     5.7692 |
+---------+------------+
4 rows in set (0.00 sec)
```

5. For each breed, top 2 cats by tricks.

```sql
WITH r AS (
  SELECT id, name, breed, num_of_tricks,
         ROW_NUMBER() OVER (PARTITION BY breed ORDER BY num_of_tricks DESC, id ASC) AS rn
  FROM cats
)
SELECT * 
FROM r 
WHERE rn <= 2;
```

6. Most common breed per gender.

```sql
WITH g AS 
(
  SELECT gender, breed, COUNT(*) AS cnt 
  FROM cats 
  GROUP BY gender, breed
)
SELECT gender, breed, cnt FROM (
  SELECT g.*, 
         RANK() OVER (PARTITION BY gender ORDER BY cnt DESC) AS rnk 
  FROM g
) t WHERE rnk=1;
```

7. Breeds with avg age above overall avg.

```sql
WITH a AS 
(
  SELECT AVG(age) AS overall 
  FROM cats
),
b AS 
(
  SELECT breed, AVG(age) AS avg_age 
  FROM cats 
  GROUP BY breed
)
SELECT breed, avg_age  
FROM b 
WHERE avg_age > (SELECT overall FROM a);
```

8. Per breed, month with most births.

```sql
WITH m AS 
(
  SELECT breed, 
         DATE_FORMAT(date_of_birth,'%Y-%m') AS ym, 
         COUNT(*) AS cnt 
  FROM cats 
  GROUP BY breed, DATE_FORMAT(date_of_birth,'%Y-%m')
)
SELECT breed, ym, cnt FROM (
  SELECT m.*, 
         RANK() OVER (PARTITION BY breed ORDER BY cnt DESC) AS rnk 
  FROM m
) t WHERE rnk=1;
```

9. Countries with at least 60% females.

```sql
WITH c AS 
(
  SELECT country, 
         SUM(gender='FEMALE') AS f, 
         COUNT(*) AS total 
  FROM cats 
  GROUP BY country
)
SELECT country 
FROM c 
WHERE f/total >= 0.60;
```

10. Top 5 most frequent names (CTE).

```sql
WITH n AS 
(
  SELECT name, COUNT(*) AS cnt 
  FROM cats 
  GROUP BY name
)
SELECT name, cnt 
FROM n 
ORDER BY cnt DESC, name 
LIMIT 5;
```

11. Breeds present in at least 4 countries.

```sql
WITH b AS 
(
  SELECT breed, 
         COUNT(DISTINCT country) AS count_per_breed
  FROM cats 
  GROUP BY breed
)
SELECT breed 
FROM b 
WHERE count_per_breed >= 4;
```

12. Country with highest average age (CTE + rank).

```sql
WITH a AS 
(
  SELECT country, 
         AVG(age) AS avg_age 
  FROM cats 
  GROUP BY country
)
, ranked AS
(
  SELECT a.*, 
         RANK() OVER (ORDER BY avg_age DESC) AS rnk 
  FROM a
)
SELECT country, avg_age, rnk
FROM ranked
WHERE rnk=1;
```

output:

```
+---------+---------+-----+
| country | avg_age | rnk |
+---------+---------+-----+
| CANADA  |  6.3500 |   1 |
+---------+---------+-----+
1 row in set (0.00 sec)
```


13. USA: top 3 breeds by avg tricks.

```sql
WITH u AS 
(
  SELECT breed, 
         AVG(num_of_tricks) AS avg_tricks 
  FROM cats 
  WHERE country='USA' 
  GROUP BY breed
)
, ranked AS
(  
  SELECT u.*, 
         RANK() OVER (ORDER BY avg_tricks DESC) AS rnk 
  FROM u
)
SELECT breed, avg_tricks, rnk
FROM ranked
WHERE rnk <= 3;
```

output:

+---------------+------------+-----+
| breed         | avg_tricks | rnk |
+---------------+------------+-----+
| Russian Blue  |     9.0000 |   1 |
| Persian       |     6.5000 |   2 |
| Scottish Fold |     6.0000 |   3 |
+---------------+------------+-----+
3 rows in set (0.00 sec)

14. Cats whose age > breed's avg age.

```sql
WITH b AS (SELECT breed, AVG(age) AS avg_age FROM cats GROUP BY breed)
SELECT c.* FROM cats c JOIN b ON c.breed=b.breed WHERE c.age > b.avg_age;
```

15. Countries with youngest average age (rank=1).

```sql
WITH a AS (SELECT country, AVG(age) AS avg_age FROM cats GROUP BY country),
r AS (SELECT country, avg_age, RANK() OVER (ORDER BY avg_age ASC) AS rnk FROM a)
SELECT country, avg_age FROM r WHERE rnk=1;
```

16. Per breed, USA ratio.

```sql
WITH u AS (SELECT breed, SUM(country='USA') AS usa_cnt, COUNT(*) AS total FROM cats GROUP BY breed)
SELECT breed, usa_cnt/total AS usa_ratio FROM u ORDER BY usa_ratio DESC;
```

17. Countries where most common breed is 'Persian'.

```sql
WITH b AS (SELECT country, breed, COUNT(*) AS cnt FROM cats GROUP BY country, breed)
SELECT country FROM (
  SELECT country, breed, cnt, RANK() OVER (PARTITION BY country ORDER BY cnt DESC) AS rnk FROM b
) t WHERE rnk=1 AND breed='Persian';
```

18. Within each country, dense rank breeds by count.

```sql
WITH c AS (SELECT country, breed, COUNT(*) AS cnt FROM cats GROUP BY country, breed)
SELECT country, breed, cnt, DENSE_RANK() OVER (PARTITION BY country ORDER BY cnt DESC) AS rnk FROM c;
```

19. Top 5 (country, breed) by avg age.

```sql
WITH a AS (SELECT country, breed, AVG(age) AS avg_age FROM cats GROUP BY country, breed)
SELECT country, breed, avg_age FROM a ORDER BY avg_age DESC LIMIT 5;
```

20. Outliers: tricks >= 2 stddev above mean.

```sql
WITH stats AS (SELECT AVG(num_of_tricks) AS mu, STD(num_of_tricks) AS sigma FROM cats)
SELECT * FROM cats WHERE num_of_tricks >= (SELECT mu + 2*sigma FROM stats);
```

