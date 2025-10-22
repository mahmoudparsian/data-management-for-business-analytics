# MySQL Exercise

## Schema and Sample Data

```sql
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product VARCHAR(30),
    region VARCHAR(20),
    amount DECIMAL(10,2)
);

INSERT INTO sales VALUES
(1, 'Laptop', 'North', 1200),
(2, 'Laptop', 'North', 1500),
(3, 'Phone', 'South', 800),
(4, 'Tablet', 'South', 600),
(5, 'Laptop', 'East', 1000),
(6, 'Phone', 'East', 850),
(7, 'Tablet', 'East', 700),
(8, 'Laptop', 'North', 900),
(9, 'Laptop', 'North', 1100),
(10, 'Phone', 'West', 700),
(11, 'Tablet', 'West', 500),
(12, 'Laptop', 'West', 1400),
(13, 'Phone', 'West', 960),
(14, 'Tablet', 'South', 600),
(15, 'Watch', 'North', 400),
(16, 'Watch', 'North', 100),
(17, 'TV', 'South', 900),
(18, 'TV', 'South', 800),
(19, 'TV', 'East', 1000),
(20, 'Watch', 'East', 850),
(21, 'Watch', 'East', 700);


```

## Questions
1. Select total sales amount from all sales.
2. Find average sales amount.
3. Find minimum and maximum sales amount.
4. Count number of sales records.
5. Find total sales per region.
6. Find average sales per product.
7. Find total sales per product per region.
8. Count number of sales per region.
9. Show the total sales for each region, ordered from highest to lowest.
10. Find the top-selling product in each region (this identifies the best-performing product per region)

## Answers
1. SELECT SUM(amount) FROM sales;
2. SELECT AVG(amount) FROM sales;
3. SELECT MIN(amount), MAX(amount) FROM sales;
4. SELECT COUNT(*) FROM sales;
5. SELECT region, SUM(amount) FROM sales GROUP BY region;
6. SELECT product, AVG(amount) FROM sales GROUP BY product;
7. SELECT product, region, SUM(amount) FROM sales GROUP BY product, region;
8. SELECT region, count(*) FROM sales group by region;
9. SELECT region, SUM(amount) AS total_sales FROM sales GROUP BY region ORDER BY total_sales DESC;

### 10.

```sql
WITH Region_Product AS (
    SELECT region, product, SUM(amount) AS total_sales
    FROM sales
    GROUP BY region, product
),
Region_Max AS (
    SELECT region, MAX(total_sales) AS max_sales
    FROM Region_Product
    GROUP BY region
)
SELECT rp.region, rp.product, rp.total_sales
FROM Region_Product rp
JOIN Region_Max rm 
  ON rp.region = rm.region 
 AND rp.total_sales = rm.max_sales
ORDER BY rp.region;
```

