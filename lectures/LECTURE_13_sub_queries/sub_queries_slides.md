# SQL Subqueries & CTEs (WITH) — Slide Deck

## Slide 1 — Introduction to Subqueries

* A subquery is a query nested inside another SQL statement.

* Used for filtering, aggregations, ranking, and modular logic

* Two types: 

	* inline subqueries and 
	
	* CTEs (`WITH`)

---

## Slide 2 — Why Do We Need Subqueries?

Subqueries help when:

- A value must be computed first

- A filter depends on aggregated data

- Query logic needs multiple stages

---

## Slide 3 — Basic Inline Subquery Example

```sql
SELECT emp_id, name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);
```

---

## Slide 4 — Subquery in the FROM Clause

	Find employees whose salary is bigger than 
	the average salary of all employees
	
solution-1:

```sql
SELECT country, avg_salary
FROM (
    SELECT country, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY country
) AS country_stats
WHERE avg_salary > 120000;
```

OR

solution-2:

```sql
WITH country_stats AS
(
    SELECT country, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY country
) 
SELECT country, avg_salary
FROM  country_stats
WHERE avg_salary > 120000;

---

## Slide 5 — Limitations of Subqueries

- Hard to read and maintain
- Cannot be reused
- Must alias derived tables
- Hard for multi-step logic

---

## Slide 6 — Introducing CTEs (Common Table Expression)
```sql
WITH name AS (
    SELECT ...
)
SELECT ...
FROM name;
```

---

## Slide 7 — Single CTE Example

```sql
WITH avg_sal AS (
    SELECT AVG(salary) AS avg_salary
    FROM employees
)
SELECT emp_id, name, salary
FROM employees
JOIN avg_sal
WHERE salary > avg_salary;
```


```
This subquery: what does it do:

WITH avg_sal AS (
    SELECT AVG(salary) AS avg_salary
    FROM employees
)
=>

Table as: avg_sal
one column: avg_salary
one row: <average-salary-of-all-employees>
```

---

## Slide 8 — CTE with GROUP BY

```sql
WITH dept_stats AS (
    SELECT dept_id, 
           AVG(salary) AS avg_salary, 
           COUNT(*) AS emp_count
    FROM employees
    GROUP BY dept_id
)
SELECT * 
FROM dept_stats
WHERE avg_salary > 120000 AND
      emp_count > 5;
```

---

## Slide 9 — Multiple CTEs in a Chain

```sql
WITH 
  high_salaries AS 
  (  
     SELECT * FROM employees 
     WHERE salary > 150000
  ),
  us_only AS 
  (
     SELECT * FROM 
     high_salaries WHERE country = 'USA'
  )
SELECT * FROM us_only;
```

## What tables can be used in CTEs?

```
Lets say we have: employees, departments, projects

WITH 
CTE1 AS
(
   use employees, departments, projects
)
,
CTE2 AS
(
 use employees, departments, projects & CTE1
) 
,
CTE3 AS
(
  use employees, departments, projects & CTE1 & CTE2
)
SELECT 
 < use employees, departments, projects & CTE1 & CTE2 & CTE3>
```
---

## Slide 10 — Ranking with CTEs

Find Top-3 employees per country:

```sql
WITH salary_ranked AS (
    SELECT emp_id, name, country, salary,
           RANK() OVER (PARTITION BY country 
                        ORDER BY salary DESC) 
             AS salary_rank
    FROM employees
)
SELECT * 
FROM salary_ranked 
WHERE salary_rank <= 3;
```

---

## Slide 11 — Scenario: Top-3 Products by Revenue

```sql
WITH revenue AS (
    SELECT product_id, 
           category, 
           SUM(price * quantity) AS total_revenue
    FROM sales
    GROUP BY product_id, category
),
ranked AS (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY category 
                              ORDER BY total_revenue DESC) 
             AS rn
    FROM revenue
)
SELECT * 
FROM ranked 
WHERE rn <= 3;
```

---

## Slide 12 — Reusable Logic with CTEs

```sql
WITH dept_stats AS (
    SELECT dept_id, 
           AVG(salary) avg_sal, 
           MIN(salary) min_sal, 
           MAX(salary) max_sal
    FROM employees
    GROUP BY dept_id
)
SELECT * 
FROM dept_stats
WHERE avg_sal > 45000 AND
      min_sal > 23000;
```

---

## Slide 13 — CTE vs Subquery Comparison

| Feature          | Subquery | CTE        |
|------------------|----------|------------|
| Readability      | Poor     | Excellent  |
| Reusability      | No       | Yes        |
| Multi-step logic | Hard     | Easy       |
| Window functions | Works    | Works well |

---

## Slide 14 — Scenario: Students Above Department Average

```sql
WITH avg_scores AS (
    SELECT department, 
           AVG(score) AS dept_avg
    FROM students
    GROUP BY department
)
SELECT s.student_id, s.name, s.score
FROM students s
JOIN avg_scores a ON s.department = a.department
WHERE s.score > a.dept_avg;
```

---

## Slide 15 — Scenario: Highest Salary per Job Title

```sql
WITH ranked_jobs AS (
    SELECT emp_id, 
           name, 
           job_title, 
           salary,
           RANK() OVER (PARTITION BY job_title 
                        ORDER BY salary DESC) 
             AS rnk
    FROM employees
)
SELECT * 
FROM ranked_jobs 
WHERE rnk = 1;
```

---

## Slide 16 — Scenario: Customers with Above-Average Spend

```sql
WITH cust_totals AS (
    SELECT customer_id, 
           SUM(order_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
avg_total AS (
    SELECT AVG(total_spent) AS avg_spent 
    FROM cust_totals
)
SELECT * 
FROM cust_totals c
JOIN avg_total a
WHERE c.total_spent > a.avg_spent;
```

---

## Slide 17 — CTE Best Practices

- Use CTEs for multi-step transformations
- Name CTEs clearly
- Avoid deeply nested subqueries
- Use CTEs for window functions
- Prioritize readability

---

## Slide 18 — Final Summary

CTEs (`WITH`) provide:

- Better readability
- Modular, step-based logic
- Reusable query components
- Enhanced analytic capabilities

-----

## Slide 19 — Final Summary

	Modern SQL relies heavily on CTEs for 
	complex business intelligence queries.
	
