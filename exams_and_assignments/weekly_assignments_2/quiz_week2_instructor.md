# Week 2 Quiz
**Schema:** students / courses / enrollments
**Focus:** Filtering, ORDER BY, DISTINCT

**Q1. (MCQ)** Which clause sorts results?
- A) ORDER BY
- B) SORT BY
- C) GROUP BY
- D) HAVING
**Answer:** A) ORDER BY

**Q2. (MCQ)** Which predicate matches subsets of strings?
- A) LIKE
- B) IN
- C) BETWEEN
- D) MATCHES
**Answer:** A) LIKE

**Q3. (MCQ)** Which returns unique rows for selected columns?
- A) DISTINCT
- B) UNIQUE
- C) ONLY
- D) SEPARATE
**Answer:** A) DISTINCT

**Q4. (SQL)** List students from 'India' or 'China'.
```sql
SELECT * FROM students WHERE country IN ('India','China');
```

**Q5. (SQL)** Show top 5 oldest students with name and age.
```sql
SELECT first_name, last_name, age FROM students ORDER BY age DESC LIMIT 5;
```

**Q6. (SQL)** Find courses with 4 or more credits, oldest first by course_code.
```sql
SELECT * FROM courses WHERE credits >= 4 ORDER BY course_code ASC;
```

**Q7. (SQL)** Return students aged between 20 and 30 (inclusive).
```sql
SELECT * FROM students WHERE age BETWEEN 20 AND 30;
```

**Q8. (SQL)** List distinct departments that offer courses.
```sql
SELECT DISTINCT department FROM courses;
```

**Q9. (SQL)** Find students whose last_name ends with 'son' ordered by last_name then first_name.
```sql
SELECT * FROM students WHERE last_name LIKE '%son' ORDER BY last_name, first_name;
```

**Q10. (SQL)** Show enrollments sorted by enrollment_date descending with first 10 rows.
```sql
SELECT * FROM enrollments ORDER BY enrollment_date DESC LIMIT 10;
```
