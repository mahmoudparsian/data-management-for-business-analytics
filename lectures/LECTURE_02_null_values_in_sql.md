# NULL value in SQL

	Explain the concept of NULL values in SQL. 

	👍 — NULL is one of the most important 
	     (and confusing) concepts in SQL.

👉 These  slides cover:

    1.    Definition of NULL
    2.    How to test for NULL
    3.    Behavior of NULL in expressions & aggregates

⸻

# 📑 Slide 1: What is NULL in SQL?

    •    NULL means “unknown” or “missing” value.
    
    •    It is not 0, 
    
    •    It is not an empty string, 
    
    •    It is not false/FALSE
    
    •    Any column can hold NULL if it was not given a value.


		In SQL, NULL is a special marker used to 
		indicate that a data value is unknown, 
		missing, or not applicable in a particular 
		column. It is not equivalent to zero, an empty 
		string, or a blank space.
		
## Handling in Operations:

	Mathematical Operations: 
	
			Any mathematical operation performed 
			with NULL will result in NULL. 
			For example, 10 + NULL equals NULL. 
			
	Aggregate Functions: 
	
			Most aggregate functions (like SUM, AVG, COUNT) 
			typically ignore NULL values by default, only 
			operating on the non-null values.
	
	
Example

~~~sql
CREATE TABLE employees (
    id INT,
    name VARCHAR(20),
    department VARCHAR(20)
);


INSERT INTO employees VALUES
(1, 'Alice', 'HR'),
(2, 'Bob', NULL),
(3, 'Charlie', 'IT');
~~~

### 📊 employees table:

~~~
id    name     department
1     Alice    HR
2     Bob      NULL
3     Charlie  IT
~~~

⸻

## 📑 Slide 2: How to Check for NULL

    •    You cannot use = or != with NULL.
    
    •    Use IS NULL and IS NOT NULL.

#### Example-1: Find employees with no department

~~~sql
SELECT name 
FROM employees
WHERE department IS NULL;
~~~

✅ Result:
    •    Bob has NULL department → found in first query
    
    
#### Example-2:  Find employees with a department assigned

~~~sql
SELECT name 
FROM employees
WHERE department IS NOT NULL;
~~~

✅ Result:
    •    Alice, Charlie found in second query

⸻

## 📑 Slide 3: NULL in Expressions & Aggregations

```
    •    Any math or string operation with NULL → results in NULL.
    
    •    Aggregates:
    •                 COUNT(*) counts all rows (ignores NULL).
    
    •                 COUNT(column) ignores NULL values.
```

### Example

~~~mysql
SELECT COUNT(*) AS total_rows,
       COUNT(department) AS dept_count
FROM employees;
~~~

✅ Result:

    •    total_rows = 3
    
    •    dept_count = 2 
    
         (because Bob’s department is NULL, not counted)

⸻

## 📑 Slide 4: Common Mistakes with NULL

#### ❌ Mistake 1: Using `=` or `!=` with NULL

~~~sql
-- WRONG: This will return no rows
SELECT name FROM employees
WHERE department = NULL;
~~~

✅ Correct way:

~~~sql
SELECT name 
FROM employees
WHERE department IS NULL;
~~~

⸻

#### ❌ Mistake 2: Assuming NULL = NULL is true

    •    In SQL, NULL is unknown.
    •    NULL = NULL → FALSE (actually “UNKNOWN”).
    •    Use IS NULL or IS NOT NULL instead.

⸻

#### ❌ Mistake 3: Forgetting about NULLs in joins

~~~sql
SELECT * 
FROM employees e
JOIN departments d
  ON e.department = d.dept_name;
~~~

    •    If department is NULL, 
         the row will not match any department.
         
    •    Must handle with LEFT JOIN if you want 
         to keep those rows.

⸻

✅ Key Rule: Always use

    •    IS NULL to check for missing values
    •    IS NOT NULL for present values

⸻

## Testing for NULL: 

		You cannot use standard comparison operators 
		(=, !=, <, >) to check for NULL values.
		
		 Instead, you must use the  following operators:
		           IS NULL  
		           IS NOT NULL 

**Is a column NULL?**

```sql
    SELECT column_name
    FROM table_name
    WHERE column_name IS NULL;
```

**Is a column NOT NULL?**

```sql
    SELECT column_name
    FROM table_name
    WHERE column_name IS NOT NULL;
```