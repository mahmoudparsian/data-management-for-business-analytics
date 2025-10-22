# complete example of cartesian product for mysql

	Let’s go through a simple but complete example 
	of Cartesian Product (Cross Join) in MySQL.

⸻

📘 What is a Cartesian Product?

    •    	In relational algebra, the Cartesian product (×) 
    		combines every row of one table with every row 
    		of another table.
    		
    •    	In SQL, this is done with:
    •    		CROSS JOIN, or
    •    		simply FROM TableA, TableB (without a join condition).

⸻

## Example Tables

Table: Students

~~~sql
student_id    name
1             John
2             Jane
~~~

Table: Courses

~~~sql
course_id    course_name
101          Math
102          History
~~~

⸻

# SQL Query — Cartesian Product

~~~sql
SELECT s.student_id, s.name, c.course_id, c.course_name
FROM Students s
CROSS JOIN Courses c;
~~~

(or equivalently:)

~~~sql
SELECT s.student_id, s.name, c.course_id, c.course_name
FROM Students s, Courses c;
~~~

⸻

## Result (Cartesian Product)

~~~sql
student_id    name    course_id    course_name
1             John    101          Math
1             John    102          History
2             Jane    101          Math
2             Jane    102          History
~~~

⸻

## ✅ Explanation:
    •    Students has 2 rows, Courses has 2 rows.
    •    The Cartesian product yields 2 × 2 = 4 rows.
    •    Each student is paired with each course.

⸻

# Cartesian Product with a WHERE filter 


⸻

## Step 1 — Cartesian Product (Cross Join)

~~~sql
SELECT s.student_id, s.name, c.course_id, c.course_name
FROM Students s
CROSS JOIN Courses c;
~~~

Result

~~~sql
student_id    name    course_id    course_name
1             John    101          Math
1             John    102          History
2             Jane    101          Math
2             Jane    102          History
~~~

⸻

## Step 2 — Add a Relation Table

Let’s say we track which student actually enrolled in which course.

Table: Enrollments

~~~sql
student_id    course_id
1             101
2             102
~~~

⸻

## Step 3 — Cartesian Product + WHERE filter

		If we cross join Students × Courses and then 
		filter using Enrollments, we effectively get 
		an Inner Join.

~~~sql
SELECT s.student_id, 
       s.name, 
       c.course_id, 
       c.course_name
FROM Students s
CROSS JOIN Courses c
JOIN Enrollments e
  ON s.student_id = e.student_id AND 
     c.course_id = e.course_id;
~~~

⸻

## Result (after filtering)

~~~sql
student_id    name    course_id    course_name
1             John    101          Math
2             Jane    102          History
~~~

⸻

✅ Explanation:
    •    Step 1: Students × Courses produced all possible pairs.
    
    •    Step 2: The JOIN Enrollments ... condition filters out 
                 only the valid pairs.
                 
    •    This is exactly how Inner Joins work in SQL: start with 
         a Cartesian product, then apply selection (filtering).

⸻

