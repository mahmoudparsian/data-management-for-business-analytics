## 🟠 Advanced INTERMEDIATE+ QUERIES (JOIN, GROUP, FILTERING)

### 1. Employees who worked on more than 2 projects

```sql
SELECT e.name, COUNT(w.project_id) AS total_projects
FROM employees e
JOIN workdays w ON e.emp_id = w.emp_id
GROUP BY e.name
HAVING total_projects > 2;
```

### 2. Departments with more than 4 employees

solution-1: by `dept_id`

```sql
SELECT dept_id, 
       COUNT(*) AS emp_count
FROM employees 
GROUP BY dept_id
HAVING emp_count > 4;
```

solution-2: by `dept_name`

```sql
SELECT d.dept_name, COUNT(e.emp_id) AS emp_count
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name
HAVING emp_count > 4;
```

### 3. Projects where more than 5 employees worked

```sql
SELECT p.project_name, COUNT(w.emp_id) AS emp_count
FROM projects p
JOIN workdays w ON p.project_id = w.project_id
GROUP BY p.project_name
HAVING emp_count > 5;
```

### 4. List employees and how many different projects they worked on

```sql
SELECT e.name, COUNT(DISTINCT w.project_id) AS project_count
FROM employees e
JOIN workdays w ON e.emp_id = w.emp_id
GROUP BY e.name;
```

### 5. Employees who never worked on any project

solution: by LEFT JOIN

```sql
SELECT e.name
FROM employees e
LEFT JOIN workdays w ON e.emp_id = w.emp_id
WHERE w.project_id IS NULL;
```

### 6. Departments and total projects their employees worked on

```sql
SELECT d.dept_name, COUNT(DISTINCT w.project_id) AS total_projects
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
JOIN workdays w ON e.emp_id = w.emp_id
GROUP BY d.dept_name;
```

### 7. Number of employees from each country

```sql
SELECT country, COUNT(*) AS total
FROM employees
GROUP BY country
ORDER BY total DESC;
```

### 8. Employees working on project “Sales Dashboard” and from USA

```sql
SELECT e.name
FROM employees e
JOIN workdays w ON e.emp_id = w.emp_id
JOIN projects p ON p.project_id = w.project_id
WHERE p.project_name = 'Sales Dashboard'
AND e.country = 'USA';
```

### 9. Employees whose age is above the average age of all employees

```sql
SELECT name, age
FROM employees
WHERE age > (SELECT AVG(age) FROM employees);
```

### 10. Projects with earliest start date

```sql
SELECT p.project_name, MIN(w.start_date) AS earliest_start
FROM projects p
JOIN workdays w ON p.project_id = w.project_id
GROUP BY p.project_name
ORDER BY earliest_start ASC
LIMIT 1;
```

---

## 🔵 10 ADVANCED QUERIES (WITH + RANKING)

> **Note:** MySQL 8+ supports `WITH` and window functions
> like `ROW_NUMBER`, `RANK`, `DENSE_RANK`.

### 1. Rank employees by age (oldest first)

```sql
WITH age_rank AS 
(
  SELECT name, 
         age,
         RANK() OVER (ORDER BY age DESC) AS age_rank
  FROM employees
)
SELECT * FROM age_rank;
```

### 2. Rank departments by total employee count

```sql
WITH dept_counts AS 
(
  SELECT d.dept_name, COUNT(e.emp_id) AS emp_count
  FROM departments d
  JOIN employees e ON d.dept_id = e.dept_id
  GROUP BY d.dept_name
)
SELECT dept_name, 
       emp_count,
       RANK() OVER (ORDER BY emp_count DESC) AS dept_rank
FROM dept_counts;
```

### 3. Rank employees by number of projects

```sql
WITH emp_projects AS 
(
  SELECT e.emp_id, e.name, COUNT(w.project_id) AS project_count
  FROM employees e
  JOIN workdays w ON e.emp_id = w.emp_id
  GROUP BY e.emp_id, e.name
)
SELECT name, 
       project_count,
       RANK() OVER (ORDER BY project_count DESC) AS project_rank
FROM emp_projects;
```

### 4. Top 3 employees with most projects

```sql
WITH emp_projects AS (
  SELECT e.emp_id, e.name, COUNT(w.project_id) AS project_count
  FROM employees e
  JOIN workdays w ON e.emp_id = w.emp_id
  GROUP BY e.emp_id, e.name
)
SELECT name, project_count
FROM emp_projects
ORDER BY project_count DESC
LIMIT 3;
```

### 5. Top 3 departments with the highest average age

