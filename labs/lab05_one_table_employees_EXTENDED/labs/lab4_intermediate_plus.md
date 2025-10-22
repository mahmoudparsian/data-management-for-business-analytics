# Lab-4 – Intermediate Plus (30 queries)

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


### 1. Salary > dept avg by 20%.

**Average salary per department:**

~~~mysql
SELECT department, AVG(salary) AS avg_sal 
FROM employees 
GROUP BY department;
  
+-------------+-------------+
| department  | avg_sal     |
+-------------+-------------+
| Engineering | 109346.0159 |
| Finance     | 115698.1739 |
| Marketing   | 111512.9688 |
| IT          | 102673.8462 |
| Business    | 107917.6923 |
| HR          | 104842.6471 |
+-------------+-------------+
~~~

**Salary > dept avg by 20%:**

```sql
WITH d AS 
(
  SELECT department, AVG(salary) AS avg_sal 
  FROM employees 
  GROUP BY department
)
SELECT e.emp_id, 
       e.first_name, 
       e.department, 
       e.salary, 
       d.avg_sal 
FROM employees e 
JOIN d ON e.department = d.department 
WHERE e.salary > 1.2 * d.avg_sal 
ORDER BY e.salary DESC;
```

### 2. Salary < country avg by 15%.

**Average salary per country:**

~~~sql
SELECT country, AVG(salary) AS avg_sal 
FROM employees 
GROUP BY country

+---------+-------------+
| country | avg_sal     |
+---------+-------------+
| CHINA   | 107187.7742 |
| CANADA  | 100433.7917 |
| INDIA   | 119077.5357 |
| ITALY   | 101915.0667 |
| FRANCE  | 124359.9545 |
| USA     | 101964.2609 |
| GERMANY | 106773.7391 |
| MEXICO  | 107841.5263 |
+---------+-------------+

~~~

**Salary < country avg by 15%**:

```sql
WITH c AS 
( 
  SELECT country, AVG(salary) AS avg_sal 
  FROM employees 
  GROUP BY country
)
SELECT e.emp_id, 
       e.first_name, 
       e.country, 
       e.salary, 
       c.avg_sal 
FROM employees e 
JOIN c ON e.country = c.country 
WHERE e.salary < 0.85 * c.avg_sal 
ORDER BY e.salary ASC;
```

### 3. Top 3 salaries per department (ROW_NUMBER).

```sql
WITH r AS 
(
  SELECT emp_id, 
         first_name, 
         department, 
         salary, 
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn
  FROM employees
)
SELECT * 
FROM r 
WHERE rn <= 3 
ORDER BY department, salary DESC;
```

### 4. DENSE_RANK departments by avg salary.

```sql
WITH a AS 
(
  SELECT department, ROUND(AVG(salary)) AS avg_sal
  FROM employees 
  GROUP BY department
)
SELECT department, 
       avg_sal, 
       DENSE_RANK() OVER (ORDER BY avg_sal DESC) AS rnk 
FROM a 
ORDER BY rnk;
```

output:

~~~
+-------------+---------+-----+
| department  | avg_sal | rnk |
+-------------+---------+-----+
| Finance     |  115698 |   1 |
| Marketing   |  111513 |   2 |
| Engineering |  109346 |   3 |
| Business    |  107918 |   4 |
| HR          |  104843 |   5 |
| IT          |  102674 |   6 |
+-------------+---------+-----+
6 rows in set (0.00 sec)
~~~

### 5. RANK countries by headcount.
```sql
WITH c AS 
(
  SELECT country, 
         COUNT(*) AS num_per_country 
  FROM employees 
  GROUP BY country
)
SELECT country, 
       num_per_country, 
       RANK() OVER (ORDER BY num_per_country DESC) AS rnk 
FROM c 
ORDER BY rnk;
```

output:

