
# 🧠 SQL Query Formatting Guide

Writing SQL queries is not just about getting the right answer —  
it’s about making your code **easy to read, debug, and share**.

This guide shows you how to format SQL queries clearly and professionally.

---

## 🎯 Why Formatting Matters

SQL doesn’t care about spaces or line breaks — but humans do.

**Good formatting:**

- ✅ Makes logic easier to follow  
- ✅ Helps you find bugs faster  
- ✅ Looks professional and readable  

---

## 🧩 Example: Average Salary per Department

### ❌ Hard-to-Read (Poor Formatting)
```sql
select department,avg(salary) from employees where salary>50000 group by department order by avg(salary) desc;
```

### ✅ Clean, Readable Format
```sql
SELECT 
    department,
    AVG(salary) AS avg_salary
FROM 
    employees
WHERE 
    salary > 50000
GROUP BY 
    department
ORDER BY 
    avg_salary DESC;
```

---

## 🪄 SQL Formatting Rules

| Rule | Example | Why It Helps |
|------|----------|--------------|
| **1. Uppercase SQL keywords** | `SELECT`, `FROM`, `WHERE`, `GROUP BY`, `ORDER BY` | Highlights the query logic |
| **2. Each clause on a new line** | `FROM employees` | Easier to scan sections |
| **3. Indent fields and conditions** | `salary > 50000` | Improves readability |
| **4. Use aliases with `AS`** | `AVG(salary) AS avg_salary` | Makes output columns clear |
| **5. Add spaces around operators** | `salary > 50000` | Avoids visual clutter |
| **6. Use consistent casing for identifiers** | Tables and columns in lowercase | Promotes consistency |
| **7. End every statement with a semicolon** | `... DESC;` | Always clear and complete |

---

## 🧱 Example: Multi-Table Join Query

### ✅ Professional Formatting
```sql
SELECT 
    e.employee_name,
    d.department_name,
    m.manager_name
FROM 
    employees e
JOIN 
    departments d ON e.dept_id = d.id
LEFT JOIN 
    managers m ON d.manager_id = m.id
WHERE 
    e.salary > 80000
ORDER BY 
    d.department_name;
```

---

## 🧰 Quick Recap

- Keep **keywords UPPERCASE**, tables/columns lowercase  
- Start each **clause** (`FROM`, `WHERE`, `GROUP BY`) on a new line  
- Use **indentation** for readability  
- Use **`AS`** for aliases to clarify calculated fields  
- Keep queries **clean, minimal, and consistent**

---

## 🧑‍🏫 Practice Exercise

Try reformatting this query into professional SQL style:

```sql
select name,avg(score) from students where score>70 group by name order by avg(score) desc;
```

✅ Hint: Use line breaks, indentation, uppercase keywords, and aliases.

---

**Author:** Dr. Mahmoud Parsian  
**Last Updated:** October 2025
