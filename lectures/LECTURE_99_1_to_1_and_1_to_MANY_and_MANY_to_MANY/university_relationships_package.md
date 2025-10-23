# University Data Model with Relationships (One-to-One, One-to-Many, Many-to-Many)

This package demonstrates **one-to-one**, **one-to-many**, and **many-to-many** relationships in MySQL.  
It includes: a short data story, a complete MySQL schema, sample rows, and **60 queries** (20 simple, 20 simple-to-intermediate, 20 intermediate using `WITH` and window/ranking functions).

---

## 📖 Data Story

A **university system** manages students, professors, and courses:

1) Each **student** has exactly one **student profile** holding sensitive info (DOB, national ID). This is a **one-to-one** relationship.  
   - `students` ↔ `student_profiles`

2) Each **professor** can teach multiple **courses**, but each course is taught by exactly one professor. This is a **one-to-many** relationship.  
   - `professors` → `courses`

3) Each **student** can take many **courses**, and each **course** can be taken by many students. This is a **many-to-many** relationship.  
   - Implemented via the junction table `enrollments(student_id, course_id)`

---

## 🗂️ MySQL Schema

```sql
-- Clean start (optional)
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS professors;
DROP TABLE IF EXISTS student_profiles;
DROP TABLE IF EXISTS students;

-- One-to-one: students and student_profiles
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name       VARCHAR(50),
    major      VARCHAR(50)
);

CREATE TABLE student_profiles (
    student_id   INT PRIMARY KEY,
    date_of_birth DATE,
    national_id   VARCHAR(20) UNIQUE,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- One-to-many: professors and courses
CREATE TABLE professors (
    professor_id INT PRIMARY KEY,
    name         VARCHAR(50),
    department   VARCHAR(50)
);

CREATE TABLE courses (
    course_id   INT PRIMARY KEY,
    course_name VARCHAR(50),
    professor_id INT,
    FOREIGN KEY (professor_id) REFERENCES professors(professor_id)
);

-- Many-to-many: students and courses via enrollments
CREATE TABLE enrollments (
    student_id INT,
    course_id  INT,
    grade      CHAR(2),   -- e.g., A, B, C
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id)  REFERENCES courses(course_id)
);
```

---

## 📝 Sample Rows


```sql
-- Students
INSERT INTO students VALUES
(1,'Alice','Computer Science'),
(2,'Bob','Mathematics'),
(3,'Carol','Physics'),
(4,'David','Computer Science'),
(5,'Eva','Biology'),
(6,'Frank','Mathematics'),
(7,'Grace','Physics'),
(8,'Henry','Computer Science'),
(9,'Isabel','Mathematics'),
(10,'Jack','Biology'),
(11,'Kara','Computer Science'),
(12,'Leo','Physics');


-- Student Profiles (1-to-1)
INSERT INTO student_profiles VALUES
(1,'2002-01-10','SSN111'),
(2,'2001-05-22','SSN222'),
(3,'2000-09-12','SSN333'),
(4,'2002-03-15','SSN444'),
(5,'2001-07-19','SSN555'),
(6,'2000-11-02','SSN666'),
(7,'1999-06-30','SSN777'),
(8,'2002-09-09','SSN888'),
(9,'2001-12-01','SSN999'),
(10,'2000-03-23','SSN101'),
(11,'2002-05-05','SSN102'),
(12,'1999-10-15','SSN103');


-- Professors
INSERT INTO professors VALUES
(10,'Dr. Smith','Computer Science'),
(11,'Dr. Johnson','Mathematics'),
(12,'Dr. Brown','Physics'),
(13,'Dr. White','Biology'),
(14,'Dr. Green','Engineering');

-- Courses (one professor teaches many courses)
INSERT INTO courses VALUES
(100,'Databases',10),
(101,'Algorithms',10),
(102,'Operating Systems',10),
(103,'Calculus',11),
(104,'Linear Algebra',11),
(105,'Quantum Mechanics',12),
(106,'Thermodynamics',12),
(107,'Genetics',13),
(108,'Ecology',13);

-- Enrollments (many-to-many)
INSERT INTO enrollments VALUES
(1,100,'A'),
(1,101,'B'),
(1,103,'A'),
(2,103,'A'),
(2,104,'B'),
(3,105,'C'),
(3,106,'B'),
(4,100,'C'),
(4,102,'B'),
(4,103,'B'),
(5,107,'A'),
(5,108,'B'),
(6,103,'C'),
(6,104,'B'),
(7,105,'B'),
(7,106,'A'),
(8,100,'A'),
(8,101,'A'),
(8,102,'B'),
(9,103,'A'),
(9,104,'A'),
(10,107,'C'),
(10,108,'B'),
(11,100,'A'),
(11,102,'A'),
(11,106,'B'),
(12,105,'A'),
(12,106,'A'),
(12,104,'C'),
(2,100,'B'),
(6,101,'A'),
(9,102,'B'),
(10,103,'B');
```

