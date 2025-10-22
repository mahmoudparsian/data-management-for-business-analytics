# Teaching Slides: Teachers Dataset

---
## Slide 1: Title
**Introduction to the Teachers Database**  
A synthetic dataset for learning SQL with MySQL.

---
## Slide 2: Learning Objectives
- Understand relational schema (1 table: teachers)
- Learn how to import/export data
- Practice basic SQL (SELECT, INSERT, UPDATE, DELETE)
- Explore GROUP BY and Aggregation
- Apply Subqueries and WITH
- Use Window Functions for Ranking

---
## Slide 3: Schema Overview
**Table: teachers**
- id (INT, PK)
- first_name, last_name (VARCHAR)
- degree (ENUM: PHD, MS, MD, MBA)
- school (ENUM: ISU, SCU, Stanford, Harvard, MIT)
- department (6 values)
- hire_year (2000–2025)
- hire_date (DATE)
- salary (100,000–200,000)
- country (8 countries)

---
## Slide 4: Example Records
| id | first_name | last_name | degree | school   | department      | hire_year | hire_date   | salary | country |
|----|------------|-----------|--------|----------|----------------|-----------|-------------|--------|---------|
| 1  | Ava        | Smith     | PHD    | MIT      | Engineering    | 2020      | 2020-08-15  | 160000 | USA     |
| 2  | Liam       | Johnson   | MS     | Harvard  | Business       | 2022      | 2022-01-20  | 145000 | UK      |

---
## Slide 5: Importing Data
- **Option 1:** `LOAD DATA INFILE`
```sql
LOAD DATA INFILE '/path/to/teachers.csv'
INTO TABLE teachers
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```
- **Option 2:** Use provided `teachers_inserts.sql`.

---
## Slide 6: Exporting Data
- Export to CSV:
```sql
SELECT * FROM teachers
INTO OUTFILE '/tmp/teachers_out.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
```

---
## Slide 7: Basic Queries (SELECT)
```sql
SELECT first_name, last_name, salary
FROM teachers
WHERE school = 'MIT'
LIMIT 5;
```

---
## Slide 8: Filtering Data
```sql
SELECT first_name, last_name, salary
FROM teachers
WHERE country = 'USA' AND salary > 150000;
```

---
## Slide 9: Sorting Results
```sql
SELECT first_name, last_name, salary
FROM teachers
ORDER BY salary DESC
LIMIT 10;
```

---
## Slide 10: INSERT Example
```sql
INSERT INTO teachers
(id, first_name, last_name, degree, school, department, hire_year, hire_date, salary, country)
VALUES (10001, 'Ada', 'Lovelace', 'PHD', 'MIT', 'Computer Science', 2024, '2024-09-01', 180000, 'UK');
```

---
## Slide 11: UPDATE Example
```sql
UPDATE teachers
SET salary = salary * 1.05
WHERE department = 'Engineering';
```

---
## Slide 12: DELETE Example
```sql
DELETE FROM teachers
WHERE id = 10001;
```

---
## Slide 13: Aggregation - COUNT
```sql
SELECT country, COUNT(*) AS num_teachers
FROM teachers
GROUP BY country;
```

---
## Slide 14: Aggregation - AVG
```sql
SELECT school, AVG(salary) AS avg_salary
FROM teachers
GROUP BY school;
```

---
## Slide 15: HAVING vs WHERE
```sql
-- Only groups with average salary > 160k
SELECT country, AVG(salary) AS avg_salary
FROM teachers
GROUP BY country
HAVING AVG(salary) > 160000;
```

---
## Slide 16: Subquery Example
```sql
SELECT first_name, last_name, salary
FROM teachers
WHERE salary > (SELECT AVG(salary) FROM teachers);
```

---
## Slide 17: WITH Example (CTE)
```sql
WITH dept_avg AS (
  SELECT department, AVG(salary) AS avg_sal
  FROM teachers
  GROUP BY department
)
SELECT t.first_name, t.last_name, t.department, t.salary
FROM teachers t
JOIN dept_avg d ON t.department = d.department
WHERE t.salary > d.avg_sal;
```

---
## Slide 18: Window Function Example
```sql
SELECT department, first_name, last_name, salary,
       ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn
FROM teachers;
```

---
## Slide 19: Ranking Example
```sql
WITH ranked AS (
  SELECT school, first_name, last_name, salary,
         RANK() OVER (PARTITION BY school ORDER BY salary DESC) AS rnk
  FROM teachers
)
SELECT * FROM ranked WHERE rnk = 1;
```

---
## Slide 20: Wrap-Up
- Dataset covers 10,000 teachers
- Practice progression:
  1. Basic DML
  2. Aggregations & GROUP BY
  3. Subqueries & WITH
  4. Window functions & ranking
- Use queries as labs!
