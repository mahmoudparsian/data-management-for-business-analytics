# SELECT operation


	Using mysql, First define a simple table of employees 
	with 10 rows. Then provide 6 SELECT statements with 
	results (3 simple, 3 intermediate)

	✅ This way, you have:
    •    3 simple queries (select all, select specific columns, 
    	  filter by department).
    	  
    •    3 intermediate queries (filter by condition, grouping, 
    	  aggregation + ordering).



⸻

## 📘 Step 1 — Create a Simple employees Table

### Create Table

~~~sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE
);
~~~

### Populate Table

~~~sql
INSERT INTO employees (emp_id, name, department, salary, hire_date) 
VALUES
(1, 'John Doe', 'Engineering', 75000, '2018-03-15'),
(2, 'Jane Smith', 'HR', 60000, '2019-06-01'),
(3, 'Robert Brown', 'Finance', 82000, '2017-11-20'),
(4, 'Linda Johnson', 'Engineering', 95000, '2015-05-23'),
(5, 'Michael Williams', 'Marketing', 67000, '2020-01-12'),
(6, 'Susan Jones', 'Finance', 73000, '2016-09-18'),
(7, 'David Miller', 'Engineering', 88000, '2014-07-09'),
(8, 'Karen Davis', 'Sales', 64000, '2021-02-25'),
(9, 'James Wilson', 'Marketing', 70000, '2019-10-10'),
(10, 'Patricia Moore', 'HR', 62000, '2018-12-05');
~~~



⸻

## 📘 Step 2 — 3 Simple SELECT Queries

### 1. Select All Employees

~~~sql
SELECT * 
FROM employees;
~~~

Result (first few rows shown):

~~~
emp_id    name        department    salary    hire_date
1         John Doe    Engineering    75000    2018-03-15
2         Jane Smith  HR             60000    2019-06-01
…    …    …    …    …
~~~

⸻


### 2. Select Names and Salaries Only

~~~sql
SELECT 
       name, 
       salary 
FROM 
     employees;
~~~

Result:

~~~sql
name          salary
John Doe      75000
Jane Smith    60000
Robert Brown  82000
…    …
~~~

⸻

### 3. Employees in HR Department

~~~sql
SELECT 
       name, 
       department 
FROM 
       employees
WHERE 
       department = 'HR';
~~~


Result:

~~~sql
name              department
Jane Smith        HR
Patricia Moore    HR
~~~

⸻

### 📘 Step 3 — 3 Intermediate SELECT Queries

#### 4. Employees With Salary Greater Than 80,000

~~~sql
SELECT 
      name,  
      salary 
FROM 
      employees
WHERE 
      salary > 80000;
~~~

Result:

~~~sql
name            salary
Robert Brown    82000
Linda Johnson   95000
David Miller    88000
~~~

⸻

## 5. Count Employees by Department

~~~sql
SELECT 
       department, 
       COUNT(*) AS num_of_employees
FROM 
       employees
GROUP BY 
       department;
~~~

Result:

~~~sql
department     num_of_employees
Engineering    3
HR             2
Finance        2
Marketing      2
Sales          1
~~~

⸻

## 6. Average Salary per Department (Ordered High → Low)

~~~sql
SELECT 
       department, 
       AVG(salary) AS avg_salary
FROM 
       employees
GROUP BY 
       department
ORDER BY 
       avg_salary DESC;
~~~

Result:

~~~sql
department     avg_salary
Engineering    86000.00
Finance        77500.00
Marketing      68500.00
HR             61000.00
Sales          64000.00
~~~

⸻
