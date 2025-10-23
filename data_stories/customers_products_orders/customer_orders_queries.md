# SQL Queries Library — Customer & Order Model

This file contains **90 queries**: 

* 30 Simple, 
* 30 Simple-to-Intermediate, 
* 30 Intermediate (CTEs + window/ranking).

---

## 30 Simple Queries

**1. List all customers**
```sql
SELECT * 
FROM customers;
```

**2. List all products**
```sql
SELECT * 
FROM products;
```

**3. List all orders**
```sql
SELECT * 
FROM orders;
```

**4. Find customers from Germany**
```sql
SELECT * 
FROM customers 
WHERE country='Germany';
```

**5. Find products in Electronics**
```sql
SELECT * 
FROM products 
WHERE category='Electronics';
```

**6. First 10 orders**
```sql
SELECT * 
FROM orders 
ORDER BY order_id 
LIMIT 10;
```

**7. Unique countries**
```sql
SELECT DISTINCT country 
FROM customers;
```

**8. Unique categories**
```sql
SELECT DISTINCT category 
FROM products;
```

**9. Customer by email (Alice)**
```sql
SELECT * 
FROM customers 
WHERE email='alice.johnson@example.com';
```

**10. Orders for customer_id=1**
```sql
SELECT * 
FROM orders 
WHERE customer_id=1;
```

**11. Orders for product_id=1**
```sql
SELECT * 
FROM orders 
WHERE product_id=1;
```

**12. Order + customer name**
```sql
SELECT o.order_id, 
       c.name, 
       o.paid_price 
FROM orders o 
JOIN customers c ON o.customer_id=c.customer_id;
```

**13. Order + product name**
```sql
SELECT o.order_id, 
       p.product_name, 
       o.paid_price 
FROM orders o 
JOIN products p ON o.product_id=p.product_id;
```

**14. Order + customer + product**
```sql
SELECT o.order_id, 
       c.name, 
       p.product_name, 
       o.paid_price 
FROM orders o 
JOIN customers c ON o.customer_id=c.customer_id 
JOIN products p ON o.product_id=p.product_id;
```

**15. Count customers**
```sql
SELECT COUNT(*) AS n_customers 
FROM customers;
```

**16. Count products**
```sql
SELECT COUNT(*) AS n_products 
FROM products;
```

**17. Count orders**
```sql
SELECT COUNT(*) AS n_orders 
FROM orders;
```

**18. Customers with no orders (LEFT anti-join)**
```sql
SELECT c.* 
FROM customers c 
LEFT JOIN orders o ON c.customer_id=o.customer_id 
WHERE o.order_id IS NULL;
```

**19. Products never sold (LEFT anti-join)**
```sql
SELECT p.* 
FROM products p 
LEFT JOIN orders o ON p.product_id=o.product_id 
WHERE o.order_id IS NULL;
```

**20. Orders over 1000**
```sql
SELECT * 
FROM orders 
WHERE paid_price > 1000;
```

**21. Top 5 most expensive orders**
```sql
SELECT * 
FROM orders 
ORDER BY paid_price DESC 
LIMIT 5;
```

**22. Cheapest 5 orders**
```sql
SELECT * 
FROM orders 
ORDER BY paid_price ASC 
LIMIT 5;
```

**23. Customers from USA or Canada**
```sql
SELECT * 
FROM customers 
WHERE country IN ('USA','Canada');
```

**24. Products with color 'Black'**
```sql
SELECT * 
FROM products 
WHERE color='Black';
```

**25. Orders in 'Books' category**
```sql
SELECT o.* 
FROM orders o 
JOIN products p ON o.product_id=p.product_id 
WHERE p.category='Books';
```

**26. Orders for customer named 'Alice Johnson'**
```sql
SELECT o.* 
FROM orders o 
JOIN customers c ON o.customer_id=c.customer_id 
WHERE c.name='Alice Johnson';
```

