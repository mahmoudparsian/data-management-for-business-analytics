# Outline and Schedule

	This is a preliminary outline for the 
	course. It is expected to change during 
	the class period (10/22/2025-12/09/2025).

------

## 1. Saturday, October  25, 2025, 8:00 am - 12:30 pm (in-person)
```
1. Introductions (instructor and students) 

2. Syllabus review

3. Setting Up Your Coding/Database Environment

4. Installing MySQL Community Edition

5. Installing MySQL Workbench

6. TEXT Editor:
      MacBook : BBEdit
      Windows 10/11: Notepad
      
7. Installing Tableau

8. Basics of the relational data model: organizing and grouping data

9. Organizing and grouping data

10. Working MySQL install

11. Working Tableau install

12. Lab: Using SQL
```
-----

## 1. Text editor

```
Any text editor should work for the book’s purposes, 
so if you have a favorite, feel free to use it. Here are 
some I have used and recommend.

Use a free and available for macOS, Windows:

macbook:
   atom: https://atom.io/
   bbedit: https://www.barebones.com/products/bbedit

windows:
   Notepad (built in)
   Notepad++ (https://notepad-plusplus.org/ 
```

## 2. Installing MySQL Community Edition

```
https://dev.mysql.com/downloads/mysql

(i) then select your operating system: macOS
(ii) select OS Version:
                   ARM: apple chip
                   x86: intel chip
                   
then select your operating system: Microsoft Windows

MySQL Database USER: root
MySQL Database Password: <password> and remember it
```

## 3. MySQL Workbench

		MySQL Workbench is a unified visual tool for 
		database architects, developers, and DBAs. 
		
		MySQL Workbench provides data modeling, SQL 
		development, and comprehensive administration 
		tools for server configuration, user 
		administration, backup, and much more. 
		
		MySQL Workbench is available on Windows, and Mac OS X.


		https://dev.mysql.com/downloads/workbench

		(i) then select your operating system: macOS
		(ii) select OS Version:
                   ARM: apple chip
                   x86: intel chip
                   
		then select your operating system: Microsoft Windows
                  
  
## 4. After Installing MySQL and MySQL Workbench:

		Open MySQL Workbench, then execute:

			SELECT version();


                 
## 5. Python programming language

		Visit the official Python site at 
		https://www.python.org/ and click 
		the Downloads menu.

		https://www.python.org/downloads/release/python-3140

		look under Files...

		If you already have Python, then no need to install it


## 6. CREATING YOUR FIRST DATABASE AND TABLE

	SQL is more than just a means for
	extracting knowledge from data. 
	
	It’s also a language for defining the
	structures that hold data so we can
	organize relationships in the data. 
	
	MySQL Database Server = set of Databases
	
	a Database = set of Tables
	
	a Table = N rows x M columns
	
	Table name: enrollments
	4 columns: student_id   class_id   class_section semester
	
			student_id   class_id   class_section semester
			----------   ---------- ------------- ---------
			CHRISPA004   COMPSCI101    3          Fall 2023
			DAVISHE010   COMPSCI101    3          Fall 2023
			ABRILDA002   ENG101       40          Fall 2023
			DAVISHE010   ENG101       40          Fall 2023
			RILEYPH002   ENG101       40          Fall 2023	

    WHAT does this mean?
    
    This table shows that two students have signed up 
    for COMPSCI101, and

    three have signed up for ENG101. 
    
    But where are the details about each student and class? 
    
    In this example, these details are stored in separate t
    ables called students and classes, and those tables relate 
    to this one. This is where the power of a relational database 
    begins to show itself.
    
    students table:
    
           The first several rows of the students table 
           include the following:

                  student_id   first_name last_name   dob
                  ----------   ---------- ---------   ----------
                  ABRILDA002   Abril      Davis       2005-01-10
                  CHRISPA004   Chris      Park        1999-04-10
                  DAVISHE010   Davis      Hernandez   2006-09-14
                  RILEYPH002   Riley      Phelps      2005-06-15
                  
## 7. Creating a Database:

          CREATE DATABASE students_db;
          
