# MySQL 101

	Create a sample database with a single table such as 
	employees with 10 records, then provide the basic SQL 
	commands for this table: keep it as simple as possible.

	Perfect idea 👍 — a “MySQL 101” exercise with a single 
	table and some basic SQL commands. Let’s keep it as simple 
	as possible for students.

### ✅ This example is self-contained and covers the basics:

    •    Create DB + table
    •    Insert rows
    •    Run basic queries (SELECT, WHERE, ORDER BY)
    •    Do simple updates and deletes
    •    Use aggregate functions (COUNT, AVG)

⸻


## Step-1: Create a Database

#### Step 1.1:

~~~mysql
CREATE DATABASE company_db;
~~~

**Make your created database active:**

#### Step 1.2:

~~~mysql
USE company_db;
~~~

⸻

## 2. Create a database Table:

This table has 4 columns:

       id,
       name,
       department,
       salary


~~~sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);
~~~


⸻

## 3. Insert Sample Data (10 records):

~~~sql
INSERT INTO employees (id, name, department, salary) 
VALUES
(1, 'Alice Johnson', 'HR', 50000),
(2, 'Bob Smith', 'IT', 60000),
(3, 'Charlie Davis', 'Finance', 55000),
(4, 'Diana Evans', 'Marketing', 52000),
(5, 'Ethan Brown', 'IT', 62000),
(6, 'Fiona Clark', 'Finance', 58000),
(7, 'George Lewis', 'HR', 51000),
(8, 'Hannah Adams', 'IT', 64000),
(9, 'Ian Wilson', 'Marketing', 53000),
(10, 'Jane Miller', 'Finance', 57000);
~~~

⸻

## 🔑 Basic SQL Commands

## 4. View all employees:

~~~sql
SELECT * 
FROM employees;
~~~

## 5. View name and salary of all employees:

~~~sql
SELECT name, salary 
FROM employees;
~~~

### 6. View specific columns: name, department

~~~sql
SELECT name, department 
FROM employees;
~~~

### 7. Filter with WHERE

~~~sql
SELECT * 
FROM employees
WHERE department = 'IT';
~~~

### 8. Sort results by salary (high to low)

~~~sql
SELECT * 
FROM employees
ORDER BY salary DESC;
~~~

### 9. Sort results by salary (low to high)

~~~sql
SELECT * 
FROM employees
ORDER BY salary ASC;
~~~

### 10. Update a record: change salary of Bob Smith to 71000

~~~sql
UPDATE employees
SET salary = 71000
WHERE name = 'Bob Smith';
~~~


### 11. Delete a record, with name of 'Jane Miller'

~~~sql
DELETE 
FROM employees
WHERE name = 'Jane Miller';
~~~

### 12. Count rows

~~~sql
SELECT COUNT(*) 
FROM employees;
~~~

### 13. Count rows

~~~sql
SELECT COUNT(*) as num_of_emps
FROM employees;
~~~

### 14. Find average salary

~~~sql
SELECT AVG(salary) AS avg_salary
FROM employees;
~~~

### 15. Find total of all salaries

~~~sql
SELECT SUM(salary) AS total_salary
FROM employees;
~~~

### 16. Describe employees table
~~~sql
DESC employees;
~~~

### 17. Find highest salary among all employees

~~~sql
SELECT MAX(salary) AS max_salary
FROM employees;
~~~

### 18. Find lowest salary among all employees

~~~sql
SELECT MIN(salary) AS min_salary
FROM employees;
~~~

### 19. Find highest and lowest salaries among all employees

~~~sql
SELECT MIN(salary) AS min_salary,
       MAX(salary) AS max_salary
FROM employees;
~~~

### 20. Find number of employees per department

~~~sql
SELECT department, 
       count(*) AS num_per_dept
FROM employees
GROUP BY department;
~~~

⸻


