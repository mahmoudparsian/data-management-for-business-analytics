# 🎓 Using EXISTS and NOT EXISTS in MySQL

## 🔹 1. Schema Setup

~~~sql
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(20)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(20),
    dept_id INT
);
~~~

## 🔹 2. Populate Tables

~~~sql
INSERT INTO departments VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');

INSERT INTO employees VALUES
(101, 'Alice', 1),
(102, 'Bob', 2),
(103, 'Charlie', 2);
~~~

#### 📊 departments

~~~
dept_id    dept_name
1          HR
2          IT
3          Finance
~~~

#### 📊 employees

~~~
emp_id    name    dept_id
101       Alice     1
102       Bob       2
103       Charlie   2
~~~

⸻

## 🔹 3. Use of EXISTS

👉 Find departments that have at least one employee.

~~~sql
SELECT dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.dept_id = d.dept_id
);
~~~

✅ Output:

~~~
dept_name
HR
IT
~~~

**NOTE: Finance excluded since no employee is assigned.**

⸻

## 🔹 4. Use of NOT EXISTS

👉 Find departments that do not have any employees.

~~~sql
SELECT dept_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.dept_id = d.dept_id
);
~~~

✅ Output:

~~~
dept_name
Finance
~~~

(✔ Finance has no employees, so it appears here.)

⸻

## 🔹 5. Key Takeaways

    •    EXISTS → returns TRUE if the subquery 
                  returns at least one row.
    
    •    NOT EXISTS → returns TRUE if the subquery 
                      returns no rows.
    
    •    Typically used for:
    •    Checking for related records in another table.
    •    Finding rows with or without relationships.

⸻

