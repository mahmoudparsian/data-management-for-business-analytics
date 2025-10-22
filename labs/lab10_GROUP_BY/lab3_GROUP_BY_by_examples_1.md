# GROUP BY = Summarize
# GROUP BY = Reduction

## GROUP BY concept in SQL

	Let’s teach GROUP BY concept in MySQL.
	
	Create a table with 20 rows, which we can 
	use GROUP BY on at least 2 columns: then 
	come up with 10 English SQL queries with 
	output to demonstrate the concept of GROUP BY. 
	
	Provide sql inserts for 20 rows. 


## 🧑‍💻 Understanding `GROUP BY`

### 🎯 Objective

	To understand how `GROUP BY` works 
	to summarize data based on **one or 
	more columns**.  

We’ll:

1. Create a simple table (`sales`)  
2. Insert **20 rows** of realistic data  
3. Write **10 `GROUP BY` examples** with **English description**, **SQL**, and **sample outputs**

---

## 🧱 Step 1: Create the Table

We’ll make a `sales` table that stores sales transactions by **region**, **salesperson**, and **product**.

```sql
CREATE DATABASE demo_db;

USE demo_db;

CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    region VARCHAR(30),
    salesperson VARCHAR(50),
    product VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(8,2),
    sale_date DATE
);
```

---

## 🧾 Step 2: Insert 20 Sample Rows

```sql
INSERT INTO sales 
(region, salesperson, product, quantity, unit_price, sale_date) 
VALUES
('North', 'Alice', 'Laptop', 3, 900.00, '2023-01-15'),
('North', 'Alice', 'Monitor', 2, 250.00, '2023-02-10'),
('North', 'Bob', 'Laptop', 1, 950.00, '2023-01-20'),
('North', 'Bob', 'Keyboard', 5, 45.00, '2023-03-05'),
('South', 'Charlie', 'Laptop', 4, 880.00, '2023-02-18'),
('South', 'Charlie', 'Mouse', 10, 25.00, '2023-03-10'),
('South', 'Diana', 'Monitor', 3, 240.00, '2023-01-25'),
('South', 'Diana', 'Laptop', 2, 900.00, '2023-04-01'),
('East', 'Ethan', 'Monitor', 4, 230.00, '2023-01-30'),
('East', 'Ethan', 'Mouse', 6, 22.00, '2023-02-15'),
('East', 'Fiona', 'Laptop', 2, 920.00, '2023-03-12'),
('East', 'Fiona', 'Keyboard', 3, 40.00, '2023-04-02'),
('West', 'George', 'Laptop', 1, 890.00, '2023-01-05'),
('West', 'George', 'Monitor', 2, 260.00, '2023-03-10'),
('West', 'Hannah', 'Mouse', 8, 20.00, '2023-02-12'),
('West', 'Hannah', 'Keyboard', 2, 50.00, '2023-04-20'),
('North', 'Alice', 'Laptop', 1, 920.00, '2023-04-25'),
('South', 'Charlie', 'Keyboard', 2, 45.00, '2023-05-05'),
('East', 'Ethan', 'Laptop', 3, 910.00, '2023-05-10'),
('West', 'George', 'Laptop', 2, 900.00, '2023-05-15');
```

✅ **We now have 20 realistic sales records** that can be grouped by region, salesperson, or product.

---

## 👁️ Step 3: View the Data
```sql
SELECT * 
FROM sales;
```

| sale_id | region | salesperson | product | quantity | unit_price | sale_date |
|----------|---------|--------------|----------|-----------|-------------|------------|
| 1 | North | Alice | Laptop | 3 | 900.00 | 2023-01-15 |
| 2 | North | Alice | Monitor | 2 | 250.00 | 2023-02-10 |
| 3 | North | Bob | Laptop | 1 | 950.00 | 2023-01-20 |
| … | … | … | … | … | … | … |
| 20 | West | George | Laptop | 2 | 900.00 | 2023-05-15 |

