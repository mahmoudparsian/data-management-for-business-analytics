Absolutely! Here's the schema I used to design all 80 SQL queries — it's a classic student-course-enrollment setup, simple but powerful for teaching relational joins, aggregations, and subqueries.

---

### 🗂️ Database Schema

#### 🧑‍🎓 `students`
Stores basic student information.

```sql
CREATE TABLE students (
  student_id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  major VARCHAR(100),
  year INT
);
```

#### 📚 `courses`
Stores course details including semester.

```sql
CREATE TABLE courses (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(100),
  department VARCHAR(100),
  semester VARCHAR(20)
);
```

#### 📝 `enrollments`
Tracks which students are enrolled in which courses.

```sql
CREATE TABLE enrollments (
  enrollment_id INT PRIMARY KEY,
  student_id INT,
  course_id INT,
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
```

---

This schema supports:
- Many-to-many relationships between students and courses
- Semester-based filtering
- Aggregations like course popularity and student load
- Advanced logic like “students who took all AI courses”

Let me know if you’d like sample data inserts or a downloadable SQL file to go with this!


Perfect — here’s a full batch of 20 instructor-level SQL queries with English prompts and answers. These are designed to cover a wide range of beginner-to-intermediate SQL concepts using realistic student/course/enrollment data.


INSERT INTO students (student_id, name, email, major, year) VALUES
(1, 'Alice Johnson', 'alice.johnson@example.edu', 'Computer Science', 2025),
(2, 'Bob Smith', 'bob.smith@example.edu', 'Electrical Engineering', 2026),
(3, 'Carol Lee', 'carol.lee@example.edu', 'Data Science', 2025),
(4, 'David Kim', 'david.kim@example.edu', 'Cybersecurity', 2026),
(5, 'Eva Brown', 'eva.brown@example.edu', 'Software Engineering', 2025);


INSERT INTO courses (course_id, course_name, department, semester) VALUES
(101, 'Intro to Programming', 'CS', 'Fall 2025'),
(102, 'Data Structures', 'CS', 'Spring 2026'),
(103, 'Operating Systems', 'CS', 'Fall 2025'),
(104, 'Machine Learning', 'DS', 'Spring 2026'),
(105, 'Cybersecurity', 'IT', 'Fall 2025'),
(106, 'Advanced Algorithms', 'CS', 'Spring 2026'),
(107, 'Networks', 'EE', 'Fall 2025'),
(108, 'Cloud Computing', 'IT', 'Spring 2026');

INSERT INTO enrollments (enrollment_id, student_id, course_id) VALUES
(1001, 1, 101),
(1002, 1, 102),
(1003, 1, 104),
(1004, 2, 101),
(1005, 2, 103),
(1006, 2, 107),
(1007, 3, 102),
(1008, 3, 104),
(1009, 3, 106),
(1010, 4, 105),
(1011, 4, 108),
(1012, 5, 101),
(1013, 5, 103),
(1014, 5, 106);


---

### 🧠 Instructor SQL Queries (1–20)

1. **List all students.**
   ```sql
   SELECT * FROM students;
   ```

2. **Find all courses offered in Fall 2025.**
   ```sql
   SELECT * FROM courses WHERE semester = 'Fall 2025';
   ```

3. **Show names of students enrolled in 'Data Structures'.**
   ```sql
   SELECT s.name
   FROM students s
   JOIN enrollments e ON s.student_id = e.student_id
   JOIN courses c ON e.course_id = c.course_id
   WHERE c.course_name = 'Data Structures';
   ```

4. **Count how many students are enrolled in each course.**
   ```sql
   SELECT c.course_name, COUNT(e.student_id) AS enrollment_count
   FROM courses c
   JOIN enrollments e ON c.course_id = e.course_id
   GROUP BY c.course_name;
   ```

5. **Find students who are enrolled in more than 3 courses.**
   ```sql
   SELECT s.name
   FROM students s
   JOIN enrollments e ON s.student_id = e.student_id
   GROUP BY s.name
   HAVING COUNT(e.course_id) > 3;
   ```

