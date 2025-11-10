# SQL Concepts Explained with Simple Examples

```
1. PK: PRIMARY KEY

2. FK: FOREIGN KEY

3. FROM

4. WHERE

5. GROUP BY

6. Aggregation functions:

* `MIN()`
* `MAX()`
* `COUNT()`
* `AVG()`
* `SUM()`
* `GROUP_CONCAT()`

7. Difference of WHERE and HAVING

8. Using WHERE and HAVING Together

9. ORDER BY ASC

10. ORDER BY DESC

11. LIMIT n
```

## 1. PRIMARY KEY (PK)
A **PRIMARY KEY** uniquely identifies each row in a table.  
It must be **unique** and **not NULL**.

### Example
```sql
CREATE TABLE students (
   student_id INT PRIMARY KEY,
   name VARCHAR(50)
);
```

---

## 2. FOREIGN KEY (FK)
A **FOREIGN KEY** creates a relationship between two tables.

### Example
```sql
CREATE TABLE enrollments (
   enroll_id INT PRIMARY KEY,
   student_id INT,
   FOREIGN KEY (student_id) REFERENCES students(student_id)
);
```

---

## 3. FROM
Specifies the table(s) from which to retrieve rows.

### Example
```sql
SELECT name
FROM students;
```

---

## 4. WHERE
Filters rows **before** grouping or aggregation happens.

### Example
```sql
SELECT *
FROM students
WHERE name = 'Alice';
```

---

## 5. GROUP BY
Groups rows so aggregation can be applied per group.

### Example
```sql
SELECT student_id, COUNT(*) AS num_courses
FROM enrollments
GROUP BY student_id;
```

---

## 6. Aggregation Functions

### MIN()
```sql
SELECT MIN(score) FROM tests;
```

### MAX()
```sql
SELECT MAX(score) FROM tests;
```

### COUNT()
```sql
SELECT COUNT(*) FROM tests;
```

### AVG()
```sql
SELECT AVG(score) FROM tests;
```

### SUM()
```sql
SELECT SUM(score) FROM tests;
```

### GROUP_CONCAT()
```sql
SELECT student_id, GROUP_CONCAT(course_name)
FROM enrollments
GROUP BY student_id;
```

---

## 7. Difference Between WHERE and HAVING

### WHERE
- Filters rows **before** GROUP BY.
- Cannot use aggregate functions.

### HAVING
- Filters groups **after** GROUP BY.
- Can use aggregate functions.

### Example

```sql
SELECT student_id, COUNT(*) AS num_courses
FROM enrollments
GROUP BY student_id
HAVING COUNT(*) > 2;
```

OR

```sql
SELECT student_id, COUNT(*) AS num_courses
FROM enrollments
GROUP BY student_id
HAVING num_courses > 2;
```


---

## 8. Using WHERE and HAVING Together

### Example
```sql
SELECT student_id, COUNT(*) AS num_courses
FROM enrollments
WHERE student_id > 100          -- row filter
GROUP BY student_id
HAVING COUNT(*) >= 3;           -- group filter
```

---

## 9. ORDER BY ASC (Ascending Order)

### Example
```sql
SELECT name
FROM students
ORDER BY name ASC;
```

---

## 10. ORDER BY DESC (Descending Order)

### Example
```sql
SELECT name
FROM students
ORDER BY name DESC;
```

---

## 11. LIMIT n
Limits the number of rows returned.

### Example
```sql
SELECT *
FROM students
ORDER BY student_id
LIMIT 5;
```

---

# Week 2: GROUP BY, HAVING, and JOINs
*Generated on 2025-11-10*

## Learning Goals
- Use INNER/LEFT/RIGHT JOINs
- GROUP BY with aggregation functions
- WHERE vs HAVING and using both

## Join Examples
### INNER JOIN (students enrolled in courses)
```sql
SELECT s.name, c.course_name, e.semester
FROM enrollments e
INNER JOIN students s ON s.student_id = e.student_id
INNER JOIN courses  c ON c.course_id  = e.course_id
ORDER BY s.name, c.course_name;
```

### LEFT JOIN (all students, with enrollments if any)
```sql
SELECT s.name, e.course_id, e.semester
FROM students s
LEFT JOIN enrollments e ON e.student_id = s.student_id
ORDER BY s.name;
```

### RIGHT JOIN (all courses, with enrollments if any)
```sql
SELECT e.student_id, c.course_name
FROM enrollments e
RIGHT JOIN courses c ON c.course_id = e.course_id
ORDER BY c.course_name;
```

## Aggregations + GROUP BY
### Count enrollments per course
```sql
SELECT c.course_name, COUNT(*) AS num_enrolled
FROM enrollments e
INNER JOIN courses c ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY num_enrolled DESC;
```

### Average grade per student (where we have a grade)
```sql
SELECT s.name, AVG(e.grade) AS avg_gpa
FROM enrollments e
INNER JOIN students s ON s.student_id = e.student_id
GROUP BY s.name
ORDER BY avg_gpa DESC;
```

### WHERE vs HAVING
- **WHERE** filters rows *before* grouping.  
- **HAVING** filters *after* grouping (can use aggregates).

```sql
-- Students with any enrollment in F24, then groups with HAVING
SELECT s.name, COUNT(*) AS cnt
FROM enrollments e
INNER JOIN students s ON s.student_id = e.student_id
WHERE e.semester = 'F24'
GROUP BY s.name
HAVING COUNT(*) >= 2;
```

### Using WHERE and HAVING together
```sql
SELECT c.course_name, AVG(e.grade) AS avg_gpa
FROM enrollments e
INNER JOIN courses c ON c.course_id = e.course_id
WHERE e.semester IN ('F24','S25')
GROUP BY c.course_name
HAVING AVG(e.grade) >= 3.5;
```

### GROUP_CONCAT
```sql
SELECT s.name, GROUP_CONCAT(c.course_name ORDER BY c.course_name SEPARATOR ', ') AS courses
FROM enrollments e
INNER JOIN students s ON s.student_id = e.student_id
INNER JOIN courses c  ON c.course_id  = e.course_id
GROUP BY s.name
ORDER BY s.name;
```

## Week 2 Exercises
1. For each course, list the **min**, **max**, and **avg** grade.  
2. Show each department and the number of courses it offers.  
3. List students who are enrolled in **at least 2** distinct courses.  
4. Show courses whose average grade is **>= 3.5** (S25 only).  
5. For each student, list a comma-separated list of courses (use `GROUP_CONCAT`).  

