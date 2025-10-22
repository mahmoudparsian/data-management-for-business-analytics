# 🗝️ MySQL Homework: Book Seller Data Model (Answer Key)

## Part A: Simple Queries
```sql
-- Q1
SELECT * FROM stores;

-- Q2
SELECT title, price FROM books;

-- Q3
SELECT name, email FROM customers;

-- Q4
SELECT transaction_id, purchase_date, total_amount FROM transactions;

-- Q5
SELECT * FROM transactions WHERE channel = 'Online';

-- Q6
SELECT b.title
FROM transactions t
JOIN books b ON t.book_id = b.book_id
JOIN stores s ON t.store_id = s.store_id
WHERE s.store_name = 'Store A';
```

---

## Part B: Intermediate Queries
```sql
-- Q7
SELECT SUM(total_amount) AS total_sales FROM transactions;

-- Q8
SELECT channel, COUNT(*) AS num_transactions
FROM transactions
GROUP BY channel;

-- Q9
SELECT s.store_name, SUM(t.total_amount) AS store_revenue
FROM transactions t
JOIN stores s ON t.store_id = s.store_id
GROUP BY s.store_name;

-- Q10
SELECT title, price
FROM books
ORDER BY price DESC
LIMIT 1;

-- Q11
SELECT AVG(total_amount) AS avg_order_value
FROM transactions;

-- Q12
SELECT c.name, SUM(t.quantity) AS total_books
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
GROUP BY c.name;
```

---

## Part C: Advanced Queries (WITH + Ranking)
```sql
-- Q13
WITH monthly_sales AS (
    SELECT DATE_FORMAT(purchase_date, '%Y-%m') AS month,
           SUM(total_amount) AS total_sales
    FROM transactions
    GROUP BY DATE_FORMAT(purchase_date, '%Y-%m')
)
SELECT * FROM monthly_sales;

-- Q14
WITH store_revenue AS (
    SELECT s.store_name, SUM(t.total_amount) AS revenue
    FROM transactions t
    JOIN stores s ON t.store_id = s.store_id
    GROUP BY s.store_name
)
SELECT store_name, revenue,
       RANK() OVER (ORDER BY revenue DESC) AS rank_position
FROM store_revenue;

-- Q15
WITH customer_spending AS (
    SELECT c.name, SUM(t.total_amount) AS spending
    FROM transactions t
    JOIN customers c ON t.customer_id = c.customer_id
    GROUP BY c.name
)
SELECT name, spending,
       RANK() OVER (ORDER BY spending DESC) AS rank_position
FROM customer_spending;

-- Q16
WITH book_sales AS (
    SELECT b.title, SUM(t.quantity) AS total_sold
    FROM transactions t
    JOIN books b ON t.book_id = b.book_id
    GROUP BY b.title
)
SELECT title, total_sold,
       RANK() OVER (ORDER BY total_sold DESC) AS rank_position
FROM book_sales;

-- Q17
WITH weekly_sales AS (
    SELECT YEARWEEK(purchase_date, 1) AS week,
           SUM(total_amount) AS weekly_total
    FROM transactions
    GROUP BY YEARWEEK(purchase_date, 1)
)
SELECT * FROM weekly_sales ORDER BY week;

-- Q18
WITH customer_books AS (
    SELECT c.name, COUNT(DISTINCT t.book_id) AS distinct_books
    FROM transactions t
    JOIN customers c ON t.customer_id = c.customer_id
    GROUP BY c.name
)
SELECT name, distinct_books,
       RANK() OVER (ORDER BY distinct_books DESC) AS rank_position
FROM customer_books;
```
