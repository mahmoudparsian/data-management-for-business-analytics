# Lab-5 – Intermediate: WITH & Ranking Advanced (25 queries)

> Tables: `students`, `courses`, `enrollments`

### 1. Top 3 students by enrollments per country (ROW_NUMBER).
```sql
WITH per AS (
  SELECT s.country, s.student_id, s.name, COUNT(*) AS n
  FROM students s JOIN enrollments e ON s.student_id=e.student_id
  GROUP BY s.country, s.student_id, s.name
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY country ORDER BY n DESC) AS rn FROM per
)
SELECT country, student_id, name, n FROM r WHERE rn<=3 ORDER BY country, n DESC;
```

### 2. For each subject prefix, students with > average enrollments in that subject.
```sql
WITH subj AS (
  SELECT SUBSTRING_INDEX(c.course_name,' ',1) AS subj, e.student_id, COUNT(*) AS n
  FROM enrollments e JOIN courses c ON e.course_id=c.course_id
  GROUP BY subj, e.student_id
), avg_s AS (
  SELECT subj, AVG(n) AS avg_n FROM subj GROUP BY subj
)
SELECT s.subj, s.student_id, st.name, s.n, a.avg_n
FROM subj s JOIN avg_s a ON s.subj=a.subj
JOIN students st ON s.student_id=st.student_id
WHERE s.n > a.avg_n;
```

### 3. Most popular course per country (by enrollment count).
```sql
WITH pc AS (
  SELECT s.country, c.course_id, c.course_name, COUNT(*) AS cnt
  FROM enrollments e JOIN students s ON e.student_id=s.student_id
  JOIN courses c ON e.course_id=c.course_id
  GROUP BY s.country, c.course_id, c.course_name
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY country ORDER BY cnt DESC) AS rn FROM pc
)
SELECT country, course_id, course_name, cnt FROM r WHERE rn=1 ORDER BY country;
```

### 4. Per student: top 5 courses by repeated enrollments.
```sql
WITH r AS (
  SELECT e.student_id, e.course_id, COUNT(*) AS n
  FROM enrollments e
  GROUP BY e.student_id, e.course_id
), rr AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY student_id ORDER BY n DESC) AS rn FROM r
)
SELECT * FROM rr WHERE rn<=5 ORDER BY student_id, rn;
```

### 5. Students with >= 30 enrollments and above global avg.
```sql
WITH s AS (
  SELECT student_id, COUNT(*) AS n FROM enrollments GROUP BY student_id
), g AS (
  SELECT AVG(n) AS gavg FROM s
)
SELECT st.student_id, st.name, s.n
FROM s JOIN g JOIN students st ON s.student_id=st.student_id
WHERE s.n >= 30 AND s.n > g.gavg ORDER BY s.n DESC;
```

### 6. Cumulative enrollments by subject within each country.
```sql
WITH rev AS (
  SELECT s.country, SUBSTRING_INDEX(c.course_name,' ',1) AS subj, COUNT(*) AS n
  FROM enrollments e JOIN students s ON e.student_id=s.student_id
  JOIN courses c ON e.course_id=c.course_id
  GROUP BY s.country, subj
)
SELECT country, subj, n, SUM(n) OVER (PARTITION BY country ORDER BY subj) AS running
FROM rev ORDER BY country, subj;
```

### 7. Subjects whose share > 25% of a country's enrollments.
```sql
WITH rev AS (
  SELECT s.country, SUBSTRING_INDEX(c.course_name,' ',1) AS subj, COUNT(*) AS n
  FROM enrollments e JOIN students s ON e.student_id=s.student_id
  JOIN courses c ON e.course_id=c.course_id
  GROUP BY s.country, subj
), tot AS (
  SELECT country, SUM(n) AS total FROM rev GROUP BY country
)
SELECT r.country, r.subj, ROUND(r.n*100.0/t.total,2) AS pct
FROM rev r JOIN tot t ON r.country=t.country
WHERE r.n*100.0/t.total > 25;
```

### 8. Top 10 students within each major by enrollments (DENSE_RANK).
```sql
WITH per AS (
  SELECT s.major, s.student_id, s.name, COUNT(*) AS n
  FROM students s JOIN enrollments e ON s.student_id=e.student_id
  GROUP BY s.major, s.student_id, s.name
), r AS (
  SELECT *, DENSE_RANK() OVER (PARTITION BY major ORDER BY n DESC) AS rnk FROM per
)
SELECT major, student_id, name, n FROM r WHERE rnk<=10 ORDER BY major, n DESC;
```

### 9. Students enrolled in exactly two subject prefixes.
```sql
WITH cats AS (
  SELECT s.student_id, COUNT(DISTINCT SUBSTRING_INDEX(c.course_name,' ',1)) AS k
  FROM students s JOIN enrollments e ON s.student_id=e.student_id
  JOIN courses c ON e.course_id=c.course_id
  GROUP BY s.student_id
)
SELECT s.student_id, s.name FROM cats x JOIN students s ON x.student_id=s.student_id WHERE x.k=2;
```

### 10. Global top 1% courses by distinct students.
```sql
WITH r AS (
  SELECT c.course_id, COUNT(DISTINCT e.student_id) AS ds
  FROM courses c LEFT JOIN enrollments e ON c.course_id=e.course_id
  GROUP BY c.course_id
), rr AS (
  SELECT *, ROW_NUMBER() OVER (ORDER BY ds DESC) AS rn, COUNT(*) OVER () AS n FROM r
)
SELECT course_id, ds FROM rr WHERE rn <= CEIL(0.01*n);
```

