# Lab3_Intermediate - Instructor Solutions (Fixed)

**1. Employees older than avg age**

```sql
SELECT * FROM employees WHERE age>(SELECT AVG(age) FROM employees);
```

**Expected Output (sample):**

| emp_id | name | age | ... |
|--------|------|-----|-----|
| 15     | Noah Brown | 54 | ... |
| ...    | ...  | ... | ... |

**2. Departments with avg salary > 100000**

```sql
SELECT d.dept_name,AVG(e.salary) AS avg_sal FROM departments d JOIN employees e ON d.dept_id=e.dept_id GROUP BY d.dept_name HAVING AVG(e.salary)>100000;
```

**Expected Output (sample):**

| dept_name | avg_sal |
|-----------|---------|
| Finance   | 120000  |

**3. Employees in departments with fewer than 5 employees**

```sql
SELECT * FROM employees e WHERE e.dept_id IN (SELECT dept_id FROM employees GROUP BY dept_id HAVING COUNT(*)<5);
```

**Expected Output (sample):**

| emp_id | name | dept_id | ... |
|--------|------|---------|-----|
| 22     | Emma Smith | 40 | ... |

**4. Countries with more than 10 employees**

```sql
SELECT country,COUNT(*) FROM employees GROUP BY country HAVING COUNT(*)>10;
```

**Expected Output (sample):**

| country | count |
|---------|-------|
| USA     | 40    |

**5. Employees earning above their department's average salary**

```sql
SELECT e.* FROM employees e JOIN (SELECT dept_id,AVG(salary) AS avg_sal FROM employees GROUP BY dept_id) a ON e.dept_id=a.dept_id WHERE e.salary>a.avg_sal;
```

**Expected Output (sample):**

| emp_id | name | salary | dept_id | ... |
|--------|------|--------|---------|-----|
| 5      | Ava Johnson | 150000 | 10 | ... |

**6. Employees older than avg age**

```sql
SELECT * FROM employees WHERE age>(SELECT AVG(age) FROM employees);
```

**Expected Output (sample):**

| emp_id | name | age | ... |
|--------|------|-----|-----|
| 15     | Noah Brown | 54 | ... |
| ...    | ...  | ... | ... |

**7. Departments with avg salary > 100000**

```sql
SELECT d.dept_name,AVG(e.salary) AS avg_sal FROM departments d JOIN employees e ON d.dept_id=e.dept_id GROUP BY d.dept_name HAVING AVG(e.salary)>100000;
```

**Expected Output (sample):**

| dept_name | avg_sal |
|-----------|---------|
| Finance   | 120000  |

**8. Employees in departments with fewer than 5 employees**

```sql
SELECT * FROM employees e WHERE e.dept_id IN (SELECT dept_id FROM employees GROUP BY dept_id HAVING COUNT(*)<5);
```

**Expected Output (sample):**

| emp_id | name | dept_id | ... |
|--------|------|---------|-----|
| 22     | Emma Smith | 40 | ... |

**9. Countries with more than 10 employees**

```sql
SELECT country,COUNT(*) FROM employees GROUP BY country HAVING COUNT(*)>10;
```

**Expected Output (sample):**

| country | count |
|---------|-------|
| USA     | 40    |

**10. Employees earning above their department's average salary**

```sql
SELECT e.* FROM employees e JOIN (SELECT dept_id,AVG(salary) AS avg_sal FROM employees GROUP BY dept_id) a ON e.dept_id=a.dept_id WHERE e.salary>a.avg_sal;
```

**Expected Output (sample):**

| emp_id | name | salary | dept_id | ... |
|--------|------|--------|---------|-----|
| 5      | Ava Johnson | 150000 | 10 | ... |

**11. Employees older than avg age**

```sql
SELECT * FROM employees WHERE age>(SELECT AVG(age) FROM employees);
```

**Expected Output (sample):**

| emp_id | name | age | ... |
|--------|------|-----|-----|
| 15     | Noah Brown | 54 | ... |
| ...    | ...  | ... | ... |

**12. Departments with avg salary > 100000**

```sql
SELECT d.dept_name,AVG(e.salary) AS avg_sal FROM departments d JOIN employees e ON d.dept_id=e.dept_id GROUP BY d.dept_name HAVING AVG(e.salary)>100000;
```

**Expected Output (sample):**

| dept_name | avg_sal |
|-----------|---------|
| Finance   | 120000  |

**13. Employees in departments with fewer than 5 employees**

```sql
SELECT * FROM employees e WHERE e.dept_id IN (SELECT dept_id FROM employees GROUP BY dept_id HAVING COUNT(*)<5);
```

**Expected Output (sample):**

| emp_id | name | dept_id | ... |
|--------|------|---------|-----|
| 22     | Emma Smith | 40 | ... |

**14. Countries with more than 10 employees**

```sql
SELECT country,COUNT(*) FROM employees GROUP BY country HAVING COUNT(*)>10;
```

**Expected Output (sample):**

| country | count |
|---------|-------|
| USA     | 40    |

**15. Employees earning above their department's average salary**

```sql
SELECT e.* FROM employees e JOIN (SELECT dept_id,AVG(salary) AS avg_sal FROM employees GROUP BY dept_id) a ON e.dept_id=a.dept_id WHERE e.salary>a.avg_sal;
```

**Expected Output (sample):**

| emp_id | name | salary | dept_id | ... |
|--------|------|--------|---------|-----|
| 5      | Ava Johnson | 150000 | 10 | ... |

