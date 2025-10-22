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

## Answers
1. SELECT e.name, d.dept_name FROM employees e INNER JOIN departments d ON e.dept_id = d.dept_id;
2. SELECT e.name, d.dept_name FROM employees e LEFT JOIN departments d ON e.dept_id = d.dept_id;
3. SELECT e.name, d.dept_name FROM employees e RIGHT JOIN departments d ON e.dept_id = d.dept_id;
4. SELECT * FROM employees WHERE dept_id IS NULL;
5. SELECT e.name FROM employees e JOIN departments d ON e.dept_id = d.dept_id WHERE d.dept_name = 'IT';
6. SELECT d.dept_name, COUNT(*) FROM employees e JOIN departments d ON e.dept_id = d.dept_id GROUP BY d.dept_name;
7. SELECT MAX(salary) FROM employees;

#### 8-Find departments without employees: 3 solutions:

8-solution-1: Using LEFT JOIN + WHERE ... IS NULL

✅ Explanation:

	•	LEFT JOIN keeps all departments.
	•	Departments without matching employees will have NULL in e.emp_id.
	•	Filter them with WHERE e.emp_id IS NULL.
	
```
SELECT d.dept_id, d.dept_name
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL;
```

8-solution-2: Using NOT EXISTS

✅ Explanation:

	•	For each department, check if no employee exists with the same dept_id.
	
```
SELECT d.dept_id, d.dept_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1 
    FROM employees e
    WHERE e.dept_id = d.dept_id
);
```

8-solution-3: Using NOT IN

✅ Explanation:

		•	Select all dept_ids from employees.
		•	Pick only departments whose dept_id is not in that list.
	
```
SELECT d.dept_id, d.dept_name
FROM departments d
WHERE d.dept_id NOT IN (
    SELECT DISTINCT dept_id 
    FROM employees 
    WHERE dept_id IS NOT NULL
);
```


#### 9. Count employees per country 

```
select 
       country, 
       count(*) as emp_count
from   
       employees
group by
       country;
```


#### 10. Find higest-paid employee per country

```
select 
       country, 
       MAX(salary) as highest_paid
from   
       employees
group by
       country;
```
