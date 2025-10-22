# Lab-5 – Intermediate to Advanced (30 queries)

> Table: `employees(emp_id, first_name, last_name, age, degree, gender, country, department, hire_date, salary)`

### 1. RANK salary within department.
```sql
SELECT emp_id, first_name, department, salary, RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk FROM employees ORDER BY department, rnk;
```

### 2. Top 5 earners per country (ROW_NUMBER).
```sql
WITH r AS (SELECT emp_id, first_name, country, salary, ROW_NUMBER() OVER (PARTITION BY country ORDER BY salary DESC) AS rn FROM employees)
SELECT * FROM r WHERE rn<=5 ORDER BY country, salary DESC;
```

### 3. Top 3 youngest per department (DENSE_RANK).
```sql
WITH r AS (SELECT emp_id, first_name, department, age, DENSE_RANK() OVER (PARTITION BY department ORDER BY age ASC) AS rnk FROM employees)
SELECT * FROM r WHERE rnk<=3 ORDER BY department, age;
```

### 4. Dept payroll and each employee's share.
```sql
WITH d AS (SELECT department, SUM(salary) AS dep_pay FROM employees GROUP BY department)
SELECT e.emp_id, e.department, e.salary, ROUND(e.salary*100.0/d.dep_pay,2) AS pct FROM employees e JOIN d ON e.department=d.department ORDER BY department, pct DESC;
```

### 5. Running headcount by hire_date.
```sql
WITH d AS (SELECT hire_date, COUNT(*) AS n FROM employees GROUP BY hire_date)
SELECT hire_date, n, SUM(n) OVER (ORDER BY hire_date) AS running FROM d ORDER BY hire_date;
```

### 6. Country headcount percentage.
```sql
WITH t AS (SELECT COUNT(*) AS total FROM employees)
SELECT country, ROUND(COUNT(*)*100.0/(SELECT total FROM t),2) AS pct FROM employees GROUP BY country ORDER BY pct DESC;
```

### 7. Outliers: salary > mean + 2*std (dept).
```sql
WITH s AS (SELECT department, AVG(salary) AS a, STDDEV_POP(salary) AS sd FROM employees GROUP BY department)
SELECT e.emp_id, e.department, e.salary FROM employees e JOIN s ON e.department=s.department WHERE e.salary > s.a + 2*s.sd ORDER BY e.salary DESC;
```

### 8. Salary above both country & degree avgs.
```sql
WITH c AS (SELECT country, AVG(salary) AS a FROM employees GROUP BY country), d AS (SELECT degree, AVG(salary) AS a FROM employees GROUP BY degree)
SELECT e.emp_id, e.first_name, e.salary, e.country, e.degree FROM employees e JOIN c ON e.country=c.country JOIN d ON e.degree=d.degree WHERE e.salary > c.a AND e.salary > d.a ORDER BY e.salary DESC;
```

### 9. Department quartiles via NTILE(4).
```sql
SELECT emp_id, department, salary, NTILE(4) OVER (PARTITION BY department ORDER BY salary) AS q FROM employees ORDER BY department, q;
```

### 10. Global deciles via NTILE(10).
```sql
SELECT emp_id, salary, NTILE(10) OVER (ORDER BY salary) AS decile FROM employees ORDER BY decile, salary;
```

### 11. Approx median per department (PERCENT_RANK).
```sql
WITH r AS (SELECT department, salary, PERCENT_RANK() OVER (PARTITION BY department ORDER BY salary) AS p FROM employees)
SELECT department, MIN(salary) AS approx_median FROM r WHERE p>=0.5 GROUP BY department;
```

### 12. Top 20% earners in each department (CUME_DIST).
```sql
WITH r AS (SELECT emp_id, department, salary, CUME_DIST() OVER (PARTITION BY department ORDER BY salary DESC) AS cd FROM employees)
SELECT emp_id, department, salary FROM r WHERE cd <= 0.20 ORDER BY department, salary DESC;
```

### 13. Top department by avg salary per country.
```sql
WITH a AS (SELECT country, department, AVG(salary) AS a FROM employees GROUP BY country, department), r AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY country ORDER BY a DESC) AS rn FROM a)
SELECT country, department, ROUND(a) AS avg_sal FROM r WHERE rn=1 ORDER BY country;
```

### 14. Top country by headcount per degree.
```sql
WITH x AS (SELECT degree, country, COUNT(*) AS n FROM employees GROUP BY degree, country), r AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY degree ORDER BY n DESC, country ASC) AS rn FROM x)
SELECT degree, country, n FROM r WHERE rn=1 ORDER BY degree;
```

