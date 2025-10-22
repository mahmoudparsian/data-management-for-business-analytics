# Employees : as a single table

We have 200 Employees 

## 1. Employees


~~~
emp_id, first name, last_name, age, degree, gender, country, department, hire_date, salary
~~~

* age range should be from 18 to 78

* assume gender has 2 possible values: MALE and FEMALE (please do not use ENUM)

* assume degree has 4 possible values: BS, MS, MSIS, MBA, and PHD (please do not use ENUM)

* assume that country has 8 possible values: (please do not use ENUM)
USA, CANADA, MEXICO, ITALY, FRANCE, GERMANY, INDIA, CHINA

* assume that hire_date range is from 2020 to 2025

* assume that salary (as an integer) range is from 60000 to 160000

* department possible values are : HR, IT, Engineering, Business, Marketing, Finance 
  (please do not use ENUM)


## Tasks

The tasks we want to do are:

1. Define a mysql database schema, which covers our data story: 
lets keep everything as simple as possible

2. Populate the employees table by CSV file 
   and SQL INSERT statements (also show how load this by
   by LOAD LOCAL command)

3. This is meant for LAB exercises (5 labs in total) by senior 
undergraduate students, who they have installed mysql database, 
but do not have exposure to databases and sql. I want to have these 
labs as progressive (starting with real basic, then basic, the 
intermediate, then intermediate 2, then advanced).  

For each lab, I want 30 English/SQL queries. I want these queries 
to be meaningful and thoughtful (not just random queries).

* Lab-1: very basic

* Lab-2: basic, some intermediate (some GROUP BY)

* Lab-3: some intermediate, intermediate (some GROUP BY and aggregation functions)

* Lab-4: intermediate+

* Lab-5: intermediate to advanced

Please use markdown format for all of the lab SQL queries

Can you please give all of this in a downloadable zip file.


Perfect 👍 I can prepare this as a complete teaching package 
(MySQL schema, CSV + SQL INSERT data for 200 employees, 
ready-to-use LOAD DATA script, and 5 progressive lab files 
with 30 queries each, all in Markdown, zipped).

Here’s the plan:

⸻

✅ Deliverables
	1.	Schema (schema.sql)

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    degree VARCHAR(10),
    gender VARCHAR(6),
    country VARCHAR(20),
    department VARCHAR(20),
    hire_date DATE,
    salary INT
);


	2.	Data (200 employees)
	•	employees.csv – 200 rows with constraints:
	•	age: 18–78
	•	gender: MALE/FEMALE
	•	degree: BS/MS/MSIS/MBA/PHD
	•	country: USA, CANADA, MEXICO, ITALY, FRANCE, GERMANY, INDIA, CHINA
	•	department: HR, IT, Engineering, Business, Marketing, Finance
	•	hire_date: 2020–2025
	•	salary: 60,000–160,000
	•	employees_inserts.sql – equivalent INSERT statements.
	3.	LOAD DATA Script (load_data_infile.sql)

LOAD DATA LOCAL INFILE '/path/to/employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(emp_id, first_name, last_name, age, degree, gender, country, department, hire_date, salary);


	4.	Labs (Markdown, 5 files × 30 queries each)
	•	lab1_basics.md → very basic: SELECT, filters, ORDER BY, INSERT, UPDATE, DELETE.
	•	lab2_basic_intermediate.md → filters, DISTINCT, simple GROUP BY.
	•	lab3_intermediate.md → GROUP BY + aggregation functions (COUNT, SUM, AVG, MIN, MAX).
	•	lab4_intermediate_plus.md → INNER JOIN (self-join examples), subqueries, HAVING.
	•	lab5_advanced.md → WITH CTEs, RANK, DENSE_RANK, ROW_NUMBER.

⸻

📦 Everything will be packaged in one zip file:

mysql_employees_labs.zip
│ schema.sql
│ load_data_infile.sql
│ employees.csv
│ employees_inserts.sql
│
└── labs/
   ├── lab1_basics.md
   ├── lab2_basic_intermediate.md
   ├── lab3_intermediate.md
   ├── lab4_intermediate_plus.md
   └── lab5_advanced.md


⸻

All set! I’ve built your complete MySQL Employees (single-table) 
teaching package and bundled everything into one ZIP.

📦 Download: mysql_employees_labs.zip

What’s inside
	•	schema.sql – simple table definition for employees.
	•	employees.csv – 200 employees (age 18–78; gender MALE/FEMALE; degree in {BS, MS, MSIS, MBA, PHD}; country in {USA, CANADA, MEXICO, ITALY, FRANCE, GERMANY, INDIA, CHINA}; department in {HR, IT, Engineering, Business, Marketing, Finance}; hire_date 2020–2025; salary 60k–160k).
	•	employees_inserts.sql – matching INSERT statements.
	•	load_data_infile.sql – ready-to-run LOAD DATA LOCAL INFILE script (just swap in your absolute path if needed).
	•	labs/ (5 Markdown files, 30 queries each, progressive difficulty)
	•	lab1_very_basic.md – essentials (SELECT, WHERE, ORDER BY, INSERT/UPDATE/DELETE demos).
	•	lab2_basic_intermediate.md – DISTINCT, CASE, GROUP BY, HAVING, buckets.
	•	lab3_intermediate.md – aggregation patterns, multi-attribute grouping, percent-of-total.
	•	lab4_intermediate_plus.md – CTEs (WITH), window functions (ROW_NUMBER, RANK, DENSE_RANK), shares, z-scores, percentiles (NTILE).
	•	lab5_advanced.md – deeper window analytics, top-k per partition, quartiles/deciles, outliers, combined CTE logic.

If you want me to add expected outputs for a subset of queries 
(e.g., 5–10 per lab) or convert the Markdown labs into PowerPoint 
for presentation, say the word and I’ll include an instructor pack.


