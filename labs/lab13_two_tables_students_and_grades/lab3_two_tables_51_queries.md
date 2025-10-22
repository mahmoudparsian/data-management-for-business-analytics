# LAB 3:  Multi-Table Queries and JOINs
# 2 Tables: Students and Grades


	1. Lab 3 with using 2 tables with sample 
	   rows and 50 new queries from simple to 
	   intermediate: show how the tables are 
	   linked by using join operations

	2. In this lab, you'll learn how to work 
	   with two related tables and explore how 
	   to query across them using JOIN operations.


## 📦 Step 1: Create Database: lab3

```sql
CREATE DATABASE lab3; 
```


## 📦 Step 2: Create Two Tables

	students table:
	
			A students table to store 
			student information

	grades table:
	
			A grades table to store course  
			grades for each student



### 🎓 Step 2.1: Create Table: students

```sql
USE lab3;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    grade_level VARCHAR(10)
);
```

### 📊 Step 2.2: Create Table: grades

```sql
USE lab3;

CREATE TABLE grades (
    grade_id INT PRIMARY KEY,
    student_id INT,
    course_name VARCHAR(100),
    score DECIMAL(5,2),
    semester VARCHAR(10),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);
```

### 📝 Step 3: Insert Sample Data Students

```sql
INSERT INTO students VALUES
(1, 'Alice', 'Johnson', '9th'),
(2, 'Bob', 'Smith', '10th'),
(3, 'Charlie', 'Lee', '11th'),
(4, 'Diana', 'Garcia', '12th'),
(5, 'Ethan', 'Martinez', '9th'),
(6, 'Max', 'Taylor', '9th'),
(7, 'Babak', 'Smith', '9th'),
(8, 'Dan', 'Grammy', '11th'),
(9, 'David', 'Gasparian', '12th'),
(10, 'Jeff', 'Trumpist', '9th'),
(11, 'Ed', 'Manning', '10th'),
(12, 'Jenny', 'Park', '10th'),
(13, 'Jan', 'Sinner', '12th');
```

### 📝 Step 4: Insert Sample Data Grades

```sql
INSERT INTO grades VALUES
(101, 1, 'Math', 88.5, 'Fall'),
(102, 1, 'English', 92.0, 'Fall'),
(103, 2, 'Math', 75.0, 'Fall'),
(104, 2, 'History', 80.0, 'Fall'),
(105, 3, 'Science', 85.0, 'Fall'),
(106, 4, 'Math', 90.0, 'Fall'),
(107, 5, 'English', 78.0, 'Spring'),
(108, 5, 'History', 82.5, 'Fall'),
(109, 6, 'Math', 78.5, 'Spring'),
(110, 6, 'English', 82.0, 'Spring'),
(111, 8, 'Math', 85.0, 'Spring'),
(112, 8, 'History', 80.0, 'Spring'),
(113, 8, 'Science', 85.0, 'Spring'),
(114, 10, 'IT', 80.0, 'Fall'),
(115, 11, 'IT', 88.0, 'Fall'),
(116, 11, 'IT', 92.5, 'Fall');
```

## 🔍 Step 5: 50 Queries (English + SQL)

## 🟢 Simple Queries (Single Table)

#### 1. Show all students

```sql
SELECT * 
FROM students;
```
 
#### 2. Show all grades

```sql
SELECT * 
FROM grades;
```
 
#### 3. Show student names only

```sql
SELECT first_name, last_name 
FROM students;
```
 
#### 4. Show all course names

```sql
SELECT DISTINCT course_name 
FROM grades;
```
 
#### 5. Show all scores above 85

```sql
SELECT * 
FROM grades 
WHERE score > 85;
```
 
#### 6. Show students in 9th grade

```sql
SELECT * 
FROM students 
WHERE grade_level = '9th';
```
 
#### 7. Show grades for the 'Math' course

```sql
SELECT * 
FROM grades 
WHERE course_name = 'Math';
```
 
#### 8. Show grades for the 'Fall' semester

```sql
SELECT * 
FROM grades 
WHERE semester = 'Fall';
```
 
#### 9. Count total students

```sql
SELECT COUNT(*) 
FROM students;
```
 
#### 10. Count total grades recorded

```sql
SELECT COUNT(*) 
FROM grades;
```
 
#### 11. Find average score in 'Math'

```sql
SELECT AVG(score) 
FROM grades 
WHERE course_name = 'Math';
```
 
#### 12. Find highest score in 'English'

```sql
SELECT MAX(score) 
FROM grades 
WHERE course_name = 'English';
```
 
#### 13. Find lowest score in 'History'

```sql
SELECT MIN(score) 
FROM grades 
WHERE course_name = 'History';
```
 
#### 14. Show students whose last name starts with 'M'

```sql
SELECT * 
FROM students 
WHERE last_name LIKE 'M%';
```
 
