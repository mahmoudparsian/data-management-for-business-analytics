I have a Small Sample employee database in MySQL.

The 6 Tables are:

employee
department
dept_manager
dept_emp
title
salary

1. Provide 5 basic SQL queries and associated SQL for mySQL

2. Provide 5 intermediate SQL queries and associated SQL for mySQL

3. Provide 5 intermediate SQL queries and associated SQL using 
   sub-queries (use WITH) and ranking functions for mySQL
   

CREATE TABLE employee (
    emp_no      INT             NOT NULL,
    birth_date  DATE            NOT NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    gender      ENUM ('M','F')  NOT NULL,    
    hire_date   DATE            NOT NULL,
    PRIMARY KEY (emp_no)
);

CREATE TABLE department (
    dept_no     CHAR(4)         NOT NULL,
    dept_name   VARCHAR(40)     NOT NULL,
    PRIMARY KEY (dept_no),
    UNIQUE  KEY (dept_name)
);

CREATE TABLE dept_manager (
   emp_no       INT             NOT NULL,
   dept_no      CHAR(4)         NOT NULL,
   from_date    DATE            NOT NULL,
   to_date      DATE            NOT NULL,
   FOREIGN KEY (emp_no)  REFERENCES employee (emp_no)    ON DELETE CASCADE,
   FOREIGN KEY (dept_no) REFERENCES department (dept_no) ON DELETE CASCADE,
   PRIMARY KEY (emp_no,dept_no)
); 

CREATE TABLE dept_emp (
    emp_no      INT             NOT NULL,
    dept_no     CHAR(4)         NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    FOREIGN KEY (emp_no)  REFERENCES employee   (emp_no)  ON DELETE CASCADE,
    FOREIGN KEY (dept_no) REFERENCES department (dept_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no,dept_no)
);

CREATE TABLE title (
    emp_no      INT             NOT NULL,
    title       VARCHAR(50)     NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE,
    FOREIGN KEY (emp_no) REFERENCES employee (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no,title, from_date)
) 
; 

CREATE TABLE salary (
    emp_no      INT             NOT NULL,
    amount      INT             NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employee (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no, from_date)
) 
; 

CREATE OR REPLACE VIEW dept_emp_latest_date AS
    SELECT emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM dept_emp
    GROUP BY emp_no;

# shows only the current department for each employee
CREATE OR REPLACE VIEW current_dept_emp AS
    SELECT l.emp_no, dept_no, l.from_date, l.to_date
    FROM dept_emp d
        INNER JOIN dept_emp_latest_date l
        ON d.emp_no=l.emp_no AND d.from_date=l.from_date AND l.to_date = d.to_date;


# SQL Queries

We organize the solution into three parts:

---

## 1. Basic SQL Queries

These are straightforward SELECT and JOIN examples.

**Query 1 – List all employees**

```sql
SELECT emp_no, 
       first_name, 
       last_name, 
       gender, 
       hire_date
FROM employee;
```

**Query 2 – List all departments**

```sql
SELECT dept_no, 
       dept_name
FROM department;
```

**Query 3 – Show all managers and their departments**

```sql
SELECT e.first_name, 
       e.last_name, 
       d.dept_name
FROM dept_manager m
JOIN employee e ON m.emp_no = e.emp_no
JOIN department d ON m.dept_no = d.dept_no;
```

**Query 4 – Get salary history of a specific employee (e.g., emp\_no = 10001)**

```sql
SELECT 
       s.emp_no, 
       s.amount, 
       s.from_date, 
       s.to_date
FROM salary s
WHERE emp_no = 10001;
```

**Query 5 – Find all employees currently assigned to a department**

```sql
SELECT e.first_name, 
       e.last_name, 
       d.dept_name
FROM current_dept_emp c
JOIN employee e ON c.emp_no = e.emp_no
JOIN department d ON c.dept_no = d.dept_no;
```

---

## 2. Intermediate SQL Queries

These add grouping, filtering, and aggregations.

**Query 6 – Count employees per department**

```sql
SELECT d.dept_name, 
       COUNT(c.emp_no) AS num_employees
FROM current_dept_emp c
JOIN department d ON c.dept_no = d.dept_no
GROUP BY d.dept_name;
```

**Query 7 – Find the average salary per department**

