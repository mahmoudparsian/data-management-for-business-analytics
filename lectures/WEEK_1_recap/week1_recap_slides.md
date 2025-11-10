# Week 1 Recap: <br> Relational Databases & SQL Basics

---

## Slide 1: What is a Relational Database?
- a Database = set of tables 
- `emp_db`: 3 tables: {employees, departments, projects}
- A **collection of data** organized into tables (rows + columns).
- Each table has:
  - **Columns** → attributes (e.g., `name`, `salary`)
  - **Rows** → records (e.g., one employee)
- Relationships exist between tables via **keys**.
- PK = Primary Key
- FK = Foreign Key

---

## Slide 2: Key Concepts
- **Primary Key (PK)**: Uniquely identifies a row in a table.
- **Foreign Key (FK)**: Refers to a PK in another table, creates relationships.
- **Schema**: Blueprint/definition of the structure of a database.

Example:

```sql
USE emp_db;

CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  name VARCHAR(50),
  department VARCHAR(30),
  salary DECIMAL(10,2)
);
```

---

## Slide 3: SQL Basics
- **Structured Query Language (SQL)** is used to:
  - Create tables → `CREATE`
  - Insert data → `INSERT`
  - Query data → `SELECT`
  - Update data → `UPDATE`
  - Delete data → `DELETE`

---

## Slide 4: Example — Create Table
```sql
CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  department VARCHAR(30),
  salary DECIMAL(10,2)
);
```

---

## Slide 5: Example — Insert Data
```sql
INSERT INTO employees 
(emp_id, first_name, last_name, department, salary)
VALUES
(1, 'Alice', 'Johnson', 'Engineering', 95000),
(2, 'Bob', 'Smith', 'Finance', 70000),
(3, 'Carol', 'Davis', 'Marketing', 78000),
(4, 'Ralph', 'Kenton', 'Business', NULL);
```

### What is `NULL`?

* `NULL` means a missing value (undefined)
* `NULL` is not 0 (zero)
* `NULL` is not an empty string ""

---

## Slide 6: Example — Basic Select
```sql
-- * refers to all columns of a table
-- List all employees
SELECT * 
FROM employees;

SELECT emp_id, first_name, last_name, department, salary
FROM employees;

-- get all columns, but only 2 rows
SELECT emp_id, first_name, last_name, department, salary
FROM employees
LIMIT 2;

-- get 2 highest-paid  employees
SELECT emp_id, first_name, last_name, department, salary
FROM employees
ORDER BY salary DESC
LIMIT 2;

RESULT:
(1, 'Alice', 'Johnson', 'Engineering', 95000)
(3, 'Carol', 'Davis', 'Marketing', 78000)

-- get 2 lowest-paid  employees
SELECT emp_id, first_name, last_name, department, salary
FROM employees
ORDER BY salary ASC
LIMIT 2;

RESULT:
(2, 'Bob', 'Smith', 'Finance', 70000),
(3, 'Carol', 'Davis', 'Marketing', 78000),



-- Show only names and salaries
SELECT first_name, last_name, salary 
FROM employees;
```

---

## Slide 7: Filtering Rows

#### Query-1: Employees with `salary > 80000`

```sql
SELECT * 
FROM employees 
WHERE salary > 80000;
```

#### Query-2: Employees in Finance

```sql
SELECT * 
FROM employees 
WHERE department = 'Finance';
```

#### Query-3: Employees with `salary > 80000` who work in Engineering department

```sql
SELECT * 
FROM employees 
WHERE salary > 80000 AND department = 'Engineering';
```

OR

```sql
SELECT * 
FROM employees 
WHERE (salary > 80000) AND (department = 'Engineering');
```

```
Boolean : TRUE and FALSE

A      B    (A AND B)   (A OR B)
TRUE   TRUE    TRUE       TRUE
TRUE   FALSE   FALSE      TRUE
FALSE  TRUE    FALSE      TRUE
FALSE  FALSE   FALSE      FALSE
```

---

## Slide 8: Aggregate Functions

- SQL provides aggregate functions:

  - `COUNT()` → number of rows
  - `AVG()` → average value
  - `MAX()` → maximum value
  - `MIN()` → minimum value
  - `SUM()` → total

#### Example: Average salary per department

**solution-1:**

```sql
SELECT department, 
       AVG(salary)
FROM employees
GROUP BY department;
```

**solution-2:**


```sql
SELECT department, 
       AVG(salary) AS avg_salary
FROM employees
GROUP BY department;
```



---

## Slide 9: Ordering & Limiting

**Query-1: Top 3 highest paid employees**:

```sql
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 3;
```

**Query-1: Bottom 3 lowewst paid employees**:

```sql
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary ASC
LIMIT 3;
```

---

## Slide 10: Key Takeaways
- Relational DBs organize data into **tables with rows and columns**.
- Keys ensure **uniqueness** and **relationships**.
- SQL lets us **create, insert, query, update, delete**.
- Aggregations + filters give insights.
- Week 1 focus: **basic SELECTs, filtering, aggregations**.

---
