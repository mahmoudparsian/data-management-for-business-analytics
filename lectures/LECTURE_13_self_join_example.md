# Self-Join Example: <br> Employees and Managers (Same Table)

✅ This example demonstrates a **self-join** 
    where both employees and managers are 
    stored in the same table.

✅ A self-join is a type of join where
    **a table is joined with itself**, 
    allowing you to compare rows within 
    the same table.

---

## 📘 Table Schema

```sql
CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  name VARCHAR(50),
  manager_id INT   -- references employees(emp_id)
);
```

---

## 📘 Sample Data

```sql
INSERT INTO employees VALUES
(1, 'Alice',   NULL),   -- CEO (no manager)
(2, 'Bob',      1),     -- Bob reports to Alice
(3, 'Carol',    1),     -- Carol reports to Alice
(4, 'David',    2),     -- David reports to Bob
(5, 'Emma',     2);     -- Emma reports to Bob
```

---

## 📘 Goal

List each employee **along with their manager’s name**, using a **self-join**.

---

## 📘 Self-Join Query

```sql
SELECT 
    e.emp_id AS employee_id,
    e.name AS employee_name,
    m.name AS manager_name
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.emp_id
ORDER BY employee_id;
```

---

## 📘 Output

| employee_id | employee_name | manager_name |
|-------------|----------------|--------------|
| 1           | Alice          | NULL         |
| 2           | Bob            | Alice        |
| 3           | Carol          | Alice        |
| 4           | David          | Bob          |
| 5           | Emma           | Bob          |

---

## ✔️ Explanation

- We alias the table as:
  - **e** for employees  
  - **m** for managers  
- A self-join works because *both* employee and manager rows come from the **same table**.
- `LEFT JOIN` ensures employees without managers (like the CEO) still appear.

---

# Self-Join Example #2 <br> Students and Their Study Buddies

## 📘 Schema

```sql
CREATE TABLE students (
  student_id INT PRIMARY KEY,
  name VARCHAR(50),
  buddy_id INT   -- references students(student_id)
);
```

---

## 📘 Sample Data

```sql
INSERT INTO students VALUES
(1, 'Alice',   3),   -- Alice’s study buddy is Carol
(2, 'Bob',     1),   -- Bob’s buddy is Alice
(3, 'Carol',   4),   -- Carol’s buddy is David
(4, 'David',   NULL),-- David has no buddy
(5, 'Emma',    2);   -- Emma’s buddy is Bob
```

---

## 📘 Goal

List each student along with the name of their study buddy by using a **self-join**.

---

## 📘 Self-Join Query

```sql
SELECT 
    s.student_id,
    s.name AS student_name,
    b.name AS buddy_name
FROM students s
LEFT JOIN students b
    ON s.buddy_id = b.student_id
ORDER BY s.student_id;
```

---

## 📘 Output

| student_id | student_name | buddy_name |
|------------|--------------|------------|
| 1          | Alice        | Carol      |
| 2          | Bob          | Alice      |
| 3          | Carol        | David      |
| 4          | David        | NULL       |
| 5          | Emma         | Bob        |

---

## ✔️ Explanation

- The `students` table references itself through `buddy_id`.
- `s` is the alias for the student.
- `b` is the alias for the buddy (another student).
- `LEFT JOIN` ensures students with no buddy (like David) still appear.

---


