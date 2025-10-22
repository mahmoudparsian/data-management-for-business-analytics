# Lab5_Advanced - Instructor Solutions (Fixed)

**1. Top 3 paid employees per department**

```sql
SELECT * FROM (SELECT e.*,ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rn FROM employees e) x WHERE rn<=3;
```

**Expected Output (sample):**

| emp_id | name | dept_id | salary | rn |
|--------|------|---------|--------|----|
| 12     | Emma | 10      | 160000 | 1  |

**2. Departments with highest avg salary**

```sql
SELECT d.dept_name,AVG(e.salary) AS avg_sal FROM employees e JOIN departments d ON e.dept_id=d.dept_id GROUP BY d.dept_name ORDER BY avg_sal DESC LIMIT 5;
```

**Expected Output (sample):**

| dept_name | avg_sal |
|-----------|---------|
| Finance   | 145000  |

**3. Employees earning above overall 90th percentile**

```sql
SELECT * FROM employees WHERE salary >= (SELECT MIN(salary) FROM (SELECT salary FROM employees ORDER BY salary DESC LIMIT CEIL(0.1*(SELECT COUNT(*) FROM employees))) x);
```

**Expected Output (sample):**

| emp_id | name | salary | ... |
|--------|------|--------|-----|
| 2      | Noah | 155000 | ... |

**4. Countries ranked by avg salary**

```sql
SELECT country,AVG(salary) AS avg_sal,RANK() OVER (ORDER BY AVG(salary) DESC) AS rnk FROM employees GROUP BY country;
```

**Expected Output (sample):**

| country | avg_sal | rnk |
|---------|---------|-----|
| USA     | 120000  | 1   |

**5. Employees whose salary > dept avg and hire_date > 2022**

```sql
SELECT e.* FROM employees e JOIN (SELECT dept_id,AVG(salary) AS avg_sal FROM employees GROUP BY dept_id) a ON e.dept_id=a.dept_id WHERE e.salary>a.avg_sal AND e.hire_date>'2022-01-01';
```

**Expected Output (sample):**

| emp_id | name | salary | dept_id | hire_date  |
|--------|------|--------|---------|------------|
| 17     | Ava  | 140000 | 20      | 2023-03-12 |

**6. Top 3 paid employees per department**

```sql
SELECT * FROM (SELECT e.*,ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rn FROM employees e) x WHERE rn<=3;
```

**Expected Output (sample):**

| emp_id | name | dept_id | salary | rn |
|--------|------|---------|--------|----|
| 12     | Emma | 10      | 160000 | 1  |

**7. Departments with highest avg salary**

```sql
SELECT d.dept_name,AVG(e.salary) AS avg_sal FROM employees e JOIN departments d ON e.dept_id=d.dept_id GROUP BY d.dept_name ORDER BY avg_sal DESC LIMIT 5;
```

**Expected Output (sample):**

| dept_name | avg_sal |
|-----------|---------|
| Finance   | 145000  |

**8. Employees earning above overall 90th percentile**

```sql
SELECT * FROM employees WHERE salary >= (SELECT MIN(salary) FROM (SELECT salary FROM employees ORDER BY salary DESC LIMIT CEIL(0.1*(SELECT COUNT(*) FROM employees))) x);
```

**Expected Output (sample):**

| emp_id | name | salary | ... |
|--------|------|--------|-----|
| 2      | Noah | 155000 | ... |

**9. Countries ranked by avg salary**

```sql
SELECT country,AVG(salary) AS avg_sal,RANK() OVER (ORDER BY AVG(salary) DESC) AS rnk FROM employees GROUP BY country;
```

**Expected Output (sample):**

| country | avg_sal | rnk |
|---------|---------|-----|
| USA     | 120000  | 1   |

**10. Employees whose salary > dept avg and hire_date > 2022**

```sql
SELECT e.* FROM employees e JOIN (SELECT dept_id,AVG(salary) AS avg_sal FROM employees GROUP BY dept_id) a ON e.dept_id=a.dept_id WHERE e.salary>a.avg_sal AND e.hire_date>'2022-01-01';
```

**Expected Output (sample):**

