# GROUP BY in SQL

## Teaching GROUP BY in SQL (Employees Table)

	We are teaching GROUP BY in SQL.
	Schema, and sample records are given.
 
    Provided 12 English/SQL queries
    ranging from simple to intermediate
    in markdown format. 

## Schema

```sql
CREATE TABLE employees (
   emp_id INT,
   country VARCHAR(30),
   degree VARCHAR(25),
   gender VARCHAR(10),
   department varchar(20),
   salary INT
);
```

## DATA

```sql
INSERT INTO 
employees(emp_id, country, degree, gender, department, salary)
VALUES
(1, 'USA', 'MS',  'MALE', 'AI', 170000),
(2, 'USA', 'MBA', 'MALE', 'Business', 140000),
(3, 'USA', 'PHD', 'FEMALE', 'AI', 180000),
(4, 'USA', 'PHD', 'MALE', 'IT', 160000),
(5, 'USA', 'BS', 'FEMALE', NULL, 120000),
(6, 'CANADA', 'BS',  'MALE', 'Engineering', 170000),
(7, 'CANADA', 'BS', 'MALE', 'Business', 130000),
(8, 'CANADA', 'PHD', 'FEMALE', 'AI', 190000),
(9, 'CANADA', 'MS', 'MALE', 'IT', 150000),
(10, 'INDIA', 'BS',  'FEMALE', 'Engineering', 140000),
(11, 'INDIA', 'MBA', 'FEMALE', 'Business', 160000),
(12, 'INDIA', 'PHD', 'FEMALE', 'AI', 180000),
(13, 'INDIA', 'MS', 'MALE', 'IT', 150000),
(14, 'INDIA', 'PHD', 'FEMALE', 'AI', 150000),
(15, 'INDIA', 'MS', 'MALE', 'IT', 120000);
```



---

## 🔹 12 GROUP BY Queries

### 1. Count employees in each country

```sql
SELECT country, 
       COUNT(*) AS num_employees
FROM employees
GROUP BY country;
```

### 2. Find average salary per country

```sql
SELECT country, 
       AVG(salary) AS avg_salary
FROM employees
GROUP BY country;
```

### 3. Find maximum salary per degree

```sql
SELECT degree, 
       MAX(salary) AS max_salary
FROM employees
GROUP BY degree;
```

### 4. Find minimum salary per gender

```sql
SELECT gender, 
       MIN(salary) AS min_salary
FROM employees
GROUP BY gender;
```

### 5. Find total salary per department

```sql
SELECT department, 
       SUM(salary) AS total_salary
FROM employees
GROUP BY department;
```

### 6. Count employees per country and degree

```sql
SELECT country, 
       degree, 
       COUNT(*) AS num_employees
FROM employees
GROUP BY country, degree;
```

### 7. Find average salary per country and department

```sql
SELECT country, 
       department, 
       AVG(salary) AS avg_salary
FROM employees
GROUP BY country, department;
```

### 8. Find highest salary per country and gender

```sql
SELECT country, 
       gender, 
       MAX(salary) AS max_salary
FROM employees
GROUP BY country, gender;
```

### 9. Find countries where average salary is greater than 150000

```sql
SELECT country, 
       AVG(salary) AS avg_salary
FROM employees
GROUP BY country
HAVING AVG(salary) > 150000;
```

### 10. Find departments with more than 2 employees

```sql
SELECT department, 
       COUNT(*) AS num_employees
FROM employees
GROUP BY department
HAVING COUNT(*) > 2;
```

### 11. Find degrees where average salary is above 160000

```sql
SELECT degree, 
       AVG(salary) AS avg_salary
FROM employees
GROUP BY degree
HAVING AVG(salary) > 160000;
```

### 12. Find total salary by country and department (exclude NULL departments)
```sql
SELECT country, 
       department, 
       SUM(salary) AS total_salary
FROM employees
WHERE department IS NOT NULL
GROUP BY country, department;
```
