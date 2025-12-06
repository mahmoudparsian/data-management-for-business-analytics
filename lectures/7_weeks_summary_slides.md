
# SQL / MySQL <br> 7-Weeks Summary Slides

----

## Slide 1 — Title

# SQL / MySQL: Concepts, Queries, and Data Modeling

* Instructor: Mahmoud Parsian 
* Course: Introduction to Relational Databases  
* Duration: 2-Hour Review Session  


---

## Slide 2 — Agenda

1. What is a relational database  
2. SQL fundamentals  
3. Data modeling  
4. Joins and multi-table queries  
5. Aggregation semantics  
6. Subqueries and CTEs  
7. Window functions  
8. Keys, integrity, normalization  
9. Constraints and indexes  
10. Transactions and ACID  
11. Query optimization  
12. Final review exercises  


---

## Slide 3 — What is a Relational Database

- Organizes data into **tables**
- Relationships enforced using **keys** (PK, FK)
- Provides **consistency, correctness, durability**
- Query language: **SQL**

> Goal: separate *logical design* from *physical storage*


---

## Slide 4 — SQL Categories

- **DDL**: CREATE, ALTER, DROP  
- **DML**: INSERT, UPDATE, DELETE  
- **DQL**: SELECT  
- **DCL**: GRANT, REVOKE  

> SELECT is declarative — describe *what*, not *how*


---

## Slide 5 — Basic SELECT Query

#### Find 5 oldest employees from USA

```sql
SELECT name, age
FROM employees
WHERE country = 'USA'
ORDER BY age DESC
LIMIT 5;
```

#### Find teen-age employees from CANADA

```sql
SELECT name, age
FROM employees
WHERE country = 'CANADA' AND
      age < 20
ORDER BY age DESC;
```

---

## Slide 6 — Filtering Semantics

#### Find employees from USA who make more than 100K
```sql
SELECT *
FROM employees
WHERE salary > 100000 
  AND country = 'USA';
```

- Boolean logic  
- NULLs require IS NULL / IS NOT NULL  


---

## Slide 7 — Projection Semantics

```sql
SELECT DISTINCT country
FROM employees;
```

- DISTINCT removes duplicates (expensive)


---

## Slide 8 — Data Modeling Key Idea

- Tables represent **entities**
- Attributes represent **properties**
- Relationships modeled using **keys**


---

## Slide 9 — Primary and Foreign Keys

* PK (Primary Key) uniquely identifies each record in a table (like a `student_id`), 
* FK (Foreign Key) links to a PK in another table

```sql
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(80),
  customer_email VARCHAR(64)
);

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);
```

To make sure that `orders.customer_id` is never going to be NULL:

```sql
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(80),
  customer_email VARCHAR(64)
);

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT NOT NULL,   -- <-- IT CAN NOT BE NULL
  FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);
```


---

## Slide 10 — Joins Overview

- INNER JOIN  
- LEFT JOIN  
- RIGHT JOIN  
- FULL JOIN (not in MySQL)


---

## Slide 11 — Inner Join Example

```sql
-- method 1
SELECT c.name, o.order_date, o.amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

-- OR --

-- method 2
SELECT c.name, o.order_date, o.amount
FROM customers c
INNER JOIN orders o USING(customer_id)

-- OR --

-- method 3
SELECT c.name, o.order_date, o.amount
FROM customers c,
     orders o 
WHERE c.customer_id = o.customer_id;
```


---

## Slide 12 — Left Join Example

```sql
SELECT c.name, o.amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;
```


---

## Slide 13 — Group By Basics

```sql
employees(emp_id, emp_name, dept_id, age, salary)
departments(dept_id, dept_name)
```

#### Find average salary per department ID:

```sql
SELECT dept_id, 
       AVG(salary) AS avg_salary
FROM employees
GROUP BY dept_id;
```

```sql
-- NOT VALID
SELECT dept_id, 
       age,
       AVG(salary) AS avg_salary
FROM employees
GROUP BY dept_id;
```

```sql
-- NOT VALID
SELECT dept_id, 
       GROUP_CONCAT(age) AS list_of_ages,
       AVG(salary) AS avg_salary
FROM employees
GROUP BY dept_id;
```



#### Find average salary per department name:

