# 🏋️ MySQL Beginner Practice Workbook  

---

## 🔹 Step 1: Create a Database

```sql
CREATE DATABASE school_db;

USE school_db;
```

---

## 🔹 Step 2: Create Tables

We’ll make two tables: `students` and `courses`.  

```sql
CREATE TABLE students (
    student_id INT  PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    grade VARCHAR(5)
);

CREATE TABLE courses (
    course_id INT  PRIMARY KEY,
    course_name VARCHAR(50),
    credits INT
);
```

---

## 🔹 Step 3: Insert Data

#### Populate students table:

```sql
INSERT INTO students (student_id, name, age, grade)
VALUES 
(1, 'Alice', 20, 'A'),
(2, 'Bob', 22, 'B'),
(3, 'Charlie', 21, 'C'),
(4, 'Diana', 23, 'B'),
(5, 'Ethan', 20, 'A'),
(6, 'Rafa', 20, 'B');
```

#### Get all rows from the students table:

~~~sql
SELECT *
FROM students;
~~~

#### Populate courses table:

~~~sql
INSERT INTO courses (course_id, course_name, credits)
VALUES 
(100, 'Math', 3),
(200, 'History', 4),
(300, 'Biology', 3),
(400, 'Computer Science', 5);
~~~

#### Get all rows from the courses table:

~~~sql
SELECT *
FROM courses;
~~~

---

## 🔹 Step 4: Basic SELECT Queries
```sql
-- See everything
SELECT * 
FROM students;

-- See only names
SELECT name 
FROM students;

-- See students with grade A
SELECT * 
FROM students 
WHERE grade = 'A';

-- See students older than 21
SELECT * 
FROM students 
WHERE age > 21;

-- Sort students by age (youngest first)
SELECT * 
FROM students 
ORDER BY age ASC;

-- Sort students by age (oldest first)
SELECT * 
FROM students 
ORDER BY age DESC;
```

---

## 🔹 Step 5.1: Update 

~~~sql
-- Change Charlie’s grade to A+
UPDATE students
SET grade = 'A+'
WHERE name = 'Charlie';
~~~

## 🔹 Step 5.2: Delete

~~~sql
-- Delete Ethan
DELETE FROM students
WHERE name = 'Ethan';
~~~

---

## 🔹 Step 6: Create Relationships  

Let’s make a **many-to-many** relation (students can take many courses).  
We’ll need a third table: `enrollments`.  

```sql
CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Add enrollments
INSERT INTO enrollments (student_id, course_id)
VALUES 
(1, 100),  -- Alice takes Math
(1, 400),  -- Alice takes Computer Science
(2, 200),  -- Bob takes History
(3, 300),  -- Charlie takes Biology
(4, 100),  -- Diana takes Math
(4, 200);  -- Diana takes History
```

---

## 🔹 Step 7: JOIN Queries  
```sql
-- See all enrollments with student names & course names
SELECT s.name, c.course_name
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id;

-- See all students taking Math
SELECT s.name
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Math';
```

---

## 🔹 Step 8: Aggregate Queries (Counts, Averages, etc.)
```sql
-- Count number of students
SELECT COUNT(*) AS total_students FROM students;

-- Find average age of students
SELECT AVG(age) AS avg_age FROM students;

-- Count how many students per grade
SELECT grade, COUNT(*) AS num_students
FROM students
GROUP BY grade;

-- Count how many students are in each course
SELECT c.course_name, COUNT(*) AS num_students
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
GROUP BY c.course_name;
```

---

