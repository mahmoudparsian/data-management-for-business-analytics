1. Count number of customers per country.
```sql
SELECT country, COUNT(*) AS customer_count FROM customers GROUP BY country;
```

2. Find average price of sales per sale_type.
```sql
SELECT sale_type, AVG(price) AS avg_price FROM sales GROUP BY sale_type;
```

3. Compute total sales revenue.
```sql
SELECT SUM(price) AS total_revenue FROM sales;
```

4. Count number of products per category.
```sql
SELECT category, COUNT(*) AS product_count FROM products GROUP BY category;
```

5. Find average age of customers by gender.
```sql
SELECT gender, AVG(age) AS avg_age FROM customers GROUP BY gender;
```

6. Total revenue per customer (with names).
```sql
SELECT c.customer_id, c.name, SUM(s.price) AS total_spent FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.customer_id, c.name;
```

7. Total revenue per product (with names).
```sql
SELECT p.product_id, p.name, SUM(s.price) AS revenue FROM sales s JOIN products p ON s.product_id=p.product_id GROUP BY p.product_id, p.name;
```

8. Number of distinct customers who purchased anything.
```sql
SELECT COUNT(DISTINCT customer_id) AS distinct_buyers FROM sales;
```

9. Number of distinct products sold.
```sql
SELECT COUNT(DISTINCT product_id) AS distinct_products_sold FROM sales;
```

10. Total sales count per year.
```sql
SELECT YEAR(sale_date) AS yr, COUNT(*) AS sales_cnt FROM sales GROUP BY YEAR(sale_date) ORDER BY yr;
```

11. Average sale price per year.
```sql
SELECT YEAR(sale_date) AS yr, AVG(price) AS avg_price FROM sales GROUP BY YEAR(sale_date) ORDER BY yr;
```

12. Minimum and maximum sale price overall.
```sql
SELECT MIN(price) AS min_price, MAX(price) AS max_price FROM sales;
```

13. Average spend per customer country.
```sql
SELECT c.country, AVG(s.price) AS avg_price FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.country;
```

14. Total revenue by sale_type and year.
```sql
SELECT YEAR(sale_date) AS yr, sale_type, SUM(price) AS revenue FROM sales GROUP BY YEAR(sale_date), sale_type ORDER BY yr, sale_type;
```

15. Count sales per product category.
```sql
SELECT p.category, COUNT(*) AS sales_cnt FROM sales s JOIN products p ON s.product_id=p.product_id GROUP BY p.category;
```

16. Average price per product category.
```sql
SELECT p.category, AVG(s.price) AS avg_price FROM sales s JOIN products p ON s.product_id=p.product_id GROUP BY p.category;
```

17. Top 10 customers by number of purchases.
```sql
SELECT c.customer_id, c.name, COUNT(*) AS purchases FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY c.customer_id, c.name ORDER BY purchases DESC LIMIT 10;
```

18. Top 10 products by revenue.
```sql
SELECT p.product_id, p.name, SUM(s.price) AS revenue FROM sales s JOIN products p ON s.product_id=p.product_id GROUP BY p.product_id, p.name ORDER BY revenue DESC LIMIT 10;
```

19. Sales count per month in 2024.
```sql
SELECT MONTH(sale_date) AS mn, COUNT(*) AS sales_cnt FROM sales WHERE YEAR(sale_date)=2024 GROUP BY MONTH(sale_date) ORDER BY mn;
```

20. Average age of purchasing customers per sale_type.
```sql
SELECT sale_type, AVG(c.age) AS avg_age FROM sales s JOIN customers c ON s.customer_id=c.customer_id GROUP BY sale_type;
```

