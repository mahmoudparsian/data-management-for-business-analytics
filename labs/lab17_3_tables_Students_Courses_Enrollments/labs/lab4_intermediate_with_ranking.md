# Lab-4 – Intermediate: Joins, WITH, Ranking (25 queries)

> Tables: `students`, `courses`, `enrollments`

### 1. INNER JOIN: students + their courses (first 15).
```sql
SELECT s.student_id, s.name, c.course_id, c.course_name
FROM enrollments e
JOIN students s ON e.student_id=s.student_id
JOIN courses c ON e.course_id=c.course_id
LIMIT 15;
```

### 2. LEFT JOIN: all students with any enrolled course (NULL if none).
```sql
SELECT s.student_id, s.name, e.course_id
FROM students s LEFT JOIN enrollments e ON s.student_id=e.student_id
ORDER BY s.student_id LIMIT 20;
```

### 3. RIGHT JOIN: all courses with any student enrolled (NULL if none).
```sql
SELECT c.course_id, c.course_name, e.student_id
FROM enrollments e RIGHT JOIN courses c ON e.course_id=c.course_id
ORDER BY c.course_id LIMIT 20;
```

### 4. Top-3 courses by distinct students per major (ROW_NUMBER).
```sql
WITH course_major AS (
  SELECT s.major, c.course_id, c.course_name, COUNT(DISTINCT s.student_id) AS ds
  FROM students s JOIN enrollments e ON s.student_id=e.student_id
  JOIN courses c ON e.course_id=c.course_id
  GROUP BY s.major, c.course_id, c.course_name
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY major ORDER BY ds DESC) AS rn
  FROM course_major
)
SELECT major, course_id, course_name, ds FROM r WHERE rn<=3 ORDER BY major, ds DESC;
```

### 5. Top-5 students by number of enrollments (CTE).
```sql
WITH counts AS (SELECT student_id, COUNT(*) AS n FROM enrollments GROUP BY student_id)
SELECT s.student_id, s.name, c.n FROM counts c JOIN students s ON c.student_id=s.student_id
ORDER BY c.n DESC LIMIT 5;
```

### 6. Students whose enrollment count > their country average.
```sql
WITH country_avg AS (
  SELECT s.country, AVG(x.n) AS avg_n
  FROM students s JOIN (SELECT student_id, COUNT(*) AS n FROM enrollments GROUP BY student_id) x ON s.student_id=x.student_id
  GROUP BY s.country
), sc AS (
  SELECT s.student_id, s.name, s.country, COUNT(e.course_id) AS n
  FROM students s LEFT JOIN enrollments e ON s.student_id=e.student_id
  GROUP BY s.student_id, s.name, s.country
)
SELECT sc.student_id, sc.name, sc.country, sc.n, country_avg.avg_n
FROM sc JOIN country_avg ON sc.country=country_avg.country
WHERE sc.n > country_avg.avg_n;
```

### 7. Rank countries by total enrollments (DENSE_RANK).
```sql
WITH cnt AS (
  SELECT s.country, COUNT(*) AS n
  FROM students s JOIN enrollments e ON s.student_id=e.student_id
  GROUP BY s.country
)
SELECT country, n, DENSE_RANK() OVER (ORDER BY n DESC) AS rnk
FROM cnt ORDER BY rnk;
```

### 8. Top student per country by total enrollments (RANK).
```sql
WITH per_stu AS (
  SELECT s.country, s.student_id, s.name, COUNT(*) AS n
  FROM students s JOIN enrollments e ON s.student_id=e.student_id
  GROUP BY s.country, s.student_id, s.name
), r AS (
  SELECT *, RANK() OVER (PARTITION BY country ORDER BY n DESC) AS rnk FROM per_stu
)
SELECT * FROM r WHERE rnk=1 ORDER BY country;
```

### 9. Per major, course with highest distinct students (ROW_NUMBER=1).
```sql
WITH a AS (
  SELECT s.major, c.course_id, c.course_name, COUNT(DISTINCT s.student_id) AS ds
  FROM students s JOIN enrollments e ON s.student_id=e.student_id
  JOIN courses c ON e.course_id=c.course_id
  GROUP BY s.major, c.course_id, c.course_name
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY major ORDER BY ds DESC) AS rn FROM a
)
SELECT major, course_id, course_name, ds FROM r WHERE rn=1;
```

### 10. Students with zero enrollments (LEFT anti-join).
```sql
SELECT s.student_id, s.name
FROM students s LEFT JOIN enrollments e ON s.student_id=e.student_id
WHERE e.course_id IS NULL;
```

### 11. Courses with zero enrollments (RIGHT anti-join).
```sql
SELECT c.course_id, c.course_name
FROM enrollments e RIGHT JOIN courses c ON e.course_id=c.course_id
WHERE e.student_id IS NULL;
```

