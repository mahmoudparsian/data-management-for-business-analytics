# Teaching SQL: <br> WHERE vs HAVING 

This short lesson uses a very simple MySQL schema 
to demonstrate the **difference between WHERE and HAVING** 
using clear examples.

---

# ✅ 1. Simple Schema

```sql
CREATE TABLE sales (
    id INT PRIMARY KEY,
    product VARCHAR(30),
    country VARCHAR(20),
    quantity INT,
    price DECIMAL(10,2)
);
```

### Sample Data
```sql
INSERT INTO sales VALUES
(1, 'Notebook', 'USA',     5, 3.50),
(2, 'Notebook', 'USA',     3, 3.50),
(3, 'Notebook', 'Canada',  8, 3.50),
(4, 'Pencil',   'Canada', 10, 1.00),
(5, 'Pencil',   'USA',     2, 1.00),
(6, 'Laptop',   'USA',     1, 900.00),
(7, 'Laptop',   'Germany', 1, 850.00);
```

---

# ✅ 2. Key Concepts

### **WHERE**
- Filters rows **before** grouping  
- Works on **individual rows**  
- Cannot use aggregate functions (SUM, AVG, COUNT, …)

### **HAVING**
- Filters groups **after** `GROUP BY`  
- Works on **aggregated results**  
- Can use aggregate functions

---

# ✅ 3. Example Queries (Clear Contrast)

---

## ✅ Example 1 — Filter Individual Rows (WHERE)

### Goal: Show all sales from the USA.

```sql
SELECT *
FROM sales
WHERE country = 'USA';
```

✔ WHERE works because it filters raw rows.

---

## ✅ Example 2 — Filter Aggregated Values (HAVING)

### Goal: Show products whose **total quantity** sold is **greater than 10**.

```sql
SELECT product, SUM(quantity) AS total_qty
FROM sales
GROUP BY product
HAVING total_qty > 10;
```

✔ HAVING filters results *after* grouping.  
❌ WHERE cannot be used here.

---

## ✅ Example 3 — Using WHERE and HAVING Together

### Goal: Find products sold **in the USA** whose **total quantity** exceeds **5**.

```sql
SELECT product, SUM(quantity) AS total_qty
FROM sales
WHERE country = 'USA'      -- row filtering
GROUP BY product
HAVING total_qty > 5;      -- group filtering
```

✔ WHERE narrows down rows first.  
✔ HAVING applies conditions on aggregated output.

---

# ✅ Summary Table

| Feature | Filters When | Works On | Aggregates Allowed? |
|--------|--------------|----------|----------------------|
| **WHERE** | Before GROUP BY | Rows | ❌ No |
| **HAVING** | After GROUP BY | Groups | ✅ Yes |

---

# ✅ End of Lesson