#### 15. Show grades with score between 80 and 90

```sql
SELECT * 
FROM grades 
WHERE score BETWEEN 80 AND 90;
```
 
## 🟡 Intermediate Queries (JOINs and Aggregations)

#### 16. Show student names with their course and score

```sql
SELECT s.first_name, 
       s.last_name, 
       g.course_name, 
       g.score
FROM students s
JOIN grades g ON s.student_id = g.student_id;
```
 
#### 17. Show student names and their average score

```sql
SELECT s.first_name, 
       s.last_name, 
       AVG(g.score) AS avg_score
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id;
```
 
#### 18. Show students with scores above 90

```sql
SELECT s.first_name, 
       g.course_name, 
       g.score
FROM students s
JOIN grades g ON s.student_id = g.student_id
WHERE g.score > 90;
```
 
#### 19. Show students and number of courses taken

```sql
SELECT s.first_name, 
       COUNT(g.course_name) AS course_count
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id;
```
 
#### 20. Show students and total score across all courses

```sql
SELECT s.first_name, 
       SUM(g.score) AS total_score
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id;
```
 
#### 21. Show students who took 'History'

```sql
SELECT DISTINCT s.first_name, s.last_name
FROM students s
JOIN grades g ON s.student_id = g.student_id
WHERE g.course_name = 'History';
```
 
#### 22. Show students with more than one grade entry

```sql
SELECT s.first_name, 
       COUNT(g.grade_id) AS grade_count
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id
HAVING COUNT(g.grade_id) > 1;
```
 
#### 23. Show students and their highest score

```sql
SELECT s.first_name, 
       MAX(g.score) AS highest_score
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id;
```
 
#### 24. Show students and their lowest score

```sql
SELECT s.first_name, 
       MIN(g.score) AS lowest_score
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id;
```
 
#### 25. Show students and their grade level with course and score

```sql
SELECT s.first_name, 
       s.grade_level, 
       g.course_name, 
       g.score
FROM students s
JOIN grades g ON s.student_id = g.student_id;
```
 
## 🟡 More JOIN-Based Queries

#### 26. Show all students with their scores in 'Fall' semester

```sql
SELECT s.first_name, 
       g.course_name, 
       g.score
FROM students s
JOIN grades g ON s.student_id = g.student_id
WHERE g.semester = 'Fall';
```
 
#### 27. Show students who scored below 80

```sql
SELECT s.first_name, 
       g.course_name, 
       g.score
FROM students s
JOIN grades g ON s.student_id = g.student_id
WHERE g.score < 80;
```
 
#### 28. Show students and number of 'Math' courses taken

```sql
SELECT s.first_name, 
       COUNT(*) AS math_courses
FROM students s
JOIN grades g ON s.student_id = g.student_id
WHERE g.course_name = 'Math'
GROUP BY s.student_id;
```
 
#### 29. Show students with average score above 85

```sql
SELECT s.first_name, 
       AVG(g.score) AS avg_score
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id
HAVING AVG(g.score) > 85;
```
 
#### 30. Show students and their score percentage (out of 100)

```sql
SELECT s.first_name, 
       g.course_name, 
       CONCAT(g.score, '%') AS score_percent
FROM students s
JOIN grades g ON s.student_id = g.student_id;
```
 
#### 31. Show students with full name and course

```sql
SELECT CONCAT(s.first_name, ' ', s.last_name) AS full_name, 
       g.course_name
FROM students s
JOIN grades g ON s.student_id = g.student_id;
```
 
#### 32. Show students and their score category (High/Medium/Low)

```sql
SELECT s.first_name, 
       g.score,
  CASE
    WHEN g.score >= 90 THEN 'High'
    WHEN g.score >= 80 THEN 'Medium'
    ELSE 'Low'
  END AS score_category
FROM students s
JOIN grades g ON s.student_id = g.student_id;
```
 

## 🟡 Intermediate Queries (continued)

#### 33. Show students and their scores in each course, sorted by score descending

```sql
SELECT s.first_name, 
       g.course_name, 
       g.score
FROM students s
JOIN grades g ON s.student_id = g.student_id
ORDER BY g.score DESC;
```
 
#### 34. Show students who scored the same in multiple courses

```sql
SELECT s.first_name, 
       g.score, 
       COUNT(*) AS score_count
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id, g.score
HAVING COUNT(*) > 1;
```
 
#### 35. Show students and their average score per semester

```sql
SELECT s.first_name, 
       g.semester, 
       AVG(g.score) AS avg_score
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id, g.semester;
```
 
#### 36. Show students who scored above the average score of all students

```sql
SELECT s.first_name, g.course_name, g.score
FROM students s
JOIN grades g ON s.student_id = g.student_id
WHERE g.score > (
                  SELECT AVG(score) FROM grades
                );
```
 
#### 37. Show students and their grade level with total number of grades

