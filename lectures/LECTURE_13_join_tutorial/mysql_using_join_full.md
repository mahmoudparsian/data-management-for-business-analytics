# Does MySQL Support USING in JOIN Operations?

Yes — **MySQL *does* support `USING` in join operations** ✅  
And it’s extremely useful.

---

# ✅ MySQL JOIN Using `USING`

MySQL allows this syntax:

```sql
SELECT ...
FROM table1
JOIN table2
USING (column_name);
```

This is equivalent to:

```sql
SELECT ...
FROM table1
JOIN table2
ON table1.column_name = table2.column_name;
```

---

# ✅ Why `USING` Is Helpful

When both tables share the same column name, `USING`:

### ✅ Automatically matches the columns  
No need for `ON t1.col = t2.col`.

### ✅ Removes duplicate columns from the result  
Instead of returning both `table1.col` and `table2.col`, it returns **one combined column**.

### ✅ Cleaner and shorter syntax  
This makes join queries cleaner for teaching and real-world use.

---

# ✅ Example

### Using `ON`
```sql
SELECT e.name, d.dept_name, e.dept_id
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id;
```

### Using `USING`
```sql
SELECT e.name, d.dept_name, dept_id
FROM employees e
JOIN departments d
USING (dept_id);
```

✅ Same result  
✅ Cleaner output (only one `dept_id` column returned)

---

# ✅ Works With All MySQL JOIN Types

You can use `USING` with:

- `INNER JOIN`
- `LEFT JOIN`
- `RIGHT JOIN`
- `JOIN` (implicit inner join)

### Example:

```sql
SELECT *
FROM orders
LEFT JOIN customers
USING (customer_id);
```

---

# ✅ Restrictions

MySQL requires:

- The column names must be **identical** in both tables.
- You cannot use table aliases before the column inside `USING`.

✅ Valid:

```sql
USING (dept_id)
```

❌ Invalid:

```sql
USING (e.dept_id)
```

---

# ✅ Summary

| Feature | Supported in MySQL? |
|---------|----------------------|
| `JOIN ... USING (col)` | ✅ Yes |
| Removes duplicate join columns | ✅ Yes |
| Works in LEFT/RIGHT/INNER JOIN | ✅ Yes |
| Requires same column name | ✅ Yes |

---

If you'd like, I can generate:

✅ A one-page Markdown slide on `JOIN ... USING`  
✅ MySQL examples for Week 2  
✅ Diagrams comparing ON vs USING  
