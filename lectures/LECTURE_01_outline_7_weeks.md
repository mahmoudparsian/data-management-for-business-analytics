# MySQL / Relational Database 101 (40 Slides)

* This is a 7-week outline with 40 slides. 
* Each slide has simple explanations and beginner-friendly MySQL examples.

---

🔑 Highlights inside

	•	Week 1 → What is a Database? What is SQL? Installing MySQL.
	•	Week 2 → Tables, Rows, Columns, and simple SELECT queries.
	•	Week 3 → Filtering, WHERE, ORDER BY, LIMIT.
	•	Week 4 → Aggregation (COUNT, SUM, AVG, MIN, MAX).
	•	Week 5 → Joins (INNER, LEFT), Keys (PK/FK).
	•	Week 6 → Subqueries, WITH clause, simple constraints.
	•	Week 7 → Wrap-up: transactions, indexes, best practices.

## Week 1 – Introduction

### Slide 1: What is a Database?
- A collection of organized data.

### Slide 2: Why Relational Databases?
- Store data in tables, rows, columns.

### Slide 3: What is SQL?
- Structured Query Language to interact with databases.

### Slide 4: MySQL Overview
- Popular open-source RDBMS.

### Slide 5: Installing MySQL
```bash
brew install mysql   # Mac
```

### Slide 6: Connecting to MySQL
```bash
mysql -u root -p
```

---

## Week 2 – Tables & SELECT

### Slide 7: Tables, Rows, Columns
- Table = structure: rows x columns
- Row = record, 
- Column = attribute.

### Slide 8: Creating a Table
```sql
CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  name VARCHAR(50),
  age INT
);
```

### Slide 9: Inserting Data: 3 new rows/records
```sql
INSERT INTO employees VALUES 
(1,'Alice',25),
(2,'Bob',30),
(8,'Max',40);
```

### Slide 10: Basic SELECT
```sql
SELECT * 
FROM employees;
```

output:

| `emp_id` | `name`  | `age` |
|----------| --------|-------|
|`1`       | `Alice` |`25`   |
|`2`       | `Bob`   |`30`   |
|`8`       | `Max`   |`40`   |

### Slide 11: SELECT specific columns

```sql
SELECT name, age 
FROM employees;
```

output:


| `name`  | `age`|
| --------|------|
| `Alice` |`25`   |
| `Bob`   |`30`   |
| `Max`   |`40`   |

### Slide 12: Practice

- Create a table `students` with 3 rows.

---

## Week 3 – Filtering

### Slide 13: WHERE Clause
```sql
SELECT * 
FROM employees 
WHERE age > 25;
```

### Slide 14: Comparison Operators

- `=`, `<`, `>`, `<=`, `>=`

### Slide 15: Logical Operators
- `AND`, `OR`, `NOT`

### Slide 16: ORDER BY

```sql
SELECT * FROM 
employees 
ORDER BY age DESC;
```

### Slide 17: LIMIT

```sql
SELECT * 
FROM employees 
LIMIT 5;
```

### Slide 18: Practice
- Find employees older than 30, order by name.

---

## Week 4 – Aggregation

### Slide 19: COUNT, SUM
```sql
SELECT COUNT(*), 
       SUM(age) 
FROM employees;
```

### Slide 20: AVG, MIN, MAX
```sql
SELECT AVG(age), 
       MIN(age), 
       MAX(age) 
FROM employees;
```

### Slide 21: GROUP BY
```sql
SELECT age, COUNT(*) 
FROM employees 
GROUP BY age;
```

### Slide 22: HAVING
```sql
SELECT age, COUNT(*) 
FROM employees 
GROUP BY age 
HAVING COUNT(*) > 1;
```

### Slide 23: Aggregation Example
- Count employees per department.

### Slide 24: Practice
- Find average age by department.

---

## Week 5 – Joins & Keys

### Slide 25: Primary Key

- Unique identifier.

### Slide 26: Foreign Key

- References another table.

### Slide 27: INNER JOIN

```sql
SELECT e.name,
       d.dept_name 
FROM employees e 
JOIN departments d ON e.dept_id = d.dept_id;
```

### Slide 28: LEFT JOIN

```sql
SELECT e.name,
       d.dept_name 
FROM employees e 
LEFT JOIN departments d ON e.dept_id = d.dept_id;
```

### Slide 29: RIGHT JOIN

```sql
SELECT e.name,
       d.dept_name
FROM employees e 
RIGHT JOIN departments d ON e.dept_id = d.dept_id;
```

### Slide 30: Practice
- List all employees with department names.

---

## Week 6 – Subqueries & WITH

### Slide 31: Subquery in WHERE

```sql
SELECT * 
FROM employees 
WHERE age > (SELECT AVG(age) FROM employees);
```

### Slide 32: Subquery in FROM

```sql
SELECT dept_id, 
       avg_age 
FROM (
       SELECT dept_id, 
       AVG(age) AS avg_age 
       FROM employees 
       GROUP BY dept_id
) x;
```

### Slide 33: WITH Clause
```sql
WITH avg_ages_table AS 
(
  SELECT AVG(age) AS avg_age 
  FROM employees
)
SELECT * 
FROM employees, avg_ages
WHERE employees.age > avg_ages_table.avg_age;
```

### Slide 34: Constraints
```sql
CREATE TABLE dept (
 id INT PRIMARY KEY,
 name VARCHAR(50) UNIQUE
);
```

### Slide 35: Practice
- Find employees above avg salary.

### Slide 36: Practice
- Use WITH to simplify a query.

---

## Week 7 – Wrap-up

### Slide 37: Transactions
```sql
START TRANSACTION;
UPDATE employees SET age=age+1;
ROLLBACK;
```

### Slide 38: Indexes
```sql
CREATE INDEX idx_age ON employees(age);
```

### Slide 39: Best Practices
- Use clear names, keep schema normalized.

### Slide 40: Course Summary

- Tables → SELECT → Joins → Aggregation → Subqueries → Transactions.

