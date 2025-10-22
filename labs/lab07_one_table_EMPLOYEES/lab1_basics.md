# 📘 SQL Queries for Employees Table

## Schema: employees Table

```sql
CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  department VARCHAR(30),
  salary DECIMAL(10,2),
  hire_date DATE
);
```

---

## 🔹 Simple Queries

#### 1. **Show all employees.**  

```sql
SELECT * 
FROM employees;
```

#### 2. **Show only 2 employees.**  

```sql
SELECT * 
FROM employees
LIMIT 2;
```

#### 3. **Show only 5 employees.**  

```sql
SELECT * 
FROM 
       employees
LIMIT 
       5;
```


#### 4. **List first and last names of all employees.**  

```sql
SELECT 
       first_name, 
       last_name 
FROM 
       employees;
```

#### 5. **List first and last names of 5 employees.**  

```sql
SELECT  first_name, last_name 
FROM employees
LIMIT  5;
```


#### 6. **Find employees in the IT department.**  

```sql
SELECT * 
FROM employees 
WHERE department = 'IT';
```

#### 7. **Find employees with salary greater than 70,000.**  

```sql
SELECT first_name, last_name, salary 
FROM employees 
WHERE salary > 70000;
```

#### 8. **List employees hired after 2020.**  

```sql
SELECT first_name, last_name, hire_date 
FROM employees 
WHERE hire_date > '2020-01-01';
```

#### 9. **Show distinct departments.**  

```sql
SELECT DISTINCT department 
FROM employees;
```

#### 10. **Count how many employees are in the company.**  
```sql
SELECT COUNT(*) 
FROM employees;
```

#### 11. **Count how many employees are in the company.**  
```sql
SELECT COUNT(*) as num_of_employees
FROM employees;
```

#### 12. **Show employees ordered by last name (Ascending).** 
 
```sql
SELECT * 
FROM employees 
ORDER BY last_name;
```

#### 13. **Show employees ordered by last name (Descending).** 
 
```sql
SELECT * 
FROM employees 
ORDER BY last_name DESC;
```

#### 14. **Show top 5 highest salaries.**  

```sql
SELECT first_name, last_name, salary 
FROM employees 
ORDER BY salary DESC 
LIMIT 5;
```

#### 15. **Find employees whose first name starts with 'A'.**  

```sql
SELECT * 
FROM employees 
WHERE first_name LIKE 'A%';
```

#### 16. **Find employees in HR or Finance.**  

solution-1:

```sql
SELECT * 
FROM employees 
WHERE department IN ('HR','Finance');
```

solution-2:

```sql
SELECT * 
FROM employees 
WHERE (department = 'HR') OR (department = 'Finance');
```


#### 17. **Find employees not in the Sales department.** 
 
```sql
SELECT * 
FROM employees 
WHERE department <> 'Sales';
```

#### 18. **Show employees hired before 2010.**  

```sql
SELECT * 
FROM employees 
WHERE hire_date < '2010-01-01';
```

#### 19. **Find employees with salary between 50,000 and 90,000.**  

solution-1:

```sql
SELECT * 
FROM employees W
HERE salary BETWEEN 50000 AND 90000;
```

solution-2:

```sql
SELECT * 
FROM employees W
HERE (salary > 50000) AND (salary < 90000);
```


#### 20. **List employees ordered by hire date (newest first).**  

```sql
SELECT * 
FROM employees 
ORDER BY hire_date DESC;
```


#### 21. **Show all employees.**  

```sql
SELECT * 
FROM employees;
```

#### 22. **List only  last name and salary.**  

```sql
SELECT last_name, salary 
FROM employees;
```

#### 23. **Find all employees in the Marketing department.**  

```sql
SELECT * 
FROM employees 
WHERE department='Marketing';
```

#### 24. **Find employees with salary greater than 80,000.**  

```sql
SELECT first_name, last_name, salary 
FROM employees 
WHERE salary > 80000;
```

#### 25. **List employees hired after 2016.**  

```sql
SELECT first_name, last_name, hire_date 
FROM employees 
WHERE hire_date > '2016-01-01';
```

#### 26. **Show all distinct departments and sorted.**  

```sql
SELECT DISTINCT department 
FROM employees
ORDER by department;
```

#### 27. **Count how many employees are in the company.**  

solution-1:

```sql
SELECT COUNT(*) 
FROM employees;
```

solution-2:

```sql
SELECT COUNT(*) as number_of_emps
FROM employees;
```


#### 28. **Show employees ordered by salary (highest first).**  

```sql
SELECT first_name, last_name, salary 
FROM employees 
ORDER BY salary DESC;
```

#### 29. **Find the top 3 highest-paid employees.**  

```sql
SELECT first_name, last_name, salary 
FROM employees 
ORDER BY salary DESC 
LIMIT 3;
```

#### 30. **Find the bottom 3 lowest-paid employees.**  

solution-1:

```sql
SELECT first_name, last_name, salary 
FROM employees 
ORDER BY salary 
LIMIT 3;
```

