# Lab-1 – Basics (25 queries)

> Tables: `customers`, `products`, `orders`

### 1. List all customers (first 10).
```sql
SELECT * 
FROM customers 
LIMIT 10;
```

### 2. List all products (first 10).
```sql
SELECT * 
FROM products 
LIMIT 10;
```

### 3. List all orders (first 10).
```sql
SELECT * 
FROM orders 
LIMIT 10;
```

### 4. Show customer names and countries.
```sql
SELECT name, country 
FROM customers 
LIMIT 15;
```

### 5. Find all customers from USA.
```sql
SELECT customer_id, name 
FROM customers 
WHERE country='USA';
```

### 6. Find customers age > 50.
```sql
SELECT customer_id, name, age 
FROM customers 
WHERE age > 50;
```

### 7. Find female customers from FRANCE.
```sql
SELECT name 
FROM customers 
WHERE gender='FEMALE' AND 
      country='FRANCE';
```

### 8. Products in category 'Electronics'.
```sql
SELECT product_id, product_name 
FROM products 
WHERE category='Electronics' 
LIMIT 15;
```

### 9. Find orders with amount > 150.
```sql
SELECT order_id, customer_id, product_id, amount 
FROM orders 
WHERE amount > 150 
LIMIT 15;
```

### 10. Sort customers by age descending (top 10).
```sql
SELECT customer_id, name, age 
FROM customers 
ORDER BY age DESC 
LIMIT 10;
```

### 11. Sort products by name ascending (first 10).
```sql
SELECT product_id, product_name 
FROM products 
ORDER BY product_name ASC 
LIMIT 10;
```

### 12. Find customers with name starting with 'A'.
```sql
SELECT customer_id, name 
FROM customers 
WHERE name LIKE 'A%';
```

### 13. Update one customer’s country to SPAIN (demo).
```sql
UPDATE customers 
SET country = 'SPAIN' 
WHERE customer_id = 1;
```

### 14. Insert a demo product.
```sql
INSERT INTO products 
VALUES 
(1001,'Demo Product','Books');
```

### 15. Delete the demo product.
```sql
DELETE 
FROM products 
WHERE product_id = 1001;
```

### 16. Count customers from each country.
```sql
SELECT country, COUNT(*) AS cnt 
FROM customers 
GROUP BY country;
```

### 17. Find orders with amount between 60 and 120.
```sql
SELECT * 
FROM orders 
WHERE amount BETWEEN 60 AND 120 
LIMIT 15;
```

### 18. List distinct product categories.
```sql
SELECT DISTINCT category 
FROM products;
```

### 19. Find customers age IN (25, 30, 35).
```sql
SELECT customer_id, name, age 
FROM customers 
WHERE age IN (25, 30, 35);
```

### 20. Find customers NOT from USA.
```sql
SELECT customer_id, name, country 
FROM customers 
WHERE country <> 'USA' 
LIMIT 15;
```

### 21. Top 5 biggest orders by amount.
```sql
SELECT order_id, customer_id, amount 
FROM orders 
ORDER BY amount DESC 
LIMIT 5;
```

### 22. Smallest 5 orders by amount.
```sql
SELECT order_id, customer_id, amount 
FROM orders 
ORDER BY amount ASC 
LIMIT 5;
```

### 23. Find customers age NULL or invalid.
```sql
SELECT * 
FROM customers 
WHERE age IS NULL OR age <= 0;
```

### 24. Preview join: orders + customers (first 10).
```sql
SELECT o.order_id, c.name, o.amount 
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id 
LIMIT 10;
```

### 25. Preview join: orders + products (first 10).
```sql
SELECT o.order_id, p.product_name, o.amount 
FROM orders o 
JOIN products p ON o.product_id = p.product_id 
LIMIT 10;
```

