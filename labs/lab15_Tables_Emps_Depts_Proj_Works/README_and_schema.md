# MySQL 101 : 4 tables

	1. employees
	
	2. departments
	
	3. projects
	
	4. workdays
	



	✅ MySQL 101: a student has just installed MySQL and wants 
	some practice with sql queries: let’s build a database with 
	4 tables: departments, employees (an employee works for one 
	department), projects, and workdays ( links employees with 
	projects, an employee can work on one or more projects). 
	
	Employee attributes are 
	
	     id, name, dept_id, hire_date, gender, country, age. 
	
	Departments table has 2 attributes: 
	
	     dept_id and dept_name. 
	
	Projects have 2 attributes: 
	
	     project_id, project_name. 
	
	Finally workdays have the following attributes: 
	
	    work_id, emp_id, project_id, start_date, end_date. 
	
	All of this is to be done in MySQL. 
	
	1. Define schema, then provide sample records by sql insert, then 
	provide 20 basic English SQL queries, then 20 queries from basic 
	to intermediate, 20 intermediate+, and finally 20 intermediate ++ 
	using sub queries using “with” and ranking functions: all in markdown 
	format 



	🧩 We re now ready for a **more realistic dataset** that makes 
	your MySQL 101 lab feel like a real company database. 

Below is a **complete set of meaningful insert statements** 
(no nonsense or random names) for: 

✅ 9 departments 

✅ 32 employees 

✅ 12 projects 

✅ 50 workdays 

All values are clean, logically consistent, and reflect realistic scenarios 
(hire dates, genders, countries, etc.). 

---

# 🧩 MySQL 101 — Meaningful Dataset Expansion

Assume your schema from earlier already exists:

```sql
CREATE DATABASE company_db;

USE company_db;
```


## Departments table

```sql
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);
```


## Employees table

```sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    hire_date DATE,
    gender CHAR(1),
    country VARCHAR(50),
    age INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
```


## Projects table

```sql
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50)
);
```


## Workdays table (linking employees and projects)

```sql
CREATE TABLE workdays (
    work_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    project_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);
```


## Data Population


---

### 🏢 1️⃣ Departments

```sql
INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'Human Resources'),
(2, 'Information Technology'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Sales'),
(6, 'Customer Support'),
(7, 'Research & Development'),
(8, 'AI'),
(9, 'QA');
```

* Note: the last 2 departments are never used for any employees.
* this will be used in teaching left/right join concepts

---

### 👩‍💼 2️⃣ Employees (32 Records)

```sql
INSERT INTO employees 
(emp_id, name, dept_id, hire_date, gender, country, age) 
VALUES
(1, 'Alice Johnson', 1, '2016-02-15', 'F', 'USA', 34),
(2, 'Robert King', 2, '2018-03-12', 'M', 'Canada', 29),
(3, 'Maria Gonzalez', 3, '2017-07-09', 'F', 'Spain', 41),
(4, 'David Chen', 2, '2020-01-25', 'M', 'China', 32),
(5, 'Emma Brown', 4, '2019-11-10', 'F', 'UK', 27),
(6, 'Michael Lee', 5, '2015-09-20', 'M', 'USA', 45),
(7, 'Sophia Patel', 1, '2021-04-14', 'F', 'India', 26),
(8, 'James Wilson', 6, '2018-06-05', 'M', 'USA', 38),
(9, 'Isabella Rossi', 4, '2020-08-19', 'F', 'Italy', 31),
(10, 'William Scott', 2, '2017-05-03', 'M', 'UK', 33),
(11, 'Olivia Davis', 7, '2022-03-01', 'F', 'USA', 28),
(12, 'Liam Martinez', 3, '2019-12-15', 'M', 'Mexico', 37),
(13, 'Charlotte Green', 4, '2016-09-10', 'F', 'Canada', 35),
(14, 'Benjamin Wright', 2, '2020-10-21', 'M', 'USA', 30),
(15, 'Amelia Thompson', 7, '2021-01-09', 'F', 'Australia', 29),
(16, 'Ethan Walker', 6, '2018-07-17', 'M', 'USA', 40),
(17, 'Grace Kim', 3, '2017-02-11', 'F', 'South Korea', 36),
(18, 'Jacob Robinson', 5, '2019-09-05', 'M', 'USA', 42),
(19, 'Mia Perez', 4, '2020-12-23', 'F', 'Argentina', 33),
(20, 'Lucas Brown', 2, '2021-02-16', 'M', 'USA', 27),
(21, 'Harper Adams', 6, '2019-05-11', 'F', 'UK', 39),
(22, 'Elijah Clark', 7, '2022-05-25', 'M', 'USA', 31),
(23, 'Ella Rivera', 5, '2018-10-10', 'F', 'Brazil', 37),
(24, 'Daniel White', 1, '2016-03-30', 'M', 'USA', 43),
(25, 'Ava Mitchell', 3, '2020-07-22', 'F', 'USA', 29),
(26, 'Henry Parker', 2, '2017-08-14', 'M', 'Canada', 34),
(27, 'Chloe Turner', 4, '2018-01-09', 'F', 'USA', 32),
(28, 'Jack Hall', 6, '2020-11-01', 'M', 'UK', 28),
(29, 'Zoe Allen', 7, '2021-09-13', 'F', 'USA', 25),
(30, 'Noah Murphy', 5, '2019-02-28', 'M', 'Ireland', 38),
(31, 'Carlos Taylor', 7, '2022-05-25', 'M', 'Mexico', 31),
(32, 'Rafa Martinez', 5, '2018-10-10', 'M', 'Mexico', 37);
```

