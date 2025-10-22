1. Top 5 customers by total spending.
```sql
SELECT c.name, SUM(s.price) AS total_spent FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.name ORDER BY total_spent DESC LIMIT 5;
```

2. Rank products by total sales count.
```sql
SELECT p.name, COUNT(*) AS cnt, RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk FROM sales s JOIN products p ON s.product_id=p.product_id GROUP BY p.name;
```

3. Find youngest customer in each country.
```sql
SELECT country, name, age FROM (SELECT country, name, age, ROW_NUMBER() OVER (PARTITION BY country ORDER BY age ASC) AS rn FROM customers) t WHERE rn=1;
```

4. Average sales price per customer.
```sql
SELECT customer_id, AVG(price) AS avg_price FROM sales GROUP BY customer_id;
```

5. Total revenue per year.
```sql
SELECT YEAR(sale_date) AS yr, SUM(price) AS revenue FROM sales GROUP BY YEAR(sale_date) ORDER BY yr;
```

6. Rank customers by spending (global).
```sql
SELECT c.customer_id, c.name, SUM(s.price) AS total, RANK() OVER (ORDER BY SUM(s.price) DESC) AS rnk FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.customer_id, c.name;
```

7. Rank customers by spending within country.
```sql
SELECT c.country, c.name, SUM(s.price) AS total, RANK() OVER (PARTITION BY c.country ORDER BY SUM(s.price) DESC) AS rnk FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.country, c.name;
```

8. Find oldest customer in each country.
```sql
SELECT country, name, age FROM (SELECT country, name, age, ROW_NUMBER() OVER (PARTITION BY country ORDER BY age DESC) AS rn FROM customers) t WHERE rn=1;
```

9. Running total of revenue by year.
```sql
SELECT YEAR(sale_date) AS yr, SUM(price) AS yearly_rev, SUM(SUM(price)) OVER (ORDER BY YEAR(sale_date)) AS running_total FROM sales GROUP BY YEAR(sale_date);
```

10. Top 3 products by revenue per category.
```sql
SELECT category, name, revenue FROM (SELECT p.category, p.name, SUM(s.price) AS revenue, DENSE_RANK() OVER (PARTITION BY p.category ORDER BY SUM(s.price) DESC) AS rnk FROM sales s JOIN products p ON s.product_id=p.product_id GROUP BY p.category, p.name) t WHERE rnk <= 3;
```

11. Customers with more than 5 purchases.
```sql
SELECT c.customer_id, c.name, COUNT(*) AS purchases FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.customer_id, c.name HAVING purchases > 5;
```

12. Products with average sale price above 300.
```sql
SELECT p.product_id, p.name, AVG(s.price) AS avg_price FROM sales s JOIN products p ON s.product_id=p.product_id GROUP BY p.product_id, p.name HAVING avg_price > 300;
```

13. Customers buying at least 10 distinct products.
```sql
SELECT c.customer_id, c.name, COUNT(DISTINCT s.product_id) AS distinct_products FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.customer_id, c.name HAVING distinct_products >= 10;
```

14. Monthly revenue with rank per year.
```sql
SELECT YEAR(sale_date) AS yr, MONTH(sale_date) AS mn, SUM(price) AS revenue, RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY SUM(price) DESC) AS rnk FROM sales GROUP BY YEAR(sale_date), MONTH(sale_date);
```

15. Rank countries by total revenue.
```sql
SELECT country, SUM(price) AS revenue, RANK() OVER (ORDER BY SUM(price) DESC) AS rnk FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY country;
```

16. Top 5 youngest purchasers (with ties).
```sql
SELECT name, age FROM (SELECT c.name, c.age, DENSE_RANK() OVER (ORDER BY c.age ASC) AS rnk FROM customers c WHERE c.customer_id IN (SELECT DISTINCT customer_id FROM sales)) t WHERE rnk <= 5;
```

17. Customers with the highest single transaction (top 10).
```sql
SELECT name, price FROM (SELECT c.name, s.price, RANK() OVER (ORDER BY s.price DESC) AS rnk FROM sales s JOIN customers c ON s.customer_id=c.customer_id) t WHERE rnk <= 10;
```

18. Customers ranked by count of CREDIT purchases.
```sql
SELECT c.name, COUNT(*) AS credit_cnt, RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk FROM sales s JOIN customers c ON s.customer_id=c.customer_id WHERE s.sale_type='CREDIT' GROUP BY c.name;
```

19. Products ranked by number of distinct buyers.
```sql
SELECT p.name, COUNT(DISTINCT s.customer_id) AS buyers, RANK() OVER (ORDER BY COUNT(DISTINCT s.customer_id) DESC) AS rnk FROM sales s JOIN products p ON s.product_id=p.product_id GROUP BY p.name;
```

