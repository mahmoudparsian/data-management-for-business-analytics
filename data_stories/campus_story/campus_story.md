# Campus Data Story

	Let's say that I just installed 
	MySQL successfully on my macbook. 
	I want to learn the following
	relationships:
	
	     1-to-1, 
	     1-to-M,  
	     M-to_M 
	     
	
	We provide a complete mysql schema for this with a 
	good solid story behind data. Then come up with SQL 
	INSERT statements, and finally provide 
	
	20 basic English/SQL queries, 
	20 simple-to-intermediate English/SQL queries, and 
	20 intermediate English/SQL queries. 
	
	All of these in markdown format.


---

# 📘 Campus Connect: Relationships 

	A university system designed to help you learn 
	1-to-1, 1-to-Many, and M-to-M relationships in MySQL.

---

## 🧱 Schema Overview

### Tables:
- `students`: student info
- `dorms`: each student has one dorm room (1-to-1)
- `professors`: each professor teaches many courses (1-to-M)
- `courses`: course info
- `enrollments`: students enroll in multiple courses (M-to-M)

---

## 🗂️ MySQL Schema

```sql
CREATE TABLE students (
  student_id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100)
);
```

```sql
CREATE TABLE dorms (
  dorm_id INT PRIMARY KEY,
  room_number VARCHAR(10),
  student_id INT UNIQUE,
  FOREIGN KEY (student_id) REFERENCES students(student_id)
);
```

```sql
CREATE TABLE professors (
  professor_id INT PRIMARY KEY,
  name VARCHAR(100),
  department VARCHAR(100)
);
```

```sql
CREATE TABLE courses (
  course_id INT PRIMARY KEY,
  title VARCHAR(100),
  professor_id INT,
  FOREIGN KEY (professor_id) REFERENCES professors(professor_id)
);
```

