# Week 1 — Intro to MySQL: SELECT / FROM / WHERE, ORDER BY, LIMIT

```sql
CREATE DATABASE IF NOT EXISTS uni;
USE uni;
```

```sql
CREATE TABLE IF NOT EXISTS students (
  student_id INT PRIMARY KEY,
  first_name VARCHAR(30),
  last_name  VARCHAR(30),
  country    VARCHAR(20),
  age        INT,
  gpa        DECIMAL(3,2)
);
```

### Inserts (50 rows)
```sql
INSERT INTO students(student_id,first_name,last_name,country,age,gpa) VALUES
(1, 'Gina', 'Gonzalez', 'MEXICO', 21, 3.25),
(2, 'Quinn', 'Miller', 'USA', 19, 3.84),
(3, 'Liam', 'Ramirez', 'INDIA', 22, 3.81),
(4, 'Zane', 'Miller', 'USA', 23, 2.50),
(5, 'Vera', 'Martin', 'CANADA', 22, 3.75),
(6, 'Mona', 'Martin', 'CANADA', 23, 3.59),
(7, 'Mona', 'Garcia', 'INDIA', 22, 3.41),
(8, 'Paul', 'Thompson', 'USA', 23, 3.09),
(9, 'Hugo', 'Rodriguez', 'MEXICO', 23, 3.47),
(10, 'Troy', 'Garcia', 'INDIA', 23, 2.53),
(11, 'Tina', 'Hernandez', 'CANADA', 18, 3.64),
(12, 'Gina', 'Clark', 'MEXICO', 21, 2.21),
(13, 'Finn', 'Ramirez', 'GERMANY', 20, 3.06),
(14, 'Tina', 'Moore', 'GERMANY', 21, 2.64),
(15, 'Sara', 'Perez', 'CANADA', 24, 3.94),
(16, 'Mona', 'Martinez', 'MEXICO', 24, 2.33),
(17, 'Ralph', 'Martinez', 'CANADA', 18, 3.70),
(18, 'Quinn', 'Gonzalez', 'MEXICO', 18, 3.83),
(19, 'Zoe', 'Thompson', 'INDIA', 23, 3.23),
(20, 'Grace', 'Clark', 'USA', 19, 2.23),
(21, 'Dylan', 'Gonzalez', 'GERMANY', 24, 2.65),
(22, 'Rita', 'Ramirez', 'USA', 24, 3.01),
(23, 'Sara', 'Wilson', 'CANADA', 19, 2.74),
(24, 'Noah', 'Thomas', 'MEXICO', 22, 3.19),
(25, 'Will', 'Taylor', 'GERMANY', 23, 3.62),
(26, 'Chloe', 'Miller', 'GERMANY', 18, 2.87),
(27, 'Bob', 'Hernandez', 'MEXICO', 18, 2.68),
(28, 'Tina', 'Lee', 'INDIA', 18, 2.30),
(29, 'Elena', 'Lopez', 'GERMANY', 20, 2.88),
(30, 'Ivy', 'Lopez', 'GERMANY', 18, 2.41),
(31, 'Yara', 'Williams', 'CANADA', 22, 2.41),
(32, 'Nina', 'Rodriguez', 'CANADA', 20, 3.80),
(33, 'Will', 'Robinson', 'INDIA', 19, 3.98),
(34, 'Mona', 'Robinson', 'USA', 22, 2.26),
(35, 'Zane', 'White', 'CANADA', 20, 3.39),
(36, 'Noah', 'Brown', 'USA', 23, 2.89),
(37, 'Jack', 'Moore', 'INDIA', 24, 2.94),
(38, 'Wendy', 'Gonzalez', 'INDIA', 24, 2.50),
(39, 'Rita', 'Miller', 'USA', 18, 3.16),
(40, 'Isla', 'Wilson', 'GERMANY', 18, 2.60),
(41, 'Ralph', 'Jackson', 'INDIA', 22, 2.24),
(42, 'Gina', 'Smith', 'GERMANY', 19, 3.23),
(43, 'Rita', 'Jackson', 'USA', 20, 3.53),
(44, 'Xander', 'Thomas', 'USA', 24, 3.85),
(45, 'Carol', 'Harris', 'USA', 22, 3.10),
(46, 'Jon', 'Clark', 'GERMANY', 22, 3.31),
(47, 'Eve', 'Garcia', 'USA', 18, 3.61),
(48, 'Sara', 'Harris', 'USA', 21, 3.63),
(49, 'Quinn', 'Ramirez', 'INDIA', 21, 3.88),
(50, 'Rita', 'Taylor', 'MEXICO', 21, 2.21);
```

## Slides (20)
#### Slide 1: Course & DB Overview
- What is a database?
- Relational vs non-relational
- Where MySQL fits

#### Slide 2: Installing & Connecting
- MySQL Server & Workbench
- Create user, grant, connect

#### Slide 3: Databases & Schemas
- CREATE DATABASE / USE
- Naming conventions

#### Slide 4: Tables & Data Types
- INT, VARCHAR, DECIMAL
- Choosing sizes / precision

#### Slide 5: Creating Tables
- CREATE TABLE syntax
- PRIMARY KEYs

#### Slide 6: Inserting Data
- INSERT single vs multi-row
- Validating inserts

#### Slide 7: SELECT Basics
- SELECT * vs column list
- Column order & aliases

#### Slide 8: FROM & Row Sources
- One-table queries
- Using aliases

#### Slide 9: WHERE Filters
- Comparison ops
- AND/OR/NOT

#### Slide 10: LIKE & Wildcards
- '%a%'
- 'M%'
- '%z'

#### Slide 11: ORDER BY
- ASC/DESC
- Multi-column sort

