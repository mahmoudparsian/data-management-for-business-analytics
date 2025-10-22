# Week 1 Quiz
**Schema:** students / courses / enrollments
**Focus:** Basics (SELECT, WHERE)

**Q1. (MCQ)** Which clause selects columns from a table?
- A) FROM
- B) SELECT
- C) WHERE
- D) ORDER BY
**Answer:** B) SELECT

**Q2. (MCQ)** Which clause filters rows by a condition?
- A) WHERE
- B) HAVING
- C) GROUP BY
- D) LIMIT
**Answer:** A) WHERE

**Q3. (MCQ)** Which is a valid comparison operator in MySQL?
- A) ==
- B) !=
- C) <=
- D) <> (not equal)
**Answer:** D) <> (not equal)

**Q4. (SQL)** List all columns for all students.
```sql
SELECT * FROM students;
```

**Q5. (SQL)** Show first_name, last_name, age for students from 'USA'.
```sql
SELECT first_name, last_name, age FROM students WHERE country = 'USA';
```

**Q6. (SQL)** Find students older than 25.
```sql
SELECT * FROM students WHERE age > 25;
```

**Q7. (SQL)** Get the email addresses of students whose first_name starts with 'A'.
```sql
SELECT email FROM students WHERE first_name LIKE 'A%';
```

**Q8. (SQL)** Return all courses in the 'COMPUTER-SCIENCE' department.
```sql
SELECT * FROM courses WHERE department = 'COMPUTER-SCIENCE';
```

**Q9. (SQL)** Find enrollments that happened in 2023.
```sql
SELECT * FROM enrollments WHERE YEAR(enrollment_date) = 2023;
```

**Q10. (SQL)** Show distinct countries represented in the students table.
```sql
SELECT DISTINCT country FROM students;
```