**27. Total spend for customer_id=1**
```sql
SELECT SUM(paid_price) AS total_spend 
FROM orders 
WHERE customer_id=1;
```

**28. Average paid price overall**
```sql
SELECT AVG(paid_price) AS avg_price 
FROM orders;
```

**29. Average paid price per category**
```sql
SELECT p.category,   
       AVG(o.paid_price) AS avg_price 
FROM orders o 
JOIN products p ON o.product_id=p.product_id 
GROUP BY p.category;
```

**30. Sanity check: Any orders for unsold products (51–54)?**
```sql
SELECT * 
FROM orders 
WHERE product_id IN (51,52,53,54);
```

## 30 Simple-to-Intermediate Queries

**1. Orders per customer (count)**
```sql
SELECT c.customer_id, c.name, COUNT(o.order_id) AS order_count FROM customers c LEFT JOIN orders o ON c.customer_id=o.customer_id GROUP BY c.customer_id, c.name ORDER BY order_count DESC, c.name;
```

**2. Revenue per customer (sum)**
```sql
SELECT c.customer_id, c.name, SUM(o.paid_price) AS total_spend FROM customers c JOIN orders o ON c.customer_id=o.customer_id GROUP BY c.customer_id, c.name ORDER BY total_spend DESC;
```

**3. Revenue per category**
```sql
SELECT p.category, SUM(o.paid_price) AS revenue FROM orders o JOIN products p ON o.product_id=p.product_id GROUP BY p.category ORDER BY revenue DESC;
```

**4. Orders per category & color**
```sql
SELECT p.category, p.color, COUNT(*) AS orders FROM orders o JOIN products p ON o.product_id=p.product_id GROUP BY p.category, p.color ORDER BY orders DESC;
```

**5. Average price per category & color**
```sql
SELECT p.category, p.color, AVG(o.paid_price) AS avg_price FROM orders o JOIN products p ON o.product_id=p.product_id GROUP BY p.category, p.color ORDER BY avg_price DESC;
```

**6. Top 10 customers by total spend**
```sql
SELECT c.name, SUM(o.paid_price) AS total_spend FROM customers c JOIN orders o ON c.customer_id=o.customer_id GROUP BY c.name ORDER BY total_spend DESC LIMIT 10;
```

**7. Top 10 products by order count**
```sql
SELECT p.product_name, COUNT(*) AS times_ordered FROM orders o JOIN products p ON o.product_id=p.product_id GROUP BY p.product_name ORDER BY times_ordered DESC LIMIT 10;
```

**8. Products never sold (NOT EXISTS)**
```sql
SELECT p.* FROM products p WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.product_id=p.product_id);
```

**9. Customers with no orders (NOT EXISTS)**
```sql
SELECT c.* FROM customers c WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id=c.customer_id);
```

**10. Avg order value by country**
```sql
SELECT c.country, AVG(o.paid_price) AS avg_order_value FROM orders o JOIN customers c ON o.customer_id=c.customer_id GROUP BY c.country ORDER BY avg_order_value DESC;
```

**11. Count distinct customers per category**
```sql
SELECT p.category, COUNT(DISTINCT o.customer_id) AS distinct_customers FROM orders o JOIN products p ON o.product_id=p.product_id GROUP BY p.category ORDER BY distinct_customers DESC;
```

**12. Proportion of orders by category**
```sql
SELECT p.category, COUNT(*)*1.0/(SELECT COUNT(*) FROM orders) AS proportion FROM orders o JOIN products p ON o.product_id=p.product_id GROUP BY p.category ORDER BY proportion DESC;
```

**13. Colors appearing in at least 20 orders**
```sql
SELECT p.color, COUNT(*) AS cnt FROM orders o JOIN products p ON o.product_id=p.product_id GROUP BY p.color HAVING COUNT(*) >= 20 ORDER BY cnt DESC;
```

