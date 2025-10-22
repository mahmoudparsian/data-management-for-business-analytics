# 📘 Lab 3 (Instructor Version): Subqueries (Employees Table)

## Solutions

1. Employees earning more than avg salary:  
```sql
SELECT * FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);
```

2. Employees with max salary:  
```sql
SELECT * FROM employees WHERE salary = (SELECT MAX(salary) FROM employees);
```

3. Departments with highest avg salary:  
```sql
WITH dept_avg AS (
  SELECT department, AVG(salary) AS avg_sal FROM employees GROUP BY department
)
SELECT * FROM dept_avg ORDER BY avg_sal DESC LIMIT 1;
```

4. Employees hired in same year as Alice Smith:  
```sql
SELECT * FROM employees
WHERE YEAR(hire_date) = (SELECT YEAR(hire_date)
                         FROM employees
                         WHERE first_name='Alice' AND last_name='Smith');
```

5. Employees in departments with >8 employees:  
```sql
SELECT * FROM employees
WHERE department IN (
  SELECT department FROM employees GROUP BY department HAVING COUNT(*) > 8
);
```

6. Top 3 highest-paid employees:  
```sql
SELECT * FROM employees ORDER BY salary DESC LIMIT 3;
```

7. Employees in smallest department:  
```sql
WITH dept_count AS (
  SELECT department, COUNT(*) AS c FROM employees GROUP BY department
)
SELECT * FROM employees
WHERE department=(SELECT department FROM dept_count ORDER BY c ASC LIMIT 1);
```

8. Highest-paid employee in IT:  
```sql
SELECT * FROM employees WHERE department='IT' ORDER BY salary DESC LIMIT 1;
```

9. Employees earning less than dept avg:  
```sql
SELECT e.* FROM employees e
JOIN (SELECT department, AVG(salary) AS avg_sal FROM employees GROUP BY department) d
ON e.department=d.department
WHERE e.salary < d.avg_sal;
```

10. Employees hired before 2010 and salary > 90000:  
```sql
SELECT * FROM employees WHERE hire_date < '2010-01-01' AND salary > 90000;
```

