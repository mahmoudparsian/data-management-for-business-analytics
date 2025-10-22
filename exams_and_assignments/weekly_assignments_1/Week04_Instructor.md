# Week 4 – Instructor Solutions

1)  
```sql
SELECT COUNT(*) AS total_sales FROM sales;
```

2)  
```sql
SELECT SUM(amount) AS revenue FROM sales;
```

3)  
```sql
SELECT AVG(amount) AS avg_amount FROM sales;
```

4)  
```sql
SELECT MAX(amount) AS max_amount, MIN(amount) AS min_amount FROM sales;
```

5)  
```sql
SELECT region, SUM(amount) AS revenue FROM sales GROUP BY region;
```

6)  
```sql
SELECT status, COUNT(*) AS cnt FROM sales GROUP BY status;
```

7)  
```sql
SELECT region, AVG(amount) AS avg_amount FROM sales GROUP BY region;
```

8)  
```sql
SELECT region, SUM(amount) AS revenue 
FROM sales 
GROUP BY region 
HAVING SUM(amount) > 300;
```

9)  
```sql
SELECT region, COUNT(DISTINCT customer) AS customers FROM sales GROUP BY region;
```

10)  
```sql
SELECT region, SUM(amount) AS revenue 
FROM sales 
GROUP BY region 
ORDER BY revenue DESC LIMIT 1;
```

11)  
```sql
SELECT AVG(amount) AS avg_paid FROM sales WHERE status='PAID';
```

12)  
```sql
SELECT region, SUM(amount) AS revenue, AVG(amount) AS avg_amount
FROM sales
GROUP BY region;
```