---

# 🔎 SQL Queries

Below are **60 queries**:  
- **20 Simple** (read/filters and basic joins)  
- **20 Simple-to-Intermediate** (GROUP BY, HAVING, left joins)  
- **20 Intermediate** (CTEs with `WITH`, window functions such as `ROW_NUMBER`, `RANK`, `DENSE_RANK`)

Where relevant, notes indicate which relationship the query showcases.

---

## ✅ 20 Simple Queries

1) **Show all students.**  
```sql
SELECT * FROM students;
```

2) **Show all professors.**  
```sql
SELECT * FROM professors;
```

3) **Show all courses.**  
```sql
SELECT * FROM courses;
```

4) **Show all enrollments.** (many-to-many bridge)  
```sql
SELECT * FROM enrollments;
```

5) **Show all student profiles.** (one-to-one)  
```sql
SELECT * FROM student_profiles;
```

6) **List student names and majors.**  
```sql
SELECT name, major FROM students;
```

7) **List professor names and departments.**  
```sql
SELECT name, department FROM professors;
```

8) **List course names only.**  
```sql
SELECT course_name FROM courses;
```

9) **Find Alice’s profile.** (one-to-one join)  
```sql
SELECT s.name, p.*
FROM students s
JOIN student_profiles p ON s.student_id = p.student_id
WHERE s.name = 'Alice';
```

10) **Find courses taught by professor_id = 10.** (one-to-many)  
```sql
SELECT * FROM courses WHERE professor_id = 10;
```

11) **Find all Computer Science majors.**  
```sql
SELECT * FROM students WHERE major = 'Computer Science';
```

12) **Find all Physics majors.**  
```sql
SELECT * FROM students WHERE major = 'Physics';
```

13) **Show students born before 2001-01-01.** (one-to-one join + filter)  
```sql
SELECT s.name, p.date_of_birth
FROM students s
JOIN student_profiles p ON s.student_id = p.student_id
WHERE p.date_of_birth < '2001-01-01';
```

14) **Professor teaching 'Databases'.** (one-to-many join)  
```sql
SELECT p.name AS professor
FROM professors p
JOIN courses c ON p.professor_id = c.professor_id
WHERE c.course_name = 'Databases';
```

15) **Students in course 100.** (many-to-many via enrollments)  
```sql
SELECT s.name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
WHERE e.course_id = 100;
```

16) **All students with their grades (any course).** (many-to-many)  
```sql
SELECT s.name, e.course_id, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id;
```

17) **Students and national IDs.** (one-to-one)  
```sql
SELECT s.name, p.national_id
FROM students s
JOIN student_profiles p ON s.student_id = p.student_id;
```

18) **Distinct majors available.**  
```sql
SELECT DISTINCT major FROM students;
```

19) **Courses with their professor IDs.**  
```sql
SELECT course_name, professor_id FROM courses;
```

