# Lab-2 – Basic to Intermediate (30 queries)

> Table: `employees`
> 
~~~
employees:
           emp_id, 
           first_name, 
           last_name, 
           age, 
           degree, 
           gender, 
           country, 
           department, 
           hire_date, 
           salary
~~~

### 1. Count employees per country.

solution-1:

```sql
SELECT country, COUNT(*) 
FROM employees 
GROUP BY country 
ORDER BY COUNT(*) DESC;
```

solution-2:

```sql
SELECT country, COUNT(*) AS cnt 
FROM employees 
GROUP BY country 
ORDER BY cnt DESC;
```


### 2. Count employees per department.

solution-1:

```sql
SELECT department, COUNT(*) 
FROM employees 
GROUP BY department 
ORDER BY COUNT(*) DESC;
```

solution-2:

```sql
SELECT department, COUNT(*) AS cnt 
FROM employees 
GROUP BY department 
ORDER BY cnt DESC;
```


### 3. Average salary overall.

solution-1:

```sql
SELECT AVG(salary)  
FROM employees;
```

solution-2:

```sql
SELECT AVG(salary) AS avg_salary 
FROM employees;
```

### 4. Average salary per department.

solution-1:

```sql
SELECT department, ROUND(AVG(salary)) AS avg_salary 
FROM employees 
GROUP BY department 
ORDER BY avg_salary DESC;
```

solution-2:

```sql
SELECT department, ROUND(AVG(salary))  
FROM employees 
GROUP BY department 
ORDER BY AVG(salary) DESC;
```


### 5. Average salary per country.

solution-1:

```sql
SELECT country, ROUND(AVG(salary)) AS avg_salary 
FROM employees 
GROUP BY country 
ORDER BY avg_salary DESC;
```

solution-2:

```sql
SELECT country, ROUND(AVG(salary)) 
FROM employees 
GROUP BY country 
ORDER BY AVG(salary) DESC;
```


### 6. Min/max salary per degree.
```sql
SELECT degree, 
       MIN(salary) AS min_salary, 
       MAX(salary) AS max_salary 
FROM employees 
GROUP BY degree;
```

### 7. Employees per degree.
```sql
SELECT degree, COUNT(*) AS cnt 
FROM employees 
GROUP BY degree 
ORDER BY cnt DESC;
```

### 8. Number of Employees hired each year.
```sql
SELECT YEAR(hire_date) AS yr, 
       COUNT(*) AS cnt 
FROM employees 
GROUP BY YEAR(hire_date) 
ORDER BY yr;
```

### 9. Average age per department.
```sql
SELECT department, ROUND(AVG(age)) AS avg_age 
FROM employees 
GROUP BY department 
ORDER BY avg_age;
```

### 10. Employees with salary above department average.

solution-1:

```sql
SELECT e.* 
FROM employees e 
JOIN (SELECT department, AVG(salary) AS avg_sal 
      FROM employees 
      GROUP BY department
     ) d 
   ON e.department=d.department WHERE e.salary > d.avg_sal;
```

solution-2:

```sql
WITH avg_salary_per_dept AS
(
  SELECT department, AVG(salary) AS avg_sal 
  FROM employees 
  GROUP BY department
)
SELECT e.* 
FROM employees e 
JOIN avg_salary_per_dept d 
   ON e.department = d.department 
WHERE e.salary > d.avg_sal;
```



### 11. Employees with salary below country average.

solution-1:

```sql
SELECT e.emp_id, e.first_name, e.salary, e.country 
FROM employees e 
JOIN (SELECT country, AVG(salary) AS avg_sal FROM employees GROUP BY country) c 
   ON e.country=c.country 
WHERE e.salary < c.avg_sal;
```

solution-2:

```sql
WITH avg_sal_per_country AS
(
  SELECT country, AVG(salary) AS avg_sal 
  FROM employees 
  GROUP BY country
) 
SELECT e.emp_id, e.first_name, e.salary, e.country 
FROM employees e 
JOIN avg_sal_per_country  c 
   ON e.country = c.country 
WHERE e.salary < c.avg_sal;
```

### 12. Departments having more than 30 employees.

solution-1:

```sql
SELECT department, COUNT(*) AS cnt 
FROM employees 
GROUP BY department 
HAVING COUNT(*) > 30;
```

solution-2:

```sql
WITH dept_count AS
(
  SELECT department, COUNT(*) AS cnt 
  FROM employees 
  GROUP BY department 
)
SELECT department, cnt 
FROM dept_count
WHERE cnt > 30;
```

### 13. Countries with avg salary >= 100k.

solution-1:

```sql
SELECT country, ROUND(AVG(salary)) AS avg_sal 
FROM employees 
GROUP BY country 
HAVING AVG(salary) >= 100000;
```


solution-2:

```sql
WITH avg_salary_per_country AS
(
  SELECT country, ROUND(AVG(salary)) AS avg_sal 
  FROM employees 
  GROUP BY country 
)
SELECT country, avg_sal 
FROM avg_salary_per_country 
WHERE avg_sal >= 100000;
```


### 14. Degrees with fewer than 35 employees.

solution-1:

```sql
SELECT degree, COUNT(*) AS cnt 
FROM employees 
GROUP BY degree 
HAVING COUNT(*) < 35;
```

solution-2:

