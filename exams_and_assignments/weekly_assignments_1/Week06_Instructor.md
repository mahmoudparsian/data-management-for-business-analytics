# Week 6 – Instructor Solutions

1)  
```sql
SELECT * FROM emps WHERE salary > (SELECT AVG(salary) FROM emps);
```

2)  
```sql
SELECT d.dept_name, AVG(e.salary) AS avg_sal
FROM depts d JOIN emps e ON d.dept_id=e.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > 90000;
```

3)  
```sql
SELECT e1.*
FROM emps e1
JOIN (
  SELECT dept_id, AVG(salary) AS avg_sal
  FROM emps GROUP BY dept_id
) a ON e1.dept_id=a.dept_id
WHERE e1.salary > a.avg_sal;
```

4)  
```sql
SELECT d.dept_name, x.cnt
FROM depts d
JOIN (SELECT dept_id, COUNT(*) AS cnt FROM emps GROUP BY dept_id) x
  ON d.dept_id=x.dept_id;
```

5)  
```sql
WITH avg_dept AS (
  SELECT dept_id, AVG(salary) AS avg_sal FROM emps GROUP BY dept_id
)
SELECT e.*
FROM emps e JOIN avg_dept a ON e.dept_id=a.dept_id
WHERE e.salary > a.avg_sal;
```

6)  
```sql
SELECT d.dept_name, e.name, e.salary
FROM depts d
JOIN emps e ON d.dept_id=e.dept_id
WHERE (d.dept_id, e.salary) IN (
  SELECT dept_id, MAX(salary) FROM emps GROUP BY dept_id
);
```

7)  
```sql
SELECT d.dept_name
FROM depts d
JOIN emps e ON d.dept_id=e.dept_id
GROUP BY d.dept_name
HAVING COUNT(*) >= 2;
```

8)  
```sql
SELECT e.* FROM emps e
WHERE e.dept_id IN (
  SELECT dept_id FROM emps WHERE salary > 100000
);
```

9)  
```sql
SELECT d.* FROM depts d
WHERE NOT EXISTS (
  SELECT 1 FROM emps e WHERE e.dept_id=d.dept_id
);
```
*Expected:* none in current data.

10)  
```sql
SELECT * FROM emps 
WHERE salary >= (
  SELECT MIN(salary) FROM (
    SELECT salary FROM emps ORDER BY salary DESC LIMIT 2
  ) t
);
```

11)  
```sql
WITH g AS (SELECT AVG(salary) AS avg_sal FROM emps)
SELECT e.* FROM emps e, g WHERE e.salary > g.avg_sal;
```

12)  
```sql
WITH c AS (
  SELECT dept_id, COUNT(*) AS cnt FROM emps GROUP BY dept_id
)
SELECT d.dept_name, c.cnt
FROM depts d JOIN c ON d.dept_id=c.dept_id
WHERE c.cnt >= 2;
```
