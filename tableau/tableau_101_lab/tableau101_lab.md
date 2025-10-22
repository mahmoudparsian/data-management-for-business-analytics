# Tableau 101 Lab – Using MySQL Sales Data

This lab provides a **sample schema**, **records**, and **7 guided exercises** to practice Tableau with MySQL.

---

## Schema

We will use a single table called **sales**.

```sql
CREATE DATABASE tableau_lab;
USE tableau_lab;

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    country VARCHAR(30),
    product VARCHAR(50),
    category VARCHAR(30),
    sale_date DATE,
    quantity INT,
    price DECIMAL(10,2)
);
```

---

## Sample Data (30 records)

```sql
INSERT INTO sales VALUES
(1,'Alice','USA','Laptop','Technology','2024-01-15',1,1200.00),
(2,'Bob','USA','Headphones','Technology','2024-01-18',2,200.00),
(3,'Charlie','Canada','Office Chair','Furniture','2024-02-01',1,150.00),
(4,'Diana','USA','Desk','Furniture','2024-02-05',1,300.00),
(5,'Ethan','Germany','Monitor','Technology','2024-02-10',2,400.00),
(6,'Fiona','Mexico','Notebook','Office Supplies','2024-02-15',5,25.00),
(7,'George','Canada','Printer','Technology','2024-02-20',1,250.00),
(8,'Hannah','USA','Pen Set','Office Supplies','2024-02-25',3,15.00),
(9,'Ivan','Germany','Lamp','Furniture','2024-03-01',2,80.00),
(10,'Julia','Italy','Desk Chair','Furniture','2024-03-05',1,180.00),
(11,'Kevin','USA','Tablet','Technology','2024-03-10',1,500.00),
(12,'Liam','Mexico','Backpack','Office Supplies','2024-03-12',2,60.00),
(13,'Mona','Canada','Bookcase','Furniture','2024-03-18',1,220.00),
(14,'Nina','Germany','Smartphone','Technology','2024-03-20',1,900.00),
(15,'Oscar','USA','Mouse','Technology','2024-03-22',2,50.00),
(16,'Paul','Italy','Keyboard','Technology','2024-03-25',1,70.00),
(17,'Quinn','USA','Desk Lamp','Furniture','2024-04-01',2,90.00),
(18,'Rita','Canada','Binder','Office Supplies','2024-04-05',10,5.00),
(19,'Sam','Germany','Laptop','Technology','2024-04-10',1,1300.00),
(20,'Tina','Mexico','Whiteboard','Office Supplies','2024-04-15',1,120.00),
(21,'Uma','Italy','Sofa','Furniture','2024-04-20',1,700.00),
(22,'Victor','USA','Monitor Stand','Furniture','2024-04-25',1,60.00),
(23,'Wendy','Canada','Eraser','Office Supplies','2024-04-27',5,3.00),
(24,'Xavier','Germany','Router','Technology','2024-05-01',1,150.00),
(25,'Yara','Mexico','File Cabinet','Furniture','2024-05-03',1,350.00),
(26,'Zane','USA','Highlighter Pack','Office Supplies','2024-05-06',4,12.00),
(27,'Aaron','Italy','Couch','Furniture','2024-05-08',1,650.00),
(28,'Bella','USA','Paper Reams','Office Supplies','2024-05-10',10,4.00),
(29,'Carlos','Canada','Smartwatch','Technology','2024-05-12',1,220.00),
(30,'Derek','Germany','Office Desk','Furniture','2024-05-15',1,400.00);
```

---

## Tableau Exercises

### Exercise 1: Sales by Country (Bar Chart)
- Create a calculated field `Revenue = quantity * price`.
- Drag **country** to Rows.
- Drag **Revenue** to Columns.
- Change chart type to **Bar**.
- Show labels and sort by descending revenue.

---

### Exercise 2: Category Share (Pie Chart)
- Create a new sheet.
- Drag **category** to Color.
- Drag **Revenue** to Angle.
- Change mark type to **Pie**.
- Add labels for category and percent of total.

---

### Exercise 3: Monthly Sales Trend (Line Chart)
- Create a new sheet.
- Drag **sale_date** to Columns → set to **MONTH**.
- Drag **Revenue** to Rows.
- Change mark type to **Line**.
- Optionally add **category** to Color for multiple lines.

---

### Exercise 4: Filter for Technology Sales
- Drag **category** to Filters → select **Technology**.
- Show Filter to allow toggling categories.
- Apply to all worksheets using this data source.

---

### Exercise 5: Calculated Field for Revenue
- Right-click Data pane → Create Calculated Field.
- Name: **Revenue**.
- Formula: `[quantity] * [price]`.
- Use this field in visualizations.

---

### Exercise 6: Top 5 Products by Revenue
- Drag **product** to Rows.
- Drag **Revenue** to Columns.
- Right-click product → Filter → Top → Top 5 by SUM(Revenue).
- Sort descending to highlight top products.

---

### Exercise 7: Dashboard with 3 Views
- Create a new Dashboard.
- Drag in the sheets: Sales by Country, Category Share, Monthly Revenue Trend.
- Arrange neatly (bars, pie, line chart).
- Enable **Use as Filter** on one sheet (e.g., Sales by Country).
- Add global category filter for interactivity.

---

This lab provides a full pipeline: connect Tableau to MySQL → load the table → build charts → combine into dashboards.
