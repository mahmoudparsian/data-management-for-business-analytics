# Lab 1: Schema and Data

---
## Step 1: Create a Database

```sql
CREATE DATABASE company101;
USE company101;
```

---
## Step 2: Create Tables

### Departments Table

```sql
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);
```

### Employees Table

```sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT
    -- FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
```

### Projects Table

```sql
CREATE TABLE projects (
    proj_id INT PRIMARY KEY,
    proj_name VARCHAR(50),
    dept_id INT
    -- FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
```

---
## Step 3: Insert Sample Data

### Insert Departments

```sql
INSERT INTO departments VALUES
(1, 'Sales'),
(2, 'HR'),
(3, 'IT'),
(4, 'Business'),
(5, 'AI');
```

### Insert Employees
```sql
INSERT INTO employees VALUES
(101, 'Alice', 1),
(102, 'Bob', 2),
(103, 'Carol', 3),
(104, 'David', 1),
(105, 'Eve', 3),
(106, 'Max', 1),
(107, 'Jeff', 2),
(108, 'Adam', 1),
(109, 'Darya', 1),
(110, 'Diana', 4);
```

### Insert Projects
```sql
INSERT INTO projects VALUES
(201, 'Website Redesign', 3),
(202, 'Recruitment Drive', 2),
(203, 'Sales Expansion', 1),
(301, 'Data Modeling', 3),
(302, 'Sport Activities', 2),
(303, 'AI LLM', 2);
```

