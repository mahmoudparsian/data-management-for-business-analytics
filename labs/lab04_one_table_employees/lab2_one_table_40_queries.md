# Lab 2, using MySQL and SQL

Activities:

	1. Create a single simple table.

	2. Insert some rows.

	3. Provide 20 beginner queries (with English + SQL).

	4. Provide 20 intermediate queries (with English + SQL).




# 📌 Step 1: Create Database & Table

#### Create Database:

~~~sql
CREATE DATABASE db2;
~~~

#### Now, Select your database for use:

~~~sql
USE db2;
~~~


#### Create Table wit 5 columns:

~~~sql
CREATE TABLE employees (

    emp_id INT  PRIMARY KEY,

    name VARCHAR(50),

    age INT,

    department VARCHAR(50),

    salary INT

);
~~~



# 📌 Step 2: Insert Sample Rows: 20 rows


~~~sql
INSERT INTO employees (emp_id, name, age, department, salary) 
VALUES
(1, 'Alice', 30, 'HR', 50000),
(2, 'Bob', 25, 'IT', 60000),
(3, 'Charlie', 28, 'Finance', 51000),
(4, 'Diana', 35, 'IT', 75000),
(5, 'Ethan', 40, 'Finance', 80000),
(6, 'Fiona', 29, 'HR', 52000),
(7, 'George', 32, 'IT', 62000),
(8, 'Rafa', 38, 'Sports', 180000),
(9, 'Denis', 69, 'Sports', 150000),
(10, 'Hamid', 52, 'HR', 96000),
(11, 'Max', 30, 'HR', 75000),
(12, 'Bo', 25, 'IT', 65000),
(13, 'Hasan', 28, 'Finance', 58000),
(14, 'Darya', 35, 'IT', 75000),
(15, 'Ed', 40, 'Finance', 80000),
(16, 'Ted', 35, 'AI', 175000),
(17, 'Darya', 25, 'AI', 165000),
(18, 'Hasan', 28, 'AI', 58000),
(19, 'Maz', 35, 'IT', 95000),
(20, 'Mo', 40, 'IT', 85000);
~~~

Now we have 15 employees in the table.




# 🟢 Part A – 20 Beginner Queries



### 1. Show all employees

~~~sql
SELECT * 
FROM employees;
~~~

### 2. Show only names of employees

~~~sql
SELECT name 
FROM employees;
~~~

### 3. Show employee names and salaries

~~~sql
SELECT name, salary 
FROM employees;
~~~


### 4. Find all employees in the IT department

~~~sql
SELECT * 
FROM employees 
WHERE department = 'IT';
~~~


### 5. Find employees older than 30

~~~sql
SELECT * 
FROM employees 
WHERE age > 30;
~~~


### 6. Show employees earning more than 60,000

~~~sql
SELECT * 
FROM employees 
WHERE salary > 60000;
~~~


### 7. Show employees with salary less than or equal to 55,000

~~~sql
SELECT * 
FROM employees 
WHERE salary <= 55000;
~~~


### 8. Show employees not in the HR department

~~~sql
SELECT * 
FROM employees 
WHERE department <> 'HR';
~~~


### 9. Show employees ordered by age (youngest first)

~~~sql
SELECT * 
FROM employees 
ORDER BY age ASC;
~~~


### 10. Show employees ordered by salary (highest first)

~~~sql
SELECT * 
FROM employees 
ORDER BY salary DESC;
~~~


### 11. Find employees named ‘Alice’

~~~sql
SELECT * 
FROM employees 
WHERE name = 'Alice';
~~~

### 12. Show only employee IDs and names

~~~sql
SELECT emp_id, name 
FROM employees;
~~~
 
### 13. Show employees between ages 28 and 35

solution-1:

~~~sql
SELECT * 
FROM employees 
WHERE age BETWEEN 28 AND 35;
~~~

solution-2:

~~~sql
SELECT * 
FROM employees 
WHERE (age >= 28) AND (age <= 35);
~~~


### 14. Show employees with names starting with ‘D’

~~~sql
SELECT * 
FROM employees 
WHERE name LIKE 'D%';
~~~
 
### 15. Show employees with names ending with ‘a’

~~~sql
SELECT * 
FROM employees 
WHERE name LIKE '%a';
~~~
 
### 16. Count total number of employees

solution-1:

~~~sql
SELECT COUNT(*) 
FROM employees;
~~~


solution-2:

~~~sql
SELECT COUNT(*) as num_of_emps
FROM employees;
~~~


### 17. Find the youngest employee

~~~sql
SELECT * 
FROM employees 
ORDER BY age ASC 
LIMIT 1;
~~~
 
### 18. Find the oldest employee

~~~sql
SELECT * 
FROM employees 
ORDER BY age DESC 
LIMIT 1;
~~~
 
### 19. Show unique departments

~~~sql
SELECT DISTINCT department 
FROM employees;
~~~
 
### 20. Show employees from HR or IT

solution-1:

~~~sql
SELECT * 
FROM employees 
WHERE department IN ('HR', 'IT');
~~~
 

solution-2:

~~~sql
SELECT * 
FROM employees 
WHERE (department = 'HR') OR 
      (department = 'IT');
~~~
 



# 🟡 Part B – 20 Intermediate Queries



### 21. Find average salary of all employees

solution-1:

~~~sql
SELECT AVG(salary) 
FROM employees;
~~~


solution-2:

~~~sql
SELECT AVG(salary) as average_salary
FROM employees;
~~~


