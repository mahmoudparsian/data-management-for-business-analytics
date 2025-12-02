# SQL Subqueries Examples (Simple → Intermediate)

## Updated Schema

```sql
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(30),
    location VARCHAR(30)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(40),
    dept_id INT,
    salary INT,
    country VARCHAR(20),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    emp_id INT,
    project_name VARCHAR(50),
    budget INT,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);
```

## Sample Data

```sql
INSERT INTO departments VALUES
(10, 'Engineering', 'New York'),
(20, 'Marketing',   'Toronto'),
(30, 'HR',          'Chicago');

INSERT INTO employees VALUES
(1, 'Alice', 10, 130000, 'USA'),
(2, 'Bob',   10, 90000,  'USA'),
(3, 'Carol', 20, 95000,  'Canada'),
(4, 'David', 20, 120000, 'USA'),
(5, 'Eve',   30, 70000,  'USA');

INSERT INTO projects VALUES
(101, 1, 'AI Platform',     500000),
(102, 2, 'Data Pipeline',   200000),
(103, 3, 'Ad Campaign',     150000),
(104, 4, 'Brand Refresh',   300000),
(105, 1, 'Search Engine',   400000);
```

---

# 10 SQL Subquery Examples

## 1. Employees earning more than average salary

```sql
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

---

## 2. Employees in departments located in New York

```sql
SELECT e.name, e.dept_id
FROM employees e
WHERE e.dept_id IN (
    SELECT dept_id 
    FROM departments 
    WHERE location = 'New York'
);
```

---

## 3. Highest salary in Engineering

```sql
SELECT MAX(salary)
FROM employees
WHERE dept_id = (
    SELECT dept_id 
    FROM departments 
    WHERE dept_name = 'Engineering'
);
```

---

## 4. Employees earning more than lowest salary in Marketing

```sql
SELECT *
FROM employees
WHERE salary > (
    SELECT MIN(salary)
    FROM employees
    WHERE dept_id = (
        SELECT dept_id FROM departments WHERE dept_name = 'Marketing'
    )
);
```

---

## 5. Count employees above department average

```sql
SELECT COUNT(*)
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE dept_id = e.dept_id
);
```

---

## 6. Projects above average budget
```sql
SELECT project_name, 
       budget
FROM projects
WHERE budget > (
    SELECT AVG(budget)
    FROM projects
);
```

---

## 7. Employees with at least one project

```sql
SELECT *
FROM employees
WHERE emp_id IN (SELECT emp_id FROM projects);
```

---

## 8. Department with highest average salary

```sql
SELECT dept_id
FROM employees
GROUP BY dept_id
HAVING AVG(salary) = (
    SELECT MAX(avg_sal)
    FROM (
        SELECT dept_id, 
               AVG(salary) AS avg_sal
        FROM employees
        GROUP BY dept_id
    ) AS t
);
```

---

## 9. Employee working on highest-budget project
```sql
SELECT name
FROM employees
WHERE emp_id = (
    SELECT emp_id
    FROM projects
    ORDER BY budget DESC
    LIMIT 1
);
```

---

## 10. Employees earning above average salary 

```sql
SELECT emp_id, name, dept_id, salary, country
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
ORDER BY salary DESC;
```

### CTE Version:

```sql
WITH avg_sal AS (
    SELECT AVG(salary) AS avg_salary
    FROM employees
)
SELECT 
    e.emp_id,
    e.name,
    e.dept_id,
    e.salary,
    e.country
FROM employees e
JOIN avg_sal a
    ON e.salary > a.avg_salary;
```

---

