# MySQL Exercise

## Schema and Sample Data

```sql
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(30)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(30),
    dept_id INT,
    salary INT,
    country VARCHAR(10)
);

INSERT INTO departments VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Business'),
(6, 'AI');


INSERT INTO employees(emp_id,name, dept_id, salary, country) VALUES
(101, 'Alice', 1, 5000, 'USA'),
(102, 'Bob', 2, 6000, 'USA'),
(103, 'Charlie', 2, 5500, 'USA'),
(104, 'David', 3, 7000, 'USA'),
(105, 'Eva', NULL, 4000, 'FRANCE'),
(106, 'Jeff', 1, 5000, 'FRANCE'),
(107, 'Carlos', 2, 6000, 'MEXICO'),
(108, 'Rafa', 2, 5500, 'MEXICO'),
(109, 'Roger', 4, 7000, 'CANADA'),
(110, 'Ed', NULL, 4000, 'CANADA'),
(111, 'Max', NULL, 8000, 'CANADA'),
(112, 'Terry', NULL, 9000, 'CANADA');
```


## Questions
1. Select all employees and their departments using INNER JOIN.
2. Select all employees and their departments using LEFT JOIN.
3. Select all departments and their employees using RIGHT JOIN.
4. Find employees without departments (dept_id IS NULL).
5. Find employees who work in IT department.
6. Count employees per department 
7. Find maximum salary among employees.
8. Find departments without employees
9. Count employees per country 
10. Find higest-paid employee per country
