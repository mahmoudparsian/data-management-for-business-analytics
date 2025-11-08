# Join Operations Tutorial

3 tables:

* students
* courses
* enrollments


---

	A hands-on introduction to **JOIN operations** 
	in MySQL using simple, realistic data.

---

## 🧩 1. Create Tables

```sql
-- Table: students
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    age INT,
    major VARCHAR(50)
);

-- Table: courses
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    instructor VARCHAR(50),
    credits INT
);

-- Table: enrollments
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade CHAR(2),
    semester VARCHAR(10),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
````

---

## 🧠 2. Insert Sample Data

### Students

```sql
INSERT INTO students VALUES
(1, 'Alice Johnson', 20, 'Computer Science'),
(2, 'Bob Smith', 21, 'Information Systems'),
(3, 'Charlie Brown', 22, 'Software Engineering'),
(4, 'Diana Lee', 23, 'Data Science'),
(5, 'Ethan Davis', 20, 'Computer Science'),
(6, 'Fiona Clark', 21, 'Information Systems'),
(7, 'George White', 22, 'Data Science'),
(8, 'Hannah Miller', 23, 'Software Engineering');
```

### Courses

```sql
INSERT INTO courses VALUES
(101, 'Database Systems', 'Dr. Smith', 4),
(102, 'Web Development', 'Prof. Lee', 3),
(103, 'Data Structures', 'Dr. Kim', 4),
(104, 'Machine Learning', 'Dr. Allen', 4),
(105, 'Network Security', 'Prof. Carter', 3),
(106, 'Cloud Computing', 'Dr. Taylor', 3);
```

### Enrollments

```sql
INSERT INTO enrollments VALUES
(1, 1, 101, 'A', 'Fall2024'),
(2, 1, 102, 'B', 'Fall2024'),
(3, 2, 103, 'A', 'Fall2024'),
(4, 3, 101, 'B', 'Fall2024'),
(5, 3, 104, 'A', 'Spring2025'),
(6, 4, 104, 'A', 'Spring2025'),
(7, 4, 105, 'B', 'Spring2025'),
(8, 5, 102, 'A', 'Fall2024'),
(9, 6, 103, 'B', 'Fall2024'),
(10, 6, 105, 'A', 'Spring2025'),
(11, 7, 106, 'A', 'Spring2025'),
(12, 8, 104, 'B', 'Spring2025');
```

----

```sql
mysql> use test_db;
Database changed
mysql> show tables;
Empty set (0.002 sec)

mysql> -- Table: students
Query OK, 0 rows affected (0.000 sec)

mysql> CREATE TABLE students (
    ->     student_id INT PRIMARY KEY,
    ->     student_name VARCHAR(50),
    ->     age INT,
    ->     major VARCHAR(50)
    -> );
Query OK, 0 rows affected (0.013 sec)

mysql>
mysql> -- Table: courses
Query OK, 0 rows affected (0.000 sec)

mysql> CREATE TABLE courses (
    ->     course_id INT PRIMARY KEY,
    ->     course_name VARCHAR(50),
    ->     instructor VARCHAR(50),
    ->     credits INT
    -> );
Query OK, 0 rows affected (0.006 sec)

mysql>
mysql> -- Table: enrollments
Query OK, 0 rows affected (0.000 sec)

mysql> CREATE TABLE enrollments (
    ->     enrollment_id INT PRIMARY KEY,
    ->     student_id INT,
    ->     course_id INT,
    ->     grade CHAR(2),
    ->     semester VARCHAR(10),
    ->     FOREIGN KEY (student_id) REFERENCES students(student_id),
    ->     FOREIGN KEY (course_id) REFERENCES courses(course_id)
    -> );
Query OK, 0 rows affected (0.015 sec)

mysql> INSERT INTO students VALUES
    -> (1, 'Alice Johnson', 20, 'Computer Science'),
    -> (2, 'Bob Smith', 21, 'Information Systems'),
    -> (3, 'Charlie Brown', 22, 'Software Engineering'),
    -> (4, 'Diana Lee', 23, 'Data Science'),
    -> (5, 'Ethan Davis', 20, 'Computer Science'),
    -> (6, 'Fiona Clark', 21, 'Information Systems'),
    -> (7, 'George White', 22, 'Data Science'),
    -> (8, 'Hannah Miller', 23, 'Software Engineering');
Query OK, 8 rows affected (0.008 sec)
Records: 8  Duplicates: 0  Warnings: 0