```sql
SELECT d.dept_name, 
       AVG(salary) AS avg_salary
FROM employees e
INNER JOIN departments USING(dept_id)
GROUP BY dept_name;
```


---

## Slide 14 — HAVING Clause

#### Filter after creating aggregated result

```sql
SELECT dept_id, 
       AVG(salary) AS avg_salary
FROM employees
GROUP BY dept_id
HAVING avg_salary > 120000;
```


---

## Slide 15 — Aggregation Semantics

Avoid invalid queries mixing aggregated & non-aggregated columns


---

## Slide 16 — Subqueries

#### Find employees making more than average salary

```sql
SELECT emp_id, emp_name
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);
```


---

## Slide 17 — CTE (WITH Clause)

```sql
WITH dept_stats AS (
  SELECT dept_id, 
         AVG(salary) AS avg_salary
  FROM employees
  GROUP BY dept_id
)
SELECT *
FROM dept_stats
WHERE avg_salary > 120000;
```


---

## Slide 18 — Window Functions

```sql
SELECT name, department, salary,
  ROW_NUMBER() OVER(
    PARTITION BY department
    ORDER BY salary DESC
  ) AS rank
FROM employees;
```


---

## Slide 19 — Top N Per Group

```sql
WITH ranked AS (
  SELECT *, 
  ROW_NUMBER() OVER(
    PARTITION BY department ORDER BY salary DESC
  ) AS rn
  FROM employees
)
SELECT *
FROM ranked
WHERE rn <= 3;
```


---

## Slide 20 — Normalization

Goals:
- Reduce redundancy  
- Avoid anomalies  
- Improve consistency  


---

## Slide 21 — Indexes

```sql
CREATE INDEX idx_name ON employees(name);
```

Tradeoffs:
- Faster reads  
- Slower writes  
- Uses storage  


---

## Slide 22 — ACID Transactions

```sql
START TRANSACTION;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;
```


---

## Slide 23 — Transaction Isolation

MySQL default: **REPEATABLE READ**


---

## Slide 24 — Query Optimization Tips

- Predicates first  
- Avoid SELECT *  
- Prefer selective joins  
- Index selective columns  
- Avoid correlated subqueries  


---

## Slide 25 — EXPLAIN

```sql
EXPLAIN SELECT * FROM employees WHERE age > 30;
```


---

## Slide 26 — Common Mistakes

- GROUP BY misuse  
- Misunderstanding NULL  
- Cartesian joins  
- Too many indexes  


---

## Slide 27 — Handling NULLs

```sql
WHERE country IS NULL
```

- Aggregations ignore NULL by default


---

## Slide 28 — Categorical Analysis Example

```sql
SELECT gender,
       COUNT(*) AS cnt,
       AVG(salary) AS avg_salary
FROM employees
GROUP BY gender;
```


---

## Slide 29 — Advanced Query Example

```sql
SELECT country, dept,
       AVG(salary) AS avg_salary,
       COUNT(*) AS num_emp
FROM employees
WHERE salary > 50000
GROUP BY country, dept
HAVING num_emp > 20
ORDER BY avg_salary DESC
LIMIT 10;
```


---

## Slide 30 — Summary

SQL is about expressing:
- What data you want  
- At what granularity  
- Under what conditions  


---

## Slide 31 — Practice Questions

1. Customers who never ordered  
2. Top 3 departments by avg salary  
3. Employees above avg salary  
4. Orders per country per month  
5. Normalize a retail schema  


---

## Slide 32 — Final Thought

> SQL is not just about correctness — it's about clarity, meaning, and scalability.


# Practice Problems with Detailed Solutions (SQL / MySQL)

## 1. Customers Who Never Ordered

### Schema

```sql
customers(customer_id, name, country)
orders(order_id, customer_id, order_date, amount)
```

### Query

```sql
SELECT c.customer_id, c.name, c.country
FROM customers c
LEFT JOIN orders o 
    ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;
```

### Explanation

- LEFT JOIN keeps all customers  
- Orders that don’t match become NULL  
- Filter on `o.customer_id IS NULL`  

### Output Example

| customer_id | name  | country |
|-------------|-------|---------|
| 4           | Eve   | USA     |
| 7           | Omar  | UK      |


---

## 2. Top 3 Departments by Average Salary

### Schema

