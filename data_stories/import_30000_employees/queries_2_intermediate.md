## 2. 20 Intermediate Queries

## Table Schema

```sql
CREATE TABLE `employees` (
  `employee_id` int DEFAULT NULL,
  `employee_name` text,
  `age` int DEFAULT NULL,
  `country` text,
  `department` text,
  `position` text,
  `salary` double DEFAULT NULL,
  `joined_date` text
);
```

---

#### 1. Average salary per department.  

```sql
SELECT department, AVG(salary) 
FROM employees 
GROUP BY department;
```

#### 2. Maximum salary per department.  

```sql
SELECT department, MAX(salary) 
FROM employees 
GROUP BY department;
```

#### 3. Minimum salary per country.  

```sql
SELECT country, MIN(salary) 
FROM employees 
GROUP BY country;
```

#### 4. Number of employees per department.  

```sql
SELECT department, COUNT(*) 
FROM employees 
GROUP BY department;
```

#### 5. Employees who joined before 2018.  

```sql
SELECT * 
FROM employees 
WHERE joined_date < '2018-01-01';
```

#### 6. Employees between ages 30 and 40.  

```sql
SELECT * 
FROM employees 
WHERE age BETWEEN 30 AND 40;
```

#### 7. Employees with salary between 50k and 100k.  

```sql
SELECT * 
FROM employees 
WHERE salary BETWEEN 50000 AND 100000;
```

#### 8. Top 3 departments by average salary.  

```sql
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC
LIMIT 3;
```

#### 9. Count employees per position.  

```sql
SELECT position, COUNT(*) 
FROM employees 
GROUP BY position;
```

#### 10. Employees whose name starts with 'M'.  

```sql
SELECT * 
FROM employees 
WHERE employee_name LIKE 'M%';
```

#### 11. Employees whose name contains 'son'.  

```sql
SELECT * 
FROM employees 
WHERE employee_name LIKE '%son%';
```

#### 12. Employees with NULL department.  

```sql
SELECT * 
FROM employees 
WHERE department IS NULL;
```
#### 13. Employees grouped by country and department.  

```sql
SELECT country, department, COUNT(*) 
FROM employees 
GROUP BY country, department;
```

#### 14. Average age of employees per country.  

```sql
SELECT country, AVG(age) 
FROM employees 
GROUP BY country;
```

#### 15. Employees with salary above average.  

```sql
SELECT * FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);
```

#### 16. Employees who joined in 2019.  

```sql
SELECT * 
FROM employees 
WHERE YEAR(joined_date) = 2019;
```

#### 17. Highest paid employee in each department.  

###### solution-1:

```sql
SELECT e.* 
FROM employees e
WHERE e.salary = (
  SELECT MAX(salary) FROM employees WHERE department = e.department
);
```

###### solution-2:

```sql
WITH dept_max AS 
(
  SELECT department, MAX(salary) AS max_salary
  FROM employees
  GROUP BY department
)
SELECT e.*
FROM employees e
JOIN dept_max d 
  ON e.department = d.department AND 
     e.salary = d.max_salary;
```

🔎 Explanation
	•	dept_max CTE finds the maximum salary per department.
	
	•	The outer query joins employees to dept_max and selects 
	only those employees whose salary matches their department’s maximum.
	
###### solution-3:

```sql
WITH ranked AS
(
    SELECT employee_id, employee_name, department, salary,
           RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
    FROM employees 
)
SELECT employee_id, employee_name, department, salary, rnk
FROM ranked
WHERE rnk = 1;
```


#### 18. Employees ordered by age then salary (limit to 10 rows) 

```sql
SELECT * FROM 
employees 
ORDER BY age, salary DESC
LIMIT 10;
```

#### 19. Countries with more than 5 employees.  

```sql
SELECT country, COUNT(*) AS cnt
FROM employees 
GROUP BY country 
HAVING cnt > 5;
```

#### 20. Departments where average salary > 90000.  

```sql
SELECT department, AVG(salary) AS avg_salary
FROM employees 
GROUP BY department 
HAVING avg_salary > 90000;
```

---

