1. Customers who spent above the average sale price overall.
```sql
WITH avg_price AS (SELECT AVG(price) AS a FROM sales) SELECT c.name, SUM(s.price) AS total FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.name HAVING total > (SELECT a FROM avg_price);
```

2. Products sold more times than the average product.
```sql
WITH prod_counts AS (SELECT product_id, COUNT(*) AS cnt FROM sales GROUP BY product_id) SELECT p.name, pc.cnt FROM prod_counts pc JOIN products p ON pc.product_id=p.product_id WHERE pc.cnt > (SELECT AVG(cnt) FROM prod_counts);
```

3. Customers ranked by spending within country (CTE).
```sql
WITH spend AS (SELECT c.country, c.name, SUM(s.price) AS total FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.country, c.name) SELECT country, name, total, RANK() OVER (PARTITION BY country ORDER BY total DESC) AS rnk FROM spend;
```

4. Categories with total sales above 5000.
```sql
WITH cat_sales AS (SELECT p.category, SUM(s.price) AS tot FROM sales s JOIN products p ON s.product_id=p.product_id GROUP BY p.category) SELECT * FROM cat_sales WHERE tot > 5000;
```

5. Customers who never bought Jewelry.
```sql
SELECT * FROM customers WHERE customer_id NOT IN (SELECT DISTINCT s.customer_id FROM sales s JOIN products p ON s.product_id=p.product_id WHERE p.category='Jewelry');
```

6. Customers who bought at least one product in every category that was sold.
```sql
WITH sold_categories AS (
  SELECT DISTINCT p.category FROM sales s JOIN products p ON s.product_id=p.product_id
), cust_cats AS (
  SELECT s.customer_id, p.category
  FROM sales s JOIN products p ON s.product_id=p.product_id
  GROUP BY s.customer_id, p.category
)
SELECT c.customer_id, c.name
FROM customers c
WHERE NOT EXISTS (
  SELECT sc.category FROM sold_categories sc
  WHERE sc.category NOT IN (
    SELECT cc.category FROM cust_cats cc WHERE cc.customer_id = c.customer_id
  )
);
```

7. Products whose average price is higher than their category average.
```sql
WITH prod_avg AS (
  SELECT p.product_id, p.category, AVG(s.price) AS pavg
  FROM sales s JOIN products p ON s.product_id=p.product_id
  GROUP BY p.product_id, p.category
), cat_avg AS (
  SELECT p.category, AVG(s.price) AS cavg
  FROM sales s JOIN products p ON s.product_id=p.product_id
  GROUP BY p.category
)
SELECT p.name
FROM prod_avg pa
JOIN cat_avg ca ON pa.category = ca.category
JOIN products p ON p.product_id = pa.product_id
WHERE pa.pavg > ca.cavg;
```

8. Customers with spending above their country average.
```sql
WITH country_avg AS (SELECT c.country, AVG(s.price) AS avg_price FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.country) SELECT c.name, SUM(s.price) AS total FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.name, c.country HAVING total > (SELECT avg_price FROM country_avg ca WHERE ca.country=c.country);
```

9. Top 3 customers per country by distinct products.
```sql
WITH cust_prod AS (SELECT c.customer_id, c.name, c.country, COUNT(DISTINCT s.product_id) AS cnt FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.customer_id, c.name, c.country) SELECT * FROM (SELECT *, DENSE_RANK() OVER (PARTITION BY country ORDER BY cnt DESC) AS rnk FROM cust_prod) t WHERE rnk <= 3;
```

10. Customers who bought from exactly 3 distinct categories.
```sql
WITH cust_cat AS (SELECT s.customer_id, COUNT(DISTINCT p.category) AS cat_cnt FROM sales s JOIN products p ON s.product_id=p.product_id GROUP BY s.customer_id) SELECT c.customer_id, c.name FROM cust_cat cc JOIN customers c ON cc.customer_id=c.customer_id WHERE cc.cat_cnt=3;
```

11. Years where revenue exceeded the prior year.
```sql
WITH yr_rev AS (SELECT YEAR(sale_date) AS yr, SUM(price) AS rev FROM sales GROUP BY YEAR(sale_date)) SELECT a.yr FROM yr_rev a JOIN yr_rev b ON a.yr=b.yr+1 WHERE a.rev > b.rev;
```

12. Customers whose maximum single purchase exceeds 450.
```sql
WITH mx AS (SELECT customer_id, MAX(price) AS mxp FROM sales GROUP BY customer_id) SELECT c.name, mx.mxp FROM mx JOIN customers c ON c.customer_id=mx.customer_id WHERE mxp > 450;
```

13. Categories ranked by number of buyers.
```sql
WITH buyers AS (SELECT p.category, s.customer_id FROM sales s JOIN products p ON s.product_id=p.product_id GROUP BY p.category, s.customer_id) SELECT category, COUNT(*) AS buyers, RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk FROM buyers GROUP BY category;
```

14. Products that were never bought with CASH.
```sql
SELECT p.* FROM products p WHERE p.product_id NOT IN (SELECT s.product_id FROM sales s WHERE s.sale_type='CASH');
```

15. Countries where average transaction price is above global average.
```sql
WITH g AS (SELECT AVG(price) AS gavg FROM sales), ctry AS (SELECT c.country, AVG(s.price) AS avgp FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.country) SELECT country FROM ctry WHERE avgp > (SELECT gavg FROM g);
```

16. Top 5 months by revenue across all years.
```sql
WITH m AS (SELECT DATE_FORMAT(sale_date,'%Y-%m') AS ym, SUM(price) AS rev FROM sales GROUP BY DATE_FORMAT(sale_date,'%Y-%m')) SELECT * FROM (SELECT ym, rev, RANK() OVER (ORDER BY rev DESC) AS rnk FROM m) t WHERE rnk <= 5;
```

17. Customers whose total CASH spending exceeds CREDIT spending.
```sql
WITH cash_sp AS (SELECT customer_id, SUM(price) AS cash_sum FROM sales WHERE sale_type='CASH' GROUP BY customer_id), credit_sp AS (SELECT customer_id, SUM(price) AS credit_sum FROM sales WHERE sale_type='CREDIT' GROUP BY customer_id) SELECT c.name FROM customers c LEFT JOIN cash_sp a ON c.customer_id=a.customer_id LEFT JOIN credit_sp b ON c.customer_id=b.customer_id WHERE IFNULL(a.cash_sum,0) > IFNULL(b.credit_sum,0);
```

18. Products that are top-1 by revenue within their category.
```sql
WITH prod_rev AS (SELECT p.product_id, p.name, p.category, SUM(s.price) AS rev FROM sales s JOIN products p ON s.product_id=p.product_id GROUP BY p.product_id, p.name, p.category) SELECT name, category, rev FROM (SELECT pr.*, RANK() OVER (PARTITION BY category ORDER BY rev DESC) AS rnk FROM prod_rev pr) t WHERE rnk=1;
```

19. Customers who purchased in every year products were sold.
```sql
WITH yrs AS (SELECT DISTINCT YEAR(sale_date) AS yr FROM sales), cust_years AS (SELECT s.customer_id, YEAR(sale_date) AS yr FROM sales s GROUP BY s.customer_id, YEAR(sale_date)) SELECT c.customer_id, c.name FROM customers c WHERE NOT EXISTS (SELECT y.yr FROM yrs y WHERE y.yr NOT IN (SELECT cy.yr FROM cust_years cy WHERE cy.customer_id=c.customer_id));
```

