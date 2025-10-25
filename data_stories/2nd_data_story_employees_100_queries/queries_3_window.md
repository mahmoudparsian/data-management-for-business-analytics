# Employees — 30 Intermediate Queries (CTEs + Ranking/Window Functions)

### Q1. Top 5 highest salaries overall using ROW_NUMBER.
```sql
WITH ranked AS (
  SELECT emp_id, first_name, last_name, salary,
         ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
  FROM employees
)
SELECT * FROM ranked WHERE rn <= 5;
```

### Q2. Top 3 highest salaries per department (RANK).
```sql
WITH ranked AS (
  SELECT emp_id, first_name, last_name, department, salary,
         RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
  FROM employees
)
SELECT * FROM ranked WHERE rnk <= 3 ORDER BY department, rnk, salary DESC;
```

### Q3. Top earner per country (DENSE_RANK).
```sql
WITH ranked AS (
  SELECT emp_id, first_name, last_name, country, salary,
         DENSE_RANK() OVER (PARTITION BY country ORDER BY salary DESC) AS dr
  FROM employees
)
SELECT * FROM ranked WHERE dr = 1 ORDER BY country;
```

### Q4. Salary percentile per department (NTILE quartiles).
```sql
SELECT emp_id, first_name, last_name, department, salary,
       NTILE(4) OVER (PARTITION BY department ORDER BY salary) AS salary_quartile
FROM employees;
```

### Q5. Find employees above department average salary.
```sql
WITH dept_avg AS (
  SELECT department, AVG(salary) AS avg_sal
  FROM employees
  GROUP BY department
)
SELECT e.*
FROM employees e
JOIN dept_avg a ON e.department=a.department
WHERE e.salary > a.avg_sal;
```

### Q6. Difference to department max salary using window MAX.
```sql
SELECT emp_id, first_name, last_name, department, salary,
       (MAX(salary) OVER (PARTITION BY department) - salary) AS diff_to_dept_max
FROM employees;
```

### Q7. Running total of salaries per department by join date.
```sql
SELECT emp_id, first_name, last_name, department, date_joined, salary,
       SUM(salary) OVER (PARTITION BY department ORDER BY date_joined ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM employees
ORDER BY department, date_joined;
```

### Q8. Employee rank by age within country.
```sql
SELECT emp_id, first_name, last_name, country, age,
       RANK() OVER (PARTITION BY country ORDER BY age DESC) AS age_rank_in_country
FROM employees;
```

### Q9. Earliest joiner per department.
```sql
WITH ranked AS (
  SELECT emp_id, first_name, last_name, department, date_joined,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY date_joined ASC) AS rn
  FROM employees
)
SELECT * FROM ranked WHERE rn=1;
```

### Q10. Latest joiner per department.
```sql
WITH ranked AS (
  SELECT emp_id, first_name, last_name, department, date_joined,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY date_joined DESC) AS rn
  FROM employees
)
SELECT * FROM ranked WHERE rn=1;
```

### Q11. Employees whose salary is within top 20% company-wide.
```sql
WITH ranked AS (
  SELECT emp_id, salary,
         NTILE(5) OVER (ORDER BY salary DESC) AS tile
  FROM employees
)
SELECT * FROM employees e JOIN ranked r USING (emp_id) WHERE tile=1;
```

### Q12. Department-wise salary z-score (using dept avg and stddev window).
```sql
SELECT emp_id, first_name, last_name, department, salary,
       (salary - AVG(salary) OVER (PARTITION BY department)) / NULLIF(STDDEV_SAMP(salary) OVER (PARTITION BY department),0) AS zscore_dept
FROM employees;
```

### Q13. Year-over-year hires with LAG.
```sql
WITH hires AS (
  SELECT YEAR(date_joined) AS yr, COUNT(*) AS hires
  FROM employees
  GROUP BY YEAR(date_joined)
)
SELECT yr, hires,
       hires - LAG(hires) OVER (ORDER BY yr) AS yoy_change
FROM hires
ORDER BY yr;
```

### Q14. Salary growth vs previous joiner in same department (LAG).
```sql
WITH dept_sorted AS (
  SELECT emp_id, first_name, last_name, department, date_joined, salary,
         LAG(salary) OVER (PARTITION BY department ORDER BY date_joined) AS prev_salary
  FROM employees
)
SELECT *, (salary - prev_salary) AS delta_vs_prev
FROM dept_sorted
ORDER BY department, date_joined;
```

