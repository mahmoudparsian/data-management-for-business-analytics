# Lab 1: Students Database with 50 SQL QUERIES

### Lab Description

	Let's create the first lab/demo for MySQL 101: 
	students have just installed MySQL database on 
	their laptop and ready to explore creating and 
	querying the fist table: create a simple table 
	with 20 rows of data with insert statements, then 
	provide 50 queries from very basic to intermediate 
	level: both in English and sql: provide everything 
	in markdown format

### Data Story...

	Here's a complete markdown-formatted lab/demo for 
	MySQL 101: Lab 1 – Creating and Querying Your First 
	Table. This lab is designed to help students get 
	hands-on experience with MySQL by creating a table, 
	inserting data, and running a wide range of queries.

## 🧪 Lab 1 – Creating and Querying Your First Table

	Welcome to your first MySQL lab! In this 
	exercise, you'll create a simple table, 
	populate it with data, and run 50 queries 
	ranging from beginner to intermediate level.
	
### 📦 Step 1: Create a Database

```sql
CREATE DATABASE students_db;
```

### 📦 Step 2: Make your created database ACTIVE to be used

```sql
USE students_db;
```

### 📦 Step 3: Create a Table

	We'll create a table called students 
	to store basic student information.


```sql
CREATE TABLE students (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    grade_level VARCHAR(10),
    gpa DECIMAL(3,2),
    enrolled BOOLEAN
);
```

### 📝 Step 4: Insert 20 Rows of Sample Data

```sql
INSERT INTO students VALUES
(1, 'Alice', 'Johnson', 14, '9th', 3.8, TRUE),
(2, 'Bob', 'Smith', 15, '10th', 3.2, TRUE),
(3, 'Charlie', 'Lee', 16, '11th', 2.9, TRUE),
(4, 'Diana', 'Garcia', 17, '12th', 3.5, TRUE),
(5, 'Ethan', 'Martinez', 14, '9th', 3.0, TRUE),
(6, 'Fiona', 'Davis', 15, '10th', 3.9, TRUE),
(7, 'George', 'Brown', 16, '11th', 2.5, TRUE),
(8, 'Hannah', 'Wilson', 17, '12th', 3.7, TRUE),
(9, 'Ian', 'Moore', 14, '9th', 3.1, TRUE),
(10, 'Julia', 'Taylor', 15, '10th', 3.6, TRUE),
(11, 'Kevin', 'Anderson', 16, '11th', 2.8, TRUE),
(12, 'Laura', 'Thomas', 17, '12th', 3.4, TRUE),
(13, 'Mike', 'Jackson', 14, '9th', 2.7, TRUE),
(14, 'Nina', 'White', 15, '10th', 3.3, TRUE),
(15, 'Oscar', 'Harris', 16, '11th', 3.0, TRUE),
(16, 'Paula', 'Martin', 17, '12th', 3.6, TRUE),
(17, 'Quinn', 'Thompson', 14, '9th', 3.2, TRUE),
(18, 'Rachel', 'Young', 15, '10th', 3.8, TRUE),
(19, 'Sam', 'King', 16, '11th', 2.6, TRUE),
(20, 'Tina', 'Scott', 17, '12th', 3.9, TRUE),
(21, 'Rafa', 'Taylor', 16, '11th', 3.6, FALSE),
(22, 'Alex', 'Smith', 18, '12th', 3.8, FALSE);
```

## 🔍 Step 5: Run 50 Queries (English + SQL)

### 🟢 Basic Queries

#### 1. Show all students

```sql
SELECT  * 
FROM students;
```

#### 2. Show only first names

```sql
SELECT  first_name 
FROM students;
```


#### 3. Show students who are 15 years old

```sql
SELECT  * 
FROM students 
WHERE age = 15;
```


#### 4. Show students in 10th grade

```sql
SELECT  * 
FROM students 
WHERE grade_level = '10th';
```

#### 5. Show students with GPA greater than 3.5

```sql
SELECT  * 
FROM students 
WHERE gpa > 3.5;
```


#### 6. Show students with GPA less than 3.0

```sql
SELECT  * 
FROM students 
WHERE gpa < 3.0;
```

#### 7. Show students whose first name starts with 'A'

```sql
SELECT  * 
FROM students 
WHERE first_name LIKE 'A%';
```

#### 8. Show students whose last name ends with 'son'

```sql
SELECT  * 
FROM students 
WHERE last_name LIKE '%son';
```

#### 9. Show students who are enrolled

```sql
SELECT  * 
FROM students 
WHERE enrolled = TRUE;
```

#### 10. Show students who are not enrolled

```sql
SELECT  * 
FROM students 
WHERE enrolled = FALSE;
```


#### 11. Count total number of students

```sql
SELECT  COUNT(*) 
FROM students;
```


#### 12. Count students in 9th grade

```sql
SELECT  COUNT(*) 
FROM students 
WHERE grade_level = '9th';
```

#### 13. Find average GPA

```sql
SELECT  AVG(gpa) 
FROM students;
```

#### 14. Find highest GPA

```sql
SELECT  MAX(gpa) 
FROM students;
```

#### 15. Find lowest GPA

```sql
SELECT  MIN(gpa) 
FROM students;
```

#### 16. Show students ordered by GPA descending


```sql
SELECT  * 
FROM students 
ORDER BY gpa DESC;
```


#### 17. Show students ordered by age ascending

