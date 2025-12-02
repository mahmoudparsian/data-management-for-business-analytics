# 🎓  Subqueries with WITH in MySQL


    Let’s build a teaching module for sub-queries 
    using WITH (Common Table Expressions / CTEs) 
    
    We’ll make it hands-on with schema + data + 
    6 queries 
              3 basic, 
              3 intermediate
    
    ## 📝 Teaching Takeaway

    •    RANK() → gaps appear if there are ties.
    
    •    DENSE_RANK() → no gaps, ranks stay consecutive.


⸻

## 🔹 Step 1: Schema + Sample Data

~~~sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(20),
    department VARCHAR(20),
    salary INT
);

INSERT INTO employees VALUES
(1, 'Alice', 'HR', 5000),
(2, 'Bob', 'IT', 7000),
(3, 'Charlie', 'IT', 6000),
(4, 'David', 'Finance', 8000),
(5, 'Eva', 'HR', 5500),
(6, 'Frank', 'Finance', 4000);
~~~

#### 📊 employees table

~~~
emp_id    name    department  salary
1         Alice    HR         5000
2         Bob      IT         7000
3         Charlie  IT         6000
4         David    Finance    8000
5         Eva      HR         5500
6         Frank    Finance    4000
~~~

⸻

## 🔹 Step 2: Basic Queries (CTE Examples)

### 1. Employees with salary > 6000

~~~sql
WITH High_Salary AS (
  SELECT name, salary FROM employees WHERE salary > 6000
)
SELECT * 
FROM High_Salary;


✅ Output → 
            Bob   7000
            David 8000
~~~
⸻

### 2. Average salary across all employees

~~~sql
WITH Avg_Salary AS (
  SELECT AVG(salary) AS avg_sal 
  FROM employees
)
SELECT avg_sal FROM AvgSalary;

✅ Output → 6083.33
~~~
⸻

### 3. All employees in IT department

~~~sql
WITH IT_Dept AS (
  SELECT name, salary FROM employees WHERE department = 'IT'
)
SELECT * 
FROM IT_Dept;

✅ Output → 

            Bob     7000
            Charlie 6000
~~~
⸻

## 🔹 Step 3: Intermediate Queries (CTE + Aggregation)

### 4. Find the highest salary per department

WITH Dept_Max AS (
  SELECT department, MAX(salary) AS max_sal
  FROM employees
  GROUP BY department
)
SELECT * 
FROM Dept_Max;

✅ Output → 

HR       5500
IT       7000 
Finance  8000
~~~
⸻

### 5. Employees earning above their department’s average

~~~sql
WITH Dept_Avg AS (
  SELECT department, AVG(salary) AS avg_sal
  FROM employees
  GROUP BY department
)
SELECT e.name, e.department, e.salary
FROM employees e
JOIN Dept_Avg d ON e.department = d.department
WHERE e.salary > d.avg_sal;

✅ Output → 

Eva   HR      5500
Bob   IT      7000
David Finance 8000
~~~
⸻

### 6. Rank employees by salary (CTE + Window Function, MySQL 8+)

~~~sql
WITH Salary_Rank AS (
  SELECT name, 
         department, 
         salary,
         RANK() OVER (ORDER BY salary DESC) AS rnk
  FROM employees
)
SELECT * FROM Salary_Rank;

✅ Output → 

David (1), 
Bob (2), 
Charlie (3), 
Eva (4), 
Alice (5), 
Frank (6)

⸻

🔹 Teaching Notes

    •    Basic CTEs simplify queries by 
         giving subquery results a name.
    
    •    Intermediate CTEs enable stepwise thinking → 
         first compute aggregates, then join back.
         
    •    Window Functions + CTEs = powerful analysis 
         (ranking, running totals, etc.).

⸻


# 🎓 Extra Ranking Examples with WITH

We’ll use the same employees table:

~~~
emp_id    name    department    salary
1         Alice    HR           5000
2         Bob      IT           7000
3         Charlie  IT           6000
4         David    Finance      8000
5         Eva      HR           5500
6         Frank    Finance      4000
~~~

⸻

## 🔹 6. Ranking with RANK() 

~~~sql
WITH Salary_Rank AS (
  SELECT name, department, salary,
         RANK() OVER (ORDER BY salary DESC) AS rnk
  FROM employees
)
SELECT * 
FROM Salary_Rank;
~~~

