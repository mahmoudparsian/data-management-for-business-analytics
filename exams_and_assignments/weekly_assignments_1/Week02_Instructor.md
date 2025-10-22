# Week 2 – Instructor Solutions

1)  
```sql
SELECT * FROM employees_basic;
```

2)  
```sql
SELECT name, salary FROM employees_basic;
```

3)  
```sql
SELECT name, salary*1.10 AS new_salary FROM employees_basic;
```

4)  
```sql
SELECT name AS employee_name FROM employees_basic;
```

5)  
```sql
SELECT DISTINCT age FROM employees_basic;
```

6)  
```sql
SELECT * FROM employees_basic ORDER BY salary DESC;
```

7)  
```sql
SELECT * FROM employees_basic ORDER BY salary DESC LIMIT 3;
```

8)  
```sql
SELECT * FROM employees_basic WHERE salary BETWEEN 75000 AND 100000;
```

9)  
```sql
SELECT * FROM employees_basic WHERE age > 40;
```

10)  
```sql
SELECT * FROM employees_basic WHERE name LIKE 'E%';
```

11)  
```sql
SELECT CONCAT(name,' (',age,')') AS label FROM employees_basic;
```

12)  
```sql
SELECT name, ROUND(salary) AS salary_rounded FROM employees_basic;
```
