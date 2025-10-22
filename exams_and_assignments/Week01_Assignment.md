# Week 1 Assignment – MySQL Basics (15 Tasks)

> Theme: tables, rows, columns, basic SELECT/INSERT/UPDATE/DELETE

## Schema (run these first)
```sql
DROP TABLE IF EXISTS students;
CREATE TABLE students (
  id INT PRIMARY KEY,
  name VARCHAR(40),
  age INT,
  major VARCHAR(40)
);
```

## Sample Data
```sql
INSERT INTO students (id, name, age, major) 
VALUES
(1,'Alice',20,'CS'),
(2,'Bob',22,'Business'),
(3,'Carol',21,'Math'),
(4,'Dan',23,'CS'),
(5,'Eva',20,'Economics'),
(6,'Frank',24,'CS'),
(7,'David',23,'CS'),
(8,'Ed',20,'Economics'),
(9,'Jenny',24,'CS'),
(10,'Rafa',23,'CS'),
(11,'Carlos',29,'Business'),
(12,'Dara',41,'Math'),
(13,'Max',20,'Economics'),
(14,'Mia',24,'Business'),
(15,'Carlitos',23,'CS');

```

## Tasks: write SQL for each and show output

1) Show all students.  
2) Show only `name, age`.  
3) Count how many students there are.  
4) List distinct majors.  
5) Find students in the `CS` major.  
6) Find students younger than 22.  
7) Order students by age descending.  
8) Show the **3 youngest** students.  
9) Add a new student: `(7, 'Grace', 22, 'Math')`.  
10) Update student `Bob`’s major to `'Economics'`.  
11) Delete student with `id = 6`.  
12) Explain in one line what a **primary key** is (no SQL needed).
13) Show the **3 oldest** students.  
14) Find the number of students per major.
15) Find the number of students per age.