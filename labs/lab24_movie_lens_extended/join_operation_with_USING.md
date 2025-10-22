# in MySQL can you Join by using  "USING"

Basic usage:

	Yes ✅ — in MySQL you can join tables using 
	the USING clause, but it only works when the 
	two tables have a column with the same name. 
	It’s basically shorthand for 
	
	        ON table1.col = table2.col.

📌 Important Notes

    •    USING(column) hides duplicate column output → 
    	the column only appears once in the result set.
    	
    •    ON gives you more flexibility if the column names 
    	differ (ON table1.col1 = table2.col2).
    	
    •    If you need to use different column names, 
    	you cannot use USING, you must use ON.

⸻

## 📌 Example 1: Using USING

Suppose you have:

~~~sql
CREATE TABLE employees (
    emp_id INT,
    name VARCHAR(50),
    dept_id INT
);

CREATE TABLE departments (
    dept_id INT,
    dept_name VARCHAR(50)
);
~~~

Now you want to join employees with their departments:

~~~sql
SELECT emp_id, name, dept_name
FROM employees
JOIN departments
USING (dept_id);
~~~

This is equivalent to:

~~~sql
SELECT emp_id, name, dept_name
FROM employees
JOIN departments
ON employees.dept_id = departments.dept_id;
~~~

⸻

## 📌 Example 2: Multiple tables

If you join three tables with a common column:

~~~sql
SELECT *
FROM ratings
JOIN movies USING (movieId)
JOIN tags USING (movieId);
~~~

⸻