### 12. Most popular subject by country (prefix of course_name).
```sql
WITH cc AS (
  SELECT s.country, SUBSTRING_INDEX(c.course_name,' ',1) AS subj, COUNT(*) AS cnt
  FROM students s JOIN enrollments e ON s.student_id=e.student_id
  JOIN courses c ON e.course_id=c.course_id
  GROUP BY s.country, subj
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY country ORDER BY cnt DESC) AS rn FROM cc
)
SELECT country, subj, cnt FROM r WHERE rn=1;
```

### 13. Running total of enrollments by country (alpha).
```sql
WITH rev AS (
  SELECT s.country AS country, COUNT(*) AS n
  FROM students s JOIN enrollments e ON s.student_id=e.student_id
  GROUP BY s.country
)
SELECT country, n, SUM(n) OVER (ORDER BY country) AS running
FROM rev ORDER BY country;
```

### 14. Top 10 courses by total enrollments.
```sql
SELECT c.course_id, c.course_name, COUNT(*) AS n
FROM courses c JOIN enrollments e ON c.course_id=e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY n DESC LIMIT 10;
```

### 15. Students enrolled in only one subject prefix.
```sql
WITH cats AS (
  SELECT s.student_id, COUNT(DISTINCT SUBSTRING_INDEX(c.course_name,' ',1)) AS k
  FROM students s JOIN enrollments e ON s.student_id=e.student_id
  JOIN courses c ON e.course_id=c.course_id
  GROUP BY s.student_id
)
SELECT s.student_id, s.name FROM cats x JOIN students s ON x.student_id=s.student_id WHERE x.k=1;
```

### 16. Percent contribution of each subject prefix to total enrollments.
```sql
WITH t AS (SELECT COUNT(*) AS total FROM enrollments)
SELECT SUBSTRING_INDEX(c.course_name,' ',1) AS subj,
       ROUND(COUNT(*)*100.0/(SELECT total FROM t),2) AS pct
FROM courses c JOIN enrollments e ON c.course_id=e.course_id
GROUP BY subj ORDER BY pct DESC;
```

### 17. Top 3 students by enrollments in 'Databases' courses.
```sql
WITH b AS (
  SELECT e.student_id, COUNT(*) AS cnt
  FROM enrollments e JOIN courses c ON e.course_id=c.course_id
  WHERE c.course_name LIKE 'Databases%'
  GROUP BY e.student_id
)
SELECT s.student_id, s.name, b.cnt
FROM b JOIN students s ON b.student_id=s.student_id
ORDER BY b.cnt DESC LIMIT 3;
```

### 18. Enrollments above the student's average load (vs global avg).
```sql
WITH la AS (SELECT student_id, COUNT(*) AS n FROM enrollments GROUP BY student_id),
     g AS (SELECT AVG(n) AS gavg FROM la),
     sc AS (SELECT s.student_id, s.name, COUNT(e.course_id) AS n FROM students s LEFT JOIN enrollments e ON s.student_id=e.student_id GROUP BY s.student_id, s.name)
SELECT sc.student_id, sc.name, sc.n, g.gavg FROM sc, g WHERE sc.n > g.gavg ORDER BY sc.n DESC LIMIT 15;
```

### 19. Most enrolled course overall (single row).
```sql
SELECT c.course_id, c.course_name, COUNT(*) AS n
FROM courses c JOIN enrollments e ON c.course_id=e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY n DESC LIMIT 1;
```

### 20. Second most popular course per major (ROW_NUMBER=2).
```sql
WITH freq AS (
  SELECT s.major, c.course_id, c.course_name, COUNT(*) AS cnt
  FROM students s JOIN enrollments e ON s.student_id=e.student_id
  JOIN courses c ON e.course_id=c.course_id
  GROUP BY s.major, c.course_id, c.course_name
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY major ORDER BY cnt DESC) AS rn FROM freq
)
SELECT major, course_id, course_name, cnt FROM r WHERE rn=2;
```

### 21. All courses & whether they were enrolled at least once (RIGHT JOIN).
```sql
SELECT c.course_id, c.course_name,
       CASE WHEN e.course_id IS NULL THEN 'NEVER' ELSE 'ENROLLED' END AS status
FROM enrollments e RIGHT JOIN courses c ON e.course_id=c.course_id
GROUP BY c.course_id, c.course_name, status
ORDER BY c.course_id;
```

### 22. All students & number of distinct courses (LEFT JOIN).
```sql
SELECT s.student_id, s.name, COUNT(DISTINCT e.course_id) AS dc
FROM students s LEFT JOIN enrollments e ON s.student_id=e.student_id
GROUP BY s.student_id, s.name
ORDER BY dc DESC, s.student_id ASC;
```

