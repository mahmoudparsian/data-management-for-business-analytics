

# Grouping, Aggregating, and Ranking in MySQL

---

## 📑 Step 1: Schema and Sample Data

```sql
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product VARCHAR(20),
    region VARCHAR(20),
    amount DECIMAL(10,2)
);

INSERT INTO sales VALUES
(1, 'Laptop', 'North', 1200.00),
(2, 'Laptop', 'North', 1500.00),
(3, 'Phone', 'North', 800.00),
(4, 'Phone', 'South', 950.00),
(5, 'Tablet', 'South', 600.00),
(6, 'Tablet', 'East', 700.00),
(7, 'Laptop', 'East', 1000.00),
(8, 'Phone', 'East', 850.00);
```

📊 **sales table**

| sale_id | product | region | amount  |
|---------|---------|--------|---------|
| 1       | Laptop  | North  | 1200.00 |
| 2       | Laptop  | North  | 1500.00 |
| 3       | Phone   | North  | 800.00  |
| 4       | Phone   | South  | 950.00  |
| 5       | Tablet  | South  | 600.00  |
| 6       | Tablet  | East   | 700.00  |
| 7       | Laptop  | East   | 1000.00 |
| 8       | Phone   | East   | 850.00  |

---

## 📑 Step 2: Grouping Data with Aggregations

### Example 1: Total sales amount per region

```sql
SELECT 
       region, 
       SUM(amount) AS total_sales
FROM 
       sales
GROUP BY 
       region;
```

✅ Output

| region | total_sales |
|--------|-------------|
| North  | 3500.00     |
| South  | 1550.00     |
| East   | 2550.00     |

---

### Example 2: Average sales amount per product

```sql
SELECT 
        product, 
        AVG(amount) AS avg_sales
FROM 
        sales
GROUP BY 
        product;
```

✅ Output

| product | avg_sales |
|---------|-----------|
| Laptop  | 1233.33   |
| Phone   | 866.67    |
| Tablet  | 650.00    |

---

### Example 3: Minimum and Maximum sales amount per region

```sql
SELECT 
       region, 
       MIN(amount) AS min_sale, 
       MAX(amount) AS max_sale
FROM 
       sales
GROUP BY 
       region;
```

✅ Output

| region | min_sale | max_sale |
|--------|----------|----------|
| North  | 800.00   | 1500.00  |
| South  | 600.00   | 950.00   |
| East   | 700.00   | 1000.00  |

---

### Example 4: Count number of sales per product

```sql
SELECT 
       product, 
       COUNT(*) AS num_sales
FROM 
       sales
GROUP BY 
       product;
```

✅ Output

| product | num_sales |
|---------|-----------|
| Laptop  | 3         |
| Phone   | 3         |
| Tablet  | 2         |

---

## 📑 Step 3: Ranking Data with RANK()

### Example 1: Rank regions by total sales

```sql
WITH Region_Sales AS (
  SELECT region, 
         SUM(amount) AS total_sales
  FROM 
         sales
  GROUP BY 
         region
)
SELECT 
       region, 
       total_sales,
       RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM 
       Region_Sales;
```

✅ Output

| region | total_sales | sales_rank |
|--------|-------------|------------|
| North  | 3500.00     | 1          |
| East   | 2550.00     | 2          |
| South  | 1550.00     | 3          |

---

### Example 2: Rank products by average sales

```sql
WITH Product_Avg AS (
  SELECT 
          product, 
          AVG(amount) AS avg_sales
  FROM 
          sales
  GROUP BY 
          product
)
SELECT 
       product, 
       avg_sales,
       RANK() OVER (ORDER BY avg_sales DESC) AS avg_rank
FROM 
       Product_Avg;
```

✅ Output

| product | avg_sales | avg_rank |
|---------|-----------|----------|
| Laptop  | 1233.33   | 1        |
| Phone   | 866.67    | 2        |
| Tablet  | 650.00    | 3        |

---

## 📑 Step 4: Using DENSE_RANK()

👉 `DENSE_RANK()` works like `RANK()`, but **without gaps** when there are ties.

### Example: Rank regions by total sales (dense)

```sql
WITH Region_Sales AS (
  SELECT 
         region, 
         SUM(amount) AS total_sales
  FROM 
         sales
  GROUP BY 
         region
)
SELECT 
       region, 
       total_sales,
       DENSE_RANK() OVER (ORDER BY total_sales DESC) AS dense_rank
FROM 
       Region_Sales;
```