### 11. Z-score of course distinct-student counts within subject prefix.
```sql
WITH a AS (
  SELECT SUBSTRING_INDEX(c.course_name,' ',1) AS subj, c.course_id, COUNT(DISTINCT e.student_id) AS ds
  FROM courses c LEFT JOIN enrollments e ON c.course_id=e.course_id
  GROUP BY subj, c.course_id
), s AS (
  SELECT subj, AVG(ds) AS a, STDDEV_POP(ds) AS sd FROM a GROUP BY subj
)
SELECT a.subj, a.course_id, (a.ds - s.a)/NULLIF(s.sd,0) AS z
FROM a JOIN s ON a.subj=s.subj;
```

### 12. Students above global average enrollment count.
```sql
WITH s AS (
  SELECT student_id, COUNT(*) AS n FROM enrollments GROUP BY student_id
), g AS (
  SELECT AVG(n) AS gavg FROM s
)
SELECT st.student_id, st.name, s.n
FROM s JOIN g JOIN students st ON s.student_id=st.student_id
WHERE s.n > g.gavg ORDER BY s.n DESC;
```

### 13. For each course, rank countries by enrollment (top 2 per course).
```sql
WITH pc AS (
  SELECT c.course_id, s.country, COUNT(*) AS n
  FROM enrollments e JOIN students s ON e.student_id=s.student_id
  JOIN courses c ON e.course_id=c.course_id
  GROUP BY c.course_id, s.country
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY course_id ORDER BY n DESC) AS rn FROM pc
)
SELECT course_id, country, n FROM r WHERE rn<=2 ORDER BY course_id, n DESC;
```

### 14. For each student, subject prefix that contributes most to their enrollments.
```sql
WITH cc AS (
  SELECT s.student_id, SUBSTRING_INDEX(c.course_name,' ',1) AS subj, COUNT(*) AS n
  FROM students s JOIN enrollments e ON s.student_id=e.student_id
  JOIN courses c ON e.course_id=c.course_id
  GROUP BY s.student_id, subj
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY student_id ORDER BY n DESC) AS rn FROM cc
)
SELECT student_id, subj, n FROM r WHERE rn=1;
```

### 15. Countries where > 10% of enrollments are in 'AI' subjects.
```sql
WITH c AS (
  SELECT s.country, COUNT(*) AS n,
         SUM(CASE WHEN SUBSTRING_INDEX(c.course_name,' ',1)='AI' THEN 1 ELSE 0 END) AS ai
  FROM students s JOIN enrollments e ON s.student_id=e.student_id
  JOIN courses c ON e.course_id=c.course_id
  GROUP BY s.country
)
SELECT country, ai*100.0/n AS pct_ai FROM c WHERE ai*100.0/n > 10;
```

### 16. Student with most enrollments per country.
```sql
WITH b AS (
  SELECT s.country, s.student_id, COUNT(*) AS n
  FROM students s JOIN enrollments e ON s.student_id=e.student_id
  GROUP BY s.country, s.student_id
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY country ORDER BY n DESC) AS rn FROM b
)
SELECT country, student_id, n FROM r WHERE rn=1;
```

### 17. Subject prefixes with at least 3 courses in global top 100 by distinct students.
```sql
WITH pr AS (
  SELECT SUBSTRING_INDEX(c.course_name,' ',1) AS subj, c.course_id, COUNT(DISTINCT e.student_id) AS ds
  FROM courses c LEFT JOIN enrollments e ON c.course_id=e.course_id
  GROUP BY subj, c.course_id
), top100 AS (
  SELECT * FROM (
    SELECT *, ROW_NUMBER() OVER (ORDER BY ds DESC) AS rn FROM pr
  ) x WHERE rn<=100
)
SELECT subj, COUNT(*) AS cnt FROM top100 GROUP BY subj HAVING COUNT(*) >= 3;
```

### 18. Above/below overall average enrollments per student.
```sql
WITH g AS (SELECT AVG(n) AS gavg FROM (SELECT student_id, COUNT(*) AS n FROM enrollments GROUP BY student_id) t),
     a AS (SELECT student_id, COUNT(*) AS n FROM enrollments GROUP BY student_id)
SELECT st.student_id, st.name,
       CASE WHEN a.n > g.gavg THEN 'ABOVE' ELSE 'BELOW' END AS cmp
FROM a JOIN g JOIN students st ON a.student_id=st.student_id;
```

### 19. Most loyal student per subject prefix (highest enroll count).
```sql
WITH cc AS (
  SELECT SUBSTRING_INDEX(c.course_name,' ',1) AS subj, s.student_id, COUNT(*) AS n
  FROM students s JOIN enrollments e ON s.student_id=e.student_id
  JOIN courses c ON e.course_id=c.course_id
  GROUP BY subj, s.student_id
), r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY subj ORDER BY n DESC) AS rn FROM cc
)
SELECT subj, student_id, n FROM r WHERE rn=1;
```

### 20. Top 3 country shares per course (country% of course enrollments).
```sql
WITH pc AS (
  SELECT c.course_id, s.country, COUNT(*) AS n
  FROM enrollments e JOIN students s ON e.student_id=s.student_id
  JOIN courses c ON e.course_id=c.course_id
  GROUP BY c.course_id, s.country
), tot AS (
  SELECT course_id, SUM(n) AS total FROM pc GROUP BY course_id
), share AS (
  SELECT pc.course_id, pc.country, pc.n*100.0/tot.total AS pct
  FROM pc JOIN tot ON pc.course_id=tot.course_id
)
SELECT * FROM (
  SELECT course_id, country, pct,
         ROW_NUMBER() OVER (PARTITION BY course_id ORDER BY pct DESC) AS rn
  FROM share
) x WHERE rn<=3 ORDER BY course_id, pct DESC;
```