~~~
+---------+-----------------+-----+
| country | num_per_country | rnk |
+---------+-----------------+-----+
| CHINA   |              31 |   1 |
| ITALY   |              30 |   2 |
| INDIA   |              28 |   3 |
| CANADA  |              24 |   4 |
| USA     |              23 |   5 |
| GERMANY |              23 |   5 |
| FRANCE  |              22 |   7 |
| MEXICO  |              19 |   8 |
+---------+-----------------+-----+
8 rows in set (0.00 sec)
~~~


### 6. ROW_NUMBER by salary desc (top 20).

```sql
SELECT emp_id, 
       first_name, 
       salary, 
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn 
FROM employees 
ORDER BY salary DESC
LIMIT 20;
```

### 7. Approx 90th percentile via NTILE.

Divide all by salary into 10 partitions:

~~~sql
SELECT salary,
       NTILE(10) OVER (ORDER BY salary) AS decile
FROM employees;
 
+--------+--------+
| salary | decile |
+--------+--------+
|  60075 |      1 |
...
|  67850 |      1 |
|  67892 |      2 |
...
|  78741 |      2 |
|  78922 |      3 |
...
|  88074 |      3 |
|  89787 |      4 |
...
|  98758 |      4 |
|  99456 |      5 |
...
| 108701 |      5 |
| 109388 |      6 |
...
| 120903 |      6 |
| 121451 |      7 |
...
| 127729 |      7 |
| 127759 |      8 |
...
| 137783 |      8 |
| 137959 |      9 |
...
| 144015 |      9 |
| 144182 |     10 |
...
| 158170 |     10 |
+--------+--------+
200 rows in set (0.00 sec)
~~~

```sql
WITH r AS 
(
  SELECT salary, 
  NTILE(10) OVER (ORDER BY salary) AS decile 
  FROM employees
)
SELECT MIN(salary) AS approx_p90 
FROM r 
WHERE decile = 10;
```

### 8. Running total salaries by hire year.
```sql
WITH s AS 
(
  SELECT YEAR(hire_date) AS yr, 
  SUM(salary) AS total 
  FROM employees 
  GROUP BY YEAR(hire_date)
)
SELECT yr, 
       total, 
       SUM(total) OVER (ORDER BY yr) AS running 
FROM s 
ORDER BY yr;
```

output:

~~~
+------+---------+----------+
| yr   | total   | running  |
+------+---------+----------+
| 2020 | 4020867 |  4020867 |
| 2021 | 3165874 |  7186741 |
| 2022 | 3454553 | 10641294 |
| 2023 | 3533522 | 14174816 |
| 2024 | 4285725 | 18460541 |
| 2025 | 3250196 | 21710737 |
+------+---------+----------+
6 rows in set (0.00 sec)
~~~


### 9. Dept salary share of total.
```sql
WITH t AS 
(
  SELECT SUM(salary) AS total 
  FROM employees
)
, 
d AS 
(
  SELECT department, SUM(salary) AS dep_total 
  FROM employees 
  GROUP BY department
)
SELECT d.department, 
       d.dep_total, 
       ROUND(d.dep_total*100.0/t.total, 2) AS pct 
FROM d, t 
ORDER BY pct DESC;
```

output:

~~~
+-------------+-----------+-------+
| department  | dep_total | pct   |
+-------------+-----------+-------+
| Engineering |   6888799 | 31.73 |
| IT          |   4004280 | 18.44 |
| Marketing   |   3568415 | 16.44 |
| Business    |   2805860 | 12.92 |
| Finance     |   2661058 | 12.26 |
| HR          |   1782325 |  8.21 |
+-------------+-----------+-------+
6 rows in set (0.00 sec)
~~~



### 10. Headcount share by country per department.
```sql
WITH c AS 
(
  SELECT department, country, COUNT(*) AS n 
  FROM employees 
  GROUP BY department, country)
, 
t AS 
(
  SELECT department, SUM(n) AS dep_total 
  FROM c 
  GROUP BY department
)
SELECT  c.department, 
        c.country, 
        ROUND(c.n*100.0/t.dep_total, 2) AS pct 
FROM c 
JOIN t ON c.department = t.department 
ORDER BY c.department, pct DESC;
```

