1. Rank breeds by total cats.

```sql
SELECT breed, 
       COUNT(*) AS cnt, 
       RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk 
FROM cats 
GROUP BY breed;
```

2. Top 3 breeds within each country by count.

solution-1:

```sql
WITH ranked AS
(
  SELECT country, 
         breed, 
         COUNT(*) AS cnt,
         DENSE_RANK() OVER (PARTITION BY country ORDER BY COUNT(*) DESC) AS rnk
  FROM cats 
  GROUP BY country, breed
)
SELECT country, breed, cnt, rnk 
FROM ranked
WHERE rnk <= 3 
ORDER BY country, cnt DESC;
```

solution-2:

```sql
SELECT country, breed, cnt, rnk FROM (
  SELECT country, breed, COUNT(*) AS cnt,
         DENSE_RANK() OVER (PARTITION BY country ORDER BY COUNT(*) DESC) AS rnk
  FROM cats GROUP BY country, breed
) t WHERE rnk <= 3 ORDER BY country, cnt DESC;
```

3. Rank countries by average tricks.

```sql
SELECT country, 
       AVG(num_of_tricks) AS avg_tricks,
       RANK() OVER (ORDER BY AVG(num_of_tricks) DESC) AS rnk
FROM cats 
GROUP BY country;
```

4. Row number of each cat within its breed by DOB desc.

```sql
SELECT id, 
       name, 
       breed, 
       date_of_birth,
       ROW_NUMBER() OVER (PARTITION BY breed ORDER BY date_of_birth DESC) AS rn
FROM cats;
```

5. Top/Bottom by DOB per breed (rn=1 oldest vs youngest).

solution-1:

```sql
SELECT breed, name, date_of_birth, rn FROM (
  SELECT breed, name, date_of_birth,
         ROW_NUMBER() OVER (PARTITION BY breed ORDER BY date_of_birth DESC) AS rn
  FROM cats
) x WHERE rn=1;
```

solution-2:

```sql
WITH ranked AS
(
  SELECT breed, name, date_of_birth,
         ROW_NUMBER() OVER (PARTITION BY breed ORDER BY date_of_birth DESC) AS rn
  FROM cats
)
SELECT breed, name, date_of_birth, rn 
FROM ranked
WHERE rn=1;
```

6. Rank genders by avg tricks within each country.

```sql
SELECT country, 
       gender, 
       AVG(num_of_tricks) AS avg_tricks,
       RANK() OVER (PARTITION BY country ORDER BY AVG(num_of_tricks) DESC) AS rnk
FROM cats 
GROUP BY country, gender;
```

7. Top 10 cats by tricks (wrap rank).

solution-1:

```sql
SELECT * FROM (
  SELECT id, name, num_of_tricks, age,
         RANK() OVER (ORDER BY num_of_tricks DESC, age ASC) AS rnk
  FROM cats WHERE num_of_tricks > 0
) t WHERE rnk <= 10;
```

solution-2:

```sql
WITH ranked AS
(  
  SELECT id, name, num_of_tricks, age,
         RANK() OVER (ORDER BY num_of_tricks DESC, age ASC) AS rnk
  FROM cats 
  WHERE num_of_tricks > 0
)

SELECT * 
FROM ranked
WHERE rnk <= 10;
```

8. Cumulative count of cats by ascending id.

```sql
SELECT id, 
       SUM(1) OVER (ORDER BY id) AS running_total 
FROM cats 
ORDER BY id;
```

Explanation: Step by step:

	1.	SELECT id
	•	You’re selecting the id column from the cats table.
	
	2.	SUM(1) OVER (ORDER BY id)
	•	SUM(1) means: add 1 for every row.

	The OVER (ORDER BY id) makes this a window function: 
	it calculates a cumulative sum in the order of id.

	So for the first row (lowest id), the running total is 1.
	For the second row, it’s 2, and so on.
	
	Essentially this creates a row counter but implemented 
	using a window aggregate.
	
Why not just use ROW_NUMBER()?

```sql
SELECT id,
       ROW_NUMBER() OVER (ORDER BY id) AS row_num
FROM cats
ORDER BY id;
```

9. Rank ages by popularity.

```sql
SELECT age, 
       COUNT(*) AS cnt, 
       RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk 
FROM cats 
GROUP BY age;
```

10. Within each breed, rank countries by average age.

```sql
SELECT breed, 
       country, 
       AVG(age) AS avg_age,
       RANK() OVER (PARTITION BY breed ORDER BY AVG(age) DESC) AS rnk
FROM cats 
GROUP BY breed, country;
```

11. Rank countries by proportion of females.

