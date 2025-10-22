# Tableau 102 Lab (Super-Simple, GROUP BY Focus) – **Students** Table

* This lab uses **one MySQL table** with **30 rows** 
* Gives you **7 very simple Tableau actions**.  
* Each action is written in **clear, step-by-step** instructions and mirrors basic SQL `GROUP BY` ideas.

---

## 1) MySQL Schema

```sql
CREATE DATABASE IF NOT EXISTS students_db;
USE students_db;

CREATE TABLE students (
  student_id   INT PRIMARY KEY,
  name         VARCHAR(60) NOT NULL,
  age          INT,
  country      VARCHAR(40),
  major        VARCHAR(60),
  tuition_paid DECIMAL(10,2)
);
```

---

## 2) Sample Data (30 INSERTs)

```sql
INSERT INTO students VALUES
(1,'Alice Johnson',19,'USA','Computer Science',12000.00),
(2,'Bao Nguyen',21,'Vietnam','Business',9000.00),
(3,'Carlos Mendez',22,'Mexico','Mathematics',8000.00),
(4,'Daria Petrov',20,'Russia','Physics',10000.00),
(5,'Ethan Brown',23,'USA','Business',11000.00),
(6,'Fatima Khan',18,'Pakistan','Computer Science',9500.00),
(7,'Giulia Rossi',20,'Italy','Design',7000.00),
(8,'Hiro Tanaka',24,'Japan','Computer Science',13000.00),
(9,'Isabella Silva',21,'Brazil','Biology',7500.00),
(10,'Jamal Carter',22,'USA','Mathematics',8500.00),
(11,'Khalid Omar',25,'Egypt','Business',9200.00),
(12,'Lina Chen',19,'China','Design',6800.00),
(13,'Marta Lopez',23,'Spain','Biology',7700.00),
(14,'Noah Schmidt',20,'Germany','Physics',10500.00),
(15,'Olivia Martin',21,'France','Business',9800.00),
(16,'Pedro Alvarez',24,'Mexico','Computer Science',12500.00),
(17,'Qi Wei',22,'China','Mathematics',8200.00),
(18,'Riya Patel',19,'India','Biology',7300.00),
(19,'Sara Ahmed',20,'Egypt','Computer Science',11800.00),
(20,'Tom Williams',23,'UK','Design',7200.00),
(21,'Uma Rao',21,'India','Business',9100.00),
(22,'Viktor Kozlov',26,'Russia','Mathematics',8600.00),
(23,'Wang Lei',20,'China','Business',9400.00),
(24,'Ximena Reyes',22,'Mexico','Design',7000.00),
(25,'Yuki Sato',23,'Japan','Physics',11200.00),
(26,'Zara Ali',18,'Pakistan','Biology',6900.00),
(27,'Ben Clark',24,'UK','Computer Science',12750.00),
(28,'Chloe Dupont',22,'France','Design',7100.00),
(29,'Diego Costa',21,'Brazil','Business',9300.00),
(30,'Emma Davis',20,'USA','Biology',7600.00);
```

> You can copy/paste the schema + inserts into MySQL Workbench (or the MySQL CLI), then refresh Tableau’s data connection.

---

## 3) Connect Tableau to MySQL (one time)

1) Open **Tableau Desktop** or **Tableau Public**.  
2) **Connect** → **To a Server** → **MySQL**.  
3) Enter your MySQL host, port (default **3306**), username, and password → **Sign In**.  
4) Select database **`students_db`** → drag the **`students`** table onto the canvas.  
5) Click **Sheet 1** to start analyzing.

> Tip: Tableau automatically treats text fields (like `country`, `major`) as **Dimensions**, and numeric fields (like `age`, `tuition_paid`) as **Measures**.

---

# 7 Very Simple Tableau Actions (GROUP BY-style)

## Action 1 — Count of Students by Country (Bar Chart)
**Goal:** How many students come from each country?

Steps:  
1) Rename the sheet to **“Count by Country”**.  
2) Drag **country** to **Rows**.  
3) Drag **student_id** to **Columns**.  
4) Click the **student_id** pill → **Measure** → choose **Count** (or **CNT**).  
5) Ensure the **Marks** type is **Bar**.  
6) Click the **Sort** (descending) icon on the toolbar.  
7) (Optional) Drag **CNT(student_id)** to **Label** → **Show mark labels**.

