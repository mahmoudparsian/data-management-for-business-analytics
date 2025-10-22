# Week 6 Quiz
**Schema:** books / customers / stores / transactions
**Focus:** Advanced queries, UNION, constraints

**Q1. (MCQ)** `UNION` by default removes duplicates. Which keeps duplicates?
- A) UNION ALL
- B) UNION DISTINCT
- C) FULL UNION
- D) UNION*
**Answer:** A) UNION ALL

**Q2. (MCQ)** A foreign key ensures:
- A) Unique values in a column
- B) Referential integrity with a parent table
- C) Automatic indexing
- D) Faster joins always
**Answer:** B) Referential integrity with a parent table

**Q3. (MCQ)** Which constraint prevents NULLs?
- A) UNIQUE
- B) NOT NULL
- C) CHECK
- D) FOREIGN KEY
**Answer:** B) NOT NULL

**Q4. (SQL)** Combine two lists of city names: store cities and customer cities (distinct).
```sql
SELECT city FROM stores UNION SELECT city FROM customers;
```

**Q5. (SQL)** Same as above but keep duplicates.
```sql
SELECT city FROM stores UNION ALL SELECT city FROM customers;
```

**Q6. (SQL)** Find average transaction price per year (`purchase_date`).
```sql
SELECT YEAR(purchase_date) AS yr, AVG(price) AS avg_price FROM transactions GROUP BY YEAR(purchase_date) ORDER BY yr;
```

**Q7. (SQL)** Show top 3 categories by total revenue.
```sql
SELECT b.category, SUM(t.price) AS revenue FROM transactions t JOIN books b ON t.book_id=b.book_id GROUP BY b.category ORDER BY revenue DESC LIMIT 3;
```

**Q8. (SQL)** Detect customers with multiple emails (should be none if UNIQUE is enforced).
```sql
SELECT email, COUNT(*) c FROM customers GROUP BY email HAVING COUNT(*) > 1;
```

**Q9. (SQL)** Find stores that have sold at least 200 transactions.
```sql
SELECT s.store_location, COUNT(*) AS cnt FROM stores s JOIN transactions t ON s.store_id=t.store_id GROUP BY s.store_location HAVING COUNT(*) >= 200;
```

**Q10. (SQL)** List books with their first sale date.
```sql
SELECT b.title, MIN(t.purchase_date) AS first_sold FROM books b JOIN transactions t ON b.book_id=t.book_id GROUP BY b.title;
```