### 22. Find total salary paid to employees

solution-1:

~~~sql
SELECT SUM(salary) 
FROM employees;
~~~


solution-2:

~~~sql
SELECT SUM(salary)  as total_salary
FROM employees;
~~~


### 23. Find highest salary

solution-1:

~~~sql
SELECT MAX(salary) 
FROM employees;
~~~


solution-2:

~~~sql
SELECT MAX(salary) as max_salary
FROM employees;
~~~


### 24. Find lowest salary

solution-1:

~~~sql
SELECT MIN(salary) 
FROM employees;
~~~

solution-2:

~~~sql
SELECT MIN(salary) as lowest_salary
FROM employees;
~~~

 
### 25. Count employees in each department

solution-1:

~~~sql
SELECT department, COUNT(*) 
FROM employees 
GROUP BY department;
~~~

solution-2:

~~~sql
SELECT department, COUNT(*) as count_per_dept
FROM employees 
GROUP BY department;
~~~


### 26. Find average salary in each department

solution-1:

~~~sql
SELECT department, AVG(salary) 
FROM employees 
GROUP BY department;
~~~

solution-2:

~~~sql
SELECT department, AVG(salary) as avg_salary 
FROM employees 
GROUP BY department;
~~~
 
### 27.1 Show department with highest average salary

~~~sql
SELECT department, AVG(salary) AS avg_salary 
FROM employees 
GROUP BY department 
ORDER BY avg_salary DESC 
LIMIT 1;
~~~

### 27.2 Show department with lowest average salary

~~~sql
SELECT department, AVG(salary) AS avg_salary 
FROM employees 
GROUP BY department 
ORDER BY avg_salary ASC 
LIMIT 1;
~~~
 
### 28.1 Show department with most number of employees

~~~sql
SELECT department, COUNT(*) AS num_per_dept 
FROM employees 
GROUP BY department 
ORDER BY num_per_dept DESC
LIMIT 1;
~~~

### 28.2 Show department with the least noner of  employees

~~~sql
SELECT department, COUNT(*) AS num_per_dept 
FROM employees 
GROUP BY department 
ORDER BY num_per_dept ASC
LIMIT 1;
~~~

### 29. List employees who earn above the overall average salary

~~~sql
SELECT * 
FROM employees WHERE salary > (
                                SELECT AVG(salary) 
                                FROM employees
                              );
~~~
 
### 30. Show employees in IT with salary above 60,000

~~~sql
SELECT * 
FROM employees 
WHERE department = 'IT' AND 
      salary > 60000;
~~~
 
### 31. Show employees not in Finance and salary above 55,000

~~~sql
SELECT * 
FROM employees 
WHERE department <> 'Finance' AND 
      salary > 55000;
~~~
 
### 32. Increase all IT employees’ salaries by 10%

**Before:**

~~~sql
SELECT * 
FROM employees;
~~~

**Increase:**

~~~sql
UPDATE employees 
SET salary = salary * 1.1 
WHERE department = 'IT';
~~~


**After:**

~~~sql
SELECT * 
FROM employees;
~~~


### 33. Change department of Alice to ‘Finance’

**Before:**

~~~sql
SELECT * 
FROM employees;
~~~

**Change:**

~~~sql
UPDATE employees 
SET department = 'Finance' 
WHERE name = 'Alice';
~~~

**After:**

~~~sql
SELECT * 
FROM employees;
~~~


### 34. Delete employees younger than 26

**Before:**

~~~sql
SELECT * 
FROM employees;
~~~

**Delete:**

~~~sql
DELETE 
FROM employees 
WHERE age < 26;
~~~

**After:**

~~~sql
SELECT * 
FROM employees;
~~~


### 35.1 Show top 3 highest-paid employees

~~~sql
SELECT * 
FROM employees 
ORDER BY salary DESC 
LIMIT 3;
~~~

### 35.2 Show bottom 3 lowest-paid employees

~~~sql
SELECT * 
FROM employees 
ORDER BY salary ASC 
LIMIT 3;
~~~
 
### 36.1 Show bottom 2 lowest-paid employees

~~~sql
SELECT * 
FROM employees 
ORDER BY salary ASC 
LIMIT 2;
~~~


### 36.2 Show top 2 highest-paid employees

~~~sql
SELECT * 
FROM employees 
ORDER BY salary DESC 
LIMIT 2;
~~~


### 37. Find average age of employees per department

solution-1:

~~~sql
SELECT department, AVG(age) 
FROM employees 
GROUP BY department;
~~~


solution-2:

~~~sql
SELECT department, AVG(age) AS avg_age
FROM employees 
GROUP BY department;
~~~


### 38. Find employees with salary between 55,000 and 70,000

solution-1:

~~~sql
SELECT * 
FROM employees 
WHERE salary BETWEEN 55000 AND 70000;
~~~

solution-2:

~~~sql
SELECT * 
FROM employees 
WHERE salary >= 55000 AND 
      salary >= 70000;
~~~


### 39. Find number of employees whose name contains ‘o’

~~~sql
SELECT COUNT(*) 
FROM employees 
WHERE name LIKE '%o%';
~~~
 
### 40. Add a new employee

~~~
emp_id: 25
name: Max
age: 32
department: Sports
Salary: 45000
~~~

Adding a new employee:

~~~sql
INSERT INTO employees (emp_id, name, age, department, salary) 
VALUES
(25, 'Max', 32, 'Sports', 45000);
~~~

