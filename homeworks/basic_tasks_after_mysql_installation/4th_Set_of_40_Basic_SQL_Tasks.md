# 40 Basic Tasks After Installing MySQL

OK, I just installed mysql on my macbook, can you provide 
a first set of tasks to do to learn sql command. provide 
40 basic tasks (provide a complete SQL queries) with a 
database, sample tables with some rows , and sql queries 
of basic and intermediate, and may be some sub-queries 
using "WITH" and ranking functions

Let’s kick off your SQL journey with a hands-on learning set. 
You’ll create a database, populate it with sample data, and 
run 40 progressively challenging SQL queries—from basic SELECTs 
to intermediate joins, subqueries, and ranking functions.

---

## 🏗️ Step 1: Create the Database and Tables

```sql
CREATE DATABASE company;
USE company;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    dept_id INT,
    salary INT,
    hire_date DATE,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    dept_id INT,
    budget INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
```

---

## 📥 Step 2: Insert Sample Data

```sql
INSERT INTO departments VALUES
(1, 'HR', 'New York'),
(2, 'Engineering', 'San Francisco'),
(3, 'Marketing', 'Chicago');

INSERT INTO employees VALUES
(101, 'Alice', 1, 60000, '2020-01-15'),
(102, 'Bob', 2, 80000, '2019-03-22'),
(103, 'Charlie', 2, 75000, '2021-07-10'),
(104, 'Diana', 3, 65000, '2022-05-01'),
(105, 'Eve', 1, 62000, '2023-02-17');

INSERT INTO projects VALUES
(201, 'Recruitment Drive', 1, 10000),
(202, 'AI Platform', 2, 150000),
(203, 'Ad Campaign', 3, 50000);
```

---

## ✅ Step 3: 40 SQL Tasks with Full Queries

### 🔹 Basic SELECT Queries (1–10)

```sql
-- 1. List all employees
SELECT * FROM employees;

-- 2. Show names and salaries
SELECT name, salary FROM employees;

-- 3. Employees in HR
SELECT * FROM employees WHERE dept_id = 1;

-- 4. Employees hired after 2021
SELECT * FROM employees WHERE hire_date > '2021-12-31';

-- 5. Count total employees
SELECT COUNT(*) FROM employees;

-- 6. Average salary
SELECT AVG(salary) AS avg_salary FROM employees;

-- 7. Highest salary
SELECT MAX(salary) AS highest_salary FROM employees;

-- 8. Lowest salary
SELECT MIN(salary) AS lowest_salary FROM employees;

-- 9. List departments
SELECT * FROM departments;

-- 10. Projects with budget > 50000
SELECT * FROM projects WHERE budget > 50000;
```

---

### 🔹 Filtering & Sorting (11–20)

```sql
-- 11. Employees with salary > 70000
SELECT * FROM employees WHERE salary > 70000;

-- 12. Employees sorted by hire date
SELECT * FROM employees ORDER BY hire_date;

-- 13. Top 3 highest-paid employees
SELECT * FROM employees ORDER BY salary DESC LIMIT 3;

-- 14. Employees not in Engineering
SELECT * FROM employees WHERE dept_id != 2;

-- 15. Projects sorted by budget descending
SELECT * FROM projects ORDER BY budget DESC;

-- 16. Departments in New York or Chicago
SELECT * FROM departments WHERE location IN ('New York', 'Chicago');

-- 17. Employees hired in 2023
SELECT * FROM employees WHERE YEAR(hire_date) = 2023;

-- 18. Employees whose name starts with 'A'
SELECT * FROM employees WHERE name LIKE 'A%';

-- 19. Projects with budget between 10000 and 100000
SELECT * FROM projects WHERE budget BETWEEN 10000 AND 100000;

-- 20. Employees ordered by name
SELECT * FROM employees ORDER BY name;
```

---

### 🔹 Aggregation & Grouping (21–25)

```sql
-- 21. Count employees per department
SELECT dept_id, COUNT(*) AS num_employees FROM employees GROUP BY dept_id;

-- 22. Average salary per department
SELECT dept_id, AVG(salary) AS avg_salary FROM employees GROUP BY dept_id;

-- 23. Total budget per department
SELECT dept_id, SUM(budget) AS total_budget FROM projects GROUP BY dept_id;

-- 24. Number of projects per department
SELECT dept_id, COUNT(*) AS num_projects FROM projects GROUP BY dept_id;

-- 25. Max salary per department
SELECT dept_id, MAX(salary) AS max_salary FROM employees GROUP BY dept_id;
```

---

### 🔹 Joins (26–30)

```sql
-- 26. Employees with department names
SELECT e.name, d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

-- 27. Projects with department names
SELECT p.project_name, d.dept_name
FROM projects p
JOIN departments d ON p.dept_id = d.dept_id;

-- 28. Employees with department location
SELECT e.name, d.location
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

-- 29. Projects with department location
SELECT p.project_name, d.location
FROM projects p
JOIN departments d ON p.dept_id = d.dept_id;

-- 30. Employees working on projects (via dept_id)
SELECT e.name, p.project_name
FROM employees e
JOIN projects p ON e.dept_id = p.dept_id;
```

---

### 🔹 Subqueries & WITH Clauses (31–35)

```sql
-- 31. Employees earning more than average salary
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 32. Departments with more than 1 project
SELECT * FROM departments
WHERE dept_id IN (
  SELECT dept_id FROM projects GROUP BY dept_id HAVING COUNT(*) > 1
);

-- 33. Employees hired before earliest Engineering hire
SELECT * FROM employees
WHERE hire_date < (
  SELECT MIN(hire_date) FROM employees WHERE dept_id = 2
);

-- 34. Projects with budget above department average
SELECT * FROM projects p
WHERE budget > (
  SELECT AVG(budget) FROM projects WHERE dept_id = p.dept_id
);

-- 35. WITH: Top 2 salaries per department
WITH ranked_salaries AS (
  SELECT emp_id, name, dept_id, salary,
         RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rnk
  FROM employees
)
SELECT * FROM ranked_salaries WHERE rnk <= 2;
```

---

### 🔹 Ranking & Window Functions (36–40)

```sql
-- 36. Rank employees by salary
SELECT name, salary,
       RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

-- 37. Dense rank employees by salary
SELECT name, salary,
       DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank
FROM employees;

-- 38. Row number by department
SELECT name, dept_id,
       ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY hire_date) AS row_num
FROM employees;

-- 39. Cumulative salary per department
SELECT name, dept_id, salary,
       SUM(salary) OVER (PARTITION BY dept_id ORDER BY hire_date) AS cumulative_salary
FROM employees;

-- 40. Salary vs department average
SELECT name, dept_id, salary,
       AVG(salary) OVER (PARTITION BY dept_id) AS avg_dept_salary,
       salary - AVG(salary) OVER (PARTITION BY dept_id) AS salary_diff
FROM employees;
```

---