**14. Customers with average order value > 500**
```sql
SELECT c.name, AVG(o.paid_price) AS aov FROM customers c JOIN orders o ON c.customer_id=o.customer_id GROUP BY c.name HAVING AVG(o.paid_price) > 500 ORDER BY aov DESC;
```

**15. Categories with AVG price between 100 and 400**
```sql
SELECT p.category, AVG(o.paid_price) AS avg_price FROM orders o JOIN products p ON o.product_id=p.product_id GROUP BY p.category HAVING AVG(o.paid_price) BETWEEN 100 AND 400;
```

**16. Top 3 categories by revenue**
```sql
SELECT p.category, SUM(o.paid_price) AS revenue FROM orders o JOIN products p ON o.product_id=p.product_id GROUP BY p.category ORDER BY revenue DESC LIMIT 3;
```

**17. Order count distribution by customer (sorted)**
```sql
SELECT c.customer_id, c.name, COUNT(*) AS cnt FROM customers c LEFT JOIN orders o ON c.customer_id=o.customer_id GROUP BY c.customer_id, c.name ORDER BY cnt DESC;
```

**18. Most common color overall**
```sql
SELECT p.color, COUNT(*) AS cnt FROM orders o JOIN products p ON o.product_id=p.product_id GROUP BY p.color ORDER BY cnt DESC LIMIT 1;
```

**19. Customers who purchased from at least 4 categories**
```sql
SELECT c.name, COUNT(DISTINCT p.category) AS cat_count FROM customers c JOIN orders o ON c.customer_id=o.customer_id JOIN products p ON o.product_id=p.product_id GROUP BY c.name HAVING COUNT(DISTINCT p.category) >= 4;
```

**20. Avg vs total spend per customer**
```sql
SELECT c.name, COUNT(*) AS orders, SUM(o.paid_price) AS total_spend, AVG(o.paid_price) AS avg_spend FROM customers c JOIN orders o ON c.customer_id=o.customer_id GROUP BY c.name ORDER BY total_spend DESC;
```

**21. Revenue share by category (percent of total)**
```sql
SELECT p.category, ROUND(100*SUM(o.paid_price)/(SELECT SUM(paid_price) FROM orders),2) AS pct FROM orders o JOIN products p ON o.product_id=p.product_id GROUP BY p.category ORDER BY pct DESC;
```

**22. Best category-color combo by revenue**
```sql
SELECT p.category, p.color, SUM(o.paid_price) AS rev FROM orders o JOIN products p ON o.product_id=p.product_id GROUP BY p.category, p.color ORDER BY rev DESC LIMIT 1;
```

**23. Most expensive product sold (by order price)**
```sql
SELECT p.product_name, o.paid_price FROM orders o JOIN products p ON o.product_id=p.product_id ORDER BY o.paid_price DESC LIMIT 1;
```

**24. Least expensive order (with customer & product)**
```sql
SELECT o.order_id, c.name, p.product_name, o.paid_price FROM orders o JOIN customers c ON o.customer_id=c.customer_id JOIN products p ON o.product_id=p.product_id ORDER BY o.paid_price ASC LIMIT 1;
```

**25. Customers who bought both Books and Electronics**
```sql
SELECT c.name FROM customers c WHERE EXISTS (SELECT 1 FROM orders o JOIN products p ON o.product_id=p.product_id WHERE o.customer_id=c.customer_id AND p.category='Books') AND EXISTS (SELECT 1 FROM orders o JOIN products p ON o.product_id=p.product_id WHERE o.customer_id=c.customer_id AND p.category='Electronics');
```

**26. Top 5 customers by number of distinct categories**
```sql
SELECT c.name, COUNT(DISTINCT p.category) AS distinct_categories FROM customers c JOIN orders o ON c.customer_id=o.customer_id JOIN products p ON o.product_id=p.product_id GROUP BY c.name ORDER BY distinct_categories DESC, c.name LIMIT 5;
```

