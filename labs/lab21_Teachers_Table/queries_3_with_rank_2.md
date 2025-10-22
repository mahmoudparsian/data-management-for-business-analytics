# Teachers Table - Intermediate++ Queries (20)

1. Find teachers with salary above average.
```sql
WITH avg_sal AS (SELECT AVG(salary) AS avg_salary FROM teachers)
SELECT * FROM teachers WHERE salary > (SELECT avg_salary FROM avg_sal);
```

2. Rank teachers by salary within each school.
```sql
SELECT id, first_name, last_name, school, salary,
       RANK() OVER (PARTITION BY school ORDER BY salary DESC) AS rank_in_school
FROM teachers;
```

3. Find top 3 highest paid teachers overall.
```sql
SELECT * FROM (
  SELECT id, first_name, last_name, salary,
         DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
  FROM teachers
) t WHERE rnk <= 3;
```

4. Find top 2 salaries per department.
```sql
SELECT * FROM (
  SELECT id, first_name, last_name, department, salary,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn
  FROM teachers
) t WHERE rn <= 2;
```

5. Find average salary per school using CTE.
```sql
WITH avg_school AS (
  SELECT school, AVG(salary) AS avg_salary
  FROM teachers GROUP BY school
)
SELECT * FROM avg_school;
```

6. Find departments with above-average salary.
```sql
WITH dept_avg AS (
  SELECT department, AVG(salary) AS avg_salary FROM teachers GROUP BY department
)
SELECT * FROM dept_avg WHERE avg_salary > (SELECT AVG(salary) FROM teachers);
```

7. Find schools where max salary > 190,000.
```sql
WITH max_sal AS (
  SELECT school, MAX(salary) AS max_salary FROM teachers GROUP BY school
)
SELECT * FROM max_sal WHERE max_salary > 190000;
```

8. Rank teachers within each department by hire_year.
```sql
SELECT id, first_name, last_name, department, hire_year,
       ROW_NUMBER() OVER (PARTITION BY department ORDER BY hire_year) AS hire_rank
FROM teachers;
```

9. Find the earliest hired teacher in each school.
```sql
SELECT * FROM (
  SELECT id, first_name, last_name, school, hire_year,
         ROW_NUMBER() OVER (PARTITION BY school ORDER BY hire_year ASC) AS rn
  FROM teachers
) t WHERE rn = 1;
```

10. Find countries with more than average number of teachers.
```sql
WITH country_counts AS (
  SELECT country, COUNT(*) AS cnt FROM teachers GROUP BY country
)
SELECT * FROM country_counts WHERE cnt > (SELECT AVG(cnt) FROM country_counts);
```

11. Find average salary difference from school average.
```sql
WITH school_avg AS (
  SELECT school, AVG(salary) AS avg_salary FROM teachers GROUP BY school
)
SELECT t.id, t.first_name, t.last_name, t.school, t.salary, (t.salary - s.avg_salary) AS diff
FROM teachers t JOIN school_avg s ON t.school = s.school;
```

12. Find second highest salary per department.
```sql
SELECT * FROM (
  SELECT id, department, salary,
         DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
  FROM teachers
) t WHERE rnk = 2;
```

13. Find teachers earning more than departmental average.
```sql
WITH dept_avg AS (
  SELECT department, AVG(salary) AS avg_salary FROM teachers GROUP BY department
)
SELECT t.* FROM teachers t JOIN dept_avg d ON t.department = d.department
WHERE t.salary > d.avg_salary;
```

14. Show department salary rankings.
```sql
SELECT department, id, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_salary
FROM teachers;
```

15. Find schools with the youngest hire year teacher.
```sql
WITH youngest AS (
  SELECT school, MIN(hire_year) AS min_hire FROM teachers GROUP BY school
)
SELECT * FROM youngest;
```

16. Show cumulative salary per country.
```sql
SELECT country, id, salary,
       SUM(salary) OVER (PARTITION BY country ORDER BY salary) AS running_total
FROM teachers;
```

17. Find top 5 earners in Harvard.
```sql
SELECT * FROM (
  SELECT id, first_name, last_name, salary,
         ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
  FROM teachers WHERE school = 'Harvard'
) t WHERE rn <= 5;
```

18. Find median-like salary (using ranking).
```sql
SELECT id, salary FROM (
  SELECT id, salary,
         ROW_NUMBER() OVER (ORDER BY salary) AS rn,
         COUNT(*) OVER () AS total
  FROM teachers
) t WHERE rn = FLOOR((total+1)/2) OR rn = CEIL((total+1)/2);
```

19. Find schools where average salary exceeds country average.
```sql
WITH country_avg AS (
  SELECT country, AVG(salary) AS avg_salary FROM teachers GROUP BY country
)
SELECT s.school, AVG(s.salary) AS school_avg, c.avg_salary AS country_avg
FROM teachers s JOIN country_avg c ON s.country = c.country
GROUP BY s.school, c.avg_salary
HAVING school_avg > c.avg_salary;
```

20. Find teachers hired earliest in each country.
```sql
SELECT * FROM (
  SELECT id, first_name, last_name, country, hire_year,
         ROW_NUMBER() OVER (PARTITION BY country ORDER BY hire_year ASC) AS rn
  FROM teachers
) t WHERE rn = 1;
```