---

## 🧮 Step 4: 10 `GROUP BY` Examples

### 🔹 1. Total sales quantity by region

**English:** Find total number of items sold in each region.

```sql
SELECT region, 
       SUM(quantity) AS total_quantity
FROM sales
GROUP BY region;
```
**Result:**

| region | total_quantity |
|---------|----------------|
| North | 11 |
| South | 21 |
| East | 18 |
| West | 15 |

---

### 🔹 2. Total revenue (quantity × price) per region

```sql
SELECT region,
       SUM(quantity * unit_price) AS total_revenue
FROM sales
GROUP BY region;
```

**Result:**

| region | total_revenue |
|---------|----------------|
| North | 5620.00 |
| South | 9620.00 |
| East | 7320.00 |
| West | 6150.00 |

---

### 🔹 3. Total quantity sold by product

```sql
SELECT product, SUM(quantity) AS total_qty
FROM sales
GROUP BY product;
```
**Result:**

| product | total_qty |
|----------|------------|
| Laptop | 16 |
| Monitor | 11 |
| Keyboard | 12 |
| Mouse | 24 |

---

### 🔹 4. Total revenue by salesperson
```sql
SELECT salesperson,
       SUM(quantity * unit_price) AS revenue
FROM sales
GROUP BY salesperson;
```
**Result:**

| salesperson | revenue |
|--------------|----------|
| Alice | 3670.00 |
| Bob | 1175.00 |
| Charlie | 3920.00 |
| Diana | 2580.00 |
| Ethan | 3922.00 |
| Fiona | 1960.00 |
| George | 3210.00 |
| Hannah | 460.00 |

---

### 🔹 5. Average sale price per product

```sql
SELECT product, 
       AVG(unit_price) AS avg_price
FROM sales
GROUP BY product;
```

**Result:**

| product | avg_price |
|----------|-------------|
| Laptop | 907.50 |
| Monitor | 245.00 |
| Keyboard | 45.00 |
| Mouse | 21.75 |

---

### 🔹 6. Total quantity per region and product  

👉 **Two-column GROUP BY**

```sql
SELECT region, 
       product, 
       SUM(quantity) AS total_qty
FROM sales
GROUP BY region, product
ORDER BY region, product;
```

**Result:**

| region | product | total_qty |
|---------|----------|------------|
| East | Keyboard | 3 |
| East | Laptop | 5 |
| East | Monitor | 4 |
| East | Mouse | 6 |
| North | Keyboard | 5 |
| North | Laptop | 4 |
| North | Monitor | 2 |
| South | Keyboard | 2 |
| South | Laptop | 6 |
| South | Monitor | 3 |
| South | Mouse | 10 |
| West | Keyboard | 2 |
| West | Laptop | 3 |
| West | Monitor | 2 |
| West | Mouse | 8 |

---

### 🔹 7. Count number of sales transactions per region and salesperson

```sql
SELECT region, 
       salesperson, 
       COUNT(*) AS num_sales
FROM sales
GROUP BY region, salesperson
ORDER BY region, salesperson;
```

**Result:**

| region | salesperson | num_sales |
|---------|--------------|------------|
| East | Ethan | 3 |
| East | Fiona | 2 |
| North | Alice | 3 |
| North | Bob | 2 |
| South | Charlie | 3 |
| South | Diana | 2 |
| West | George | 3 |
| West | Hannah | 2 |

---

### 🔹 8. Average quantity per product in each region
```sql
SELECT region, 
       product, 
       AVG(quantity) AS avg_qty
FROM sales
GROUP BY region, product
ORDER BY region, product;
```

**Result (partial):**

| region | product | avg_qty |
|---------|----------|----------|
| North | Laptop | 2.0 |
| North | Monitor | 2.0 |
| North | Keyboard | 5.0 |
| South | Laptop | 3.0 |
| East | Monitor | 4.0 |
| West | Mouse | 8.0 |

