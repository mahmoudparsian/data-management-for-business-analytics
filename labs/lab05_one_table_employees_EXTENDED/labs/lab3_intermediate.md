# Lab-3 – Intermediate Aggregations (30 queries)

> Table: `employees`
> 

~~~
employees:
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
~~~



### 1. Per department: total, avg, min, max salary.

```sql
SELECT department, 
       COUNT(*) AS n, 
       ROUND(AVG(salary)) AS avg_sal, 
       MIN(salary) AS min_sal, 
       MAX(salary) AS max_sal 
FROM employees 
GROUP BY department 
ORDER BY avg_sal DESC;
```

### 2. Per country: total employees and avg age.
```sql
SELECT country, 
       COUNT(*) AS n, 
       ROUND(AVG(age)) AS avg_age 
FROM employees 
GROUP BY country 
ORDER BY n DESC;
```

### 3. Per degree: avg salary, avg age.
```sql
SELECT degree, 
       ROUND(AVG(salary)) AS avg_sal, 
       ROUND(AVG(age)) AS avg_age 
FROM employees 
GROUP BY degree 
ORDER BY avg_sal DESC;
```

### 4. Per (country, department): headcount.
```sql
SELECT country, department, COUNT(*) AS n 
FROM employees 
GROUP BY country, department 
ORDER BY country, n DESC;
```

### 5. Departments with average salary between 90k and 120k.

solution-1: use HAVING

```sql
SELECT department, ROUND(AVG(salary)) AS avg_salary 
FROM employees 
GROUP BY department 
HAVING AVG(salary) BETWEEN 90000 AND 120000;
```

solution-2: use sub-query and the WHERE

```sql
WITH avg_salary_per_dept AS
(
  SELECT department, ROUND(AVG(salary)) AS avg_salary 
  FROM employees 
  GROUP BY department 
)
SELECT department, avg_salary 
FROM avg_salary_per_dept 
WHERE avg_salary BETWEEN 90000 AND 120000;
```

solution-3: use sub-query and the WHERE, and then AND

```sql
WITH avg_salary_per_dept AS
(
  SELECT department, ROUND(AVG(salary)) AS avg_salary 
  FROM employees 
  GROUP BY department 
)
SELECT department, avg_salary 
FROM avg_salary_per_dept 
WHERE (avg_salary >= 90000) AND 
      (avg_salary <= 120000);
```


### 6. Countries with at least 2 degrees represented.

solution-1: use HAVING

```sql
SELECT country, COUNT(DISTINCT degree) AS degree_per_country 
FROM employees 
GROUP BY country 
HAVING COUNT(DISTINCT degree) >= 2;
```

solution-2: use sub-query and the WHERE

```sql
WITH degree_per_country_table AS
(
  SELECT country, COUNT(DISTINCT degree) AS degree_per_country 
  FROM employees 
  GROUP BY country 
)
SELECT country, degree_per_country 
FROM degree_per_country_table
WHERE degree_per_country >= 2;
```



### 7. Top 3 departments by headcount.

```sql
SELECT department, COUNT(*) AS n 
FROM employees 
GROUP BY department 
ORDER BY n DESC 
LIMIT 3;
```

### 8. Bottom 3 departments by avg salary.

```sql
SELECT department, ROUND(AVG(salary)) AS avg_sal 
FROM employees 
GROUP BY department 
ORDER BY avg_sal ASC 
LIMIT 3;
```

### 9. For each country, count employees per age bucket (by 10s).

The `FLOOR()` function:

	The FLOOR() function returns the 
	largest integer that is less than 
	or equal to the numeric_expression. 
	
	SELECT FLOOR(25.75); -- Returns 25
	SELECT FLOOR(10);    -- Returns 10


```sql
SELECT country, 
       FLOOR(age/10)*10 AS age_bucket, 
       COUNT(*) AS n 
FROM employees 
GROUP BY country, age_bucket 
ORDER BY country, age_bucket;
```

### 10. Count of employees hired per year.
```sql
SELECT YEAR(hire_date) AS yr, 
       COUNT(*) AS n 
FROM employees 
GROUP BY YEAR(hire_date) 
ORDER BY yr;
```

### 11. Departments with > 50% MALE employees (approx).

```sql
WITH g AS 
(
  SELECT department, 
         SUM(CASE WHEN gender='MALE' THEN 1 ELSE 0 END) AS m, 
         COUNT(*) AS n
  FROM employees 
  GROUP BY department
)
SELECT department, m*1.0/n AS male_ratio 
FROM g 
WHERE m*1.0/n > 0.5;
```

### 12. Avg salary per (degree, department).

```sql
SELECT degree, 
       department, 
       ROUND(AVG(salary)) AS avg_sal 
FROM employees 
GROUP BY degree, department 
ORDER BY degree, avg_sal DESC;
```

