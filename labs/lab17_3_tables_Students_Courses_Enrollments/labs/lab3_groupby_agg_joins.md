# Lab-3 – Aggregations & Basic Joins (25 queries)

> Tables: `students`, `courses`, `enrollments`

### 1. Students per country.
```sql
SELECT country, COUNT(*) AS cnt FROM students GROUP BY country ORDER BY cnt DESC;
```

### 2. Students per major.
```sql
SELECT major, COUNT(*) AS cnt FROM students GROUP BY major ORDER BY cnt DESC;
```

### 3. Top 5 courses by enrollment count.
```sql
SELECT c.course_id, c.course_name, COUNT(*) AS n
FROM courses c JOIN enrollments e ON c.course_id=e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY n DESC LIMIT 5;
```

### 4. Distinct students per course (top 10).
```sql
SELECT c.course_id, c.course_name, COUNT(DISTINCT e.student_id) AS ds
FROM courses c JOIN enrollments e ON c.course_id=e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY ds DESC LIMIT 10;
```

### 5. Distinct courses per student (top 10).
```sql
SELECT s.student_id, s.name, COUNT(DISTINCT e.course_id) AS dc
FROM students s JOIN enrollments e ON s.student_id=e.student_id
GROUP BY s.student_id, s.name
ORDER BY dc DESC LIMIT 10;
```

### 6. Countries with avg #courses per student > 10.
```sql
WITH cs AS (SELECT student_id, COUNT(*) AS n FROM enrollments GROUP BY student_id)
SELECT st.country, AVG(cs.n) AS avg_courses
FROM students st JOIN cs ON st.student_id=cs.student_id
GROUP BY st.country
HAVING AVG(cs.n) > 10;
```

### 7. Majors with avg #courses per student >= 12.
```sql
WITH cs AS (SELECT student_id, COUNT(*) AS n FROM enrollments GROUP BY student_id)
SELECT st.major, AVG(cs.n) AS avg_courses
FROM students st JOIN cs ON st.student_id=cs.student_id
GROUP BY st.major
HAVING AVG(cs.n) >= 12;
```

### 8. Course popularity by country (counts).
```sql
SELECT st.country, c.course_name, COUNT(*) AS cnt
FROM enrollments e JOIN students st ON e.student_id=st.student_id
JOIN courses c ON e.course_id=c.course_id
GROUP BY st.country, c.course_name
ORDER BY st.country, cnt DESC LIMIT 20;
```

### 9. Most enrolled course overall.
```sql
SELECT c.course_id, c.course_name, COUNT(*) AS n
FROM courses c JOIN enrollments e ON c.course_id=e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY n DESC LIMIT 1;
```

### 10. Students with at least 30 total enrollments.
```sql
SELECT s.student_id, s.name, COUNT(*) AS n
FROM students s JOIN enrollments e ON s.student_id=e.student_id
GROUP BY s.student_id, s.name
HAVING COUNT(*) >= 30
ORDER BY n DESC;
```

### 11. Courses never enrolled (confirm last 5).
```sql
SELECT c.course_id, c.course_name
FROM courses c LEFT JOIN enrollments e ON c.course_id=e.course_id
WHERE e.student_id IS NULL ORDER BY c.course_id DESC;
```

### 12. Students never enrolled (confirm last 4).
```sql
SELECT s.student_id, s.name
FROM students s LEFT JOIN enrollments e ON s.student_id=e.student_id
WHERE e.course_id IS NULL ORDER BY s.student_id DESC;
```

### 13. Top 5 courses by number of countries represented.
```sql
SELECT c.course_id, c.course_name, COUNT(DISTINCT s.country) AS countries
FROM courses c JOIN enrollments e ON c.course_id=e.course_id
JOIN students s ON e.student_id=s.student_id
GROUP BY c.course_id, c.course_name
ORDER BY countries DESC LIMIT 5;
```

### 14. Top 5 majors by total enrollments.
```sql
SELECT s.major, COUNT(*) AS n
FROM students s JOIN enrollments e ON s.student_id=e.student_id
GROUP BY s.major
ORDER BY n DESC LIMIT 5;
```

### 15. Country-subject popularity (prefix of course_name).
```sql
SELECT s.country, SUBSTRING_INDEX(c.course_name,' ',1) AS subj, COUNT(*) AS n
FROM students s JOIN enrollments e ON s.student_id=e.student_id
JOIN courses c ON e.course_id=c.course_id
GROUP BY s.country, subj
ORDER BY s.country, n DESC;
```

### 16. Courses with enrollments from at least 40 distinct students.
```sql
SELECT c.course_id, c.course_name, COUNT(DISTINCT e.student_id) AS ds
FROM courses c JOIN enrollments e ON c.course_id=e.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(DISTINCT e.student_id) >= 40;
```

### 17. Majors with students taking at least 20 distinct courses (count of students).
```sql
WITH dc AS (SELECT student_id, COUNT(DISTINCT course_id) AS k FROM enrollments GROUP BY student_id)
SELECT s.major, COUNT(*) AS num_students
FROM students s JOIN dc ON s.student_id=dc.student_id
WHERE dc.k >= 20
GROUP BY s.major ORDER BY num_students DESC;
```

### 18. Per (country, major): avg distinct courses per student.
```sql
WITH dc AS (SELECT student_id, COUNT(DISTINCT course_id) AS k FROM enrollments GROUP BY student_id)
SELECT s.country, s.major, AVG(dc.k) AS avg_k
FROM students s JOIN dc ON s.student_id=dc.student_id
GROUP BY s.country, s.major
ORDER BY s.country, avg_k DESC;
```

### 19. Most common subject prefix.
```sql
SELECT SUBSTRING_INDEX(course_name,' ',1) AS subj, COUNT(*) AS cnt
FROM courses GROUP BY subj ORDER BY cnt DESC;
```

### 20. Students in both a 'Databases' and an 'AI' course.
```sql
SELECT DISTINCT s.student_id, s.name
FROM students s
JOIN enrollments e1 ON s.student_id=e1.student_id
JOIN courses c1 ON e1.course_id=c1.course_id AND c1.course_name LIKE 'Databases%'
JOIN enrollments e2 ON s.student_id=e2.student_id
JOIN courses c2 ON e2.course_id=c2.course_id AND c2.course_name LIKE 'AI%';
```

### 21. Courses with enrollments from all 6 countries (if any).
```sql
SELECT c.course_id, c.course_name
FROM courses c JOIN enrollments e ON c.course_id=e.course_id
JOIN students s ON e.student_id=s.student_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(DISTINCT s.country)=6;
```

### 22. Country with the most total enrollments.
```sql
SELECT s.country, COUNT(*) AS n
FROM students s JOIN enrollments e ON s.student_id=e.student_id
GROUP BY s.country ORDER BY n DESC LIMIT 1;
```

### 23. Major with the least total enrollments.
```sql
SELECT s.major, COUNT(*) AS n
FROM students s JOIN enrollments e ON s.student_id=e.student_id
GROUP BY s.major ORDER BY n ASC LIMIT 1;
```

### 24. Top 10 students by number of 'Programming' courses.
```sql
SELECT s.student_id, s.name, COUNT(*) AS n
FROM students s JOIN enrollments e ON s.student_id=e.student_id
JOIN courses c ON e.course_id=c.course_id AND c.course_name LIKE 'Programming%'
GROUP BY s.student_id, s.name
ORDER BY n DESC LIMIT 10;
```