output:

~~~
+-------------+---------+-------+
| department  | country | pct   |
+-------------+---------+-------+
| Business    | ITALY   | 30.77 |
| Business    | CANADA  | 19.23 |
| Business    | GERMANY | 15.38 |
| Business    | FRANCE  | 11.54 |
| Business    | INDIA   |  7.69 |
| Business    | MEXICO  |  7.69 |
| Business    | CHINA   |  3.85 |
| Business    | USA     |  3.85 |
...
+-------------+---------+-------+
45 rows in set (0.00 sec)
~~~

### 11. Top 10% salaries globally.
```sql
WITH r AS 
(
  SELECT emp_id, 
         salary, 
         ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn, 
         COUNT(*) OVER () AS n 
  FROM employees
)
SELECT emp_id, 
       salary,
       rn 
FROM r 
WHERE rn <= CEIL(0.10*n) 
ORDER BY salary DESC;
```

output:

~~~
+--------+--------+----+
| emp_id | salary | rn |
+--------+--------+----+
|     20 | 158170 |  1 |
|    197 | 158168 |  2 |
|     66 | 157574 |  3 |
|    170 | 156656 |  4 |
|     27 | 156342 |  5 |
|    143 | 155787 |  6 |
|    121 | 154868 |  7 |
|     45 | 154839 |  8 |
|    129 | 153767 |  9 |
|    118 | 153291 | 10 |
|     92 | 152966 | 11 |
|    100 | 152817 | 12 |
|    142 | 151082 | 13 |
|    139 | 150476 | 14 |
|    177 | 147716 | 15 |
|    117 | 147511 | 16 |
|    153 | 147429 | 17 |
|    182 | 146562 | 18 |
|    108 | 146540 | 19 |
|     70 | 144182 | 20 |
+--------+--------+----+
20 rows in set (0.01 sec)
~~~

### 12. Bottom 10% salaries globally.

```sql
WITH r AS 
(
  SELECT emp_id, 
         salary, 
         ROW_NUMBER() OVER (ORDER BY salary ASC) AS rn, 
         COUNT(*) OVER () AS n 
  FROM employees
)
SELECT emp_id, 
       salary 
FROM r 
WHERE rn <= CEIL(0.10*n) 
ORDER BY salary ASC;
```

output:

~~~
+--------+--------+
| emp_id | salary |
+--------+--------+
|    145 |  60075 |
|    194 |  60458 |
|     63 |  61736 |
|    126 |  62430 |
|    195 |  62538 |
|     12 |  62573 |
|    176 |  62673 |
|     23 |  62786 |
|     54 |  63047 |
|     94 |  63161 |
|     76 |  63520 |
|    156 |  64405 |
|    105 |  64767 |
|     43 |  64867 |
|    192 |  64998 |
|     32 |  65317 |
|    163 |  65546 |
|     77 |  66919 |
|    175 |  67503 |
|     10 |  67850 |
+--------+--------+
20 rows in set (0.00 sec)
~~~


### 13. Top degree by average salary (global).

```sql
WITH a AS 
(
  SELECT degree, 
         ROUND(AVG(salary)) AS avg_sal 
  FROM employees 
  GROUP BY degree
)
SELECT degree, 
       avg_sal 
FROM a 
ORDER BY avg_sal DESC 
LIMIT 1;
```

output:

~~~
+--------+---------+
| degree | avg_sal |
+--------+---------+
| MS     |  114664 |
+--------+---------+
1 row in set (0.00 sec)
~~~



### 14. Most common degree within each country.

```sql
WITH x AS 
(
   SELECT country, 
          degree, 
          COUNT(*) AS n 
   FROM employees 
   GROUP BY country, degree
)
, r AS 
(
  SELECT *, 
         ROW_NUMBER() OVER (PARTITION BY country ORDER BY n DESC, degree ASC) 
           AS rn 
  FROM x
)
SELECT country, 
       degree, 
       n 
FROM r 
WHERE rn=1 
ORDER BY country;
```

output:

