# Week 1 – Instructor Solutions

## Answers

1) Show all students.  

```sql
SELECT * 
FROM students;
```

2) Show only `name, age`.  

```sql
SELECT name, age 
FROM students;
```

3) Count how many students there are. 
 
```sql
SELECT COUNT(*) AS total_students 
FROM students;
```


4) List distinct majors. 
 
```sql
SELECT DISTINCT major 
FROM students;
```


5) Find students in the `CS` major.  

```sql
SELECT * FROM students 
WHERE major='CS';
```


6) Find students younger than 22.  

```sql
SELECT * FROM students 
WHERE age < 22;
```


7) Order students by age descending.  

```sql
SELECT * 
FROM students 
ORDER BY age DESC;
```

8) Show the **3 youngest** students.  

```sql
SELECT * 
FROM students 
ORDER BY age ASC, id ASC 
LIMIT 3;
```

9) Add a new student. 
 
```sql
INSERT INTO students 
VALUES 
(17, 'Grace', 22, 'Math');
```

10) Update Bob’s major.  

```sql
UPDATE students 
SET major='Economics' 
WHERE name='Bob';
```

11) Delete student with id=6. 
 
```sql
DELETE FROM students 
WHERE id=6;
```

12) Primary key definition:  

*A column (or set of columns) whose values uniquely identify each row and cannot be NULL.*

13) Show the **3 oldest** students.  

```sql
SELECT * 
FROM students 
ORDER BY age DESC, id ASC 
LIMIT 3;
```

14) Find the number of students per major

```sql
SELECT major, count(*) as students_per_major 
FROM students 
GROUP BY major;
```

15) Find the number of students per age

```sql
SELECT age, count(*) as students_per_age
FROM students 
GROUP BY age;
```