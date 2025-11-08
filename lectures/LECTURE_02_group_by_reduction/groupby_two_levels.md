

# Two-Level Grouping in MySQL Using WITH (CTEs)

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
WITH RegionProductSales AS (
  SELECT region, product, SUM(amount) AS total_sales
  FROM sales
  GROUP BY region, product
)
SELECT * FROM RegionProductSales;
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
WITH RegionProductSales AS (
  SELECT region, product, SUM(amount) AS total_sales
  FROM sales
  GROUP BY region, product
),
RegionTotals AS (
  SELECT region, SUM(total_sales) AS region_total
  FROM RegionProductSales
  GROUP BY region
)
SELECT * FROM RegionTotals;
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

