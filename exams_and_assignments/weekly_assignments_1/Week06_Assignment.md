# Week 6 Assignment – Subqueries & WITH (12 Tasks)

## Schema
```sql
DROP TABLE IF EXISTS depts;
DROP TABLE IF EXISTS emps;
CREATE TABLE depts (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(40)
);
CREATE TABLE emps (
  emp_id INT PRIMARY KEY,
  name VARCHAR(40),
  dept_id INT,
  salary DECIMAL(10,2),
  FOREIGN KEY (dept_id) REFERENCES depts(dept_id)
);
```

## Sample Data
```sql
INSERT INTO depts VALUES
(10,'Engineering'),(20,'Sales'),(30,'HR');

INSERT INTO emps VALUES
(1,'Alice',10,120000),
(2,'Bob',10,90000),
(3,'Carol',20,80000),
(4,'Dan',20,95000),
(5,'Eva',30,70000);
```

## Tasks
1) Employees earning above overall average salary (subquery).  
2) Departments with avg salary > 90k (subquery + GROUP BY).  
3) For each department, list employees whose salary > dept average (correlated).  
4) Count of employees per department using a subquery in FROM.  
5) Use `WITH` to compute dept averages, then select employees above that.  
6) Highest-paid employee per department (subquery with MAX).  
7) Departments with at least 2 employees (subquery with HAVING).  
8) Employees in departments that have someone earning > 100k.  
9) Departments with no employees (anti-join via NOT EXISTS).  
10) Employees whose salary is in the top 2 overall (LIMIT in subquery).  
11) Reuse a CTE to compute global average and list above-average employees.  
12) Show department and number of employees using a CTE, then filter count >= 2.