~~~
+---------+--------+----+
| country | degree | n  |
+---------+--------+----+
| CANADA  | BS     |  7 |
| CHINA   | BS     | 11 |
| FRANCE  | MBA    | 10 |
| GERMANY | BS     |  7 |
| INDIA   | BS     | 10 |
| ITALY   | BS     | 10 |
| MEXICO  | BS     |  6 |
| USA     | PHD    |  7 |
+---------+--------+----+
8 rows in set (0.00 sec)
~~~


### 15. Most common department within each country.

```sql
WITH x AS 
(
  SELECT country, 
         department, 
         COUNT(*) AS n 
  FROM employees 
  GROUP BY country, department
)
, r AS 
(
  SELECT *, 
         ROW_NUMBER() OVER (PARTITION BY country ORDER BY n DESC, department ASC) 
           AS rn 
  FROM x
)
SELECT country, 
       department, 
       n 
FROM r 
WHERE rn=1 
ORDER BY country;
```

output:

~~~
+---------+-------------+----+
| country | department  | n  |
+---------+-------------+----+
| CANADA  | Engineering |  9 |
| CHINA   | Engineering | 12 |
| FRANCE  | Engineering | 11 |
| GERMANY | Engineering |  9 |
| INDIA   | Engineering |  7 |
| ITALY   | Business    |  8 |
| MEXICO  | Engineering |  6 |
| USA     | IT          |  9 |
+---------+-------------+----+
8 rows in set (0.00 sec)
~~~


### 16. Oldest employee per department.

```sql
WITH r AS 
(
  SELECT emp_id, 
         first_name, 
         department, 
         age, 
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY age DESC) 
           AS rn 
  FROM employees
)
SELECT * 
FROM r 
WHERE rn=1;
```

output:

~~~
+--------+------------+-------------+------+----+
| emp_id | first_name | department  | age  | rn |
+--------+------------+-------------+------+----+
|    176 | Alexander  | Business    |   77 |  1 |
|     33 | Faith      | Engineering |   78 |  1 |
|    157 | Jason      | Finance     |   76 |  1 |
|    151 | Gianna     | HR          |   74 |  1 |
|    170 | Violet     | IT          |   78 |  1 |
|     39 | Isaac      | Marketing   |   78 |  1 |
+--------+------------+-------------+------+----+
6 rows in set (0.00 sec)
~~~


### 17. Youngest employee per department.

```sql
WITH r AS 
(
  SELECT emp_id, 
         first_name, 
         department, 
         age, 
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY age ASC) 
           AS rn 
  FROM employees
)
SELECT * 
FROM r 
WHERE rn=1;
```

output:

~~~
+--------+------------+-------------+------+----+
| emp_id | first_name | department  | age  | rn |
+--------+------------+-------------+------+----+
|    162 | Alexander  | Business    |   19 |  1 |
|    102 | Isaac      | Engineering |   19 |  1 |
|    114 | Faith      | Finance     |   24 |  1 |
|     52 | Gianna     | HR          |   19 |  1 |
|    172 | Avery      | IT          |   21 |  1 |
|    101 | Jason      | Marketing   |   20 |  1 |
+--------+------------+-------------+------+----+
6 rows in set (0.00 sec)
~~~

### 18. Most recent hire per department.

```sql
WITH r AS 
(
  SELECT emp_id, 
         first_name, 
         department, 
         hire_date, 
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY hire_date DESC) 
           AS rn 
  FROM employees
)
SELECT * 
FROM r 
WHERE rn=1;
```

output:

~~~
+--------+------------+-------------+------------+----+
| emp_id | first_name | department  | hire_date  | rn |
+--------+------------+-------------+------------+----+
|    126 | Noah       | Business    | 2025-12-10 |  1 |
|     45 | Mateo      | Engineering | 2025-10-16 |  1 |
|     22 | Luke       | Finance     | 2025-11-07 |  1 |
|    164 | Daisy      | HR          | 2025-09-22 |  1 |
|    167 | Jade       | IT          | 2025-11-22 |  1 |
|     55 | Avery      | Marketing   | 2025-12-27 |  1 |
+--------+------------+-------------+------------+----+
6 rows in set (0.00 sec)
~~~