Then you may create many tables under students_db database.
    
    
## 8. Creating a table called "students":

         USE students_db; 
          
         CREATE TABLE students (
         
              student_id   VARCHAR(20),
              first_name   VARCHAR(25),
              last_name    VARCHAR(35),
              dob          DATE
              
         );
         
## 9. Inserting Rows into a Table    

            USE students_db; 
          
            INSERT INTO students (student_id, first_name, last_name, dob)
            VALUES
                   ('ABRILDA002', 'Abril', 'Davis',     '2005-01-10'),
                   ('CHRISPA004', 'Chris', 'Park',      '1999-04-10'),
                   ('DAVISHE010', 'Davis', 'Hernandez', '2006-09-14'),
                   ('RILEYPH002', 'Riley', 'Phelps',    '2005-06-15');

## 10. Viewing the Data

```sql
USE students_db;

-- query 1
SELECT * 
FROM students;

-- query 2
SELECT student_id, dob 
FROM students;

-- query 3
SELECT student_id, first_name, last_name 
FROM students;

-- query 4
SELECT COUNT(*) 
FROM students;

-- query 5
SELECT COUNT(*) as num_of_students
FROM students;
```

## 11. Formatting SQL for Readability


## 12. BEGINNING DATA EXPLORATION WITH SQL's SELECT

Basic SELECT Syntax:

			Here’s a SELECT statement that fetches every 
			row and column in a table called students:

             SELECT * FROM students;

## 13. Show all databases:

```sql      
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| cats_db            |
| company            |
| company_db         |
| employee           |
| homeworks          |
| information_schema |
| movies             |
| my_test_db         |
| mysql              |
| performance_schema |
| salaries           |
| streamlit_mysql    |
| sys                |
| teachers_db        |
| test_db            |
| test_db2           |
| world              |
+--------------------+
17 rows in set (0.00 sec)
```

## 14. select a database and make it active:

		mysql> use test_db;
		Database changed



		mysql> show tables;
		+-------------------+
		| Tables_in_test_db |
		+-------------------+
		| employees         |
		| emps              |
		| salaries          |
		| table_A           |
		| table_B           |
		+-------------------+
		5 rows in set (0.01 sec)

		mysql> desc employees;
		+------------+-------------+------+-----+---------+-------+
		| Field      | Type        | Null | Key | Default | Extra |
		+------------+-------------+------+-----+---------+-------+
		| emp_id     | int         | NO   | PRI | NULL    |       |
		| first_name | varchar(50) | YES  |     | NULL    |       |
		| last_name  | varchar(50) | YES  |     | NULL    |       |
		| age        | int         | YES  |     | NULL    |       |
		| degree     | varchar(10) | YES  |     | NULL    |       |
		| gender     | varchar(6)  | YES  |     | NULL    |       |
		| country    | varchar(20) | YES  |     | NULL    |       |
		| department | varchar(20) | YES  |     | NULL    |       |
		| hire_date  | date        | YES  |     | NULL    |       |
		| salary     | int         | YES  |     | NULL    |       |
		+------------+-------------+------+-----+---------+-------+
		10 rows in set (0.01 sec)

		mysql> select count(*) from employees;
		+----------+
		| count(*) |
		+----------+
		|      200 |
		+----------+
		1 row in set (0.01 sec)
		
		mysql> select * from employees limit 5;
		+--------+------------+-----------+------+--------+--------+---------+-------------+------------+--------+
		| emp_id | first_name | last_name | age  | degree | gender | country | department  | hire_date  | salary |
		+--------+------------+-----------+------+--------+--------+---------+-------------+------------+--------+
		|      1 | Camila     | Rogers    |   53 | PHD    | FEMALE | CHINA   | Engineering | 2022-02-16 |  84203 |
		|      2 | Owen       | Walker    |   58 | MSIS   | MALE   | CANADA  | Engineering | 2021-08-03 |  71884 |
		|      3 | Thomas     | Phillips  |   74 | MBA    | MALE   | INDIA   | Finance     | 2021-10-07 | 141674 |
		|      4 | Noah       | Stewart   |   51 | BS     | MALE   | ITALY   | Marketing   | 2020-05-03 | 120808 |
		|      5 | Leo        | Lewis     |   55 | MBA    | MALE   | FRANCE  | Engineering | 2020-12-14 | 119943 |
		+--------+------------+-----------+------+--------+--------+---------+-------------+------------+--------+
		5 rows in set (0.00 sec)


