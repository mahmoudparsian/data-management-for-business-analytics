# SQL's WHERE vs HAVING <br> Teaching Slide Deck (Markdown)

## Slide 1 — Title

**SQL Filtering: WHERE vs HAVING**  

Why, when, and how to use each filter correctly.

---

## Slide 2 — Learning Goals

- Understand **row filtering** vs **group filtering**
- Use `WHERE` to filter **before** aggregation
- Use `HAVING` to filter **after** aggregation
- Combine both correctly in the same query

---

## Slide 3 —  Schema

```sql
CREATE TABLE sales (
  id INT PRIMARY KEY,
  product VARCHAR(30),
  country VARCHAR(20),
  quantity INT,
  price DECIMAL(10,2),
  sale_date DATE
);
```


**Sample rows (conceptual):** 

```sql
INSERT INTO sales 
(id, product, country, quantity, price, sale_date) 
VALUES
(1,  'Notebook', 'USA',      3,  6.00,  '2024-01-05'),
(2,  'Notebook', 'Canada',   2,  6.00,  '2024-01-10'),
(3,  'Notebook', 'Germany',  5,  7.00,  '2024-02-12'),
(4,  'Pencil',   'USA',      10, 1.00,  '2024-02-20'),
(5,  'Pencil',   'Canada',   15, 1.00,  '2024-02-25'),
(6,  'Pencil',   'Germany',   8, 1.00,  '2024-03-01'),
(7,  'Laptop',   'USA',       1, 899.00, '2024-03-15'),
(8,  'Laptop',   'Canada',     1, 899.00, '2024-03-18'),
(9,  'Laptop',   'Germany',    2, 899.00, '2024-04-01'),
(10, 'Mouse',    'USA',       4, 20.00, '2024-01-08'),
(11, 'Mouse',    'Canada',    3, 21.00, '2024-01-12'),
(12, 'Mouse',    'Germany',   6, 23.00, '2024-02-03'),
(13,  'Notebook', 'USA',      4,  8.00,  '2025-01-05'),
(14,  'Notebook', 'Canada',   5,  7.00,  '2025-01-10'),
(15,  'Notebook', 'Germany',  7,  9.00,  '2025-02-12'),
(16,  'Pencil',   'USA',      12, 1.00,  '2025-02-20');
```
---

## Slide 4 — Concept: WHERE

- Filters **rows** (the raw data)
- Happens **before** `GROUP BY`
- **Cannot** reference aggregates (e.g., `SUM()`, `AVG()`)

**Example:**  

```sql
SELECT * 
FROM sales 
WHERE country = 'USA';
```

---

## Slide 5 — Concept: HAVING

- Filters **groups** (after aggregation)
- Happens **after** `GROUP BY`
- **Can** reference aggregates

**Example:**  

```sql
SELECT product, 
       SUM(quantity) AS total_qty
FROM sales
GROUP BY product
HAVING total_qty > 10;
```

---

## Slide 6 — Example A (WHERE only)

Goal: show all rows for Germany.

```sql
SELECT *
FROM sales
WHERE country = 'Germany';
```

---

## Slide 7 — Example B (HAVING only)

Goal: products with **total revenue** > 200.

```sql
SELECT product, 
       SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY product
HAVING total_revenue > 200;
```

---

## Slide 8 — Example C (WHERE + HAVING)

Goal: For **USA** only, show products with **total quantity** > 5.

```sql
SELECT product, 
       SUM(quantity) AS total_qty
FROM sales
WHERE country = 'USA'           -- row filter first
GROUP BY product
HAVING total_qty > 5;           -- group filter next
```

---

## Slide 9 — Why not use WHERE with aggregates?

Because the aggregate isn’t computed 
yet at the row-filtering phase.

**Incorrect:** 
 
```sql
-- ❌ This fails in MySQL
SELECT product
FROM sales
WHERE SUM(quantity) > 10
GROUP BY product;
```

---

## Slide 10 — Typical Mistake & Fix

- **Mistake:** Using `WHERE` to filter aggregated value.  
- **Fix:** Move the aggregated condition to `HAVING`.

```sql
-- ✅ Correct
SELECT product, 
       SUM(quantity) AS total_qty
FROM sales
GROUP BY product
HAVING total_qty > 10;
```

---

## Slide 11 — Another Combo Example

Goal: 2024 sales only; show products with avg price > 20.

```sql
SELECT product, 
       AVG(price) AS avg_price
FROM sales
WHERE YEAR(sale_date) = 2024     -- pre-filter rows by year
GROUP BY product
HAVING avg_price > 20;           -- post-filter by aggregate
```

---

## Slide 12 — Performance Tip

- Use `WHERE` to **reduce data early** (fewer rows to group)
- Use `HAVING` **only** for conditions on aggregate results
- Prefer pushing as much logic as possible into `WHERE`

---

## Slide 13 — Quick Mental Model

- `WHERE`: filter for **rows**
- `GROUP BY`: makes **buckets**
- Aggregates: compute **per bucket** (SUM/AVG/COUNT/MIN/MAX)
- `HAVING`: filter for **buckets**

---

## Slide 14 — Summary

- `WHERE` = raw rows, pre-aggregation, no aggregates
- `HAVING` = grouped results, post-aggregation, aggregates welcome
- Use both when you need **row pre-filtering** and **group post-filtering**
