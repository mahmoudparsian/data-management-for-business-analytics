# Lab1_VeryBasic - Instructor Solutions (Fixed)


#### 1. List all employees

```sql
SELECT * 
FROM employees;
```

**Expected Output (sample):**

| emp_id | name | age | degree | gender | country | dept_id | hire_date | salary |
|--------|------|-----|--------|--------|---------|---------|-----------|--------|
| 1      | Ava Smith | 34 | MS | FEMALE | USA | 10 | 2021-05-12 | 85000 |

-----

#### 2. List all departments

```sql
SELECT * 
FROM departments;
```

**Expected Output (sample):**

| dept_id | dept_name   | location   |
|---------|-------------|------------|
| 10      | Engineering | New York   |
| 20      | Sales       | Chicago    |

-----

#### 3. Show employee names and ages

```sql
SELECT name, age 
FROM employees;
```

**Expected Output (sample):**

| name       | age |
|------------|-----|
| Ava Smith  | 34  |
| Noah Brown | 41  |

-----


#### 4. List female employees**

```sql
SELECT * 
FROM employees 
WHERE gender = 'FEMALE';
```

**Expected Output (sample):**

| emp_id | name      | gender  |
|--------|-----------|---------|
| 5      | Emma Lee  | FEMALE  |

-----

#### 5. List male employees

```sql
SELECT * 
FROM employees 
WHERE gender = 'MALE';
```

**Expected Output (sample):**

| emp_id | name     | gender |
|--------|----------|--------|
| 2      | Noah Kim | MALE   |

-----

#### 6. Employees with degree MBA

```sql
SELECT * 
FROM employees 
WHERE degree = 'MBA';
```

**Expected Output (sample):**

| emp_id | name      | degree |
|--------|-----------|--------|
| 9      | Ava Patel | MBA    |

-----

#### 7. Employees from USA

```sql
SELECT * 
FROM employees 
WHERE country = 'USA';
```

**Expected Output (sample):**

| emp_id | name      | country |
|--------|-----------|---------|
| 7      | Liam Doe  | USA     |

-----

#### 8. Employees older than 50

```sql
SELECT * 
FROM employees 
WHERE age > 50;
```

**Expected Output (sample):**

| emp_id | name       | age |
|--------|------------|-----|
| 8      | Noah Smith | 54  |

-----


#### 9. Order employees by name

```sql
SELECT * 
FROM employees 
ORDER BY name;
```

**Expected Output (sample):**

| emp_id | name       |
|--------|------------|
| 3      | Ava Brown  |
| 5      | Emma Lee   |

-----

#### 10. Top 5 highest salaries

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

-----

#### 11. List only 3 employees

```sql
SELECT * 
FROM employees
LIMIT 3;
```

**Expected Output (sample):**

| emp_id | name | age | degree | gender | country | dept_id | hire_date | salary |
|--------|------|-----|--------|--------|---------|---------|-----------|--------|
| 1      | Ava Smith | 34 | MS | FEMALE | USA | 10 | 2021-05-12 | 85000 |

-----

#### 12. List all departments

```sql
SELECT * 
FROM departments;
```

-----

#### 13. List only 2 departments

```sql
SELECT * 
FROM departments
LIMIT 2;
```

**Expected Output (sample):**

| dept_id | dept_name   | location   |
|---------|-------------|------------|
| 10      | Engineering | New York   |
| 20      | Sales       | Chicago    |

-----

#### 14. Show employee names and ages

```sql
SELECT name, age 
FROM employees;
```

**Expected Output (sample):**

| name       | age |
|------------|-----|
| Ava Smith  | 34  |
| Noah Brown | 41  |

-----


#### 15. List female employees

```sql
SELECT * 
FROM employees 
WHERE gender = 'FEMALE';
```

**Expected Output (sample):**

| emp_id | name      | gender  |
|--------|-----------|---------|
| 5      | Emma Lee  | FEMALE  |

-----

#### 16. List male employees

```sql
SELECT * 
FROM employees 
WHERE gender =' MALE';
```

**Expected Output (sample):**

| emp_id | name     | gender |
|--------|----------|--------|
| 2      | Noah Kim | MALE   |

-----

#### 17. Employees with degree MBA

```sql
SELECT * 
FROM employees 
WHERE degree = 'MBA';
```

**Expected Output (sample):**

| emp_id | name      | degree |
|--------|-----------|--------|
| 9      | Ava Patel | MBA    |

-----


#### 18. Employees from USA

```sql
SELECT * 
FROM employees 
WHERE country = 'USA';
```

**Expected Output (sample):**

