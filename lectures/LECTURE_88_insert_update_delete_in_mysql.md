# Modification of the Database

👉 This deck clearly demonstrates the **three essential SQL operations**:  
- `INSERT` → add rows  
- `UPDATE` → modify rows  
- `DELETE` → remove rows  



# Slide 1: INSERT Examples  

📊 **employees table (initial)**  

| emp_id | name    | department | salary |
|--------|---------|------------|--------|
| 1      | Alice   | HR         | 5000   |
| 2      | Bob     | IT         | 6000   |
| 3      | Charlie | Finance    | 5500   |

### Insert one row  
```sql
INSERT INTO employees (emp_id, name, department, salary)
VALUES (4, 'David', 'IT', 6500);
```

| emp_id | name    | department | salary |
|--------|---------|------------|--------|
| 1      | Alice   | HR         | 5000   |
| 2      | Bob     | IT         | 6000   |
| 3      | Charlie | Finance    | 5500   |
| 4      | David   | IT         | 6500   |

### Insert multiple rows  
```sql
INSERT INTO employees (emp_id, name, department, salary)
VALUES
(5, 'Eva', 'HR', 5200),
(6, 'Frank', 'Finance', 4800);
```

| emp_id | name    | department | salary |
|--------|---------|------------|--------|
| 1      | Alice   | HR         | 5000   |
| 2      | Bob     | IT         | 6000   |
| 3      | Charlie | Finance    | 5500   |
| 4      | David   | IT         | 6500   |
| 5      | Eva     | HR         | 5200   |
| 6      | Frank   | Finance    | 4800   |
---

# Slide 2: UPDATE Examples  

### Update one employee’s salary  
```sql
UPDATE employees
SET salary = 7000
WHERE name = 'Bob';
```
✅ Bob’s salary → 7000  

---

### Update multiple rows (HR employees get +500)  
```sql
UPDATE employees
SET salary = salary + 500
WHERE department = 'HR';
```
✅ Alice & Eva get raises  

---

# Slide 3: DELETE Examples  

### Delete one employee  

```sql
DELETE FROM employees
WHERE emp_id = 6;
```

✅ Frank removed  

---

### Delete all Finance employees
  
```sql
DELETE FROM employees
WHERE department = 'Finance';
```
✅ Charlie (and Frank if present) removed  

---

👉 This deck clearly demonstrates the **three essential SQL operations**:  
- `INSERT` → add rows  
- `UPDATE` → modify rows  
- `DELETE` → remove rows  

