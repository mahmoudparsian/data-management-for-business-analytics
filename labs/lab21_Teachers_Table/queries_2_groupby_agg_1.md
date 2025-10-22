# 20 Aggregation / GROUP BY Queries

1. **Total number of teachers**  
```sql
SELECT COUNT(*) AS total_teachers FROM teachers;
```

2. **Average salary overall**  
```sql
SELECT AVG(salary) AS avg_salary FROM teachers;
```

3. **Min/Max salary overall**  
```sql
SELECT MIN(salary) AS min_salary, MAX(salary) AS max_salary FROM teachers;
```

4. **Teachers per country**  
```sql
SELECT country, COUNT(*) AS cnt FROM teachers GROUP BY country ORDER BY cnt DESC;
```

5. **Average salary by country**  
```sql
SELECT country, AVG(salary) AS avg_salary FROM teachers GROUP BY country ORDER BY avg_salary DESC;
```

6. **Teachers per school**  
```sql
SELECT school, COUNT(*) AS cnt FROM teachers GROUP BY school ORDER BY cnt DESC;
```

7. **Average salary by school**  
```sql
SELECT school, AVG(salary) AS avg_salary FROM teachers GROUP BY school ORDER BY avg_salary DESC;
```

8. **Teachers per department**  
```sql
SELECT department, COUNT(*) AS cnt FROM teachers GROUP BY department ORDER BY cnt DESC;
```

9. **Average salary by department**  
```sql
SELECT department, AVG(salary) AS avg_salary FROM teachers GROUP BY department ORDER BY avg_salary DESC;
```

10. **PHD share by school (percentage)**  
```sql
SELECT school,
       100.0*SUM(CASE WHEN degree='PHD' THEN 1 ELSE 0 END)/COUNT(*) AS phd_pct
FROM teachers
GROUP BY school
ORDER BY phd_pct DESC;
```

11. **Top-3 schools by average salary**  
```sql
SELECT school, AVG(salary) AS avg_salary
FROM teachers
GROUP BY school
ORDER BY avg_salary DESC
LIMIT 3;
```

12. **Countries with avg salary > 160k**  
```sql
SELECT country, AVG(salary) AS avg_salary
FROM teachers
GROUP BY country
HAVING AVG(salary) > 160000;
```

13. **Departments with > 1500 teachers**  
```sql
SELECT department, COUNT(*) AS cnt
FROM teachers
GROUP BY department
HAVING COUNT(*) > 1500;
```

14. **Average hire year by school**  
```sql
SELECT school, AVG(hire_year) AS avg_hire_year
FROM teachers
GROUP BY school
ORDER BY avg_hire_year DESC;
```

15. **Most common degree by school (approx via max count)**  
```sql
WITH deg_counts AS (
  SELECT school, degree, COUNT(*) AS cnt,
         ROW_NUMBER() OVER (PARTITION BY school ORDER BY COUNT(*) DESC) AS rn
  FROM teachers
  GROUP BY school, degree
)
SELECT school, degree AS most_common_degree, cnt
FROM deg_counts WHERE rn=1;
```

16. **Salary distribution buckets (by 10k)**  
```sql
SELECT CONCAT(FLOOR(salary/10000)*10, 'k') AS bucket, COUNT(*) AS cnt
FROM teachers
GROUP BY bucket
ORDER BY FLOOR(salary/10000)*10;
```

17. **Average salary by (school, department)**  
```sql
SELECT school, department, AVG(salary) AS avg_salary
FROM teachers
GROUP BY school, department
ORDER BY school, avg_salary DESC;
```

18. **Country with highest average salary**  
```sql
WITH c AS (
  SELECT country, AVG(salary) AS avg_sal FROM teachers GROUP BY country
)
SELECT country, avg_sal FROM c ORDER BY avg_sal DESC LIMIT 1;
```

19. **Schools with at least 1000 teachers and avg salary > 150k**  
```sql
SELECT school, COUNT(*) AS cnt, AVG(salary) AS avg_salary
FROM teachers
GROUP BY school
HAVING COUNT(*) >= 1000 AND AVG(salary) > 150000;
```

20. **Department count per country**  
```sql
SELECT country, department, COUNT(*) AS cnt
FROM teachers
GROUP BY country, department
ORDER BY country, cnt DESC;
```
