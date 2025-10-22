# 📘 Lab 2 : Aggregation and GROUP BY (Employees Table)

## Schema: employees Table

~~~sql
CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  department VARCHAR(30),
  salary DECIMAL(10,2),
  hire_date DATE
);
~~~

## Queries

#### 1. Average salary of all employees:  

solution-1:

```sql
SELECT AVG(salary) 
FROM employees;
```

solution-2:

```sql
SELECT AVG(salary) as avg_salary
FROM employees;
```

#### 2. Maximum salary:  

solution-1:

```sql
SELECT MAX(salary) 
FROM employees;
```

solution-2:

```sql
SELECT MAX(salary) as max_salary
FROM employees;
```

#### 3. Minimum salary:  

solution-1:

```sql
SELECT MIN(salary) 
FROM employees;
```

solution-2:

```sql
SELECT MIN(salary) as min_salary
FROM employees;
```

#### 4. Total salary:  

solution-1:

```sql
SELECT SUM(salary) 
FROM employees;
```

solution-2:

```sql
SELECT SUM(salary) as total_salary
FROM employees;
```

#### 5. Count employees in each department:  

solution-1:

```sql
SELECT department, COUNT(*) 
FROM employees 
GROUP BY department;
```

solution-2:

```sql
SELECT department, COUNT(*) as num_of_emps
FROM employees 
GROUP BY department;
```

#### 6. Average salary in each department:  

solution-1:

```sql
SELECT department, AVG(salary) 
FROM employees 
GROUP BY department;
```

solution-2:

```sql
SELECT department, AVG(salary) as avg_salary
FROM employees 
GROUP BY department;
```

#### 7. Departments with more than 5 employees:  

solution-1:

```sql
SELECT department, COUNT(*) 
FROM employees 
GROUP BY department 
HAVING COUNT(*) > 5;
```

solution-2:

```sql
SELECT department, COUNT(*) as count_of_emps
FROM employees 
GROUP BY department 
HAVING COUNT(*) > 5;
```

solution-3:

```sql
WITH counted_employees AS
(
  SELECT department, COUNT(*) as count_of_emps
  FROM employees 
  GROUP BY department 
)
SELECT department, count_of_emps
FROM counted_employees 
WHERE count_of_emps> 5;
```


### 8. Departments with average `salary > 70000`:  


solution-1:

```sql
SELECT department, AVG(salary)
FROM employees 
GROUP BY department 
HAVING AVG(salary) > 70000;
```

solution-2:

```sql
SELECT department, AVG(salary) as avg_salary
FROM employees 
GROUP BY department 
HAVING AVG(salary) > 70000;
```

solution-3:

```sql
WITH avg_per_department AS
(
  SELECT department, AVG(salary) as avg_salary
  FROM employees 
  GROUP BY department 
)
SELECT department, avg_salary
FROM avg_per_department 
WHERE avg_salary> 70000;
```

#### 9. Newest hire date per department:  

solution-1:

```sql
SELECT department, MAX(hire_date) 
FROM employees 
GROUP BY department;
```

solution-2:

```sql
SELECT department, MAX(hire_date)  as max_hire_date
FROM employees 
GROUP BY department;
```


#### 10. Oldest hire date per department:  


solution-1:

```sql
SELECT department, MIN(hire_date) 
FROM employees 
GROUP BY department;
```

solution-2:

```sql
SELECT department, MIN(hire_date)  as min_hire_date
FROM employees 
GROUP BY department;
```

-------

## 📘 5 intermediate SQL queries 


#### 11.	Find the number of employees in each department.

~~~mysql
SELECT department, COUNT(*) AS num_employees
FROM employees
GROUP BY department;
~~~

#### 12.	Find the average salary in each department.

~~~sql
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department;
~~~

#### 13.	Find departments with more than 5 employees.

solution-1:

~~~sql
SELECT department, COUNT(*) AS num_employees
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;
~~~

solution-2:

~~~sql
WITH count_per_dept AS 
(
  SELECT department, COUNT(*) AS num_employees
  FROM employees
  GROUP BY department
)
SELECT department, num_employees
FROM count_per_dept
WHERE num_employees > 5;
~~~



