#### 1. What is a relational database 

**1.1 General Definition of a Database:**
		
		A database is an organized collection of information, 
		or data, that is stored electronically and can be easily 
		accessed, managed, and updated. Databases are used by 
		businesses and individuals for various purposes, such 
		as storing customer records or managing social media 
		statistics. The core of a database system is a Database 
		Management System (DBMS), which handles tasks like querying 
		and securing data without users needing to know the physical 
		storage details. 

**1.2 Relational Database:**

		Here’s a concise definition of a "relational database"
		in 3 bullet items:
		
		•	📊 Organizes data into tables (relations) 
		made up of rows (records/tuples) and columns 
		(attributes/fields).
		
		•	🔑 Uses keys (Primary Keys & Foreign Keys) 
		to uniquely identify rows and define relationships 
		between tables.
		
		•	📐 Supports Structured Query Language (SQL) 
		for defining, managing, and querying data in a 
		consistent, relational manner.


------

#### 2. MySQL as an example of a relational database 


		Here’s MySQL as an example of a relational database 
		in 3 simple bullet items:
		
		•	🗄️ Tables and Relationships: MySQL stores 
		data in tables (rows and columns) and allows 
		relationships between them using Primary Keys 
		and Foreign Keys.
		
		•	🔍 SQL Support: MySQL uses Structured Query 
		Language (SQL) to create tables, insert data, 
		and run queries like SELECT, JOIN, and GROUP BY.
	
		•	⚡ Reliability and Scalability: MySQL enforces 
		data integrity rules (like uniqueness, not null, 
		referential integrity) and can scale from small 
		apps to large enterprise systems.

-------

#### 3. MySQL Workbench in 3 bullet items

		Here’s a simple description of MySQL Workbench 
		in 3 bullet items:
		
		•	🖥️ Visual Database Tool: MySQL Workbench 
		is a graphical user interface (GUI) that lets 
		you design, create, and manage MySQL databases 
		without needing to type all commands manually.
		
		•	🔧 Database Administration: It supports 
		tasks like running SQL queries, managing users, 
		configuring servers, and monitoring database 
		performance.
		
		•	📊 Modeling and Design: Provides tools to 
		create Entity–Relationship (ER) diagrams, 
		forward/reverse engineer schemas, and visually 
		design databases.

#### 4. What is an SQL?

	SQL, or Structured Query Language, is a programming 
	language used to communicate with and manage data in 
	relational databases. It is the standard language for 
	interacting with databases, allowing users to query, 
	insert, update, and delete data, as well as manage 
	their structure and security. 
	
-------

#### 5. Create a Database

```sql
CREATE DATABASE my_db;
```

#### 6. Use/Select a Created Database: 

make it active for creating tables inside a created database:

```sql
USE my_db;
```

------

	
SQL Examples:

Create a Table:

```sql
-- create an employees table with 4 fields: 
-- column names are: {emp_id, emp_name, salary, age}
-- every column has a name and a data type
create table employees (
    emp_id int, 
    emp_name VARCHAR(20), 
    salary int,
    age int
);
```

View Table Definition:

```sql
desc employees;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| emp_id   | int         | YES  |     | NULL    |       |
| emp_name | varchar(20) | YES  |     | NULL    |       |
| salray   | int         | YES  |     | NULL    |       |
| age      | int         | YES  |     | NULL    |       |
+----------+-------------+------+-----+---------+-------+
4 rows in set 
```

Insert some rows:


```sql
-- add 3 rows to employees table:

insert into employees(emp_id, emp_name, salary, age) 
values(10, 'alex', 45000, 74);

insert into employees(emp_id, emp_name, salary, age) 
values(30, 'jenny', 89000, 54);

insert into employees(emp_id, emp_name, salary, age) 
values(40, 'max', 65000, 18);
```

SQL queries:

```sql 
-- select all rows of an employees table:
select * from employees;
+--------+----------+---------+------+
| emp_id | emp_name | salary  | age  |
+--------+----------+---------+------+
|     10 | alex     |   45000 | 74   |
|     30 | jenny    |   89000 | 54   |
|     40 | max      |   65000 | 18   |
+--------+----------+---------+------+
3 rows in set (0.001 sec)
```

```sql
-- get  employees with salary higher than 50000
SELECT * 
FROM employees
WHERE salary > 50000;
+--------+----------+---------+------+
| emp_id | emp_name | salary  | age  |
+--------+----------+---------+------+
|     30 | jenny    |   89000 | 54   |
|     40 | max      |   65000 | 18   |
+--------+----------+---------+------+
2 rows in set (0.001 sec)

```