6. **List courses that have fewer than 10 students enrolled.**
   ```sql
   SELECT c.course_name
   FROM courses c
   JOIN enrollments e ON c.course_id = e.course_id
   GROUP BY c.course_name
   HAVING COUNT(e.student_id) < 10;
   ```

7. **Show student names and the number of courses they are enrolled in.**
   ```sql
   SELECT s.name, COUNT(e.course_id) AS course_count
   FROM students s
   JOIN enrollments e ON s.student_id = e.student_id
   GROUP BY s.name;
   ```

8. **Find courses that no students are enrolled in.**
   ```sql
   SELECT c.course_name
   FROM courses c
   LEFT JOIN enrollments e ON c.course_id = e.course_id
   WHERE e.student_id IS NULL;
   ```

9. **List all students and their enrolled course names.**
   ```sql
   SELECT s.name AS student_name, c.course_name
   FROM students s
   JOIN enrollments e ON s.student_id = e.student_id
   JOIN courses c ON e.course_id = c.course_id;
   ```

10. **Find the most popular course by enrollment.**
   ```sql
   SELECT c.course_name, COUNT(e.student_id) AS enrollment_count
   FROM courses c
   JOIN enrollments e ON c.course_id = e.course_id
   GROUP BY c.course_name
   ORDER BY enrollment_count DESC
   LIMIT 1;
   ```

11. **Show students who are not enrolled in any course.**
   ```sql
   SELECT s.name
   FROM students s
   LEFT JOIN enrollments e ON s.student_id = e.student_id
   WHERE e.course_id IS NULL;
   ```

12. **List all courses and the average number of students per course.**
   ```sql
   SELECT c.course_name, COUNT(e.student_id) AS student_count
   FROM courses c
   JOIN enrollments e ON c.course_id = e.course_id
   GROUP BY c.course_name;
   ```

13. **Find students enrolled in both 'Algorithms' and 'Operating Systems'.**
   ```sql
   SELECT s.name
   FROM students s
   JOIN enrollments e1 ON s.student_id = e1.student_id
   JOIN courses c1 ON e1.course_id = c1.course_id
   JOIN enrollments e2 ON s.student_id = e2.student_id
   JOIN courses c2 ON e2.course_id = c2.course_id
   WHERE c1.course_name = 'Algorithms' AND c2.course_name = 'Operating Systems';
   ```

14. **Show the number of courses offered each semester.**
   ```sql
   SELECT semester, COUNT(course_id) AS course_count
   FROM courses
   GROUP BY semester;
   ```

15. **Find students who are enrolled in exactly 2 courses.**
   ```sql
   SELECT s.name
   FROM students s
   JOIN enrollments e ON s.student_id = e.student_id
   GROUP BY s.name
   HAVING COUNT(e.course_id) = 2;
   ```

16. **List course names and the number of unique students enrolled.**
   ```sql
   SELECT c.course_name, COUNT(DISTINCT e.student_id) AS unique_students
   FROM courses c
   JOIN enrollments e ON c.course_id = e.course_id
   GROUP BY c.course_name;
   ```

17. **Show all students enrolled in courses taught in Spring 2026.**
   ```sql
   SELECT DISTINCT s.name
   FROM students s
   JOIN enrollments e ON s.student_id = e.student_id
   JOIN courses c ON e.course_id = c.course_id
   WHERE c.semester = 'Spring 2026';
   ```

18. **Find the course with the least number of enrollments.**
   ```sql
   SELECT c.course_name, COUNT(e.student_id) AS enrollment_count
   FROM courses c
   JOIN enrollments e ON c.course_id = e.course_id
   GROUP BY c.course_name
   ORDER BY enrollment_count ASC
   LIMIT 1;
   ```

