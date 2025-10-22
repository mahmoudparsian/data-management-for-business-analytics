

# Teaching JOIN Operations in MySQL

		Let's learn join operations in mysql from the ground up: 
		what is a join, inner join, left join, right join, with 
		a complete schema of 2 tables with inserting sample rows:  
		we have 5 departments (only 3 of them are assigned to 
		employees), we have 6 employees, only 4 of them have 
		proper departments and 2 of them have NULL departments, 
		provide everything in a downloadable markdown format. 
---

## 📑 Step 1: What is a JOIN?

- A **JOIN** is used to combine rows from two or more tables based on a related column.  
- Helps answer questions that require data spread across multiple tables.  
- Common types: **INNER JOIN**, **LEFT JOIN**, **RIGHT JOIN**, **FULL OUTER JOIN** (simulated in MySQL).  

---

## 📑 Step 2: Create Schema and Insert Rows

### Departments Table
```sql
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(20)
);

INSERT INTO departments VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Legal');
```

📊 **departments table**

| dept_id | dept_name |
|---------|-----------|
| 1       | HR        |
| 2       | IT        |
| 3       | Finance   |
| 4       | Marketing |
| 5       | Legal     |

---

### Employees Table
```sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(20),
    dept_id INT
);

INSERT INTO employees VALUES
(101, 'Alice', 1),   -- HR
(102, 'Bob', 2),     -- IT
(103, 'Charlie', 2), -- IT
(104, 'David', 3),   -- Finance
(105, 'Eva', NULL),  -- No department
(106, 'Frank', NULL);-- No department
```

📊 **employees table**

| emp_id | name    | dept_id |
|--------|---------|---------|
| 101    | Alice   | 1       |
| 102    | Bob     | 2       |
| 103    | Charlie | 2       |
| 104    | David   | 3       |
| 105    | Eva     | NULL    |
| 106    | Frank   | NULL    |

---

## 📑 Step 3: INNER JOIN

👉 Returns rows where there is a match in both tables.

```sql
SELECT e.emp_id, e.name, d.dept_name
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id;
```

✅ Output

| emp_id | name    | dept_name |
|--------|---------|-----------|
| 101    | Alice   | HR        |
| 102    | Bob     | IT        |
| 103    | Charlie | IT        |
| 104    | David   | Finance   |

✔ Employees with NULL dept_id are excluded.  
✔ Departments with no employees (Marketing, Legal) are excluded.  

---

## 📑 Step 4: LEFT JOIN

👉 Returns all rows from the **left table** (employees), and matching rows from the right (departments).  
If no match, department is NULL.

```sql
SELECT e.emp_id, e.name, d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;
```

✅ Output

| emp_id | name    | dept_name |
|--------|---------|-----------|
| 101    | Alice   | HR        |
| 102    | Bob     | IT        |
| 103    | Charlie | IT        |
| 104    | David   | Finance   |
| 105    | Eva     | NULL      |
| 106    | Frank   | NULL      |

✔ All employees are included.  
✔ Eva and Frank show `NULL` for department since they have none.  

---

## 📑 Step 5: RIGHT JOIN

👉 Returns all rows from the **right table** (departments), and matching rows from the left (employees).  
If no match, employee columns are NULL.

```sql
SELECT e.emp_id, e.name, d.dept_name
FROM employees e
RIGHT JOIN departments d
ON e.dept_id = d.dept_id;
```

✅ Output

| emp_id | name    | dept_name |
|--------|---------|-----------|
| 101    | Alice   | HR        |
| 102    | Bob     | IT        |
| 103    | Charlie | IT        |
| 104    | David   | Finance   |
| NULL   | NULL    | Marketing |
| NULL   | NULL    | Legal     |

✔ All departments are included.  
✔ Marketing and Legal appear with `NULL` employees because they have none.  

---

## 📑 Step 6: FULL OUTER JOIN (via UNION in MySQL)

👉 MySQL does not support `FULL OUTER JOIN` directly.  
We can simulate it with a **UNION** of `LEFT JOIN` and `RIGHT JOIN`.  

```sql
SELECT e.emp_id, e.name, d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id

UNION

SELECT e.emp_id, e.name, d.dept_name
FROM employees e
RIGHT JOIN departments d
ON e.dept_id = d.dept_id;
```

✅ Output

| emp_id | name    | dept_name |
|--------|---------|-----------|
| 101    | Alice   | HR        |
| 102    | Bob     | IT        |
| 103    | Charlie | IT        |
| 104    | David   | Finance   |
| 105    | Eva     | NULL      |
| 106    | Frank   | NULL      |
| NULL   | NULL    | Marketing |
| NULL   | NULL    | Legal     |

✔ Includes **all employees** and **all departments**.  
✔ Employees without departments and departments without employees are both shown.  

---

## 📑 Step 7: Key Takeaways

- **INNER JOIN** → only matching rows (intersection).  
- **LEFT JOIN** → all employees, with NULL if no department.  
- **RIGHT JOIN** → all departments, with NULL if no employees.  
- **FULL OUTER JOIN** (via UNION) → all employees and all departments, matched when possible, NULL otherwise.  

---

