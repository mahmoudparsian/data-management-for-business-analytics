# Gentle Introduction to JOINs

We’ll:


* Create two simple tables.

* Insert a few rows.

* Provide 10 basic JOIN queries (with English + SQL + sample results).

* Provide 10 intermediate JOIN queries (with English + SQL + sample results).

* We will keep the data very small and simple so students can see exactly 
  what’s happening.

* ✅ This Lab on JOINs introduces students to 
INNER, LEFT, RIGHT, FULL (via UNION), and CROSS 
joins, plus aggregates and self-joins.





## 📌 Step 1: Create a Database



```sql
CREATE DATABASE join_db;
```

## 📌 Step 2: Create Table employees

```sql
USE join_db;

CREATE TABLE employees (

    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT

);
```

## 📌 Step 3: Create Table departments

```sql
USE join_db;

CREATE TABLE departments (

    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)

);
```


## 📌 Step 4: Insert Data into Both Tables


```sql
INSERT INTO employees (emp_id, name, department_id) 
VALUES
(1, 'Alice', 1),
(2, 'Max', 1),
(3, 'Bob', 2),
(4, 'Charlie', 2),
(5, 'Diana', 3),
(6, 'Ethan', NULL);


INSERT INTO departments (dept_id, dept_name) 
VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'AI');

```

## 📌 Step 5: Check content of Both Tables

```
mysql> select * from employees;
+--------+---------+---------------+
| emp_id | name    | department_id |
+--------+---------+---------------+
|      1 | Alice   |             1 |
|      2 | Max     |             1 |
|      3 | Bob     |             2 |
|      4 | Charlie |             2 |
|      5 | Diana   |             3 |
|      6 | Ethan   |          NULL |
+--------+---------+---------------+
6 rows in set (0.00 sec)

mysql> select * from departments;
+---------+-----------+
| dept_id | dept_name |
+---------+-----------+
|       1 | HR        |
|       2 | IT        |
|       3 | Finance   |
|       4 | Marketing |
|       5 | AI        |
+---------+-----------+
5 rows in set (0.00 sec)
```

## 🟢 Part A – 10 Basic JOIN Queries

### 0. Join two tables

```sql
SELECT e.emp_id, 
       e.name, 
       e.department_id,
       d.dept_id, 
       d.dept_name 
FROM employees e 
JOIN departments d;
```

output:

```
+--------+---------+---------------+---------+-----------+
| emp_id | name    | department_id | dept_id | dept_name |
+--------+---------+---------------+---------+-----------+
|      1 | Alice   |             1 |       5 | AI        |
|      1 | Alice   |             1 |       4 | Marketing |
|      1 | Alice   |             1 |       3 | Finance   |
|      1 | Alice   |             1 |       2 | IT        |
|      1 | Alice   |             1 |       1 | HR        |
|      2 | Max     |             1 |       5 | AI        |
|      2 | Max     |             1 |       4 | Marketing |
|      2 | Max     |             1 |       3 | Finance   |
|      2 | Max     |             1 |       2 | IT        |
|      2 | Max     |             1 |       1 | HR        |
|      3 | Bob     |             2 |       5 | AI        |
|      3 | Bob     |             2 |       4 | Marketing |
|      3 | Bob     |             2 |       3 | Finance   |
|      3 | Bob     |             2 |       2 | IT        |
|      3 | Bob     |             2 |       1 | HR        |
|      4 | Charlie |             2 |       5 | AI        |
|      4 | Charlie |             2 |       4 | Marketing |
|      4 | Charlie |             2 |       3 | Finance   |
|      4 | Charlie |             2 |       2 | IT        |
|      4 | Charlie |             2 |       1 | HR        |
|      5 | Diana   |             3 |       5 | AI        |
|      5 | Diana   |             3 |       4 | Marketing |
|      5 | Diana   |             3 |       3 | Finance   |
|      5 | Diana   |             3 |       2 | IT        |
|      5 | Diana   |             3 |       1 | HR        |
|      6 | Ethan   |          NULL |       5 | AI        |
|      6 | Ethan   |          NULL |       4 | Marketing |
|      6 | Ethan   |          NULL |       3 | Finance   |
|      6 | Ethan   |          NULL |       2 | IT        |
|      6 | Ethan   |          NULL |       1 | HR        |
+--------+---------+---------------+---------+-----------+
30 rows in set (0.00 sec)
```

### 1. Show employees with their departments (INNER JOIN)

```sql
SELECT e.name, 
       d.dept_name 
FROM employees e 
INNER JOIN departments d ON e.department_id = d.dept_id;
```

output:

```
+---------+-----------+
| name    | dept_name |
+---------+-----------+
| Alice   | HR        |
| Max     | HR        |
| Bob     | IT        |
| Charlie | IT        |
| Diana   | Finance   |
+---------+-----------+
5 rows in set (0.00 sec)
```

