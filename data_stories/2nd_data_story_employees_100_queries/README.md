# Employees Package: 
# data story employees 100 queries

## Database Schema: employees 

Consider the following database table called employees:

```sql
CREATE TABLE employees (
  emp_id       INT,
  first_name   VARCHAR(60),
  last_name    VARCHAR(60),
  department   VARCHAR(20),
  gender       VARCHAR(10),
  country      VARCHAR(10),
  salary       INT,
  age          INT,
  date_joined  DATE
);
```

1. Verify schema in MySQL

2. Assume that we have 5 departments: Business, Marketing, Engineering, IT, AI

3. Assume that we have 5 countries: USA, CANADA, INDIA, CHINA, GERMANY

4. date_joined should be from 01/01/2020 to NOW

5. Age can be from 20 to 80

6. Gender is in {MALE, FEMALE}, no ENUM should be used.

7. Create 50 employees: with real names, do not have even number 
   of employees per country or department

8. Create 40 basic/simple English/SQL queries 
   (SELECT, FILTER, ORDER ASC, ORDER DESC, WHERE, some GROUP BY)(separate file)

9. Create 30 basic-to-intermediate English/SQL queries 
   (GROUP BY and Aggregation functions)(separate file)

10. Create 30 intermediate English/SQL queries 
    (sub-queries using WITH and all ranking functions)(separate file)

11. All in markdown format 

12. Python program for data exploration and visualization

13. Jupyter notebook with the same content as 12


## Contents:

- `employees_schema.sql` — Table DDL + verification commands

- `employees_inserts.sql` — 50 rows, uneven across departments & countries

- `queries_basic.md` — 40 basic/simple queries

- `queries_groupby.md` — 30 group-by & aggregation queries

- `queries_window.md` — 30 intermediate queries using CTEs and window functions

- `employees_exploration.py` — Data exploration & charts (matplotlib)

- `employees_exploration.ipynb` — Notebook version of the exploration


## Quickstart

1) Create table and insert data:

```sql
SOURCE employees_schema.sql;
SOURCE employees_inserts.sql;
```

2) Run queries by opening the markdown files and copy-paste the SQL blocks.

3) Python exploration:
```bash
python employees_exploration.py
```
Generates PNGs in the working directory:

- `headcount_by_department.png`
- `avg_salary_by_department.png`
- `headcount_by_country.png`
- `salary_distribution.png`
- `age_vs_salary.png`
