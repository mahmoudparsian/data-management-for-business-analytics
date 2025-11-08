# 🧠 Understanding First Normal Form (1NF)

## ❌ Example: Table Not in 1NF

Consider a table called `students_courses`:

| student_id | student_name | courses_enrolled        |
|-------------|---------------|--------------------------|
| 1           | Alice         | Math, Science, English   |
| 2           | Bob           | History, Math            |
| 3           | Carol         | Physics, Chemistry, Math  |

---

## 🚫 What’s Wrong Here?

This table **violates 1NF** because:

- The column `courses_enrolled` contains **multiple values (a list)** instead of **atomic values**.  
- Each field in a table should hold **only one value**, not a set of values.  

---

## ✅ Conversion to 1NF

We make sure every field contains **only one value per cell**.

| student_id | student_name | course_enrolled |
|-------------|---------------|-----------------|
| 1           | Alice         | Math            |
| 1           | Alice         | Science         |
| 1           | Alice         | English         |
| 2           | Bob           | History         |
| 2           | Bob           | Math            |
| 3           | Carol         | Physics         |
| 3           | Carol         | Chemistry       |
| 3           | Carol         | Math            |

---

## 💡 MySQL Example

```sql
-- ❌ Table violating 1NF
CREATE TABLE students_courses_not_1NF (
  student_id INT,
  student_name VARCHAR(50),
  courses_enrolled VARCHAR(300)  -- comma-separated values
);

-- ✅ Corrected table in 1NF
CREATE TABLE students_courses_1NF (
  student_id INT,
  student_name VARCHAR(50),
  course_enrolled VARCHAR(50)  -- one course per row
);
```

---

## 🧠 Key Takeaway

A table is in **First Normal Form (1NF)** if:

- Each column contains **only atomic (indivisible)** values.  
- There are **no repeating groups or lists** in any column.  

---

### 👨‍🏫 Summary

| Rule | Description |
|------|--------------|
| 1NF | Each cell contains one value only (no arrays or lists) |
| Goal | Eliminate repeating groups, store one value per field |

---

**Author:** Dr. Mahmoud Parsian  
_Last updated: November 2, 2025_
