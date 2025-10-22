# 🎓 Testing for Absence of Duplicate Tuples in MySQL

## 🔹 1. Schema Setup

~~~sql
CREATE TABLE students (
    id INT,
    name VARCHAR(20)
);

INSERT INTO students VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Alice'),
(4, 'Charlie');
~~~

📊 students table

~~~
id    name
1     Alice
2     Bob
3     Alice
4     Charlie
~~~

👉 Here, 'Alice' is duplicated.

⸻

## 🔹 2. Method 1: Using GROUP BY + HAVING

👉 Find duplicates (tuples with count > 1):

~~~sql
SELECT name, COUNT(*) AS occurrences
FROM students
GROUP BY name
HAVING COUNT(*) > 1;
~~~

✅ Output:

~~~
name    occurrences
Alice    2
~~~

👉 Absence of duplicates = query returns no rows.

⸻

## 🔹 3. Method 2: Using DISTINCT vs total count

👉 Compare row count vs distinct row count:

~~~sql
SELECT
  (SELECT COUNT(*) FROM students) AS total_rows,
  (SELECT COUNT(DISTINCT name) FROM students) AS distinct_rows;
~~~

✅ Output:

~~~
total_rows    distinct_rows
4             3

👉 If total_rows = distinct_rows → no duplicates.
👉 Here: 4 ≠ 3 → duplicates exist.
~~~

⸻

## 🔹 4. Method 3: Using NOT EXISTS

👉 Find students where same name appears more than once.

~~~sql
SELECT s1.name
FROM students s1
WHERE EXISTS (
  SELECT 1
  FROM students s2
  WHERE s2.name = s1.name
  AND s2.id <> s1.id
);
~~~

✅ Output:

~~~
name
Alice
Alice

👉 If this query returns rows → duplicates exist.
👉 Absence of duplicates = query returns empty result.
~~~
⸻

## 🔹 5. Method 4: Using `ROW_NUMBER()` (MySQL 8+)

👉 Assign row numbers per name and check for > 1.

~~~sql
WITH numbered AS (
  SELECT name,
         ROW_NUMBER() OVER (PARTITION BY name ORDER BY id) AS rn
  FROM students
)
SELECT name
FROM numbered
WHERE rn > 1;
~~~

✅ Output:

~~~
name
Alice

👉 Absence of duplicates = no rows with rn > 1.
~~~
⸻

## 📝 Summary of Methods

    1.    GROUP BY + HAVING → easiest way to detect duplicates.
    
    2.    COUNT(*) vs COUNT(DISTINCT col) → test if duplicates exist.
    
    3.    EXISTS / NOT EXISTS → relational-style test for duplicates.
    
    4.    ROW_NUMBER() → window function to detect duplicates (MySQL 8+).

⸻