#### Slide 12: LIMIT & OFFSET
- Top-N
- Pagination patterns

#### Slide 13: DISTINCT
- Removing duplicates
- When to use

#### Slide 14: NULLs
- IS NULL/IS NOT NULL
- Three-valued logic

#### Slide 15: Expressions
- Computed columns
- Functions: UPPER, LOWER, LENGTH, ROUND

#### Slide 16: Readability
- AS aliases
- Formatting SQL

#### Slide 17: Indexing (Preview)
- What indexes are
- Why not now

#### Slide 18: EXPLAIN (Preview)
- High-level idea
- When to use

#### Slide 19: Common Pitfalls
- SELECT *
- Implicit conversions

#### Slide 20: Lab Preview
- What you’ll practice today


## Lab: 40 Queries (English → SQL)

1. List all students
```sql
SELECT * FROM students;
```

2. Show the first 5 rows
```sql
SELECT * FROM students LIMIT 5;
```

3. Return only first and last names
```sql
SELECT first_name, last_name FROM students;
```

4. Find students from USA
```sql
SELECT * FROM students WHERE country='USA';
```

5. Find students aged 21 and above
```sql
SELECT * FROM students WHERE age >= 21;
```

6. Find students with GPA greater than 3.50
```sql
SELECT * FROM students WHERE gpa > 3.50;
```

7. Find students not from CANADA
```sql
SELECT * FROM students WHERE country <> 'CANADA';
```

8. Find students with GPA between 3.00 and 3.50
```sql
SELECT * FROM students WHERE gpa BETWEEN 3.00 AND 3.50;
```

9. Find students whose last name starts with 'M'
```sql
SELECT * FROM students WHERE last_name LIKE 'M%';
```

10. Find students whose first name contains 'a'
```sql
SELECT * FROM students WHERE first_name LIKE '%a%';
```

11. Sort students by GPA (highest first)
```sql
SELECT * FROM students ORDER BY gpa DESC;
```

12. Sort students by country, then last name
```sql
SELECT * FROM students ORDER BY country, last_name;
```

13. Return the top 10 students by GPA
```sql
SELECT * FROM students ORDER BY gpa DESC LIMIT 10;
```

14. List the unique countries represented
```sql
SELECT DISTINCT country FROM students;
```

15. Count how many students are from INDIA
```sql
SELECT COUNT(*) AS cnt FROM students WHERE country='INDIA';
```

16. Calculate average GPA of students from USA
```sql
SELECT AVG(gpa) AS avg_gpa FROM students WHERE country='USA';
```

17. Find students with missing last name (if any)
```sql
SELECT * FROM students WHERE last_name IS NULL;
```

18. Show student_id, first_name, and computed score (gpa*25)
```sql
SELECT student_id, first_name, gpa, gpa*25 AS score FROM students;
```

19. Return last names in uppercase
```sql
SELECT student_id, UPPER(last_name) AS last_caps FROM students;
```

20. Show 5 youngest students by age, tie-break on GPA desc
```sql
SELECT * FROM students ORDER BY age ASC, gpa DESC LIMIT 5;
```

21. Find students whose age is either 20 or 22
```sql
SELECT * FROM students WHERE age IN (20,22);
```

22. Find students whose age is not 19
```sql
SELECT * FROM students WHERE age <> 19;
```

23. Round GPA to 1 decimal place for all students
```sql
SELECT student_id, ROUND(gpa,1) AS gpa_1d FROM students;
```

24. Show first 10 rows ordered by last then first name
```sql
SELECT * FROM students ORDER BY last_name, first_name LIMIT 10;
```

25. Show the length of each student's first_name
```sql
SELECT student_id, first_name, LENGTH(first_name) AS len FROM students;
```

26. Show top 3 USA students by GPA
```sql
SELECT * FROM students WHERE country='USA' ORDER BY gpa DESC LIMIT 3;
```

27. Find students whose last name ends with 'z'
```sql
SELECT * FROM students WHERE last_name LIKE '%z';
```

28. Find students whose GPA is not between 2.50 and 3.00
```sql
SELECT * FROM students WHERE gpa NOT BETWEEN 2.50 AND 3.00;
```

29. Preview country-wise top GPAs (sorted view)
```sql
SELECT country, gpa FROM students ORDER BY country, gpa DESC;
```

30. Project first_name with alias 'fname'
```sql
SELECT first_name AS fname FROM students;
```

31. Find students from USA or INDIA
```sql
SELECT * FROM students WHERE country IN ('USA','INDIA');
```

32. Return top 15 students by GPA, tie-break by ascending age
```sql
SELECT * FROM students ORDER BY gpa DESC, age ASC LIMIT 15;
```

33. Find students whose last name equals 'Lee'
```sql
SELECT * FROM students WHERE last_name='Lee';
```

34. Show students aged 18–24 (preview by listing age & id)
```sql
SELECT age, student_id FROM students WHERE age BETWEEN 18 AND 24;
```

35. Return rows 6–10 by GPA (using OFFSET)
```sql
SELECT * FROM students ORDER BY gpa DESC LIMIT 5 OFFSET 5;
```

36. Find the student with the smallest GPA
```sql
SELECT * FROM students ORDER BY gpa ASC LIMIT 1;
```

37. Find the student with the largest GPA
```sql
SELECT * FROM students ORDER BY gpa DESC LIMIT 1;
```

38. Order by last_name then first_name to visually inspect duplicates
```sql
SELECT * FROM students ORDER BY last_name, first_name;
```

39. Find students whose first_name length is at least 4
```sql
SELECT * FROM students WHERE LENGTH(first_name) >= 4;
```

40. Return a sample of 12 rows
```sql
SELECT * FROM students LIMIT 12;
```
