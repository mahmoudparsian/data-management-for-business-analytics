## 3. 20 Advanced Queries (with ranking/subqueries)

## Table Schema

```sql
CREATE TABLE `employees` (
  `employee_id` int DEFAULT NULL,
  `employee_name` text,
  `age` int DEFAULT NULL,
  `country` text,
  `department` text,
  `position` text,
  `salary` double DEFAULT NULL,
  `joined_date` text
);
```

---


#### 	1.	Top 5 employees by salary using RANK.

```sql
WITH ranked AS (
  SELECT employee_id, employee_name, salary,
         RANK() OVER (ORDER BY salary DESC) AS rnk
  FROM employees
)
SELECT * FROM ranked WHERE rnk <= 5;
```

#### 	2.	Rank employees within each department by salary.

```sql
SELECT employee_id, employee_name, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rank
FROM employees;
```

#### 	3.	Dense rank by age.

```sql
SELECT employee_name, age,
       DENSE_RANK() OVER (ORDER BY age DESC) AS age_rank
FROM employees;
```

#### 	4.	Average salary per department using WITH.

```sql
WITH dept_avg AS (
  SELECT department, AVG(salary) AS avg_salary
  FROM employees GROUP BY department
)
SELECT * FROM dept_avg;
```

#### 	5.	Employees above dept average salary.

```sql
WITH dept_avg AS (
  SELECT department, AVG(salary) AS avg_salary
  FROM employees GROUP BY department
)
SELECT e.*
FROM employees e
JOIN dept_avg d ON e.department = d.department
WHERE e.salary > d.avg_salary;
```

#### 	6.	Highest paid employee per country using RANK.

```sql
WITH c_rank AS (
  SELECT country, employee_name, salary,
         RANK() OVER (PARTITION BY country ORDER BY salary DESC) AS rnk
  FROM employees
)
SELECT * FROM c_rank WHERE rnk = 1;
```

#### 	7.	Employees joined earliest per department.

```sql
WITH earliest AS (
  SELECT department, employee_name, joined_date,
         RANK() OVER (PARTITION BY department ORDER BY joined_date ASC) AS rnk
  FROM employees
)
SELECT * FROM earliest WHERE rnk = 1;
```

#### 	8.	Count employees older than company average age.

```sql
WITH avg_age AS (
  SELECT AVG(age) AS avg_age FROM employees
)
SELECT COUNT(*) 
FROM employees e, avg_age a 
WHERE e.age > a.avg_age;
```

#### 	9.	Top 3 salaries in Finance.

```sql
WITH ranked AS (
  SELECT employee_name, salary,
         RANK() OVER (ORDER BY salary DESC) AS rnk
  FROM employees WHERE department='Finance'
)
SELECT * FROM ranked WHERE rnk <= 3;
```

#### 	10.	Average salary per position per department.

```sql
SELECT department, position, AVG(salary)
FROM employees
GROUP BY department, position;
```

#### 	11.	Employees with salary above overall median (approx via subquery).

```sql
SELECT * FROM employees
WHERE salary > (
  SELECT AVG(salary) FROM (
    SELECT salary FROM employees ORDER BY salary LIMIT 2 OFFSET (SELECT COUNT(*)/2 FROM employees)
  ) AS median_calc
);
```

#### 	12.	Departments ranked by number of employees.

```sql
SELECT department, COUNT(*) AS num_emp,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS dept_rank
FROM employees GROUP BY department;
```

#### 	13.	Top 2 employees per department.

```sql
WITH dept_rank AS (
  SELECT employee_id, employee_name, department, salary,
         RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
  FROM employees
)
SELECT * FROM dept_rank WHERE rnk <= 2;
```

#### 	14.	Employees who joined last per department.

```sql
WITH dept_last AS (
  SELECT department, employee_name, joined_date,
         RANK() OVER (PARTITION BY department ORDER BY joined_date DESC) AS rnk
  FROM employees
)
SELECT * FROM dept_last WHERE rnk = 1;
```

#### 	15.	Countries ranked by avg salary.

```sql
SELECT country, AVG(salary) AS avg_salary,
       RANK() OVER (ORDER BY AVG(salary) DESC) AS rnk
FROM employees GROUP BY country;
```

#### 	16.	Employees in top 10% salary bracket.

```sql
WITH ranked AS (
  SELECT employee_name, salary,
         PERCENT_RANK() OVER (ORDER BY salary DESC) AS pr
  FROM employees
)
SELECT * FROM ranked WHERE pr <= 0.1;
```

#### 	17.	Department with maximum average age.

```sql
WITH avg_age AS (
  SELECT department, AVG(age) AS avg_age
  FROM employees GROUP BY department
)
SELECT * FROM avg_age ORDER BY avg_age DESC LIMIT 1;
```

#### 	18.	Employees in departments with > average employee count.

```sql
WITH dept_count AS (
  SELECT department, COUNT(*) AS cnt
  FROM employees GROUP BY department
)
SELECT e.* 
FROM employees e
JOIN dept_count d ON e.department = d.department
WHERE d.cnt > (SELECT AVG(cnt) FROM dept_count);
```

#### 	19.	Compare salary of each employee to dept avg.

```sql
WITH dept_avg AS (
  SELECT department, AVG(salary) AS avg_salary
  FROM employees GROUP BY department
)
SELECT e.employee_name, e.department, e.salary, d.avg_salary,
       (e.salary - d.avg_salary) AS diff
FROM employees e
JOIN dept_avg d ON e.department = d.department;
```

#### 	20.	Employees hired before their country’s average join date.

```sql
WITH avg_join AS (
  SELECT country, AVG(YEAR(joined_date)) AS avg_year
  FROM employees GROUP BY country
)
SELECT e.*
FROM employees e
JOIN avg_join a ON e.country=a.country
WHERE YEAR(e.joined_date) < a.avg_year;
```