```sql
-- get employees older than 70 years old
SELECT *
FROM employees
WHERE age > 70;
+--------+----------+---------+------+
| emp_id | emp_name | salary  | age  |
+--------+----------+---------+------+
|     10 | alex     |   45000 | 74   |
+--------+----------+---------+------+
```

```sql
-- get teenage employees 
SELECT *
FROM employees
WHERE age < 20;
+--------+----------+---------+------+
| emp_id | emp_name | salary  | age  |
+--------+----------+---------+------+
|     40 | max      |   65000 | 18   |
+--------+----------+---------+------+
```


#### 7. Definitions of PK and FK

		PK = Primary Key
		FK = Foreign Key

		Give a simple definitions of PK and FK with 2 
		simple tables and some rows, and talk about 
		violation when you try to insert the same PK. 

		Here’s a very simple MySQL example that defines 
		Primary Key (PK) and Foreign Key (FK) using two 
		small tables.

⸻

##### 7.1 Create the Tables

```mysql
-- Departments table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,          -- PK
    dept_name VARCHAR(50)
);

-- Employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,           -- PK
    emp_name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)   -- FK
);
```

⸻

##### 7.2 Insert Some Rows

```sql
-- Insert departments
INSERT INTO departments VALUES (1, 'Engineering');
INSERT INTO departments VALUES (2, 'Marketing');

-- Insert employees (dept_id must exist in departments)
INSERT INTO employees VALUES (101, 'Alice', 1);
INSERT INTO employees VALUES (102, 'Bob', 2);
```

At this point:

			•	departments.dept_id is the Primary Key (PK) → 
			must be unique and not NULL.
			
			•	employees.emp_id is also a Primary Key (PK).
			
			•	employees.dept_id is a Foreign Key (FK) → 
			must match a valid dept_id in departments.

⸻

#### 7.3 Example of PK Violation

```sql
-- Try inserting another employee with emp_id=101 (already exists)
INSERT INTO employees VALUES (101, 'Charlie', 1);
```

❌ This will fail:


		ERROR 1062 (23000): Duplicate entry '101' for key 'employees.PRIMARY'


Because `emp_id=101` is already used → Primary Key must be unique.

⸻

#### 7.4 Example of FK Violation

```sql
-- Try inserting employee into dept_id=99 (does not exist)
INSERT INTO employees VALUES (103, 'David', 99);
```

❌ This will fail:

		ERROR 1452 (23000): Cannot add or update a child row: a 
		foreign key constraint fails

Because `99` is not a valid `dept_id` in the departments table.

⸻

#### 8. Example on PK and FK


		Here’s a very simple MySQL example showing how to 
		define a Primary Key (PK) and a Foreign Key (FK) 
		between departments and employees tables:

NOTE: comments in SQL begins with `--`

```sql
-- Departments table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,          -- PK
    dept_name VARCHAR(50) NOT NULL
);

-- Employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,           -- PK
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    dept_id INT,                      -- FK
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
```

⸻

✅ Explanation

		•	departments.dept_id is the Primary Key (PK) 
		of the departments table.
	
		•	employees.emp_id is the Primary Key (PK) 
		of the employees table.
		
		•	employees.dept_id is a Foreign Key (FK) that 
		references departments.dept_id
		
		•	This ensures an employee can only belong 
		to a valid department.
		
		•	If you try to insert an employee with a non-existent 
		dept_id, MySQL will reject it.

⸻

Example Inserts

```sql
INSERT INTO departments 
VALUES (1, 'Engineering'), (2, 'Marketing');

INSERT INTO employees VALUES (101, 'Alice', 'Smith', 1);
INSERT INTO employees VALUES (102, 'Bob', 'Johnson', 2);

-- Thefollowing INSERT statement will fail 
-- because dept_id=99 does not exist in departments
INSERT INTO employees VALUES (103, 'Eve', 'Adams', 99);
```

⸻

#### 9. Changing Metadata

		If I have an employee table, and name of a column 
		is "salaray" and I want to change it to "salary",
		then we do the following:

			ALTER TABLE employees RENAME COLUMN salaray TO salary;

#### 10. SELECT *

Not that "*" refers to all of the columns in your table.

#### 11. Count number of rows for a Table:

```sql
SELECT COUNT(*)
FROM employees;
```

OR

```sql
SELECT COUNT(*) as num_of_emps
FROM employees;
```


#### 12. Filtering rows: use WHERE clause

```sql
-- select employees with salary of higher than 78000
SELECT *
FROM employees
WHERE salary > 78000;
```

#### 13. Sorting result of a SQL query

##### 13.1 select an employee with highest salary 

```sql
-- order salary from highest to lowest
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 1;
```

##### 13.2 select an employee with lowest salary 

```sql
-- order salary from lowest  to highest
SELECT *
FROM employees
ORDER BY salary ASC
LIMIT 1;
```

