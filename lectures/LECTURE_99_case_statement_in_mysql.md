

# CASE Statement in MySQL

---

## 📑 Step 1: Create Schema and Insert Rows

```sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(20),
    department VARCHAR(20),
    salary INT
);

INSERT INTO employees VALUES
(1, 'Alice', 'HR', 5000),
(2, 'Bob', 'IT', 6000),
(3, 'Charlie', 'Finance', 5500),
(4, 'David', 'IT', 4500),
(5, 'Eva', 'HR', 7000);
```

📊 **employees table (initial data)**

| emp_id | name    | department | salary |
|--------|---------|------------|--------|
| 1      | Alice   | HR         | 5000   |
| 2      | Bob     | IT         | 6000   |
| 3      | Charlie | Finance    | 5500   |
| 4      | David   | IT         | 4500   |
| 5      | Eva     | HR         | 7000   |

---

## 📑 Step 2: CASE Statement in SELECT

👉 Example: Categorize salaries into levels.

```sql
SELECT name, salary,
       CASE
         WHEN salary >= 7000 THEN 'High'
         WHEN salary BETWEEN 5000 AND 6999 THEN 'Medium'
         ELSE 'Low'
       END AS salary_level
FROM employees;
```

✅ Output:

| name    | salary | salary_level |
|---------|--------|--------------|
| Alice   | 5000   | Medium       |
| Bob     | 6000   | Medium       |
| Charlie | 5500   | Medium       |
| David   | 4500   | Low          |
| Eva     | 7000   | High         |

---

## 📑 Step 3: CASE Statement for Conditional Updates

👉 Example: Give raises based on department.

```sql
UPDATE employees
SET salary = CASE
               WHEN department = 'HR' THEN salary + 500
               WHEN department = 'IT' THEN salary + 1000
               ELSE salary
             END;
```

📊 After update →

| emp_id | name    | department | salary |
|--------|---------|------------|--------|
| 1      | Alice   | HR         | 5500   |
| 2      | Bob     | IT         | 7000   |
| 3      | Charlie | Finance    | 5500   |
| 4      | David   | IT         | 5500   |
| 5      | Eva     | HR         | 7500   |

---

## 📑 Key Takeaways

- `CASE` in **SELECT** → derive new computed columns.  
- `CASE` in **UPDATE** → apply conditional updates.  
- Acts like `if-else` logic in SQL.