```sql
employees(emp_id, name, department, salary)
```

### Query

```sql
WITH dept_stats AS (
    SELECT department,
           AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
)
SELECT department, avg_salary
FROM dept_stats
ORDER BY avg_salary DESC
LIMIT 3;
```

### Output Example

| department  | avg_salary |
|-------------|------------|
| AI          | 185000     |
| Engineering | 160000     |
| IT          | 140000     |


---

## 3. Employees Above Company Average Salary

### Schema

```sql
employees(emp_id, name, department, salary)
```

### Query

```sql
SELECT name, department, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);
```

### Output Example

| name  | department | salary |
|-------|------------|--------|
| Alice | AI         | 170000 |
| Carol | Business   | 150000 |
| David | IT         | 165000 |


---

## 4. Orders Per Country Per Month

### Schema

```sql
customers(customer_id, country)
orders(order_id, customer_id, order_date, amount)
```

### Query

#### Use of `DATE_FORMAT`:

```
mysql> select DATE_FORMAT('2025-12-05', '%Y-%m');
+------------------------------------+
| DATE_FORMAT('2025-12-05', '%Y-%m') |
+------------------------------------+
| 2025-12                            |
+------------------------------------+
```

<mark>solution-1:</mark>

```sql
SELECT c.country,
       DATE_FORMAT(o.order_date, '%Y-%m') AS year_month,
       COUNT(*) AS num_orders,
       SUM(o.amount) AS total_amount
FROM orders o
JOIN customers c 
    ON o.customer_id = c.customer_id
GROUP BY c.country, year_month
ORDER BY c.country, year_month;
```

### Output Example

| country | year_month | num_orders | total_amount |
|---------|------------|------------|--------------|
| USA     | 2024-01    | 120        | 98000        |
| USA     | 2024-02    | 90         | 76000        |
| UK      | 2024-02    | 45         | 39000        |


<mark>solution-2:</mark>

```
mysql> select YEAR('2025-12-05');
+--------------------+
| YEAR('2025-12-05') |
+--------------------+
|               2025 |
+--------------------+

mysql> select MONTH('2025-12-05');
+---------------------+
| MONTH('2025-12-05') |
+---------------------+
|                  12 |
+---------------------+
```

```sql
SELECT c.country,
       YEAR(o.order_date) AS year,
       MONTH(o.order_date) AS month,
       COUNT(*) AS num_orders,
       SUM(o.amount) AS total_amount
FROM orders o
JOIN customers c 
    ON o.customer_id = c.customer_id
GROUP BY c.country, year, month
ORDER BY c.country, year, month;
```

---

## 5. Normalize a Retail Schema

### Given Schema

```sql
sales(order_id, order_date, customer_name, customer_email,
      product_name, product_category, price, quantity)
```

### Issues

- Redundant customer and product info  
- Update and insertion anomalies  

### Normalized Model (3NF)

#### Customers

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(60),
    email VARCHAR(60) UNIQUE
);
```

#### Products

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(60),
    category VARCHAR(60),
    price DECIMAL(10,2)
);
```

#### Orders

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
```

#### Order Items

```sql
CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
```

### Benefits

- Removes redundancy  
- Better data integrity  
- More flexible modeling  


---

## Teaching Notes

| Problem | Key Concepts |
|--------|--------------|
| Customers w/o orders | Join semantics & NULL logic |
| Top 3 departments | Aggregation + ranking |
| Above avg salary | Subqueries |
| Orders by month | Temporal analytics |
| Normalize schema | Data modeling theory |


---

## Bonus Problem (Optional)

### Highest Spending Customer per Country

```sql
WITH totals AS (
  SELECT c.country, o.customer_id, SUM(o.amount) AS total_spend
  FROM orders o JOIN customers c ON o.customer_id = c.customer_id
  GROUP BY c.country, o.customer_id
),
ranked AS (
  SELECT *, ROW_NUMBER() OVER(
     PARTITION BY country ORDER BY total_spend DESC
  ) rn FROM totals
)
SELECT country, customer_id, total_spend
FROM ranked
WHERE rn = 1;
```


---

## Summary

These problems demonstrate:

- Joins  
- Aggregations  
- Subqueries  
- Window functions  
- Normalization  

in realistic analytic and modeling contexts.

