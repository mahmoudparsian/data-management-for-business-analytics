# Employees — 30 Group-By & Aggregation Queries (MySQL)

### Q1. Employees per department.

```sql
SELECT department, 
       COUNT(*) AS cnt 
FROM employees 
GROUP BY department 
ORDER BY cnt DESC;
```

### Q2. Employees per country.

```sql
SELECT country, 
       COUNT(*) AS cnt 
FROM employees 
GROUP BY country 
ORDER BY cnt DESC;
```

### Q3. Average salary per department.

```sql
SELECT department, 
       AVG(salary) AS avg_salary 
FROM employees 
GROUP BY department 
ORDER BY avg_salary DESC;
```

### Q4. Average salary per country.

```sql
SELECT country, 
       AVG(salary) AS avg_salary 
FROM employees 
GROUP BY country 
ORDER BY avg_salary DESC;
```

### Q5. Average age per department.

```sql
SELECT department, 
       AVG(age) AS avg_age 
FROM employees 
GROUP BY department;
```

### Q6. Min/Max salary per department.

```sql
SELECT department, 
       MIN(salary) AS min_sal, 
       MAX(salary) AS max_sal 
FROM employees 
GROUP BY department;
```

### Q7. Min/Max age per country.

```sql
SELECT country, 
       MIN(age) AS min_age, 
       MAX(age) AS max_age 
FROM employees 
GROUP BY country;
```

### Q8. Total salary per department.

```sql
SELECT department, 
       SUM(salary) AS total_salary 
FROM employees 
GROUP BY department 
ORDER BY total_salary DESC;
```

### Q9. Median-like salary per department (approx via percentile_disc).

```
PERCENTILE_DISC(n) in MySQL 

	•	Type: it’s an ordered-set aggregate function.
	
	•	Meaning: Percentile Discrete.
	
	•	It returns the **first value in the 
	    ordered set whose cumulative distribution 
	    is greater than or equal to the requested 
	    percentile n**.
```	

```sql
SELECT department, 
       PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY salary) AS median_salary 
FROM employees 
GROUP BY department;
```

### Q10. Salary standard deviation per department.

```sql
SELECT department, 
       STDDEV_SAMP(salary) AS sd_salary 
FROM employees 
GROUP BY department;
```

### Q11. Count males/females per department.

```sql
SELECT department, 
       gender, 
       COUNT(*) AS cnt 
FROM employees 
GROUP BY department, gender 
ORDER BY department;
```

### Q12. Average salary by gender per department.

```sql
SELECT department, 
       gender, 
       AVG(salary) AS avg_salary 
FROM employees 
GROUP BY department, gender;
```

### Q13. Employees joined per year.

```sql
SELECT YEAR(date_joined) AS yr, 
       COUNT(*) AS cnt 
FROM employees 
GROUP BY YEAR(date_joined) 
ORDER BY yr;
```

### Q14. Employees joined per month in 2024.

```sql
SELECT MONTH(date_joined) AS mon, 
       COUNT(*) AS cnt 
FROM employees 
WHERE YEAR(date_joined)=2024 
GROUP BY MONTH(date_joined) 
ORDER BY mon;
```

### Q15. Average age by country and gender.

```sql
SELECT country, 
       gender, 
       AVG(age) AS avg_age 
FROM employees 
GROUP BY country, gender 
ORDER BY country;
```

### Q16. Top department by average salary.

```sql
SELECT department, 
       AVG(salary) AS avg_salary 
FROM employees 
GROUP BY department 
ORDER BY avg_salary DESC 
LIMIT 1;
```

### Q17. Departments having more than 8 employees.

```sql
SELECT department, 
       COUNT(*) AS cnt 
FROM employees 
GROUP BY department 
HAVING cnt > 8;
```

### Q18. Countries with average salary > 120k.

```sql
SELECT country, 
       AVG(salary) AS avg_salary 
FROM employees 
GROUP BY country 
HAVING avg_salary > 120000;
```

### Q19. Departments with average age < 40.

```sql
SELECT department, 
       AVG(age) AS avg_age 
FROM employees 
GROUP BY department 
HAVING avg_age < 40;
```

### Q20. Department share of employees (percentage).

```sql
SELECT department, 
       ROUND(100.0 * COUNT(*)/(SELECT COUNT(*) FROM employees),2) AS pct 
FROM employees 
GROUP BY department 
ORDER BY pct DESC;
```

### Q21. Country share of payroll (percentage of total salary).

```sql
SELECT country, 
       ROUND(100.0 * SUM(salary)/(SELECT SUM(salary) FROM employees),2) AS pct_payroll 
FROM employees 
GROUP BY country 
ORDER BY pct_payroll DESC;
```

### Q22. Top 3 departments by total salary.

```sql
SELECT department, 
       SUM(salary) AS total_salary 
FROM employees 
GROUP BY department 
ORDER BY total_salary DESC 
LIMIT 3;
```

### Q23. Average salary by age bucket (20s, 30s, 40s, 50s, 60s, 70s+).

```sql
SELECT 
  CASE 
    WHEN age BETWEEN 20 AND 29 THEN '20s'
    WHEN age BETWEEN 30 AND 39 THEN '30s'
    WHEN age BETWEEN 40 AND 49 THEN '40s'
    WHEN age BETWEEN 50 AND 59 THEN '50s'
    WHEN age BETWEEN 60 AND 69 THEN '60s'
    ELSE '70s+'
  END AS age_bucket,
  AVG(salary) AS avg_salary

FROM employees
GROUP BY age_bucket
ORDER BY age_bucket;
```

### Q24. Count per department for USA only.

```sql
SELECT department, 
       COUNT(*) AS cnt 
FROM employees 
WHERE country='USA' 
GROUP BY department 
ORDER BY cnt DESC;
```

### Q25. Average salary of females vs males.

```sql
SELECT gender, 
       AVG(salary) AS avg_salary 
FROM employees 
GROUP BY gender;
```

### Q26. Max salary per country and department.

```sql
SELECT country, 
       department, 
       MAX(salary) AS max_salary 
FROM employees 
GROUP BY country, department 
ORDER BY country, max_salary DESC;
```

### Q27. Employees joined per department per year.

```sql
SELECT department, 
       YEAR(date_joined) AS yr, 
       COUNT(*) AS cnt 
FROM employees 
GROUP BY department, YEAR(date_joined) 
ORDER BY department, yr;
```

### Q28. Departments with min salary above 80k.

```sql
SELECT department, 
       MIN(salary) AS min_salary 
FROM employees 
GROUP BY department 
HAVING min_salary > 80000;
```

### Q29. Countries where more than 5 employees work.

```sql
SELECT country, 
       COUNT(*) AS cnt 
FROM employees 
GROUP BY country 
HAVING cnt > 5;
```

### Q30. Departments where females outnumber males.

```sql
SELECT department
FROM employees
GROUP BY department
HAVING SUM(gender='FEMALE') > SUM(gender='MALE');
```


### Q31. median salary for the Engineering department.

```sql
SELECT 
  department,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary) AS median_salary
FROM employees
WHERE department = 'Engineering'
GROUP BY department;
```