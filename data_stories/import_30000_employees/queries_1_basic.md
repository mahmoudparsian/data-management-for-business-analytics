## 1. 20 Basic Queries

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


#### 1. List all employees.  

```sql
SELECT * 
FROM employees;
```

#### 2. Show only employee names and departments.  

```sql
SELECT employee_name, department 
FROM employees;
```

#### 3. Get all employees from UK.  

```sql
SELECT * 
FROM employees 
WHERE country = 'UK';
```

#### 4. Find employees older than 40.  

```sql
SELECT * 
FROM employees 
WHERE age > 40;
```

#### 5. Count total employees.  

```sql
SELECT COUNT(*) 
FROM employees;
```

#### 6. Show distinct departments.  

```sql
SELECT DISTINCT department 
FROM employees;
```

#### 7. List employees in Finance.  

```sql
SELECT employee_name 
FROM employees 
WHERE department = 'Finance';
```

#### 8. Find employees who joined after 2020.  

```sql
SELECT * 
FROM employees 
WHERE joined_date > '2020-01-01';
```

#### 9. Show employees with salary greater than 100000.  

```sql
SELECT * 
FROM employees 
WHERE salary > 100000;
```

#### 10. Get average salary of all employees.  

```sql
SELECT AVG(salary) 
FROM employees;
```

#### 11. List employees with position = 'Analyst'.  

```sql
SELECT * 
FROM employees 
WHERE position = 'Analyst';
```

#### 12. Count employees per country.  

```sql
SELECT country, COUNT(*) 
FROM employees 
GROUP BY country;
```

#### 13. Find youngest employee.  

```sql
SELECT * 
FROM employees 
ORDER BY age ASC 
LIMIT 1;
```

#### 14. Find oldest employee.  

```sql
SELECT * 
FROM employees 
ORDER BY age DESC 
LIMIT 1;
```

#### 15. List employees in HR with salary above 90000.  

```sql
SELECT * 
FROM employees 
WHERE department = 'HR' AND 
      salary > 90000;
```

#### 16. Get employees ordered by salary descending.  

```sql
SELECT * 
FROM employees 
ORDER BY salary DESC;
```

#### 17. Get top 5 highest paid employees.  

```sql
SELECT * 
FROM employees 
ORDER BY salary DESC 
LIMIT 5;
```

#### 18. Get bottom 5 lowest paid employees.  

```sql
SELECT * 
FROM employees 
ORDER BY salary ASC 
LIMIT 5;
```

#### 19. Show employees in Support or Marketing.  

```sql
SELECT * 
FROM employees 
WHERE department IN ('Support','Marketing');
```

#### 20. Show employees not in Finance.  

```sql
SELECT * 
FROM employees 
WHERE department <> 'Finance';
```

---

