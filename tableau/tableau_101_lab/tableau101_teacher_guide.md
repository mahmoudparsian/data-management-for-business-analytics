# Teacher’s Demo Guide – Tableau 101 Lab

This guide provides **expected results** and **demo notes** for each of the 7 Tableau lab exercises.

---

## Exercise 1: Sales by Country (Bar Chart)
**Steps Recap:**
- Created `Revenue = quantity * price`
- Built a bar chart with **country** on Rows and **Revenue** on Columns.

**Expected Result:**
- A horizontal bar chart with 5 countries (USA, Canada, Germany, Italy, Mexico).
- USA should have the tallest bar (most sales), smaller bars for others.
- Label values shown as revenue totals.

**Teaching Notes:**
- Emphasize the power of aggregation: Tableau automatically sums revenue.
- Show how sorting makes comparisons easier.

---

## Exercise 2: Category Share (Pie Chart)
**Steps Recap:**
- Category on Color, Revenue on Angle, Pie chart type.

**Expected Result:**
- Pie chart with 3 slices: Technology, Furniture, Office Supplies.
- Technology slice likely largest due to laptops, monitors, etc.
- Labels show % of total revenue.

**Teaching Notes:**
- Warn about pie charts: best for limited categories (2–5 max).
- Demonstrate switching to bar chart for clarity.

---

## Exercise 3: Monthly Sales Trend (Line Chart)
**Steps Recap:**
- Month(sale_date) on Columns, Revenue on Rows, Line chart.

**Expected Result:**
- A line showing revenue across months (Jan–May 2024).
- Peaks in Feb–Mar (due to laptops, smartphones), dips in April, rise in May.

**Teaching Notes:**
- Show difference between discrete vs continuous dates (blue vs green pills).
- Stress importance of time-series analysis.

---

## Exercise 4: Filter for Technology Sales
**Steps Recap:**
- Added **category** filter = Technology.

**Expected Result:**
- All sheets show only Technology-related products (Laptop, Smartphone, Monitor, etc.).
- Interactivity: user can toggle between Technology, Furniture, Supplies.

**Teaching Notes:**
- Show global filter application (apply to all worksheets).
- Stress interactivity for dashboard end users.

---

## Exercise 5: Calculated Field for Revenue
**Steps Recap:**
- Created `[Revenue] = [quantity] * [price]`.

**Expected Result:**
- Field appears under Measures in Data pane.
- Reused consistently in Sheets 1–3.

**Teaching Notes:**
- Stress calculated fields as reusable components.
- Show editing calculations and testing formulas.

---

## Exercise 6: Top 5 Products by Revenue
**Steps Recap:**
- Product on Rows, Revenue on Columns, filter to Top 5.

**Expected Result:**
- Bars for 5 products with highest revenue (likely Laptops, Smartphone, Sofa, Couch, Desk).
- Sorted descending.

**Teaching Notes:**
- Show both Filter → Top tab and Set-based method.
- Useful for competitive analysis (top N performers).

---

## Exercise 7: Dashboard with 3 Views
**Steps Recap:**
- Assembled Sales by Country, Category Share, Monthly Trend in dashboard.

**Expected Result:**
- Dashboard with 3 charts arranged cleanly.
- Clicking a country bar filters other charts (if “Use as Filter” enabled).
- Category filter shown on side to switch between categories.

**Teaching Notes:**
- Demonstrate interactivity by clicking bars/pie slices.
- Stress dashboard storytelling: combining multiple views.

---

# General Notes for Teachers
- Encourage students to experiment: drag other fields, change chart types.
- Use “Show Me” panel to suggest alternatives.
- Remind that Tableau auto-aggregates measures and classifies dimensions.
- Reinforce the workflow: Connect → Explore → Visualize → Dashboard → Share.
