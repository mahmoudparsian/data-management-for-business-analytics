# 46 Intermediate SQL Queries

### 1. Count employees in each department. 

```sql
SELECT d.dept_name, 
       COUNT(e.emp_id) AS emp_count 
FROM departments d 
LEFT JOIN employees e ON d.dept_id = e.dept_id 
GROUP BY d.dept_name;
```

### 2. Average age of employees per department. 

solution-1: use `dep_id`

```sql
SELECT dept_id, AVG(age) AS avg_age 
FROM employees 
GROUP BY dept_id;
```

solution-2: use `dep_name`

```sql
SELECT d.dept_name, AVG(e.age) AS avg_age 
FROM departments d 
JOIN employees e ON d.dept_id = e.dept_id 
GROUP BY d.dept_name;
```

### 3. Count employees per country. 

solution-1:

```sql
SELECT country, 
       COUNT(*)  
FROM employees 
GROUP BY country;
```

solution-2:

```sql
SELECT country, 
       COUNT(*) AS count_per_country 
FROM employees 
GROUP BY country;
```


### 4. Count employees per gender. 

solution-1:

```sql
SELECT gender, 
       COUNT(*) 
FROM employees 
GROUP BY gender;
```

solution-2:

```sql
SELECT gender, 
       COUNT(*) AS count_per_gender
FROM employees 
GROUP BY gender;
```

### 5. Number of employees per department and gender. 

solution-1: use `dept_id`: one table

```sql
SELECT dept_id, 
       gender, 
       COUNT(*) 
FROM 
       employees 
GROUP BY 
       dept_id, gender;
```

solution-2: use `dept_name`: join two tables

```sql
SELECT d.dept_name, e.gender, COUNT(*) 
FROM departments d 
JOIN employees e ON d.dept_id = e.dept_id 
GROUP BY d.dept_name, e.gender;
```

### 6. Projects and number of employees assigned. 

```sql
SELECT p.project_name, COUNT(w.emp_id) AS emp_count 
FROM projects p 
LEFT JOIN workdays w ON p.project_id=w.project_id 
GROUP BY p.project_name;
```

### 7. Departments with total employees older than 40. 

```sql
SELECT d.dept_name, COUNT(e.emp_id) AS cnt 
FROM departments d 
JOIN employees e ON d.dept_id=e.dept_id 
WHERE e.age>40 
GROUP BY d.dept_name;
```

### 8. Average hire year of employees per department. 

```sql
SELECT d.dept_name, AVG(YEAR(e.hire_date)) AS avg_hire_year 
FROM departments d 
JOIN employees e ON d.dept_id=e.dept_id 
GROUP BY d.dept_name;
```

### 9. Number of projects per employee. 

```sql
SELECT e.name, COUNT(w.project_id) AS project_count 
FROM employees e 
LEFT JOIN workdays w ON e.emp_id=w.emp_id 
GROUP BY e.name;
```

### 10. Employees working in multiple projects. 

```sql
SELECT e.name, COUNT(DISTINCT w.project_id) AS proj_count 
FROM employees e 
JOIN workdays w ON e.emp_id=w.emp_id 
GROUP BY e.name 
HAVING COUNT(DISTINCT w.project_id) > 1;
```

### 11. Departments and number of projects their employees are assigned to. 

```sql
SELECT d.dept_name, COUNT(DISTINCT w.project_id) AS proj_count 
FROM departments d 
JOIN employees e ON d.dept_id=e.dept_id 
JOIN workdays w ON e.emp_id=w.emp_id 
GROUP BY d.dept_name;
```

### 12. Country-wise average employee age. 

```sql
SELECT country, 
       AVG(age) AS avg_age 
FROM employees 
GROUP BY country;
```

### 13. Gender-wise average age of employees. 

```sql
SELECT gender, 
       AVG(age) AS avg_age
FROM employees 
GROUP BY gender;
```

### 14. Employees per project per department. 

```sql
SELECT p.project_name, d.dept_name, COUNT(e.emp_id) AS emp_count 
FROM projects p 
JOIN workdays w ON p.project_id=w.project_id 
JOIN employees e ON w.emp_id=e.emp_id 
JOIN departments d ON e.dept_id=d.dept_id 
GROUP BY p.project_name, d.dept_name;
```

### 15. Project with maximum employees assigned. 

```sql
SELECT p.project_name, COUNT(w.emp_id) AS emp_count 
FROM projects p 
JOIN workdays w ON p.project_id=w.project_id 
GROUP BY p.project_name 
ORDER BY emp_count DESC 
LIMIT 1;
```

### 16. Departments with less than 5 employees. 

solution-1: use `dept_id` on one table

```sql
SELECT dept_id, 
       COUNT(*) AS emp_count 
FROM employees 
GROUP BY dept_id 
HAVING emp_count < 5;
```