**SQL idea:** `SELECT country, COUNT(*) FROM students GROUP BY country;`

---

## Action 2 — Count of Students by Major (Horizontal Bars)
**Goal:** Which majors are most popular?

Steps:  
1) New sheet → name **“Count by Major”**.  
2) Drag **major** to **Rows**.  
3) Drag **student_id** to **Columns** → set to **Count**.  
4) Sort descending and show labels (as in Action 1).  
5) (Optional) Drag **major** to **Color** to visually distinguish majors.

**SQL idea:** `SELECT major, COUNT(*) FROM students GROUP BY major;`

---

## Action 3 — Average Tuition by Major (Bar Chart)
**Goal:** What is the average tuition paid for each major?

Steps:  
1) New sheet → name **“Avg Tuition by Major”**.  
2) Drag **major** to **Rows**.  
3) Drag **tuition_paid** to **Columns**.  
4) Click the **tuition_paid** pill → **Measure** → **Average**.  
5) Sort descending, show labels; format to currency:  
   - Right‑click the axis → **Format** → **Numbers** → **Currency**.

**SQL idea:** `SELECT major, AVG(tuition_paid) FROM students GROUP BY major;`

---

## Action 4 — Average Age by Country (Bar Chart)
**Goal:** What is the average age per country?

Steps:  
1) New sheet → name **“Avg Age by Country”**.  
2) Drag **country** to **Rows**.  
3) Drag **age** to **Columns**.  
4) Click **age** pill → **Measure** → **Average**.  
5) Sort and label as desired.

**SQL idea:** `SELECT country, AVG(age) FROM students GROUP BY country;`

---

## Action 5 — Total Tuition by Country (Bar Chart)
**Goal:** How much tuition (sum) has been paid per country?

Steps:  
1) New sheet → name **“Total Tuition by Country”**.  
2) Drag **country** to **Rows**.  
3) Drag **tuition_paid** to **Columns**.  
4) Ensure **SUM(tuition_paid)** is used (default).  
5) Sort descending; show labels; format currency if needed.

**SQL idea:** `SELECT country, SUM(tuition_paid) FROM students GROUP BY country;`

---

## Action 6 — Total Tuition by Country and Major (Stacked Bars)
**Goal:** For each country, how is tuition split across majors? (two dimensions)

Steps:  
1) New sheet → name **“Tuition by Country × Major”**.  
2) Drag **country** to **Rows**.  
3) Drag **tuition_paid** to **Columns** (SUM).  
4) Drag **major** to the **Color** shelf on the **Marks** card (creates stacked bars).  
5) Sort countries by **SUM(tuition_paid)**.  
6) (Optional) Drag **major** to **Label** → **Show mark labels**.

**SQL idea:** `SELECT country, major, SUM(tuition_paid) FROM students GROUP BY country, major;`

---

## Action 7 — Simple Table: Major, Count, Average Tuition (Text Table)
**Goal:** Put a small summary table in one place (no charts).

Steps:  
1) New sheet → name **“Major Summary Table”**.  
2) Drag **major** to **Rows**.  
3) Drag **student_id** to **Text** on the **Marks** card → set to **Count**.  
4) Drag **tuition_paid** to **Text** as well → click the **tuition_paid** pill on **Marks** → **Measure** → **Average**.  
   - You’ll see something like: `CNT(student_id), AVG(tuition_paid)` in each row.  
5) Click **Label** → **Allow labels to overlap** (optional) to keep both numbers visible.  
6) Format **AVG(tuition_paid)** as currency: right‑click its pill → **Format** → **Numbers: Currency**.

**SQL idea:**  
```
SELECT major,
       COUNT(*)          AS student_count,
       AVG(tuition_paid) AS avg_tuition
FROM students
GROUP BY major;
```

---

## 4) Troubleshooting Tips (Keep It Simple)

- **No numbers on the chart?** Drag your measure to **Label** and enable **Show mark labels**.  
- **Wrong aggregation?** Click the measure pill → choose **SUM**, **AVG**, **COUNT**, or **CNTD**.  
- **Sort not working?** Click the **Sort** icon on the toolbar, or sort from a field’s dropdown.  
- **Currency format:** Right‑click an axis or a measure pill → **Format** → Numbers → **Currency**.

You now have a clean, simple set of views that map directly to `GROUP BY` queries—perfect for beginners. 🎉
