# Employees — 40 Basic/Simple Queries (MySQL)

### Q1. List all employees.

```sql
SELECT * 
FROM employees;
```

### Q2. Fetch first 10 employees.

```sql
SELECT * 
FROM employees 
ORDER BY emp_id 
LIMIT 10;
```

### Q3. Show first and last names only.

```sql
SELECT first_name, last_name 
FROM employees;
```

### Q4. Employees in the USA.

```sql
SELECT * 
FROM employees 
WHERE country = 'USA';
```

### Q5. Employees not in USA.

```sql
SELECT * 
FROM employees 
WHERE country <> 'USA';
```

### Q6. Employees in Engineering.

```sql
SELECT emp_id, first_name, last_name 
FROM employees 
WHERE department = 'Engineering';
```

### Q7. Employees with salary > 150k.

```sql
SELECT emp_id, first_name, last_name, salary 
FROM employees 
WHERE salary > 150000;
```

### Q8. Employees with salary between 90k and 120k.

```sql
SELECT emp_id, first_name, last_name, salary 
FROM employees 
WHERE salary BETWEEN 90000 AND 120000;
```

### Q9. Employees older than 60.

```sql
SELECT emp_id, first_name, last_name, age 
FROM employees 
WHERE age > 60;
```

### Q10. Employees aged 20 to 30.

```sql
SELECT emp_id, first_name, last_name, age 
FROM employees 
WHERE age BETWEEN 20 AND 30;
```

### Q11. Order by salary ascending.

```sql
SELECT emp_id, first_name, last_name, salary 
FROM employees 
ORDER BY salary ASC;
```

### Q12. Order by salary descending.

```sql
SELECT emp_id, first_name, last_name, salary 
FROM employees 
ORDER BY salary DESC;
```

### Q13. Order by last name then first name.

```sql
SELECT emp_id, first_name, last_name 
FROM employees 
ORDER BY last_name, first_name;
```

### Q14. Employees joined in 2020.

Extract year from a Date:

```sql
SELECT YEAR('2022-01-01');
```

output:

```sql
2022
```

Employees joined in 2020:

```sql
SELECT * 
FROM employees 
WHERE YEAR(date_joined) = 2020;
```

### Q15. Employees joined after 2022-01-01.

```sql
SELECT * 
FROM employees 
WHERE date_joined > '2022-01-01';
```

### Q16. Employees named 'Olivia'.

```sql
SELECT * 
FROM employees 
WHERE first_name = 'Olivia';
```

### Q17. Distinct departments.

```sql
SELECT DISTINCT department 
FROM employees;
```

### Q18. Distinct countries.

```sql
SELECT DISTINCT country 
FROM employees;
```

### Q19. Count employees.

```sql
SELECT COUNT(*) AS employee_count 
FROM employees;
```

### Q20. Count distinct countries.

```sql
SELECT COUNT(DISTINCT country) AS distinct_countries 
FROM employees;
```

### Q21. Employees in AI or IT.

```sql
SELECT emp_id, first_name, last_name, department 
FROM employees 
WHERE department IN ('AI','IT');
```

### Q22. Employees not in Marketing.

```sql
SELECT emp_id, first_name, last_name, department 
FROM employees 
WHERE department <> 'Marketing';
```

### Q23. Employees with last name starting with 'S'.

```sql
SELECT * 
FROM employees 
WHERE last_name LIKE 'S%';
```

### Q24. Employees with 'an' in first name.

```sql
SELECT * 
FROM employees 
WHERE first_name LIKE '%an%';
```

### Q25. Top 5 highest salaries.

```sql
SELECT emp_id, first_name, last_name, salary 
FROM employees 
ORDER BY salary DESC 
LIMIT 5;
```

### Q26. Bottom 5 salaries.

```sql
SELECT emp_id, first_name, last_name, salary 
FROM employees 
ORDER BY salary ASC LIMIT 5;
```

### Q27. Oldest 5 employees.

```sql
SELECT emp_id, first_name, last_name, age 
FROM employees 
ORDER BY age DESC 
LIMIT 5;
```

### Q28. Youngest 5 employees.

```sql
SELECT emp_id, first_name, last_name, age 
FROM employees 
ORDER BY age ASC 
LIMIT 5;
```

### Q29. Employees joined this year.

```sql
SELECT * 
FROM employees 
WHERE YEAR(date_joined) = YEAR(CURDATE());
```

### Q30. Employees joined in last 90 days.

```sql
SELECT * 
FROM employees 
WHERE date_joined >= (CURDATE() - INTERVAL 90 DAY);
```

### Q31. Average salary (all).

```sql
SELECT AVG(salary) AS avg_salary 
FROM employees;
```

### Q32. Minimum and maximum salary.

```sql
SELECT MIN(salary) AS min_salary, 
       MAX(salary) AS max_salary 
FROM employees;
```

### Q33. How many males vs females.

```sql
SELECT gender, 
       COUNT(*) AS cnt 
FROM employees 
GROUP BY gender;
```

### Q34. Employees per department (quick).

```sql
SELECT department, 
       COUNT(*) AS cnt 
FROM employees 
GROUP BY department 
ORDER BY cnt DESC;
```

### Q35. Employees per country (quick).

```sql
SELECT country, 
       COUNT(*) AS cnt 
FROM employees 
GROUP BY country 
ORDER BY cnt DESC;
```

### Q36. Employees with salary not null.

```sql
SELECT COUNT(*) 
FROM employees 
WHERE salary IS NOT NULL;
```

### Q37. Employees with age not null.

```sql
SELECT COUNT(*) 
FROM employees 
WHERE age IS NOT NULL;
```

### Q38. Employees in USA sorted by last name.

```sql
SELECT emp_id, first_name, last_name 
FROM employees 
WHERE country='USA' 
ORDER BY last_name;
```

### Q39. Employees in Engineering with salary > 120k.

```sql
SELECT emp_id, first_name, last_name, salary 
FROM employees 
WHERE (department='Engineering') AND 
      (salary > 120000);
```

### Q40. Employees joined before 2021.

```sql
SELECT * 
FROM employees 
WHERE date_joined < '2021-01-01';
```