**27. Products by total revenue (top 10)**
```sql
SELECT p.product_name, SUM(o.paid_price) AS revenue FROM orders o JOIN products p ON o.product_id=p.product_id GROUP BY p.product_name ORDER BY revenue DESC LIMIT 10;
```

**28. Customers who only bought from one category**
```sql
SELECT c.name FROM customers c JOIN orders o ON c.customer_id=o.customer_id JOIN products p ON o.product_id=p.product_id GROUP BY c.name HAVING COUNT(DISTINCT p.category)=1;
```

**29. Customers who bought at least one item in Beauty**
```sql
SELECT DISTINCT c.name FROM customers c JOIN orders o ON c.customer_id=o.customer_id JOIN products p ON o.product_id=p.product_id WHERE p.category='Beauty';
```

**30. Top customer per country by order count**
```sql
SELECT country, name, order_count FROM (SELECT c.country, c.name, COUNT(*) AS order_count, ROW_NUMBER() OVER (PARTITION BY c.country ORDER BY COUNT(*) DESC) AS rn FROM customers c JOIN orders o ON c.customer_id=o.customer_id GROUP BY c.country, c.name) t WHERE rn=1;
```

## 30 Intermediate Queries (WITH, ROW_NUMBER, RANK, DENSE_RANK)

**1. Rank customers by total spend (CTE + RANK)**
```sql
WITH spend AS (
   SELECT c.customer_id, c.name, SUM(o.paid_price) AS total_spend
   FROM customers c JOIN orders o ON c.customer_id=o.customer_id
   GROUP BY c.customer_id, c.name
 )
 SELECT name, total_spend, RANK() OVER (ORDER BY total_spend DESC) AS spend_rank
 FROM spend;
```

**2. Top 3 customers by number of orders (ROW_NUMBER)**
```sql
WITH cnt AS (
   SELECT c.customer_id, c.name, COUNT(*) AS order_count
   FROM customers c JOIN orders o ON c.customer_id=o.customer_id
   GROUP BY c.customer_id, c.name
 ),
 r AS (
   SELECT name, order_count, ROW_NUMBER() OVER (ORDER BY order_count DESC) AS rn
   FROM cnt
 )
 SELECT * FROM r WHERE rn <= 3;
```

**3. Top product by revenue (CTE + ROW_NUMBER)**
```sql
WITH rev AS (
   SELECT p.product_id, p.product_name, SUM(o.paid_price) AS revenue
   FROM products p JOIN orders o ON p.product_id=o.product_id
   GROUP BY p.product_id, p.product_name
 )
 SELECT product_name, revenue
 FROM (
   SELECT product_name, revenue, ROW_NUMBER() OVER (ORDER BY revenue DESC) AS rn
   FROM rev
 ) x
 WHERE rn=1;
```

**4. Rank categories by average order value (AOV)**
```sql
WITH aov AS (
   SELECT p.category, AVG(o.paid_price) AS avg_price
   FROM orders o JOIN products p ON o.product_id=p.product_id
   GROUP BY p.category
 )
 SELECT category, avg_price, RANK() OVER (ORDER BY avg_price DESC) AS rnk
 FROM aov;
```

**5. Within each category, rank colors by revenue (DENSE_RANK)**
```sql
WITH color_rev AS (
   SELECT p.category, p.color, SUM(o.paid_price) AS revenue
   FROM orders o JOIN products p ON o.product_id=p.product_id
   GROUP BY p.category, p.color
 )
 SELECT category, color, revenue,
        DENSE_RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rnk
 FROM color_rev;
```

**6. Customers with total spend > overall average (CTE)**
```sql
WITH spend AS (
   SELECT c.customer_id, c.name, SUM(o.paid_price) AS total_spend
   FROM customers c JOIN orders o ON c.customer_id=o.customer_id
   GROUP BY c.customer_id, c.name
 ),
 overall AS (
   SELECT AVG(total_spend) AS avg_spend FROM spend
 )
 SELECT s.name, s.total_spend
 FROM spend s CROSS JOIN overall o
 WHERE s.total_spend > o.avg_spend
 ORDER BY s.total_spend DESC;
```