20) **All enrollments for student_id = 1.**  
```sql
SELECT * FROM enrollments WHERE student_id = 1;
```

---

## 🔷 20 Simple-to-Intermediate Queries

1) **Professors and the number of courses they teach.** (one-to-many)  
```sql
SELECT p.name, COUNT(c.course_id) AS num_courses
FROM professors p
LEFT JOIN courses c ON p.professor_id = c.professor_id
GROUP BY p.name;
```

2) **Students and how many courses each is enrolled in.** (many-to-many)  
```sql
SELECT s.name, COUNT(e.course_id) AS num_courses
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.name;
```

3) **Students enrolled in more than one course.** (many-to-many + HAVING)  
```sql
SELECT s.name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.name
HAVING COUNT(e.course_id) > 1;
```

4) **Courses and how many students enrolled.** (many-to-many)  
```sql
SELECT c.course_name, COUNT(e.student_id) AS num_students
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;
```

5) **Number of students per major.**  
```sql
SELECT major, COUNT(*) AS num_students
FROM students
GROUP BY major;
```

6) **Number of professors per department.**  
```sql
SELECT department, COUNT(*) AS num_professors
FROM professors
GROUP BY department;
```

7) **Average age of students by major.** (one-to-one + GROUP BY)  
```sql
SELECT s.major, AVG(TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE())) AS avg_age
FROM students s
JOIN student_profiles p ON s.student_id = p.student_id
GROUP BY s.major;
```

8) **Courses and their professor names.** (one-to-many join)  
```sql
SELECT c.course_name, p.name AS professor_name
FROM courses c
JOIN professors p ON c.professor_id = p.professor_id;
```

9) **Student names and the course names they’re enrolled in.** (many-to-many)  
```sql
SELECT s.name, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;
```

10) **Students enrolled in 'Databases'.** (many-to-many)  
```sql
SELECT s.name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Databases';
```

11) **Students and their grades in 'Calculus'.** (many-to-many)  
```sql
SELECT s.name, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Calculus';
```

12) **Professor → course → student chain.** (all three tables)  
```sql
SELECT p.name AS professor, c.course_name, s.name AS student
FROM professors p
JOIN courses c ON p.professor_id = c.professor_id
JOIN enrollments e ON c.course_id = e.course_id
JOIN students s ON e.student_id = s.student_id;
```

13) **Number of courses taken by students, grouped by major.**  
```sql
SELECT s.major, COUNT(e.course_id) AS num_courses
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.major;
```

14) **Students NOT enrolled in any course.** (anti-join)  
```sql
SELECT s.name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.course_id IS NULL;
```

15) **Courses with NO students enrolled.** (anti-join)  
```sql
SELECT c.course_name
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE e.student_id IS NULL;
```

16) **Average grade per course (A=4, B=3, C=2).**  
```sql
SELECT c.course_name,
       AVG(CASE e.grade WHEN 'A' THEN 4 WHEN 'B' THEN 3 WHEN 'C' THEN 2 END) AS avg_grade
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;
```

17) **(Illustration) Count students by a code derived from national_id.**  
```sql
SELECT SUBSTRING(p.national_id,1,3) AS id_prefix,
       COUNT(*) AS num_students
FROM student_profiles p
GROUP BY id_prefix;
```

18) **Professors who teach more than one course.**  
```sql
SELECT p.name
FROM professors p
JOIN courses c ON p.professor_id = c.professor_id
GROUP BY p.name
HAVING COUNT(c.course_id) > 1;
```

19) **Majors where average student age < 22.**  
```sql
SELECT s.major
FROM students s
JOIN student_profiles p ON s.student_id = p.student_id
GROUP BY s.major
HAVING AVG(TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE())) < 22;
```

20) **Courses with professor name and number of enrolled students.**  
```sql
SELECT c.course_name, p.name AS professor, COUNT(e.student_id) AS num_students
FROM courses c
JOIN professors p ON c.professor_id = p.professor_id
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name, p.name;
```

