# 📘 Teacher’s Answer Key — Payments + Shipments Lab

This file contains the full SQL solutions for all **30 lab queries**.

---

## 🔹 10 Simple Queries

**1. List all customers.**
```sql
SELECT * FROM customers;
```

**2. Show all orders with paid_price.**
```sql
SELECT order_id, paid_price FROM orders;
```

**3. Show all payment methods used.**
```sql
SELECT DISTINCT method FROM payments;
```

**4. List all shipments with status Delivered.**
```sql
SELECT * FROM shipments WHERE status='Delivered';
```

**5. Find orders where price > 500.**
```sql
SELECT * FROM orders WHERE paid_price > 500;
```

**6. Show all payments made via PayPal.**
```sql
SELECT * FROM payments WHERE method='PayPal';
```

**7. List orders not yet delivered.**
```sql
SELECT * FROM shipments WHERE delivery_date IS NULL;
```

**8. Show all products ordered by Alice.**
```sql
SELECT o.order_id, p.product_name
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
JOIN products p ON o.product_id=p.product_id
WHERE c.name='Alice';
```

**9. Count total customers.**
```sql
SELECT COUNT(*) AS total_customers FROM customers;
```

**10. Count total products.**
```sql
SELECT COUNT(*) AS total_products FROM products;
```

---

## 🔹 10 Simple-to-Intermediate Queries

**11. Show all orders with customer name, product name, and payment method.**
```sql
SELECT o.order_id, c.name AS customer, p.product_name, pay.method
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
JOIN products p ON o.product_id=p.product_id
JOIN payments pay ON o.order_id=pay.order_id;
```

**12. Find total revenue per payment method.**
```sql
SELECT method, SUM(amount) AS total_revenue
FROM payments
GROUP BY method;
```

**13. Count shipments by status.**
```sql
SELECT status, COUNT(*) AS count_shipments
FROM shipments
GROUP BY status;
```

**14. Average paid_price per product category.**
```sql
SELECT p.category, AVG(o.paid_price) AS avg_price
FROM orders o
JOIN products p ON o.product_id=p.product_id
GROUP BY p.category;
```

**15. List customers with more than 2 orders.**
```sql
SELECT c.name, COUNT(*) AS order_count
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.name
HAVING COUNT(*) > 2;
```

**16. Show orders with shipment carrier and delivery status.**
```sql
SELECT o.order_id, c.name, s.carrier, s.status
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
JOIN shipments s ON o.order_id=s.order_id;
```

**17. List payments where amount < 100.**
```sql
SELECT * FROM payments WHERE amount < 100;
```

**18. Find the max paid_price per country.**
```sql
SELECT c.country, MAX(o.paid_price) AS max_price
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.country;
```

**19. Count orders by country.**
```sql
SELECT c.country, COUNT(o.order_id) AS order_count
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.country;
```

**20. Show top 3 products by total revenue.**
```sql
SELECT p.product_name, SUM(o.paid_price) AS revenue
FROM orders o
JOIN products p ON o.product_id=p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 3;
```

---

## 🔹 10 Intermediate Queries (CTEs + Ranking)

**21. With CTE: Find customers ranked by total spend.**
```sql
WITH spend AS (
  SELECT c.name, SUM(o.paid_price) AS total_spend
  FROM orders o
  JOIN customers c ON o.customer_id=c.customer_id
  GROUP BY c.name
)
SELECT name, total_spend,
       RANK() OVER (ORDER BY total_spend DESC) AS spend_rank
FROM spend;
```

**22. With CTE: Rank products by total revenue.**
```sql
WITH prod_rev AS (
  SELECT p.product_name, SUM(o.paid_price) AS revenue
  FROM orders o
  JOIN products p ON o.product_id=p.product_id
  GROUP BY p.product_name
)
SELECT product_name, revenue,
       RANK() OVER (ORDER BY revenue DESC) AS rank_revenue
FROM prod_rev;
```

**23. With CTE: Top customer per country by spend.**
```sql
WITH spend AS (
  SELECT c.country, c.name, SUM(o.paid_price) AS total_spend
  FROM orders o
  JOIN customers c ON o.customer_id=c.customer_id
  GROUP BY c.country, c.name
),
ranked AS (
  SELECT country, name, total_spend,
         ROW_NUMBER() OVER (PARTITION BY country ORDER BY total_spend DESC) AS rn
  FROM spend
)
SELECT country, name, total_spend
FROM ranked
WHERE rn=1;
```

**24. With ROW_NUMBER: Top 2 shipments per order by date.**
```sql
WITH ranked_shipments AS (
  SELECT order_id, shipment_id, shipped_date,
         ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY shipped_date) AS rn
  FROM shipments
)
SELECT * FROM ranked_shipments WHERE rn <= 2;
```

**25. With DENSE_RANK: Rank carriers by number of shipments.**
```sql
SELECT carrier, COUNT(*) AS shipment_count,
       DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS carrier_rank
FROM shipments
GROUP BY carrier;
```

**26. With RANK: Rank customers by number of orders.**
```sql
WITH cnt AS (
  SELECT c.name, COUNT(o.order_id) AS order_count
  FROM orders o
  JOIN customers c ON o.customer_id=c.customer_id
  GROUP BY c.name
)
SELECT name, order_count,
       RANK() OVER (ORDER BY order_count DESC) AS rank_order
FROM cnt;
```

**27. With CTE: Find customers who only used Credit Card.**
```sql
WITH methods AS (
  SELECT c.name, COUNT(DISTINCT p.method) AS methods_used
  FROM customers c
  JOIN orders o ON c.customer_id=o.customer_id
  JOIN payments p ON o.order_id=p.order_id
  GROUP BY c.name
  HAVING methods_used=1
)
SELECT * FROM methods
WHERE name IN (
  SELECT c.name
  FROM customers c
  JOIN orders o ON c.customer_id=o.customer_id
  JOIN payments p ON o.order_id=p.order_id
  WHERE p.method='Credit Card'
);
```

**28. With ROW_NUMBER: For each product, show the top order by paid_price.**
```sql
WITH ranked_orders AS (
  SELECT p.product_name, o.order_id, o.paid_price,
         ROW_NUMBER() OVER (PARTITION BY p.product_name ORDER BY o.paid_price DESC) AS rn
  FROM orders o
  JOIN products p ON o.product_id=p.product_id
)
SELECT * FROM ranked_orders WHERE rn=1;
```

**29. With CTE: Find categories where average spend > overall average.**
```sql
WITH cat_avg AS (
  SELECT p.category, AVG(o.paid_price) AS avg_price
  FROM orders o
  JOIN products p ON o.product_id=p.product_id
  GROUP BY p.category
),
overall AS (
  SELECT AVG(avg_price) AS overall_avg FROM cat_avg
)
SELECT c.category, c.avg_price
FROM cat_avg c, overall o
WHERE c.avg_price > o.overall_avg;
```

**30. With RANK: Rank orders by paid_price within each customer.**
```sql
SELECT c.name, o.order_id, o.paid_price,
       RANK() OVER (PARTITION BY c.name ORDER BY o.paid_price DESC) AS price_rank
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id;
```

---

✅ End of Teacher’s Key
