# 📘 Lab 5 (Instructor Version): Capstone — Advanced SQL (Employees Table)

## Solutions

1. Top 3 highest-paid employees per department:  
```sql
SELECT department, first_name, last_name, salary
FROM (
  SELECT department, first_name, last_name, salary,
         RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
  FROM employees
) x
WHERE rnk <= 3;
```

2. Departments where total salary > 500,000:  
```sql
SELECT department, SUM(salary) AS total_sal
FROM employees
GROUP BY department
HAVING SUM(salary) > 500000;
```

3. Employees above overall avg salary:  
```sql
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

4. Employees above dept avg salary:  
```sql
SELECT e.*
FROM employees e
JOIN (
  SELECT department, AVG(salary) AS avg_sal
  FROM employees
  GROUP BY department
) d ON e.department=d.department
WHERE e.salary > d.avg_sal;
```

5. Top 2 newest hires per department:  
```sql
SELECT department, first_name, last_name, hire_date
FROM (
  SELECT department, first_name, last_name, hire_date,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY hire_date DESC) AS rn
  FROM employees
) x
WHERE rn <= 2;
```

6. Department with highest avg salary:  
```sql
WITH dept_avg AS (
  SELECT department, AVG(salary) AS avg_sal
  FROM employees
  GROUP BY department
)
SELECT * FROM dept_avg ORDER BY avg_sal DESC LIMIT 1;
```

7. Employees hired before 2010 with salary > avg of pre-2010 employees:  
```sql
SELECT * FROM employees
WHERE hire_date < '2010-01-01'
  AND salary > (SELECT AVG(salary) FROM employees WHERE hire_date < '2010-01-01');
```

8. Cumulative salary per department ordered by hire_date:  
```sql
SELECT department, first_name, hire_date, salary,
       SUM(salary) OVER (PARTITION BY department ORDER BY hire_date) AS cumulative_salary
FROM employees;
```

9. Rank departments by total salary expense:  
```sql
WITH dept_sum AS (
  SELECT department, SUM(salary) AS total_sal
  FROM employees
  GROUP BY department
)
SELECT department, total_sal,
       RANK() OVER (ORDER BY total_sal DESC) AS dept_rank
FROM dept_sum;
```

10. Employees in top 10% salaries:  
```sql
WITH ranked AS (
  SELECT emp_id, first_name, last_name, salary,
         PERCENT_RANK() OVER (ORDER BY salary DESC) AS pct
  FROM employees
)
SELECT * FROM ranked WHERE pct <= 0.1;
```