19. **Show all students and the semesters they are enrolled in.**
   ```sql
   SELECT DISTINCT s.name, c.semester
   FROM students s
   JOIN enrollments e ON s.student_id = e.student_id
   JOIN courses c ON e.course_id = c.course_id;
   ```

20. **List students who are enrolled in every course offered in Fall 2025.**
   ```sql
   SELECT s.name
   FROM students s
   WHERE NOT EXISTS (
     SELECT c.course_id
     FROM courses c
     WHERE c.semester = 'Fall 2025'
     EXCEPT
     SELECT e.course_id
     FROM enrollments e
     WHERE e.student_id = s.student_id
   );
   ```

---

Let me know if you’d like the next batch (21–40), or if you’d prefer the full set in a downloadable markdown file instead.

Awesome — here’s the next batch of 20 instructor-level SQL queries (21–40), continuing from the previous set:

---

### 🧠 Instructor SQL Queries (21–40)

21. **Find students enrolled in courses with “Advanced” in the title.**
   ```sql
   SELECT DISTINCT s.name
   FROM students s
   JOIN enrollments e ON s.student_id = e.student_id
   JOIN courses c ON e.course_id = c.course_id
   WHERE c.course_name LIKE '%Advanced%';
   ```

22. **List all semesters in which 'Machine Learning' was offered.**
   ```sql
   SELECT DISTINCT semester
   FROM courses
   WHERE course_name = 'Machine Learning';
   ```

23. **Show the number of students enrolled per semester.**
   ```sql
   SELECT c.semester, COUNT(DISTINCT e.student_id) AS student_count
   FROM courses c
   JOIN enrollments e ON c.course_id = e.course_id
   GROUP BY c.semester;
   ```

24. **Find students who have taken both 'Intro to Programming' and 'Databases'.**
   ```sql
   SELECT s.name
   FROM students s
   JOIN enrollments e1 ON s.student_id = e1.student_id
   JOIN courses c1 ON e1.course_id = c1.course_id
   JOIN enrollments e2 ON s.student_id = e2.student_id
   JOIN courses c2 ON e2.course_id = c2.course_id
   WHERE c1.course_name = 'Intro to Programming' AND c2.course_name = 'Databases';
   ```

25. **List courses with more than 20 students enrolled.**
   ```sql
   SELECT c.course_name
   FROM courses c
   JOIN enrollments e ON c.course_id = e.course_id
   GROUP BY c.course_name
   HAVING COUNT(e.student_id) > 20;
   ```

26. **Show students enrolled in courses in both Fall and Spring semesters.**
   ```sql
   SELECT s.name
   FROM students s
   JOIN enrollments e ON s.student_id = e.student_id
   JOIN courses c ON e.course_id = c.course_id
   GROUP BY s.name
   HAVING COUNT(DISTINCT c.semester) > 1;
   ```

27. **Find the average number of courses per student.**
   ```sql
   SELECT AVG(course_count) AS avg_courses
   FROM (
     SELECT COUNT(e.course_id) AS course_count
     FROM enrollments e
     GROUP BY e.student_id
   ) AS sub;
   ```

28. **List students who have taken a course in every semester offered.**
   ```sql
   SELECT s.name
   FROM students s
   WHERE NOT EXISTS (
     SELECT DISTINCT semester
     FROM courses
     EXCEPT
     SELECT DISTINCT c.semester
     FROM enrollments e
     JOIN courses c ON e.course_id = c.course_id
     WHERE e.student_id = s.student_id
   );
   ```

29. **Show courses with the same number of enrollments.**
   ```sql
   SELECT c.course_name, COUNT(e.student_id) AS enrollment_count
   FROM courses c
   JOIN enrollments e ON c.course_id = e.course_id
   GROUP BY c.course_name
   HAVING COUNT(e.student_id) IN (
     SELECT COUNT(e.student_id)
     FROM enrollments e
     GROUP BY e.course_id
     HAVING COUNT(e.student_id) > 1
   );
   ```

