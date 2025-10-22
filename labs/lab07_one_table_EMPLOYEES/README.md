# 📊 Teaching Slide Deck: Employees Theme


📂 Deliverables

    •    1. A single table called employees with columns:
		•    emp_id INT PRIMARY KEY
		•    first_name VARCHAR(30)
		•    last_name VARCHAR(30)
		•    department VARCHAR(30)
		•    salary DECIMAL(10,2)
		•    hire_date DATE

    2.    queries:
		•    A progressive set of 50 SQL queries:
		•    Basics (1–10): SELECT *, choosing columns, WHERE filters.
		•    Intermediate (11–25): ORDER BY, aggregates (COUNT, SUM, AVG, MIN, MAX).
		•    Advanced basics (26–40): GROUP BY, HAVING, simple subqueries.
		•    Intro to window functions (41–50): RANK, ROW_NUMBER, WITH.
		•    Each query includes English explanation + SQL.
		•    The first student lab assignment:
		•    10 progressive exercises, each stated in natural language.
		•    No answers — students write queries themselves.
		•    Example: “List all employees in the ‘Marketing’ department.”

⸻


---

# 🎯 Introduction
- Target audience: Senior undergraduates (Business School)
- No prior SQL experience required
- Theme: **Employees database**
- One main table: `employees(emp_id, first_name, last_name, department, salary, hire_date)`
- 5 progressive labs to build SQL skills step by step

---

# 🧪 Lab 1: Basics
- Objectives:
  - Understand SELECT statements
  - Filtering with WHERE
  - Sorting with ORDER BY
  - Simple pattern matching with LIKE
- Example queries:
  ```sql
  SELECT * FROM employees;
  SELECT first_name, last_name FROM employees;
  SELECT * FROM employees WHERE department='IT';
  ```

---

# 📊 Lab 2: Aggregation & GROUP BY
- Objectives:
  - Use aggregate functions: COUNT, AVG, MIN, MAX, SUM
  - Group data with GROUP BY
  - Filter groups with HAVING
- Example queries:
  ```sql
  SELECT department, COUNT(*) FROM employees GROUP BY department;
  SELECT department, AVG(salary) FROM employees GROUP BY department HAVING AVG(salary) > 70000;
  ```

---

# 🔎 Lab 3: Subqueries
- Objectives:
  - Write nested queries
  - Use WITH (CTEs) for clarity
  - Combine subqueries with conditions
- Example queries:
  ```sql
  SELECT * FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);
  WITH dept_avg AS (
    SELECT department, AVG(salary) AS avg_sal FROM employees GROUP BY department
  )
  SELECT * FROM dept_avg ORDER BY avg_sal DESC LIMIT 1;
  ```

---

# 🪜 Lab 4: Window Functions & Ranking
- Objectives:
  - Apply ranking functions (RANK, DENSE_RANK, ROW_NUMBER)
  - Use PERCENT_RANK to calculate percentiles
  - Perform running totals and moving averages
- Example queries:
  ```sql
  SELECT first_name, salary,
         RANK() OVER (ORDER BY salary DESC) AS salary_rank
  FROM employees;

  SELECT department, salary,
         salary - AVG(salary) OVER (PARTITION BY department) AS diff_from_avg
  FROM employees;
  ```

---

# 🏆 Lab 5: Capstone (Advanced SQL)
- Objectives:
  - Integrate aggregation + subqueries + window functions
  - Solve business-style problems
  - Apply multiple SQL features together
- Example queries:
  ```sql
  -- Top 3 highest-paid employees in each department
  SELECT department, first_name, salary
  FROM (
    SELECT department, first_name, salary,
           RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
    FROM employees
  ) x
  WHERE rnk <= 3;

  -- Employees in top 10% salaries
  WITH ranked AS (
    SELECT first_name, salary,
           PERCENT_RANK() OVER (ORDER BY salary DESC) AS pct
    FROM employees
  )
  SELECT * FROM ranked WHERE pct <= 0.1;
  ```

---

# 📚 Wrap-Up

- 5 labs build skills progressively:

  1. Basics
  2. Aggregation & GROUP BY
  3. Subqueries
  4. Window Functions
  5. Capstone (Advanced SQL)
- Students gain confidence step by step
- Ready for real-world business SQL problems

---
