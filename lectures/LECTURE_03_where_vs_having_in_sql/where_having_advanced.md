# Advanced WHERE vs HAVING — Tricky Cases & Patterns

## 1) Filtering Nulls

**Goal:** Count rows per product but ignore null prices *before* grouping.

```sql
SELECT product, COUNT(*) AS cnt
FROM sales
WHERE price IS NOT NULL               -- row filter
GROUP BY product;
```

**Goal:** Keep only products with **at least one** null price (post-group).

```sql
SELECT product, SUM(price IS NULL) AS null_prices
FROM sales
GROUP BY product
HAVING SUM(price IS NULL) >= 1;       -- group filter
```

---

## 2) Counting Distinct with HAVING

**Goal:** Products sold in **2 or more countries**.

```sql
SELECT product, COUNT(DISTINCT country) AS country_count
FROM sales
GROUP BY product
HAVING country_count >= 2;
```

---

## 3) Combining Date Filters + Aggregates

**Goal:** For 2024 only, show products with total revenue > 300.

```sql
SELECT product, SUM(quantity * price) AS revenue_2024
FROM sales
WHERE YEAR(sale_date) = 2024
GROUP BY product
HAVING revenue_2024 > 300;
```

---

## 4) Avoiding WRONG Results: Pushdown Early Filters
**Wrong (filters too late):**

```sql
SELECT product, SUM(quantity) AS total_qty
FROM sales
GROUP BY product
HAVING SUM(CASE WHEN country = 'USA' THEN quantity ELSE 0 END) > 5;
```

**Right (faster/clearer):**

```sql
SELECT product, SUM(quantity) AS total_qty
FROM sales
WHERE country = 'USA'
GROUP BY product
HAVING total_qty > 5;
```

---

## 5) Using HAVING Without GROUP BY

MySQL allows `HAVING` without `GROUP BY` as a post-filter on the “single group.”  

**Example:** overall revenue must exceed threshold.
```sql
SELECT SUM(quantity * price) AS total_revenue
FROM sales
HAVING total_revenue > 1000;
```

---

## 6) Multi-Condition Aggregates

**Goal:** Products where (USA revenue) > 200 and (Germany revenue) > 100.

```sql
SELECT product,
       SUM(CASE WHEN country = 'USA' THEN quantity*price ELSE 0 END) AS rev_usa,
       SUM(CASE WHEN country = 'Germany' THEN quantity*price ELSE 0 END) AS rev_de
FROM sales
GROUP BY product
HAVING rev_usa > 200 AND rev_de > 100;
```

---

## 7) Order of Execution (Mental Model)

1. FROM / JOIN  
2. WHERE  — row filter  
3. GROUP BY — make groups  
4. Aggregates — compute per group  
5. HAVING — filter groups  
6. SELECT — project columns/aliases  
7. ORDER BY — sort

* Remember: if you need to filter **rows**, use `WHERE`; 
* if you need to filter **aggregated groups**, use `HAVING`.