solution-2: use `dept_name` on join of 2 tables

```sql
SELECT d.dept_name, COUNT(e.emp_id) AS emp_count 
FROM departments d 
LEFT JOIN employees e ON d.dept_id=e.dept_id 
GROUP BY d.dept_name 
HAVING COUNT(e.emp_id) < 5;
```


### 17. Employees count per hire year. 

solution-1:

```sql
SELECT YEAR(hire_date) AS hire_year, 
       COUNT(*) AS emp_count 
FROM employees 
GROUP BY YEAR(hire_date);
```

solution-2:

```sql
WITH year_added AS
(
   SELECT YEAR(hire_date) AS hire_year, 
   FROM employees
)
SELECT hire_year, 
       count(*) AS emp_count
GROUP BY hire_year;
```

### 18. Number of employees per project and gender. 

```sql
SELECT p.project_name, e.gender, COUNT(*) AS cnt 
FROM projects p 
JOIN workdays w ON p.project_id=w.project_id 
JOIN employees e ON w.emp_id=e.emp_id 
GROUP BY p.project_name, e.gender;
```

### 19. Average age per project. 

```sql
SELECT p.project_name, AVG(e.age) AS avg_age 
FROM projects p 
JOIN workdays w ON p.project_id=w.project_id 
JOIN employees e ON w.emp_id=e.emp_id 
GROUP BY p.project_name;
```

### 20. Departments with employees from multiple countries. 

```sql
SELECT d.dept_name, 
       COUNT(DISTINCT e.country) AS country_count 
FROM departments d 
JOIN employees e ON d.dept_id=e.dept_id 
GROUP BY d.dept_name 
HAVING COUNT(DISTINCT e.country) > 1;
```

### 21. Count projects per country. 

```sql
SELECT e.country, COUNT(DISTINCT w.project_id) AS proj_count 
FROM employees e 
JOIN workdays w ON e.emp_id=w.emp_id 
GROUP BY e.country;
```

### 22. Gender distribution per department. 

```sql
SELECT d.dept_name, 
       e.gender, 
       COUNT(*) AS cnt 
FROM departments d 
JOIN employees e ON d.dept_id=e.dept_id 
GROUP BY d.dept_name, e.gender;
```

### 23. Country-wise number of departments employees belong to. 

```sql
SELECT e.country, 
       COUNT(DISTINCT e.dept_id) AS dept_count 
FROM employees e 
GROUP BY e.country;
```

### 24. Average hire year per country. 

```sql
SELECT country, 
       AVG(YEAR(hire_date)) AS avg_hire_year 
FROM employees 
GROUP BY country;
```

### 25. Projects without employees. 

```sql
SELECT p.project_name 
FROM projects p 
LEFT JOIN workdays w ON p.project_id=w.project_id 
WHERE w.project_id IS NULL;
```

### 26. Employees who have worked on projects in more than one department. 

```sql
SELECT e.name, 
       COUNT(DISTINCT e.dept_id) AS dept_count 
FROM employees e 
JOIN workdays w ON e.emp_id=w.emp_id 
GROUP BY e.name 
HAVING COUNT(DISTINCT e.dept_id) > 1;
```

### 27. Departments and average projects per employee. 

Compute, per department, the average number of projects per employee.

There are several correct approaches — let’s go through them.

⸻

✅ Solution 1: Subquery with GROUP BY twice

```sql
SELECT d.dept_name, 
       AVG(emp_proj.project_count) AS avg_projects_per_employee
FROM departments d
JOIN (
    SELECT e.dept_id, e.emp_id, COUNT(DISTINCT w.project_id) AS project_count
    FROM employees e
    LEFT JOIN workdays w ON e.emp_id = w.emp_id
    GROUP BY e.emp_id, e.dept_id
) emp_proj
  ON d.dept_id = emp_proj.dept_id
GROUP BY d.dept_name;
```

🔎 Explanation

	1.	Inner query:
	•	Counts how many projects each employee worked on.
	•	Uses LEFT JOIN so employees with 0 projects are included.
	2.	Outer query:
	•	Groups by department.
	•	Averages the per-employee counts.

⸻

✅ Solution 2: Using CTE

Same logic, but a bit cleaner to read:

```sql
WITH emp_projects AS (
    SELECT e.dept_id, e.emp_id, COUNT(DISTINCT w.project_id) AS project_count
    FROM employees e
    LEFT JOIN workdays w ON e.emp_id = w.emp_id
    GROUP BY e.dept_id, e.emp_id
)
SELECT d.dept_name, 
       AVG(ep.project_count) AS avg_projects_per_employee
FROM departments d
JOIN emp_projects ep ON d.dept_id = ep.dept_id
GROUP BY d.dept_name;
```

