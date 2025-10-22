# Week 3 – Instructor Solutions

1)  
```sql
SELECT * FROM employees_filter WHERE dept='Engineering';
```

2)  
```sql
SELECT * FROM employees_filter WHERE dept <> 'Sales';
```

3)  
```sql
SELECT * FROM employees_filter WHERE salary > 90000;
```

4)  
```sql
SELECT * FROM employees_filter WHERE hire_date > '2021-01-01';
```

5)  
```sql
SELECT * FROM employees_filter WHERE bonus IS NULL;
```

6)  
```sql
SELECT * FROM employees_filter WHERE bonus IS NOT NULL;
```

7)  
```sql
SELECT * FROM employees_filter WHERE age BETWEEN 30 AND 40;
```

8)  
```sql
SELECT * FROM employees_filter WHERE name LIKE '%a%';
```

9)  
```sql
SELECT * FROM employees_filter WHERE dept IN ('HR','Marketing') ORDER BY age;
```

10)  
```sql
SELECT * FROM employees_filter 
WHERE dept='Engineering' 
ORDER BY salary DESC LIMIT 2;
```

11)  
```sql
SELECT COUNT(*) AS with_bonus FROM employees_filter WHERE bonus IS NOT NULL;
```

12)  
```sql
SELECT AVG(salary) AS avg_sales FROM employees_filter WHERE dept='Sales';
```
