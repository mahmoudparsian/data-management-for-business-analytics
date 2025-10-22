# 20 Basic SQL Queries for Employees Table

**1. List all employees.**

```sql
SELECT * 
FROM employees;
```

**2. Show first name and last name of all employees.**

```sql
SELECT first_name, last_name 
FROM employees;
```

**3. Find employees older than 40.**

```sql
SELECT * 
FROM employees 
WHERE age > 40;
```

**4. Find female employees.**

```sql
SELECT * 
FROM employees 
WHERE gender='F';
```

**5. Find male employees.**

```sql
SELECT * 
FROM employees 
WHERE gender='M';
```

**6. Find employees from USA.**

```sql
SELECT * 
FROM employees 
WHERE country='USA';
```

**7. Find employees working in 'IT' department.**

```sql
SELECT * 
FROM employees 
WHERE department='IT';
```

**8. List employees hired after 2020.**

```sql
SELECT * 
FROM employees 
WHERE hire_date > '2020-01-01';
```

**9. Find employees with salary greater than 50000.**

```sql
SELECT * 
FROM employees 
WHERE salary > 50000;
```

**10. List employees sorted by salary descending.**

```sql
SELECT * 
FROM employees 
ORDER BY salary DESC;
```

**11. Find top 5 highest paid employees.**

```sql
SELECT * 
FROM employees 
ORDER BY salary DESC 
LIMIT 5;
```

**12. Find youngest employee.**

```sql
SELECT * 
FROM employees 
ORDER BY age ASC 
LIMIT 1;
```

**13. Find oldest employee.**

```sql
SELECT * 
FROM employees 
ORDER BY age DESC 
LIMIT 1;
```

**14. Count total number of employees.**

```sql
SELECT COUNT(*) 
FROM employees;
```

**15. Count employees in 'HR' department.**

```sql
SELECT COUNT(*) 
FROM employees 
WHERE department='HR';
```

**16. Find employees whose first name starts with 'A'.**

```sql
SELECT * 
FROM employees 
WHERE first_name LIKE 'A%';
```

**17. Find employees whose last name ends with 'n'.**

```sql
SELECT * 
FROM employees 
WHERE last_name LIKE '%n';
```

**18. Find employees hired in 2019.**

```sql
SELECT * 
FROM employees 
WHERE YEAR(hire_date)=2019;
```

**19. Find distinct countries employees are from.**

```sql
SELECT DISTINCT country 
FROM employees;
```

**20. Find distinct departments.**

```sql
SELECT DISTINCT department 
FROM employees;
```