30. **Find students who have taken only one course.**
   ```sql
   SELECT s.name
   FROM students s
   JOIN enrollments e ON s.student_id = e.student_id
   GROUP BY s.name
   HAVING COUNT(e.course_id) = 1;
   ```

31. **List courses that have been offered more than once.**
   ```sql
   SELECT course_name
   FROM courses
   GROUP BY course_name
   HAVING COUNT(course_id) > 1;
   ```

32. **Show students who have taken courses only in Spring semesters.**
   ```sql
   SELECT s.name
   FROM students s
   WHERE NOT EXISTS (
     SELECT e.course_id
     FROM enrollments e
     JOIN courses c ON e.course_id = c.course_id
     WHERE e.student_id = s.student_id AND c.semester NOT LIKE 'Spring%'
   );
   ```

33. **Find the course with the highest number of unique students.**
   ```sql
   SELECT c.course_name, COUNT(DISTINCT e.student_id) AS unique_students
   FROM courses c
   JOIN enrollments e ON c.course_id = e.course_id
   GROUP BY c.course_name
   ORDER BY unique_students DESC
   LIMIT 1;
   ```

34. **List students who have taken courses with the word “Systems” in the title.**
   ```sql
   SELECT DISTINCT s.name
   FROM students s
   JOIN enrollments e ON s.student_id = e.student_id
   JOIN courses c ON e.course_id = c.course_id
   WHERE c.course_name LIKE '%Systems%';
   ```

35. **Show the total number of enrollments per student.**
   ```sql
   SELECT s.name, COUNT(e.course_id) AS total_enrollments
   FROM students s
   JOIN enrollments e ON s.student_id = e.student_id
   GROUP BY s.name;
   ```

36. **Find students who have taken courses in exactly two different semesters.**
   ```sql
   SELECT s.name
   FROM students s
   JOIN enrollments e ON s.student_id = e.student_id
   JOIN courses c ON e.course_id = c.course_id
   GROUP BY s.name
   HAVING COUNT(DISTINCT c.semester) = 2;
   ```

37. **List courses with no duplicate titles.**
   ```sql
   SELECT course_name
   FROM courses
   GROUP BY course_name
   HAVING COUNT(course_id) = 1;
   ```

38. **Show students who have taken all courses with “Intro” in the title.**
   ```sql
   SELECT s.name
   FROM students s
   WHERE NOT EXISTS (
     SELECT c.course_id
     FROM courses c
     WHERE c.course_name LIKE '%Intro%'
     EXCEPT
     SELECT e.course_id
     FROM enrollments e
     WHERE e.student_id = s.student_id
   );
   ```

39. **Find the average number of students per course.**
   ```sql
   SELECT AVG(student_count) AS avg_students
   FROM (
     SELECT COUNT(e.student_id) AS student_count
     FROM enrollments e
     GROUP BY e.course_id
   ) AS sub;
   ```

40. **List students who have taken courses in both 2025 and 2026.**
   ```sql
   SELECT s.name
   FROM students s
   JOIN enrollments e ON s.student_id = e.student_id
   JOIN courses c ON e.course_id = c.course_id
   GROUP BY s.name
   HAVING COUNT(DISTINCT SUBSTRING(c.semester, -4)) >= 2;
   ```

---

Let me know if you’d like the next batch (41–60), or if you’d prefer the full set in a downloadable markdown file.

You're on a roll — here’s the next batch of 20 instructor-level SQL queries (41–60):

---

### 🧠 Instructor SQL Queries (41–60)

41. **Find students who have taken courses with the word “Engineering” in the title.**
```sql
SELECT DISTINCT s.name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name LIKE '%Engineering%';
```

42. **Show the number of students enrolled in each semester.**
```sql
SELECT c.semester, COUNT(DISTINCT e.student_id) AS student_count
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.semester;
```

43. **List students who have taken courses in only one semester.**
```sql
SELECT s.name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
GROUP BY s.name
HAVING COUNT(DISTINCT c.semester) = 1;
```

