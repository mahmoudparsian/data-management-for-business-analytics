# Lab2_BasicIntermediate - Instructor Solutions

#### 1. Join employees with departments (display emp. name and dept. name)

```sql
SELECT e.name, d.dept_name 
FROM employees e 
JOIN departments d ON e.dept_id = d.dept_id;
```

**Expected Output (sample):**

| name | dept_name |
|------|-----------|
| Ava  | Sales     |
| Noah | Finance   |

-----

#### 2. List employees in Engineering

```sql
SELECT e.* 
FROM employees e 
JOIN departments d ON e.dept_id=d.dept_id 
WHERE d.dept_name = 'Engineering';
```

**Expected Output (sample):**

| emp_id | name | dept_id | ... |
|--------|------|---------|-----|

------

#### 3. Count employees per department

```sql
SELECT d.dept_name, COUNT(e.emp_id) AS count_per_dept 
FROM departments d 
LEFT JOIN employees e ON d.dept_id = e.dept_id 
GROUP BY d.dept_name;
```

**Expected Output (sample):**

| dept_name   | cnt |
|-------------|-----|
| Engineering | 25  |
| Sales       | 18  |

-----

#### 4. Average salary per department

```sql
SELECT d.dept_name, AVG(e.salary) AS avg_salary 
FROM departments d 
JOIN employees e ON d.dept_id = d.dept_id 
GROUP BY d.dept_name;
```

**Expected Output (sample):**

| dept_name | avg_sal |
|-----------|---------|
| HR        | 74000   |

------

#### 5. Employees without department

```sql
SELECT * 
FROM employees e 
LEFT JOIN departments d ON e.dept_id=d.dept_id 
WHERE d.dept_id IS NULL;
```

**Expected Output (sample):**

| emp_id | name | dept_id | ... |
|--------|------|---------|-----|

------

#### 6. Top 5 highest salaries

```sql
SELECT name, salary 
FROM employees 
ORDER BY salary DESC 
LIMIT 5;
```

**Expected Output (sample):**

| name | salary  |
|------|---------|
| Emma | 160000  |
| Noah | 155000  |

------

#### 7. Departments with no employees

```sql
SELECT d.* 
FROM departments d 
LEFT JOIN employees e ON d.dept_id = e.dept_id 
WHERE e.emp_id IS NULL;
```

**Expected Output (sample):**

| dept_id | dept_name | location |
|---------|-----------|----------|
| 90      | Legal     | DC       |


-------

#### 8. Total employees per country

```sql
SELECT country, COUNT(*) as emps_per_country
FROM employees 
GROUP BY country;
```

**Expected Output (sample):**

| country | cnt |
|---------|-----|
| USA     | 40  |
| CANADA  | 22  |

------

#### 9. Employees per degree

```sql
SELECT degree, COUNT(*) emps_per_degree
FROM employees 
GROUP BY degree;
```

**Expected Output (sample):**

| degree | cnt |
|--------|-----|
| BS     | 70  |
| MS     | 40  |

------

#### 10. Departments in Boston or Seattle

Solution-1:

```sql
   SELECT * 
   FROM departments 
   WHERE location IN ('Boston','Seattle');
```

Solution-2:

```sql
   SELECT * 
   FROM departments 
   WHERE (location = 'Boston') OR
         (location = 'Seattle');
```


**Expected Output (sample):**

| dept_id | dept_name   | location |
|---------|-------------|----------|
| 50      | Finance     | Boston   |
| 60      | Operations  | Seattle  |

------

#### 11. Join employees with departments

```sql
SELECT e.name, d.dept_name 
FROM employees e 
JOIN departments d ON e.dept_id = d.dept_id;
```

**Expected Output (sample):**

| name | dept_name |
|------|-----------|
| Ava  | Sales     |
| Noah | Finance   |

-----

#### 12. List employees in Engineering

```sql
SELECT e.* 
FROM employees e 
JOIN departments d ON e.dept_id = d.dept_id 
WHERE d.dept_name = 'Engineering';
```

**Expected Output (sample):**

| emp_id | name | dept_id | ... |
|--------|------|---------|-----|

------

#### 13. Count employees per department

```sql
SELECT d.dept_name, COUNT(e.emp_id) AS count_per_dept 
FROM departments d 
LEFT JOIN employees e ON d.dept_id = e.dept_id 
GROUP BY d.dept_name;
```

**Expected Output (sample):**

| dept_name   | cnt |
|-------------|-----|
| Engineering | 25  |
| Sales       | 18  |

-----

**14. Average salary per department**