---

## 🧠 20 Intermediate Queries (CTEs + Ranking)

> We’ll map grades to points: **A=4, B=3, C=2** for GPA-style calculations where needed.

1) **Top student per course by grade (uses `ROW_NUMBER`).**  
```sql
WITH graded AS (
  SELECT e.student_id, e.course_id,
         CASE e.grade WHEN 'A' THEN 4 WHEN 'B' THEN 3 WHEN 'C' THEN 2 END AS pts
  FROM enrollments e
),
ranked AS (
  SELECT g.*, ROW_NUMBER() OVER (PARTITION BY g.course_id ORDER BY g.pts DESC) AS rn
  FROM graded g
)
SELECT s.name, c.course_name, r.pts AS grade_points
FROM ranked r
JOIN students s ON r.student_id = s.student_id
JOIN courses c  ON r.course_id  = c.course_id
WHERE r.rn = 1;
```

2) **Top professor by number of students taught.**  
```sql
WITH prof_students AS (
  SELECT p.professor_id, COUNT(e.student_id) AS total_students
  FROM professors p
  JOIN courses c ON p.professor_id = c.professor_id
  JOIN enrollments e ON c.course_id = e.course_id
  GROUP BY p.professor_id
)
SELECT p.name, ps.total_students
FROM prof_students ps
JOIN professors p ON ps.professor_id = p.professor_id
ORDER BY ps.total_students DESC
LIMIT 1;
```

3) **Rank students by number of courses taken.**  
```sql
WITH student_counts AS (
  SELECT s.student_id, s.name, COUNT(e.course_id) AS num_courses
  FROM students s
  LEFT JOIN enrollments e ON s.student_id = e.student_id
  GROUP BY s.student_id, s.name
)
SELECT *, RANK() OVER (ORDER BY num_courses DESC) AS course_rank
FROM student_counts;
```

4) **Students with highest average grade (GPA).**  
```sql
WITH gpa_calc AS (
  SELECT student_id, AVG(CASE grade WHEN 'A' THEN 4 WHEN 'B' THEN 3 WHEN 'C' THEN 2 END) AS gpa
  FROM enrollments
  GROUP BY student_id
)
SELECT s.name, g.gpa
FROM gpa_calc g
JOIN students s ON g.student_id = s.student_id
ORDER BY g.gpa DESC;
```

5) **Professor(s) teaching the most courses.**  
```sql
WITH prof_course_counts AS (
  SELECT professor_id, COUNT(*) AS num_courses
  FROM courses
  GROUP BY professor_id
)
SELECT p.name, pc.num_courses
FROM prof_course_counts pc
JOIN professors p ON pc.professor_id = p.professor_id
WHERE pc.num_courses = (SELECT MAX(num_courses) FROM prof_course_counts);
```

6) **Youngest student(s) (by latest DOB).**  
```sql
WITH ages AS (
  SELECT s.name, p.date_of_birth,
         RANK() OVER (ORDER BY p.date_of_birth DESC) AS rnk
  FROM students s
  JOIN student_profiles p ON s.student_id = p.student_id
)
SELECT name, date_of_birth FROM ages WHERE rnk = 1;
```

7) **Course(s) with the maximum number of students.**  
```sql
WITH course_counts AS (
  SELECT course_id, COUNT(student_id) AS num_students
  FROM enrollments
  GROUP BY course_id
)
SELECT c.course_name, cc.num_students
FROM course_counts cc
JOIN courses c ON cc.course_id = c.course_id
WHERE cc.num_students = (SELECT MAX(num_students) FROM course_counts);
```

8) **Rank students by GPA.**  
```sql
WITH gpa_calc AS (
  SELECT student_id, AVG(CASE grade WHEN 'A' THEN 4 WHEN 'B' THEN 3 WHEN 'C' THEN 2 END) AS gpa
  FROM enrollments
  GROUP BY student_id
)
SELECT s.name, g.gpa,
       RANK() OVER (ORDER BY g.gpa DESC) AS gpa_rank
FROM gpa_calc g
JOIN students s ON g.student_id = s.student_id;
```

