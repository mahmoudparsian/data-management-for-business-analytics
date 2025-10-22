# GROUP BY tutorial


	Let’s teach GROUP BY concept in MySql to novice: 
	
	create a table with 20 rows, which we can use group 
	by on at least 2 columns: then come up with 10 English 
	SQL queries with output to demonstrate the concept of 
	group by. 
	
	Provide sql inserts for 20 rows. 
	Everything in markdown format.

# What is GROUP BY in SQL

### Syntax:

	SELECT 
	       country, 
	       count(*) AS emps_per_country
	FRPM 
	       employees
	GROUP BY
	       country;

### Description:


	The GROUP BY clause in SQL is used to group rows 
	that have the same values in one or more specified 
	columns into a summary row for each group. 
	This is typically used in conjunction with aggregate 
	functions (like COUNT(), SUM(), AVG(), MAX(), MIN()) 
	to perform calculations on each group of rows, rather 
	than on the entire dataset. 
	
### GROUP BY In Action: set of (key, value)

	(K1, a)
	(K1, b)
	(K1, c)
	(K2, d)
	(K2, e)

GROUP BY will result in:

	(K1, [a, b, c])
	(K2, [d, e])

# 🧑‍💻 MySQL 101 — Understanding `GROUP BY`

### 🎯 Objective
To understand how `GROUP BY` works to summarize data based on **one or more columns**.  

We’ll:

1. Create a simple table (`sales`)  
2. Insert **20 rows** of realistic data  
3. Write **10 `GROUP BY` examples** with **English description**, **SQL**, and **sample outputs**

---

## 🧱 Step 1: Create the Table

We’ll make a `sales` table that stores sales transactions by **region**, **sales_person**, and **product**.

```sql
CREATE DATABASE demo_db;
USE demo_db;

CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    region VARCHAR(30),
    sales_person VARCHAR(50),
    product VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(8,2),
    sale_date DATE
);
```

---

## 🧾 Step 2: Insert 20 Sample Rows

```sql
INSERT INTO sales (region, sales_person, product, quantity, unit_price, sale_date)
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

✅ **We now have 20 realistic sales records** that can be grouped by region, sales_person, or product.

---

## 👁️ Step 3: View the Data
```sql
SELECT * 
FROM sales;
```

| sale_id | region | sales_person | product | quantity | unit_price | sale_date |
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

**SQL:**

```sql
SELECT region, SUM(quantity) AS total_quantity
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

**SQL:**

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

**SQL:**

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

### 🔹 4. Total revenue by sales_person

**SQL:**

```sql
SELECT sales_person,
       SUM(quantity * unit_price) AS revenue
FROM sales
GROUP BY sales_person;
```
**Result:**

| sales_person | revenue |
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

**SQL:**

```sql
SELECT product, AVG(unit_price) AS avg_price
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

**SQL:**

```sql
SELECT region, product, SUM(quantity) AS total_qty
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

### 🔹 7. Count number of sales transactions per region and sales_person

**SQL**

```sql
SELECT region, sales_person, COUNT(*) AS num_sales
FROM sales
GROUP BY region, sales_person
ORDER BY region, sales_person;
```
**Result:**

| region | sales_person | num_sales |
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

**SQL**

```sql
SELECT region, product, AVG(quantity) AS avg_qty
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

### 🔹 9. Total sales revenue per sales_person per region

**SQL**

```sql
SELECT region, sales_person,
       SUM(quantity * unit_price) AS total_revenue
FROM sales
GROUP BY region, sales_person
ORDER BY region, sales_person;
```

**Result:**

| region | sales_person | total_revenue |
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

**SQL**

solution-1:

```sql
WITH region_product_totals AS (
    SELECT region, product, SUM(quantity) AS total_qty
    FROM sales
    GROUP BY region, product
),
region_max AS (
    SELECT region, MAX(total_qty) AS max_qty
    FROM region_product_totals
    GROUP BY region
)
SELECT rpt.region, rpt.product, rpt.total_qty
FROM region_product_totals rpt
JOIN region_max rm
  ON rpt.region = rm.region
 AND rpt.total_qty = rm.max_qty;
```

solution-2:

```sql
WITH ranked AS
(    
  SELECT region,
         product,
         SUM(quantity) AS total_qty,
         RANK() OVER (PARTITION BY region ORDER BY SUM(quantity) DESC) AS rnk
  FROM sales
  GROUP BY region, product
)
SELECT region, product, total_qty
FROM  ranked
WHERE rnk = 1;
```
 
> This query conceptually shows how to find **the most sold product per region** (though for beginners, simpler grouping examples are usually preferred).

---

## 💡 Key Takeaways

| Concept | Explanation |
|----------|--------------|
| `GROUP BY column` | Groups rows that have the same value in one or more columns. |
| `SUM()`, `AVG()`, `COUNT()` | Aggregation functions used with GROUP BY. |
| Multiple columns | You can group by more than one column (e.g. `region, product`). |
| `ORDER BY` | Helps sort the grouped results. |
| `HAVING` | Filters aggregated results (works like WHERE but after grouping). |

---
