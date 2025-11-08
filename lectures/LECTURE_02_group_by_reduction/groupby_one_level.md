# Teaching GROUP BY in SQL/MySQL

This lesson introduces the GROUP BY concept in MySQL using a simple `sales` table.

---

## 📑 Schema

```sql
CREATE TABLE sales (
    id INT PRIMARY KEY,
    region VARCHAR(20),
    product VARCHAR(20),
    quantity INT,
    price DECIMAL(8,2)
);
```

---

## 📊 Sample Data (12 rows)

```sql
INSERT INTO sales VALUES
(1, 'East', 'Laptop', 3, 1200),
(2, 'East', 'Phone', 5, 800),
(3, 'East', 'Tablet', 2, 600),
(4, 'West', 'Laptop', 4, 1150),
(5, 'West', 'Phone', 6, 750),
(6, 'West', 'Tablet', 3, 620),
(7, 'North', 'Laptop', 2, 1250),
(8, 'North', 'Phone', 7, 820),
(9, 'North', 'Tablet', 4, 610),
(10, 'East', 'Laptop', 1, 1180),
(11, 'West', 'Phone', 8, 770),
(12, 'North', 'Tablet', 5, 605);
```

---

## 📝 10 GROUP BY Queries

### Q1. Find total quantity sold per region.

```sql
SELECT region, 
       SUM(quantity) AS total_quantity
FROM sales
GROUP BY region;
```

### Q2. Find average price per product.

```sql
SELECT product, 
       AVG(price) AS avg_price
FROM sales
GROUP BY product;
```

### Q3. Find total revenue (quantity × price) per region.

```sql
SELECT region, 
       SUM(quantity*price) AS total_revenue
FROM sales
GROUP BY region;
```

### Q4. Find total quantity sold per region and product.

```sql
SELECT region, 
       product, 
       SUM(quantity) AS total_quantity
FROM sales
GROUP BY region, product;
```

### Q5. Find highest price recorded per product.

```sql
SELECT product, 
       MAX(price) AS max_price
FROM sales
GROUP BY product;
```

### Q6. Find average quantity sold per product.

```sql
SELECT product, 
       AVG(quantity) AS avg_qty
FROM sales
GROUP BY product;
```

### Q7. Count how many transactions each region has.

```sql
SELECT region, 
       COUNT(*) AS num_transactions
FROM sales
GROUP BY region;
```

### Q8. Find minimum and maximum price per region.

```sql
SELECT region, 
       MIN(price) AS min_price, 
       MAX(price) AS max_price
FROM sales
GROUP BY region;
```

### Q9. Find total revenue per region and product.
```sql
SELECT region, 
       product, 
       SUM(quantity*price) AS total_revenue
FROM sales
GROUP BY region, product;
```

### Q10. Find the average revenue per transaction in each region.

```sql
SELECT region, 
       AVG(quantity*price) AS avg_revenue
FROM sales
GROUP BY region;
```
