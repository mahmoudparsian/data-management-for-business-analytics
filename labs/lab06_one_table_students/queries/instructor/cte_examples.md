1. List students with row numbers by student_id order
```sql
WITH ordered AS (
  SELECT student_id, first_name, last_name,
         ROW_NUMBER() OVER (ORDER BY student_id) AS rn
  FROM students
)
SELECT * FROM ordered;
```

2. Top 5 youngest students by DOB using CTE
```sql
WITH ranked AS (
  SELECT *, RANK() OVER (ORDER BY date_of_birth DESC) AS rnk
  FROM students
)
SELECT * FROM ranked WHERE rnk <= 5;
```

3. Rank majors by number of students
```sql
WITH counts AS (
  SELECT major, COUNT(*) AS cnt
  FROM students
  GROUP BY major
)
SELECT major, cnt, RANK() OVER (ORDER BY cnt DESC) AS rnk
FROM counts;
```

4. Top 3 languages overall
```sql
WITH lang_counts AS (
  SELECT language, COUNT(*) AS cnt
  FROM students
  GROUP BY language
)
SELECT language, cnt,
       DENSE_RANK() OVER (ORDER BY cnt DESC) AS rnk
FROM lang_counts
WHERE rnk <= 3;
```

5. Within each country, rank majors by size
```sql
WITH country_major AS (
  SELECT country, major, COUNT(*) AS cnt
  FROM students
  GROUP BY country, major
)
SELECT *, RANK() OVER (PARTITION BY country ORDER BY cnt DESC) AS rnk
FROM country_major;
```

6. Rank countries by average birth year
```sql
WITH ctry AS (
  SELECT country, AVG(YEAR(date_of_birth)) AS avg_year
  FROM students
  GROUP BY country
)
SELECT country, avg_year,
       RANK() OVER (ORDER BY avg_year DESC) AS rnk
FROM ctry;
```

7. Row number within each gender
```sql
WITH gendered AS (
  SELECT gender, first_name, last_name,
         ROW_NUMBER() OVER (PARTITION BY gender ORDER BY student_id) AS rn
  FROM students
)
SELECT * FROM gendered WHERE rn <= 5;
```

8. Rank languages inside USA
```sql
WITH usa_lang AS (
  SELECT language, COUNT(*) AS cnt
  FROM students
  WHERE country='USA'
  GROUP BY language
)
SELECT language, cnt,
       RANK() OVER (ORDER BY cnt DESC) AS rnk
FROM usa_lang;
```

9. CTE to compute per-major share of females
```sql
WITH counts AS (
  SELECT major,
         SUM(gender='FEMALE') AS females,
         COUNT(*) AS total
  FROM students
  GROUP BY major
)
SELECT major, females, total,
       females/total AS female_ratio,
       RANK() OVER (ORDER BY females/total DESC) AS rnk
FROM counts;
```

10. Rank countries by number of distinct languages
```sql
WITH ctry_lang AS (
  SELECT country, COUNT(DISTINCT language) AS distinct_langs
  FROM students
  GROUP BY country
)
SELECT country, distinct_langs,
       RANK() OVER (ORDER BY distinct_langs DESC) AS rnk
FROM ctry_lang;
```

