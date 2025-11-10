
# Teacher Answer Key: Week 1 & Week 2
*Generated on 2025-11-10*

Use `USE module_db;` first.

## Part A — Week 1
1.
```sql
SELECT student_id, name, country, age
FROM students
ORDER BY age DESC;
```
2.
```sql
SELECT name, age
FROM students
WHERE country = 'USA' AND age > 21;
```
3.
```sql
SELECT c.course_name
FROM courses c
INNER JOIN departments d ON d.dept_id = c.dept_id
WHERE d.dept_name = 'Mathematics'
ORDER BY c.course_name;
```
4.
```sql
SELECT name, age
FROM students
ORDER BY age ASC
LIMIT 3;
```
5.
```sql
SELECT name
FROM students
WHERE name LIKE 'A%' OR name LIKE '%y';
```

## Part B — Week 2
6.
```sql
SELECT s.name, c.course_name, e.semester
FROM enrollments e
INNER JOIN students s ON s.student_id = e.student_id
INNER JOIN courses  c ON c.course_id  = e.course_id
ORDER BY s.name, c.course_name;
```
7.
```sql
SELECT s.name, COUNT(e.enroll_id) AS num_enrollments
FROM students s
LEFT JOIN enrollments e ON e.student_id = s.student_id
GROUP BY s.student_id, s.name
ORDER BY num_enrollments DESC, s.name;
```
8.
```sql
SELECT c.course_name, COUNT(*) AS num_enrolled
FROM enrollments e
INNER JOIN courses c ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY num_enrolled DESC;
```
9.
```sql
SELECT s.name, AVG(e.grade) AS avg_gpa
FROM enrollments e
INNER JOIN students s ON s.student_id = e.student_id
GROUP BY s.name
ORDER BY avg_gpa DESC;
```
10.
```sql
SELECT d.dept_name, COUNT(*) AS num_courses
FROM courses c
INNER JOIN departments d ON d.dept_id = c.dept_id
GROUP BY d.dept_name
HAVING COUNT(*) >= 2
ORDER BY num_courses DESC;
```
11.
```sql
SELECT c.course_name, AVG(e.grade) AS avg_gpa
FROM enrollments e
INNER JOIN courses c ON c.course_id = e.course_id
WHERE e.semester = 'S25'
GROUP BY c.course_name
HAVING AVG(e.grade) >= 3.5
ORDER BY avg_gpa DESC;
```
12.
```sql
SELECT s.name,
       GROUP_CONCAT(c.course_name ORDER BY c.course_name SEPARATOR ', ') AS courses
FROM enrollments e
INNER JOIN students s ON s.student_id = e.student_id
INNER JOIN courses c  ON c.course_id  = e.course_id
GROUP BY s.student_id, s.name
ORDER BY s.name;
```
13.
```sql
SELECT s.name, COUNT(*) AS total_enrollments
FROM enrollments e
INNER JOIN students s ON s.student_id = e.student_id
GROUP BY s.student_id, s.name
ORDER BY total_enrollments DESC, s.name
LIMIT 5;
```
14. (Intro to SQL course_id = 201; tests inserted with ids 1..3 in order)
```sql
SELECT t.test_name, AVG(sc.score) AS avg_score
FROM scores sc
INNER JOIN tests t ON t.test_id = sc.test_id
WHERE t.course_id = 201
GROUP BY t.test_id, t.test_name
ORDER BY t.test_id;
```
15.
```sql
SELECT s.name, AVG(sc.score) AS avg_score_intro_sql
FROM scores sc
INNER JOIN tests t ON t.test_id = sc.test_id
INNER JOIN students s ON s.student_id = sc.student_id
WHERE t.course_id = 201
GROUP BY s.student_id, s.name
ORDER BY avg_score_intro_sql DESC;
```
