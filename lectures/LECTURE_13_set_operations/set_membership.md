# Set Membership

	Explain set membership in mysql 
	with solid simple examples

	Perfect 👍 — let’s explain set membership 
	in MySQL with simple and solid examples.

⸻

# 🎓 Set Membership in MySQL

## 1. Concept

    •    Set membership in SQL means checking if 
         a value belongs to a set of values.
         
    •    In MySQL, this is done using the IN and 
         NOT IN operators.

⸻

## 2. Example Table

~~~sql
CREATE TABLE employees (
    id INT,
    name VARCHAR(20),
    department VARCHAR(20)
);

INSERT INTO employees VALUES
(1, 'Alice', 'HR'),
(2, 'Bob', 'IT'),
(3, 'Charlie', 'Finance'),
(4, 'David', 'IT'),
(5, 'Eva', 'Marketing');
~~~

#### 📊 employees table

~~~
id   name     department
1    Alice    HR
2    Bob      IT
3    Charlie  Finance
4    David    IT
5    Eva      Marketing
~~~

⸻

## 3. Example 1: Membership with IN

#### 👉 Find employees who work in IT or HR.

solution-1:

~~~sql
SELECT name, department
FROM employees
WHERE department IN ('IT', 'HR');
~~~

solution-2:

~~~sql
SELECT name, department
FROM employees
WHERE (department = 'IT') OR
      (department = 'HR');
~~~


✅ Output:

~~~
name     department
Alice    HR
Bob      IT
David    IT
~~~

**Alternate Solution:**

~~~sql
SELECT name, department
FROM employees
WHERE (department = 'IT') OR 
      (department = 'HR');
~~~
⸻

## 4. Example 2: Negated Membership with NOT IN

#### 👉 Find employees who are not in IT or HR.

~~~sql
SELECT name, department
FROM employees
WHERE department NOT IN ('IT', 'HR');
~~~

✅ Output:

~~~
name       department
Charlie    Finance
Eva        Marketing
~~~


⸻

## 5. Example 3: Subquery with IN

👉 Find employees whose department exists in another table.

~~~sql
-- Create another table
CREATE TABLE active_departments (dept_name VARCHAR(20));
INSERT INTO active_departments VALUES ('IT'), ('Finance');

-- Query with subquery
SELECT name, department
FROM employees
WHERE department IN (
                      SELECT dept_name 
                      FROM active_departments
                    );
~~~

✅ Output:

~~~
name     department
Bob      IT
Charlie  Finance
David    IT
~~~

⸻

## 📝 Summary

    •    IN → checks if value belongs to 
         a list or subquery result.
         
    •    NOT IN → checks if value does not belong.
    
    •    Works with explicit lists or results of subqueries.

⸻