## 15. Sorting Data with ORDER BY


Sorting Data with ORDER BY

		Data can make more sense, and may reveal 
		patterns more readily, when it’s arranged 
		in order rather than jumbled randomly.

		In SQL, we order the results of a query 
		using a clause containing the keywords 
		ORDER BY followed by the name of the column 
		or columns to sort.

		Applying this clause doesn’t change the 
		original table, only the result of the query. 
		
		example using the students table:
		
				SELECT emp_id, first_name, last_name, age
				FROM employees
				ORDER BY age ASC;
				
				SELECT emp_id, first_name, last_name, age
				FROM employees
				ORDER BY age DESC;


## 16. Using DISTINCT to Find Unique Values

			SELECT DISTINCT country
			from employees;
			
			--  A->Z
			SELECT DISTINCT country
			from employees
			ORDER BY country ASC;
			
			--   Z->A
			SELECT DISTINCT country
			from employees
			ORDER BY country DESC;
			
			
## 17. Filtering Rows with WHERE:

```sql

				SELECT emp_id, first_name, last_name, age
				FROM employees
				WHERE age > 18;
				
				
				SELECT emp_id, first_name, last_name, age
				FROM employees
				WHERE emp_id IN (1, 2, 3);
```


------
------
------

## 2. Monday, October  27, 2025, 7:00 pm-9:40 pm (zoom)

```
1. Creating your first database

2. Creating your first tables

3. Importing CSV data into existing tables

4. Writing simple SQL code to retrieve data (no WHERE or ORDER BY clauses)    

5. MovieLens  database
•    Tables: movies, genres, screenings, theaters

6. Data Types in MySQL

7. Lab: Using SQL
```
 
------

## 3. Monday, November  3, 2025, 7:00 pm-9:40 pm (zoom)

```
1. Writing SQL code to retrieve data (using WHERE or ORDER BY clauses)

2. Joining tables

3. Managing missing data (NULL)

4. Basic, row-level arithmetic    

5. Limiting and sorting data

6. Inner and Outer joins

7. Lab: Using SQL
```

------

## 4. Saturday, November  8, 2025, 8:00 am - 12:30 pm (in-person)

```
1. Grouping data

2. Aggregating data (SUM, AVG, MIN, MAX)

3. Simple Ranking data: RANK() functions

4. Grouping, aggregating, and ranking data to make decisions

5. Lab: Using SQL

```
------

## 5. Monday, November 10, 2025, 7:00 pm-9:40 pm (zoom)

```
1. Using dates and times to understand intervals and durations

2. Extracting the components of a date or a time

3. Performing date or time math

4. Using date parts to track events

5. Lab: Using SQL
```
-------
  
## 6. Monday, November 17, 2025, 7:00 pm-9:40 pm (zoom)

```
1. Join Operations in Action

2. Inner Join

3. Left Join

4. Right Join

5. Lab: Using SQL
```

-------

## 7. Saturday, November 22, 20258 8:00 am - 12:30 pm (in-person)

```
1. Using a simple Python program to perform ETL

2. Extraction

3. Transformation

4. Load

5. Lab: Using SQL

```
-------

## 8. Monday, November 24, 2025, 7:00 pm-9:40 pm (zoom)

```
1. Sub-queries

2. Ranking functions

3. ROW_NUMBER()

4. RANK()

5. DENSE_RANK()

6. Lab: using SQL

```
--------
  
## 9. Monday, December  1, 2025, 7:00 pm-9:40 pm (zoom)

```
1. Turning data into value

2. Business queries using multi-year data

3. Some OLAP operations: roll up, roll down, slice, dice

4. Lab: using SQL
```

## 10. Saturday, December  6, 20258 8:00 am - 12:30 pm (in-person)

```
1. Review relational databases 

2. Create a database with multiple tables

3. Perform business operations using SQL

4. Lab: using SQL
```
  
## 11. Monday, December  8, 2025, 7:00 pm-9:40 pm (zoom)

```
1. Large datasets: How big is big?

2. Review

3. Lab: using SQL
```  
  
  