#### 14.	Find departments where the average salary is greater than 80,000.

solution-1:

~~~sql
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 80000;
~~~

solution-2:

~~~sql
WITH avg_per_dept AS
(
  SELECT department, AVG(salary) AS avg_salary
  FROM employees
  GROUP BY department
)
SELECT department, avg_salary
FROM avg_per_dept
WHERE avg_salary  > 80000;
~~~


#### 15.	Find the newest hire in each department.

~~~sql
SELECT department, MAX(hire_date) AS newest_hire
FROM employees
GROUP BY department;
~~~

⸻

## 🔹 10 Intermediate Queries

#### 16.	Find employees earning above the company’s average salary.

~~~sql
WITH avg_sal AS (
  SELECT AVG(salary) AS company_avg 
  FROM employees
)
SELECT e.*
FROM employees e, avg_sal
WHERE e.salary > avg_sal.company_avg;
~~~

⸻

#### 17.	Find departments with average salary greater than 80,000.

~~~sql
WITH dept_avg AS (
  SELECT department, AVG(salary) AS avg_salary
  FROM employees
  GROUP BY department
)
SELECT * FROM dept_avg 
WHERE avg_salary > 80000;
~~~

⸻

#### 18.	Find the top 3 highest-paid employees in the company.

~~~sql
WITH ranked AS (
  SELECT first_name, 
         last_name, 
         salary,
         RANK() OVER (ORDER BY salary DESC) AS rnk
  FROM employees
)
SELECT * 
FROM ranked 
WHERE rnk <= 3;
~~~

⸻

#### 19.	Find the highest-paid employee in each department.

~~~sql
WITH ranked AS (
  SELECT department, 
         first_name, 
         last_name, salary,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn
  FROM employees
)
SELECT department, first_name, last_name, salary
FROM ranked WHERE rn = 1;
~~~

⸻

#### 20.	Rank departments by their total salary expense.

~~~sql
WITH dept_totals AS (
  SELECT department, SUM(salary) AS total_salary
  FROM employees
  GROUP BY department
)
SELECT department, 
       total_salary,
       RANK() OVER (ORDER BY total_salary DESC) AS dept_rank
FROM dept_totals;
~~~


⸻

#### 21.	Find employees whose salary is above their department’s average.

~~~sql
WITH dept_avg AS (
  SELECT department, AVG(salary) AS avg_salary
  FROM employees
  GROUP BY department
)
SELECT e.first_name, 
       e.last_name, 
       e.department, 
       e.salary, 
       d.avg_salary
FROM employees e
JOIN dept_avg d ON e.department = d.department
WHERE e.salary > d.avg_salary;
~~~

⸻

#### 22.	List the top 2 newest hires in each department.

~~~sql
WITH ranked AS (
  SELECT department, first_name, last_name, hire_date,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY hire_date DESC) AS rn
  FROM employees
)
SELECT * 
FROM ranked WHERE rn <= 2;
~~~

⸻

#### 23.	Find the oldest hire in each department.

~~~sql
WITH ranked AS (
  SELECT department, first_name, last_name, hire_date,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY hire_date ASC) AS rn
  FROM employees
)
SELECT * 
FROM ranked 
WHERE rn = 1;
~~~

⸻

#### 24.	Calculate the difference between each employee’s salary and their department’s average.

~~~sql
WITH dept_avg AS (
  SELECT department, AVG(salary) AS avg_salary
  FROM employees
  GROUP BY department
)
SELECT e.first_name, e.last_name, e.department, e.salary,
       (e.salary - d.avg_salary) AS diff_from_avg
FROM employees e
JOIN dept_avg d ON e.department = d.department;
~~~

⸻

#### 25.	Find employees in the top 10% of salaries.

~~~sql
WITH ranked AS (
  SELECT emp_id, first_name, last_name, salary,
         PERCENT_RANK() OVER (ORDER BY salary DESC) AS pct_rank
  FROM employees
)
SELECT * 
FROM ranked 
WHERE pct_rank <= 0.1;
~~~

⸻