9) **Top 2 students per major by GPA.**  
```sql
WITH gpa_calc AS (
  SELECT s.major, s.student_id, s.name,
         AVG(CASE e.grade WHEN 'A' THEN 4 WHEN 'B' THEN 3 WHEN 'C' THEN 2 END) AS gpa
  FROM students s
  JOIN enrollments e ON s.student_id = e.student_id
  GROUP BY s.major, s.student_id, s.name
),
ranked AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY major ORDER BY gpa DESC) AS rn
  FROM gpa_calc
)
SELECT major, name, gpa
FROM ranked
WHERE rn <= 2;
```

10) **Majors ranked by average GPA.**  
```sql
WITH gpa_by_major AS (
  SELECT s.major,
         AVG(CASE e.grade WHEN 'A' THEN 4 WHEN 'B' THEN 3 WHEN 'C' THEN 2 END) AS avg_gpa
  FROM students s
  JOIN enrollments e ON s.student_id = e.student_id
  GROUP BY s.major
)
SELECT major, avg_gpa,
       RANK() OVER (ORDER BY avg_gpa DESC) AS rnk
FROM gpa_by_major;
```

11) **Professor(s) whose courses have the highest average grade.**  
```sql
WITH prof_grades AS (
  SELECT p.professor_id,
         AVG(CASE e.grade WHEN 'A' THEN 4 WHEN 'B' THEN 3 WHEN 'C' THEN 2 END) AS avg_grade
  FROM professors p
  JOIN courses c ON p.professor_id = c.professor_id
  JOIN enrollments e ON c.course_id = e.course_id
  GROUP BY p.professor_id
)
SELECT p.name, pg.avg_grade
FROM prof_grades pg
JOIN professors p ON pg.professor_id = p.professor_id
WHERE pg.avg_grade = (SELECT MAX(avg_grade) FROM prof_grades);
```

12) **Students with no enrollments (CTE version).**  
```sql
WITH student_enrolled AS (
  SELECT s.student_id, COUNT(e.course_id) AS num_courses
  FROM students s
  LEFT JOIN enrollments e ON s.student_id = e.student_id
  GROUP BY s.student_id
)
SELECT s.name
FROM student_enrolled se
JOIN students s ON se.student_id = s.student_id
WHERE se.num_courses = 0;
```

13) **Rank professors by number of students taught.**  
```sql
WITH prof_students AS (
  SELECT p.professor_id, COUNT(e.student_id) AS total_students
  FROM professors p
  JOIN courses c ON p.professor_id = c.professor_id
  JOIN enrollments e ON c.course_id = e.course_id
  GROUP BY p.professor_id
)
SELECT p.name, ps.total_students,
       RANK() OVER (ORDER BY ps.total_students DESC) AS rnk
FROM prof_students ps
JOIN professors p ON ps.professor_id = p.professor_id;
```

14) **Course(s) with the fewest enrollments.**  
```sql
WITH course_counts AS (
  SELECT course_id, COUNT(student_id) AS num_students
  FROM enrollments
  GROUP BY course_id
)
SELECT c.course_name, cc.num_students
FROM course_counts cc
JOIN courses c ON cc.course_id = c.course_id
WHERE cc.num_students = (SELECT MIN(num_students) FROM course_counts);
```

15) **Top student per major by GPA (ROW_NUMBER).**  
```sql
WITH gpa_calc AS (
  SELECT s.major, s.student_id, s.name,
         AVG(CASE e.grade WHEN 'A' THEN 4 WHEN 'B' THEN 3 WHEN 'C' THEN 2 END) AS gpa
  FROM students s
  JOIN enrollments e ON s.student_id = e.student_id
  GROUP BY s.major, s.student_id, s.name
),
ranked AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY major ORDER BY gpa DESC) AS rn
  FROM gpa_calc
)
SELECT major, name, gpa
FROM ranked
WHERE rn = 1;
```