⸻


### 28. Employees per department ordered by count. 

```sql
SELECT d.dept_name, COUNT(e.emp_id) AS cnt FROM departments d LEFT JOIN employees e ON d.dept_id=e.dept_id GROUP BY d.dept_name ORDER BY cnt DESC;
```

### 29. Country with the maximum number of employees. 

```sql
SELECT country, COUNT(*) AS cnt FROM employees GROUP BY country ORDER BY cnt DESC LIMIT 1;
```

### 30. Department with the highest average age. 

```sql
SELECT d.dept_name, AVG(e.age) AS avg_age FROM departments d JOIN employees e ON d.dept_id=e.dept_id GROUP BY d.dept_name ORDER BY avg_age DESC LIMIT 1;
```


### 31. Show employee names with their department names

```sql
SELECT e.name, d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;
```

### 32. Show project names assigned to employee ID = 1

```sql
SELECT p.project_name
FROM workdays w
JOIN projects p ON w.project_id = p.project_id
WHERE w.emp_id = 1;
```

### 33. Count number of employees per department

solution-1: count by `dept_id` (using one table)

```sql
SELECT dept_id, COUNT(*) AS employee_count
FROM employees e
GROUP BY dept_id;
```

solution-2: count by `dept_name` (using two tables)

```sql
SELECT d.dept_name, COUNT(*) AS employee_count
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;
```

### 34. Count number of employees by gender

```sql
SELECT gender, COUNT(*) AS total
FROM employees
GROUP BY gender;
```

### 35. Average age of employees in each department

```sql
SELECT d.dept_name, AVG(e.age) AS avg_age
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;
```

### 36. List employees who worked on project “Cloud Infrastructure Migration”

```sql
SELECT e.name
FROM employees e
JOIN workdays w ON e.emp_id = w.emp_id
JOIN projects p ON p.project_id = w.project_id
WHERE p.project_name = 'Cloud Infrastructure Migration';
```

### 37. Total number of project assignments per employee

```sql
SELECT e.name, COUNT(w.project_id) AS project_count
FROM employees e
JOIN workdays w ON e.emp_id = w.emp_id
GROUP BY e.name;
```

### 38. Projects with total employees assigned

```sql
SELECT p.project_name, COUNT(w.emp_id) AS total_employees
FROM projects p
JOIN workdays w ON p.project_id = w.project_id
GROUP BY p.project_name;
```

### 39. Employees hired in 2019

```sql
SELECT name, hire_date
FROM employees
WHERE YEAR(hire_date) = 2019;
```

### 40. Department with the highest average employee age

```sql
SELECT d.dept_name, AVG(e.age) AS avg_age
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY avg_age DESC
LIMIT 1;
```


### 41. Find projects that have no employees assigned. 

```sql
SELECT p.project_id, p.project_name 
FROM projects p 
LEFT JOIN workdays w ON p.project_id=w.project_id 
WHERE w.project_id IS NULL;
```

### 42. Find employees who have not worked on any project. 

```sql
SELECT e.emp_id, e.name 
FROM employees e 
LEFT JOIN workdays w ON e.emp_id=w.emp_id 
WHERE w.emp_id IS NULL;
```

### 43. Find departments without employees. 

```sql
SELECT d.dept_id, d.dept_name 
FROM departments d 
LEFT JOIN employees e ON d.dept_id=e.dept_id 
WHERE e.dept_id IS NULL;
```

### 44. Find employees in project ID=2. 

```sql
SELECT e.emp_id, e.name 
FROM employees e 
JOIN workdays w ON e.emp_id=w.emp_id 
WHERE w.project_id = 2;
```

### 45. List all projects with their employees. 

```sql
SELECT p.project_name, e.name 
FROM projects p 
JOIN workdays w ON p.project_id=w.project_id 
JOIN employees e ON w.emp_id=e.emp_id;
```

### 46. Find 2 oldest  & 2 youngest employees

✅ Option 1 — Single Query with UNION

solution-1:

```sql
(
  SELECT emp_id, name, age
  FROM employees
  ORDER BY age ASC
  LIMIT 2
)
UNION ALL
(
  SELECT emp_id, name, age
  FROM employees
  ORDER BY age DESC
  LIMIT 2
);
```

solution-2:

✅ Option 2 — Using Window Functions 

```sql
WITH ranked AS (
    SELECT emp_id, 
           name, 
           age,
           ROW_NUMBER() OVER (ORDER BY age ASC) AS youngest_rank,
           ROW_NUMBER() OVER (ORDER BY age DESC) AS oldest_rank
    FROM employees
)
SELECT emp_id, name, age
FROM ranked
WHERE (youngest_rank <= 2) OR
      (oldest_rank <= 2);
```