**7. Top 2 colors by revenue within each category**
```sql
WITH color_rev AS (
   SELECT p.category, p.color, SUM(o.paid_price) AS revenue
   FROM orders o JOIN products p ON o.product_id=p.product_id
   GROUP BY p.category, p.color
 ),
 ranked AS (
   SELECT category, color, revenue,
          ROW_NUMBER() OVER (PARTITION BY category ORDER BY revenue DESC) AS rn
   FROM color_rev
 )
 SELECT category, color, revenue FROM ranked WHERE rn <= 2;
```

**8. Customer order counts with percentile rank**
```sql
WITH cnt AS (
   SELECT c.customer_id, c.name, COUNT(*) AS order_count
   FROM customers c JOIN orders o ON c.customer_id=o.customer_id
   GROUP BY c.customer_id, c.name
 )
 SELECT name, order_count,
        ROUND(100.0 * (RANK() OVER (ORDER BY order_count) - 1) / (COUNT(*) OVER () - 1), 2) AS pct_rank
 FROM cnt;
```

**9. Product diversity per customer (distinct categories) + rank**
```sql
WITH diversity AS (
   SELECT c.customer_id, c.name, COUNT(DISTINCT p.category) AS distinct_categories
   FROM customers c JOIN orders o ON c.customer_id=o.customer_id
   JOIN products p ON o.product_id=p.product_id
   GROUP BY c.customer_id, c.name
 )
 SELECT name, distinct_categories,
        RANK() OVER (ORDER BY distinct_categories DESC) AS rnk
 FROM diversity;
```

**10. Customers with the single most expensive order (ties allowed)**
```sql
WITH mx AS ( SELECT MAX(paid_price) AS mxp FROM orders )
 SELECT c.name, o.order_id, o.paid_price
 FROM orders o JOIN customers c ON o.customer_id=c.customer_id
 JOIN mx ON o.paid_price=mx.mxp;
```

**11. Best customer per country by total spend**
```sql
WITH spend AS (
   SELECT c.customer_id, c.name, c.country, SUM(o.paid_price) AS total_spend
   FROM customers c JOIN orders o ON c.customer_id=o.customer_id
   GROUP BY c.customer_id, c.name, c.country
 ),
 ranked AS (
   SELECT *, ROW_NUMBER() OVER (PARTITION BY country ORDER BY total_spend DESC) AS rn
   FROM spend
 )
 SELECT country, name, total_spend FROM ranked WHERE rn=1;
```

**12. Rank products by number of orders within each category**
```sql
WITH cnt AS (
   SELECT p.category, p.product_name, COUNT(*) AS n
   FROM orders o JOIN products p ON o.product_id=p.product_id
   GROUP BY p.category, p.product_name
 )
 SELECT category, product_name, n,
        RANK() OVER (PARTITION BY category ORDER BY n DESC) AS rnk
 FROM cnt;
```

**13. Customers with above-average AOV (avg order value)**
```sql
WITH aov AS (
   SELECT c.customer_id, c.name, AVG(o.paid_price) AS avg_price
   FROM customers c JOIN orders o ON c.customer_id=o.customer_id
   GROUP BY c.customer_id, c.name
 ),
 overall AS ( SELECT AVG(avg_price) AS overall_avg FROM aov )
 SELECT a.name, a.avg_price
 FROM aov a CROSS JOIN overall o
 WHERE a.avg_price > o.overall_avg
 ORDER BY a.avg_price DESC;
```

**14. Least purchased category (fewest orders)**
```sql
WITH cat_counts AS (
   SELECT p.category, COUNT(*) AS n
   FROM orders o JOIN products p ON o.product_id=p.product_id
   GROUP BY p.category
 )
 SELECT * FROM cat_counts WHERE n = (SELECT MIN(n) FROM cat_counts);
```

