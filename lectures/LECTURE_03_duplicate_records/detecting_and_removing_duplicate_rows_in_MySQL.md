# 🎓 Detecting & Removing Duplicate Rows in MySQL

⸻

## 🔹 1. Schema with Duplicate Rows

~~~sql
CREATE TABLE students (
    id INT,
    name VARCHAR(20)
);

INSERT INTO students VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Alice'),
(4, 'Charlie'),
(5, 'Bob');   -- duplicate name
~~~

📊 students table

~~~
id    name
1     Alice
2     Bob
3     Alice
4     Charlie
5     Bob
~~~

⸻

## 🔹 2. Detect Duplicate Rows

#### A. Find duplicates by GROUP BY + HAVING

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
Bob      2
~~~

⸻

### B. Show the actual duplicate rows

~~~sql
SELECT id, name
FROM students s1
WHERE (
    SELECT COUNT(*)
    FROM students s2
    WHERE s2.name = s1.name
) > 1;

✅ Output:

~~~
id    name
1     Alice
3     Alice
2     Bob
5     Bob
~~~

⸻

## 🔹 3. Remove Duplicate Rows

A. Keep the lowest id, delete the rest (MySQL 8+)

~~~sql
DELETE FROM students
WHERE id NOT IN (
  SELECT MIN(id)
  FROM students
  GROUP BY name
);
~~~

✅ Remaining rows:

~~~
id   name
1    Alice
2    Bob
4    Charlie
~~~

⸻

### B. Using `ROW_NUMBER()` (MySQL 8+)

~~~sql
WITH ranked AS (
  SELECT id, 
         name,
         ROW_NUMBER() OVER (PARTITION BY name ORDER BY id) AS rn
  FROM students
)
DELETE FROM students
WHERE id IN (
  SELECT id FROM ranked WHERE rn > 1
);
~~~

    •    ROW_NUMBER() assigns 1 to the first row per group,
         >1 to duplicates.
         
    •    The DELETE removes those duplicates.

⸻

## 🔹 4. Key Notes

    •    Detect duplicates → GROUP BY … HAVING COUNT(*) > 1
    
    •    Show duplicates → join or subquery to list them
    
    •    Remove duplicates → keep MIN(id) (or MAX(id)) per group
    
    •    Requires MySQL 8+ for ROW_NUMBER()

⸻

