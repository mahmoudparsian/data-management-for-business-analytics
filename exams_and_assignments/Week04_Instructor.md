# Week 4 – Instructor Solutions


1)  Total number of sales. 

```sql
SELECT COUNT(*) AS total_sales 
FROM sales;
```

2) Total revenue (sum of amount).  

```sql
SELECT SUM(amount) AS revenue 
FROM sales;
```

3) Average sale amount.  

```sql
SELECT AVG(amount) AS avg_amount 
FROM sales;
```

4) Max and Min sale amounts.  
 
```sql
SELECT MAX(amount) AS max_amount, 
       MIN(amount) AS min_amount 
FROM sales;
```

5) Revenue by region.  
 
```sql
SELECT region, SUM(amount) AS revenue 
FROM sales 
GROUP BY region;
```

6) Count of sales by status.  
  
```sql
SELECT status, COUNT(*) AS status_count 
FROM sales 
GROUP BY status;
```

7) Average sale by region.  

```sql
SELECT region, AVG(amount) AS avg_amount 
FROM sales 
GROUP BY region;
```

8) Regions with total revenue > 300.  

solution-1:

```sql
   SELECT region, SUM(amount) AS revenue 
   FROM sales 
   GROUP BY region 
   HAVING SUM(amount) > 300;
```

solution-2:

```sql
   WITH total_sales AS
   (
     SELECT region, SUM(amount) AS revenue 
     FROM sales 
     GROUP BY region
   )
   SELECT region, revenue 
   FROM total_sales  
   WHERE revenue > 300;
```

9) Number of customers per region.  

```sql
SELECT region, COUNT(DISTINCT customer) AS customers 
FROM sales 
GROUP BY region;
```

10) Top region by revenue.  

```sql
SELECT region, SUM(amount) AS revenue 
FROM sales 
GROUP BY region 
ORDER BY revenue DESC 
LIMIT 1;
```

11) Average amount for PAID sales only.  
 
```sql
SELECT AVG(amount) AS avg_paid 
FROM sales 
WHERE status='PAID';
```

12) For each region, show revenue and average amount.

```sql
SELECT region, 
       SUM(amount) AS revenue, 
       AVG(amount) AS avg_amount
FROM sales
GROUP BY region;
```