**16. Employees older than avg age**

```sql
SELECT * FROM employees WHERE age>(SELECT AVG(age) FROM employees);
```

**Expected Output (sample):**

| emp_id | name | age | ... |
|--------|------|-----|-----|
| 15     | Noah Brown | 54 | ... |
| ...    | ...  | ... | ... |

**17. Departments with avg salary > 100000**

```sql
SELECT d.dept_name,AVG(e.salary) AS avg_sal FROM departments d JOIN employees e ON d.dept_id=e.dept_id GROUP BY d.dept_name HAVING AVG(e.salary)>100000;
```

**Expected Output (sample):**

| dept_name | avg_sal |
|-----------|---------|
| Finance   | 120000  |

**18. Employees in departments with fewer than 5 employees**

```sql
SELECT * FROM employees e WHERE e.dept_id IN (SELECT dept_id FROM employees GROUP BY dept_id HAVING COUNT(*)<5);
```

**Expected Output (sample):**

| emp_id | name | dept_id | ... |
|--------|------|---------|-----|
| 22     | Emma Smith | 40 | ... |

**19. Countries with more than 10 employees**

```sql
SELECT country,COUNT(*) FROM employees GROUP BY country HAVING COUNT(*)>10;
```

**Expected Output (sample):**

| country | count |
|---------|-------|
| USA     | 40    |

**20. Employees earning above their department's average salary**

```sql
SELECT e.* FROM employees e JOIN (SELECT dept_id,AVG(salary) AS avg_sal FROM employees GROUP BY dept_id) a ON e.dept_id=a.dept_id WHERE e.salary>a.avg_sal;
```

**Expected Output (sample):**

| emp_id | name | salary | dept_id | ... |
|--------|------|--------|---------|-----|
| 5      | Ava Johnson | 150000 | 10 | ... |

**21. Employees older than avg age**

```sql
SELECT * FROM employees WHERE age>(SELECT AVG(age) FROM employees);
```

**Expected Output (sample):**

| emp_id | name | age | ... |
|--------|------|-----|-----|
| 15     | Noah Brown | 54 | ... |
| ...    | ...  | ... | ... |

**22. Departments with avg salary > 100000**

```sql
SELECT d.dept_name,AVG(e.salary) AS avg_sal FROM departments d JOIN employees e ON d.dept_id=e.dept_id GROUP BY d.dept_name HAVING AVG(e.salary)>100000;
```

**Expected Output (sample):**

| dept_name | avg_sal |
|-----------|---------|
| Finance   | 120000  |

**23. Employees in departments with fewer than 5 employees**

```sql
SELECT * FROM employees e WHERE e.dept_id IN (SELECT dept_id FROM employees GROUP BY dept_id HAVING COUNT(*)<5);
```

**Expected Output (sample):**

| emp_id | name | dept_id | ... |
|--------|------|---------|-----|
| 22     | Emma Smith | 40 | ... |

**24. Countries with more than 10 employees**

```sql
SELECT country,COUNT(*) FROM employees GROUP BY country HAVING COUNT(*)>10;
```

**Expected Output (sample):**

| country | count |
|---------|-------|
| USA     | 40    |

**25. Employees earning above their department's average salary**

```sql
SELECT e.* FROM employees e JOIN (SELECT dept_id,AVG(salary) AS avg_sal FROM employees GROUP BY dept_id) a ON e.dept_id=a.dept_id WHERE e.salary>a.avg_sal;
```

**Expected Output (sample):**

| emp_id | name | salary | dept_id | ... |
|--------|------|--------|---------|-----|
| 5      | Ava Johnson | 150000 | 10 | ... |

**26. Employees older than avg age**

```sql
SELECT * FROM employees WHERE age>(SELECT AVG(age) FROM employees);
```

**Expected Output (sample):**

| emp_id | name | age | ... |
|--------|------|-----|-----|
| 15     | Noah Brown | 54 | ... |
| ...    | ...  | ... | ... |

**27. Departments with avg salary > 100000**

```sql
SELECT d.dept_name,AVG(e.salary) AS avg_sal FROM departments d JOIN employees e ON d.dept_id=e.dept_id GROUP BY d.dept_name HAVING AVG(e.salary)>100000;
```

**Expected Output (sample):**

| dept_name | avg_sal |
|-----------|---------|
| Finance   | 120000  |

**28. Employees in departments with fewer than 5 employees**

```sql
SELECT * FROM employees e WHERE e.dept_id IN (SELECT dept_id FROM employees GROUP BY dept_id HAVING COUNT(*)<5);
```

**Expected Output (sample):**

| emp_id | name | dept_id | ... |
|--------|------|---------|-----|
| 22     | Emma Smith | 40 | ... |

**29. Countries with more than 10 employees**

```sql
SELECT country,COUNT(*) FROM employees GROUP BY country HAVING COUNT(*)>10;
```

**Expected Output (sample):**

| country | count |
|---------|-------|
| USA     | 40    |

**30. Employees earning above their department's average salary**

```sql
SELECT e.* FROM employees e JOIN (SELECT dept_id,AVG(salary) AS avg_sal FROM employees GROUP BY dept_id) a ON e.dept_id=a.dept_id WHERE e.salary>a.avg_sal;
```

**Expected Output (sample):**

| emp_id | name | salary | dept_id | ... |
|--------|------|--------|---------|-----|
| 5      | Ava Johnson | 150000 | 10 | ... |

