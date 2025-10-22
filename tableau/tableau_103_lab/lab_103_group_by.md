# Tableau 101 Lab (GROUP BY Focus) – Single MySQL Table + 7 Guided Actions

This lab gives you a **single MySQL table (30 rows)** and **7 Tableau actions** that all rely on GROUP BY–style analysis (i.e., dimensions + aggregated measures). Each action includes **very detailed step-by-step instructions**.

---

## 1) MySQL Schema (single table)

```sql
CREATE DATABASE IF NOT EXISTS tableau_lab_groupby;
USE tableau_lab_groupby;

CREATE TABLE orders (
  order_id     INT PRIMARY KEY,
  customer     VARCHAR(50),
  country      VARCHAR(30),
  product      VARCHAR(60),
  category     VARCHAR(30),
  order_date   DATE,
  quantity     INT,
  price        DECIMAL(10,2)  -- unit price
);
```
> **Note:** In Tableau we’ll create a calculated field `Revenue = quantity * price` and then aggregate it (SUM) by various dimensions.

---

## 2) Sample Data (30 INSERTs)

```sql
INSERT INTO orders VALUES
(1,'Alice','USA','Laptop 14"','Technology','2024-01-05',1,1100.00),
(2,'Bob','USA','Noise-Cancel Headphones','Technology','2024-01-10',2,180.00),
(3,'Charlie','Canada','Office Chair','Furniture','2024-01-15',1,160.00),
(4,'Diana','Germany','Desk (120 cm)','Furniture','2024-01-20',1,290.00),
(5,'Ethan','Mexico','4K Monitor 27"','Technology','2024-01-25',1,320.00),
(6,'Fiona','USA','Notebook Pack','Office Supplies','2024-02-01',5,6.00),
(7,'George','Canada','Laser Printer','Technology','2024-02-04',1,240.00),
(8,'Hannah','USA','Pen Set (10)','Office Supplies','2024-02-06',3,12.00),
(9,'Ivan','Germany','LED Desk Lamp','Furniture','2024-02-10',2,35.00),
(10,'Julia','Italy','Ergonomic Chair','Furniture','2024-02-14',1,210.00),
(11,'Kevin','USA','Tablet 10"','Technology','2024-02-20',1,450.00),
(12,'Liam','Mexico','Backpack','Office Supplies','2024-02-22',2,28.00),
(13,'Mona','Canada','Bookcase 5-shelf','Furniture','2024-03-02',1,200.00),
(14,'Nina','Germany','Smartphone 128GB','Technology','2024-03-05',1,820.00),
(15,'Oscar','USA','Wireless Mouse','Technology','2024-03-07',2,32.00),
(16,'Paul','Italy','Mechanical Keyboard','Technology','2024-03-09',1,95.00),
(17,'Quinn','USA','Desk Lamp','Furniture','2024-03-12',2,40.00),
(18,'Rita','Canada','Ring Binder (pack)','Office Supplies','2024-03-15',10,3.50),
(19,'Sam','Germany','Ultrabook 13"','Technology','2024-03-17',1,1250.00),
(20,'Tina','Mexico','Whiteboard 60x90','Office Supplies','2024-03-20',1,85.00),
(21,'Uma','Italy','2-seat Sofa','Furniture','2024-03-25',1,680.00),
(22,'Victor','USA','Monitor Stand','Furniture','2024-03-28',1,52.00),
(23,'Wendy','Canada','Eraser (pack)','Office Supplies','2024-04-01',5,1.50),
(24,'Xavier','Germany','WiFi Router AX','Technology','2024-04-04',1,140.00),
(25,'Yara','Mexico','Filing Cabinet','Furniture','2024-04-08',1,330.00),
(26,'Zane','USA','Highlighter Pack','Office Supplies','2024-04-10',4,2.50),
(27,'Aaron','Italy','Lounge Couch','Furniture','2024-04-12',1,640.00),
(28,'Bella','USA','Printer Paper (10x500)','Office Supplies','2024-04-15',10,4.20),
(29,'Carlos','Canada','Smartwatch','Technology','2024-04-18',1,210.00),
(30,'Derek','Germany','Office Desk L-shape','Furniture','2024-04-20',1,420.00);
```

---

## 3) Connect Tableau to MySQL (one time)
1. Open Tableau Desktop or Tableau Public.  
2. **Connect** → **To a Server** → **MySQL**.  
3. Enter host, port (3306), username, password → **Sign In**.  
4. Choose database **`tableau_lab_groupby`** → drag **`orders`** to the canvas.  
5. Click **Sheet 1** to start analysis.

### Create a reusable calculated field
6. In the **Data** pane → right‑click → **Create** → **Calculated Field…**  
7. Name it **Revenue** and enter:  
   ```
   [quantity] * [price]
   ```  
8. Click **OK**. You’ll use **SUM(Revenue)** in the actions below.

---

# 7 Actions (GROUP BY–style analyses)

> In Tableau, *GROUP BY* is achieved by placing **dimensions** on Rows/Columns (or in the view) and aggregating **measures** (SUM, AVG, COUNT, etc.).

