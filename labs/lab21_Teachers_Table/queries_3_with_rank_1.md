# 20 Queries – GROUP BY + Subqueries (WITH) + Ranking

1. **Top earner per school (ties included with RANK)**  
```sql
WITH ranked AS (
  SELECT school, first_name, last_name, salary,
         RANK() OVER (PARTITION BY school ORDER BY salary DESC) AS rnk
  FROM teachers
)
SELECT school, first_name, last_name, salary
FROM ranked WHERE rnk = 1;
```

2. **Top 3 salaries per department**  
```sql
WITH x AS (
  SELECT department, first_name, last_name, salary,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn
  FROM teachers
)
SELECT * FROM x WHERE rn <= 3 ORDER BY department, salary DESC;
```

3. **Teachers earning above their country's average**  
```sql
WITH c AS (SELECT country, AVG(salary) AS avg_sal FROM teachers GROUP BY country)
SELECT t.* FROM teachers t JOIN c ON t.country=c.country
WHERE t.salary > c.avg_sal;
```

4. **Most common degree per country (by count, using ROW_NUMBER)**  
```sql
WITH dc AS (
  SELECT country, degree, COUNT(*) AS cnt
  FROM teachers GROUP BY country, degree
), ranked AS (
  SELECT country, degree, cnt,
         ROW_NUMBER() OVER (PARTITION BY country ORDER BY cnt DESC) AS rn
  FROM dc
)
SELECT country, degree, cnt FROM ranked WHERE rn=1;
```

5. **Percentile-ish cutoff (top 10% salaries overall)**  
```sql
WITH s AS (
  SELECT salary, ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn,
         COUNT(*) OVER () AS n
  FROM teachers
)
SELECT * FROM teachers
WHERE salary >= (SELECT MIN(salary) FROM s WHERE rn <= CEIL(0.10*n));
```

6. **Schools ranked by average salary (DENSE_RANK)**  
```sql
WITH a AS (
  SELECT school, AVG(salary) AS avg_sal FROM teachers GROUP BY school
)
SELECT school, avg_sal,
       DENSE_RANK() OVER (ORDER BY avg_sal DESC) AS rnk
FROM a ORDER BY rnk;
```

7. **Running total of teachers by hire_year**  
```sql
WITH y AS (
  SELECT hire_year, COUNT(*) AS cnt FROM teachers GROUP BY hire_year
)
SELECT hire_year, cnt,
       SUM(cnt) OVER (ORDER BY hire_year) AS running_total
FROM y ORDER BY hire_year;
```

8. **Country share of total teachers (percentage)**  
```sql
WITH total AS (SELECT COUNT(*) AS n FROM teachers)
SELECT country, COUNT(*)*100.0/(SELECT n FROM total) AS pct
FROM teachers GROUP BY country ORDER BY pct DESC;
```

9. **Departments with at least 3 countries represented**  
```sql
SELECT department
FROM teachers
GROUP BY department
HAVING COUNT(DISTINCT country) >= 3;
```

10. **Salary z-score-like (per school) using AVG & STDDEV_POP**  
```sql
WITH stats AS (
  SELECT school, AVG(salary) AS a, STDDEV_POP(salary) AS sd
  FROM teachers GROUP BY school
)
SELECT t.school, t.first_name, t.last_name,
       (t.salary - s.a)/NULLIF(s.sd,0) AS z
FROM teachers t JOIN stats s ON t.school=s.school;
```

11. **Earliest hire per department (ROW_NUMBER by hire_date)**  
```sql
WITH r AS (
  SELECT department, first_name, last_name, hire_date,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY hire_date ASC) AS rn
  FROM teachers
)
SELECT department, first_name, last_name, hire_date FROM r WHERE rn=1;
```

12. **Departments sorted by % PHD**  
```sql
WITH d AS (
  SELECT department,
         SUM(CASE WHEN degree='PHD' THEN 1 ELSE 0 END) AS phds,
         COUNT(*) AS total
  FROM teachers GROUP BY department
)
SELECT department, phds*100.0/total AS phd_pct FROM d ORDER BY phd_pct DESC;
```

13. **Find countries whose average salary is above the global average**  
```sql
WITH g AS (SELECT AVG(salary) AS global_avg FROM teachers),
     c AS (SELECT country, AVG(salary) AS avg_sal FROM teachers GROUP BY country)
SELECT c.country, c.avg_sal FROM c, g WHERE c.avg_sal > g.global_avg;
```

14. **Max salary per (school, department)**  
```sql
WITH m AS (
  SELECT school, department, MAX(salary) AS max_sal
  FROM teachers GROUP BY school, department
)
SELECT * FROM m ORDER BY school;
```

15. **Rank degrees by count (overall)**  
```sql
WITH dc AS (SELECT degree, COUNT(*) AS cnt FROM teachers GROUP BY degree)
SELECT degree, cnt, RANK() OVER (ORDER BY cnt DESC) AS rnk FROM dc;
```

16. **Top earners per country (ties allowed via RANK)**  
```sql
WITH r AS (
  SELECT country, first_name, last_name, salary,
         RANK() OVER (PARTITION BY country ORDER BY salary DESC) AS rnk
  FROM teachers
)
SELECT country, first_name, last_name, salary FROM r WHERE rnk=1 ORDER BY country;
```

17. **For each department, top 5 salaries**  
```sql
WITH r AS (
  SELECT department, first_name, last_name, salary,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn
  FROM teachers
)
SELECT * FROM r WHERE rn <= 5 ORDER BY department, salary DESC;
```

18. **Schools whose median-ish salary (NTILE(2) midpoint) exceeds 160k**  
```sql
WITH n AS (
  SELECT school, salary, NTILE(2) OVER (PARTITION BY school ORDER BY salary) AS half
  FROM teachers
), mid AS (
  SELECT school, AVG(salary) AS approx_median FROM n WHERE half IN (1,2) GROUP BY school
)
SELECT * FROM mid WHERE approx_median > 160000;
```

19. **Departments where average hire_year is after 2015**  
```sql
WITH a AS (
  SELECT department, AVG(hire_year) AS avg_hy
  FROM teachers GROUP BY department
)
SELECT * FROM a WHERE avg_hy > 2015;
```

20. **Find teachers hired after their school’s average hire_year**  
```sql
WITH a AS (
  SELECT school, AVG(hire_year) AS avg_hy FROM teachers GROUP BY school
)
SELECT t.* FROM teachers t JOIN a ON t.school=a.school
WHERE t.hire_year > a.avg_hy;
```
