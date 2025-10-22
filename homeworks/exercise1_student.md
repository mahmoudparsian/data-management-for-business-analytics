# MySQL Exercise

## Schema and Sample Data

```sql
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(30),
    age INT,
    major VARCHAR(30),
    country VARCHAR(10)
);

INSERT INTO students 
VALUES
(1, 'Alice', 20, 'Computer Science', 'USA'),
(2, 'Bob', 21, 'Mathematics', 'USA'),
(3, 'Charlie', 22, 'Physics', 'USA'),
(4, 'David', 23, 'Computer Science', 'USA'),
(5, 'Eva', 21, 'Biology', 'USA'),
(6, 'Alex', 20, 'Computer Science', 'CANADA'),
(7, 'Jane', 21, 'Mathematics', 'CANADA'),
(8, 'Dara', 23, 'Computer Science', 'CANADA');
```

## Questions
1. create a new database called homework1
2. Use the created database, and then create the "students" table and populate it with the given valuers.
3. Select all rows from the students table.
4. Select only the names of all students.
5. Select students who are majoring in 'Computer Science'.
6. Select students older than 21.
7. Select all students ordered by age descending.
8. Count the number of students in the table.
9. Find distinct majors from the students table.
10. Find the number of students per country

