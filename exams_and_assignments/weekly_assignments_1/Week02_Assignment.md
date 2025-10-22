# Week 2 Assignment – SELECT, Aliases, Expressions (12 Tasks)

## Schema
```sql
DROP TABLE IF EXISTS employees_basic;
CREATE TABLE employees_basic (
  emp_id INT PRIMARY KEY,
  name VARCHAR(40),
  age INT,
  salary DECIMAL(10,2)
);
```

## Sample Data
```sql
INSERT INTO employees_basic VALUES
(1,'Ava',28,72000),(2,'Noah',35,88000),
(3,'Emma',41,105000),(4,'Liam',30,78000),
(5,'Olivia',29,76000),(6,'Ethan',45,116000);
```

## Tasks

1) Select all columns.  
2) Select name and salary only.  
3) Show name and a 10% raise as `new_salary`.  
4) Show `name` as `employee_name` (alias).  
5) Show **distinct** ages.  
6) Order by salary descending.  
7) Top 3 highest salaries.  
8) Show employees with salary between 75k and 100k.  
9) Show employees older than 40.  
10) Show names that start with 'E'.  
11) Concatenate name and age as `"name (age)"`.  
12) Round salary to nearest integer as `salary_rounded`.