```sql
SELECT d.dept_name,AVG(e.salary) AS avg_sal FROM departments d JOIN employees e ON d.dept_id=d.dept_id GROUP BY d.dept_name;
```

**Expected Output (sample):**

| dept_name | avg_sal |
|-----------|---------|
| HR        | 74000   |

**15. Employees without department**

```sql
SELECT * FROM employees e LEFT JOIN departments d ON e.dept_id=d.dept_id WHERE d.dept_id IS NULL;
```

**Expected Output (sample):**

| emp_id | name | dept_id | ... |
|--------|------|---------|-----|

**16. Top 5 highest salaries**

```sql
SELECT name,salary FROM employees ORDER BY salary DESC LIMIT 5;
```

**Expected Output (sample):**

| name | salary  |
|------|---------|
| Emma | 160000  |
| Noah | 155000  |

**17. Departments with no employees**

```sql
SELECT d.* FROM departments d LEFT JOIN employees e ON d.dept_id=e.dept_id WHERE e.emp_id IS NULL;
```

**Expected Output (sample):**

| dept_id | dept_name | location |
|---------|-----------|----------|
| 90      | Legal     | DC       |

**18. Total employees per country**

```sql
SELECT country,COUNT(*) FROM employees GROUP BY country;
```

**Expected Output (sample):**

| country | cnt |
|---------|-----|
| USA     | 40  |
| CANADA  | 22  |

**19. Employees per degree**

```sql
SELECT degree,COUNT(*) FROM employees GROUP BY degree;
```

**Expected Output (sample):**

| degree | cnt |
|--------|-----|
| BS     | 70  |
| MS     | 40  |

**20. Departments in Boston or Seattle**

```sql
SELECT * FROM departments WHERE location IN ('Boston','Seattle');
```

**Expected Output (sample):**

| dept_id | dept_name   | location |
|---------|-------------|----------|
| 50      | Finance     | Boston   |
| 60      | Operations  | Seattle  |

**21. Join employees with departments**

```sql
SELECT e.name,d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id;
```

**Expected Output (sample):**

| name | dept_name |
|------|-----------|
| Ava  | Sales     |
| Noah | Finance   |

**22. List employees in Engineering**

```sql
SELECT e.* FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE d.dept_name='Engineering';
```

**Expected Output (sample):**

| emp_id | name | dept_id | ... |
|--------|------|---------|-----|

**23. Count employees per department**

```sql
SELECT d.dept_name,COUNT(e.emp_id) AS cnt FROM departments d LEFT JOIN employees e ON d.dept_id=e.dept_id GROUP BY d.dept_name;
```

**Expected Output (sample):**

| dept_name   | cnt |
|-------------|-----|
| Engineering | 25  |
| Sales       | 18  |

**24. Average salary per department**

```sql
SELECT d.dept_name,AVG(e.salary) AS avg_sal FROM departments d JOIN employees e ON d.dept_id=d.dept_id GROUP BY d.dept_name;
```

**Expected Output (sample):**

| dept_name | avg_sal |
|-----------|---------|
| HR        | 74000   |

**25. Employees without department**

```sql
SELECT * FROM employees e LEFT JOIN departments d ON e.dept_id=d.dept_id WHERE d.dept_id IS NULL;
```

**Expected Output (sample):**

| emp_id | name | dept_id | ... |
|--------|------|---------|-----|

**26. Top 5 highest salaries**

```sql
SELECT name,salary FROM employees ORDER BY salary DESC LIMIT 5;
```

**Expected Output (sample):**

| name | salary  |
|------|---------|
| Emma | 160000  |
| Noah | 155000  |

**27. Departments with no employees**

```sql
SELECT d.* FROM departments d LEFT JOIN employees e ON d.dept_id=e.dept_id WHERE e.emp_id IS NULL;
```

**Expected Output (sample):**

| dept_id | dept_name | location |
|---------|-----------|----------|
| 90      | Legal     | DC       |

**28. Total employees per country**

```sql
SELECT country,COUNT(*) FROM employees GROUP BY country;
```

**Expected Output (sample):**

| country | cnt |
|---------|-----|
| USA     | 40  |
| CANADA  | 22  |

**29. Employees per degree**

```sql
SELECT degree,COUNT(*) FROM employees GROUP BY degree;
```

**Expected Output (sample):**

| degree | cnt |
|--------|-----|
| BS     | 70  |
| MS     | 40  |

**30. Departments in Boston or Seattle**

```sql
SELECT * FROM departments WHERE location IN ('Boston','Seattle');
```

**Expected Output (sample):**

| dept_id | dept_name   | location |
|---------|-------------|----------|
| 50      | Finance     | Boston   |
| 60      | Operations  | Seattle  |

