# Weekly Quizzes - Intro to Database Management (MySQL)

This package contains **7 weekly quizzes** (10 questions each) 
for a 7‑week course.

Each quiz is provided in two versions:
- `students_version/`: questions only
- `instructor_version/`: questions + worked answers

## Schemas Used

### Weeks 1–3: Education domain
```sql
students(student_id, first_name, last_name, email, country, age)
courses(course_id, course_code, course_name, credits, department)
enrollments(enrollment_id, student_id, course_id, enrollment_date, grade)
```

### Weeks 4–6: Bookstore domain
```sql
stores(store_id, store_location, city, country)
customers(customer_id, name, email, gender, age, city, country)
books(book_id, ISBN, title, author, category, published_date)
transactions(sale_id, store_id, book_id, customer_id, purchase_date, price)
```

### Week 7: Integrated Capstone
Uses both schemas in a single quiz.

## Weekly Focus
1. Basics (SELECT, WHERE)
2. Filtering, ORDER BY, DISTINCT
3. Aggregations, GROUP BY, HAVING
4. JOINs
5. Subqueries & WITH (CTEs)
6. Advanced queries, UNION, constraints
7. Capstone exam-style mixed problems

> Submit answers on your LMS (Canvas/Blackboard). 
Use MySQL Workbench or your preferred client to test SQL.