```sql
WITH dept_age AS 
(
  SELECT d.dept_name, 
         AVG(e.age) AS avg_age
  FROM departments d
  JOIN employees e ON d.dept_id = e.dept_id
  GROUP BY d.dept_name
)
SELECT dept_name, avg_age
FROM dept_age
ORDER BY avg_age DESC
LIMIT 3;
```

### 6. Employees ranked by years of service

```sql
WITH years AS 
(
  SELECT name,
         YEAR(CURDATE()) - YEAR(hire_date) AS years_service
  FROM employees
)
SELECT name, 
       years_service,
       RANK() OVER (ORDER BY years_service DESC) AS service_rank
FROM years;
```

### 7. Find average number of projects per department

```sql
WITH dept_proj AS 
(
  SELECT d.dept_name, 
         COUNT(DISTINCT w.project_id) AS total_projects
  FROM departments d
  JOIN employees e ON d.dept_id = e.dept_id
  JOIN workdays w ON e.emp_id = w.emp_id
  GROUP BY d.dept_name
)
SELECT dept_name, 
       total_projects,
       AVG(total_projects) OVER () AS avg_projects_overall
FROM dept_proj;
```

### 8. Rank projects by total employees assigned

```sql
WITH proj_count AS 
(
  SELECT p.project_name, 
         COUNT(w.emp_id) AS emp_count
  FROM projects p
  JOIN workdays w ON p.project_id = w.project_id
  GROUP BY p.project_name
)
SELECT project_name, 
       emp_count,
       RANK() OVER (ORDER BY emp_count DESC) AS project_rank
FROM proj_count;
```

### 9. Employees who are in top 5 oldest or top 5 longest serving

```sql
WITH age_rank AS 
(
  SELECT emp_id, 
         name,
         RANK() OVER (ORDER BY age DESC) AS age_rank
  FROM employees
),
service_rank AS 
(
  SELECT emp_id, 
         name,
         RANK() OVER (ORDER BY YEAR(CURDATE()) - YEAR(hire_date) DESC) AS service_rank
  FROM employees
)
SELECT DISTINCT a.name
FROM age_rank a
JOIN service_rank s ON a.emp_id = s.emp_id
WHERE a.age_rank <= 5 OR s.service_rank <= 5;
```

### 10. Department and employee rankings combined

```sql
WITH dept_emp_count AS 
(
  SELECT d.dept_name, 
         COUNT(e.emp_id) AS emp_count
  FROM departments d
  JOIN employees e ON d.dept_id = e.dept_id
  GROUP BY d.dept_name
),
dept_ranked AS 
(
  SELECT dept_name, 
         emp_count,
         RANK() OVER (ORDER BY emp_count DESC) AS dept_rank
  FROM dept_emp_count
)
SELECT * FROM dept_ranked;
```

---


## 11. Employees not assigned to any projects

Here we want employees that do not appear in the workdays table.

#### Option A — LEFT JOIN

```sql
SELECT e.emp_id, e.name
FROM employees e
LEFT JOIN workdays w ON e.emp_id = w.emp_id
WHERE w.emp_id IS NULL;
```

👉 Explanation:

	•	LEFT JOIN keeps all employees.
	•	If no matching row exists in workdays, then w.emp_id is NULL.
	•	Those are the employees with no projects.

#### Option B — NOT EXISTS

```sql
SELECT e.emp_id, e.name
FROM employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM workdays w
    WHERE w.emp_id = e.emp_id
);
```

## 12. Departments with no employees assigned

Here we want departments that do not appear in the employees table.

Option A — LEFT JOIN

```sql
SELECT d.dept_id, d.dept_name
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
WHERE e.dept_id IS NULL;
```

👉 Explanation:

	•	LEFT JOIN keeps all departments.
	•	If no employee has that dept_id, then e.dept_id is NULL.
	•	Those are the “empty” departments.

⸻

Option B — NOT EXISTS

```sql
SELECT d.dept_id, d.dept_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.dept_id = d.dept_id
);
```

## 13. write a SQL query to find projects, which have not been assigned to any employees

Perfect 👌 Now we want projects that do not appear in 
the workdays table (meaning no employees are assigned).

⸻

✅ Query Option A — LEFT JOIN

```sql
SELECT p.project_id, 
       p.project_name
FROM projects p
LEFT JOIN workdays w ON p.project_id = w.project_id
WHERE w.project_id IS NULL;
```

	•	LEFT JOIN ensures all projects are included.
	•	If a project has no row in workdays, w.project_id will be NULL.
	•	Those are the unassigned projects.

⸻

✅ Query Option B — NOT EXISTS

```sql
SELECT p.project_id, p.project_name
FROM projects p
WHERE NOT EXISTS (
    SELECT 1
    FROM workdays w
    WHERE w.project_id = p.project_id
);
```
