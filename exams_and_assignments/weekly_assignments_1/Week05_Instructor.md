# Week 5 – Instructor Solutions

1)  
```sql
SELECT c.customer_id, c.name, o.order_id, o.amount, o.status
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id;
```

2)  
```sql
SELECT c.customer_id, c.name, o.order_id, o.amount
FROM customers c
LEFT JOIN orders o ON c.customer_id=o.customer_id;
```

3)  
```sql
SELECT c.* FROM customers c
LEFT JOIN orders o ON c.customer_id=o.customer_id
WHERE o.order_id IS NULL;
```
*Expected:* customer_id=4 (Liam, UK).

4)  
```sql
SELECT c.name, SUM(o.amount) AS total
FROM customers c JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.name;
```

5)  
```sql
SELECT c.name, SUM(o.amount) AS total
FROM customers c JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.name
HAVING SUM(o.amount) > 250;
```

6)  
```sql
SELECT c.country, COUNT(o.order_id) AS orders_count
FROM customers c LEFT JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.country;
```

7)  
```sql
SELECT c.name, AVG(o.amount) AS avg_amount
FROM customers c JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.name;
```

8)  
```sql
SELECT o.order_id, o.amount, c.name
FROM orders o JOIN customers c ON o.customer_id=c.customer_id
WHERE o.status='PAID';
```

9)  
```sql
SELECT country, COUNT(*) AS customer_count
FROM customers
GROUP BY country
HAVING COUNT(*) >= 2;
```

10)  
```sql
SELECT c.name, SUM(o.amount) AS total
FROM customers c JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.name
ORDER BY total DESC LIMIT 1;
```
*Expected:* Emma or Ava depending on sums (Ava=320, Emma=300).

11)  
```sql
SELECT c.name, MAX(o.order_id) AS latest_order
FROM customers c JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.name;
```

12)  
Right join is equivalent to a left join with tables swapped. In this dataset (all orders have a valid customer), RIGHT JOIN orders→customers gives same rows as INNER JOIN.
