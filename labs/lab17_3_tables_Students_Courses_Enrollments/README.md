Consider the following 3 tables in MySQL:


CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    major VARCHAR(50),  -- major is in { "Business", "CS", "Engineering", "Law", "Finance", "AI" }
    country VARCHAR(10) -- country is in {"USA", "CANADA", "CHINA", "INDIA", "MEXICO", "FRANCE"}
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    instructor VARCHAR(50)
);

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

Scenarios:
    •    INNER JOIN → Show only students enrolled in courses.
    •    LEFT JOIN → Show all students, even if not enrolled in any course.
    •    RIGHT JOIN → Show all courses, even if no students have enrolled yet.




1. let's validate these schemas in MySQL database

2. Populate these 3 tables with CSV files as well as SQL INSERT statements:
There should be 

* 54 students (make sure the last 4 students have not taken any classes -- useful for join)

* 105 courses (make sure that the last 5 courses are never assigned to any students -- useful for join)

* 2000 enrollments

3. Prepare 5 labs, each having 25 queries of English and SQL

Lab-1: the most basic queries for primitives

Lab-2: basic to simple to intermediate

Lab-3: simple to intermediate: using GROUP BY and aggregation function, some basic joins

Lab-4: intermediate queries: using GROUP BY, inner join, left join, right join, 
       simple sub-queries using WITH, and simple ranking functions,
       
Lab-5: intermediate queries: using GROUP BY, sub-queries using WITH, and ranking functions

Prepare everything, labs in markdown format, data in CSV and SQL INSERT: all in one zip file.
Thanks.


Awesome — I built the full package with your students/courses/enrollments schema, realistic CSVs & INSERT scripts, and five labs (25 English+SQL queries each) showcasing INNER/LEFT/RIGHT JOIN scenarios, GROUP BY, WITH CTEs, and ranking functions.

📦 Download the bundle (everything in one ZIP)
mysql_students_courses_enrollments.zip

What’s inside
	•	schema.sql – ready-to-run DDL for:
	•	students(student_id, name, major, country)
	•	courses(course_id, course_name, instructor)
	•	enrollments(student_id, course_id) with PK + FKs
	•	data/
	•	students.csv – 54 rows (students 51–54 have no enrollments)
	•	courses.csv – 105 rows (courses 101–105 never enrolled)
	•	enrollments.csv – 2,000 unique (student_id, course_id) pairs using only students 1–50 & courses 1–100 (so the last student/course sets are reserved for join demos)
	•	inserts/
	•	students_inserts.sql
	•	courses_inserts.sql
	•	enrollments_inserts.sql (batched for performance)
	•	load_data_infile.sql – copy/paste scripts for fast CSV import (just swap in your absolute paths)
	•	labs/ (Markdown, 25 queries each)
	•	lab1_basics.md — primitives, filters, ORDER BY, simple DML, PK sanity checks
	•	lab2_basic_to_intermediate.md — CASE, IN/NOT IN, DISTINCT, anti-joins, first join use cases
	•	lab3_groupby_agg_joins.md — GROUP BY/HAVING, distinct-counts, multi-table aggregates
	•	lab4_intermediate_with_ranking.md — INNER/LEFT/RIGHT joins, WITH, ROW_NUMBER/DENSE_RANK/RANK, top-N per group
	•	lab5_with_ranking_advanced.md — more CTEs + analytics (shares, running totals, z-scores, top-k per partition)

If you want tweaks (e.g., custom instructor names, more/less enrollments, or adding expected-output notes for each lab), say the word and I’ll spin an updated pack.
