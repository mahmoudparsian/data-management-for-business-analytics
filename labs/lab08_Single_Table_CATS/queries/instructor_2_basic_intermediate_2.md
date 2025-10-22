# 20 Basic-to-Intermediate Queries (Instructor)

### 1. Count cats per country 

```sql
SELECT country, 
       COUNT(*) 
FROM cats 
GROUP BY country;
```

### 2. Average age of cats per country 

```sql
SELECT country, 
       AVG(age) 
FROM cats 
GROUP BY country;
```

### 3. Maximum tricks per breed 

```sql
SELECT breed, 
       MAX(num_of_tricks) 
FROM cats 
GROUP BY breed;
```

### 4. Minimum age per gender 

```sql
SELECT gender, 
       MIN(age) 
FROM cats 
GROUP BY gender;
```

### 5. Count cats per gender 

```sql
SELECT gender, 
       COUNT(*) 
FROM cats 
GROUP BY gender;
```

### 6. Average number of tricks per gender 

```sql
SELECT gender, 
       AVG(num_of_tricks) 
FROM cats 
GROUP BY gender;
```

### 7. Average age per breed 

```sql
SELECT breed, 
       AVG(age) 
FROM cats 
GROUP BY breed;
```

### 8. Count cats per breed 

```sql
SELECT breed, 
       COUNT(*) 
FROM cats 
GROUP BY breed;
```

### 9. Average tricks per country 

```sql
SELECT country, 
       AVG(num_of_tricks) 
FROM cats 
GROUP BY country;
```

### 10. Total tricks per country 

```sql
SELECT country, 
       SUM(num_of_tricks) 
FROM cats 
GROUP BY country;
```

### 11. Find countries with more than 10 cats 

solution-1:

```sql
WITH counted_cats AS
(
 SELECT country, 
        COUNT(*) AS cnt 
 FROM cats 
 GROUP BY country 
)
SELECT country, cnt
FROM counted_cats
WHERE cnt > 10;
```


solution-2:

```sql
SELECT country, 
       COUNT(*) as cnt
FROM cats 
GROUP BY country 
HAVING cnt > 10;
```

### 12. Find breeds with avg age > 5 

solution-1:

```sql
WITH age_averaged AS
(
  SELECT breed, 
         AVG(age) AS avg_age
  FROM cats 
  GROUP BY breed 
)
SELECT breed, 
       avg_age
FROM age_averaged
WHERE avg_age > 5;
```

solution-2:

```sql
SELECT breed, 
       AVG(age) AS avg_age
FROM cats 
GROUP BY breed 
HAVING avg_age > 5;
```


### 13. Find genders with more than 20 cats 

solution-1:

```sql

WITH gender_counts AS
(
  SELECT gender, 
         COUNT(*) AS cnt
  FROM cats 
  GROUP BY gender 
)
SELECT gender, 
       cnt 
FROM gender_counts 
WHERE cnt > 20;
```

solution-2:

```sql
SELECT gender, 
       COUNT(*) AS cnt
FROM cats 
GROUP BY gender 
HAVING cnt > 20;
```

### 14. Count cats per breed and gender 

```sql
SELECT breed, 
       gender, 
       COUNT(*) 
FROM cats 
GROUP BY breed, 
         gender;
```

### 15. Average tricks per breed and gender 

```sql
SELECT breed, 
       gender, 
       AVG(num_of_tricks) AS avg_num_of_tricks 
FROM cats 
GROUP BY breed, 
         gender;
```

### 16. Average age per country and gender 

```sql
SELECT country, 
       gender, 
       AVG(age) AS avg_age
FROM cats 
GROUP BY country, 
         gender;
```

### 17. Find the maximum tricks per country 

```sql
SELECT country, 
      MAX(num_of_tricks) AS max_num_of_tricks
FROM cats 
GROUP BY country;
```

### 18. Find the minimum age per country 

```sql
SELECT country, 
       MIN(age) AS min_age
FROM cats 
GROUP BY country;
```

### 19. Find breeds with total tricks > 50 

solution-1:

```sql
WITH sum_of_cats_tricks AS
(
  SELECT breed, 
         SUM(num_of_tricks) AS sum_tricks
  FROM cats 
  GROUP BY breed 
)
SELECT breed, 
       sum_tricks
FROM sum_of_cats_tricks 
WHERE sum_tricks > 50;
```

solution-2:

```sql
SELECT breed, 
       SUM(num_of_tricks) AS sum_tricks
FROM cats 
GROUP BY breed 
HAVING sum_tricks > 50;
```


### 20. Find average tricks by gender within each country 

```sql
SELECT country, 
       gender, 
       AVG(num_of_tricks) AS avg_num_of_tricks
FROM cats 
GROUP BY country, 
         gender;
```