### 2. Show all employees and departments (LEFT JOIN)

```sql
SELECT e.name, 
       d.dept_name 
FROM employees e 
LEFT JOIN departments d ON e.department_id = d.dept_id;
```

output:

```
+---------+-----------+
| name    | dept_name |
+---------+-----------+
| Alice   | HR        |
| Max     | HR        |
| Bob     | IT        |
| Charlie | IT        |
| Diana   | Finance   |
| Ethan   | NULL      |
+---------+-----------+
6 rows in set (0.00 sec)
```
### 3. Show all departments and employees (RIGHT JOIN)

```sql
SELECT e.name, 
       d.dept_name 
FROM employees e 
RIGHT JOIN departments d ON e.department_id = d.dept_id;
```
output:

```
+---------+-----------+
| name    | dept_name |
+---------+-----------+
| Max     | HR        |
| Alice   | HR        |
| Charlie | IT        |
| Bob     | IT        |
| Diana   | Finance   |
| NULL    | Marketing |
| NULL    | AI        |
+---------+-----------+
7 rows in set (0.00 sec)
```

### 4. Show all employees and all departments (FULL OUTER JOIN simulation)

```sql
SELECT e.name, 
       d.dept_name 
FROM employees e 
LEFT JOIN departments d ON e.department_id = d.dept_id 
UNION 
SELECT e.name, 
       d.dept_name 
FROM employees e 
RIGHT JOIN departments d ON e.department_id = d.dept_id;
```

output:

```
+---------+-----------+
| name    | dept_name |
+---------+-----------+
| Alice   | HR        |
| Max     | HR        |
| Bob     | IT        |
| Charlie | IT        |
| Diana   | Finance   |
| Ethan   | NULL      |
| NULL    | Marketing |
| NULL    | AI        |
+---------+-----------+
8 rows in set (0.00 sec)
```

### 5. Find employees in IT department

```sql
SELECT e.name 
FROM employees e 
JOIN departments d ON e.department_id = d.dept_id 
WHERE d.dept_name = 'IT';
```

output:

```
+---------+
| name    |
+---------+
| Bob     |
| Charlie |
+---------+
2 rows in set (0.00 sec)
```

### 6. Find employees in HR department

```sql
SELECT e.name 
FROM employees e 
JOIN departments d ON e.department_id = d.dept_id 
WHERE d.dept_name = 'HR';
```

output:

```
+-------+
| name  |
+-------+
| Alice |
| Max   |
+-------+
2 rows in set (0.00 sec)
```

### 7. Show employee names with department IDs (without dept_name)

```sql
SELECT e.name, 
       e.department_id 
FROM employees e;
```

output:

```
+---------+---------------+
| name    | department_id |
+---------+---------------+
| Alice   |             1 |
| Max     |             1 |
| Bob     |             2 |
| Charlie |             2 |
| Diana   |             3 |
| Ethan   |          NULL |
+---------+---------------+
6 rows in set (0.00 sec)
```

### 8. Show employees who don’t belong to a department

```sql
SELECT e.name 
FROM employees e 
LEFT JOIN departments d ON e.department_id = d.dept_id 
WHERE d.dept_name IS NULL;
```

output:

```
+-------+
| name  |
+-------+
| Ethan |
+-------+
1 row in set (0.00 sec)
```

### 9. Show departments with at least one employee

```sql
SELECT DISTINCT d.dept_name 
FROM departments d 
JOIN employees e ON d.dept_id = e.department_id;
```

output:

```
+-----------+
| dept_name |
+-----------+
| HR        |
| IT        |
| Finance   |
+-----------+
3 rows in set (0.00 sec)
```


### 10. Show departments with no employees

```sql
SELECT d.dept_name 
FROM departments d 
LEFT JOIN employees e ON d.dept_id = e.department_id 
WHERE e.emp_id IS NULL;
```

output:

```
+-----------+
| dept_name |
+-----------+
| Marketing |
| AI        |
+-----------+
2 rows in set (0.01 sec)
```



## 🟡 Part B – 10 Intermediate JOIN Queries



### 11. Count employees in each department

```sql
SELECT d.dept_name, 
       COUNT(e.emp_id) AS num_employees 
FROM departments d 
LEFT JOIN employees e ON d.dept_id = e.department_id 
GROUP BY d.dept_name;
```

output:

```
+-----------+---------------+
| dept_name | num_employees |
+-----------+---------------+
| HR        |             2 |
| IT        |             2 |
| Finance   |             1 |
| Marketing |             0 |
| AI        |             0 |
+-----------+---------------+
5 rows in set (0.00 sec)
```

### 12. Find department with the most employees

```sql
SELECT d.dept_name, 
       COUNT(e.emp_id) AS num_employees 
FROM departments d 
LEFT JOIN employees e ON d.dept_id = e.department_id 
GROUP BY d.dept_name 
ORDER BY num_employees DESC 
LIMIT 1;
```