* Note: the last 2 employees are never used for any projects.
* this will be used in teaching left/right join concepts

---

### 🚀 3️⃣ Projects (12 Records)

```sql
INSERT INTO projects (project_id, project_name) VALUES
(1, 'Website Redesign'),
(2, 'Cloud Infrastructure Migration'),
(3, 'Payroll Automation'),
(4, 'Customer Feedback System'),
(5, 'Mobile App Launch'),
(6, 'Quarterly Financial Analysis'),
(7, 'Product Marketing Campaign'),
(8, 'Sales Data Dashboard'),
(9, 'Customer Support Chatbot'),
(10, 'AI Product Research'),
(11, 'Genomics'),
(12, 'Robotics');
```

* Note: the last 2 projects are never used for any workdays.
* this will be used in teaching left/right join concepts

---

### 🗓️ 4️⃣ Workdays (50 Records)

Each employee works on one or more projects. 
The dates are realistic and spread across 2023–2024.

```sql
INSERT INTO workdays (emp_id, project_id, start_date, end_date) 
VALUES
(1, 1, '2023-01-10', '2023-03-15'),
(1, 5, '2023-04-01', '2023-06-30'),
(2, 2, '2023-02-05', '2023-05-20'),
(3, 6, '2023-03-10', '2023-06-30'),
(4, 2, '2023-04-15', '2023-07-25'),
(5, 7, '2023-02-01', '2023-04-10'),
(6, 8, '2023-01-12', '2023-04-15'),
(7, 1, '2023-05-05', '2023-08-01'),
(8, 9, '2023-03-01', '2023-06-10'),
(9, 5, '2023-02-20', '2023-05-15'),
(10, 2, '2023-03-25', '2023-06-10'),
(11, 10, '2023-05-10', '2023-09-15'),
(12, 6, '2023-04-20', '2023-07-05'),
(13, 7, '2023-01-18', '2023-03-25'),
(14, 2, '2023-06-01', '2023-08-20'),
(15, 10, '2023-02-25', '2023-05-30'),
(16, 9, '2023-04-15', '2023-07-01'),
(17, 6, '2023-03-10', '2023-06-20'),
(18, 8, '2023-01-05', '2023-03-30'),
(19, 7, '2023-04-12', '2023-07-01'),
(20, 2, '2023-05-10', '2023-07-25'),
(21, 9, '2023-03-20', '2023-05-25'),
(22, 10, '2023-06-15', '2023-09-10'),
(23, 8, '2023-02-12', '2023-05-20'),
(24, 1, '2023-04-05', '2023-06-15'),
(25, 3, '2023-05-01', '2023-07-20'),
(26, 2, '2023-03-18', '2023-06-01'),
(27, 7, '2023-02-28', '2023-05-05'),
(28, 9, '2023-03-10', '2023-06-30'),
(29, 10, '2023-01-20', '2023-04-25'),
(30, 8, '2023-05-12', '2023-08-01'),
(1, 3, '2024-01-10', '2024-03-30'),
(2, 5, '2024-02-15', '2024-05-10'),
(3, 8, '2024-03-01', '2024-06-15'),
(4, 6, '2024-01-05', '2024-04-30'),
(5, 7, '2024-02-01', '2024-05-01'),
(6, 9, '2024-03-12', '2024-06-10'),
(7, 10, '2024-04-01', '2024-07-25'),
(8, 2, '2024-01-20', '2024-03-25'),
(9, 5, '2024-03-10', '2024-06-20'),
(10, 1, '2024-02-05', '2024-04-15'),
(11, 8, '2024-04-15', '2024-07-01'),
(12, 9, '2024-05-10', '2024-08-20'),
(13, 6, '2024-01-18', '2024-03-30'),
(14, 4, '2024-03-05', '2024-06-01'),
(15, 7, '2024-02-10', '2024-04-30'),
(16, 10, '2024-01-15', '2024-03-20'),
(17, 3, '2024-02-20', '2024-04-15'),
(18, 5, '2024-04-10', '2024-07-05'),
(19, 4, '2024-01-05', '2024-03-10'),
(20, 2, '2024-03-15', '2024-06-10');
```

---

## Created Tables in `company_db`:

```
mysql> show tables;
+----------------------+
| Tables_in_company_db |
+----------------------+
| departments          |
| employees            |
| projects             |
| workdays             |
+----------------------+
4 rows in set (0.00 sec)
```


✅ **Total Data Generated:**
- Departments: 9 
- Employees: 32 
- Projects: 12 
- Workdays: 50 


## SQL Queries

- 🟢 **50 Basic Queries** (simple SELECT, filters, sorting) 
- 🟡 **46 Intermediate Queries** (joins, grouping, aggregates) 
- 🟠 **10 Intermediate+ Queries** (more complex joins, conditions, HAVING) 
- 🔵 **10 Advanced Queries** (using `WITH` and ranking functions) 

👉 All in **Markdown**, with English description + SQL.


## 📝 Summary of Learning Progression

| Level               | Skills Practiced                                     |
|----------------------|-----------------------------------------------------|
| 🟢 Basic              | SELECT, WHERE, ORDER BY, COUNT, LIMIT                |
| 🟡 Intermediate       | INNER JOIN, GROUP BY, aggregates                     |
| 🟠 Intermediate+      | HAVING, multi-table joins, subqueries               |
| 🔵 Advanced           | WITH CTEs, RANK, window functions, top-N queries    |

---