## Action 1 — Revenue by Country (bar chart)
**Goal:** Total revenue per `country` (GROUP BY country).  
**Steps:**
1. Rename sheet to **Revenue by Country**.  
2. Drag **country** to **Rows**.  
3. Drag **Revenue** to **Columns** (aggregation should default to **SUM**).  
4. On **Marks**, ensure **Bar** is selected.  
5. Click **Sort** (descending) to order highest to lowest revenue.  
6. Drag **Revenue** to **Label** → **Show mark labels** to display values.  
7. Optional: Format currency → right‑click axis → **Format** → **Numbers: Currency (Custom)**.

**What you did:** `SELECT country, SUM(quantity*price) FROM orders GROUP BY country;`

---

## Action 2 — Units by Category (horizontal bars)
**Goal:** Total units (`quantity`) per `category` (GROUP BY category).  
**Steps:**
1. New sheet → name **Units by Category**.  
2. Drag **category** to **Rows**.  
3. Drag **quantity** to **Columns** (SUM).  
4. Show labels; sort descending.  
5. Optional: Drag **category** to **Color** for visual grouping.

**What you did:** `SELECT category, SUM(quantity) FROM orders GROUP BY category;`

---

## Action 3 — Monthly Revenue Trend (line)
**Goal:** Revenue per month (GROUP BY month).  
**Steps:**
1. New sheet → **Monthly Revenue**.  
2. Drag **order_date** to **Columns** → click the pill dropdown → choose **MONTH(order_date)**.  
3. Drag **Revenue** to **Rows** (SUM).  
4. Marks type should be **Line**.  
5. Optional: Add **category** to **Color** to split into multiple monthly lines.  
6. Optional: Hover a point to see the tooltips with month and revenue.

**What you did:** `SELECT DATE_FORMAT(order_date,'%Y-%m') AS month, SUM(quantity*price) FROM orders GROUP BY month;`

---

## Action 4 — Revenue by Country and Category (stacked bars)
**Goal:** Revenue broken down by both `country` and `category` (GROUP BY country, category).  
**Steps:**
1. New sheet → **Country × Category (Revenue)**.  
2. Drag **country** to **Rows**.  
3. Drag **Revenue** to **Columns**.  
4. Drag **category** to **Color** on the **Marks** card to stack by category.  
5. Sort countries by total revenue (toolbar **Sort**).  
6. Optional: Drag **category** to **Label** to show category labels inside bars.

**What you did:** `SELECT country, category, SUM(quantity*price) FROM orders GROUP BY country, category;`

---

## Action 5 — Top 5 Products by Revenue (bars + filter)
**Goal:** Overall top 5 `product` by revenue (GROUP BY product + Top N filter).  
**Steps:**
1. New sheet → **Top 5 Products (Revenue)**.  
2. Drag **product** to **Rows**.  
3. Drag **Revenue** to **Columns** (SUM).  
4. Right‑click **product** on Rows → **Filter…** → **Top** tab.  
5. Choose **By Field** → **Top** **5** by **SUM** of **Revenue** → **OK**.  
6. Sort descending, show labels.  
7. Optional: Add **country** to **Color** to see which country contributes most per product.

**What you did:** `SELECT product, SUM(quantity*price) FROM orders GROUP BY product ORDER BY SUM(...) DESC LIMIT 5;`

---

## Action 6 — Distinct Customers by Country (table or bars)
**Goal:** Count **distinct** customers per `country` (GROUP BY country with COUNTD).  
**Steps:**
1. New sheet → **Distinct Customers by Country**.  
2. Drag **country** to **Rows**.  
3. Drag **customer** to **Text** on the **Marks** card, then click the **customer** pill → **Measure** → **Count Distinct**.  
   - (Tableau shows **CNTD(customer)**.)  
4. Optional: Switch to **Bar** and move **CNTD(customer)** to **Columns** for a chart.  
5. Sort and label as needed.

**What you did:** `SELECT country, COUNT(DISTINCT customer) FROM orders GROUP BY country;`

---

## Action 7 — Average Order Value by Customer (table + sort)
**Goal:** Average order value per `customer` (GROUP BY customer).  
**Steps:**
1. New sheet → **Avg Order Value by Customer**.  
2. Drag **customer** to **Rows**.  
3. Drag **Revenue** to **Text** on **Marks**.  
4. Click the **SUM(Revenue)** pill → **Measure** → **Average** → it becomes **AVG(Revenue)**.  
5. Optional: Convert to bar chart → drag **AVG(Revenue)** to **Columns**.  
6. Format as currency and sort descending to see top customers by average order value.

**What you did:** `SELECT customer, AVG(quantity*price) FROM orders GROUP BY customer;`

---

## Troubleshooting & Tips
- **No labels?** Place the measure on **Label** and enable **Show mark labels**.  
- **Wrong aggregation?** Click the measure pill → set to **SUM/AVG/COUNT/CNTD** as needed.  
- **Dates wrong?** Change the date pill’s granularity (Year/Quarter/Month) and role (Discrete vs Continuous).  
- **Global filters?** On a filter card → **Apply to Worksheets** → **All Using This Data Source** to synchronize.

Happy visualizing! 🎉