output:

```
+-----------+---------------+
| dept_name | num_employees |
+-----------+---------------+
| HR        |             2 |
+-----------+---------------+
1 row in set (0.00 sec)
```

### 13. Find employees working in Finance

```sql
SELECT e.name 
FROM employees e 
JOIN departments d ON e.department_id = d.dept_id 
WHERE d.dept_name = 'Finance';
```

output:

```
+-------+
| name  |
+-------+
| Diana |
+-------+
1 row in set (0.01 sec)
```

### 14. List all employees and replace NULL departments with ‘Unassigned’

```sql
SELECT e.name, 
       COALESCE(d.dept_name, 'Unassigned') AS department 
FROM employees e 
LEFT JOIN departments d ON e.department_id = d.dept_id;
```

output:

```
+---------+------------+
| name    | department |
+---------+------------+
| Alice   | HR         |
| Max     | HR         |
| Bob     | IT         |
| Charlie | IT         |
| Diana   | Finance    |
| Ethan   | Unassigned |
+---------+------------+
6 rows in set (0.00 sec)
```

### 15. Show employees with department IDs greater than 2

```sql
SELECT e.name, 
       d.dept_name 
FROM employees e 
JOIN departments d ON e.department_id = d.dept_id 
WHERE d.dept_id > 2;
```

output:

```
+-------+-----------+
| name  | dept_name |
+-------+-----------+
| Diana | Finance   |
+-------+-----------+
1 row in set (0.00 sec)
```

### 16. Show all employee-department pairs (Cartesian product)

```sql
SELECT e.name, 
       d.dept_name 
FROM employees e 
CROSS JOIN departments d;
```

output:

```
+---------+-----------+
| name    | dept_name |
+---------+-----------+
| Alice   | AI        |
| Alice   | Marketing |
| Alice   | Finance   |
| Alice   | IT        |
| Alice   | HR        |
| Max     | AI        |
| Max     | Marketing |
| Max     | Finance   |
| Max     | IT        |
| Max     | HR        |
| Bob     | AI        |
| Bob     | Marketing |
| Bob     | Finance   |
| Bob     | IT        |
| Bob     | HR        |
| Charlie | AI        |
| Charlie | Marketing |
| Charlie | Finance   |
| Charlie | IT        |
| Charlie | HR        |
| Diana   | AI        |
| Diana   | Marketing |
| Diana   | Finance   |
| Diana   | IT        |
| Diana   | HR        |
| Ethan   | AI        |
| Ethan   | Marketing |
| Ethan   | Finance   |
| Ethan   | IT        |
| Ethan   | HR        |
+---------+-----------+
30 rows in set (0.00 sec)
```

6 employees × 5 departments = 30 rows


### 17. Find if any employees belong to non-existing departments

```sql
SELECT e.name 
FROM employees e 
LEFT JOIN departments d ON e.department_id = d.dept_id 
WHERE (e.department_id IS NOT NULL) AND 
      (d.dept_id IS NULL);
```

output:

```
Empty set (0.00 sec)
```

(none in this dataset)

### 18. Find employees with same department (self-join)

```sql
SELECT a.name AS emp1, 
       b.name AS emp2, 
       d.dept_name 
FROM employees a 
JOIN employees b ON a.department_id = b.department_id 
JOIN departments d ON a.department_id = d.dept_id 
WHERE a.emp_id < b.emp_id;
```

output:

```
+-------+---------+-----------+
| emp1  | emp2    | dept_name |
+-------+---------+-----------+
| Alice | Max     | HR        |
| Bob   | Charlie | IT        |
+-------+---------+-----------+
2 rows in set (0.00 sec)
```


### 19. Show number of employees in IT and HR only

```sql
SELECT d.dept_name, 
       COUNT(e.emp_id) AS count
FROM departments d 
LEFT JOIN employees e ON d.dept_id = e.department_id 
WHERE d.dept_name IN ('IT','HR') 
GROUP BY d.dept_name;
```


output:

```
+-----------+-------+
| dept_name | count |
+-----------+-------+
| HR        |     2 |
| IT        |     2 |
+-----------+-------+
2 rows in set (0.00 sec)
```

### 20 Show employees with departments, sorted by department then name

```sql
SELECT d.dept_name, 
       e.name 
FROM employees e 
LEFT JOIN departments d ON e.department_id = d.dept_id 
ORDER BY d.dept_name, e.name;
```

output:

```
+-----------+---------+
| dept_name | name    |
+-----------+---------+
| NULL      | Ethan   |
| Finance   | Diana   |
| HR        | Alice   |
| HR        | Max     |
| IT        | Bob     |
| IT        | Charlie |
+-----------+---------+
6 rows in set (0.00 sec)
```