```sql
SELECT s.first_name, s.grade_level, COUNT(g.grade_id) AS total_grades
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id;
```
 
#### 38. Show students who scored below the average in 'Math'

```sql
SELECT s.first_name, 
       g.score
FROM students s
JOIN grades g ON s.student_id = g.student_id
WHERE g.course_name = 'Math'
AND g.score < (
                 SELECT AVG(score) 
                 FROM grades WHERE 
                 course_name = 'Math'
              );
```
 
#### 39. Show students and their highest scoring course

```sql
SELECT s.student_id, 
       s.first_name, 
       g.course_name, 
       g.score
FROM students s
JOIN grades g ON s.student_id = g.student_id
WHERE g.score = (
                  SELECT MAX(score) 
                  FROM grades 
                  WHERE student_id = s.student_id
                );
```
 
#### 40. Show students and their lowest scoring course

```sql
SELECT s.first_name, g.course_name, g.score

FROM students s
JOIN grades g ON s.student_id = g.student_id
WHERE g.score = (
SELECT MIN(score) 
FROM grades WHERE student_id = s.student_id
);
```
 
#### 41. Show students and number of semesters they’ve taken courses in

```sql
SELECT s.first_name, COUNT(DISTINCT g.semester) AS semesters
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id;
```
 
#### 42. Show students who have taken more than 2 courses

```sql
SELECT s.first_name, COUNT(g.course_name) AS course_count
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id
HAVING COUNT(g.course_name) > 2;
```
 
#### 43. Show students and their score difference 
FROM the average

```sql
SELECT s.first_name, 
       g.course_name, 
       g.score,
       g.score - (SELECT AVG(score) FROM grades) AS score_diff
FROM students s
JOIN grades g ON s.student_id = g.student_id;
```
 
#### 44. Show students and their course list as a comma-separated string

```sql
SELECT s.first_name, GROUP_CONCAT(g.course_name SEPARATOR ', ') AS courses
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id;
```
 
#### 45. Show students and their total score per semester

```sql
SELECT s.first_name, g.semester, SUM(g.score) AS total_score
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id, g.semester;
```
 
#### 46. Show students who scored exactly 80 in any course

```sql
SELECT s.first_name, g.course_name
FROM students s
JOIN grades g ON s.student_id = g.student_id
WHERE g.score = 80;
```
 
#### 47. Show students and their score rank per course

```sql
SELECT s.first_name, g.course_name, g.score,
       RANK() OVER (PARTITION BY g.course_name ORDER BY g.score DESC) AS rank
FROM students s
JOIN grades g ON s.student_id = g.student_id;
```
 
#### 48. Show students and whether they passed (score ≥ 70) or failed

```sql
SELECT s.first_name, g.course_name, g.score,
       CASE WHEN g.score >= 70 THEN 'Pass' ELSE 'Fail' END AS result

FROM students s
JOIN grades g ON s.student_id = g.student_id;
```
 
#### 49. Show students and their average score rounded to nearest integer

```sql
SELECT s.first_name, ROUND(AVG(g.score)) AS avg_score

FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id;
```
 
#### 50. Show students and their score improvement between two courses

```sql
SELECT s.first_name,
       MAX(g.score) - MIN(g.score) AS score_improvement

FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id
HAVING COUNT(g.course_name) > 1;
```
----

#### 51. 🎯 Given two tables: find students who do not have any grades at all

	You want to return all students who have 
	no grades at all in the grades table.


There are a couple of standard SQL solutions for this:

⸻

✅ Solution 1: LEFT JOIN + IS NULL

```sql
SELECT s.student_id, 
       s.first_name, 
       s.last_name, 
       s.grade_level
FROM students s
LEFT JOIN grades g ON s.student_id = g.student_id
WHERE g.student_id IS NULL;

```
•	Explanation:
	
	•	LEFT JOIN keeps all students, even 
	    if no matching grade exists.
	    
	•	The WHERE g.student_id IS NULL condition ensures 
	    we only keep those with no grades.

⸻

✅ Solution 2: NOT IN subquery

```sql
SELECT s.student_id, 
       s.first_name, 
       s.last_name, 
       s.grade_level
FROM students s
WHERE s.student_id NOT IN (
    SELECT g.student_id
    FROM grades g
);
```

•	Explanation:

	•	The inner query returns all 
	    student_ids with grades.
	    
	•	The outer query excludes those, 
	    leaving only students without any grades.

⸻

✅ Solution 3: NOT EXISTS

```sql
SELECT s.student_id, 
       s.first_name, 
       s.last_name, 
       s.grade_level
FROM students s
WHERE NOT EXISTS (
    SELECT 1
    FROM grades g
    WHERE g.student_id = s.student_id
);
```

•	Explanation:

	•	For each student, the subquery 
	    checks if a grade exists.
	    
	•	NOT EXISTS ensures we only return 
	    students without matches.

⸻

