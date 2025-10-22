# 🟢 50 Basic SQL Queries 

### 1. List all departments. 

```sql
SELECT * 
FROM departments;
```

### 2. List all employees. 

```sql
SELECT * 
FROM employees;
```

### 3. List all projects. 

```sql
SELECT * 
FROM projects;
```

### 4. List all workdays. 

```sql
SELECT * 
FROM workdays;
```

### 5. Find names of all employees and their department IDs. 

```sql
SELECT name, dept_id 
FROM employees;
```

### 6. Find all department names. 

```sql
SELECT dept_name 
FROM departments;
```

### 7. Show project IDs and project names. 

```sql
SELECT project_id, project_name 
FROM projects;
```

### 8. Find all employees from USA. 

```sql
SELECT * 
FROM employees 
WHERE country='USA';
```

### 9. Find all employees older than 40. 

```sql
SELECT * 
FROM employees 
WHERE age > 40;
```

### 10. Find all female employees. 

```sql
SELECT * 
FROM employees 
WHERE gender='F';
```

### 11. List employees sorted by age ascending. 

```sql
SELECT * 
FROM employees 
ORDER BY age ASC;
```

### 12. List employees sorted by hire date descending. 

```sql
SELECT * 
FROM employees 
ORDER BY hire_date DESC;
```

### 13. Find first 5 employees by hire date. 

```sql
SELECT * 
FROM employees 
ORDER BY hire_date ASC 
LIMIT 5;
```

### 14. Find the oldest employee. 

```sql
SELECT * 
FROM employees 
ORDER BY age DESC LIMIT 1;
```

### 15. Find the youngest employee. 

```sql
SELECT * 
FROM employees 
ORDER BY age ASC 
LIMIT 1;
```

### 16. Count how many employees are in the table. 

```sql
SELECT COUNT(*) 
FROM employees;
```

### 17. Count how many projects are in the table. 

```sql
SELECT COUNT(*) 
FROM projects;
```

### 18. Find employees in department 2. 

```sql
SELECT * 
FROM employees 
WHERE dept_id=2;
```

### 19. Find employees not assigned to any department. 

```sql
SELECT * 
FROM employees 
WHERE dept_id IS NULL;
```

### 20. List all employees and their countries. 

```sql
SELECT name, country 
FROM employees;
```

### 21. Find distinct countries of employees. 

```sql
SELECT DISTINCT country 
FROM employees;
```

### 22. Find employees whose name starts with 'A'. 

```sql
SELECT * 
FROM employees 
WHERE name LIKE 'A%';
```

### 23. Find employees whose name ends with 'n'. 

```sql
SELECT * 
FROM employees 
WHERE name LIKE '%n';
```

### 24. Find employees hired in 2020. 

```sql
SELECT * 
FROM employees 
WHERE YEAR(hire_date)=2020;
```


### 25. Find workdays for employee ID=1. 

```sql
SELECT * 
FROM workdays 
WHERE emp_id=1;
```


### 26. List all employees

```sql
SELECT * 
FROM employees;
```

### 27. Show employee names and their departments (by ID only)

```sql
SELECT name, dept_id 
FROM employees;
```

### 28. List employees who are older than 35

```sql
SELECT name, age 
FROM employees
WHERE age > 35;
```

### 29. Show employees hired after 2020

```sql
SELECT name, hire_date 
FROM employees
WHERE hire_date > '2020-01-01';
```

### 30. Show all female employees

```sql
SELECT name, gender 
FROM employees
WHERE gender = 'F';
```

### 31. Sort employees by age, descending

```sql
SELECT name, age 
FROM employees
ORDER BY age DESC;
```

### 32. List employees from USA only

```sql
SELECT name, country 
FROM employees
WHERE country = 'USA';
```

### 33. Show employee names and years of service (using YEAR)

```sql
SELECT name, YEAR(CURDATE()) - YEAR(hire_date) AS years_of_service
FROM employees;
```

### 34. Count total employees

```sql
SELECT COUNT(*) AS total_employees
FROM employees;
```

### 35. Show first 5 employees

```sql
SELECT * 
FROM employees
LIMIT 5;
```

### 36. Show first 5 employees (hired oldest)

```sql
SELECT * 
FROM employees
ORDER BY hire_date DESC
LIMIT 5;
```

### 37. Show first 5 employees (hired recently)

```sql
SELECT * 
FROM employees
ORDER BY hire_date ASC
LIMIT 5;
```

### 38. Show all employees from USA and India

solution-1:

```sql
SELECT * 
FROM employees
WHERE country in ('USA', 'India');
```

solution-2:

```sql
SELECT * 
FROM employees
WHERE (country = 'USA') OR 
      (country = 'India');
```

### 39. Show all employees NOT from USA 

```sql
SELECT * 
FROM employees
WHERE country <> 'USA' ;
```

### 40. Show top-5 youngest employees

```sql
SELECT * 
FROM employees
ORDER BY age ASC
LIMIT 5;
```

### 41. Show top-5 oldest employees

```sql
SELECT * 
FROM employees
ORDER BY age DESC
LIMIT 5;
```

### 42. Show all employees whose name begin with "A":

```sql
SELECT * 
FROM employees
WHERE name LIKE 'A%';
```

### 43. Show all employees whose name begin with "e":

```sql
SELECT * 
FROM employees
WHERE name LIKE '%e';
```

### 44. 2 Find 2 youngest employees

✅ Using ORDER BY + LIMIT

```sql
-- 2 youngest employees
SELECT emp_id, name, age
FROM employees
ORDER BY age ASC
LIMIT 2;
```

### 45. 2 Find 2 oldest employees

```sql
-- 2 oldest employees
SELECT emp_id, name, age
FROM employees
ORDER BY age DESC
LIMIT 2;
```

### 46. Find 2 oldest  & 2 youngest employees

✅ Option 1 — Single Query with UNION


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

✅ Option 2 — Using Window Functions (future classes)


### 47. Find Employees whose age is above the average age of all employees

```sql
SELECT name, age
FROM employees
WHERE age > (SELECT AVG(age) FROM employees);
```

### 48. Find number of Employees per country

```sql
SELECT country, 
       count(*) AS num_of_emps
FROM employees
GROUP BY country;
```

### 49. Find number of Employees per gender

```sql
SELECT gender, 
       count(*) AS num_of_emps
FROM employees
GROUP BY gender;
```

### 50. Find number of Employees per department

```sql
SELECT dept_id, 
       count(*) AS num_of_emps
FROM employees
GROUP BY dept_id;
```
