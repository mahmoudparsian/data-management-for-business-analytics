1. Customers who bought from all categories ever sold (set division).
```sql
WITH cats AS (
  SELECT DISTINCT p.category FROM sales s JOIN products p ON s.product_id=p.product_id
), cust_cats AS (
  SELECT s.customer_id, p.category
  FROM sales s JOIN products p ON s.product_id=p.product_id
  GROUP BY s.customer_id, p.category
)
SELECT c.customer_id, c.name
FROM customers c
WHERE NOT EXISTS (
  SELECT ct.category FROM cats ct
  WHERE ct.category NOT IN (
    SELECT cc.category FROM cust_cats cc WHERE cc.customer_id = c.customer_id
  )
);
```

2. Products never purchased by customers in Germany.
```sql
SELECT * FROM products p WHERE p.product_id NOT IN (SELECT DISTINCT s.product_id FROM sales s JOIN customers c ON s.customer_id=c.customer_id WHERE c.country='GERMANY');
```

3. Monthly revenue and month-over-month growth (using LAG).
```sql
WITH m AS (SELECT DATE_FORMAT(sale_date,'%Y-%m') AS ym, SUM(price) AS rev FROM sales GROUP BY DATE_FORMAT(sale_date,'%Y-%m')) SELECT ym, rev, (rev - LAG(rev) OVER (ORDER BY ym)) AS mom_change FROM m ORDER BY ym;
```

4. Top customer in each country by spending.
```sql
SELECT country, name, total FROM (SELECT c.country, c.name, SUM(s.price) AS total, RANK() OVER (PARTITION BY c.country ORDER BY SUM(s.price) DESC) AS rnk FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.country, c.name) t WHERE rnk=1;
```

5. Customers who bought more than 10 distinct products.
```sql
SELECT c.name, COUNT(DISTINCT s.product_id) AS cnt FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.name HAVING cnt>10;
```

6. Pareto analysis: cumulative revenue share by customers.
```sql
WITH cust_rev AS (SELECT c.customer_id, c.name, SUM(s.price) AS rev FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.customer_id, c.name), ranked AS (SELECT *, RANK() OVER (ORDER BY rev DESC) AS rnk, SUM(rev) OVER () AS total_rev, SUM(rev) OVER (ORDER BY rev DESC) AS cum_rev FROM cust_rev) SELECT name, rev, cum_rev/total_rev AS cum_share FROM ranked ORDER BY rnk;
```

7. Products with revenue in the top 10% (NTILE).
```sql
WITH pr AS (SELECT p.product_id, p.name, SUM(s.price) AS rev FROM sales s JOIN products p ON s.product_id=p.product_id GROUP BY p.product_id, p.name) SELECT * FROM (SELECT pr.*, NTILE(10) OVER (ORDER BY rev DESC) AS decile FROM pr) t WHERE decile=1;
```

8. Yearly revenue, best month per year.
```sql
WITH ym AS (SELECT YEAR(sale_date) AS yr, MONTH(sale_date) AS mn, SUM(price) AS rev FROM sales GROUP BY YEAR(sale_date), MONTH(sale_date)) SELECT * FROM (SELECT ym.*, RANK() OVER (PARTITION BY yr ORDER BY rev DESC) AS rnk FROM ym) t WHERE rnk=1;
```

9. Customers with at least one purchase in consecutive years.
```sql
WITH yrs AS (SELECT customer_id, YEAR(sale_date) AS yr FROM sales GROUP BY customer_id, YEAR(sale_date)) SELECT DISTINCT c.name FROM (SELECT y1.customer_id FROM yrs y1 JOIN yrs y2 ON y1.customer_id=y2.customer_id AND y2.yr=y1.yr+1) t JOIN customers c ON c.customer_id=t.customer_id;
```

10. Category mix per country (share of revenue).
```sql
WITH cat_rev AS (SELECT c.country, p.category, SUM(s.price) AS rev FROM sales s JOIN customers c ON s.customer_id=c.customer_id JOIN products p ON s.product_id=p.product_id GROUP BY c.country, p.category), tot AS (SELECT country, SUM(rev) AS total_rev FROM cat_rev GROUP BY country) SELECT cr.country, cr.category, cr.rev / t.total_rev AS share FROM cat_rev cr JOIN tot t ON cr.country=t.country ORDER BY cr.country, share DESC;
```

11. Customers who never used CASH.
```sql
SELECT * FROM customers c WHERE NOT EXISTS (SELECT 1 FROM sales s WHERE s.customer_id=c.customer_id AND s.sale_type='CASH') AND EXISTS (SELECT 1 FROM sales s WHERE s.customer_id=c.customer_id);
```

