1. Count students per country.
```sql
SELECT country, COUNT(*) FROM students GROUP BY country;
```

2. Count courses per department.
```sql
SELECT department, COUNT(*) FROM courses GROUP BY department;
```

3. Average credits by department.
```sql
SELECT department, AVG(credits) FROM courses GROUP BY department;
```

4. Total enrollments per year.
```sql
SELECT YEAR(enrollment_date), COUNT(*) FROM enrollments GROUP BY YEAR(enrollment_date);
```

5. Grade distribution overall.
```sql
SELECT grade, COUNT(*) FROM enrollments GROUP BY grade;
```

6. Number of distinct students enrolled.
```sql
SELECT COUNT(DISTINCT student_id) FROM enrollments;
```

7. Number of distinct courses taken.
```sql
SELECT COUNT(DISTINCT course_id) FROM enrollments;
```

8. Average age by country (2025).
```sql
SELECT country, AVG(TIMESTAMPDIFF(YEAR, date_of_birth,'2025-01-01')) FROM students GROUP BY country;
```

9. Enrollments per department.
```sql
SELECT c.department, COUNT(*) FROM enrollments e JOIN courses c ON e.course_id=c.course_id GROUP BY c.department;
```

10. Average GPA per department.
```sql
SELECT c.department, AVG(CASE grade WHEN 'A' THEN 4 WHEN 'B' THEN 3 WHEN 'C' THEN 2 WHEN 'D' THEN 1 ELSE 0 END) FROM enrollments e JOIN courses c ON e.course_id=c.course_id GROUP BY c.department;
```

11. Top 10 students by enrollments.
```sql
SELECT s.student_id, COUNT(*) FROM enrollments e JOIN students s ON e.student_id=s.student_id GROUP BY s.student_id ORDER BY COUNT(*) DESC LIMIT 10;
```

12. Top 10 courses by enrollments.
```sql
SELECT c.course_id, COUNT(*) FROM enrollments e JOIN courses c ON e.course_id=c.course_id GROUP BY c.course_id ORDER BY COUNT(*) DESC LIMIT 10;
```

13. Year with highest enrollments.
```sql
SELECT YEAR(enrollment_date), COUNT(*) FROM enrollments GROUP BY YEAR(enrollment_date) ORDER BY COUNT(*) DESC LIMIT 1;
```

14. Count of A grades per department.
```sql
SELECT c.department, COUNT(*) FROM enrollments e JOIN courses c ON e.course_id=c.course_id WHERE grade='A' GROUP BY c.department;
```

15. Average enrollments per student.
```sql
SELECT AVG(cnt) FROM (SELECT student_id, COUNT(*) as cnt FROM enrollments GROUP BY student_id) x;
```

16. Departments with avg credits > 3.
```sql
SELECT department, AVG(credits) FROM courses GROUP BY department HAVING AVG(credits)>3;
```

17. Courses with zero enrollments.
```sql
SELECT c.course_id FROM courses c LEFT JOIN enrollments e ON c.course_id=e.course_id WHERE e.course_id IS NULL;
```

18. Students with zero enrollments.
```sql
SELECT s.student_id FROM students s LEFT JOIN enrollments e ON s.student_id=e.student_id WHERE e.student_id IS NULL;
```

19. Enrollments per country per year.
```sql
SELECT s.country, YEAR(e.enrollment_date), COUNT(*) FROM enrollments e JOIN students s ON e.student_id=s.student_id GROUP BY s.country, YEAR(e.enrollment_date);
```

