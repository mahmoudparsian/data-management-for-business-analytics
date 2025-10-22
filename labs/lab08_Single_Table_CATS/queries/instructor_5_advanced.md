# 20 Advanced Queries (Instructor)

**1. Find the top 3 oldest cats using ROW_NUMBER.**

```sql
WITH ranked AS (
    SELECT id, name, age, ROW_NUMBER() OVER (ORDER BY age DESC) as rnk
    FROM cats
 )
 SELECT * FROM ranked WHERE rnk <= 3;
```

**2. Find youngest 3 cats using ROW_NUMBER.**

```sql
WITH ranked AS (
    SELECT id, name, age, ROW_NUMBER() OVER (ORDER BY age ASC) as rnk
    FROM cats
 )
 SELECT * FROM ranked WHERE rnk <= 3;
```

**3. Rank countries by total number of cats.**

```sql
SELECT country, COUNT(*) as cnt,
        RANK() OVER (ORDER BY COUNT(*) DESC) as rnk
 FROM cats
 GROUP BY country;
```

**4. Find average age per breed and rank breeds.**

```sql
SELECT breed, AVG(age) as avg_age,
        DENSE_RANK() OVER (ORDER BY AVG(age) DESC) as rnk
 FROM cats
 GROUP BY breed;
```

**5. Find cats with salary-like metric: top tricks earners per breed.**

```sql
WITH breed_tricks AS (
    SELECT id, name, breed, num_of_tricks,
           RANK() OVER (PARTITION BY breed ORDER BY num_of_tricks DESC) as rnk
    FROM cats
 )
 SELECT * FROM breed_tricks WHERE rnk=1;
```

**6. Find breed with most cats using CTE.**

```sql
WITH breed_count AS (
    SELECT breed, COUNT(*) as cnt FROM cats GROUP BY breed
 )
 SELECT * FROM breed_count ORDER BY cnt DESC LIMIT 1;
```

**7. Find average tricks per gender per country with CTE.**

```sql
WITH stats AS (
    SELECT country, gender, AVG(num_of_tricks) as avg_tricks
    FROM cats
    GROUP BY country, gender
 )
 SELECT * FROM stats;
```

**8. Find countries with average age greater than global average.**

```sql
WITH global_avg AS (SELECT AVG(age) as gavg FROM cats),
      country_avg AS (SELECT country, AVG(age) as cavg FROM cats GROUP BY country)
 SELECT country, cavg FROM country_avg, global_avg WHERE cavg > gavg;
```

**9. Find breeds that appear in more than one country using CTE.**

```sql
WITH breed_country AS (
    SELECT breed, COUNT(DISTINCT country) as ccount FROM cats GROUP BY breed
 )
 SELECT * FROM breed_country WHERE ccount>1;
```

**10. Find the oldest cat per country using ROW_NUMBER.**

```sql
WITH ranked AS (
    SELECT country, name, age,
           ROW_NUMBER() OVER (PARTITION BY country ORDER BY age DESC) as rnk
    FROM cats
 )
 SELECT * FROM ranked WHERE rnk=1;
```

**11. Find the youngest cat per country using ROW_NUMBER.**

```sql
WITH ranked AS (
    SELECT country, name, age,
           ROW_NUMBER() OVER (PARTITION BY country ORDER BY age ASC) as rnk
    FROM cats
 )
 SELECT * FROM ranked WHERE rnk=1;
```

**12. List breeds ordered by total tricks with rank.**

```sql
SELECT breed, SUM(num_of_tricks) as total_tricks,
        RANK() OVER (ORDER BY SUM(num_of_tricks) DESC) as rnk
 FROM cats
 GROUP BY breed;
```

**13. Find top 2 genders in terms of average tricks.**

```sql
WITH gender_avg AS (
    SELECT gender, AVG(num_of_tricks) as avg_tricks FROM cats GROUP BY gender
 )
 SELECT gender, avg_tricks FROM gender_avg
 ORDER BY avg_tricks DESC LIMIT 2;
```

**14. Find breeds where average tricks > overall average tricks.**

```sql
WITH overall AS (SELECT AVG(num_of_tricks) as oavg FROM cats),
      breed_avg AS (SELECT breed, AVG(num_of_tricks) as bavg FROM cats GROUP BY breed)
 SELECT breed, bavg FROM breed_avg, overall WHERE bavg > oavg;
```

**15. Rank cats within each breed by age.**

```sql
SELECT breed, name, age,
        RANK() OVER (PARTITION BY breed ORDER BY age DESC) as rnk
 FROM cats;
```

**16. Find countries ranked by average cat age.**

```sql
SELECT country, AVG(age) as avg_age,
        RANK() OVER (ORDER BY AVG(age) DESC) as rnk
 FROM cats
 GROUP BY country;
```

**17. Find the oldest and youngest cat per breed with CTE.**

```sql
WITH extremes AS (
    SELECT breed, MAX(age) as oldest, MIN(age) as youngest FROM cats GROUP BY breed
 )
 SELECT * FROM extremes;
```

**18. Find top 5 cats by tricks globally.**

```sql
SELECT id, name, num_of_tricks,
        RANK() OVER (ORDER BY num_of_tricks DESC) as rnk
 FROM cats
 LIMIT 5;
```

**19. Find breeds with cats across at least 3 countries.**

```sql
WITH breed_country AS (
    SELECT breed, COUNT(DISTINCT country) as ccount FROM cats GROUP BY breed
 )
 SELECT * FROM breed_country WHERE ccount >= 3;
```

**20. Find the country with the highest average tricks.**

```sql
WITH country_avg AS (
    SELECT country, AVG(num_of_tricks) as avg_tricks FROM cats GROUP BY country
 )
 SELECT * FROM country_avg ORDER BY avg_tricks DESC LIMIT 1;
```

