# Every SQL Query Returns a Relation (Table)

## ✅ Core Principle

	In relational algebra — the theory behind SQL — 
	**every operation takes one or more relations 
	as input and produces a relation as output**.

In SQL this means:

> **Every SQL query returns a table**, even if it has  
> - 1 row  
> - 1 column  
> - or 0 rows

---

## ✅ Examples

### 1. Basic SELECT

```sql
SELECT * 
FROM employees;
```
✅ Returns a table (all rows & columns)

**Output (example):**

| emp_id | name   | salary |
|--------|--------|---------|
| 101    | Alice  | 120000 |
| 102    | Bob    | 140000 |
| 103    | Carol  | 180000 |


---

### 2. Filtered SELECT

```sql
SELECT * 
FROM employees 
WHERE salary > 130000;
```
✅ Returns a table (maybe empty)

**Output (example):**

| emp_id | name  | salary |
|--------|-------|---------|
| 102    | Bob    | 140000 |
| 103    | Carol  | 180000 |


---

### 3. JOIN
```sql
SELECT e.name, 
       d.dept_name
FROM employees e
JOIN departments d USING (dept_id);
```

OR

```sql
SELECT e.name, 
       d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;
```

✅ Returns a table combining two relations

---

### 4. Aggregate Result
```sql
SELECT dept_id, AVG(salary)
FROM employees
GROUP BY dept_id;
```
✅ Still a table (one row per group)

---

### 5. Even a Single Value Is a Table
```sql
SELECT NOW();
```

Output is:

| NOW() |
|-------|
| 2025-02-05 12:00:00 |

✅ A 1-row, 1-column table

---

### 6. Empty Result Is Still a Table
```sql
SELECT * FROM employees WHERE 1 = 0;
```

✅ Columns are defined  
✅ Zero rows  
✅ Still a table

**Output:**

| emp_id | name | salary |
|--------|-------|---------|
| *(no rows)* |

---

### 7. Subqueries Always Return Tables
```sql
SELECT *
FROM (SELECT 1 AS x, 2 AS y) AS t;
```

✅ Table with 1 row, 2 columns

**Output:**

| x | y |
|---|---|
| 1 | 2 |

-----

### 8. Examples:

|Query Type    | Example   | Output is a table? |
|--------------|-----------|--------------------|
|Basic SELECT   | `SELECT * FROM employees;` | ✅ Table |
|Filtered SELECT	 | `SELECT * FROM employees WHERE salary > 100000;` |✅ Table |
|JOIN	|`SELECT e.name, d.dept_name FROM employees e JOIN departments d USING (dept_id);`	| ✅ Table|
|Aggregate	| `SELECT dept_id, AVG(salary) FROM employees GROUP BY dept_id;` |	✅ Table |
|Scalar function	| `SELECT NOW();` |	✅ A 1-row, 1-column table |
|No rows	| `SELECT * FROM employees WHERE 1=0;` |	✅ An empty table with columns defined |
|UNION / INTERSECT	| `SELECT ... UNION SELECT ...` |	✅ Table |


⸻

### ✅ 9. Even a Single Value Is Still a Table

Example:

```sql
SELECT COUNT(*) 
FROM employees;
```

This returns:

```
COUNT(*)
42
```

You might think this is a scalar, but relationally it is:

	•	a table with 1 row
	•	a table with 1 column
	•	still a relation


-----

## ✅ Why This Matters 

- Enables unlimited query composition  
- Makes JOINs intuitive  
- Explains subqueries and derived tables  
- Builds a strong foundation for relational thinking  

---

## ✅ Big Concept Summary
**SQL = relational algebra.  
Every SQL query returns a relation.**  
