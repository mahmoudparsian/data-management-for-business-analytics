# Week 3 Assignment – Filtering & WHERE (12 Tasks)

## Schema
```sql
DROP TABLE IF EXISTS employees_filter;
CREATE TABLE employees_filter (
  emp_id INT PRIMARY KEY,
  name VARCHAR(40),
  dept VARCHAR(30),
  age INT,
  salary DECIMAL(10,2),
  hire_date DATE,
  bonus DECIMAL(10,2) NULL
);
```

## Sample Data
```sql
INSERT INTO employees_filter VALUES
(1,'Alice','HR',31,70000,'2021-03-10',NULL),
(2,'Bob','Engineering',40,120000,'2020-11-05',5000),
(3,'Carol','Sales',29,65000,'2022-06-15',NULL),
(4,'Dan','Engineering',45,135000,'2020-01-20',10000),
(5,'Eva','Marketing',33,80000,'2023-02-11',NULL),
(6,'Frank','Sales',38,90000,'2021-07-01',3000);
```

## Tasks
1) Employees in `Engineering`.  
2) Employees not in `Sales`.  
3) Employees with salary > 90k.  
4) Employees hired after `2021-01-01`.  
5) Employees with `bonus IS NULL`.  
6) Employees with `bonus IS NOT NULL`.  
7) Employees age between 30 and 40.  
8) Names containing `'a'` (case-insensitive).  
9) Employees in (`HR`,`Marketing`) ordered by age.  
10) Top 2 highest salaries in `Engineering`.  
11) Count employees with `bonus`.  
12) Average salary of `Sales`.
