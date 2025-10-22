# MySQL 101 Lab Exercise Sheet

## Sample Schema

We will create a simple database called **school** with one table **students**.

```sql
CREATE DATABASE school;
USE school;

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT,
    grade VARCHAR(5),
    country VARCHAR(30)
);
```

### Insert Sample Data

```sql
INSERT INTO students VALUES 
(1, 'Alice', 20, 'A', 'USA'),
(2, 'Bob', 22, 'B', 'CANADA'),
(3, 'Charlie', 21, 'A', 'USA'),
(4, 'Diana', 23, 'C', 'GERMANY'),
(5, 'Ethan', 20, 'B', 'MEXICO'),
(6, 'Fiona', 22, 'A', 'USA'),
(7, 'George', 24, 'B', 'ITALY'),
(8, 'Hannah', 21, 'C', 'USA'),
(9, 'Ivan', 23, 'A', 'CANADA'),
(10, 'Julia', 22, 'B', 'GERMANY');
```

---

## Lab Queries (20 Practice Questions)

**1. Show all records in the students table**
```sql
SELECT * FROM students;
```

**2. Show only the names and ages of students**
```sql
SELECT name, age FROM students;
```

**3. Find all students from USA**
```sql
SELECT * FROM students WHERE country='USA';
```

**4. Find students older than 22**
```sql
SELECT * FROM students WHERE age > 22;
```

**5. Sort students by age ascending**
```sql
SELECT * FROM students ORDER BY age ASC;
```

**6. Sort students by name descending**
```sql
SELECT * FROM students ORDER BY name DESC;
```

**7. Show first 5 students**
```sql
SELECT * FROM students LIMIT 5;
```

**8. Find distinct countries**
```sql
SELECT DISTINCT country FROM students;
```

**9. Count how many students are in the table**
```sql
SELECT COUNT(*) FROM students;
```

**10. Find the average age of students**
```sql
SELECT AVG(age) FROM students;
```

**11. Find the youngest student**
```sql
SELECT * FROM students ORDER BY age ASC LIMIT 1;
```

**12. Find the oldest student**
```sql
SELECT * FROM students ORDER BY age DESC LIMIT 1;
```

**13. Find number of students per grade**
```sql
SELECT grade, COUNT(*) FROM students GROUP BY grade;
```

**14. Find number of students per country**
```sql
SELECT country, COUNT(*) FROM students GROUP BY country;
```

**15. Find students with grade A**
```sql
SELECT * FROM students WHERE grade='A';
```

**16. Update Bob’s grade to A**
```sql
UPDATE students SET grade='A' WHERE name='Bob';
```

**17. Delete student with id=10**
```sql
DELETE FROM students WHERE id=10;
```

**18. Add a new student (id=11, Kate, 21, grade B, from USA)**
```sql
INSERT INTO students VALUES (11,'Kate',21,'B','USA');
```

**19. Show students who are 20 or 21 years old**
```sql
SELECT * FROM students WHERE age IN (20,21);
```

**20. Find average age per country**
```sql
SELECT country, AVG(age) FROM students GROUP BY country;
```

