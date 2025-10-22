# Lab-2 – Basic to Intermediate (25 queries)

> Tables: `customers`, `products`, `orders`

### 1. Age bracket for customers (CASE).
```sql
SELECT customer_id, name, age,
CASE WHEN age<30 THEN 'YOUNG' 
     WHEN age<=50 THEN 'MID' 
     ELSE 'SENIOR' 
END AS age_group
FROM customers LIMIT 20;
```

### 2. Customers from USA or CANADA.
```sql
SELECT customer_id, name, country FROM customers WHERE country IN ('USA','CANADA');
```

### 3. Products NOT in 'Books' or 'Toys'.
```sql
SELECT product_id, product_name, category FROM products WHERE category NOT IN ('Books','Toys') LIMIT 15;
```

### 4. Orders for customer_id 7.
```sql
SELECT * FROM orders WHERE customer_id=7 LIMIT 10;
```

### 5. Orders for product_id between 10 and 20.
```sql
SELECT * FROM orders WHERE product_id BETWEEN 10 AND 20 LIMIT 10;
```

### 6. Order counts by customer (top 10).
```sql
SELECT customer_id, COUNT(*) AS order_count FROM orders GROUP BY customer_id ORDER BY order_count DESC LIMIT 10;
```

### 7. Average order amount overall.
```sql
SELECT AVG(amount) AS avg_amount FROM orders;
```

### 8. Average order amount per country.
```sql
SELECT c.country, AVG(o.amount) AS avg_amount
FROM orders o JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.country ORDER BY avg_amount DESC;
```

### 9. Total revenue per category.
```sql
SELECT p.category, SUM(o.amount) AS revenue
FROM orders o JOIN products p ON o.product_id=p.product_id
GROUP BY p.category ORDER BY revenue DESC;
```

### 10. Customers with no orders (LEFT JOIN anti-join).
```sql
SELECT c.customer_id, c.name
FROM customers c LEFT JOIN orders o ON c.customer_id=o.customer_id
WHERE o.order_id IS NULL;
```

### 11. Products never purchased (LEFT JOIN anti-join).
```sql
SELECT p.product_id, p.product_name
FROM products p LEFT JOIN orders o ON p.product_id=o.product_id
WHERE o.order_id IS NULL;
```

### 12. Top 10 most purchased products by frequency.
```sql
SELECT o.product_id, p.product_name, COUNT(*) AS times
FROM orders o JOIN products p ON o.product_id=p.product_id
GROUP BY o.product_id, p.product_name
ORDER BY times DESC LIMIT 10;
```

### 13. Total spent by each customer (top 10).
```sql
SELECT c.customer_id, c.name, SUM(o.amount) AS total_spent
FROM customers c JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC LIMIT 10;
```

### 14. Bucket counts of orders by 10s.
```sql
SELECT FLOOR(amount/10)*10 AS bucket, COUNT(*) AS cnt FROM orders GROUP BY bucket ORDER BY bucket;
```

### 15. French customers who bought 'Electronics'.
```sql
SELECT DISTINCT c.customer_id, c.name
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN products p ON o.product_id=p.product_id
WHERE c.country='FRANCE' AND p.category='Electronics';
```

### 16. Top 5 countries by total revenue.
```sql
SELECT c.country, SUM(o.amount) AS revenue
FROM orders o JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.country
ORDER BY revenue DESC LIMIT 5;
```

### 17. Top 5 categories by average order amount.
```sql
SELECT p.category, AVG(o.amount) AS avg_amt
FROM orders o JOIN products p ON o.product_id=p.product_id
GROUP BY p.category
ORDER BY avg_amt DESC LIMIT 5;
```

### 18. Customers whose name contains 'an'.
```sql
SELECT customer_id, name FROM customers WHERE name LIKE '%an%';
```

### 19. Products whose name ends with '5'.
```sql
SELECT product_id, product_name FROM products WHERE product_name LIKE '%5' LIMIT 10;
```

### 20. Orders where amount is a multiple of 10.
```sql
SELECT * FROM orders WHERE amount % 10 = 0 LIMIT 15;
```

### 21. First 10 orders sorted by (customer_id asc, amount desc).
```sql
SELECT * FROM orders ORDER BY customer_id ASC, amount DESC LIMIT 10;
```

### 22. Top 10 customers by average amount per order.
```sql
SELECT c.customer_id, c.name, AVG(o.amount) AS avg_amt
FROM customers c JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY avg_amt DESC LIMIT 10;
```

### 23. Top 10 customers by number of distinct products.
```sql
SELECT c.customer_id, c.name, COUNT(DISTINCT o.product_id) AS distinct_products
FROM customers c JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY distinct_products DESC LIMIT 10;
```

### 24. Products with more than 50 orders.
```sql
SELECT p.product_id, p.product_name, COUNT(*) AS cnt
FROM products p JOIN orders o ON p.product_id=o.product_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(*) > 50
ORDER BY cnt DESC;
```

### 25. Spanish customers who never bought anything.
```sql
SELECT c.customer_id, c.name
FROM customers c LEFT JOIN orders o ON c.customer_id=o.customer_id
WHERE o.order_id IS NULL AND c.country='SPAIN';
```