**15. Within each country, rank customers by total spend**
```sql
WITH spend AS (
   SELECT c.customer_id, c.name, c.country, SUM(o.paid_price) AS total_spend
   FROM customers c JOIN orders o ON c.customer_id=o.customer_id
   GROUP BY c.customer_id, c.name, c.country
 )
 SELECT country, name, total_spend,
        RANK() OVER (PARTITION BY country ORDER BY total_spend DESC) AS rnk
 FROM spend
 ORDER BY country, rnk;
```

**16. Products contributing to top 20% cumulative revenue**
```sql
WITH prod_rev AS (
   SELECT p.product_id, p.product_name, SUM(o.paid_price) AS rev
   FROM products p JOIN orders o ON p.product_id=o.product_id
   GROUP BY p.product_id, p.product_name
 ),
 ranked AS (
   SELECT product_id, product_name, rev,
          ROW_NUMBER() OVER (ORDER BY rev DESC) AS rn,
          SUM(rev) OVER (ORDER BY rev DESC) AS cum_rev,
          SUM(rev) OVER () AS total_rev
   FROM prod_rev
 )
 SELECT product_name, rev, ROUND(100*cum_rev/total_rev,2) AS cum_pct
 FROM ranked
 WHERE cum_rev/total_rev <= 0.2;
```

**17. Customers who never purchased Electronics (anti-join via CTE)**
```sql
WITH electronics_buyers AS (
   SELECT DISTINCT o.customer_id
   FROM orders o JOIN products p ON o.product_id=p.product_id
   WHERE p.category='Electronics'
 )
 SELECT c.* FROM customers c
 LEFT JOIN electronics_buyers e ON c.customer_id=e.customer_id
 WHERE e.customer_id IS NULL;
```

**18. Color with highest average price per category (ties allowed)**
```sql
WITH color_avg AS (
   SELECT p.category, p.color, AVG(o.paid_price) As avg_price
   FROM orders o JOIN products p ON o.product_id=p.product_id
   GROUP BY p.category, p.color
 ),
 ranked AS (
   SELECT *, RANK() OVER (PARTITION BY category ORDER BY avg_price DESC) AS rnk
   FROM color_avg
 )
 SELECT category, color, avg_price FROM ranked WHERE rnk=1;
```

**19. Customers with at least 5 Electronics orders**
```sql
WITH cnt AS (
   SELECT c.customer_id, c.name, COUNT(*) AS n
   FROM customers c JOIN orders o ON c.customer_id=o.customer_id
   JOIN products p ON o.product_id=p.product_id
   WHERE p.category='Electronics'
   GROUP BY c.customer_id, c.name
 )
 SELECT * FROM cnt WHERE n >= 5;
```

**20. Best category per customer by spend**
```sql
WITH cust_cat AS (
   SELECT c.customer_id, c.name, p.category, SUM(o.paid_price) AS spend
   FROM customers c JOIN orders o ON c.customer_id=o.customer_id
   JOIN products p ON o.product_id=p.product_id
   GROUP BY c.customer_id, c.name, p.category
 ),
 ranked AS (
   SELECT *, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY spend DESC) AS rn
   FROM cust_cat
 )
 SELECT name, category, spend FROM ranked WHERE rn=1;
```

**21. Top 10 customers by revenue per month (example with dummy month)**
```sql
WITH by_month AS (
   SELECT c.name, DATE_FORMAT(CURDATE(), '%Y-%m') AS ym, SUM(o.paid_price) AS rev
   FROM customers c JOIN orders o ON c.customer_id=o.customer_id
   GROUP BY c.name
 ),
 ranked AS (
   SELECT name, ym, rev, ROW_NUMBER() OVER (PARTITION BY ym ORDER BY rev DESC) AS rn
   FROM by_month
 )
 SELECT * FROM ranked WHERE rn <= 10;
```