✅ Output (ties get same rank, gaps appear):

~~~
name    salary  rnk
David    8000    1
Bob      7000    2
Charlie  6000    3
Eva      5500    4
Alice    5000    5
Frank    4000    6
~~~

⸻

## 🔹 7. Ranking with DENSE_RANK()

👉 Similar to RANK(), but no gaps in ranking.

~~~
WITH Salary_Dense_Rank AS (
  SELECT name, department, salary,
         DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rnk
  FROM employees
)
SELECT * 
FROM Salary_Dense_Rank;
~~~

✅ Output (no gaps):

name    salary    dense_rnk
David    8000     1
Bob      7000     2
Charlie  6000     3
Eva      5500     4
Alice    5000     5
Frank    4000     6

(Difference shows up when salaries tie — RANK skips, DENSE_RANK doesn’t.)

⸻

## 🔹 8. Ranking with ROW_NUMBER()

👉 Assigns a unique number to each row (even if salaries tie).

~~~sql
WITH Salary_Row_Num AS (
  SELECT name, 
         department, 
         salary,
         ROW_NUMBER() OVER (ORDER BY salary DESC) AS rownum
  FROM employees
)
SELECT * 
FROM Salary_Row_Num;
~~~

✅ Output (no ties, strictly unique order):

~~~
name     salary   rownum
David    8000     1
Bob      7000     2
Charlie  6000     3
Eva      5500     4
Alice    5000     5
Frank    4000     6
~~~

⸻

# 📝 Teaching Notes

    •    RANK() → gaps in ranking when ties occur.
    
    •    DENSE_RANK() → no gaps in ranking.
    
    •    ROW_NUMBER() → unique number per row, ignores ties.

⸻

# Difference between `RANK()` and `DENSE_RANK()`

⸻

## 🎓 Example 1: Student Exam Scores

📊 students table

~~~
student_id  name    score
1           Alice    95
2           Bob      90
3           Charlie  90
4           David    85
~~~

⸻

## Query with RANK()

~~~sql
WITH Ranked AS (
  SELECT name, 
         score,
         RANK() OVER (ORDER BY score DESC) AS rnk
  FROM students
)
SELECT * 
FROM Ranked;
~~~

✅ Output:

~~~
name     score    rnk
Alice    95       1
Bob      90       2
Charlie  90       2
David    85       4
~~~

👉 Notice the gap (rank 3 is skipped) because Bob & Charlie tied.

⸻

## Query with DENSE_RANK()

~~~
WITH DenseRanked AS (
  SELECT name, 
         score,
         DENSE_RANK() OVER (ORDER BY score DESC) AS drnk
  FROM students
)
SELECT * 
FROM DenseRanked;
~~~

✅ Output:

~~~
name    score    drnk
Alice    95      1
Bob      90      2
Charlie  90      2
David    85      3
~~~

👉 No gap: next rank continues as 3.

⸻

## 🎓 Example 2: Employee Salaries

#### 📊 employees table

~~~
emp_id    name     salary
1         Eva      8000
2         Frank    7500
3         Grace    7500
4         Henry    7000
5         Irene    6500
~~~
⸻

## Query with `RANK()`

WITH Salary_Rank AS (
  SELECT name, 
         salary,
         RANK() OVER (ORDER BY salary DESC) AS rnk
  FROM employees
)
SELECT * 
FROM SalaryRank;
~~~

✅ Output:

~~~
name     salary    rnk
Eva      8000      1
Frank    7500      2
Grace    7500      2
Henry    7000      4
Irene    6500      5
~~~

👉 Rank 3 is skipped because Frank & Grace tied.

⸻

## Query with `DENSE_RANK()`

~~~sql
WITH Salary_Dense_Rank AS (
  SELECT name, 
         salary,
         DENSE_RANK() OVER (ORDER BY salary DESC) AS drnk
  FROM employees
)
SELECT * 
FROM Salary_Dense_Rank;
~~~

✅ Output:

~~~
name     salary    drnk
Eva      8000      1
Frank    7500      2
Grace    7500      2
Henry    7000      3
Irene    6500      4
~~~

👉 No gaps: next rank is 3.

⸻

## 📝 Teaching Takeaway

    •    RANK() → gaps appear if there are ties.
    
    •    DENSE_RANK() → no gaps, ranks stay consecutive.

⸻