### Q15. Next joiner per department with LEAD.
```sql
SELECT emp_id, first_name, last_name, department, date_joined,
       LEAD(emp_id) OVER (PARTITION BY department ORDER BY date_joined) AS next_emp_id
FROM employees
ORDER BY department, date_joined;
```

### Q16. Employees within top 3 oldest per department (DENSE_RANK).
```sql
WITH ranked AS (
  SELECT emp_id, first_name, last_name, department, age,
         DENSE_RANK() OVER (PARTITION BY department ORDER BY age DESC) AS rk
  FROM employees
)
SELECT * FROM ranked WHERE rk <= 3 ORDER BY department, rk, age DESC;
```

### Q17. Find median salary overall via PERCENTILE_CONT.
```sql
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary) AS median_salary FROM employees;
```

### Q18. Top 2 by salary per country and gender.
```sql
WITH ranked AS (
  SELECT emp_id, first_name, last_name, country, gender, salary,
         ROW_NUMBER() OVER (PARTITION BY country, gender ORDER BY salary DESC) AS rn
  FROM employees
)
SELECT * FROM ranked WHERE rn <= 2 ORDER BY country, gender, salary DESC;
```

### Q19. Department headcount and share using window SUM.
```sql
SELECT department,
       COUNT(*) AS dept_count,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_company
FROM employees
GROUP BY department
ORDER BY dept_count DESC;
```

### Q20. Find employees in bottom decile of salary (NTILE 10).
```sql
WITH bins AS (
  SELECT emp_id, NTILE(10) OVER (ORDER BY salary ASC) AS decile
  FROM employees
)
SELECT e.* FROM employees e JOIN bins b USING(emp_id) WHERE b.decile = 1;
```

### Q21. Rank employees by tenure company-wide.
```sql
SELECT emp_id, first_name, last_name, date_joined,
       RANK() OVER (ORDER BY date_joined ASC) AS tenure_rank
FROM employees
ORDER BY tenure_rank;
```

### Q22. Longest-tenured per department.
```sql
WITH ranked AS (
  SELECT emp_id, first_name, last_name, department, date_joined,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY date_joined ASC) AS rn
  FROM employees
)
SELECT * FROM ranked WHERE rn=1;
```

### Q23. Compare salary to country average with window AVG.
```sql
SELECT emp_id, first_name, last_name, country, salary,
       salary - AVG(salary) OVER (PARTITION BY country) AS diff_vs_country_avg
FROM employees
ORDER BY country, diff_vs_country_avg DESC;
```

### Q24. Employees who are local top earners (salary > P80 in dept).
```sql
WITH p80 AS (
  SELECT department, PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY salary) AS p80
  FROM employees
  GROUP BY department
)
SELECT e.*
FROM employees e
JOIN p80 p ON e.department=p.department
WHERE e.salary > p.p80;
```

### Q25. Top 1% approximately: top employee by salary per entire company (ROW_NUMBER=1).
```sql
WITH ranked AS (
  SELECT emp_id, ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
  FROM employees
)
SELECT e.* FROM employees e JOIN ranked r USING(emp_id) WHERE r.rn=1;
```

### Q26. Employees whose salary is higher than their country's median (join to percentile).
```sql
WITH med AS (
  SELECT country, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary) AS med_sal
  FROM employees
  GROUP BY country
)
SELECT e.* FROM employees e
JOIN med m ON e.country=m.country
WHERE e.salary > m.med_sal;
```

### Q27. Age vs department median age.
```sql
WITH med AS (
  SELECT department, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY age) AS med_age
  FROM employees
  GROUP BY department
)
SELECT e.*, (e.age - m.med_age) AS delta_age
FROM employees e
JOIN med m ON e.department=m.department;
```

### Q28. Employees near department average (within ±5k).
```sql
WITH avgd AS (
  SELECT department, AVG(salary) AS avg_sal FROM employees GROUP BY department
)
SELECT e.*
FROM employees e
JOIN avgd a ON e.department=a.department
WHERE ABS(e.salary - a.avg_sal) <= 5000;
```

### Q29. Windowed cumulative hire count by country over time.
```sql
SELECT country, date_joined,
       COUNT(*) OVER (PARTITION BY country ORDER BY date_joined ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cum_hires
FROM employees
ORDER BY country, date_joined;
```