solution-2:

```sql
SELECT first_name, last_name, salary 
FROM employees 
ORDER BY salary ASC
LIMIT 3;
```


#### 31. **Find employees whose first name starts with 'J'.** 
 
```sql
SELECT first_name, last_name 
FROM employees 
WHERE first_name LIKE 'J%';
```

---
---

## 🔹 Intermediate Queries

#### 32. **Find the average salary of all employees.**  

solution-1:

```sql
SELECT AVG(salary) 
FROM employees;
```

solution-2:

```sql
SELECT AVG(salary) as avg_salary
FROM employees;
```

#### 33. **Find the maximum salary in the company.**  

solution-1:

```sql
SELECT MAX(salary) 
FROM employees;
```

solution-2:

```sql
SELECT MAX(salary) as max_salary
FROM employees;
```


#### 34. **Find the minimum salary in the entire company.** 

solution-1:

```sql
SELECT MIN(salary) 
FROM employees;
```

solution-2:

```sql
SELECT MIN(salary) as minimum_salary
FROM employees;
```

#### 35. **Find the total salary paid by the company.**  

solution-1:

```sql
SELECT SUM(salary) 
FROM employees;
```

solution-2:

```sql
SELECT SUM(salary)  as total_salary
FROM employees;
```


#### 36. **Find the number of employees in each department.**  

solution-1:

```sql
SELECT department, COUNT(*) 
FROM employees 
GROUP BY department;
```

solution-2:

```sql
SELECT department, COUNT(*) as num_of_emps
FROM employees 
GROUP BY department;
```

#### 37. **Find the average salary in each department.**  

solution-1:

```sql
SELECT department, AVG(salary) 
FROM employees 
GROUP BY department;
```

solution-2:

```sql
SELECT department, AVG(salary) as avg_salary
FROM employees 
GROUP BY department;
```


#### 38. **Find departments with more than 5 employees.**  

solution-1:

```sql
SELECT department, COUNT(*) 
FROM employees 
GROUP BY department 
HAVING COUNT(*) > 5;
```

solution-2:

```sql
SELECT department, COUNT(*) as num_of_emps
FROM employees 
GROUP BY department 
HAVING COUNT(*) > 5;
```

solution-3:

```sql
WITH emp_counted AS
(
  SELECT department, COUNT(*) as num_of_emps
  FROM employees 
  GROUP BY department 
)
SELECT department, num_of_emps
FROM emp_counted
WHERE  num_of_emps > 5;
```


#### 39. **Find departments where the average salary is greater than 80,000.**  

solution-1:

```sql
SELECT department, AVG(salary) as avg_salary
FROM employees 
GROUP BY department 
HAVING AVG(salary) > 80000;
```

solution-2:

```sql
WITH average_salaries AS
( 
  SELECT department, AVG(salary) as avg_salary
  FROM employees 
  GROUP BY department 
)
SELECT department,  avg_salary
FROM average_salaries 
WHERE avg_salary > 80000;
```


#### 40. **Find the newest hire in each department.**  

```sql
SELECT department, MAX(hire_date) as max_hire_date
FROM employees 
GROUP BY department;
```

#### 41. **Find the oldest hire in the company.**  

```sql
SELECT * 
FROM employees 
ORDER BY hire_date ASC 
LIMIT 1;
```


#### 42.	Find the number of employees in each department.

~~~sql
SELECT department, COUNT(*) AS num_employees
FROM employees
GROUP BY department;
~~~


#### 43. Find the average salary in each department.

~~~sql
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department;
~~~

#### 44.	Find departments with less than 6 employees.

solution-1:

~~~sql
SELECT department, COUNT(*) AS num_employees
FROM employees
GROUP BY department
HAVING COUNT(*) < 6;
~~~

solution-2:

~~~sql
WITH counted_table AS
(
  SELECT department, COUNT(*) AS num_employees
  FROM employees
  GROUP BY department
)
SELECT department, num_employees
FROM counted_table
WHERE num_employees < 6;
~~~

#### 45.	Find departments where the average salary is greater than 80,000.

solution-1:

~~~sql
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 80000;
~~~

solution-2:

~~~sql
WITH avg_salaries_table AS
(
  SELECT department, AVG(salary) AS avg_salary
  FROM employees
  GROUP BY department
)
SELECT department, AVG(salary) AS avg_salary
FROM avg_salaries_table
WHERE avg_salary > 80000;
~~~


#### 46 .	Find the newest hire in each department.

~~~sql
SELECT department, MAX(hire_date) AS newest_hire
FROM employees
GROUP BY department;
~~~


⸻


#### 47. **YOUR-QUERY.**  

```sql
your-sql-query
```

---

#### 48. **YOUR-QUERY.**  

```sql
your-sql-query
```

#### 49. **YOUR-QUERY.**  

```sql
your-sql-query
```

---

#### 50. **YOUR-QUERY.**  

```sql
your-sql-query
```