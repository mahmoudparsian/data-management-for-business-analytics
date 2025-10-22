# 20 Intermediate Queries (Instructor)

### 1. Find breed with the maximum average tricks. 

solution-1:

```sql
SELECT breed,
       AVG(num_of_tricks) AS avg_num_of_tricks
FROM cats 
GROUP BY breed 
ORDER BY AVG(num_of_tricks) DESC 
LIMIT 1;
```

solution-2:

```sql
SELECT breed
FROM cats 
GROUP BY breed 
ORDER BY AVG(num_of_tricks) DESC 
LIMIT 1;
```

### 2. Find country with the maximum cats. 

solution-1:

```sql
SELECT country,
       COUNT(*) as cnt
FROM cats 
GROUP BY country 
ORDER BY COUNT(*) DESC LIMIT 1;
```

solution-2:

```sql
SELECT country 
FROM cats 
GROUP BY country 
ORDER BY COUNT(*) DESC LIMIT 1;
```

### 3. Find gender with minimum average age. 

```sql
SELECT gender 
FROM cats 
GROUP BY gender 
ORDER BY AVG(age) ASC 
LIMIT 1;
```

### 4. Rank countries by average tricks. 

```sql
SELECT country, 
       AVG(num_of_tricks) as avg_tricks 
FROM cats 
GROUP BY country 
ORDER BY avg_tricks DESC;
```

### 5. Find breeds with more than 2 distinct countries. 

solution-1:

```sql
SELECT breed, 
       COUNT(DISTINCT country) 
FROM cats 
GROUP BY breed 
HAVING COUNT(DISTINCT country) > 2;
```

solution-2:

```sql
WITH counted_countries AS
(
  SELECT breed, 
         COUNT(DISTINCT country)  AS cnt
  FROM cats 
  GROUP BY breed 
)
SELECT breed, 
       cnt
FROM counted_countries 
WHERE cnt > 2;
```

### 6. Find countries where average age > 7. 

```sql
SELECT country, 
       AVG(age) AS avg_age
FROM cats 
GROUP BY country 
HAVING avg_age > 7;
```

### 7. Find breeds where average tricks between 3 and 6. 

```sql
SELECT breed, 
       AVG(num_of_tricks) AS avg_num_of_tricks
FROM cats 
GROUP BY breed 
HAVING avg_num_of_tricks BETWEEN 3 AND 6;
```

### 8. Find gender with most total tricks. 

```sql
SELECT gender, 
       SUM(num_of_tricks) AS total_num_of_tricks
FROM cats 
GROUP BY gender 
ORDER BY total_num_of_tricks DESC 
LIMIT 1;
```

### 9. Find breeds with at least 5 cats. 

```sql
SELECT breed, 
       COUNT(*) AS cnt
FROM cats 
GROUP BY breed 
HAVING cnt >= 5;
```

### 10. List breeds ordered by total tricks descending. 

```sql
SELECT breed, 
       SUM(num_of_tricks) AS total_num_of_tricks
FROM cats 
GROUP BY breed 
ORDER BY total_num_of_tricks DESC;
```

### 11. Find the oldest cat per country. 

```sql
SELECT country, 
       MAX(age) AS max_age
FROM cats 
GROUP BY country;
```

### 12. Find the youngest cat per country. 

```sql
SELECT country, 
       MIN(age) AS min_age
FROM cats 
GROUP BY country;
```

### 13. Find countries with both male and female cats. 

```sql
SELECT country 
FROM cats 
GROUP BY country 
HAVING COUNT(DISTINCT gender) = 2;
```

output:

```
+---------+
| country |
+---------+
| CANADA  |
| CHINA   |
| FRANCE  |
| GERMANY |
| USA     |
+---------+
5 rows in set (0.00 sec)
```

### 14. Find average tricks per country and gender. 

```sql
SELECT country, 
       gender, 
       AVG(num_of_tricks) as avg_num_of_tricks
FROM cats 
GROUP BY country, 
         gender;
```

### 15. Find breeds with more than 2 male cats. 

```sql
SELECT breed, 
       COUNT(*) as cnt
FROM cats 
WHERE gender = 'MALE' 
GROUP BY breed 
HAVING cnt > 2;
```

### 16. Find average age of cats per breed description. 

```sql
SELECT b.description, 
       AVG(c.age) AS avg_age
FROM cats c 
JOIN breeds b ON c.breed = b.breed 
GROUP BY b.description;
```

### 17. Find the breed description with the maximum cats. 

solution-1:

```sql
SELECT b.description,
       COUNT(*) as cnt 
FROM cats c 
JOIN breeds b ON c.breed = b.breed 
GROUP BY b.description 
ORDER BY cnt DESC 
LIMIT 1;
```

solution-2:

```sql
SELECT b.description 
FROM cats c 
JOIN breeds b ON c.breed = b.breed 
GROUP BY b.description 
ORDER BY COUNT(*) DESC 
LIMIT 1;
```

### 18. Find breed with highest average age. 

```sql
SELECT breed 
FROM cats 
GROUP BY breed 
ORDER BY AVG(age) DESC 
LIMIT 1;
```

### 19. Find country with highest average age. 

```sql
SELECT country 
FROM cats 
GROUP BY country 
ORDER BY AVG(age) DESC 
LIMIT 1;
```

### 20. Find average tricks per breed and country. 

```sql
SELECT breed, 
       country, 
       AVG(num_of_tricks) AS avg_num_of_tricks
FROM cats 
GROUP BY breed, 
         country;
```