```sql
SELECT country, 
       SUM(gender='FEMALE')/COUNT(*) AS female_ratio,
       RANK() OVER (ORDER BY SUM(gender='FEMALE')/COUNT(*) DESC) AS rnk
FROM cats 
GROUP BY country;
```

12. Per country, top breed by avg tricks.

solution-1:

```sql
SELECT country, breed, avg_tricks FROM (
  SELECT country, breed, AVG(num_of_tricks) AS avg_tricks,
         RANK() OVER (PARTITION BY country ORDER BY AVG(num_of_tricks) DESC) AS rnk
  FROM cats GROUP BY country, breed
) t WHERE rnk=1;
```

solution-2:

```sql
WITH ranked as 
(
  SELECT country, 
         breed, 
         AVG(num_of_tricks) AS avg_tricks,
         RANK() OVER (PARTITION BY country ORDER BY AVG(num_of_tricks) DESC) AS rnk
  FROM cats 
  GROUP BY country, breed
)
SELECT country, breed, avg_tricks 
FROM ranked
WHERE rnk=1;
```

13. Rank breeds by avg age (descending).

```sql
SELECT breed, 
       AVG(age) AS avg_age,
       RANK() OVER (ORDER BY AVG(age) DESC) AS rnk
FROM cats 
GROUP BY breed;
```

14. Top 5 names by frequency.

```sql
SELECT name, 
       COUNT(*) AS cnt 
FROM cats 
GROUP BY name 
ORDER BY cnt DESC, name 
LIMIT 5;
```

15. Within each breed, dense rank by tricks.

```sql
SELECT id, 
       name, 
       breed, 
       num_of_tricks,
       DENSE_RANK() OVER (PARTITION BY breed ORDER BY num_of_tricks DESC) AS rnk
FROM cats;
```

16. Rank countries by number of breeds present.

```sql
SELECT country, 
       COUNT(DISTINCT breed) AS breed_count,
       RANK() OVER (ORDER BY COUNT(DISTINCT breed) DESC) AS rnk
FROM cats 
GROUP BY country;
```

17. Top 3 youngest cats per country.

solution-1:

```sql
SELECT country, id, name, age, rn FROM (
  SELECT country, id, name, age,
         ROW_NUMBER() OVER (PARTITION BY country ORDER BY age ASC, id ASC) AS rn
  FROM cats
) t WHERE rn <= 3;
```

solution-2:

```sql
WITH ranked AS
(
  SELECT country, 
         id, 
         name, 
         age,
         ROW_NUMBER() OVER (PARTITION BY country ORDER BY age ASC, id ASC) AS rn
  FROM cats
)
SELECT country, id, name, age, rn 
FROM ranked
WHERE rn <= 3;
```


18. Rank breeds by average birth year.

```sql
SELECT breed, 
       AVG(YEAR(date_of_birth)) AS avg_year,
       RANK() OVER (ORDER BY AVG(YEAR(date_of_birth)) DESC) AS rnk
FROM cats 
GROUP BY breed;
```

19. Within each country, rank genders by count.

```sql
SELECT country, 
       gender, 
       COUNT(*) AS cnt,
       RANK() OVER (PARTITION BY country ORDER BY COUNT(*) DESC) AS rnk
FROM cats 
GROUP BY country, gender;
```

20. Rank breeds by USA share (CTE).

```sql
WITH totals AS 
(
 SELECT COUNT(*) AS t 
 FROM cats 
 WHERE country='USA'
),
by_breed AS 
(
 SELECT breed, 
        SUM(country='USA') AS usa_cnt 
        FROM cats 
        GROUP BY breed
)
SELECT breed, 
       usa_cnt/(SELECT t FROM totals) AS usa_share,
       RANK() OVER (ORDER BY usa_cnt/(SELECT t FROM totals) DESC) AS rnk
FROM by_breed;
```

output:

```
+----------------------+-----------+-----+
| breed                | usa_share | rnk |
+----------------------+-----------+-----+
| Bengal               |    0.1860 |   1 |
| Maine Coon           |    0.1163 |   2 |
| Ragdoll              |    0.1163 |   2 |
| British Shorthair    |    0.0930 |   4 |
| Persian              |    0.0930 |   4 |
| Russian Blue         |    0.0698 |   6 |
| Scottish Fold        |    0.0698 |   6 |
| Siamese              |    0.0698 |   6 |
| Sphynx               |    0.0698 |   6 |
| Exotic Shorthair     |    0.0465 |  10 |
| Oriental Shorthair   |    0.0465 |  10 |
| Turkish Angora       |    0.0233 |  12 |
| Abyssinian           |    0.0000 |  13 |
| American Shorthair   |    0.0000 |  13 |
| Norwegian Forest Cat |    0.0000 |  13 |
+----------------------+-----------+-----+
15 rows in set (0.00 sec)
```

