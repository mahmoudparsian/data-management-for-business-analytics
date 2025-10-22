Consider the following table:

teachers (id, first_name, last_name, degree, school, department, hire_year, hire_date, salary, country)

1. Create a MySQL schema for this table.

2. The degree can be in {"PHD", "MS", "MD", "MBA"}

3. The country can be in {"USA", "CANADA", "FRANCE", "GERMANY", "SPAIN", "MEXICO", "ITALY", "UK"}

4. Assume that we have only 5 schools:

	1. ISU 
	2. SCU
	3. Stanford
	4. Harvard
	5. MIT

5. Keep salary as an INTEGER data type

6. Assume that we have 6 departments

	1. Engineering
	2. Computer Science
	3. Business
	4. Accounting
	5. Bio Informatics
	6. Data Science

7. Assume that salary range is from 100000 to 200000

8. Assume that hire date is from 1/1/2000 to 10/1/2025

9. Create 10,000 records with the assumptions mentioned: create a CSV file
as well as SQL INSERT statements (CSV as a separate file)(SQL INSERT a separate file)

10. Provide  20 English/SQL interesting and meaningful 
    queries using basic SELECT/INSERT/UPDATE/DELETE
    (markdown format)

11. Provide  20 English/SQL queries using basic SELECT/GROUP BY/Aggregation 
   functions such as COUNT(), SUM(), AVG(), ...
   (markdown format)

12. Provide  20 English/SQL queries using basic GROUP BY, sub-queries using WITH,
    and RANKING functions
    (markdown format)
    
Give all of these in a downloadable zip file.

Did I miss anything?

Thank you!


Awesome brief — I built everything exactly to your spec and bundled it up for you. 🙌

📦 Download the full package:
teachers_bundle.zip → contains schema, 10k-row CSV + INSERTs, and 60 queries in 3 Markdown files
Download

What’s inside
	1.	MySQL schema (schema.sql)

	•	Uses ENUM for controlled values (degree, school, department, country)
	•	salary is INT
	•	hire_year + hire_date with checks (ranges and hire_year = YEAR(hire_date))

	2.	10,000 records (realistic synthetic)

	•	teachers.csv — ready for LOAD DATA INFILE
	•	teachers_inserts.sql — batched INSERT statements (500 per batch) for performance

	3.	Markdown query packs (20 each = 60 total)

	•	queries_basic_dml.md — SELECT/INSERT/UPDATE/DELETE
	•	queries_groupby_agg.md — GROUP BY + COUNT/SUM/AVG/MIN/MAX + HAVING
	•	queries_with_rank.md — WITH (CTEs), subqueries, window functions (ROW_NUMBER, RANK, DENSE_RANK, NTILE)

Example snippets

Schema

CREATE TABLE teachers (
  id INT PRIMARY KEY,
  first_name VARCHAR(40) NOT NULL,
  last_name  VARCHAR(40) NOT NULL,
  degree ENUM('PHD','MS','MD','MBA') NOT NULL,
  school ENUM('ISU','SCU','Stanford','Harvard','MIT') NOT NULL,
  department ENUM('Engineering','Computer Science','Business','Accounting','Bio Informatics','Data Science') NOT NULL,
  hire_year INT NOT NULL,
  hire_date DATE NOT NULL,
  salary INT NOT NULL,
  country ENUM('USA','CANADA','FRANCE','GERMANY','SPAIN','MEXICO','ITALY','UK') NOT NULL,
  CHECK (salary BETWEEN 100000 AND 200000),
  CHECK (hire_year BETWEEN 2000 AND 2025),
  CHECK (hire_year = YEAR(hire_date))
);

CTE + RANK example (top earner per school)

WITH ranked AS (
  SELECT school, first_name, last_name, salary,
         RANK() OVER (PARTITION BY school ORDER BY salary DESC) AS rnk
  FROM teachers
)
SELECT school, first_name, last_name, salary
FROM ranked WHERE rnk = 1;

GROUP BY + HAVING example

SELECT country, AVG(salary) AS avg_salary
FROM teachers
GROUP BY country
HAVING AVG(salary) > 160000;


⸻

Did you miss anything?

You’re in great shape. Optional add-ons I can include if you want:
	•	LOAD DATA INFILE ready scripts for super-fast CSV import.
	•	Teaching slide deck (Markdown → PPTX) introducing the dataset + query patterns.
	•	Instructor solutions pack with expected output patterns for the queries.

If any of those sound helpful, say the word and I’ll generate them to match this dataset. ￼

    