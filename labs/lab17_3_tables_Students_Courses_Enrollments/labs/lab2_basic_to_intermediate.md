# Lab-2 – Basic to Intermediate (25 queries)

> Tables: `students`, `courses`, `enrollments`

### 1. Show student + country with CASE-based region grouping.
```sql
SELECT student_id, name, country,
CASE WHEN country IN ('USA','CANADA','MEXICO') THEN 'NA' ELSE 'INTL' END AS region
FROM students LIMIT 20;
```

### 2. Students from USA or CANADA.
```sql
SELECT student_id, name, country FROM students WHERE country IN ('USA','CANADA');
```

### 3. Courses not taught by an instructor with 'Smith' in name.
```sql
SELECT course_id, course_name FROM courses WHERE instructor NOT LIKE '%Smith%';
```

### 4. Enrollments for a given student_id (12).
```sql
SELECT * FROM enrollments WHERE student_id=12 LIMIT 10;
```

### 5. Enrollments for courses 30..40.
```sql
SELECT * FROM enrollments WHERE course_id BETWEEN 30 AND 40 LIMIT 10;
```

### 6. Count enrollments by student (top 10).
```sql
SELECT student_id, COUNT(*) AS n FROM enrollments GROUP BY student_id ORDER BY n DESC LIMIT 10;
```

### 7. Students per major.
```sql
SELECT major, COUNT(*) AS cnt FROM students GROUP BY major ORDER BY cnt DESC;
```

### 8. Top 5 courses by enrollment.
```sql
SELECT e.course_id, c.course_name, COUNT(*) AS cnt
FROM enrollments e JOIN courses c ON e.course_id=c.course_id
GROUP BY e.course_id, c.course_name
ORDER BY cnt DESC LIMIT 5;
```

### 9. Students with no enrollments (LEFT anti-join).
```sql
SELECT s.student_id, s.name
FROM students s LEFT JOIN enrollments e ON s.student_id=e.student_id
WHERE e.course_id IS NULL;
```

### 10. Courses with no enrollments (RIGHT join anti-join).
```sql
SELECT c.course_id, c.course_name
FROM enrollments e RIGHT JOIN courses c ON e.course_id=c.course_id
WHERE e.student_id IS NULL;
```

### 11. Distinct courses per student (top 10).
```sql
SELECT s.student_id, s.name, COUNT(DISTINCT e.course_id) AS dc
FROM students s JOIN enrollments e ON s.student_id=e.student_id
GROUP BY s.student_id, s.name
ORDER BY dc DESC LIMIT 10;
```

### 12. Distinct students per course (top 10).
```sql
SELECT c.course_id, c.course_name, COUNT(DISTINCT e.student_id) AS ds
FROM courses c JOIN enrollments e ON c.course_id=e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY ds DESC LIMIT 10;
```

### 13. Students from FRANCE enrolled in any AI-related course.
```sql
SELECT DISTINCT s.student_id, s.name
FROM students s
JOIN enrollments e ON s.student_id=e.student_id
JOIN courses c ON e.course_id=c.course_id
WHERE s.country='FRANCE' AND c.course_name LIKE '%AI%';
```

### 14. Students whose name contains 'an'.
```sql
SELECT student_id, name FROM students WHERE name LIKE '%an%';
```

### 15. Courses whose name ends with '01'.
```sql
SELECT course_id, course_name FROM courses WHERE course_name LIKE '%01' LIMIT 10;
```

### 16. First 10 enrollments sorted by (student_id asc, course_id asc).
```sql
SELECT * FROM enrollments ORDER BY student_id ASC, course_id ASC LIMIT 10;
```

### 17. Students with majors 'Engineering' or 'Law'.
```sql
SELECT student_id, name, major FROM students WHERE major IN ('Engineering','Law');
```

### 18. Students and count of enrollments >= 20.
```sql
SELECT s.student_id, s.name, COUNT(*) AS n
FROM students s JOIN enrollments e ON s.student_id=e.student_id
GROUP BY s.student_id, s.name
HAVING COUNT(*) >= 20
ORDER BY n DESC;
```

### 19. Courses with at least 25 students.
```sql
SELECT c.course_id, c.course_name, COUNT(*) AS n
FROM courses c JOIN enrollments e ON c.course_id=e.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(*) >= 25
ORDER BY n DESC;
```

### 20. Random sample of 10 students.
```sql
SELECT * FROM students ORDER BY RAND() LIMIT 10;
```

### 21. INNER JOIN: student name + course name (first 10).
```sql
SELECT s.name, c.course_name
FROM enrollments e
JOIN students s ON e.student_id=s.student_id
JOIN courses c ON e.course_id=c.course_id
LIMIT 10;
```

### 22. LEFT JOIN: all students + any course.
```sql
SELECT s.student_id, s.name, e.course_id
FROM students s LEFT JOIN enrollments e ON s.student_id=e.student_id
LIMIT 10;
```

### 23. RIGHT JOIN: all courses + any student.
```sql
SELECT c.course_id, c.course_name, e.student_id
FROM enrollments e RIGHT JOIN courses c ON e.course_id=c.course_id
LIMIT 10;
```

### 24. Invalid FKs (should be none).
```sql
SELECT e.* FROM enrollments e LEFT JOIN students s ON e.student_id=s.student_id WHERE s.student_id IS NULL
UNION ALL
SELECT e.* FROM enrollments e LEFT JOIN courses c ON e.course_id=c.course_id WHERE c.course_id IS NULL;
```

### 25. Duplicate enrollments (should be none).
```sql
SELECT student_id, course_id, COUNT(*) FROM enrollments GROUP BY student_id, course_id HAVING COUNT(*)>1;
```

