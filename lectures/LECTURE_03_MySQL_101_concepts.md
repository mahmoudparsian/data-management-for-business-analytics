# 1. What is MySQL?


	MySQL is a database system.
	
	A database stores information (like 
	spreadsheets but much bigger and smarter).

	Example: A university database may have tables 
	for students, teachers, courses, grades.

### A Database = { set of Tables }
### A Table = rows x columns

### A Table example: Students: 5 rows x 4 columns

students:

| id       | name    | age      | grade |
| :------- | :------ | :------- | :---- |
| 1        | Alice   | 20       | A     |
| 2        | Bob     | 22       | B     |
| 3        | Charlie | 21       | C     |
| 4        | Jeff    | 22       | B     |
| 5        | Rafa    | 38       | A     |



# 🔑 2. Key Terms



	Database: A collection of tables.
	
	Table: Like an Excel sheet (rows & columns).
	
	Row (Record): One entry in the table.
	
	Column (Field): A property of the data (e.g., name, age, grade).
	

# What is SQL?

	SQL (Structured Query Language): 
	The language we use to talk to the database.



# 🛠 3. Installing MySQL


	Install MySQL Community Server (free).
	
	Use MySQL Workbench or command line to interact.
	
	Connect with username & password (default user = root).



# 📋 4. Creating a Database



	CREATE DATABASE school;

	USE school;



# 📋 5. Creating a Table called as **"students"**


~~~sql
CREATE TABLE students (

    id INT  PRIMARY KEY,

    name VARCHAR(50),

    age INT,

    grade VARCHAR(5)

);
~~~

👉 This makes a table called students with columns for id, name, age, grade.



# ✍️ 6. Inserting Data


~~~sql
INSERT INTO students (id, name, age, grade)
VALUES 
(1, 'Alice', 20, 'A'),
(2, 'Bob', 22, 'B'),
(3, 'Charlie', 21, 'C');
~~~



# 🔍 7. Reading Data (SELECT)

👉 **Example-1: Shows all rows and columns.**

~~~sql
SELECT * 
FROM students;
~~~

OR

~~~sql
SELECT id name, age, grade
FROM students;
~~~

**Result:**

| id       | name    | age      | grade |
| :------- | :------ | :------- | :---- |
| 1        | Alice   | 20       | A     |
| 2        | Bob     | 22       | B     |
| 3        | Charlie | 21       | C     |

👉 **Example-2: Shows only name and grade.**

~~~sql
SELECT name, grade 
FROM students;
~~~



# ✏️ 8. Updating Data

**Change Bob's grade to A+:**

~~~sql
UPDATE students

SET grade = 'A+'

WHERE name = 'Bob';
~~~

**SELECT all rows again:**

~~~sql
SELECT id name, age, grade
FROM students;
~~~


**Result:**

| id       | name    | age      | grade |
| :------- | :------ | :------- | :---- |
| 1        | Alice   | 20       | A     |
| 2        | Bob     | 22       | A+    |
| 3        | Charlie | 21       | C     |


# ❌ 9. Deleting Data

**Delete a row where id = 3.**

~~~sql
DELETE FROM students

WHERE id = 3;
~~~

**SELECT all rows again:**

~~~sql
SELECT id name, age, grade
FROM students;
~~~

**Result:**

| id       | name    | age      | grade |
| :------- | :------ | :------- | :---- |
| 1        | Alice   | 20       | A     |
| 2        | Bob     | 22       | A+    |






# 📊 10. Filtering & Sorting


**Example-1: get all students older than 20.**

~~~sql
SELECT * 
FROM students 
WHERE age > 20;
~~~

**Example-1: get all students sorted by their grade (A->Z)**

~~~sql
SELECT * 
FROM students 
ORDER BY grade;
~~~


**Example-1: get all students sorted by their grade (Z->A)**

~~~sql
SELECT * 
FROM students 
ORDER BY grade DESC;
~~~


# 🔗 11. Relationships (Joining Tables)


👍 Let’s demonstrate a very simple INNER JOIN so beginners can see how data from two tables is combined.


#### 1. Departments Table


~~~sql
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO departments VALUES
(1, 'Sales'),
(2, 'HR'),
(3, 'IT');
~~~

#### 2. Employees Table

~~~sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    CONSTRAINT fk_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO employees VALUES
(101, 'Alice', 1),
(102, 'Bob', 2),
(103, 'Carol', 3),
(104, 'David', 1);
~~~

⸻

#### 3. INNER JOIN Query

~~~sql
SELECT e.emp_id, e.name, d.dept_name
FROM employees e
INNER JOIN departments d
    ON e.dept_id = d.dept_id;
~~~

OR

~~~sql
SELECT e.emp_id, e.name, d.dept_name
FROM employees e,
     departments d
WHERE e.dept_id = d.dept_id;
~~~

⸻

#### 4. Result


```
| emp_id | name  | dept_name |
|--------|-------|-----------|
| 101    | Alice | Sales     |
| 102    | Bob   | HR        |
| 103    | Carol | IT        |
| 104    | David | Sales     |
```


**💡 Explanation**

	•	The INNER JOIN only returns rows where the dept_id 
	   exists in both employees and departments.
	   
	•	Employees get “enriched” with department names 
	   instead of just numeric IDs.

⸻




# 🚀 12. Practice Tips

### 1. Always create small tables and test queries.

### 2. Use SELECT the most — it’s how you explore data.

### 3. Don’t be afraid to break things; just re-create the table!

✅ With this, you can create, read, update, and delete (CRUD) data — the foundation of MySQL.





