# Week 7 Quiz
**Schema:** Integrated (students/courses/enrollments + books/customers/stores/transactions)
**Focus:** Capstone exam-style queries

**Q1. (MCQ)** A primary key must be:
- A) Unique & NOT NULL
- B) Unique only
- C) NOT NULL only
- D) Either unique or NOT NULL
**Answer:** A) Unique & NOT NULL

**Q2. (MCQ)** Which best describes an INNER JOIN?
- A) All rows from left table
- B) All rows from right table
- C) Only matching rows from both tables
- D) All rows from both tables
**Answer:** C) Only matching rows from both tables

**Q3. (MCQ)** What does `HAVING` filter?
- A) Raw rows before grouping
- B) Groups/aggregates after GROUP BY
- C) Columns
- D) Indexes
**Answer:** B) Groups/aggregates after GROUP BY

**Q4. (SQL)** Education: Find students with no enrollments.
```sql
SELECT s.student_id, s.first_name, s.last_name FROM students s LEFT JOIN enrollments e ON s.student_id=e.student_id WHERE e.student_id IS NULL;
```

**Q5. (SQL)** Education: For each course, total number of enrollments, order by most enrolled.
```sql
SELECT c.course_id, c.course_name, COUNT(e.enrollment_id) AS total_enrolls FROM courses c LEFT JOIN enrollments e ON c.course_id=e.course_id GROUP BY c.course_id, c.course_name ORDER BY total_enrolls DESC;
```

**Q6. (SQL)** Bookstore: Top 5 customers by total spend.
```sql
SELECT c.customer_id, c.name, SUM(t.price) AS total_spent FROM customers c JOIN transactions t ON c.customer_id=t.customer_id GROUP BY c.customer_id, c.name ORDER BY total_spent DESC LIMIT 5;
```

**Q7. (SQL)** Bookstore: Best-selling category per store (by total revenue).
```sql
WITH cat_rev AS (SELECT s.store_location, b.category, SUM(t.price) AS revenue FROM transactions t JOIN stores s ON t.store_id=s.store_id JOIN books b ON t.book_id=b.book_id GROUP BY s.store_location, b.category), ranked AS (SELECT store_location, category, revenue, ROW_NUMBER() OVER (PARTITION BY store_location ORDER BY revenue DESC) rn FROM cat_rev) SELECT store_location, category, revenue FROM ranked WHERE rn=1;
```

**Q8. (SQL)** Cross-domain: Return countries present in both students and customers.
```sql
SELECT country FROM students INTERSECT SELECT country FROM customers; -- If INTERSECT unsupported, emulate: SELECT DISTINCT s.country FROM students s JOIN customers c ON s.country=c.country;
```

**Q9. (SQL)** Cross-domain: For each country, list student count and customer count side-by-side.
```sql
WITH stu AS (SELECT country, COUNT(*) sc FROM students GROUP BY country), cus AS (SELECT country, COUNT(*) cc FROM customers GROUP BY country) SELECT COALESCE(stu.country, cus.country) AS country, sc, cc FROM stu FULL JOIN cus ON stu.country=cus.country; -- Emulate FULL JOIN if needed with UNION of left/right joins.
```

**Q10. (SQL)** Cross-domain: Countries where avg student age > avg book price/10 (toy metric).
```sql
WITH sa AS (SELECT country, AVG(age) a FROM students GROUP BY country), bp AS (SELECT s.country, AVG(t.price) p FROM transactions t JOIN stores s ON t.store_id=s.store_id GROUP BY s.country) SELECT sa.country FROM sa JOIN bp ON sa.country=bp.country WHERE sa.a > bp.p/10.0;
```