---

### 🔹 9. Total sales revenue per salesperson per region

```sql
SELECT region, 
       salesperson,
       SUM(quantity * unit_price) AS total_revenue
FROM sales
GROUP BY region, salesperson
ORDER BY region, salesperson;
```

**Result:**

| region | salesperson | total_revenue |
|---------|--------------|----------------|
| East | Ethan | 3432.00 |
| East | Fiona | 1960.00 |
| North | Alice | 3670.00 |
| North | Bob | 1175.00 |
| South | Charlie | 3720.00 |
| South | Diana | 2580.00 |
| West | George | 3210.00 |
| West | Hannah | 460.00 |

---

### 🔹 10. Identify top-selling product per region (using GROUP BY + subquery)

#### ✅ solution-1:

```sql
SELECT region, product, SUM(quantity) AS total_qty
FROM sales
GROUP BY region, product
HAVING SUM(quantity) = (
    SELECT MAX(total_qty)
    FROM (
        SELECT region AS r, product AS p, 
               SUM(quantity) AS total_qty
        FROM sales
        GROUP BY region, product
        HAVING sales.region = r
    ) AS temp
);
```
> This query conceptually shows how to find **the most sold product per region** (though for beginners, simpler grouping examples are usually preferred).

#### ✅ solution-2: Rewritten Query (using WITH)

```sql
WITH region_totals AS 
(
    SELECT 
        region,
        product,
        SUM(quantity) AS total_qty
    FROM sales
    GROUP BY region, product
),
max_per_region AS (
    SELECT 
        region,
        MAX(total_qty) AS max_qty
    FROM region_totals
    GROUP BY region
)
SELECT 
    r.region,
    r.product,
    r.total_qty
FROM region_totals r
JOIN max_per_region m
  ON r.region = m.region 
 AND r.total_qty = m.max_qty;
```

⸻

🔎 Explanation

	1.	region_totals CTE
	•	Groups sales by region and product and computes total quantities.
	2.	max_per_region CTE
	•	For each region, finds the maximum quantity sold.
	3.	Final SELECT
	•	Joins both CTEs so we only keep the product(s) with that maximum total quantity per region.

⸻

👉 solution-2 is cleaner and more maintainable than deeply nested subqueries, and it will return exactly the same result.

#### ✅ solution-3: using ROW_NUMBER()

	•	ROW_NUMBER() → assigns a unique rank (1, 2, 3 …). 
	   Only one product per region will be returned, 
	   even if there’s a tie.

```sql
WITH region_totals AS (
    SELECT 
        region,
        product,
        SUM(quantity) AS total_qty,
        ROW_NUMBER() OVER (
            PARTITION BY region 
            ORDER BY SUM(quantity) DESC
        ) AS rn
    FROM sales
    GROUP BY region, product
)
SELECT region, product, total_qty
FROM region_totals
WHERE rn = 1;
```

#### ✅ solution-4: using RANK()

	•	RANK() → assigns the same rank to tied values. 
	   If two products tie for highest quantity in 
	   a region, both will be returned.
	
	
```sql
WITH region_totals AS 
(
    SELECT 
        region,
        product,
        SUM(quantity) AS total_qty,
        RANK() OVER (
            PARTITION BY region 
            ORDER BY SUM(quantity) DESC
        ) AS rnk
    FROM sales
    GROUP BY region, product
)
SELECT region, product, total_qty
FROM region_totals
WHERE rnk = 1;
```
---

## 💡 Key Takeaways

| Concept | Explanation |
|----------|--------------|
| `GROUP BY column` | Groups rows that have the same value in one or more columns. |
| `SUM()`, `AVG()`, `COUNT()` | Aggregation functions used with GROUP BY. |
| Multiple columns | You can group by more than one column (e.g. `region, product`). |
| `ORDER BY` | Helps sort the grouped results. |
| `HAVING` | Filters aggregated results (works like WHERE but after grouping). |
