# Lab-1 – Basics (25 queries)

> Tables: `students`, `courses`, `enrollments`

### 1. List first 10 students.
```sql
SELECT * FROM students LIMIT 10;
```

### 2. List first 10 courses.
```sql
SELECT * FROM courses LIMIT 10;
```

### 3. List first 10 enrollments.
```sql
SELECT * FROM enrollments LIMIT 10;
```

### 4. Show student names and majors.
```sql
SELECT name, major FROM students LIMIT 15;
```

### 5. Find all CS majors.
```sql
SELECT student_id, name FROM students WHERE major='CS';
```

### 6. Find students from INDIA.
```sql
SELECT student_id, name FROM students WHERE country='INDIA';
```

### 7. Find students from USA studying AI.
```sql
SELECT student_id, name FROM students WHERE country='USA' AND major='AI';
```

### 8. Courses taught by instructor name containing 'Lee'.
```sql
SELECT course_id, course_name FROM courses WHERE instructor LIKE '%Lee%';
```

### 9. Students whose name starts with 'A'.
```sql
SELECT student_id, name FROM students WHERE name LIKE 'A%';
```

### 10. Sort students by name (A→Z).
```sql
SELECT student_id, name FROM students ORDER BY name ASC LIMIT 15;
```

### 11. Sort courses by course_name (Z→A).
```sql
SELECT course_id, course_name FROM courses ORDER BY course_name DESC LIMIT 15;
```

### 12. Change one student’s major to Finance (demo).
```sql
UPDATE students SET major='Finance' WHERE student_id=1;
```

### 13. Insert a demo course (to delete later).
```sql
INSERT INTO courses VALUES (1001,'Demo 101','Demo Instructor');
```

### 14. Delete the demo course.
```sql
DELETE FROM courses WHERE course_id=1001;
```

### 15. Find enrollments for student_id=7 (first 10).
```sql
SELECT * FROM enrollments WHERE student_id=7 LIMIT 10;
```

### 16. Find enrollments for course_id between 10 and 20.
```sql
SELECT * FROM enrollments WHERE course_id BETWEEN 10 AND 20 LIMIT 10;
```

### 17. Distinct list of majors.
```sql
SELECT DISTINCT major FROM students;
```

### 18. Count students per country (preview GROUP BY).
```sql
SELECT country, COUNT(*) AS cnt FROM students GROUP BY country;
```

### 19. Count enrollments per course (top 10).
```sql
SELECT course_id, COUNT(*) AS cnt FROM enrollments GROUP BY course_id ORDER BY cnt DESC LIMIT 10;
```

### 20. Students not from CHINA.
```sql
SELECT student_id, name, country FROM students WHERE country <> 'CHINA' LIMIT 15;
```

### 21. Preview INNER JOIN: show student + course for first 10 enrollments.
```sql
SELECT e.student_id, s.name, e.course_id, c.course_name
FROM enrollments e JOIN students s ON e.student_id=s.student_id
JOIN courses c ON e.course_id=c.course_id
LIMIT 10;
```

### 22. Preview LEFT JOIN: all students and any course enrolled.
```sql
SELECT s.student_id, s.name, e.course_id
FROM students s LEFT JOIN enrollments e ON s.student_id=e.student_id
LIMIT 10;
```

### 23. Preview RIGHT JOIN: all courses and any enrolled student.
```sql
SELECT c.course_id, c.course_name, e.student_id
FROM enrollments e RIGHT JOIN courses c ON e.course_id=c.course_id
LIMIT 10;
```

### 24. Sanity check: students with NULL name (should be none).
```sql
SELECT * FROM students WHERE name IS NULL;
```

### 25. Sanity check: duplicate enrollments (should be none by PK).
```sql
SELECT student_id, course_id, COUNT(*) FROM enrollments GROUP BY student_id, course_id HAVING COUNT(*)>1;
```

