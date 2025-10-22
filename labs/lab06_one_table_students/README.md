# MySQL Students Package
See data/, queries/, and starter_notebook.ipynb. Load with SQL inserts or CSV.

Consider the following table in MySQL:

CREATE TABLE students (
        student_id INT PRIMARY KEY,
        first_name VARCHAR(50) NOT NULL,
        last_name VARCHAR(50) NOT NULL,
        email VARCHAR(100) UNIQUE,
        date_of_birth DATE,
        major VARCHAR(50),
        country VARCHAR(20),
        gender VARCHAR(10),
        language VARCHAR(50)
);

1. we want to create 100 students by CSV and SQL INSERT.
I want the names of students to be as real as possible,
no last_name_1, last_name_2, ...
no first_name_1, first_name_2

2. date_of_birth: the year range can be from 1980 to 2000.

3. major can be in {"Business", "Computer Science", "Data Science", "Biology", "Math", "Finance"}

4. country can be in {"USA", "CANADA", "FRANCE", "INDIA", "CHINA", "GERMANY", "ITALY"}

5. gender can be in {"MALE", "FEMALE"}

6. language can be in {"ENGLISH", "FRENCH", "SPANISH", "CHINESE", "GERMAN", "ITALIAN"}

7. Do not distribute data evenly among countries and languages, and gender

8. English/SQL Queries: present these in markdown format: for students and instructor
   -- Come up with 20 basic  English/SQL queries
   -- Come up with 20 basic-to-intermediate  English/SQL queries
   -- Come up with 20 intermediate  English/SQL queries

9. Include a starter Jupyter notebook for this data

All of these in one single downloadable zip file.

All set ✅

I generated a complete package with:
	•	data/students.csv (100 realistic students)
	•	data/students.sql (matching SQL INSERTs)
	•	queries/students/*.md (English-only: basic, basic_intermediate, intermediate — 20 each)
	•	queries/instructor/*.md (same prompts with SQL answers — 20 each)
	•	create_students.sql (table schema)
	•	starter_notebook.ipynb (connects to MySQL, loads the CSV, runs sample queries)
	•	README.md (quick load instructions)

📦 Download: mysql_students_package.zip

If you want any tweaks (e.g., shift the country/language distribution, add more majors, or include additional query tiers like advanced/CTE-only), say the word and I’ll regenerate. ￼

