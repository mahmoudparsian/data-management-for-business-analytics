# The GROUP BY clause in SQL

		The GROUP BY clause  in MySQL is used to organize 
		rows  that have  the same  values in one  or more 
		specified   columns  into  summary  rows.   It is 
		primarily used  with  aggregate  functions  (like 
		COUNT(), SUM(), AVG(), MIN(), MAX())  to  perform 
		calculations on each of these groups, rather than 
		on the entire dataset. 

		In simple terms, think of it like this:

		Imagine you have a  list of  customer orders, and 
		each order has a customer_id, product, and amount.  
		If you want to know the total amount spent by each 
		customer, you would use 
		
		      GROUP BY customer_id
		      
		This would: Group: all the orders belonging to the 
		same customer_id together. Then, for each of these 
		groups, you would use an aggregate  function  like 
		SUM(amount) to  calculate the  total  amount spent 
		within that specific customer's group.

Example:

```sql
	SELECT customer_id,
           SUM(amount) AS total_spent
	FROM orders
	GROUP BY customer_id;
```

-------

# A Complete Example

## Use `dom_db` Database & Create an `employees` Table

```sql
USE dom_db;

CREATE TABLE employees (
   emp_id INT,
   emp_name VARCHAR(20),
   country  VARCHAR(10), 
   department VARCHAR(20),
   bonus INT
);

mysql> CREATE TABLE employees (
    ->    emp_id INT,
    ->    emp_name VARCHAR(20),
    ->    country  VARCHAR(10),
    ->    department VARCHAR(20),
    ->    bonus INT
    -> );
Query OK, 0 rows affected (0.007 sec)

```

## Populate `employees` Table

```sql
INSERT INTO employees 
(emp_id, emp_name, country, department, bonus)
VALUES
(1, 'Alice', 'USA', 'Engineering', 20),
(2, 'Bob', 'USA', 'Engineering', 30),
(3, 'Carol', 'USA', 'Marketing', 40),
(4, 'Ralph', 'USA', 'Marketing', 70),
(5, 'Al', 'CANADA', 'Engineering', 50),
(6, 'Bo', 'CANADA', 'Business', 70),
(7, 'Cameron', 'CANADA', 'Marketing', 90),
(8, 'Rosie', 'GERMANY', 'Business', 10),
(9, 'Alex', 'GERMANY', 'Engineering', 30),
(10, 'Betty', 'GERMANY', 'Engineering', 60),
(11, 'Candice', 'GERMANY', 'Marketing', 50),
(12, 'Mo', 'GERMANY', 'Business', 70);


mysql> INSERT INTO employees
    -> (emp_id, emp_name, country, department, bonus)
    -> VALUES
    -> (1, 'Alice', 'USA', 'Engineering', 20),
    -> (2, 'Bob', 'USA', 'Engineering', 30),
    -> (3, 'Carol', 'USA', 'Marketing', 40),
    -> (4, 'Ralph', 'USA', 'Marketing', 70),
    -> (5, 'Al', 'CANADA', 'Engineering', 50),
    -> (6, 'Bo', 'CANADA', 'Business', 70),
    -> (7, 'Cameron', 'CANADA', 'Marketing', 90),
    -> (8, 'Rosie', 'GERMANY', 'Business', 10),
    -> (9, 'Alex', 'GERMANY', 'Engineering', 30),
    -> (10, 'Betty', 'GERMANY', 'Engineering', 60),
    -> (11, 'Candice', 'GERMANY', 'Marketing', 50),
    -> (12, 'Mo', 'GERMANY', 'Business', 70);
Query OK, 12 rows affected (0.003 sec)
Records: 12  Duplicates: 0  Warnings: 0
```

### Query-1: Get all employees

```sql
SELECT * 
from employees;

+--------+----------+---------+-------------+-------+
| emp_id | emp_name | country | department  | bonus |
+--------+----------+---------+-------------+-------+
|      1 | Alice    | USA     | Engineering |    20 |
|      2 | Bob      | USA     | Engineering |    30 |
|      3 | Carol    | USA     | Marketing   |    40 |
|      4 | Ralph    | USA     | Marketing   |    70 |
|      5 | Al       | CANADA  | Engineering |    50 |
|      6 | Bo       | CANADA  | Business    |    70 |
|      7 | Cameron  | CANADA  | Marketing   |    90 |
|      8 | Rosie    | GERMANY | Business    |    10 |
|      9 | Alex     | GERMANY | Engineering |    30 |
|     10 | Betty    | GERMANY | Engineering |    60 |
|     11 | Candice  | GERMANY | Marketing   |    50 |
|     12 | Mo       | GERMANY | Business    |    70 |
+--------+----------+---------+-------------+-------+
12 rows in set (0.001 sec)
```

### Query-2: Find number of employees per country

```sql
SELECT country, 
       count(*) as num_of_employees 
FROM employees 
GROUP BY country;

+---------+------------------+
| country | num_of_employees |
+---------+------------------+
| USA     |                4 |
| CANADA  |                3 |
| GERMANY |                5 |
+---------+------------------+
3 rows in set (0.001 sec)
```

### Query-3: Find total of bonuses  per country

```sql
SELECT country, 
       SUM(bonus) as sum_of_bonuses 
FROM employees 
GROUP BY country;

+---------+----------------+
| country | sum_of_bonuses |
+---------+----------------+
| USA     |            160 |
| CANADA  |            210 |
| GERMANY |            220 |
+---------+----------------+
3 rows in set (0.001 sec)
```

### Query-4: Find average of bonuses  per country