### 15. Age z-score within department.
```sql
WITH a AS (SELECT department, AVG(age) AS a, STDDEV_POP(age) AS sd FROM employees GROUP BY department)
SELECT e.emp_id, e.department, e.age, ROUND((e.age-a.a)/NULLIF(a.sd,0),2) AS z FROM employees e JOIN a ON e.department=a.department ORDER BY z DESC LIMIT 20;
```

### 16. YOY hires by department (pivot-like).
```sql
SELECT department,
  SUM(CASE WHEN YEAR(hire_date)=2020 THEN 1 ELSE 0 END) AS y2020,
  SUM(CASE WHEN YEAR(hire_date)=2021 THEN 1 ELSE 0 END) AS y2021,
  SUM(CASE WHEN YEAR(hire_date)=2022 THEN 1 ELSE 0 END) AS y2022,
  SUM(CASE WHEN YEAR(hire_date)=2023 THEN 1 ELSE 0 END) AS y2023,
  SUM(CASE WHEN YEAR(hire_date)=2024 THEN 1 ELSE 0 END) AS y2024,
  SUM(CASE WHEN YEAR(hire_date)=2025 THEN 1 ELSE 0 END) AS y2025
FROM employees GROUP BY department;
```

### 17. Tenure (days) since hire (today).
```sql
SELECT emp_id, first_name, DATEDIFF(CURDATE(), hire_date) AS tenure_days FROM employees ORDER BY tenure_days DESC LIMIT 20;
```

### 18. Top 3 first names overall (ROW_NUMBER).
```sql
WITH x AS (SELECT first_name, COUNT(*) AS n FROM employees GROUP BY first_name), r AS (SELECT *, ROW_NUMBER() OVER (ORDER BY n DESC, first_name ASC) AS rn FROM x)
SELECT first_name, n FROM r WHERE rn<=3;
```

### 19. Above dept & global average salary.
```sql
WITH d AS (SELECT department, AVG(salary) AS a FROM employees GROUP BY department), g AS (SELECT AVG(salary) AS a FROM employees)
SELECT e.emp_id, e.first_name, e.department, e.salary FROM employees e, d, g WHERE e.department=d.department AND e.salary > d.a AND e.salary > g.a ORDER BY e.salary DESC;
```

### 20. Top salary per (country, degree).
```sql
WITH r AS (SELECT emp_id, country, degree, salary, ROW_NUMBER() OVER (PARTITION BY country, degree ORDER BY salary DESC) AS rn FROM employees)
SELECT * FROM r WHERE rn=1 ORDER BY country, degree;
```

### 21. Top 2 departments by headcount per hire year.
```sql
WITH x AS (SELECT YEAR(hire_date) AS yr, department, COUNT(*) AS n FROM employees GROUP BY YEAR(hire_date), department), r AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY yr ORDER BY n DESC) AS rn FROM x)
SELECT yr, department, n FROM r WHERE rn<=2 ORDER BY yr, n DESC;
```

### 22. Top 10% oldest per department.
```sql
WITH r AS (SELECT emp_id, department, age, CUME_DIST() OVER (PARTITION BY department ORDER BY age DESC) AS cd FROM employees)
SELECT emp_id, department, age FROM r WHERE cd <= 0.10 ORDER BY department, age DESC;
```

### 23. Common (degree, department) pairs (top 10).
```sql
SELECT degree, department, COUNT(*) AS n FROM employees GROUP BY degree, department ORDER BY n DESC LIMIT 10;
```

### 24. Below both country & degree averages.
```sql
WITH c AS (SELECT country, AVG(salary) AS a FROM employees GROUP BY country), d AS (SELECT degree, AVG(salary) AS a FROM employees GROUP BY degree)
SELECT e.emp_id, e.first_name, e.salary, e.country, e.degree FROM employees e JOIN c ON e.country=c.country JOIN d ON e.degree=d.degree WHERE e.salary < c.a AND e.salary < d.a ORDER BY e.salary ASC;
```

### 25. Approx 75th percentile per department (NTILE).
```sql
WITH r AS (SELECT department, salary, NTILE(4) OVER (PARTITION BY department ORDER BY salary) AS q FROM employees)
SELECT department, MIN(salary) AS approx_p75 FROM r WHERE q=4 GROUP BY department;
```

### 26. Country share within each degree (percentage).
```sql
WITH x AS (SELECT degree, country, COUNT(*) AS n FROM employees GROUP BY degree, country), t AS (SELECT degree, SUM(n) AS tot FROM x GROUP BY degree)
SELECT x.degree, x.country, ROUND(x.n*100.0/t.tot,2) AS pct FROM x JOIN t ON x.degree=t.degree ORDER BY degree, pct DESC;
```

### 27. Top 5 global earners.
```sql
SELECT emp_id, first_name, country, department, salary FROM employees ORDER BY salary DESC LIMIT 5;
```

