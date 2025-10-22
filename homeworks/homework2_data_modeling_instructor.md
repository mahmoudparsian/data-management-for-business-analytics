# 🗝️ MySQL 101 Homework: Very Basic Data Modeling (Answer Key)

## Part A: Simple Queries
```sql
-- Q1
SELECT * FROM employees;

-- Q2
SELECT * FROM departments;

-- Q3
SELECT name FROM employees
WHERE department_id = 1;

-- Q4
SELECT name, salary FROM employees
WHERE salary > 55000;

-- Q5
SELECT * FROM projects;
```

---

## Part B: Intermediate Queries
```sql
-- Q6
SELECT d.dept_name, COUNT(e.employee_id) AS total_employees
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.dept_name;

-- Q7
SELECT d.dept_name, AVG(e.salary) AS avg_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.dept_name;

-- Q8
SELECT e.name
FROM employees e
JOIN employee_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON ep.project_id = p.project_id
WHERE p.project_name = 'Website Upgrade';

-- Q9
SELECT p.project_name, COUNT(ep.employee_id) AS total_employees
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY p.project_name;

-- Q10
SELECT name, salary
FROM employees
ORDER BY salary DESC
LIMIT 1;
```