```sql
SELECT country, 
       AVG(bonus) as avg_of_bonuses 
FROM employees 
GROUP BY country;

+---------+----------------+
| country | avg_of_bonuses |
+---------+----------------+
| USA     |        40.0000 |
| CANADA  |        70.0000 |
| GERMANY |        44.0000 |
+---------+----------------+
3 rows in set (0.001 sec)
```

### Query-5: Find minimum and maximum of bonuses  per country

```sql
SELECT country, 
       MIN(bonus) as min_of_bonuses, 
       MAX(bonus) AS max_of_bonuses
FROM employees 
GROUP BY country;

+---------+----------------+----------------+
| country | min_of_bonuses | max_of_bonuses |
+---------+----------------+----------------+
| USA     |             20 |             70 |
| CANADA  |             50 |             90 |
| GERMANY |             10 |             70 |
+---------+----------------+----------------+
3 rows in set (0.001 sec)
```

### Query-6: Find average of bonuses and list of bonuses  per country

> The `GROUP_CONCAT` function in MySQL is an aggregate function that concatenates strings from multiple rows within a group into a single string. It is a MySQL-specific extension and not part of the standard SQL.

```sql
SELECT country, 
       AVG(bonus) as avg_of_bonuses, 
       GROUP_CONCAT(bonus) AS list_of_bonuses 
FROM employees 
GROUP BY country;

+---------+----------------+----------------+
| country | avg_of_bonuses | list_of_bonuses|
+---------+----------------+----------------+
| CANADA  |        70.0000 | 50,70,90       |
| GERMANY |        44.0000 | 10,30,60,50,70 |
| USA     |        40.0000 | 20,30,40,70    |
+---------+----------------+----------------+
3 rows in set (0.001 sec)
```

### Query-7: Find average of bonuses, employees count, and list of bonuses  per country

```sql
SELECT country, 
       AVG(bonus) as avg_of_bonuses, 
       COUNT(*) as emp_count, 
       GROUP_CONCAT(bonus) AS list_of_bonuses 
FROM employees 
GROUP BY country;
+---------+----------------+-----------+----------------+
| country | avg_of_bonuses | emp_count | list_of_bonuses|
+---------+----------------+-----------+----------------+
| CANADA  |        70.0000 |         3 | 50,70,90       |
| GERMANY |        44.0000 |         5 | 10,30,60,50,70 |
| USA     |        40.0000 |         4 | 20,30,40,70    |
+---------+----------------+-----------+----------------+
3 rows in set (0.001 sec)
```

### Query-8: Find total of bonuses per department

```sql
SELECT department, 
       SUM(bonus) as sum_of_bonuses 
FROM employees 
GROUP BY department;

+-------------+----------------+
| department  | sum_of_bonuses |
+-------------+----------------+
| Engineering |            190 |
| Marketing   |            250 |
| Business    |            150 |
+-------------+----------------+
3 rows in set (0.001 sec)
```

### Query-9: Find average of bonuses and list of bonuses  per department

```sql
SELECT department, 
       AVG(bonus) as avg_of_bonuses, 
       GROUP_CONCAT(bonus) AS list_of_bonuses 
FROM employees 
GROUP BY department;

+-------------+----------------+----------------+
| department  | avg_of_bonuses | bonuses        |
+-------------+----------------+----------------+
| Business    |        50.0000 | 70,10,70       |
| Engineering |        38.0000 | 20,30,50,30,60 |
| Marketing   |        62.5000 | 40,70,90,50    |
+-------------+----------------+----------------+
3 rows in set (0.001 sec)
```

### Query-10: Find average of bonuses and list of bonuses  per (country and department)

> GROUP BY is done by 2 colums: country and department

```sql
SELECT country, 
       department, 
       AVG(bonus) as avg_of_bonuses, 
       GROUP_CONCAT(bonus) AS bonuses 
FROM employees 
GROUP BY country, department;

+---------+-------------+----------------+-----------------+
| country | department  | avg_of_bonuses | list_of_bonuses |
+---------+-------------+----------------+-----------------+
| CANADA  | Business    |        70.0000 | 70              |
| CANADA  | Engineering |        50.0000 | 50              |
| CANADA  | Marketing   |        90.0000 | 90              |
| GERMANY | Business    |        40.0000 | 10,70           |
| GERMANY | Engineering |        45.0000 | 30,60           |
| GERMANY | Marketing   |        50.0000 | 50              |
| USA     | Engineering |        25.0000 | 20,30           |
| USA     | Marketing   |        55.0000 | 40,70           |
+---------+-------------+----------------+-----------------+
8 rows in set (0.001 sec)
```

### Query-11: Find number of employees per (country and department)

> GROUP BY is done by 2 colums: country and department

```sql
SELECT country, 
       department, 
       COUNT(*) AS num_of_employees
FROM employees 
GROUP BY country, department;

+---------+-------------+------------------+
| country | department  | num_of_employees |
+---------+-------------+------------------+
| USA     | Engineering |                2 |
| USA     | Marketing   |                2 |
| CANADA  | Engineering |                1 |
| CANADA  | Business    |                1 |
| CANADA  | Marketing   |                1 |
| GERMANY | Business    |                2 |
| GERMANY | Engineering |                2 |
| GERMANY | Marketing   |                1 |
+---------+-------------+------------------+
8 rows in set (0.001 sec)
```

## References & Tutorials

[1. SQL GROUP BY -- www.sqltutorial.org](https://www.sqltutorial.org/sql-group-by)

[2. SQL GROUP BY](https://www.programiz.com/sql/group-by)

[3. MySQL GROUP BY Statement](https://www.w3schools.com/mysql/mysql_groupby.asp)

[4. SQL - Group By Clause by Examples](https://www.tutorialspoint.com/sql/sql-group-by.htm) 