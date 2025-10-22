# 40 SQL Queries for Departments, Employees, and Projects

## 1. Basic Queries (10)

#### 1. List all departments.

```sql
SELECT * 
FROM departments;
```

#### 2. List all employees.

```sql
SELECT * 
FROM employees;
```

#### 3. List all projects.

```sql
SELECT * 
FROM projects;
```

#### 4. Find the name of all employees in the Sales department.

```sql
SELECT name 
FROM employees 
WHERE dept_id = 1;
```

#### 5. Show all project names handled by the IT department.

```sql
SELECT proj_name 
FROM projects 
WHERE dept_id = 3;
```

#### 6. Display all employee IDs and names.

```sql
SELECT emp_id, name 
FROM employees;
```

#### 7. Get all department names ordered alphabetically.

```sql
SELECT dept_name 
FROM departments 
ORDER BY dept_name;
```

#### 8. Show all project IDs and project names.

```sql
SELECT proj_id, proj_name 
FROM projects;
```

#### 9. Find employees who belong to department 2 (HR).

```sql
SELECT name 
FROM employees 
WHERE dept_id = 2;
```

#### 10. Show all employees with dept_id and emp_id only.

```sql
SELECT emp_id, dept_id 
FROM employees;
```


## 2. Basic-to-Intermediate Queries (10)

#### 11. Find the number of employees in each department.

```sql
SELECT dept_id, 
       COUNT(*) AS num_employees 
FROM employees 
GROUP BY dept_id;
```

#### 12. List all departments and their employees (using join).

```sql
SELECT d.dept_name, 
       e.name 
FROM employees e 
JOIN departments d ON e.dept_id = d.dept_id;
```

#### 13. Show the names of employees along with their department name.

```sql
SELECT e.name, 
       d.dept_name 
FROM employees e 
JOIN departments d ON e.dept_id = d.dept_id;
```

#### 14. Show projects along with their department name.

```sql
SELECT p.proj_name, 
       d.dept_name 
FROM projects p 
JOIN departments d ON p.dept_id = d.dept_id;
```

#### 15. Count how many projects each department has.

```sql
SELECT dept_id, 
       COUNT(*) AS num_projects 
FROM projects 
GROUP BY dept_id;
```

#### 16. Find employees who are in departments that have projects.

```sql
SELECT DISTINCT e.name 
FROM employees e 
JOIN projects p ON e.dept_id = p.dept_id;
```

#### 17. List employees who are in IT department by joining with departments.

```sql
SELECT e.name 
FROM employees e 
JOIN departments d ON e.dept_id = d.dept_id 
WHERE d.dept_name = 'IT';
```

#### 18. List projects handled by the HR department.

```sql
SELECT p.proj_name 
FROM projects p 
JOIN departments d ON p.dept_id = d.dept_id 
WHERE d.dept_name = 'HR';
```

#### 19. Find employees whose names start with 'D'.

```sql
SELECT * 
FROM employees 
WHERE name LIKE 'D%';
```

#### 20. Show employee count per department along with department name.

```sql
SELECT d.dept_name, 
       COUNT(e.emp_id) AS num_employees
FROM departments d 
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;
```


## 3. Intermediate Queries (10)

#### 21. Find the department with the maximum number of employees.

```sql
SELECT dept_id, COUNT(*) AS num_employees
FROM employees
GROUP BY dept_id
ORDER BY num_employees DESC
LIMIT 1;
```

#### 22. Find all employees who belong to departments with more than 2 employees.

```sql
SELECT e.name
FROM employees e
WHERE e.dept_id IN (
                     SELECT dept_id 
                     FROM employees 
                     GROUP BY dept_id 
                     HAVING COUNT(*) > 2
                   );
```

#### 23. Find all departments that have no employees.

```sql
SELECT d.dept_name
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL;
```

#### 24. Show the top 2 departments with the most projects.

```sql
SELECT d.dept_name, 
       COUNT(p.proj_id) AS project_count
FROM departments d
JOIN projects p ON d.dept_id = p.dept_id
GROUP BY d.dept_name
ORDER BY project_count DESC
LIMIT 2;
```

#### 25. Show employees along with number of projects in their department.

```sql
SELECT e.name, 
       COUNT(p.proj_id) AS num_projects
FROM employees e
LEFT JOIN projects p ON e.dept_id = p.dept_id
GROUP BY e.emp_id, e.name;
```

#### 26. Find all employees in departments that have a project named 'AI LLM'.

```sql
SELECT e.name
FROM employees e
WHERE e.dept_id IN (
    SELECT dept_id FROM projects WHERE proj_name = 'AI LLM'
);
```

#### 27. List employees along with their department and any associated project names.

```sql
SELECT e.name, d.dept_name, p.proj_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN projects p ON d.dept_id = p.dept_id;
```

#### 28. Find departments that handle more than 1 project.

```sql
SELECT d.dept_name, COUNT(p.proj_id) AS num_projects
FROM departments d
JOIN projects p ON d.dept_id = p.dept_id
GROUP BY d.dept_name
HAVING COUNT(p.proj_id) > 1;
```

#### 29. Show all projects not assigned to the IT department.

```sql
SELECT proj_name 
FROM projects 
WHERE dept_id <> 3;
```

#### 30. Find employees who share the same department with 'Alice'.

```sql
SELECT e.name
FROM employees e
WHERE 
      e.dept_id = (SELECT dept_id FROM employees WHERE name = 'Alice') AND 
      e.name <> 'Alice';
```

---
## Practice: Basic Queries

#### 31. List all employees


```sql
SELECT * 
FROM employees;
```

#### 32. Show all departments


```sql
SELECT * 
FROM departments;
```

#### 33. Show all projects

```sql
SELECT * 
FROM projects;
```


#### 34. Simple Filtering: Find employees in IT department


```sql
SELECT name
FROM employees
WHERE dept_id = 3;
```

#### 35. Find projects handled by HR department


```sql
SELECT proj_name
FROM projects
WHERE dept_id = 2;
```

#### 36. Step 6: Aggregations: Count employees in each department


```sql
SELECT dept_id, 
       COUNT(*) AS num_employees
FROM employees
GROUP BY dept_id;
```

#### 37. Average employees per department (demo of AVG)

solution-1:


```sql
SELECT AVG(emp_count) AS avg_employees
FROM (
    SELECT dept_id, 
           COUNT(*) AS emp_count
    FROM employees
    GROUP BY dept_id
) t;
```

solution-2:


```sql
WITH counted_emps AS
(
    SELECT dept_id, 
           COUNT(*) AS emp_count
    FROM employees
    GROUP BY dept_id
)
SELECT AVG(emp_count) AS avg_employees
FROM counted_emps;
```


#### 38. Joins: Employees with Department Names (INNER JOIN)


```sql
SELECT e.emp_id, 
       e.name, 
       d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;
```

#### 39. Projects with Department Names


```sql
SELECT p.proj_name, 
       d.dept_name
FROM projects p
INNER JOIN departments d ON p.dept_id = d.dept_id;
```

#### 40. Employees working in IT department projects (multi-join)


```sql
SELECT e.name, 
       p.proj_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN projects p ON d.dept_id = p.dept_id
WHERE d.dept_name = 'IT';
```


