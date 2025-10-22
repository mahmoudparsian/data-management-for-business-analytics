# Lab4_IntermediatePlus - Instructor Solutions (Fixed)

**1. Rank employees by salary**

```sql
SELECT name,salary,RANK() OVER (ORDER BY salary DESC) AS rnk FROM employees;
```

**Expected Output (sample):**

| name | salary | rnk |
|------|--------|-----|
| Ava  | 160000 | 1   |
| Noah | 150000 | 2   |

**2. Dense rank departments by average age**

```sql
SELECT d.dept_name,AVG(e.age) AS avg_age,DENSE_RANK() OVER (ORDER BY AVG(e.age) DESC) AS rnk FROM employees e JOIN departments d ON e.dept_id=d.dept_id GROUP BY d.dept_name;
```

**Expected Output (sample):**

| dept_name | avg_age | rnk |
|-----------|---------|-----|
| HR        | 50.3    | 1   |

**3. Top 3 highest paid employees per department**

```sql
SELECT * FROM (SELECT e.*,ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rn FROM employees e) x WHERE rn<=3;
```

**Expected Output (sample):**

| emp_id | name | dept_id | salary | rn |
|--------|------|---------|--------|----|
| 12     | Emma | 10      | 160000 | 1  |

**4. Running total of salaries by department**

```sql
SELECT dept_id,salary,SUM(salary) OVER (PARTITION BY dept_id ORDER BY salary) AS running_total FROM employees;
```

**Expected Output (sample):**

| dept_id | salary | running_total |
|---------|--------|----------------|
| 10      | 60000  | 60000          |
| 10      | 80000  | 140000         |

**5. Rank countries by employee count**

```sql
SELECT country,COUNT(*) AS cnt,RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk FROM employees GROUP BY country;
```

**Expected Output (sample):**

| country | cnt | rnk |
|---------|-----|-----|
| USA     | 40  | 1   |

**6. Rank employees by salary**

```sql
SELECT name,salary,RANK() OVER (ORDER BY salary DESC) AS rnk FROM employees;
```

**Expected Output (sample):**

| name | salary | rnk |
|------|--------|-----|
| Ava  | 160000 | 1   |
| Noah | 150000 | 2   |

**7. Dense rank departments by average age**

```sql
SELECT d.dept_name,AVG(e.age) AS avg_age,DENSE_RANK() OVER (ORDER BY AVG(e.age) DESC) AS rnk FROM employees e JOIN departments d ON e.dept_id=d.dept_id GROUP BY d.dept_name;
```

**Expected Output (sample):**

| dept_name | avg_age | rnk |
|-----------|---------|-----|
| HR        | 50.3    | 1   |

**8. Top 3 highest paid employees per department**

```sql
SELECT * FROM (SELECT e.*,ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rn FROM employees e) x WHERE rn<=3;
```

**Expected Output (sample):**

| emp_id | name | dept_id | salary | rn |
|--------|------|---------|--------|----|
| 12     | Emma | 10      | 160000 | 1  |

**9. Running total of salaries by department**

```sql
SELECT dept_id,salary,SUM(salary) OVER (PARTITION BY dept_id ORDER BY salary) AS running_total FROM employees;
```

**Expected Output (sample):**

| dept_id | salary | running_total |
|---------|--------|----------------|
| 10      | 60000  | 60000          |
| 10      | 80000  | 140000         |

**10. Rank countries by employee count**

```sql
SELECT country,COUNT(*) AS cnt,RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk FROM employees GROUP BY country;
```

**Expected Output (sample):**

| country | cnt | rnk |
|---------|-----|-----|
| USA     | 40  | 1   |

**11. Rank employees by salary**

```sql
SELECT name,salary,RANK() OVER (ORDER BY salary DESC) AS rnk FROM employees;
```

**Expected Output (sample):**

| name | salary | rnk |
|------|--------|-----|
| Ava  | 160000 | 1   |
| Noah | 150000 | 2   |

**12. Dense rank departments by average age**

```sql
SELECT d.dept_name,AVG(e.age) AS avg_age,DENSE_RANK() OVER (ORDER BY AVG(e.age) DESC) AS rnk FROM employees e JOIN departments d ON e.dept_id=d.dept_id GROUP BY d.dept_name;
```

**Expected Output (sample):**

| dept_name | avg_age | rnk |
|-----------|---------|-----|
| HR        | 50.3    | 1   |

**13. Top 3 highest paid employees per department**

```sql
SELECT * FROM (SELECT e.*,ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rn FROM employees e) x WHERE rn<=3;
```

**Expected Output (sample):**

| emp_id | name | dept_id | salary | rn |
|--------|------|---------|--------|----|
| 12     | Emma | 10      | 160000 | 1  |

**14. Running total of salaries by department**

```sql
SELECT dept_id,salary,SUM(salary) OVER (PARTITION BY dept_id ORDER BY salary) AS running_total FROM employees;
```

**Expected Output (sample):**

| dept_id | salary | running_total |
|---------|--------|----------------|
| 10      | 60000  | 60000          |
| 10      | 80000  | 140000         |

**15. Rank countries by employee count**

```sql
SELECT country,COUNT(*) AS cnt,RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk FROM employees GROUP BY country;
```

**Expected Output (sample):**