mysql> INSERT INTO courses VALUES
    -> (101, 'Database Systems', 'Dr. Smith', 4),
    -> (102, 'Web Development', 'Prof. Lee', 3),
    -> (103, 'Data Structures', 'Dr. Kim', 4),
    -> (104, 'Machine Learning', 'Dr. Allen', 4),
    -> (105, 'Network Security', 'Prof. Carter', 3),
    -> (106, 'Cloud Computing', 'Dr. Taylor', 3);
Query OK, 6 rows affected (0.003 sec)
Records: 6  Duplicates: 0  Warnings: 0

mysql> INSERT INTO enrollments VALUES
    -> (1, 1, 101, 'A', 'Fall2024'),
    -> (2, 1, 102, 'B', 'Fall2024'),
    -> (3, 2, 103, 'A', 'Fall2024'),
    -> (4, 3, 101, 'B', 'Fall2024'),
    -> (5, 3, 104, 'A', 'Spring2025'),
    -> (6, 4, 104, 'A', 'Spring2025'),
    -> (7, 4, 105, 'B', 'Spring2025'),
    -> (8, 5, 102, 'A', 'Fall2024'),
    -> (9, 6, 103, 'B', 'Fall2024'),
    -> (10, 6, 105, 'A', 'Spring2025'),
    -> (11, 7, 106, 'A', 'Spring2025'),
    -> (12, 8, 104, 'B', 'Spring2025');
Query OK, 12 rows affected (0.003 sec)
Records: 12  Duplicates: 0  Warnings: 0

mysql> select count(*) from students;
+----------+
| count(*) |
+----------+
|        8 |
+----------+
1 row in set (0.001 sec)

mysql> select count(*) from courses;
+----------+
| count(*) |
+----------+
|        6 |
+----------+
1 row in set (0.001 sec)

mysql> select count(*) from enrollments;
+----------+
| count(*) |
+----------+
|       12 |
+----------+
1 row in set (0.001 sec)

mysql> select 8 * 6 *12;
+-----------+
| 8 * 6 *12 |
+-----------+
|       576 |
+-----------+
1 row in set (0.000 sec)
```

###  Joining 3 tables:

select * 
from students, 
     courses, 
     enrollments;

+------------+---------------+------+----------------------+-----------+------------------+--------------+---------+---------------+------------+-----------+-------+------------+
| student_id | student_name  | age  | major                | course_id | course_name      | instructor   | credits | enrollment_id | student_id | course_id | grade | semester   |
+------------+---------------+------+----------------------+-----------+------------------+--------------+---------+---------------+------------+-----------+-------+------------+
|          8 | Hannah Miller |   23 | Software Engineering |       101 | Database Systems | Dr. Smith    |       4 |             1 |          1 |       101 | A     | Fall2024   |
|          8 | Hannah Miller |   23 | Software Engineering |       102 | Web Development  | Prof. Lee    |       3 |             1 |          1 |       101 | A     | Fall2024   |
|          8 | Hannah Miller |   23 | Software Engineering |       103 | Data Structures  | Dr. Kim      |       4 |             1 |          1 |       101 | A     | Fall2024   |
...
|          1 | Alice Johnson |   20 | Computer Science     |       104 | Machine Learning | Dr. Allen    |       4 |            12 |          8 |       104 | B     | Spring2025 |
|          1 | Alice Johnson |   20 | Computer Science     |       105 | Network Security | Prof. Carter |       3 |            12 |          8 |       104 | B     | Spring2025 |
|          1 | Alice Johnson |   20 | Computer Science     |       106 | Cloud Computing  | Dr. Taylor   |       3 |            12 |          8 |       104 | B     | Spring2025 |
+------------+---------------+------+----------------------+-----------+------------------+--------------+---------+---------------+------------+-----------+-------+------------+
576 rows in set (0.002 sec)


SELECT s.student_id AS s_student_id,
       s.student_name AS s_student_name,
       s.age AS s_age,
       s.major AS s_major,
       c.course_id AS c_course_id,
       c.course_name AS c_course_name,
       c.instructor AS c_instructor,
       c.credits AS c_credits,
       e.enrollment_id AS e_enrollment_id,
       e.student_id AS e_student_id,
       e.course_id AS e_course_id,
       e.grade AS e_garde,
       e.semester AS e_semester
FROM
     students s,
     courses c,
     enrollments e;

+--------------+----------------+-------+----------------------+-------------+------------------+--------------+-----------+-----------------+--------------+-------------+---------+------------+
| s_student_id | s_student_name | s_age | s_major              | c_course_id | c_course_name    | c_instructor | c_credits | e_enrollment_id | e_student_id | e_course_id | e_garde | e_semester |
+--------------+----------------+-------+----------------------+-------------+------------------+--------------+-----------+-----------------+--------------+-------------+---------+------------+
|            8 | Hannah Miller  |    23 | Software Engineering |         101 | Database Systems | Dr. Smith    |         4 |               1 |            1 |         101 | A       | Fall2024   |
|            8 | Hannah Miller  |    23 | Software Engineering |         102 | Web Development  | Prof. Lee    |         3 |               1 |            1 |         101 | A       | Fall2024   |
|            8 | Hannah Miller  |    23 | Software Engineering |         103 | Data Structures  | Dr. Kim      |         4 |               1 |            1 |         101 | A       | Fall2024   |
...
|            1 | Alice Johnson  |    20 | Computer Science     |         104 | Machine Learning | Dr. Allen    |         4 |              12 |            8 |         104 | B       | Spring2025 |
|            1 | Alice Johnson  |    20 | Computer Science     |         105 | Network Security | Prof. Carter |         3 |              12 |            8 |         104 | B       | Spring2025 |
|            1 | Alice Johnson  |    20 | Computer Science     |         106 | Cloud Computing  | Dr. Taylor   |         3 |              12 |            8 |         104 | B       | Spring2025 |
+--------------+----------------+-------+----------------------+-------------+------------------+--------------+-----------+-----------------+--------------+-------------+---------+------------+
576 rows in set (0.002 sec)

     

-- Table: enrollments
CREATE TABL

## 🔗 3. Join Examples (10 Queries)

### **1️⃣ Basic INNER JOIN**

List student names with their enrolled course names.

```sql
SELECT s.student_name, c.course_name
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id;
```

---

### **2️⃣ LEFT JOIN**

Show all students and their courses (even if not enrolled).

```sql
SELECT s.student_name, c.course_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id;
```

---

### **3️⃣ RIGHT JOIN**

Show all courses and students (even if no one enrolled).

```sql
SELECT s.student_name, c.course_name
FROM enrollments e
RIGHT JOIN students s ON e.student_id = s.student_id
RIGHT JOIN courses c ON e.course_id = c.course_id;
```

---

### **4️⃣ FULL OUTER JOIN (simulated using UNION)**

Combine LEFT and RIGHT joins to show all students and all courses.

```sql
SELECT s.student_name, c.course_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id

