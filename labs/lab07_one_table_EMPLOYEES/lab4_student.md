# 📘 Lab 4: Window Functions & Ranking (Employees Table)

Schema:
```sql
employees(emp_id, first_name, last_name, department, salary, hire_date)
```

## Exercises

1. Rank employees by salary (highest salary = rank 1).  
2. Assign a row number to employees based on hire date (earliest = 1).  
3. Use dense rank to rank employees by salary (no gaps).  
4. Show the percent rank of each employee by salary.  
5. Rank employees within each department by salary.  
6. Calculate a running total of salaries ordered by employee ID.  
7. Show average salary within each department (using window function).  
8. Show difference between each employee’s salary and their department’s average.  
9. Flag the newest hire in each department.  
10. Find the oldest hire in each department (using ROW_NUMBER with PARTITION).  