```sql
SELECT d.dept_name, 
       AVG(s.amount) AS avg_salary
FROM current_dept_emp c
JOIN salary s ON c.emp_no = s.emp_no
JOIN department d ON c.dept_no = d.dept_no
GROUP BY d.dept_name;
```

**Query 8 – Employees hired after 2015**

```sql
SELECT emp_no, 
       first_name, 
       last_name, 
       hire_date
FROM employee
WHERE hire_date > '2015-01-01';
```

**Query 9 – Highest salary for each department**

```sql
SELECT d.dept_name, 
       MAX(s.amount) AS max_salary
FROM current_dept_emp c
JOIN salary s ON c.emp_no = s.emp_no
JOIN department d ON c.dept_no = d.dept_no
GROUP BY d.dept_name;
```

**Query 10 – Find departments without employees**

```sql
SELECT d.dept_name
FROM department d
LEFT JOIN current_dept_emp c ON d.dept_no = c.dept_no
WHERE c.emp_no IS NULL;
```

---

## 3. Intermediate SQL Queries with Subqueries (CTEs) and Ranking

These use `WITH` and window functions (MySQL 8+).

**Query 11 – Rank employees by salary within their department**

```sql
WITH ranked AS (
  SELECT e.emp_no, e.first_name, e.last_name, d.dept_name,
         s.amount,
         RANK() OVER (PARTITION BY d.dept_name ORDER BY s.amount DESC) AS rnk
  FROM current_dept_emp c
  JOIN employee e ON c.emp_no = e.emp_no
  JOIN department d ON c.dept_no = d.dept_no
  JOIN salary s ON c.emp_no = s.emp_no
)
SELECT *
FROM ranked
WHERE rnk <= 3;   -- top 3 per department
```

**Query 12 – Find the second highest salary in each department**

```sql
WITH ranked AS (
  SELECT d.dept_name, s.amount,
         DENSE_RANK() OVER (PARTITION BY d.dept_name ORDER BY s.amount DESC) AS rnk
  FROM current_dept_emp c
  JOIN salary s ON c.emp_no = s.emp_no
  JOIN department d ON c.dept_no = d.dept_no
)
SELECT dept_name, amount
FROM ranked
WHERE rnk = 2;
```

**Query 13 – Employees with salary above department average**

```sql
WITH dept_avg AS (
  SELECT d.dept_no, AVG(s.amount) AS avg_salary
  FROM current_dept_emp c
  JOIN salary s ON c.emp_no = s.emp_no
  JOIN department d ON c.dept_no = d.dept_no
  GROUP BY d.dept_no
)
SELECT e.first_name, e.last_name, d.dept_name, s.amount
FROM current_dept_emp c
JOIN employee e ON c.emp_no = e.emp_no
JOIN department d ON c.dept_no = d.dept_no
JOIN salary s ON c.emp_no = s.emp_no
JOIN dept_avg a ON d.dept_no = a.dept_no
WHERE s.amount > a.avg_salary;
```

**Query 14 – Longest-serving employee in each department**

```sql
WITH ranked AS (
  SELECT d.dept_name, e.first_name, e.last_name, c.from_date,
         ROW_NUMBER() OVER (PARTITION BY d.dept_name ORDER BY c.from_date ASC) AS rnk
  FROM current_dept_emp c
  JOIN employee e ON c.emp_no = e.emp_no
  JOIN department d ON c.dept_no = d.dept_no
)
SELECT dept_name, first_name, last_name, from_date
FROM ranked
WHERE rnk = 1;
```

**Query 15 – Top 5 highest paid employees company-wide**

```sql
WITH ranked AS (
  SELECT e.emp_no, e.first_name, e.last_name, s.amount,
         ROW_NUMBER() OVER (ORDER BY s.amount DESC) AS rnk
  FROM employee e
  JOIN salary s ON e.emp_no = s.emp_no
)
SELECT emp_no, first_name, last_name, amount
FROM ranked
WHERE rnk <= 5;
```

---

✅ That gives you:

* 5 **basic** queries,
* 5 **intermediate** queries, and
* 5 **advanced queries with CTE + ranking**.

Would you like me to also **generate some sample data inserts** (a few rows for each table) so you can run and test all of these queries immediately?