44. **Find courses that were offered in both 2025 and 2026.**
```sql
SELECT course_name
FROM courses
WHERE semester LIKE '%2025%'
INTERSECT
SELECT course_name
FROM courses
WHERE semester LIKE '%2026%';
```

45. **Show students who have taken more than one course with the same title.**
```sql
SELECT s.name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
GROUP BY s.name, c.course_name
HAVING COUNT(*) > 1;
```

46. **List all course titles and how many times each has been offered.**
```sql
SELECT course_name, COUNT(*) AS times_offered
FROM courses
GROUP BY course_name;
```

47. **Find students who have taken courses in every Spring semester.**
```sql
SELECT s.name
FROM students s
WHERE NOT EXISTS (
  SELECT DISTINCT semester
  FROM courses
  WHERE semester LIKE 'Spring%'
  EXCEPT
  SELECT DISTINCT c.semester
  FROM enrollments e
  JOIN courses c ON e.course_id = c.course_id
  WHERE e.student_id = s.student_id AND c.semester LIKE 'Spring%'
);
```

48. **Show the most frequently offered course title.**
```sql
SELECT course_name, COUNT(*) AS times_offered
FROM courses
GROUP BY course_name
ORDER BY times_offered DESC
LIMIT 1;
```

49. **List students who have taken courses with duplicate titles across semesters.**
```sql
SELECT DISTINCT s.name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name IN (
  SELECT course_name
  FROM courses
  GROUP BY course_name
  HAVING COUNT(*) > 1
);
```

50. **Find students who have taken courses in every semester except Fall 2025.**
```sql
SELECT s.name
FROM students s
WHERE NOT EXISTS (
  SELECT DISTINCT semester
  FROM courses
  WHERE semester != 'Fall 2025'
  EXCEPT
  SELECT DISTINCT c.semester
  FROM enrollments e
  JOIN courses c ON e.course_id = c.course_id
  WHERE e.student_id = s.student_id AND c.semester != 'Fall 2025'
);
```

51. **Show the average number of semesters per student.**
```sql
SELECT AVG(semester_count) AS avg_semesters
FROM (
  SELECT COUNT(DISTINCT c.semester) AS semester_count
  FROM enrollments e
  JOIN courses c ON e.course_id = c.course_id
  GROUP BY e.student_id
) AS sub;
```

52. **List courses that have been taken by every student.**
```sql
SELECT c.course_name
FROM courses c
WHERE NOT EXISTS (
  SELECT s.student_id
  FROM students s
  EXCEPT
  SELECT e.student_id
  FROM enrollments e
  WHERE e.course_id = c.course_id
);
```

53. **Find students who have taken all courses with “Data” in the title.**
```sql
SELECT s.name
FROM students s
WHERE NOT EXISTS (
  SELECT c.course_id
  FROM courses c
  WHERE c.course_name LIKE '%Data%'
  EXCEPT
  SELECT e.course_id
  FROM enrollments e
  WHERE e.student_id = s.student_id
);
```

54. **Show the number of students who have taken courses in both Fall and Spring semesters.**
```sql
SELECT COUNT(*) AS student_count
FROM (
  SELECT s.student_id
  FROM students s
  JOIN enrollments e ON s.student_id = e.student_id
  JOIN courses c ON e.course_id = c.course_id
  GROUP BY s.student_id
  HAVING COUNT(DISTINCT c.semester) > 1
) AS sub;
```

55. **List students who have taken courses with the same title in different semesters.**
```sql
SELECT s.name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
GROUP BY s.name, c.course_name
HAVING COUNT(DISTINCT c.semester) > 1;
```

56. **Find courses that have been taken by students in every semester.**
```sql
SELECT c.course_name
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
JOIN students s ON e.student_id = s.student_id
GROUP BY c.course_name
HAVING COUNT(DISTINCT c.semester) = (
  SELECT COUNT(DISTINCT semester) FROM courses
);
```

