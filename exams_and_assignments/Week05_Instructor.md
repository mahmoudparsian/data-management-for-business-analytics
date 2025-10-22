# Week 5 – Instructor Solutions


1) Inner join customers and orders.  

```sql
SELECT c.customer_id, 
       c.name, 
       o.order_id, 
       o.amount, 
       o.status
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id;
```

2) Left join customers and orders.  

```sql
SELECT c.customer_id, 
       c.name, 
       o.order_id, 
       o.amount
FROM customers c
LEFT JOIN orders o ON c.customer_id=o.customer_id;
```

3) Customers with no orders.  

```sql
SELECT c.* 
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```


4) Total order amount per customer.  

```sql
SELECT c.name, 
       SUM(o.amount) AS total
FROM customers c 
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.name;
```

5) Customers with total orders > 250.  

```sql
SELECT c.name, 
       SUM(o.amount) AS total
FROM customers c 
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.name
HAVING total > 250;
```

6) Number of orders per country.  

```sql
SELECT c.country, 
       COUNT(o.order_id) AS orders_count
FROM customers c 
LEFT JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.country;
```

7) Average order amount per customer.  
 
```sql
SELECT c.name, 
       AVG(o.amount) AS avg_amount
FROM customers c 
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.name;
```

8) Orders with status = 'PAID' and their customers.  

```sql
SELECT o.order_id, 
       o.amount, 
       c.name
FROM orders o 
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.status='PAID';
```

9) Countries with at least 2 customers.  

```sql
SELECT country, 
       COUNT(*) AS customer_count
FROM customers
GROUP BY country
HAVING customer_count >= 2;
```

10) Top customer by total spend.  

```sql
SELECT c.name, 
       SUM(o.amount) AS total
FROM customers c 
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.name
ORDER BY total DESC 
LIMIT 1;
```


11) Show each customer and their latest order_id (max).  
```sql
SELECT c.name, 
       MAX(o.order_id) AS latest_order
FROM customers c 
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.name;
```

12) Right join (explain why results match inner/left here). 
 
Right join is equivalent to a left join with tables swapped. 

In this dataset (all orders have a valid customer), 

RIGHT JOIN orders→customers gives same rows as INNER JOIN.