```sql
WITH degree_count AS 
(
  SELECT degree, COUNT(*) AS cnt 
  FROM employees 
  GROUP BY degree
)
SELECT degree, cnt 
FROM degree_count 
WHERE cnt < 35;
```


### 15. Top 10 highest paid employees.
```sql
SELECT emp_id, first_name, last_name, salary 
FROM employees 
ORDER BY salary DESC 
LIMIT 10;
```

### 16. Bottom 10 salaries.
```sql
SELECT emp_id, first_name, last_name, salary 
FROM employees 
ORDER BY salary ASC 
LIMIT 10;
```

### 17. Median-ish (approx) placeholder.
```sql
SELECT 'See Lab 5 for window-based percentile' AS note;
```

### 18. Salary buckets (every 20k).

> `FLOOR(salary/20000)` computes a consistent bucket number.

Solution-1:

```sql
SELECT
  CONCAT(b.bucket*20000, '-', b.bucket*20000 + 19999) AS salary_bucket,
  COUNT(*) AS num_employees
FROM (
  SELECT FLOOR(salary/20000) AS bucket
  FROM employees
) AS b
GROUP BY b.bucket
ORDER BY b.bucket;
```

Output:

~~~
+---------------+---------------+
| salary_bucket | num_employees |
+---------------+---------------+
| 60000-79999   |            47 |
| 80000-99999   |            36 |
| 100000-119999 |            33 |
| 120000-139999 |            50 |
| 140000-159999 |            34 |
+---------------+---------------+
5 rows in set (0.00 sec)
~~~

Solution-2:

```sql
WITH bucket_table AS
(
  SELECT FLOOR(salary/20000) AS bucket
  FROM employees
)
SELECT
  CONCAT(b.bucket*20000, '-', b.bucket*20000 + 19999) AS salary_bucket,
  COUNT(*) AS num_employees
FROM bucket_table b
GROUP BY b.bucket
ORDER BY b.bucket;
```

Output:

~~~
+---------------+---------------+
| salary_bucket | num_employees |
+---------------+---------------+
| 60000-79999   |            47 |
| 80000-99999   |            36 |
| 100000-119999 |            33 |
| 120000-139999 |            50 |
| 140000-159999 |            34 |
+---------------+---------------+
5 rows in set (0.00 sec)
~~~


### 19. Age groups via CASE.
```sql
SELECT 
       CASE 
            WHEN age<30 THEN 'Under30' 
            WHEN age<=50 THEN '30to50' 
            ELSE 'Over50'
       END AS age_group, 
       COUNT(*) AS cnt 
FROM employees 
GROUP BY age_group;
```
output:

~~~
+-----------+-----+
| age_group | cnt |
+-----------+-----+
| Over50    |  83 |
| 30to50    |  75 |
| Under30   |  42 |
+-----------+-----+
3 rows in set (0.00 sec)
~~~


### 20. Department + country counts.

```sql
SELECT department, country, COUNT(*) AS cnt 
FROM employees 
GROUP BY department, country 
ORDER BY department, cnt DESC;
```

### 21. Distinct full names (sanity).
```sql
SELECT COUNT(DISTINCT CONCAT(first_name,' ',last_name)) 
FROM employees;
```

### 22. Top 5 countries by headcount.
```sql
SELECT country, COUNT(*) AS cnt 
FROM employees 
GROUP BY country 
ORDER BY cnt DESC 
LIMIT 5;
```

output:

~~~
+---------+-----+
| country | cnt |
+---------+-----+
| CHINA   |  31 |
| ITALY   |  30 |
| INDIA   |  28 |
| CANADA  |  24 |
| USA     |  23 |
+---------+-----+
5 rows in set (0.01 sec)
~~~


### 23. Top 5 departments by average age.
```sql
SELECT department, ROUND(AVG(age)) AS avg_age 
FROM employees 
GROUP BY department 
ORDER BY avg_age DESC 
LIMIT 5;
```

### 24. Employees with degree IN (MBA, PHD).

solution-1:

```sql
SELECT emp_id, first_name, degree 
FROM employees 
WHERE degree IN ('MBA','PHD');
```

solution-2:

```sql
SELECT emp_id, first_name, degree 
FROM employees 
WHERE (degree = 'MBA') OR (degree = 'PHD');
```


### 25. Employees NOT from (USA, CANADA).
```sql
SELECT emp_id, first_name, country 
FROM employees 
WHERE country NOT IN ('USA','CANADA') 
LIMIT 20;
```

### 26. Employees hired in Q1 of any year.
```sql
SELECT emp_id, first_name, hire_date 
FROM employees 
WHERE MONTH(hire_date) IN (1,2,3);
```

### 27. Count of employees hired per month (across all years).
```sql
SELECT MONTH(hire_date) AS m, COUNT(*) as count_of_emps
FROM employees 
GROUP BY MONTH(hire_date) 
ORDER BY m;
```

### 28. Top 10 youngest in Engineering.
```sql
SELECT emp_id, first_name, age 
FROM employees 
WHERE department='Engineering' 
ORDER BY age ASC 
LIMIT 10;
```

### 29. Top 10 oldest in HR.
```sql
SELECT emp_id, first_name, age 
FROM employees 
WHERE department='HR' 
ORDER BY age DESC 
LIMIT 10;
```

### 30. Check rows with odd characters in first_name.
```sql
SELECT emp_id, first_name 
FROM employees 
WHERE first_name REGEXP '[^A-Za-z]';
```

