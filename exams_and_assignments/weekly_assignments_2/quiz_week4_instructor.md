# Week 4 Quiz
**Schema:** books / customers / stores / transactions
**Focus:** JOINs

**Q1. (MCQ)** Which join returns rows that match in both tables?
- A) LEFT JOIN
- B) RIGHT JOIN
- C) INNER JOIN
- D) FULL JOIN
**Answer:** C) INNER JOIN

**Q2. (MCQ)** Which join keeps all rows from the left table?
- A) LEFT JOIN
- B) RIGHT JOIN
- C) INNER JOIN
- D) CROSS JOIN
**Answer:** A) LEFT JOIN

**Q3. (MCQ)** What keyword aliases a table in a query?
- A) AS
- B) LIKE
- C) USING
- D) INTO
**Answer:** A) AS

**Q4. (SQL)** List each transaction with book title and customer name.
```sql
SELECT t.sale_id, b.title, c.name, t.price FROM transactions t JOIN books b ON t.book_id=b.book_id JOIN customers c ON t.customer_id=c.customer_id;
```

**Q5. (SQL)** Show total sales (sum price) per store_location.
```sql
SELECT s.store_location, SUM(t.price) AS total_sales FROM transactions t JOIN stores s ON t.store_id=s.store_id GROUP BY s.store_location;
```

**Q6. (SQL)** Find customers who have never made a purchase (use LEFT JOIN).
```sql
SELECT c.customer_id, c.name FROM customers c LEFT JOIN transactions t ON c.customer_id=t.customer_id WHERE t.customer_id IS NULL;
```

**Q7. (SQL)** Count transactions per book category.
```sql
SELECT b.category, COUNT(*) AS txn_count FROM transactions t JOIN books b ON t.book_id=b.book_id GROUP BY b.category;
```

**Q8. (SQL)** Average price per category and per store country.
```sql
SELECT s.country, b.category, AVG(t.price) AS avg_price FROM transactions t JOIN books b ON t.book_id=b.book_id JOIN stores s ON t.store_id=s.store_id GROUP BY s.country, b.category;
```

**Q9. (SQL)** For each customer, total amount spent (descending).
```sql
SELECT c.customer_id, c.name, SUM(t.price) AS total_spent FROM customers c JOIN transactions t ON c.customer_id=t.customer_id GROUP BY c.customer_id, c.name ORDER BY total_spent DESC;
```

**Q10. (SQL)** Top 5 bestselling books by transaction count.
```sql
SELECT b.title, COUNT(*) AS cnt FROM transactions t JOIN books b ON t.book_id=b.book_id GROUP BY b.title ORDER BY cnt DESC LIMIT 5;
```
