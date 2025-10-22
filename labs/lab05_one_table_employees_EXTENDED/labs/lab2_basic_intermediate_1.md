# 20 Simple-to-Intermediate SQL Queries for Employees Table

**1. Count employees per department.**

```sql
SELECT department, COUNT(*) AS emp_count 
FROM employees 
GROUP BY department;
```

**2. Average salary per department.**

```sql
SELECT department, AVG(salary) AS avg_salary 
FROM employees 
GROUP BY department;
```

**3. Maximum salary per department.**

```sql
SELECT department, MAX(salary) AS max_salary 
FROM employees 
GROUP BY department;
```

**4. Minimum salary per department.**

```sql
SELECT department, MIN(salary) AS min_salary 
FROM employees 
GROUP BY department;
```

**5. Average age per department.**

```sql
SELECT department, AVG(age) AS avg_age 
FROM employees 
GROUP BY department;
```

**6. Count employees per country.**

```sql
SELECT country, COUNT(*) AS emp_count 
FROM employees 
GROUP BY country;
```

**7. Average salary per country.**

```sql
SELECT country, AVG(salary) AS avg_salary 
FROM employees 
GROUP BY country;
```

**8. Employees count per degree.**

```sql
SELECT degree, COUNT(*) AS emp_count 
FROM employees 
GROUP BY degree;
```

**9. Average salary per degree.**

```sql
SELECT degree, AVG(salary) AS avg_salary 
FROM employees 
GROUP BY degree;
```

**10. Number of employees per gender.**

```sql
SELECT gender, COUNT(*) 
FROM employees 
GROUP BY gender;
```

**11. Average age per gender.**

```sql
SELECT gender, AVG(age) 
FROM employees 
GROUP BY gender;
```

**12. Highest salary per country.**

```sql
SELECT country, MAX(salary) 
FROM employees 
GROUP BY country;
```

**13. Lowest salary per country.**

```sql
SELECT country, MIN(salary) 
FROM employees 
GROUP BY country;
```

**14. Count employees per hire year.**

solution-1:

```sql
SELECT YEAR(hire_date) AS hire_year, 
       COUNT(*) 
FROM employees 
GROUP BY YEAR(hire_date);
```

solution-1:

```sql
SELECT YEAR(hire_date) AS hire_year, 
       COUNT(*) 
FROM employees 
GROUP BY YEAR(hire_date);
```

solution-2:

```sql
WITH year_table AS
(
  SELECT YEAR(hire_date) AS hire_year 
  FROM employees 
)
SELECT hire_year, 
       count(*) 
FROM year_table
GROUP BY hire_year;
```

**15. Average salary per hire year.**

```sql
SELECT YEAR(hire_date) AS hire_year, 
       AVG(salary) AS avg_salary
FROM employees 
GROUP BY YEAR(hire_date);
```

**16. Total salary per department.**

```sql
SELECT department, 
       SUM(salary) AS total_salary 
FROM employees 
GROUP BY department;
```

**17. Average salary per gender within each department.**

Group by 2 columns: department, gender

```sql
SELECT department, 
       gender, 
       AVG(salary) 
FROM employees 
GROUP BY department, gender;
```

**18. Number of employees per country and department.**

Group by 2 columns: country, department

```sql
SELECT country, 
       department, 
       COUNT(*) 
FROM employees 
GROUP BY country, department;
```

**19. Average age per country and gender.**

Group by 2 columns: country, gender

```sql
SELECT country, 
       gender, 
       AVG(age) 
FROM employees 
GROUP BY country, gender;
```

**20. Maximum salary per degree and gender.**

Group by 2 columns: degree, gender

```sql
SELECT degree, gender, MAX(salary) 
FROM employees 
GROUP BY degree, gender;
```