| emp_id | name      | country |
|--------|-----------|---------|
| 7      | Liam Doe  | USA     |

-----

#### 19. Employees older than 50

```sql
SELECT * 
FROM employees 
WHERE age > 50;
```

**Expected Output (sample):**

| emp_id | name       | age |
|--------|------------|-----|
| 8      | Noah Smith | 54  |

------

#### 20. Order employees by name

```sql
SELECT * 
FROM employees 
ORDER BY name;
```

**Expected Output (sample):**

| emp_id | name       |
|--------|------------|
| 3      | Ava Brown  |
| 5      | Emma Lee   |

------

#### 21. Top 5 highest salaries

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

#### 22. List all employees from USA and MS degrees

```sql
SELECT * 
FROM employees
WHERE country = 'USA' AND
      degree = 'MS';
```

OR

```sql
SELECT * 
FROM employees
WHERE (country = 'USA') AND
      (degree = 'MS');
```

**Expected Output (sample):**

| emp_id | name | age | degree | gender | country | dept_id | hire_date | salary |
|--------|------|-----|--------|--------|---------|---------|-----------|--------|
| 1      | Ava Smith | 34 | MS | FEMALE | USA | 10 | 2021-05-12 | 85000 |

-----

#### 23. List all departments

```sql
SELECT * 
FROM departments;
```

**Expected Output (sample):**

| dept_id | dept_name   | location   |
|---------|-------------|------------|
| 10      | Engineering | New York   |
| 20      | Sales       | Chicago    |

-------

#### 24. Show 10 employees by  names and age

```sql
SELECT name, age 
FROM employees
LIMIT 10;
```

**Expected Output (sample):**

| name       | age |
|------------|-----|
| Ava Smith  | 34  |
| Noah Brown | 41  |

-----

#### 25. List female employees with PHD degrees

```sql
SELECT * 
FROM employees 
WHERE (gender = 'FEMALE') AND 
      (degree = 'PHD');
```

-------

#### 26. List 5 of male employees sorted by name (A->Z)

```sql
SELECT * 
FROM employees 
WHERE gender = 'MALE'
ORDER BY name
LIMIT 5;
```

OR

```sql
SELECT * 
FROM employees 
WHERE gender = 'MALE'
ORDER BY name ASC
LIMIT 5;
```

-----

#### 27. List 5 of male employees sorted by name (Z->A)

```sql
SELECT * 
FROM employees 
WHERE gender = 'MALE'
ORDER BY name DESC
LIMIT 5;
```

------

#### 28. Employees with degree MBA

```sql
SELECT * 
FROM employees 
WHERE degree = 'MBA';
```

**Expected Output (sample):**

| emp_id | name      | degree |
|--------|-----------|--------|
| 9      | Ava Patel | MBA    |


#### 29. Male employees from USA and age older than 30

```sql
SELECT * 
FROM employees 
WHERE (gender = 'MALE') AND
      (country = 'USA') AND
      (age > 30);
```

------


##### 30. Female employees younger than 50

```sql
SELECT * 
FROM employees 
WHERE (gender = 'FEMALE') AND
      (age < 50);
```

------


#### 31. Order employees by name (A->Z), and list only 7 of them.

```sql
SELECT * 
FROM employees 
ORDER BY name
LIMIT 7;
```

OR


```sql
SELECT * 
FROM employees 
ORDER BY name ASC
LIMIT 7;
```
-------

#### 32. Order employees by name (Z->A), and list only 7 of them.

```sql
SELECT * 
FROM employees 
ORDER BY name DESC
LIMIT 7;
```


#### 33. Top 5 highest salaries

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

-------

#### 34. Bottom 5 lowest salaries

```sql
SELECT name, salary 
FROM employees 
ORDER BY salary  
LIMIT 5;
```

OR


```sql
SELECT name, salary 
FROM employees 
ORDER BY salary  ASC 
LIMIT 5;
```

------

#### 35. List all Engineering and Sales departments

```sql
SELECT * 
FROM departments
WHERE (dept_name = 'Engineering') OR
      (dept_name = 'Sales')
```

**Expected Output (sample):**

| dept_id | dept_name   | location   |
|---------|-------------|------------|
| 10      | Engineering | New York   |
| 20      | Sales       | Chicago    |

-----

#### 36. Top 3 highest salaries and Bottom 3 lowest salaries

```sql
-- 3 highest salaries
SELECT name, salary 
FROM employees 
ORDER BY salary DESC 
LIMIT 3

UNION

-- 3 lowest salaries
SELECT name, salary 
FROM employees 
ORDER BY salary ASC 
LIMIT 3
```