UNION

SELECT s.student_name, c.course_name
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
LEFT JOIN students s ON e.student_id = s.student_id;
```

---

### **5️⃣ Join With WHERE Clause**

Show only students who got grade ‘A’.

```sql
SELECT s.student_name, c.course_name, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE e.grade = 'A';
```

---

### **6️⃣ Using Table Aliases**

Same as above but cleaner syntax.

```sql
SELECT s.student_name, c.course_name, e.grade
FROM students AS s
JOIN enrollments AS e ON s.student_id = e.student_id
JOIN courses AS c ON e.course_id = c.course_id
WHERE e.grade = 'A';
```

---

### **7️⃣ Join and ORDER BY**

List all enrollments sorted by student name.

```sql
SELECT s.student_name, c.course_name, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
ORDER BY s.student_name;
```

---

### **8️⃣ Join with Aggregate Function**

Count how many students are enrolled in each course.

```sql
SELECT c.course_name, COUNT(e.student_id) AS total_students
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY total_students DESC;
```

---

### **9️⃣ Multi-table Join with Condition**

Find all courses taught by “Dr. Smith” and their enrolled students.

```sql
SELECT c.course_name, s.student_name
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
JOIN students s ON e.student_id = s.student_id
WHERE c.instructor = 'Dr. Smith';
```

---

### **🔟 Nested Join (Subquery)**

Show all students enrolled in any course where “Dr. Kim” teaches.

```sql
SELECT s.student_name
FROM students s
WHERE s.student_id IN (
    SELECT e.student_id
    FROM enrollments e
    JOIN courses c ON e.course_id = c.course_id
    WHERE c.instructor = 'Dr. Kim'
);
```

---

## ✅ Summary

| Join Type       | Purpose                                 |
| --------------- | --------------------------------------- |
| INNER JOIN      | Match only related records              |
| LEFT JOIN       | Keep all from left table                |
| RIGHT JOIN      | Keep all from right table               |
| FULL OUTER JOIN | Show all data (union of left + right)   |
| SELF JOIN       | Table joined to itself (not shown here) |

---


```

