# Union Operation

	Using mysql database, Build 2 tables with the 
	same schema with sample rows, Then provide 
	detailed examples of all "union" and "union all" 
	operations with complete sql queries and results. 

✅ Let’s build this step by step.

	We’ll use MySQL to create two tables with the same 
	schema so that we can properly demonstrate UNION 
	and UNION ALL.
	
# Union in MySQL

	The MySQL UNION Operator:
	
		The UNION operator is used to combine the 
		result-set of two or more SELECT statements.

		The UNION operator automatically removes duplicate 
		rows from the result set.

		Requirements for UNION: 

			1. Every SELECT statement within UNION must 
			   have the same number of columns

			2. The columns must also have similar data types

			3. The columns in every SELECT statement must 
			   also be in the same order

**MySQL's UNION Syntax:**

~~~sql
		SELECT column_name(s) FROM table1
		UNION
		SELECT column_name(s) FROM table2;
~~~

⸻

## 1. Create Two Tables with the Same Schema

We’ll create two tables: employees_2024 and employees_2025.

~~~sql
CREATE TABLE employees_2024 (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50)
);

CREATE TABLE employees_2025 (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50)
);
~~~

⸻

## 2. Insert Sample Rows

~~~sql
-- Insert into employees_2024
INSERT INTO employees_2024 (emp_id, emp_name, department) 
VALUES
(1, 'Alice', 'HR'),
(2, 'Bob', 'IT'),
(3, 'Charlie', 'Finance'),
(4, 'David', 'IT');

-- Insert into employees_2025
INSERT INTO employees_2025 (emp_id, emp_name, department) 
VALUES
(3, 'Charlie', 'Finance'),
(4, 'David', 'IT'),
(5, 'Eve', 'HR'),
(6, 'Frank', 'Marketing');
~~~

⸻

## 3. Data in Each Table

employees_2024

~~~sql
emp_id    emp_name    department
1         Alice       HR
2         Bob         IT
3         Charlie     Finance
4         David       IT
~~~

employees_2025

~~~sql
emp_id    emp_name    department
3         Charlie     Finance
4         David       IT
5         Eve         HR
6         Frank       Marketing
~~~

⸻

4. UNION Example

👉 UNION removes duplicates.

~~~sql
SELECT emp_id, emp_name, department FROM employees_2024
UNION
SELECT emp_id, emp_name, department FROM employees_2025;
~~~

👉 Result (duplicates removed):

~~~sql
emp_id    emp_name    department
1         Alice       HR
2         Bob         IT
3         Charlie     Finance
4         David       IT
5         Eve         HR
6         Frank       Marketing
~~~

✅ Notice Charlie and David appear only once, even though they are in both tables.

⸻

## 5. UNION ALL Example

👉 **UNION ALL keeps duplicates.**

~~~sql
SELECT emp_id, emp_name, department FROM employees_2024
UNION ALL
SELECT emp_id, emp_name, department FROM employees_2025;
~~~

👉 Result (duplicates kept):

~~~sql
emp_id    emp_name    department
1         Alice       HR
2         Bob         IT
3         Charlie     Finance
4         David       IT
3         Charlie     Finance
4         David       IT
5         Eve         HR
6         Frank       Marketing
~~~

✅ Here, Charlie and David appear twice because they exist in both tables.

⸻

## 6. Key Differences
    
    	•    UNION → combines rows from both  
    	     queries, removes duplicates (slower).
    	     
    	•    UNION ALL → combines rows and 
    	     keeps duplicates (faster).

⸻



## Practical Use Case: Merging Employee Data Across Years

	Imagine you want to see which employees appear 
	across multiple years (2024 and 2025), and also 
	count duplicates to detect overlaps.

⸻

## 1. Combine with UNION ALL and Count Duplicates

👉 Use UNION ALL so we keep duplicates, then group by employees.

~~~sql
SELECT emp_id, emp_name, department, COUNT(*) AS occurrences
FROM (
    SELECT emp_id, emp_name, department FROM employees_2024
    UNION ALL
    SELECT emp_id, emp_name, department FROM employees_2025
) AS combined
GROUP BY emp_id, emp_name, department;
~~~

Result:

~~~sql
emp_id    emp_name    department    occurrences
1         Alice       HR            1
2         Bob         IT            1
3         Charlie     Finance       2
4         David       IT            2
5         Eve         HR            1
6         Frank       Marketing     1
~~~

✅ Charlie and David have occurrences = 2, meaning they exist in both years.

⸻

## 2. Identify Employees Present in Both Years

👉 We can filter occurrences > 1.

~~~sql
SELECT emp_id, emp_name, department
FROM (
    SELECT emp_id, emp_name, department, COUNT(*) AS occurrences
    FROM (
        SELECT emp_id, emp_name, department FROM employees_2024
        UNION ALL
        SELECT emp_id, emp_name, department FROM employees_2025
    ) AS combined
    GROUP BY emp_id, emp_name, department
) AS final
WHERE occurrences > 1;
~~~

Result:

~~~sql
emp_id    emp_name    department
3         Charlie     Finance
4         David       IT
~~~

✅ These are the employees who worked in both years.

⸻

## 3. Employees Unique to Each Year

👉 Use `UNION ALL + GROUP BY + HAVING occurrences = 1.`

~~~sql
SELECT emp_id, emp_name, department
FROM (
    SELECT emp_id, emp_name, department, COUNT(*) AS occurrences
    FROM (
        SELECT emp_id, emp_name, department FROM employees_2024
        UNION ALL
        SELECT emp_id, emp_name, department FROM employees_2025
    ) AS combined
    GROUP BY emp_id, emp_name, department
) AS final
WHERE occurrences = 1;
~~~

Result:

~~~sql
emp_id    emp_name    department
1         Alice       HR
2         Bob         IT
5         Eve         HR
6         Frank       Marketing
~~~

✅ These employees appear in only one year.

⸻

👉 This way:

    	•    UNION → good for deduplicated list of employees across years.
    	
    	•    UNION ALL → useful for finding overlaps, duplicates, and unique entries.

⸻

