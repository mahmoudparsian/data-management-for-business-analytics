# composition of relational operations <br> applying more than one relational algebra operation together

✅ This is a composition of three operations:

		1.	Join (combine Employee + Department)
		2.	Selection (filter rows where dept = Engineering)
		3.	Projection (keep only the name column)

⸻

## Composition of Relational Operations

		•	Relational Algebra allows us to combine 
		(compose) operations such as Selection (σ), 
		Projection (π), and Join (⨝).
		
		•	In SQL, this translates to combining 
		SELECT, WHERE, and JOIN.

⸻

# Example

We have two tables:

~~~sql
Employee

emp_id  name    dept_id  salary
1       John    10       75000
2       Jane    20       60000
3       Robert  10       82000
4       Linda   30       70000

Department

dept_id   dept_name
10        Engineering
20        HR
30        Marketing
~~~

⸻

# Task: Find the names of employees in the Engineering department.

⸻

Step 1 — Join

Relational Algebra:

		Employee ⨝ Department


SQL:

~~~sql
SELECT e.emp_id, 
       e.name, 
       e.dept_id, 
       d.dept_name
FROM Employee e
JOIN Department d ON e.dept_id = d.dept_id;
~~~

Result (after Join)

~~~sql
emp_id  name  dept_id  dept_name
1       John	10     Engineering
2       Jane	20     HR
3       Robert	10     Engineering
4       Linda	30     Marketing
~~~

⸻

# Step 2 — Selection

	Now select rows where dept_name = 'Engineering'.

Relational Algebra:

		σ dept_name='Engineering' (Employee ⨝ Department)

SQL:

~~~sql
SELECT e.emp_id, e.name, d.dept_name
FROM Employee e
JOIN Department d ON e.dept_id = d.dept_id
WHERE d.dept_name = 'Engineering';
~~~

Result (after Selection)

~~~sql
emp_id	name	dept_name
1	John	Engineering
3	Robert	Engineering
~~~

⸻

# Step 3 — Projection

Finally, keep only the name column.

Relational Algebra:

		π name (σ dept_name='Engineering' (Employee ⨝ Department))

SQL:

~~~sql
SELECT e.name
FROM Employee e
JOIN Department d ON e.dept_id = d.dept_id
WHERE d.dept_name = 'Engineering';
~~~

Final Result (after Projection)

~~~sql
name
John
Robert
~~~

⸻

