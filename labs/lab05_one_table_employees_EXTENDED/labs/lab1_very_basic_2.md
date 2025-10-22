# Lab-1 – Very Basic (30 queries)

> employees  Table: 

~~~
employees(
  emp_id, 
  first_name, 
  last_name, 
  age, 
  degree, 
  gender, 
  country, 
  department, 
  hire_date, 
  salary
)
~~~

> MySQL schema:

~~~sql
-- MySQL schema
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    degree VARCHAR(10),
    gender VARCHAR(6),
    country VARCHAR(20),
    department VARCHAR(20),
    hire_date DATE,
    salary INT
);
~~~

### 1. Preview first 10 rows.
```sql
SELECT * 
FROM employees 
LIMIT 10;
```

### 2. Show only first_name, last_name.
```sql
SELECT first_name, last_name 
FROM employees 
LIMIT 10;
```

### 3. Find all employees in USA.
```sql
SELECT emp_id, first_name, last_name 
FROM employees 
WHERE country = 'USA' 
LIMIT 20;
```

### 4. Find employees older than 50.
```sql
SELECT emp_id, first_name, age 
FROM employees 
WHERE age > 50;
```

### 5. Find female employees from INDIA.
```sql
SELECT emp_id, first_name, last_name 
FROM employees 
WHERE gender = 'FEMALE' AND 
      country = 'INDIA';
```

### 6. Employees in IT department.
```sql
SELECT emp_id, first_name, last_name 
FROM employees 
WHERE department = 'IT' 
LIMIT 20;
```

### 7. Employees with salary > 120000.
```sql
SELECT emp_id, first_name, salary 
FROM employees 
WHERE salary > 120000;
```

### 8. Employees hired in 2023.
```sql
SELECT emp_id, first_name, hire_date 
FROM employees 
WHERE YEAR(hire_date) = 2023;
```

### 9. Sort by salary high → low (top 10).
```sql
SELECT emp_id, first_name, salary 
FROM employees 
ORDER BY salary DESC 
LIMIT 10;
```

### 10. Sort by last_name A → Z (first 10).
```sql
SELECT emp_id, first_name, last_name 
FROM employees 
ORDER BY last_name ASC 
LIMIT 10;
```

### 11. First Names starting with 'A'.
```sql
SELECT emp_id, first_name, last_name 
FROM employees 
WHERE first_name LIKE 'A%';
```

### 12. First Names containing 'an'.
```sql
SELECT emp_id, first_name, last_name 
FROM employees 
WHERE first_name LIKE '%an%';
```

### 13. Count employees quickly.
```sql
SELECT COUNT(*) AS num_employees 
FROM employees;
```

### 14. Change one person’s department to HR (demo).
```sql
UPDATE employees 
SET department='HR' 
WHERE emp_id = 1;
```

### 15. Give a 5% raise to emp_id=2 (demo).
```sql
UPDATE employees 
SET salary = ROUND(salary * 1.05) 
WHERE emp_id = 2;
```

### 16. Insert a demo employee (to delete later).
```sql
INSERT INTO employees 
VALUES 
(1001,'Demo','User',30,'BS','MALE','USA','IT','2024-01-01',90000);
```

### 17. Delete the demo employee.
```sql
DELETE 
FROM employees 
WHERE emp_id = 1001;
```

### 18. Employees with salary between 80k and 100k.

solution-1:

```sql
SELECT emp_id, first_name, salary 
FROM employees 
WHERE salary BETWEEN 80000 AND 100000;
```

solution-2:

```sql
SELECT emp_id, first_name, salary 
FROM employees 
WHERE (salary >= 80000) AND (salary <= 100000);
```


### 19. Employees in (USA, CANADA, MEXICO).

solution-1:

```sql
SELECT emp_id, first_name, country 
FROM employees 
WHERE country IN ('USA','CANADA','MEXICO');
```

solution-2:

```sql
SELECT emp_id, first_name, country 
FROM employees 
WHERE (country  = 'USA')    OR
      (country  = 'CANADA') OR
      (country  = 'MEXICO');
```


### 20. Employees NOT in Finance.
```sql
SELECT emp_id, first_name, department 
FROM employees 
WHERE department <> 'Finance';
```

### 21. List distinct degrees.
```sql
SELECT DISTINCT degree 
FROM employees;
```

### 22. List distinct departments.
```sql
SELECT DISTINCT department 
FROM employees;
```

### 23. Employees with NULL checks (should be none).
```sql
SELECT * FROM employees 
WHERE (first_name IS NULL) OR 
      (salary IS NULL);
```

### 24. Oldest 5 employees.
```sql
SELECT emp_id, first_name, age 
FROM employees 
ORDER BY age DESC
LIMIT 5;
```

### 25. Youngest 5 employees.
```sql
SELECT emp_id, first_name, age 
FROM employees 
ORDER BY age ASC 
LIMIT 5;
```

### 26. Employees hired after 2024-06-01.
```sql
SELECT emp_id, first_name, hire_date 
FROM employees 
WHERE hire_date > '2024-06-01';
```

### 27. Show full name via CONCAT.
```sql
SELECT emp_id, CONCAT(first_name,' ',last_name) AS full_name 
FROM employees LIMIT 10;
```

### 28. Simple aliasing.
```sql
SELECT e.emp_id AS id, 
       e.first_name AS fname 
FROM employees e 
LIMIT 10;
```

### 29. Random sample of 10 employees.
```sql
SELECT * FROM 
employees 
ORDER BY RAND() 
LIMIT 10;
```

### 30. SELECT an expression:
```sql
mysql> SELECT (1+2+3) as add_of_1_2_3, (4*5) as mult_4_5;
+--------------+----------+
| add_of_1_2_3 | mult_4_5 |
+--------------+----------+
|            6 |       20 |
+--------------+----------+
1 row in set (0.00 sec)
```

