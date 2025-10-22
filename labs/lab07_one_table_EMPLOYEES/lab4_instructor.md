# 📘 Lab 4 (Instructor Version): Window Functions & Ranking (Employees Table)

## Solutions

1. Rank employees by salary:  
```sql
SELECT first_name, last_name, salary,
       RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;
```

2. Row number by hire date:  
```sql
SELECT first_name, last_name, hire_date,
       ROW_NUMBER() OVER (ORDER BY hire_date ASC) AS hire_order
FROM employees;
```

3. Dense rank by salary:  
```sql
SELECT first_name, last_name, salary,
       DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank
FROM employees;
```

4. Percent rank by salary:  
```sql
SELECT first_name, last_name, salary,
       PERCENT_RANK() OVER (ORDER BY salary DESC) AS pct_rank
FROM employees;
```

5. Rank within each department:  
```sql
SELECT department, first_name, last_name, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rank
FROM employees;
```

6. Running total of salaries:  
```sql
SELECT emp_id, first_name, salary,
       SUM(salary) OVER (ORDER BY emp_id) AS running_total
FROM employees;
```

7. Average salary within each department:  
```sql
SELECT department, first_name, salary,
       AVG(salary) OVER (PARTITION BY department) AS dept_avg
FROM employees;
```

8. Difference from dept avg:  
```sql
SELECT department, first_name, salary,
       salary - AVG(salary) OVER (PARTITION BY department) AS diff_from_avg
FROM employees;
```

9. Flag newest hire in each department:  
```sql
SELECT emp_id, first_name, department, hire_date,
       CASE WHEN hire_date = MAX(hire_date) OVER (PARTITION BY department)
            THEN 'Newest' ELSE '' END AS flag
FROM employees;
```

10. Oldest hire in each department:  
```sql
SELECT emp_id, first_name, department, hire_date
FROM (
  SELECT emp_id, first_name, department, hire_date,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY hire_date ASC) AS rn
  FROM employees
) x
WHERE rn=1;
```