### 13. Country with highest average salary.

```sql
SELECT country, 
       ROUND(AVG(salary)) AS avg_sal 
FROM employees 
GROUP BY country 
ORDER BY avg_sal DESC 
LIMIT 1;
```

### 14. Degree with lowest average salary.

```sql
SELECT degree, 
       ROUND(AVG(salary)) AS avg_sal 
FROM employees 
GROUP BY degree 
ORDER BY avg_sal ASC 
LIMIT 1;
```

### 15. How many unique last names?

```sql
SELECT COUNT(DISTINCT last_name) AS unique_last_names 
FROM employees;
```

### 16. Per department: count of degrees.

```sql
SELECT department, degree, COUNT(*) AS n 
FROM employees 
GROUP BY department, degree 
ORDER BY department ASC,
         n DESC;
```

### 17. Per country: count of departments represented.

```sql
SELECT country, 
       COUNT(DISTINCT department) AS dep_cnt 
FROM employees 
GROUP BY country 
ORDER BY dep_cnt DESC, country ASC;
```

### 18. Employees who earn above their country average.

solution-1:

```sql
SELECT e.* 
FROM employees e 
JOIN (
      SELECT country, AVG(salary) AS avg_country 
      FROM employees 
      GROUP BY country
     ) c 
  ON e.country=c.country 
WHERE e.salary > c. avg_country;
```


solution-2:

```sql
WITH avg_per_country_table AS
(
  SELECT country, AVG(salary) AS avg_country 
  FROM employees 
  GROUP BY country
)
SELECT e.* 
FROM employees e 
JOIN avg_per_country_table c 
  ON e.country=c.country 
WHERE e.salary > c.avg_country;
```

### 19. Employees who earn below their department average.

solution-1:

```sql
SELECT e.emp_id, 
       e.first_name, 
       e.department, 
       e.salary 
FROM employees e 
JOIN (SELECT department, AVG(salary) AS a FROM employees GROUP BY department) d 
  ON e.department = d.department 
WHERE e.salary < d.a;
```

solution-2:

```sql
WITH dept_averages AS
(
  SELECT department, AVG(salary) AS a 
  FROM employees 
  GROUP BY department
)
SELECT e.emp_id, 
       e.first_name, 
       e.department, 
       e.salary 
FROM employees e 
JOIN dept_averages d ON e.department = d.department 
WHERE e.salary < d.a;
```


### 20. Top degree by count within each department (ROW_NUMBER).

```sql
WITH x AS 
(
  SELECT department, 
         degree, 
         COUNT(*) AS n 
         FROM employees 
         GROUP BY department, degree
), 
r AS (
  SELECT *, 
  ROW_NUMBER() OVER (PARTITION BY department ORDER BY n DESC, degree ASC) AS rn 
  FROM x
)
SELECT department, degree, n 
FROM r 
WHERE rn=1;
```

output:

~~~
+-------------+--------+----+
| department  | degree | n  |
+-------------+--------+----+
| Business    | MBA    |  7 |
| Engineering | BS     | 18 |
| Finance     | MBA    |  8 |
| HR          | BS     |  7 |
| IT          | MS     | 12 |
| Marketing   | BS     | 15 |
+-------------+--------+----+
6 rows in set (0.00 sec)
~~~

### 21. Percent of employees per department (global).

~~~
mysql> SELECT COUNT(*) AS total FROM employees;
+-------+
| total |
+-------+
|   200 |
+-------+
1 row in set (0.01 sec)
~~~

```sql
WITH t AS (SELECT COUNT(*) AS total FROM employees)
SELECT department, 
       ROUND(COUNT(*)*100.0/(SELECT total FROM t),2) AS pct 
FROM employees 
GROUP BY department 
ORDER BY pct DESC;
```

output:

~~~
+-------------+-------+
| department  | pct   |
+-------------+-------+
| Engineering | 31.50 |
| IT          | 19.50 |
| Marketing   | 16.00 |
| Business    | 13.00 |
| Finance     | 11.50 |
| HR          |  8.50 |
+-------------+-------+
6 rows in set (0.00 sec)
~~~

### 22. Average salary per hire year.

**SELECT year from a date:**

~~~sql
mysql> select YEAR('2025-03-13');
+--------------------+
| YEAR('2025-03-13') |
+--------------------+
|               2025 |
+--------------------+
1 row in set (0.01 sec)
~~~


```sql
SELECT YEAR(hire_date) AS yr, 
       ROUND(AVG(salary)) AS avg_sal 
FROM employees 
GROUP BY YEAR(hire_date) 
ORDER BY yr;
```

output:

~~~
+------+---------+
| yr   | avg_sal |
+------+---------+
| 2020 |  108672 |
| 2021 |  105529 |
| 2022 |  111437 |
| 2023 |  107076 |
| 2024 |  107143 |
| 2025 |  112076 |
+------+---------+
6 rows in set (0.00 sec)
~~~

### 23. Headcount per (hire_year, department).

```sql
SELECT YEAR(hire_date) AS yr, 
       department, COUNT(*) AS n 
FROM employees 
GROUP BY YEAR(hire_date), department 
ORDER BY yr, n DESC;
```

### 24. Employees per (country, degree).

```sql
SELECT country, degree, COUNT(*) AS n 
FROM employees 
GROUP BY country, degree 
ORDER BY country, n DESC;
```

### 25. Top 5 salaries per department (list).

solution-1:

```sql
SELECT department, 
       GROUP_CONCAT(salary ORDER BY salary DESC SEPARATOR ', ') AS top_sals 
FROM (
       SELECT department, 
              salary, 
              ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn 
              FROM employees
     ) t 
WHERE rn <= 5
GROUP BY department;
```

output:

~~~
+-------------+----------------------------------------+
| department  | top_sals                               |
+-------------+----------------------------------------+
| Business    | 156342, 147511, 144015, 140322, 137959 |
| Engineering | 158168, 154839, 152817, 150476, 146562 |
| Finance     | 155787, 154868, 153767, 152966, 151082 |
| HR          | 153291, 140591, 137691, 131493, 129528 |
| IT          | 158170, 157574, 156656, 147716, 142981 |
| Marketing   | 146540, 143685, 142467, 142366, 140749 |
+-------------+----------------------------------------+
6 rows in set (0.00 sec)
~~~

solution-2:

```sql
WITH ranked_table AS
(
  SELECT department, 
         salary, 
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn 
  FROM employees
) 
SELECT department, 
       GROUP_CONCAT(salary ORDER BY salary DESC SEPARATOR ', ') AS top_sals 
FROM ranked_table t 
WHERE rn <= 5
GROUP BY department;
```

output:

~~~
+-------------+----------------------------------------+
| department  | top_sals                               |
+-------------+----------------------------------------+
| Business    | 156342, 147511, 144015, 140322, 137959 |
| Engineering | 158168, 154839, 152817, 150476, 146562 |
| Finance     | 155787, 154868, 153767, 152966, 151082 |
| HR          | 153291, 140591, 137691, 131493, 129528 |
| IT          | 158170, 157574, 156656, 147716, 142981 |
| Marketing   | 146540, 143685, 142467, 142366, 140749 |
+-------------+----------------------------------------+
6 rows in set (0.00 sec)
~~~


### 26. Countries where Engineering avg salary > global Engineering avg.

> Average salary for `department='Engineering'`

~~~sql
mysql> SELECT AVG(salary) AS g FROM employees WHERE department='Engineering';
+-------------+
| g           |
+-------------+
| 109346.0159 |
+-------------+
1 row in set (0.00 sec)
~~~


```sql
WITH eng AS (SELECT AVG(salary) AS g FROM employees WHERE department='Engineering')
SELECT country, ROUND(AVG(salary)) AS eng_avg 
FROM employees 
WHERE department='Engineering' 
GROUP BY country 
HAVING AVG(salary) > (SELECT g FROM eng);
```

output:

~~~
+---------+---------+
| country | eng_avg |
+---------+---------+
| FRANCE  |  117472 |
| INDIA   |  134964 |
| MEXICO  |  127651 |
+---------+---------+
3 rows in set (0.00 sec)
~~~

### 27. Quartile buckets by salary (approx).

sample output:

~~~
+----------+----+
| quartile | n  |
+----------+----+
| Q1       | 47 |
| Q2       | 36 |
| Q3       | 33 |
| Q4       | 84 |
+----------+----+
4 rows in set (0.01 sec)
~~~

```sql
SELECT CASE 
           WHEN salary < 80000 THEN 'Q1' 
           WHEN salary < 100000 THEN 'Q2' 
           WHEN salary < 120000 THEN 'Q3' 
           ELSE 'Q4' 
       END AS quartile, 
       COUNT(*) AS n 
FROM employees 
GROUP BY quartile 
ORDER BY quartile;
```

### 28. Most common first names (top 10).

```sql
SELECT first_name, COUNT(*) AS n 
FROM employees 
GROUP BY first_name 
ORDER BY n DESC, first_name ASC 
LIMIT 10;
```

output:

~~~
+------------+---+
| first_name | n |
+------------+---+
| Stella     | 6 |
| Violet     | 6 |
| Gianna     | 5 |
| Luke       | 5 |
| Noah       | 5 |
| Avery      | 4 |
| Camila     | 4 |
| Elijah     | 4 |
| Elsa       | 4 |
| Emma       | 4 |
+------------+---+
10 rows in set (0.00 sec)
~~~