| emp_id | name | salary | dept_id | hire_date  |
|--------|------|--------|---------|------------|
| 17     | Ava  | 140000 | 20      | 2023-03-12 |

**11. Top 3 paid employees per department**

```sql
SELECT * FROM (SELECT e.*,ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rn FROM employees e) x WHERE rn<=3;
```

**Expected Output (sample):**

| emp_id | name | dept_id | salary | rn |
|--------|------|---------|--------|----|
| 12     | Emma | 10      | 160000 | 1  |

**12. Departments with highest avg salary**

```sql
SELECT d.dept_name,AVG(e.salary) AS avg_sal FROM employees e JOIN departments d ON e.dept_id=d.dept_id GROUP BY d.dept_name ORDER BY avg_sal DESC LIMIT 5;
```

**Expected Output (sample):**

| dept_name | avg_sal |
|-----------|---------|
| Finance   | 145000  |

**13. Employees earning above overall 90th percentile**

```sql
SELECT * FROM employees WHERE salary >= (SELECT MIN(salary) FROM (SELECT salary FROM employees ORDER BY salary DESC LIMIT CEIL(0.1*(SELECT COUNT(*) FROM employees))) x);
```

**Expected Output (sample):**

| emp_id | name | salary | ... |
|--------|------|--------|-----|
| 2      | Noah | 155000 | ... |

**14. Countries ranked by avg salary**

```sql
SELECT country,AVG(salary) AS avg_sal,RANK() OVER (ORDER BY AVG(salary) DESC) AS rnk FROM employees GROUP BY country;
```

**Expected Output (sample):**

| country | avg_sal | rnk |
|---------|---------|-----|
| USA     | 120000  | 1   |

**15. Employees whose salary > dept avg and hire_date > 2022**

```sql
SELECT e.* FROM employees e JOIN (SELECT dept_id,AVG(salary) AS avg_sal FROM employees GROUP BY dept_id) a ON e.dept_id=a.dept_id WHERE e.salary>a.avg_sal AND e.hire_date>'2022-01-01';
```

**Expected Output (sample):**

| emp_id | name | salary | dept_id | hire_date  |
|--------|------|--------|---------|------------|
| 17     | Ava  | 140000 | 20      | 2023-03-12 |

**16. Top 3 paid employees per department**

```sql
SELECT * FROM (SELECT e.*,ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rn FROM employees e) x WHERE rn<=3;
```

**Expected Output (sample):**

| emp_id | name | dept_id | salary | rn |
|--------|------|---------|--------|----|
| 12     | Emma | 10      | 160000 | 1  |

**17. Departments with highest avg salary**

```sql
SELECT d.dept_name,AVG(e.salary) AS avg_sal FROM employees e JOIN departments d ON e.dept_id=d.dept_id GROUP BY d.dept_name ORDER BY avg_sal DESC LIMIT 5;
```

**Expected Output (sample):**

| dept_name | avg_sal |
|-----------|---------|
| Finance   | 145000  |

**18. Employees earning above overall 90th percentile**

```sql
SELECT * FROM employees WHERE salary >= (SELECT MIN(salary) FROM (SELECT salary FROM employees ORDER BY salary DESC LIMIT CEIL(0.1*(SELECT COUNT(*) FROM employees))) x);
```

**Expected Output (sample):**

| emp_id | name | salary | ... |
|--------|------|--------|-----|
| 2      | Noah | 155000 | ... |

**19. Countries ranked by avg salary**

```sql
SELECT country,AVG(salary) AS avg_sal,RANK() OVER (ORDER BY AVG(salary) DESC) AS rnk FROM employees GROUP BY country;
```

**Expected Output (sample):**

| country | avg_sal | rnk |
|---------|---------|-----|
| USA     | 120000  | 1   |

**20. Employees whose salary > dept avg and hire_date > 2022**

```sql
SELECT e.* FROM employees e JOIN (SELECT dept_id,AVG(salary) AS avg_sal FROM employees GROUP BY dept_id) a ON e.dept_id=a.dept_id WHERE e.salary>a.avg_sal AND e.hire_date>'2022-01-01';
```

**Expected Output (sample):**

| emp_id | name | salary | dept_id | hire_date  |
|--------|------|--------|---------|------------|
| 17     | Ava  | 140000 | 20      | 2023-03-12 |

