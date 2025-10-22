# Join Operations in Action

	using mysql, to explain join operations: create a 
	departments table with 5 distinct departments (do not 
	assign 2 of these departments to any employee), and 
	then create 8 employees, where assign 5 of them to 3 
	departments, and for 3 of them, set the departments 
	to NULL. Then come up with all joins in sql and give 
	a natural language query as well for understanding, 
	then give sample rows for both tables and output for 
	all joins

	👍 — this is a classic way to teach joins in MySQL. 
	Let’s carefully build this step by step.

⸻

# 1. Create Tables

TABLE Departments:

~~~sql
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);
~~~

TABLE Employees:

~~~sql
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT NULL,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);
~~~

⸻

# 2. Insert Sample Data

Departments (5 total, 2 unassigned)

~~~sql
INSERT INTO Departments (dept_id, dept_name) 
VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'Engineering'),
(4, 'Marketing'),   -- not assigned
(5, 'Legal');       -- not assigned
~~~

Employees (8 total, 5 assigned, 3 NULL)

~~~sql
INSERT INTO Employees (emp_id, emp_name, dept_id) 
VALUES
(1, 'Alice', 1),   -- HR
(2, 'Bob', 2),     -- Finance
(3, 'Charlie', 3), -- Engineering
(4, 'David', 1),   -- HR
(5, 'Eve', 2),     -- Finance
(6, 'Frank', NULL),
(7, 'Grace', NULL),
(8, 'Heidi', NULL);
~~~

⸻

# 3. Sample Rows

Departments

~~~
dept_id    dept_name
1          HR
2          Finance
3          Engineering
4          Marketing
5          Legal
~~~

Employees

~~~
emp_id    emp_name    dept_id
1         Alice       1
2         Bob         2
3         Charlie     3
4         David       1
5         Eve         2
6         Frank       NULL
7         Grace       NULL
8         Heidi       NULL
~~~

⸻

# 4. All Join Types in SQL

⸻

## A. INNER JOIN

Show employees that are assigned to departments.

~~~sql
SELECT 
       e.emp_name, 
       d.dept_name
FROM 
       Employees e
INNER JOIN Departments d ON e.dept_id = d.dept_id;
~~~

Output

~~~
emp_name    dept_name
Alice       HR
Bob         Finance
Charlie     Engineering
David       HR
Eve         Finance
~~~

⸻

## B. LEFT JOIN

Show all employees, even if they don’t belong to a department.

~~~sql
SELECT 
       e.emp_name, 
       d.dept_name
FROM 
       Employees e
LEFT JOIN Departments d ON e.dept_id = d.dept_id;
~~~

Output

~~~
emp_name    dept_name
Alice       HR
Bob         Finance
Charlie     Engineering
David       HR
Eve         Finance
Frank       NULL
Grace       NULL
Heidi       NULL
~~~

⸻

## C. RIGHT JOIN

Show all departments, even if no employees are assigned.

~~~sql
SELECT 
       e.emp_name, 
       d.dept_name
FROM 
       Employees e
RIGHT JOIN Departments d ON e.dept_id = d.dept_id;
~~~

Output

~~~
emp_name    dept_name
Alice       HR
David       HR
Bob         Finance
Eve         Finance
Charlie     Engineering
NULL        Marketing
NULL        Legal
~~~

⸻

## D. FULL OUTER JOIN

	NOTE: MySQL doesn’t support FULL JOIN directly, 
	but we can emulate it with UNION of left + right joins.)

~~~sql
SELECT e.emp_name, d.dept_name
FROM Employees e
LEFT JOIN Departments d ON e.dept_id = d.dept_id

UNION

SELECT e.emp_name, d.dept_name
FROM Employees e
RIGHT JOIN Departments d ON e.dept_id = d.dept_id;
~~~

Output

~~~
emp_name    dept_name
Alice       HR
David       HR
Bob         Finance
Eve         Finance
Charlie     Engineering
Frank       NULL
Grace       NULL
Heidi       NULL
NULL        Marketing
NULL        Legal
~~~

⸻

5. Summary in Words
    •    INNER JOIN → only employees with valid departments.
    •    LEFT JOIN → all employees, with or without departments.
    •    RIGHT JOIN → all departments, with or without employees.
    •    FULL OUTER JOIN → all employees + all departments, with NULLs where no match.

⸻

## We want departments that have no employees assigned.

**Solution 1: Using LEFT JOIN + WHERE IS NULL**

~~~sql
SELECT d.dept_id, d.dept_name
FROM Departments d
LEFT JOIN Employees e ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL;
~~~

Explanation:
	•	LEFT JOIN keeps all departments.
	•	If no employee matches, e.emp_id will be NULL.
	•	Filtering on WHERE e.emp_id IS NULL gives departments with no employees.


🎯 Sample Output (from our dataset)

~~~
dept_id   dept_name
4         Marketing
5         Legal
~~~

**Solution 2: Using NOT IN**

~~~sql
SELECT dept_id, dept_name
FROM Departments
WHERE dept_id NOT IN (
                       SELECT DISTINCT dept_id 
                       FROM Employees 
                       WHERE dept_id IS NOT NULL
                     );
~~~