**22. Customers above median spend (approx via rank)**
```sql
WITH spend AS (
   SELECT c.customer_id, c.name, SUM(o.paid_price) AS total_spend
   FROM customers c JOIN orders o ON c.customer_id=o.customer_id
   GROUP BY c.customer_id, c.name
 ),
 ranked AS (
   SELECT name, total_spend,
          RANK() OVER (ORDER BY total_spend) AS rnk,
          COUNT(*) OVER () AS n
   FROM spend
 )
 SELECT name, total_spend FROM ranked WHERE rnk >= n/2;
```

**23. Customers who bought the top product in each category**
```sql
WITH prod_rank AS (
   SELECT p.category, p.product_id, p.product_name, COUNT(*) AS n,
          ROW_NUMBER() OVER (PARTITION BY p.category ORDER BY COUNT(*) DESC) AS rn
   FROM orders o JOIN products p ON o.product_id=p.product_id
   GROUP BY p.category, p.product_id, p.product_name
 ),
 top_prod AS ( SELECT * FROM prod_rank WHERE rn=1 )
 SELECT DISTINCT c.name, tp.category, tp.product_name
 FROM top_prod tp
 JOIN orders o ON o.product_id=tp.product_id
 JOIN customers c ON c.customer_id=o.customer_id;
```

**24. Top-spend quartile customers (NTILE)**
```sql
WITH spend AS (
   SELECT c.customer_id, c.name, SUM(o.paid_price) AS total_spend
   FROM customers c JOIN orders o ON c.customer_id=o.customer_id
   GROUP BY c.customer_id, c.name
 ),
 ranked AS (
   SELECT name, total_spend, NTILE(4) OVER (ORDER BY total_spend DESC) AS quartile
   FROM spend
 )
 SELECT * FROM ranked WHERE quartile=1;
```

**25. Rank customers by category-specific spend**
```sql
WITH cat_spend AS (
   SELECT c.customer_id, c.name, p.category, SUM(o.paid_price) AS spend
   FROM customers c JOIN orders o ON c.customer_id=o.customer_id
   JOIN products p ON o.product_id=p.product_id
   GROUP BY c.customer_id, c.name, p.category
 )
 SELECT category, name, spend,
        RANK() OVER (PARTITION BY category ORDER BY spend DESC) AS rnk
 FROM cat_spend;
```

**26. Customers who bought any of the top 3 revenue products overall**
```sql
WITH prod_rev AS (
   SELECT p.product_id, p.product_name, SUM(o.paid_price) AS rev
   FROM products p JOIN orders o ON p.product_id=o.product_id
   GROUP BY p.product_id, p.product_name
 ),
 top3 AS (
   SELECT product_id FROM (
     SELECT product_id, ROW_NUMBER() OVER (ORDER BY rev DESC) AS rn
     FROM prod_rev
   ) t WHERE rn <= 3
 )
 SELECT DISTINCT c.name
 FROM orders o JOIN customers c ON o.customer_id=c.customer_id
 WHERE o.product_id IN (SELECT product_id FROM top3);
```

**27. Categories where top 3 colors cover ≥60% of orders**
```sql
WITH color_counts AS (
   SELECT p.category, p.color, COUNT(*) AS n
   FROM orders o JOIN products p ON o.product_id=p.product_id
   GROUP BY p.category, p.color
 ),
 ranked AS (
   SELECT *, ROW_NUMBER() OVER (PARTITION BY category ORDER BY n DESC) AS rn,
            SUM(n) OVER (PARTITION BY category) AS total_n
   FROM color_counts
 ),
 top3 AS (
   SELECT category, SUM(n) AS top3_n, MAX(total_n) AS total_n
   FROM ranked WHERE rn <= 3 GROUP BY category
 )
 SELECT category, ROUND(100.0*top3_n/total_n,2) AS top3_pct
 FROM top3
 WHERE top3_n/total_n >= 0.6;
```