12. Longest gap in days between purchases per customer.
```sql
WITH purchases AS (SELECT customer_id, sale_date, LAG(sale_date) OVER (PARTITION BY customer_id ORDER BY sale_date) AS prev_date FROM sales), gaps AS (SELECT customer_id, DATEDIFF(sale_date, prev_date) AS gap_days FROM purchases WHERE prev_date IS NOT NULL) SELECT c.name, MAX(gap_days) AS max_gap FROM gaps g JOIN customers c ON c.customer_id=g.customer_id GROUP BY c.name ORDER BY max_gap DESC;
```

13. Top 3 categories by number of distinct buyers.
```sql
WITH buyers AS (SELECT p.category, s.customer_id FROM sales s JOIN products p ON s.product_id=p.product_id GROUP BY p.category, s.customer_id) SELECT category, COUNT(*) AS buyers FROM buyers GROUP BY category ORDER BY buyers DESC LIMIT 3;
```

14. Customers whose average purchase price increased year-over-year.
```sql
WITH yr_cust AS (SELECT customer_id, YEAR(sale_date) AS yr, AVG(price) AS avgp FROM sales GROUP BY customer_id, YEAR(sale_date)), cmp AS (SELECT a.customer_id FROM yr_cust a JOIN yr_cust b ON a.customer_id=b.customer_id AND a.yr=b.yr+1 WHERE a.avgp > b.avgp) SELECT DISTINCT c.name FROM cmp JOIN customers c ON c.customer_id=cmp.customer_id;
```

15. Products with zero sales in any given year where other products sold.
```sql
WITH years AS (SELECT DISTINCT YEAR(sale_date) AS yr FROM sales), prod_years AS (SELECT p.product_id, y.yr FROM products p JOIN years y), sold AS (SELECT product_id, YEAR(sale_date) AS yr FROM sales GROUP BY product_id, YEAR(sale_date)) SELECT p.product_id FROM prod_years p LEFT JOIN sold s ON p.product_id=s.product_id AND p.yr=s.yr WHERE s.product_id IS NULL GROUP BY p.product_id;
```

16. Recursive CTE: list months from min to max sale_date.
```sql
WITH RECURSIVE months AS (SELECT DATE_FORMAT(MIN(sale_date),'%Y-%m-01') AS m FROM sales UNION ALL SELECT DATE_FORMAT(DATE_ADD(m, INTERVAL 1 MONTH),'%Y-%m-01') FROM months WHERE DATE_ADD(m, INTERVAL 1 MONTH) <= DATE_FORMAT((SELECT MAX(sale_date) FROM sales),'%Y-%m-01')) SELECT * FROM months;
```

17. Customers whose second purchase is greater or equal to their first.
```sql
WITH ord AS (SELECT customer_id, sale_date, price, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY sale_date) AS rn FROM sales), a AS (SELECT customer_id, price AS p1 FROM ord WHERE rn=1), b AS (SELECT customer_id, price AS p2 FROM ord WHERE rn=2) SELECT c.name FROM a JOIN b USING (customer_id) JOIN customers c ON c.customer_id=a.customer_id WHERE b.p2 >= a.p1;
```

18. Customers and the share of revenue they contribute within their country.
```sql
WITH cr AS (SELECT c.country, c.customer_id, SUM(s.price) AS rev FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.country, c.customer_id), tot AS (SELECT country, SUM(rev) AS total_rev FROM cr GROUP BY country) SELECT cu.name, cr.country, cr.rev/t.total_rev AS share FROM cr JOIN tot t ON cr.country=t.country JOIN customers cu ON cu.customer_id=cr.customer_id ORDER BY cr.country, share DESC;
```

19. Most expensive product per category by average selling price.
```sql
WITH pavg AS (SELECT p.product_id, p.category, AVG(s.price) AS avgp FROM sales s JOIN products p ON s.product_id=p.product_id GROUP BY p.product_id, p.category) SELECT p.name, pavg.category, pavg.avgp FROM pavg JOIN products p ON p.product_id=pavg.product_id WHERE (pavg.category, pavg.avgp) IN (SELECT category, MAX(avgp) FROM pavg GROUP BY category);
```

20. Find the country with the highest revenue variance across months.
```sql
WITH m AS (SELECT c.country, DATE_FORMAT(sale_date,'%Y-%m') AS ym, SUM(s.price) AS rev FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.country, DATE_FORMAT(sale_date,'%Y-%m')), stats AS (SELECT country, AVG(rev) AS avg_rev FROM m GROUP BY country) SELECT m.country FROM m JOIN stats s ON m.country=s.country GROUP BY m.country ORDER BY (AVG(POW(rev - s.avg_rev,2))) DESC LIMIT 1;
```