### 19. Department salary variance (pop).

```sql
SELECT department, 
       ROUND(VAR_POP(salary), 2) AS var_pop 
FROM employees 
GROUP BY department 
ORDER BY var_pop DESC;
```

output:

~~~
+-------------+--------------+
| department  | var_pop      |
+-------------+--------------+
| Business    |  994671802.6 |
| IT          | 897091106.54 |
| Finance     | 880428954.06 |
| Engineering | 741394627.63 |
| HR          | 673934374.35 |
| Marketing   | 642040264.41 |
+-------------+--------------+
6 rows in set (0.00 sec)
~~~

### 20. Country salary std-deviation (pop).

```sql
SELECT country, 
       ROUND(STDDEV_POP(salary), 2) AS std_pop 
FROM employees 
GROUP BY country 
ORDER BY std_pop DESC;
```

output:

~~~
+---------+----------+
| country | std_pop  |
+---------+----------+
| GERMANY | 31203.56 |
| ITALY   | 30402.72 |
| MEXICO  | 27926.77 |
| USA     | 27642.83 |
| FRANCE  | 26130.95 |
| INDIA   | 26121.54 |
| CHINA   | 25750.32 |
| CANADA  | 23321.65 |
+---------+----------+
8 rows in set (0.00 sec)
~~~

### 21. Departments with > 30% >120k salaries.
```sql
WITH x AS 
(
  SELECT department, 
         SUM(CASE WHEN salary>120000 THEN 1 ELSE 0 END) AS hi, 
         COUNT(*) AS n 
  FROM employees 
  GROUP BY department
)
SELECT department, 
       ROUND(hi*100.0/n, 2) AS pct_hi 
FROM x 
WHERE hi*100.0/n > 30;
```

output:

~~~
+-------------+--------+
| department  | pct_hi |
+-------------+--------+
| Engineering |  41.27 |
| Finance     |  47.83 |
| Marketing   |  46.88 |
| IT          |  30.77 |
| Business    |  57.69 |
+-------------+--------+
5 rows in set (0.00 sec)
~~~



### 22. Most frequent last_name per department.

```sql
WITH x AS 
(
  SELECT department, 
         last_name, 
         COUNT(*) AS n 
  FROM employees 
  GROUP BY department, last_name
)
, r AS 
(
  SELECT *, 
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY n DESC, last_name ASC) 
           AS rn 
  FROM x
)
SELECT department, 
       last_name, 
       n 
FROM r 
WHERE rn=1;
```

output:

~~~
+-------------+-----------+---+
| department  | last_name | n |
+-------------+-----------+---+
| Business    | Nelson    | 3 |
| Engineering | Walker    | 4 |
| Finance     | King      | 3 |
| HR          | Edwards   | 2 |
| IT          | Perez     | 3 |
| Marketing   | Stewart   | 3 |
+-------------+-----------+---+
6 rows in set (0.00 sec)
~~~

### 23. Salary above both country & dept averages

```sql
WITH ca AS 
(
  SELECT country, AVG(salary) AS a 
  FROM employees 
  GROUP BY country
)
, da AS 
(
  SELECT department, AVG(salary) AS a 
  FROM employees 
  GROUP BY department
)
SELECT e.emp_id, e.first_name, e.country, e.department, e.salary 
FROM employees e 
JOIN ca ON e.country = ca.country 
JOIN da ON e.department = da.department 
WHERE (e.salary > ca.a) AND 
      (e.salary > da.a) 
ORDER BY e.salary DESC;
```

### 24. For each degree, % in Engineering department.

```sql
WITH g AS 
( 
  SELECT degree, 
         SUM(CASE WHEN department='Engineering' THEN 1 ELSE 0 END) AS eng, 
         COUNT(*) AS n 
  FROM employees 
  GROUP BY degree
)
SELECT degree, 
       ROUND(eng*100.0/n,2) AS pct_eng 
FROM g 
ORDER BY pct_eng DESC;
```

