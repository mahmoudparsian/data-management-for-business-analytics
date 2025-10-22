1. List all students.
```sql
SELECT * FROM students;
```

2. Show first_name, last_name, and email.
```sql
SELECT first_name, last_name, email FROM students;
```

3. Find students from INDIA.
```sql
SELECT * FROM students WHERE country='INDIA';
```

4. Find students who speak FRENCH.
```sql
SELECT * FROM students WHERE language='FRENCH';
```

5. List Computer Science majors.
```sql
SELECT * FROM students WHERE major='Computer Science';
```

6. Show students born after 1995-01-01.
```sql
SELECT * FROM students WHERE date_of_birth > '1995-01-01';
```

7. Find students named Emma.
```sql
SELECT * FROM students WHERE first_name='Emma';
```

8. 10 most recent students by id.
```sql
SELECT * FROM students ORDER BY student_id DESC LIMIT 10;
```

9. Students from USA or CANADA.
```sql
SELECT * FROM students WHERE country IN ('USA','CANADA');
```

10. Students with last name Patel.
```sql
SELECT * FROM students WHERE last_name='Patel';
```

11. Emails ending with example.edu.
```sql
SELECT * FROM students WHERE email LIKE '%@example.edu';
```

12. Distinct countries.
```sql
SELECT DISTINCT country FROM students;
```

13. Distinct languages.
```sql
SELECT DISTINCT language FROM students;
```

14. Students born in 1990.
```sql
SELECT * FROM students WHERE YEAR(date_of_birth)=1990;
```

15. Not Finance majors.
```sql
SELECT * FROM students WHERE major <> 'Finance';
```

16. First 5 alphabetically by last, first.
```sql
SELECT * FROM students ORDER BY last_name, first_name LIMIT 5;
```

17. Count students named Liam.
```sql
SELECT COUNT(*) FROM students WHERE first_name='Liam';
```

18. Last names starting with 'Ro'.
```sql
SELECT * FROM students WHERE last_name LIKE 'Ro%';
```

19. From GERMANY who speak GERMAN.
```sql
SELECT * FROM students WHERE country='GERMANY' AND language='GERMAN';
```

20. Biology majors born before 1990-01-01.
```sql
SELECT * FROM students WHERE major='Biology' AND date_of_birth < '1990-01-01';
```