57. **Show students who have taken courses with “AI” or “Artificial Intelligence” in the title.**
```sql
SELECT DISTINCT s.name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name LIKE '%AI%' OR c.course_name LIKE '%Artificial Intelligence%';
```

58. **List students who have taken courses in every year offered.**
```sql
SELECT s.name
FROM students s
WHERE NOT EXISTS (
  SELECT DISTINCT SUBSTRING(semester, -4)
  FROM courses
  EXCEPT
  SELECT DISTINCT SUBSTRING(c.semester, -4)
  FROM enrollments e
  JOIN courses c ON e.course_id = c.course_id
  WHERE e.student_id = s.student_id
);
```

59. **Find the course title with the widest semester spread.**
```sql
SELECT course_name, COUNT(DISTINCT semester) AS semester_count
FROM courses
GROUP BY course_name
ORDER BY semester_count DESC
LIMIT 1;
```

60. **Show students who have taken courses in at least 3 different semesters.**
```sql
SELECT s.name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
GROUP BY s.name
HAVING COUNT(DISTINCT c.semester) >= 3;
```

---

Let me know if you’d like the final batch (61–80), or if you’d prefer the full set in a downloadable markdown file.

You're unstoppable — here’s the final batch of instructor-level SQL queries (61–80):

---

### 🧠 Instructor SQL Queries (61–80)

61. **Find students who have taken courses with “Security” in the title.**
```sql
SELECT DISTINCT s.name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name LIKE '%Security%';
```

62. **Show the number of students who have taken courses in only one year.**
```sql
SELECT COUNT(*) AS student_count
FROM (
  SELECT s.student_id
  FROM students s
  JOIN enrollments e ON s.student_id = e.student_id
  JOIN courses c ON e.course_id = c.course_id
  GROUP BY s.student_id
  HAVING COUNT(DISTINCT SUBSTRING(c.semester, -4)) = 1
) AS sub;
```

63. **List courses that have been taken by students in every year offered.**
```sql
SELECT c.course_name
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
JOIN students s ON e.student_id = s.student_id
GROUP BY c.course_name
HAVING COUNT(DISTINCT SUBSTRING(c.semester, -4)) = (
  SELECT COUNT(DISTINCT SUBSTRING(semester, -4)) FROM courses
);
```

64. **Find students who have taken courses with “Network” or “Networking” in the title.**
```sql
SELECT DISTINCT s.name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name LIKE '%Network%' OR c.course_name LIKE '%Networking%';
```

65. **Show the most common semester for course offerings.**
```sql
SELECT semester, COUNT(*) AS course_count
FROM courses
GROUP BY semester
ORDER BY course_count DESC
LIMIT 1;
```

66. **List students who have taken courses in every semester except Spring 2026.**
```sql
SELECT s.name
FROM students s
WHERE NOT EXISTS (
  SELECT DISTINCT semester
  FROM courses
  WHERE semester != 'Spring 2026'
  EXCEPT
  SELECT DISTINCT c.semester
  FROM enrollments e
  JOIN courses c ON e.course_id = c.course_id
  WHERE e.student_id = s.student_id AND c.semester != 'Spring 2026'
);
```

67. **Find courses that have been taken by students in both 2025 and 2026.**
```sql
SELECT c.course_name
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
JOIN students s ON e.student_id = s.student_id
GROUP BY c.course_name
HAVING COUNT(DISTINCT SUBSTRING(c.semester, -4)) >= 2;
```

68. **Show students who have taken courses with “Cloud” in the title.**
```sql
SELECT DISTINCT s.name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name LIKE '%Cloud%';
```

69. **List students who have taken courses in every semester that “AI” was offered.**
```sql
SELECT s.name
FROM students s
WHERE NOT EXISTS (
  SELECT DISTINCT semester
  FROM courses
  WHERE course_name LIKE '%AI%'
  EXCEPT
  SELECT DISTINCT c.semester
  FROM enrollments e
  JOIN courses c ON e.course_id = c.course_id
  WHERE e.student_id = s.student_id AND c.course_name LIKE '%AI%'
);
```