**21. Top 3 paid employees per department**

```sql
SELECT * FROM (SELECT e.*,ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rn FROM employees e) x WHERE rn<=3;
```

**Expected Output (sample):**

| emp_id | name | dept_id | salary | rn |
|--------|------|---------|--------|----|
| 12     | Emma | 10      | 160000 | 1  |

**22. Departments with highest avg salary**

```sql
SELECT d.dept_name,AVG(e.salary) AS avg_sal FROM employees e JOIN departments d ON e.dept_id=d.dept_id GROUP BY d.dept_name ORDER BY avg_sal DESC LIMIT 5;
```

**Expected Output (sample):**

| dept_name | avg_sal |
|-----------|---------|
| Finance   | 145000  |

**23. Employees earning above overall 90th percentile**

```sql
SELECT * FROM employees WHERE salary >= (SELECT MIN(salary) FROM (SELECT salary FROM employees ORDER BY salary DESC LIMIT CEIL(0.1*(SELECT COUNT(*) FROM employees))) x);
```

**Expected Output (sample):**

| emp_id | name | salary | ... |
|--------|------|--------|-----|
| 2      | Noah | 155000 | ... |

**24. Countries ranked by avg salary**

```sql
SELECT country,AVG(salary) AS avg_sal,RANK() OVER (ORDER BY AVG(salary) DESC) AS rnk FROM employees GROUP BY country;
```

**Expected Output (sample):**

| country | avg_sal | rnk |
|---------|---------|-----|
| USA     | 120000  | 1   |

**25. Employees whose salary > dept avg and hire_date > 2022**

```sql
SELECT e.* FROM employees e JOIN (SELECT dept_id,AVG(salary) AS avg_sal FROM employees GROUP BY dept_id) a ON e.dept_id=a.dept_id WHERE e.salary>a.avg_sal AND e.hire_date>'2022-01-01';
```

**Expected Output (sample):**

| emp_id | name | salary | dept_id | hire_date  |
|--------|------|--------|---------|------------|
| 17     | Ava  | 140000 | 20      | 2023-03-12 |

**26. Top 3 paid employees per department**

```sql
SELECT * FROM (SELECT e.*,ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rn FROM employees e) x WHERE rn<=3;
```

**Expected Output (sample):**

| emp_id | name | dept_id | salary | rn |
|--------|------|---------|--------|----|
| 12     | Emma | 10      | 160000 | 1  |

**27. Departments with highest avg salary**

```sql
SELECT d.dept_name,AVG(e.salary) AS avg_sal FROM employees e JOIN departments d ON e.dept_id=d.dept_id GROUP BY d.dept_name ORDER BY avg_sal DESC LIMIT 5;
```

**Expected Output (sample):**

| dept_name | avg_sal |
|-----------|---------|
| Finance   | 145000  |

**28. Employees earning above overall 90th percentile**

```sql
SELECT * FROM employees WHERE salary >= (SELECT MIN(salary) FROM (SELECT salary FROM employees ORDER BY salary DESC LIMIT CEIL(0.1*(SELECT COUNT(*) FROM employees))) x);
```

**Expected Output (sample):**

| emp_id | name | salary | ... |
|--------|------|--------|-----|
| 2      | Noah | 155000 | ... |

**29. Countries ranked by avg salary**

```sql
SELECT country,AVG(salary) AS avg_sal,RANK() OVER (ORDER BY AVG(salary) DESC) AS rnk FROM employees GROUP BY country;
```

**Expected Output (sample):**

| country | avg_sal | rnk |
|---------|---------|-----|
| USA     | 120000  | 1   |

**30. Employees whose salary > dept avg and hire_date > 2022**

```sql
SELECT e.* FROM employees e JOIN (SELECT dept_id,AVG(salary) AS avg_sal FROM employees GROUP BY dept_id) a ON e.dept_id=a.dept_id WHERE e.salary>a.avg_sal AND e.hire_date>'2022-01-01';
```

**Expected Output (sample):**

| emp_id | name | salary | dept_id | hire_date  |
|--------|------|--------|---------|------------|
| 17     | Ava  | 140000 | 20      | 2023-03-12 |