| country | cnt | rnk |
|---------|-----|-----|
| USA     | 40  | 1   |

**16. Rank employees by salary**

```sql
SELECT name,salary,RANK() OVER (ORDER BY salary DESC) AS rnk FROM employees;
```

**Expected Output (sample):**

| name | salary | rnk |
|------|--------|-----|
| Ava  | 160000 | 1   |
| Noah | 150000 | 2   |

**17. Dense rank departments by average age**

```sql
SELECT d.dept_name,AVG(e.age) AS avg_age,DENSE_RANK() OVER (ORDER BY AVG(e.age) DESC) AS rnk FROM employees e JOIN departments d ON e.dept_id=d.dept_id GROUP BY d.dept_name;
```

**Expected Output (sample):**

| dept_name | avg_age | rnk |
|-----------|---------|-----|
| HR        | 50.3    | 1   |

**18. Top 3 highest paid employees per department**

```sql
SELECT * FROM (SELECT e.*,ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rn FROM employees e) x WHERE rn<=3;
```

**Expected Output (sample):**

| emp_id | name | dept_id | salary | rn |
|--------|------|---------|--------|----|
| 12     | Emma | 10      | 160000 | 1  |

**19. Running total of salaries by department**

```sql
SELECT dept_id,salary,SUM(salary) OVER (PARTITION BY dept_id ORDER BY salary) AS running_total FROM employees;
```

**Expected Output (sample):**

| dept_id | salary | running_total |
|---------|--------|----------------|
| 10      | 60000  | 60000          |
| 10      | 80000  | 140000         |

**20. Rank countries by employee count**

```sql
SELECT country,COUNT(*) AS cnt,RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk FROM employees GROUP BY country;
```

**Expected Output (sample):**

| country | cnt | rnk |
|---------|-----|-----|
| USA     | 40  | 1   |

**21. Rank employees by salary**

```sql
SELECT name,salary,RANK() OVER (ORDER BY salary DESC) AS rnk FROM employees;
```

**Expected Output (sample):**

| name | salary | rnk |
|------|--------|-----|
| Ava  | 160000 | 1   |
| Noah | 150000 | 2   |

**22. Dense rank departments by average age**

```sql
SELECT d.dept_name,AVG(e.age) AS avg_age,DENSE_RANK() OVER (ORDER BY AVG(e.age) DESC) AS rnk FROM employees e JOIN departments d ON e.dept_id=d.dept_id GROUP BY d.dept_name;
```

**Expected Output (sample):**

| dept_name | avg_age | rnk |
|-----------|---------|-----|
| HR        | 50.3    | 1   |

**23. Top 3 highest paid employees per department**

```sql
SELECT * FROM (SELECT e.*,ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rn FROM employees e) x WHERE rn<=3;
```

**Expected Output (sample):**

| emp_id | name | dept_id | salary | rn |
|--------|------|---------|--------|----|
| 12     | Emma | 10      | 160000 | 1  |

**24. Running total of salaries by department**

```sql
SELECT dept_id,salary,SUM(salary) OVER (PARTITION BY dept_id ORDER BY salary) AS running_total FROM employees;
```

**Expected Output (sample):**

| dept_id | salary | running_total |
|---------|--------|----------------|
| 10      | 60000  | 60000          |
| 10      | 80000  | 140000         |

**25. Rank countries by employee count**

```sql
SELECT country,COUNT(*) AS cnt,RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk FROM employees GROUP BY country;
```

**Expected Output (sample):**

| country | cnt | rnk |
|---------|-----|-----|
| USA     | 40  | 1   |

**26. Rank employees by salary**

```sql
SELECT name,salary,RANK() OVER (ORDER BY salary DESC) AS rnk FROM employees;
```

**Expected Output (sample):**

| name | salary | rnk |
|------|--------|-----|
| Ava  | 160000 | 1   |
| Noah | 150000 | 2   |

**27. Dense rank departments by average age**

```sql
SELECT d.dept_name,AVG(e.age) AS avg_age,DENSE_RANK() OVER (ORDER BY AVG(e.age) DESC) AS rnk FROM employees e JOIN departments d ON e.dept_id=d.dept_id GROUP BY d.dept_name;
```

**Expected Output (sample):**

| dept_name | avg_age | rnk |
|-----------|---------|-----|
| HR        | 50.3    | 1   |

**28. Top 3 highest paid employees per department**

```sql
SELECT * FROM (SELECT e.*,ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rn FROM employees e) x WHERE rn<=3;
```

**Expected Output (sample):**

| emp_id | name | dept_id | salary | rn |
|--------|------|---------|--------|----|
| 12     | Emma | 10      | 160000 | 1  |

**29. Running total of salaries by department**

```sql
SELECT dept_id,salary,SUM(salary) OVER (PARTITION BY dept_id ORDER BY salary) AS running_total FROM employees;
```

**Expected Output (sample):**

| dept_id | salary | running_total |
|---------|--------|----------------|
| 10      | 60000  | 60000          |
| 10      | 80000  | 140000         |

**30. Rank countries by employee count**

```sql
SELECT country,COUNT(*) AS cnt,RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk FROM employees GROUP BY country;
```

**Expected Output (sample):**

| country | cnt | rnk |
|---------|-----|-----|
| USA     | 40  | 1   |