output:

~~~
+--------+---------+
| degree | pct_eng |
+--------+---------+
| PHD    |   46.67 |
| MS     |   30.77 |
| BS     |   29.03 |
| MBA    |   28.89 |
| MSIS   |   25.00 |
+--------+---------+
5 rows in set (0.00 sec)
~~~


### 25. For each country, top 2 departments by average salary.

```sql
WITH a AS 
(
  SELECT country, 
         department, 
         ROUND(AVG(salary)) AS avg_sal 
  FROM employees 
  GROUP BY country, department
)
, r AS 
(
  SELECT *, 
         ROW_NUMBER() OVER (PARTITION BY country ORDER BY avg_sal DESC) 
           AS rn 
  FROM a
)
SELECT country, department, avg_sal 
FROM r 
WHERE rn <= 2 
ORDER BY country ASC, avg_sal DESC;
```

output:

~~~
+---------+-------------+---------+
| country | department  | avg_sal |
+---------+-------------+---------+
| CANADA  | Business    |  115040 |
| CANADA  | Marketing   |  100327 |
| CHINA   | Marketing   |  120940 |
| CHINA   | Finance     |  111415 |
| FRANCE  | Finance     |  154868 |
| FRANCE  | IT          |  152908 |
| GERMANY | Finance     |  152966 |
| GERMANY | Marketing   |  121921 |
| INDIA   | Business    |  138450 |
| INDIA   | Finance     |  135957 |
| ITALY   | Finance     |  127997 |
| ITALY   | Marketing   |  112087 |
| MEXICO  | Engineering |  127651 |
| MEXICO  | Marketing   |  116576 |
| USA     | Business    |  140322 |
| USA     | Marketing   |  120903 |
+---------+-------------+---------+
16 rows in set (0.00 sec)
~~~


### 26. Coefficient of variation per department.

```sql
SELECT department, 
       ROUND(STDDEV_POP(salary)/NULLIF(AVG(salary),0),3) AS cv 
FROM employees 
GROUP BY department 
ORDER BY cv DESC;
```

output:

~~~
+-------------+-------+
| department  | cv    |
+-------------+-------+
| IT          | 0.292 |
| Business    | 0.292 |
| Finance     | 0.256 |
| Engineering | 0.249 |
| HR          | 0.248 |
| Marketing   | 0.227 |
+-------------+-------+
6 rows in set (0.00 sec)
~~~

### 27. Salary z-score within department.

```sql
WITH a AS 
(
  SELECT department, 
         AVG(salary) AS a, 
         STDDEV_POP(salary) AS s 
  FROM employees 
  GROUP BY department
)
SELECT e.emp_id, 
       e.department, 
       ROUND((e.salary - a.a)/NULLIF(a.s,0),2) AS z 
FROM employees e 
JOIN a ON e.department = a.department 
ORDER BY z DESC 
LIMIT 20;
```

output:

~~~
+--------+-------------+------+
| emp_id | department  | z    |
+--------+-------------+------+
|    118 | HR          | 1.87 |
|     20 | IT          | 1.85 |
|     66 | IT          | 1.83 |
|    170 | IT          |  1.8 |
|    197 | Engineering | 1.79 |
|     45 | Engineering | 1.67 |
|    100 | Engineering |  1.6 |
|     27 | Business    | 1.54 |
|    139 | Engineering | 1.51 |
|    177 | IT          |  1.5 |
|    113 | HR          | 1.38 |
|    108 | Marketing   | 1.38 |
|    182 | Engineering | 1.37 |
|     83 | IT          | 1.35 |
|    143 | Finance     | 1.35 |
|    107 | IT          | 1.32 |
|    121 | Finance     | 1.32 |
|     70 | Engineering | 1.28 |
|    129 | Finance     | 1.28 |
|     55 | Marketing   | 1.27 |
+--------+-------------+------+
20 rows in set (0.00 sec)
~~~