✅ Output

| region | total_sales | dense_rank |
|--------|-------------|------------|
| North  | 3500.00     | 1          |
| East   | 2550.00     | 2          |
| South  | 1550.00     | 3          |

*(Here results are the same, but in cases of ties, `RANK()` would skip numbers while `DENSE_RANK()` would not.)*

---

## 📑 Step 5: Using ROW_NUMBER()

👉 `ROW_NUMBER()` gives each row a unique sequential number, even if values tie.

### Example: Numbering products by average sales

```sql
WITH Product_Avg AS (
  SELECT 
         product, 
         AVG(amount) AS avg_sales
  FROM 
         sales
  GROUP BY 
         product
)
SELECT 
       product, 
       avg_sales,
       ROW_NUMBER() OVER (ORDER BY avg_sales DESC) AS rownum
FROM 
       Product_Avg;
```

✅ Output

| product | avg_sales | rownum |
|---------|-----------|--------|
| Laptop  | 1233.33   | 1      |
| Phone   | 866.67    | 2      |
| Tablet  | 650.00    | 3      |

---

## 📑 Key Takeaways

- **Grouping + Aggregation** lets you summarize data by categories.  

- Aggregates include: `SUM`, `AVG`, `MIN`, `MAX`, `COUNT`.  

- **RANK()** → ranking with possible gaps in numbering.  

- **DENSE_RANK()** → ranking with no gaps.  

- **ROW_NUMBER()** → unique sequential number per row.  

- Combine `WITH` (CTEs) + ranking to make queries clearer.

---


# Two-Level of Grouping Using WITH (CTEs)

---

## 📑 Step 1: Schema and Sample Data

```sql
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product VARCHAR(20),
    region VARCHAR(20),
    amount DECIMAL(10,2)
);

INSERT INTO sales VALUES
(1, 'Laptop', 'North', 1200.00),
(2, 'Laptop', 'North', 1500.00),
(3, 'Phone', 'North', 800.00),
(4, 'Phone', 'South', 950.00),
(5, 'Tablet', 'South', 600.00),
(6, 'Tablet', 'East', 700.00),
(7, 'Laptop', 'East', 1000.00),
(8, 'Phone', 'East', 850.00);
```

📊 **sales table**

| sale_id | product | region | amount  |
|---------|---------|--------|---------|
| 1       | Laptop  | North  | 1200.00 |
| 2       | Laptop  | North  | 1500.00 |
| 3       | Phone   | North  | 800.00  |
| 4       | Phone   | South  | 950.00  |
| 5       | Tablet  | South  | 600.00  |
| 6       | Tablet  | East   | 700.00  |
| 7       | Laptop  | East   | 1000.00 |
| 8       | Phone   | East   | 850.00  |

---

## 📑 Step 2: First-Level Grouping (per region + product)

👉 Compute total sales per **region + product**.

```sql
WITH Region_Product_Sales AS (
  SELECT 
          region, 
          product, 
          SUM(amount) AS total_sales
  FROM 
          sales
  GROUP BY 
          region, product
)
SELECT * 
FROM Region_Product_Sales;
```

✅ Output

| region | product | total_sales |
|--------|---------|-------------|
| North  | Laptop  | 2700.00     |
| North  | Phone   | 800.00      |
| South  | Phone   | 950.00      |
| South  | Tablet  | 600.00      |
| East   | Laptop  | 1000.00     |
| East   | Phone   | 850.00      |
| East   | Tablet  | 700.00      |

---

## 📑 Step 3: Second-Level Grouping (per region)

👉 Now group again on **region**, aggregating across products.

```sql
WITH Region_Product_Sales AS (
  SELECT 
         region, 
         product, 
         SUM(amount) AS total_sales
  FROM 
         sales
  GROUP BY 
         region, product
),
Region_Totals AS (
  SELECT 
         region, 
         SUM(total_sales) AS region_total
  FROM 
         Region_Product_Sales
  GROUP BY 
         region
)
SELECT * 
FROM Region_Totals;
```

✅ Output

| region | region_total |
|--------|--------------|
| North  | 3500.00      |
| South  | 1550.00      |
| East   | 2550.00      |

---

## 📑 Key Takeaways

- First CTE (`RegionProductSales`) → groups by **region + product**.  

- Second CTE (`RegionTotals`) → groups by **region** using the first result.  

- This is how you achieve **multi-level grouping** with subqueries.  

---



