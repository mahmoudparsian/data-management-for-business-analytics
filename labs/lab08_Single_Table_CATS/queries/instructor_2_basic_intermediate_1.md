1. Count cats per country.

```sql
SELECT country, COUNT(*) AS cnt 
FROM cats 
GROUP BY country 
ORDER BY cnt DESC;
```

2. Count cats per breed.

```sql
SELECT breed, COUNT(*) AS cnt 
FROM cats 
GROUP BY breed 
ORDER BY cnt DESC;
```

3. Count cats by gender.

```sql
SELECT gender, COUNT(*) AS cnt 
FROM cats 
GROUP BY gender;
```

4. Average tricks by breed.

```sql
SELECT breed, AVG(num_of_tricks) AS avg_tricks 
FROM cats 
GROUP BY breed 
ORDER BY avg_tricks DESC;
```

5. Average age by country.

```sql
SELECT country, AVG(age) AS avg_age 
FROM cats 
GROUP BY country 
ORDER BY avg_age DESC;
```

6. Max and min age by breed.

```sql
SELECT breed, 
       MAX(age) AS max_age, 
       MIN(age) AS min_age 
FROM cats 
GROUP BY breed;
```

7. Top 3 breeds by number of cats.

```sql
SELECT breed, COUNT(*) AS cnt 
FROM cats 
GROUP BY breed 
ORDER BY cnt DESC 
LIMIT 3;
```

8. Breeds with at least 4 average tricks.

solution-1:

```sql
SELECT breed, 
       AVG(num_of_tricks) AS avg_tricks 
FROM cats 
GROUP BY breed 
HAVING AVG(num_of_tricks) >= 4;
```

solution-2:

```sql
SELECT breed, 
       AVG(num_of_tricks) AS avg_tricks 
FROM cats 
GROUP BY breed 
HAVING avg_tricks >= 4;
```

9. Countries with fewer than 21 cats.

solution-1:

```sql
SELECT country, 
       COUNT(*) AS cnt 
FROM cats 
GROUP BY country 
HAVING COUNT(*) < 21;
```

solution-2:

```sql
SELECT country, 
       COUNT(*) AS cnt 
FROM cats 
GROUP BY country 
HAVING cnt < 21;
```

10. Total cats and total tricks overall.

```sql
SELECT COUNT(*) AS cats_total, 
       SUM(num_of_tricks) AS tricks_total 
FROM cats;
```

11. Share of each gender overall.

```sql
SELECT gender, 
       COUNT(*)/(SELECT COUNT(*) FROM cats) AS share 
FROM cats 
GROUP BY gender;
```

12. Count of cats per (country, gender).

```sql
SELECT country, 
       gender, 
       COUNT(*) AS cnt 
FROM cats 
GROUP BY country, gender 
ORDER BY cnt DESC;
```

13. Breeds seen in more than 3 countries.

```sql
SELECT breed 
FROM cats 
GROUP BY breed 
HAVING COUNT(DISTINCT country) > 3;
```


14. Average age per birth year.

solution-1:

```sql
SELECT YEAR(date_of_birth) AS y, 
       AVG(age) AS avg_age 
FROM cats 
GROUP BY YEAR(date_of_birth) 
ORDER BY y;
```
solution-2:

```sql
SELECT YEAR(date_of_birth) AS y, 
       AVG(age) AS avg_age 
FROM cats 
GROUP BY y 
ORDER BY y;
```

15. Cats per age, descending count.

```sql
SELECT age, COUNT(*) AS cnt 
FROM cats 
GROUP BY age 
ORDER BY cnt DESC, age;
```

16. Average tricks by gender in USA.

```sql
SELECT gender, 
       AVG(num_of_tricks) 
FROM cats 
WHERE country = 'USA' 
GROUP BY gender;
```

17. Countries where avg age > 6.

```sql
SELECT country 
FROM cats 
GROUP BY country 
HAVING AVG(age) > 6;
```

18. Top 5 countries by avg tricks.

```sql
SELECT country, 
       AVG(num_of_tricks) AS avg_tricks 
FROM cats 
GROUP BY country 
ORDER BY avg_tricks DESC 
LIMIT 5;
```

19. Join: show breed descriptions for 10 cats.

```sql
SELECT c.name, 
       c.breed, 
       b.description 
FROM cats c 
JOIN breeds b ON c.breed = b.breed 
LIMIT 10;
```

20. Name frequency table (top 10).

```sql
SELECT name, 
       COUNT(*) AS cnt 
FROM cats 
GROUP BY name 
ORDER BY cnt DESC, name 
LIMIT 10;
```