```sql
SELECT  * 
FROM students 
ORDER BY age ASC;
```


#### 18. Show top 5 students by GPA

```sql
SELECT  * 
FROM students 
ORDER BY gpa DESC 
LIMIT 5;
```


#### 19. Show students aged between 15 and 17

```sql
SELECT  * 
FROM students 
WHERE age BETWEEN 15 AND 17;
```


#### 20. Show students with GPA between 3.0 and 3.5


```sql
SELECT  * 
FROM students 
WHERE gpa BETWEEN 3.0 AND 3.5;
```


## 🟡 Intermediate Queries

#### 21. Group students by grade level


```sql
SELECT  grade_level, 
        COUNT(*) 
FROM students 
GROUP BY grade_level;
```


#### 22. Group students by age


```sql
SELECT  age, 
        COUNT(*) 
FROM students 
GROUP BY age;
```


#### 23. Show average GPA per grade level


```sql
SELECT  grade_level, 
        AVG(gpa) 
FROM students 
GROUP BY grade_level;
```


#### 24. Show students with GPA above average


```sql
SELECT  * 
FROM students 
WHERE gpa > (SELECT  AVG(gpa) FROM students);
```


#### 25. Show students with duplicate GPA


```sql
SELECT  gpa, 
        COUNT(*) 
FROM students 
GROUP BY gpa 
HAVING COUNT(*) > 1;
```


#### 26. Show students whose age is not 14

```sql
SELECT  * 
FROM students 
WHERE age != 14;
```


#### 27. Show students whose GPA is not null


```sql
SELECT  * 
FROM students 
WHERE gpa IS NOT NULL;
```


#### 28. Show students whose GPA is null


```sql
SELECT  * 
FROM students 
WHERE gpa IS NULL;
```


#### 29. Update GPA of student with id 1 to 4.0

```sql
UPDATE students 
SET gpa = 4.0 
WHERE id = 1;
```


#### 30. Delete student with id 20

```sql
DELETE 
FROM students 
WHERE id = 20;
```


#### 31. Add a new column for email

```sql
ALTER TABLE students 
ADD email VARCHAR(100);
```


#### 32. Set email for student with id 1

```sql
UPDATE students 
SET email = 'alice.johnson@example.com' 
WHERE id = 1;
```


#### 33. Show students with email ending in 'example.com'

```sql
SELECT  * 
FROM students 
WHERE email LIKE '%@example.com';
```


#### 34. Show students with GPA rounded to nearest integer


```sql
SELECT  first_name, 
        ROUND(gpa) 
FROM students;
```


#### 35. Show students with GPA truncated to 1 decimal


```sql
SELECT  first_name, 
        TRUNCATE(gpa, 1) 
FROM students;
```


#### 36. Show students with full name


```sql
SELECT  CONCAT(first_name, ' ', last_name) AS full_name 
FROM students;
```


#### 37. Show students with grade level as number (9th → 9)


```sql
SELECT  first_name, 
        CAST(SUBSTRING(grade_level, 1, 1) AS UNSIGNED) AS grade_num 
FROM students;
```


#### 38. Show students with GPA multiplied by 25


```sql
SELECT  first_name, 
        gpa * 25 AS score 
FROM students;
```


#### 39. Show students with age incremented by 1


```sql
SELECT  first_name, 
        age,
        age + 1 AS next_year_age 
FROM students;
```


#### 40. Show students with GPA formatted as percentage


```sql
SELECT  first_name, 
        CONCAT(gpa * 25, '%') AS gpa_percent 
FROM students;
```


#### 41. Find students with same first name


```sql
SELECT  first_name, 
        COUNT(*) 
FROM students 
GROUP BY first_name 
HAVING COUNT(*) > 1;
```


#### 42. Find students with same last name

```sql
SELECT  last_name, 
        COUNT(*) 
FROM students 
GROUP BY last_name 
HAVING COUNT(*) > 1;
```


## 🟡 Intermediate Queries (continued)

#### 43. Find students whose GPA is above 3.5 and are in 12th grade

```sql
SELECT  * 
FROM students 
WHERE (gpa > 3.5) AND 
      (grade_level = '12th');
```


#### 44. Find students whose first name contains the letter 'a'

```sql
SELECT  * 
FROM students 
WHERE first_name LIKE '%a%';
```


#### 45. Find students whose last name is either 'Smith' or 'Lee'

```sql
SELECT  * 
FROM students 
WHERE last_name IN ('Smith', 'Lee');
```


#### 46. Find students whose GPA is either 3.0, 3.5, or 4.0

```sql
SELECT  * 
FROM students 
WHERE gpa IN (3.0, 3.5, 4.0);
```


#### 47. Find students whose age is not between 15 and 17

```sql
SELECT  * 
FROM students 
WHERE age NOT BETWEEN 15 AND 17;
```


#### 48. Show students with GPA rounded to nearest tenth

```sql
SELECT  first_name, 
        ROUND(gpa, 1) AS rounded_gpa 
FROM students;
```


#### 49. Show students with full name and grade level in one column

```sql
SELECT  CONCAT(first_name, ' ', last_name, ' - ', grade_level) AS student_info 
FROM students;
```


#### 50. Find students whose GPA is above average for their grade level

```sql
SELECT  * FROM students s
WHERE gpa > (
               SELECT  AVG(gpa)
               FROM students
               WHERE grade_level = s.grade_level
            );
```

