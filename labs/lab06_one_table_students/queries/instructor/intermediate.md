1. Rank languages by count.
```sql
SELECT language, COUNT(*) AS cnt, RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk FROM students GROUP BY language;
```

2. Top 2 languages per country.
```sql
SELECT country, language, cnt FROM (
  SELECT country, language, COUNT(*) AS cnt,
         DENSE_RANK() OVER (PARTITION BY country ORDER BY COUNT(*) DESC) AS rnk
  FROM students GROUP BY country, language
) x WHERE rnk <= 2 ORDER BY country, cnt DESC;
```

3. Countries ranked by avg birth year.
```sql
SELECT country, AVG(YEAR(date_of_birth)) AS avg_birth_year,
       RANK() OVER (ORDER BY AVG(YEAR(date_of_birth)) DESC) AS rnk
FROM students GROUP BY country;
```

4. Top 3 last names per major.
```sql
WITH counts AS (
  SELECT major, last_name, COUNT(*) AS cnt FROM students GROUP BY major, last_name
)
SELECT major, last_name, cnt FROM (
  SELECT *, RANK() OVER (PARTITION BY major ORDER BY cnt DESC, last_name) AS rnk FROM counts
) t WHERE rnk <= 3;
```

5. CS share by country with totals.
```sql
WITH ctry AS (
  SELECT country, SUM(major='Computer Science') AS cs, COUNT(*) AS total FROM students GROUP BY country
)
SELECT country, cs, total, cs/total AS share FROM ctry ORDER BY share DESC;
```

6. Running count by student_id.
```sql
SELECT student_id,
       SUM(1) OVER (ORDER BY student_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_count
FROM students ORDER BY student_id;
```

7. Most common first_name (ties).
```sql
SELECT first_name, cnt FROM (
  SELECT first_name, COUNT(*) AS cnt, RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
  FROM students GROUP BY first_name
) t WHERE rnk=1;
```

8. Countries where ENGLISH is not the top language.
```sql
WITH ctry_lang AS (
  SELECT country, language, COUNT(*) AS cnt FROM students GROUP BY country, language
)
SELECT DISTINCT country FROM (
  SELECT country, language, cnt, RANK() OVER (PARTITION BY country ORDER BY cnt DESC) AS rnk FROM ctry_lang
) t WHERE rnk=1 AND language <> 'ENGLISH';
```

9. Approx median birth year per language.
```sql
WITH yrs AS (
  SELECT language, YEAR(date_of_birth) AS yr,
         ROW_NUMBER() OVER (PARTITION BY language ORDER BY YEAR(date_of_birth)) AS rn,
         COUNT(*) OVER (PARTITION BY language) AS cnt
  FROM students
)
SELECT language, AVG(yr) AS approx_median_year FROM yrs WHERE rn IN (FLOOR((cnt+1)/2), CEIL((cnt+1)/2)) GROUP BY language;
```

10. Most international major (most distinct countries).
```sql
SELECT major, COUNT(DISTINCT country) AS countries FROM students GROUP BY major ORDER BY countries DESC LIMIT 1;
```

11. Rank countries by count within each major.
```sql
SELECT major, country, cnt, RANK() OVER (PARTITION BY major ORDER BY cnt DESC) AS rnk
FROM (SELECT major, country, COUNT(*) AS cnt FROM students GROUP BY major, country) x;
```

12. Top 5 most frequent name pairs.
```sql
SELECT first_name, last_name, COUNT(*) AS cnt FROM students GROUP BY first_name, last_name ORDER BY cnt DESC, first_name, last_name LIMIT 5;
```

13. Country with youngest average population.
```sql
SELECT country FROM students GROUP BY country ORDER BY AVG(date_of_birth) DESC LIMIT 1;
```

14. Percent of females per country.
```sql
SELECT country, SUM(gender='FEMALE')/COUNT(*) AS female_pct FROM students GROUP BY country ORDER BY female_pct DESC;
```

15. Language proportions within USA.
```sql
WITH us AS (SELECT language, COUNT(*) AS cnt FROM students WHERE country='USA' GROUP BY language),
total AS (SELECT COUNT(*) AS t FROM students WHERE country='USA')
SELECT language, cnt/(SELECT t FROM total) AS share FROM us ORDER BY share DESC;
```

16. Top major per birth decade.
```sql
WITH dec_major AS (
  SELECT CASE WHEN YEAR(date_of_birth) BETWEEN 1980 AND 1989 THEN '1980s'
              WHEN YEAR(date_of_birth) BETWEEN 1990 AND 1999 THEN '1990s'
              ELSE '2000' END AS decade,
         major, COUNT(*) AS cnt
  FROM students GROUP BY decade, major
)
SELECT decade, major, cnt FROM (
  SELECT decade, major, cnt, RANK() OVER (PARTITION BY decade ORDER BY cnt DESC) AS rnk FROM dec_major
) t WHERE rnk=1;
```

17. Countries where >=60% speak ENGLISH.
```sql
SELECT country FROM students GROUP BY country HAVING SUM(language='ENGLISH')/COUNT(*) >= 0.60;
```

18. Majors where USA is not the top country.
```sql
WITH m AS (SELECT major, country, COUNT(*) AS cnt FROM students GROUP BY major, country)
SELECT DISTINCT major FROM (
  SELECT major, country, cnt, RANK() OVER (PARTITION BY major ORDER BY cnt DESC) AS rnk FROM m
) t WHERE rnk=1 AND country <> 'USA';
```

19. Languages where FEMALE ranks #1 by count.
```sql
WITH lg AS (SELECT language, gender, COUNT(*) AS cnt FROM students GROUP BY language, gender)
SELECT language FROM (
  SELECT language, gender, cnt, RANK() OVER (PARTITION BY language ORDER BY cnt DESC) AS rnk FROM lg
) t WHERE rnk=1 AND gender='FEMALE';
```