```sql
CREATE TABLE enrollments (
  student_id INT,
  course_id INT,
  PRIMARY KEY (student_id, course_id),
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
```
```

---

## 📥 Sample INSERT Statements

see file `sample_rows.sql`


------


## 🔍 20 Basic SQL Queries


#### 1. List all students
```sql
SELECT * 
FROM students;
```


------

#### 2. List all dorms
```sql
SELECT * 
FROM dorms;
```


------

#### 3. List all professors
```sql
SELECT * 
FROM professors;
```


------

#### 4. List all courses
```sql
SELECT * 
FROM courses;
```


------

#### 5. Get Alice's dorm room
```sql
SELECT room_number 
FROM dorms 
WHERE student_id = 1;
```


------

#### 6. Get Bob's email
```sql
SELECT email 
FROM students 
WHERE name = 'Bob Smith';
```


------

#### 7. List courses taught by Dr. Blue
```sql
SELECT title 
FROM courses 
WHERE professor_id = 2;
```


------

#### 8. Count number of students
```sql
SELECT COUNT(*) 
FROM students;
```


------

#### 9. Count number of courses
```sql
SELECT COUNT(*) 
FROM courses;
```


------

#### 10. Get all enrollments
```sql
SELECT * 
FROM enrollments;
```


------

#### 11. Get all students in course 3
```sql
SELECT student_id 
FROM enrollments 
WHERE course_id = 3;
```


------

#### 12. Get all courses Alice is enrolled in
```sql
SELECT course_id 
FROM enrollments 
WHERE student_id = 1;
```


------

#### 13. Get professor name for course 1
```sql
SELECT p.name
FROM courses c
JOIN professors p ON c.professor_id = p.professor_id
WHERE c.course_id = 1;
```


------

#### 14. Get dorm info for Charlie
```sql
SELECT room_number
FROM dorms
JOIN students ON dorms.student_id = students.student_id
WHERE students.name = 'Charlie Lee';
```


------

#### 15. Get student names enrolled in course 3
```sql
SELECT students.name
FROM enrollments
JOIN students ON enrollments.student_id = students.student_id
WHERE enrollments.course_id = 3;
```


------

#### 16. Get course titles for student 2
```sql
SELECT courses.title
FROM enrollments
JOIN courses ON enrollments.course_id = courses.course_id
WHERE enrollments.student_id = 2;
```


------

#### 17. Get all student emails
```sql
SELECT email 
FROM students;
```


------

#### 18. Get all professor's departments
```sql
SELECT DISTINCT department 
FROM professors;
```


------

#### 19. Get all room numbers
```sql
SELECT room_number 
FROM dorms;
```


------

#### 20. Get all course titles
```sql
SELECT title 
FROM courses;
```

-----

## 🧠 20 Simple-to-Intermediate SQL Queries


#### 1. List students with their dorm room
```sql
SELECT students.name, dorms.room_number
FROM students
JOIN dorms ON students.student_id = dorms.student_id;
```


------

#### 2. List courses with professor names
```sql
SELECT courses.title, professors.name
FROM courses
JOIN professors ON courses.professor_id = professors.professor_id;
```


------

#### 3. List students with their enrolled courses
```sql
SELECT students.name, courses.title
FROM enrollments
JOIN students ON enrollments.student_id = students.student_id
JOIN courses ON enrollments.course_id = courses.course_id;
```


------

#### 4. Count students per course
```sql
SELECT course_id, COUNT(student_id) AS student_count
FROM enrollments
GROUP BY course_id;
```


------

#### 5. Count courses per professor
```sql
SELECT professor_id, COUNT(course_id) AS course_count
FROM courses
GROUP BY professor_id;
```


------

#### 6. Find students not enrolled in any course
```sql
SELECT name
FROM students
WHERE student_id NOT IN (SELECT student_id FROM enrollments);
```


------

#### 7. Find courses with more than 1 student
```sql
SELECT course_id
FROM enrollments
GROUP BY course_id
HAVING COUNT(student_id) > 1;
```


------

#### 8. Find professors who teach more than 1 course
```sql
SELECT name
FROM professors
WHERE professor_id IN (
  SELECT professor_id
  FROM courses
  GROUP BY professor_id
  HAVING COUNT(course_id) > 1
);
```


------

#### 9. Get all student-course-professor combinations
```sql
SELECT students.name, courses.title, professors.name
FROM enrollments
JOIN students ON enrollments.student_id = students.student_id
JOIN courses ON enrollments.course_id = courses.course_id
JOIN professors ON courses.professor_id = professors.professor_id;
```


------

#### 10. Get all dorms with student names
```sql
SELECT dorms.room_number, students.name
FROM dorms
JOIN students ON dorms.student_id = students.student_id;
```


------

#### 11. Get all courses not enrolled by Charlie
```sql
SELECT title
FROM courses
WHERE course_id NOT IN (
  SELECT course_id
  FROM enrollments
  WHERE student_id = 3
);
```


------

#### 12. Get professors who teach 'Calculus I'
```sql
SELECT professors.name
FROM courses
JOIN professors ON courses.professor_id = professors.professor_id
WHERE courses.title = 'Calculus I';
```


------

#### 13. Get students enrolled in both course 1 and 3
```sql
SELECT student_id
FROM enrollments
WHERE course_id IN (1, 3)
GROUP BY student_id
HAVING COUNT(course_id) = 2;
```


------

#### 14. Get student count per professor
```sql
SELECT professors.name, COUNT(enrollments.student_id) AS student_count
FROM professors
JOIN courses ON professors.professor_id = courses.professor_id
JOIN enrollments ON courses.course_id = enrollments.course_id
GROUP BY professors.name;
```


------

#### 15. Get course titles with professor department
```sql
SELECT courses.title, professors.department
FROM courses
JOIN professors ON courses.professor_id = professors.professor_id;
```


------

#### 16. Get students with more than one enrollment
```sql
SELECT students.name
FROM enrollments
JOIN students ON enrollments.student_id = students.student_id
GROUP BY students.name
HAVING COUNT(course_id) > 1;
```


------

#### 17. Get all students and their dorms, even if missing
```sql
SELECT students.name, dorms.room_number
FROM students
LEFT JOIN dorms ON students.student_id = dorms.student_id;
```


------

#### 18. Get all courses and their professors, even if missing
```sql
SELECT courses.title, professors.name
FROM courses
LEFT JOIN professors ON courses.professor_id = professors.professor_id;
```


------

#### 19. Get all professors and their courses, even if missing
```sql
SELECT professors.name, courses.title
FROM professors
LEFT JOIN courses ON professors.professor_id = courses.professor_id;
```


------

#### 20. Get all students and their courses, even if missing
```sql
SELECT students.name, courses.title
FROM students
LEFT JOIN enrollments ON students.student_id = enrollments.student_id
LEFT JOIN courses ON enrollments.course_id = courses.course_id;
```

------


## 🧠 20 Intermediate SQL Queries


#### 1. Get students who share a course with Alice
```sql
SELECT DISTINCT s2.name
FROM enrollments e1
JOIN enrollments e2 ON e1.course_id = e2.course_id
JOIN students s1 ON e1.student_id = s1.student_id
JOIN students s2 ON e2.student_id = s2.student_id
WHERE s1.name = 'Alice Johnson' AND s2.name != 'Alice Johnson';
```


------

#### 2. Get courses with no students
```sql
SELECT title
FROM courses
WHERE course_id NOT IN (SELECT course_id FROM enrollments);
```


------

#### 3. Get professors with no courses
```sql
SELECT name
FROM professors
WHERE professor_id NOT IN (SELECT professor_id FROM courses);
```


------

#### 4. Get students with same dorm room prefix
```sql
SELECT s1.name AS student1, s2.name AS student2
FROM dorms d1
JOIN dorms d2 ON LEFT(d1.room_number, 1) = LEFT(d2.room_number, 1)
JOIN students s1 ON d1.student_id = s1.student_id
JOIN students s2 ON d2.student_id = s2.student_id
WHERE s1.student_id < s2.student_id;
```


------

#### 5. Get number of courses each student is enrolled in
```sql
SELECT students.name, COUNT(enrollments.course_id) AS course_count
FROM students
JOIN enrollments ON students.student_id = enrollments.student_id
GROUP BY students.name;
```


------

#### 6. Get students enrolled in all courses taught by Dr. Blue
```sql
SELECT s.name
FROM students s
WHERE NOT EXISTS (
  SELECT c.course_id
  FROM courses c
  WHERE c.professor_id = 2
  EXCEPT
  SELECT e.course_id
  FROM enrollments e
  WHERE e.student_id = s.student_id
);
```


------

#### 7. Get professors whose students are enrolled in more than 2 courses
```sql
SELECT DISTINCT professors.name
FROM professors
JOIN courses ON professors.professor_id = courses.professor_id
JOIN enrollments ON courses.course_id = enrollments.course_id
JOIN students ON enrollments.student_id = students.student_id
GROUP BY professors.name, students.student_id
HAVING COUNT(enrollments.course_id) > 2;
```


------

#### 8. Get students who are enrolled in courses from multiple professors
```sql
SELECT students.name
FROM enrollments
JOIN courses ON enrollments.course_id = courses.course_id
JOIN students ON enrollments.student_id = students.student_id
GROUP BY students.name
HAVING COUNT(DISTINCT courses.professor_id) > 1;
```


------

#### 9. Get average number of students per course
```sql
SELECT AVG(student_count) AS avg_students
FROM (
  SELECT COUNT(student_id) AS student_count
  FROM enrollments
  GROUP BY course_id
) AS sub;
```


------

#### 10. Get courses with the highest number of enrollments
```sql
SELECT courses.title, COUNT(enrollments.student_id) AS total_enrolled
FROM courses
JOIN enrollments ON courses.course_id = enrollments.course_id
GROUP BY courses.title
ORDER BY total_enrolled DESC
LIMIT 1;
```


------

#### 11. Get students who live in dorms starting with 'B'
```sql
SELECT students.name
FROM students
JOIN dorms ON students.student_id = dorms.student_id
WHERE dorms.room_number LIKE 'B%';
```


------

#### 12. Get professors who teach only one course
```sql
SELECT name
FROM professors
WHERE professor_id IN (
  SELECT professor_id
  FROM courses
  GROUP BY professor_id
  HAVING COUNT(course_id) = 1
);
```


------

#### 13. Get students who are not in dorms
```sql
SELECT name
FROM students
WHERE student_id NOT IN (SELECT student_id FROM dorms);
```


------

#### 14. Get professors whose students include 'Charlie Lee'
```sql
SELECT DISTINCT professors.name
FROM professors
JOIN courses ON professors.professor_id = courses.professor_id
JOIN enrollments ON courses.course_id = enrollments.course_id
JOIN students ON enrollments.student_id = students.student_id
WHERE students.name = 'Charlie Lee';
```


------

#### 15. Get course titles with number of unique students
```sql
SELECT courses.title, COUNT(DISTINCT enrollments.student_id) AS student_count
FROM courses
JOIN enrollments ON courses.course_id = enrollments.course_id
GROUP BY courses.title;
```


------

#### 16. Get students who are enrolled in exactly 2 courses
```sql
SELECT students.name
FROM enrollments
JOIN students ON enrollments.student_id = students.student_id
GROUP BY students.name
HAVING COUNT(course_id) = 2;
```


------

#### 17. Get professors and number of students they teach
```sql
SELECT professors.name, COUNT(DISTINCT enrollments.student_id) AS student_count
FROM professors
JOIN courses ON professors.professor_id = courses.professor_id
JOIN enrollments ON courses.course_id = enrollments.course_id
GROUP BY professors.name;
```


------

#### 18. Get students who are enrolled in courses taught by professors from 'Mathematics'
```sql
SELECT DISTINCT students.name
FROM students
JOIN enrollments ON students.student_id = enrollments.student_id
JOIN courses ON enrollments.course_id = courses.course_id
JOIN professors ON courses.professor_id = professors.professor_id
WHERE professors.department = 'Mathematics';
```


------

#### 19. Get dorms with students enrolled in more than one course
```sql
SELECT DISTINCT dorms.room_number
FROM dorms
JOIN students ON dorms.student_id = students.student_id
JOIN enrollments ON students.student_id = enrollments.student_id
GROUP BY dorms.room_number, students.student_id
HAVING COUNT(enrollments.course_id) > 1;
```


------

#### 20. Get students who are enrolled in courses taught by more than one professor
```sql
SELECT students.name
FROM enrollments
JOIN courses ON enrollments.course_id = courses.course_id
JOIN students ON enrollments.student_id = students.student_id
GROUP BY students.name
HAVING COUNT(DISTINCT courses.professor_id) > 1;
```

---