16) **Students who scored 'A' in at least one course.**  
```sql
WITH a_students AS (
  SELECT DISTINCT student_id
  FROM enrollments
  WHERE grade = 'A'
)
SELECT s.name
FROM a_students a
JOIN students s ON a.student_id = s.student_id;
```

17) **Students enrolled in *all* courses taught by Dr. Smith.** (set division pattern)  
```sql
WITH smith_courses AS (
  SELECT c.course_id
  FROM courses c
  JOIN professors p ON c.professor_id = p.professor_id
  WHERE p.name = 'Dr. Smith'
),
student_coverage AS (
  SELECT e.student_id, COUNT(DISTINCT e.course_id) AS cnt
  FROM enrollments e
  JOIN smith_courses sc ON e.course_id = sc.course_id
  GROUP BY e.student_id
),
required AS (
  SELECT COUNT(*) AS needed FROM smith_courses
)
SELECT s.name
FROM student_coverage x
JOIN required r ON x.cnt = r.needed
JOIN students s ON s.student_id = x.student_id;
```

18) **Courses with average grade ≥ 3.5 (≈ between A and B+), ranked by average.**  
```sql
WITH course_avg AS (
  SELECT c.course_id, c.course_name,
         AVG(CASE e.grade WHEN 'A' THEN 4 WHEN 'B' THEN 3 WHEN 'C' THEN 2 END) AS avg_pts
  FROM courses c
  JOIN enrollments e ON c.course_id = e.course_id
  GROUP BY c.course_id, c.course_name
)
SELECT course_name, avg_pts,
       RANK() OVER (ORDER BY avg_pts DESC) AS rnk
FROM course_avg
WHERE avg_pts >= 3.5;
```

19) **Within each course, show each student’s grade and their rank (ties get same rank).**  
```sql
WITH graded AS (
  SELECT e.student_id, e.course_id,
         CASE e.grade WHEN 'A' THEN 4 WHEN 'B' THEN 3 WHEN 'C' THEN 2 END AS pts
  FROM enrollments e
),
ranked AS (
  SELECT g.*, DENSE_RANK() OVER (PARTITION BY g.course_id ORDER BY g.pts DESC) AS rnk
  FROM graded g
)
SELECT c.course_name, s.name, r.pts AS grade_points, r.rnk
FROM ranked r
JOIN students s ON r.student_id = s.student_id
JOIN courses  c ON r.course_id  = c.course_id
ORDER BY c.course_name, r.rnk, s.name;
```

20) **Students whose GPA is above the overall average GPA.**  
```sql
WITH student_gpa AS (
  SELECT student_id,
         AVG(CASE grade WHEN 'A' THEN 4 WHEN 'B' THEN 3 WHEN 'C' THEN 2 END) AS gpa
  FROM enrollments
  GROUP BY student_id
),
overall AS (
  SELECT AVG(gpa) AS overall_gpa FROM student_gpa
)
SELECT s.name, sg.gpa
FROM student_gpa sg
CROSS JOIN overall o
JOIN students s ON s.student_id = sg.student_id
WHERE sg.gpa > o.overall_gpa
ORDER BY sg.gpa DESC;
```

---

## ✅ Notes on Relationships Covered

- **One-to-one (`students` ↔ `student_profiles`)**: Queries 9, 13, 17 (simple); 7 (avg age by major), 19 (majors avg age), etc.  
- **One-to-many (`professors` → `courses`)**: Queries 10, 14 (simple); 1, 6, 8, 12, 18, 20 (s2i); 5, 11, 13 (intermediate).  
- **Many-to-many (`students` ↔ `enrollments` ↔ `courses`)**: Queries 15, 16 (simple); 2–4, 9–12, 13–16, 20 (s2i); 1–4, 7–10, 14–20 (intermediate).

---

Happy querying! 🎓