70. **Find the course with the highest number of repeat enrollments (same student, same course title).**
```sql
SELECT c.course_name, COUNT(*) AS repeat_count
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
GROUP BY c.course_name, e.student_id
HAVING COUNT(*) > 1
ORDER BY repeat_count DESC
LIMIT 1;
```

71. **Show students who have taken courses with “Design” in the title.**
```sql
SELECT DISTINCT s.name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name LIKE '%Design%';
```

72. **List students who have taken courses in every semester that “Machine Learning” was offered.**
```sql
SELECT s.name
FROM students s
WHERE NOT EXISTS (
  SELECT DISTINCT semester
  FROM courses
  WHERE course_name = 'Machine Learning'
  EXCEPT
  SELECT DISTINCT c.semester
  FROM enrollments e
  JOIN courses c ON e.course_id = c.course_id
  WHERE e.student_id = s.student_id AND c.course_name = 'Machine Learning'
);
```

73. **Find students who have taken courses in the same semester more than once.**
```sql
SELECT s.name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
GROUP BY s.name, c.semester
HAVING COUNT(*) > 1;
```

74. **Show the number of students who have taken courses in all semesters.**
```sql
SELECT COUNT(*) AS student_count
FROM (
  SELECT s.student_id
  FROM students s
  WHERE NOT EXISTS (
    SELECT DISTINCT semester
    FROM courses
    EXCEPT
    SELECT DISTINCT c.semester
    FROM enrollments e
    JOIN courses c ON e.course_id = c.course_id
    WHERE e.student_id = s.student_id
  )
) AS sub;
```

75. **List courses that have been taken by students in only one semester.**
```sql
SELECT c.course_name
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
HAVING COUNT(DISTINCT c.semester) = 1;
```

76. **Find students who have taken courses with “Intro” and “Advanced” in the title.**
```sql
SELECT s.name
FROM students s
JOIN enrollments e1 ON s.student_id = e1.student_id
JOIN courses c1 ON e1.course_id = c1.course_id
JOIN enrollments e2 ON s.student_id = e2.student_id
JOIN courses c2 ON e2.course_id = c2.course_id
WHERE c1.course_name LIKE '%Intro%' AND c2.course_name LIKE '%Advanced%';
```

77. **Show students who have taken courses in every semester that “Cybersecurity” was offered.**
```sql
SELECT s.name
FROM students s
WHERE NOT EXISTS (
  SELECT DISTINCT semester
  FROM courses
  WHERE course_name = 'Cybersecurity'
  EXCEPT
  SELECT DISTINCT c.semester
  FROM enrollments e
  JOIN courses c ON e.course_id = c.course_id
  WHERE e.student_id = s.student_id AND c.course_name = 'Cybersecurity'
);
```

78. **List students who have taken courses in at least 4 different semesters.**
```sql
SELECT s.name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
GROUP BY s.name
HAVING COUNT(DISTINCT c.semester) >= 4;
```

79. **Find the course title with the most unique semesters.**
```sql
SELECT course_name, COUNT(DISTINCT semester) AS semester_count
FROM courses
GROUP BY course_name
ORDER BY semester_count DESC
LIMIT 1;
```

80. **Show students who have taken courses in every semester that “Operating Systems” was offered.**
```sql
SELECT s.name
FROM students s
WHERE NOT EXISTS (
  SELECT DISTINCT semester
  FROM courses
  WHERE course_name = 'Operating Systems'
  EXCEPT
  SELECT DISTINCT c.semester
  FROM enrollments e
  JOIN courses c ON e.course_id = c.course_id
  WHERE e.student_id = s.student_id AND c.course_name = 'Operating Systems'
);
```

---

🎉 That’s all 80 instructor-level SQL queries! If you’d like the student version (just the English prompts), or want this in a downloadable markdown file, I can prep that next.

