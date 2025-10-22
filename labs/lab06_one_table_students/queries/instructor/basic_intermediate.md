1. Count per country.
```sql
SELECT country, COUNT(*) AS cnt FROM students GROUP BY country ORDER BY cnt DESC;
```

2. Count per language.
```sql
SELECT language, COUNT(*) AS cnt FROM students GROUP BY language ORDER BY cnt DESC;
```

3. Count per major.
```sql
SELECT major, COUNT(*) AS cnt FROM students GROUP BY major ORDER BY cnt DESC;
```

4. Count by gender.
```sql
SELECT gender, COUNT(*) AS cnt FROM students GROUP BY gender;
```

5. Top 3 countries by count.
```sql
SELECT country, COUNT(*) AS cnt FROM students GROUP BY country ORDER BY cnt DESC LIMIT 3;
```

6. Oldest student.
```sql
SELECT * FROM students ORDER BY date_of_birth ASC LIMIT 1;
```

7. Youngest student.
```sql
SELECT * FROM students ORDER BY date_of_birth DESC LIMIT 1;
```

8. Average birth year by country.
```sql
SELECT country, AVG(YEAR(date_of_birth)) AS avg_birth_year FROM students GROUP BY country;
```

9. Count per (country, language).
```sql
SELECT country, language, COUNT(*) AS cnt FROM students GROUP BY country, language ORDER BY cnt DESC;
```

10. Majors with at least 12 students.
```sql
SELECT major, COUNT(*) AS cnt FROM students GROUP BY major HAVING COUNT(*) >= 12;
```

11. Languages with fewer than 10 students.
```sql
SELECT language, COUNT(*) AS cnt FROM students GROUP BY language HAVING COUNT(*) < 10;
```

12. Countries with >=20% CS majors.
```sql
SELECT country FROM students GROUP BY country HAVING SUM(major='Computer Science')/COUNT(*) >= 0.20;
```

13. Most common language per country (ties kept).
```sql
SELECT country, language, cnt FROM (
  SELECT country, language, COUNT(*) AS cnt,
         RANK() OVER (PARTITION BY country ORDER BY COUNT(*) DESC) AS rnk
  FROM students GROUP BY country, language
) t WHERE rnk=1;
```

14. Share of each major overall.
```sql
SELECT major, COUNT(*)/(SELECT COUNT(*) FROM students) AS share FROM students GROUP BY major ORDER BY share DESC;
```

15. Country-language combos with at least 5 students.
```sql
SELECT country, language, COUNT(*) AS cnt FROM students GROUP BY country, language HAVING COUNT(*) >= 5 ORDER BY cnt DESC;
```

16. Middle 10 student_ids (by order).
```sql
SELECT student_id FROM students ORDER BY student_id LIMIT 10 OFFSET 45;
```

17. Email username length > 12 count.
```sql
SELECT COUNT(*) FROM (
  SELECT LEFT(email, LOCATE('@', email)-1) AS user FROM students
) u WHERE CHAR_LENGTH(user) > 12;
```

18. Earliest and latest DOB year per major.
```sql
SELECT major, MIN(YEAR(date_of_birth)) AS min_year, MAX(YEAR(date_of_birth)) AS max_year FROM students GROUP BY major;
```

19. Total students and USA students.
```sql
SELECT (SELECT COUNT(*) FROM students) AS total_students,
       (SELECT COUNT(*) FROM students WHERE country='USA') AS usa_students;
```

20. Count per birth decade.
```sql
SELECT CASE WHEN YEAR(date_of_birth) BETWEEN 1980 AND 1989 THEN '1980s'
            WHEN YEAR(date_of_birth) BETWEEN 1990 AND 1999 THEN '1990s'
            ELSE '2000'
       END AS decade,
       COUNT(*) AS cnt
FROM students GROUP BY decade;
```

