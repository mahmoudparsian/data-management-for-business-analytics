# 📑 SQL Cheat Sheet: Common Patterns

This cheat sheet summarizes the most common SQL patterns with examples.

---

## 🔹 1. SELECT & Filtering

```sql
-- Select all columns
SELECT * FROM table_name;

-- Select specific columns
SELECT col1, col2 FROM table_name;

-- Filtering
SELECT * FROM employees WHERE salary > 5000;

-- Pattern matching
SELECT * FROM customers WHERE name LIKE 'A%';
```

---

## 🔹 2. Aggregations & GROUP BY

```sql
-- Count, Sum, Average
SELECT COUNT(*) AS num_rows FROM orders;
SELECT SUM(amount) AS total_sales FROM orders;
SELECT AVG(salary) AS avg_salary FROM employees;

-- Grouping
SELECT dept_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY dept_id;
```

---

## 🔹 3. HAVING

```sql
-- Filter after grouping
SELECT dept_id, COUNT(*) AS num_employees
FROM employees
GROUP BY dept_id
HAVING COUNT(*) > 5;
```

---

## 🔹 4. Sorting & Limiting

```sql
-- Order results
SELECT name, salary FROM employees
ORDER BY salary DESC;

-- Limit results
SELECT name FROM employees LIMIT 10;
```

---

## 🔹 5. Joins

```sql
-- Inner Join
SELECT e.name, d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

-- Left Join
SELECT e.name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

-- Right Join
SELECT e.name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;

-- Full Outer Join (MySQL via UNION)
SELECT e.name, d.dept_name
FROM employees e LEFT JOIN departments d ON e.dept_id = d.dept_id
UNION
SELECT e.name, d.dept_name
FROM employees e RIGHT JOIN departments d ON e.dept_id = d.dept_id;
```

---

## 🔹 6. Subqueries

```sql
-- Scalar subquery
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- IN subquery
SELECT name
FROM employees
WHERE dept_id IN (SELECT dept_id FROM departments WHERE location = 'NY');

-- EXISTS
SELECT name
FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id);
```

---

## 🔹 7. Set Operations

```sql
-- UNION (removes duplicates)
SELECT name FROM table1
UNION
SELECT name FROM table2;

-- UNION ALL (keeps duplicates)
SELECT name FROM table1
UNION ALL
SELECT name FROM table2;

-- INTERSECT (rows common to both)
SELECT name FROM table1
INTERSECT
SELECT name FROM table2;

-- EXCEPT (rows in first, not in second)
SELECT name FROM table1
EXCEPT
SELECT name FROM table2;
```

---

## 🔹 8. Window Functions

```sql
-- Row numbering
SELECT name, ROW_NUMBER() OVER (ORDER BY salary DESC) AS rownum
FROM employees;

-- Ranking with ties
SELECT name, RANK() OVER (ORDER BY salary DESC) AS rnk
FROM employees;

-- Dense rank (no gaps)
SELECT name, DENSE_RANK() OVER (ORDER BY salary DESC) AS drnk
FROM employees;

-- Running total
SELECT name, SUM(salary) OVER (ORDER BY hire_date) AS running_total
FROM employees;

-- Partitioned aggregation
SELECT dept_id, name, salary,
       AVG(salary) OVER (PARTITION BY dept_id) AS dept_avg
FROM employees;
```

---

## 🔹 9. Common Table Expressions (CTEs)

```sql
WITH DeptAvg AS (
  SELECT dept_id, AVG(salary) AS avg_salary
  FROM employees
  GROUP BY dept_id
)
SELECT e.name, e.salary, d.avg_salary
FROM employees e JOIN DeptAvg d ON e.dept_id = d.dept_id;
```

---

✅ Use this cheat sheet as a quick reference during exercises!
