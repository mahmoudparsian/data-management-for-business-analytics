# Week 6 – Instructor Solutions

1) Employees earning above overall average salary (subquery).  
 
```sql
SELECT * 
FROM emps 
WHERE salary > (SELECT AVG(salary) FROM emps);
```

2) Departments with avg salary > 90k (subquery + GROUP BY).  

solution-1:

```sql
   SELECT d.dept_name, AVG(e.salary) AS avg_sal
   FROM depts d 
   JOIN emps e ON d.dept_id = e.dept_id
   GROUP BY d.dept_name
   HAVING AVG(e.salary) > 90000;
```

solution-2:

```sql
   WITH avg_salaries_table AS
   ( 
      SELECT d.dept_name, AVG(e.salary) AS avg_sal
      FROM depts d 
      JOIN emps e ON d.dept_id = e.dept_id
      GROUP BY d.dept_name
   )
   SELECT dept_name, avg_sal
   FROM avg_salaries_table
   WHERE avg_sal > 90000;
```

3) For each department, list employees whose salary > dept average (correlated).  

solution-1:
  
```sql
SELECT e1.*
FROM emps e1
JOIN (
  SELECT dept_id, AVG(salary) AS avg_sal
  FROM emps GROUP BY dept_id
) a ON e1.dept_id=a.dept_id
WHERE e1.salary > a.avg_sal;
```

solution-2:
  
```sql
WITH avg_sal_by_dept AS
(
  SELECT dept_id, AVG(salary) AS avg_sal
  FROM emps 
  GROUP BY dept_id
)
SELECT e1.*
FROM emps e1
JOIN avg_sal_by_dept a ON e1.dept_id =a .dept_id
WHERE e1.salary > a.avg_sal;
```


4) Count of employees per department using a subquery in FROM.  

solution-1:

```sql
SELECT d.dept_name, x.cnt
FROM depts d
JOIN (SELECT dept_id, COUNT(*) AS cnt FROM emps GROUP BY dept_id) x
  ON d.dept_id=x.dept_id;
```

solution-2:

```sql
WITH dept_counts_table As
(
  SELECT dept_id, COUNT(*) AS count_per_dept 
  FROM emps 
  GROUP BY dept_id
)
SELECT d.dept_name, x.count_per_dept
FROM depts d
JOIN dept_counts_table x ON d.dept_id = x.dept_id;
```

5) Use `WITH` to compute dept averages, then select employees above that.  
  
```sql
WITH avg_dept_table AS 
(
  SELECT dept_id, AVG(salary) AS avg_sal 
  FROM emps 
  GROUP BY dept_id
)
SELECT e.*
FROM emps e JOIN avg_dept_table a ON e.dept_id = a.dept_id
WHERE e.salary > a.avg_sal;
```

6) Highest-paid employee per department (subquery with MAX).  

solution-1:


```sql
SELECT d.dept_name, e.name, e.salary
FROM depts d
JOIN emps e ON d.dept_id=e.dept_id
WHERE (d.dept_id, e.salary) IN (
  SELECT dept_id, MAX(salary) 
  FROM emps 
  GROUP BY dept_id
);
```

solution-2:

```sql
WITH ranked_emps AS (
    SELECT d.dept_name, 
           e.name, 
           e.salary,
           ROW_NUMBER() OVER (PARTITION BY e.dept_id ORDER BY e.salary DESC) AS rn
    FROM depts d
    JOIN emps e ON d.dept_id = e.dept_id
)
SELECT dept_name, name, salary
FROM ranked_emps
WHERE rn = 1;
```


7) Departments with at least 2 employees (subquery with HAVING).  

solution-1:

```sql
SELECT d.dept_name, COUNT(*) as department_count
FROM depts d
JOIN emps e ON d.dept_id=e.dept_id
GROUP BY d.dept_name
HAVING COUNT(*) >= 2;
```

solution-2:

```sql
WITH dept_count_table AS
(
  SELECT d.dept_name, COUNT(*) as dept_count
  FROM depts d
  JOIN emps e ON d.dept_id = e.dept_id
  GROUP BY d.dept_name
)
SELECT dept_name, dept_count
FROM dept_count_table
WHERE  dept_count >= 2;
```


8) Employees in departments that have someone earning > 100k.  

```sql
SELECT e.* FROM emps e
WHERE e.dept_id IN (
  SELECT dept_id 
  FROM emps 
  WHERE salary > 100000
);
```

9) Departments with no employees (anti-join via NOT EXISTS).  
  
```sql
SELECT d.* 
FROM depts d
WHERE NOT EXISTS (
  SELECT 1 FROM emps e WHERE e.dept_id = d.dept_id
);
```


10) Employees whose salary is in the top 2 overall (LIMIT in subquery).  

```sql
SELECT * FROM emps 
WHERE salary >= (
  SELECT MIN(salary) FROM (
    SELECT salary FROM emps ORDER BY salary DESC LIMIT 2
  ) t
);
```

11) Reuse a CTE to compute global average and list above-average employees.  

```sql
WITH g AS 
(
  SELECT AVG(salary) AS avg_sal 
  FROM emps
)
SELECT e.* 
FROM emps e, g 
WHERE e.salary > g.avg_sal;
```

12) Show department and number of employees using a CTE, then filter count >= 2. 

```sql
WITH c AS 
(
  SELECT dept_id, COUNT(*) AS count_per_dept 
  FROM emps 
  GROUP BY dept_id
)
SELECT d.dept_name, c.count_per_dept
FROM depts d 
JOIN c ON d.dept_id = c.dept_id
WHERE c.count_per_dept >= 2;
```
