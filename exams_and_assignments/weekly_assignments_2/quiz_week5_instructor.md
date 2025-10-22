# Week 5 Quiz
**Schema:** books / customers / stores / transactions
**Focus:** Subqueries & WITH (CTEs)

**Q1. (MCQ)** A subquery that depends on the outer query is called:
- A) Inline query
- B) Correlated subquery
- C) Nested JOIN
- D) Temp view
**Answer:** B) Correlated subquery

**Q2. (MCQ)** `WITH` creates:
- A) Transaction
- B) Common Table Expression (CTE)
- C) Stored procedure
- D) Temp table only
**Answer:** B) Common Table Expression (CTE)

**Q3. (MCQ)** Which operator tests set membership?
- A) IN
- B) HAS
- C) MATCH
- D) WITHIN
**Answer:** A) IN

**Q4. (SQL)** Find customers whose total spending exceeds $500 (use subquery).
```sql
SELECT customer_id, name FROM customers WHERE customer_id IN (SELECT customer_id FROM transactions GROUP BY customer_id HAVING SUM(price) > 500);
```

**Q5. (SQL)** Using a CTE, compute total sales per category and return categories over $2000.
```sql
WITH cat_sales AS (SELECT b.category, SUM(t.price) AS total FROM transactions t JOIN books b ON t.book_id=b.book_id GROUP BY b.category) SELECT * FROM cat_sales WHERE total > 2000;
```

**Q6. (SQL)** Return books that have never been sold (LEFT JOIN + IS NULL).
```sql
SELECT b.book_id, b.title FROM books b LEFT JOIN transactions t ON b.book_id = t.book_id WHERE t.book_id IS NULL;
```

**Q7. (SQL)** Find the average price per store using a CTE, then list stores above the overall avg of those averages.
```sql
WITH store_avg AS (SELECT store_id, AVG(price) AS avg_price FROM transactions GROUP BY store_id) SELECT s.store_id, s.avg_price FROM store_avg s WHERE s.avg_price > (SELECT AVG(avg_price) FROM store_avg);
```

**Q8. (SQL)** Find the most expensive transaction per customer (CTE + window or subquery).
```sql
WITH ranked AS (SELECT t.*, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY price DESC) AS rn FROM transactions t) SELECT * FROM ranked WHERE rn=1;
```

**Q9. (SQL)** List categories where the average price is higher than the category 'Fiction'.
```sql
WITH cat_avg AS (SELECT b.category, AVG(t.price) AS avgp FROM transactions t JOIN books b ON t.book_id=b.book_id GROUP BY b.category) SELECT category FROM cat_avg WHERE avgp > (SELECT avgp FROM cat_avg WHERE category='Fiction');
```

**Q10. (SQL)** Find authors whose books sold more than 50 copies total.
```sql
SELECT b.author FROM books b JOIN transactions t ON b.book_id=t.book_id GROUP BY b.author HAVING COUNT(*) > 50;
```
