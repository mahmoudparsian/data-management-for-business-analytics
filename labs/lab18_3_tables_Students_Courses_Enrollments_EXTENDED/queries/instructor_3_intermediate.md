1. List all students.
```sql
SELECT * FROM students;
```

2. Show all courses.
```sql
SELECT * FROM courses;
```

3. List students from INDIA.
```sql
SELECT * FROM students WHERE country='INDIA';
```

4. Find courses with 4 credits.
```sql
SELECT * FROM courses WHERE credits=4;
```

5. Show enrollments that happened in 2020.
```sql
SELECT * FROM enrollments WHERE YEAR(enrollment_date)=2020;
```

6. Find students with email ending in 'example.edu'.
```sql
SELECT * FROM students WHERE email LIKE '%@example.edu';
```

7. List distinct countries of students.
```sql
SELECT DISTINCT country FROM students;
```

8. Show students born after 2005-01-01.
```sql
SELECT * FROM students WHERE date_of_birth > '2005-01-01';
```

9. Find a course by course_code (replace 'CS101').
```sql
SELECT * FROM courses WHERE course_code='CS101';
```

10. List students named 'Emma'.
```sql
SELECT * FROM students WHERE first_name='Emma';
```

11. Top 10 most recent enrollments by date.
```sql
SELECT * FROM enrollments ORDER BY enrollment_date DESC LIMIT 10;
```

12. Find enrollments with grade A.
```sql
SELECT * FROM enrollments WHERE grade='A';
```

13. List courses in the AI department.
```sql
SELECT * FROM courses WHERE department='AI';
```

14. Show students from USA or CANADA.
```sql
SELECT * FROM students WHERE country IN ('USA','CANADA');
```

15. Find students with last name 'Patel'.
```sql
SELECT * FROM students WHERE last_name='Patel';
```

16. Find courses whose name contains 'Data'.
```sql
SELECT * FROM courses WHERE course_name LIKE '%Data%';
```

17. Get first 5 students (by id).
```sql
SELECT * FROM students ORDER BY student_id LIMIT 5;
```

18. Show enrollments for a student_id (e.g. 7).
```sql
SELECT * FROM enrollments WHERE student_id=7;
```

19. List courses not in LAW department.
```sql
SELECT * FROM courses WHERE department <> 'LAW';
```

20. Show enrollments with grade in (A,B).
```sql
SELECT * FROM enrollments WHERE grade IN ('A','B');
```

