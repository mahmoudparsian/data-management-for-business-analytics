# Week 3 Quiz
**Schema:** students / courses / enrollments
**Focus:** Aggregations, GROUP BY, HAVING

**Q1. (MCQ)** Which clause groups rows for aggregation?
- A) GROUP BY
- B) HAVING
- C) ORDER BY
- D) WHERE
**Answer:** A) GROUP BY

**Q2. (MCQ)** Which clause filters *after* aggregation?
- A) HAVING
- B) WHERE
- C) LIMIT
- D) JOIN
**Answer:** A) HAVING

**Q3. (MCQ)** Which is an aggregate function?
- A) SUM
- B) CONCAT
- C) UPPER
- D) LENGTH
**Answer:** A) SUM

**Q4. (SQL)** Count how many students per country.
```sql
SELECT country, COUNT(*) AS num_students FROM students GROUP BY country;
```

**Q5. (SQL)** Average student age per country (only countries with avg age > 25).
```sql
SELECT country, AVG(age) AS avg_age FROM students GROUP BY country HAVING AVG(age) > 25;
```

**Q6. (SQL)** Number of courses per department, ordered by count desc.
```sql
SELECT department, COUNT(*) AS num_courses FROM courses GROUP BY department ORDER BY num_courses DESC;
```

**Q7. (SQL)** For each student, count how many enrollments they have.
```sql
SELECT student_id, COUNT(*) AS enroll_count FROM enrollments GROUP BY student_id;
```

**Q8. (SQL)** Find departments whose average course credits >= 4.
```sql
SELECT department, AVG(credits) AS avg_credits FROM courses GROUP BY department HAVING AVG(credits) >= 4;
```

**Q9. (SQL)** Find the year with the most enrollments.
```sql
SELECT YEAR(enrollment_date) AS yr, COUNT(*) AS c FROM enrollments GROUP BY YEAR(enrollment_date) ORDER BY c DESC LIMIT 1;
```

**Q10. (SQL)** Total enrollments per course_id.
```sql
SELECT course_id, COUNT(*) AS total_enrolls FROM enrollments GROUP BY course_id;
```
