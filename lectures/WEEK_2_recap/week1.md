
# Week 1: SQL Fundamentals
*Generated on 2025-11-10*

## Learning Goals
- Understand tables, rows, columns
- Create tables with PRIMARY KEY and FOREIGN KEY
- Basic SELECT, WHERE, ORDER BY, LIMIT
- Simple INSERTs and SELECTs

## Concepts + Examples

### Creating Tables
```sql
CREATE TABLE demo_students (
  student_id INT PRIMARY KEY,
  name VARCHAR(60),
  age INT
);
```

### INSERT + SELECT
```sql
INSERT INTO demo_students VALUES (1, 'Ada', 20), (2, 'Linus', 22);
SELECT * FROM demo_students;
```

### WHERE
```sql
SELECT * FROM demo_students
WHERE age >= 21;
```

### ORDER BY + LIMIT
```sql
SELECT * FROM demo_students
ORDER BY name ASC
LIMIT 1;
```

### FROM (multiple tables next week)
We start with single-table queries this week. Joins come in Week 2.

## Hands-on using module_db
After running `module_tables.sql`, try:

```sql
-- All students
SELECT student_id, name, country, age FROM students;

-- Students from USA older than 21
SELECT name, age FROM students
WHERE country = 'USA' AND age > 21
ORDER BY age DESC;

-- Top 3 youngest students
SELECT name, age FROM students
ORDER BY age ASC
LIMIT 3;
```

## Quick Exercises (Week 1)
1. List all department names alphabetically.  
2. Show the 5 oldest students, with name and age.  
3. List all courses in the 'Mathematics' department.  
4. Find all students from GERMANY or FRANCE.  
5. Show students whose names start with 'A' or 'B'.  

*(Answers in Teacher Key)*
