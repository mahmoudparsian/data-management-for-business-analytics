# Teacher’s Answer Key: Employees Table (MySQL)

This file contains SQL solutions for all exercises.

---

## Part 1: Basic Queries (20)

1. Show all employees  
```sql
SELECT * 
FROM employees;
```

2. Show the first 10 employees  
```sql
SELECT * 
FROM employees 
LIMIT 10;
```

3. List all employee first and last names  
```sql
SELECT first_name, last_name 
FROM employees;
```

4. Show employees from USA  
```sql
SELECT * 
FROM employees 
WHERE country='USA';
```

5. Show employees in the IT department  
```sql
SELECT * 
FROM employees 
WHERE department='IT';
```

6. Show employees with salary greater than 150000  
```sql
SELECT * 
FROM employees 
WHERE salary > 150000;
```

7. Show employees born after 1990  
```sql
SELECT * 
FROM employees 
WHERE date_of_birth > '1990-01-01';
```

8. Show employees ordered by salary  
```sql
SELECT * 
FROM employees 
ORDER BY salary;
```

9. Show employees ordered by last name descending  
```sql
SELECT * 
FROM employees 
ORDER BY last_name DESC;
```

10. Show employees with degree 'PHD'  
```sql
SELECT * 
FROM employees 
WHERE degree='PHD';
```

11. Show first 5 employees with salary between 120000 and 140000  
```sql
SELECT * 
FROM employees 
WHERE salary BETWEEN 120000 AND 140000 
LIMIT 5;
```

12. Show distinct countries  
```sql
SELECT DISTINCT country 
FROM employees;
```

13. Show distinct departments  
```sql
SELECT DISTINCT department 
FROM employees;
```

14. Count number of employees  
```sql
SELECT COUNT(*) 
FROM employees;
```

15. Show employees hired in 2020  
```sql
SELECT * 
FROM employees 
WHERE YEAR(hire_date)=2020;
```

16. Show employees born in March  
```sql
SELECT * 
FROM employees 
WHERE MONTH(date_of_birth)=3;
```

17. Show employees with salary exactly 200000  
```sql
SELECT * 
FROM employees 
WHERE salary=200000;
```

18. Show employees with last name 'Smith'  
```sql
SELECT * 
FROM employees 
WHERE last_name='Smith';
```

19. Show employees with degree in ('BS','MS')  
```sql
SELECT * 
FROM employees 
WHERE degree IN ('BS','MS');
```

20. Show employees not in the IT department  
```sql
SELECT * 
FROM employees 
WHERE department <> 'IT';
```

---

## Part 2: Basic-to-Intermediate Queries (20)

1. Count employees in each department  
```sql
SELECT department, COUNT(*) 
FROM employees 
GROUP BY department;
```

2. Count employees in each country  
```sql
SELECT country, COUNT(*) 
FROM employees 
GROUP BY country;
```

3. Show average salary by department  
```sql
SELECT department, AVG(salary) 
FROM employees 
GROUP BY department;
```

4. Show maximum salary in each department  
```sql
SELECT department, MAX(salary) 
FROM employees 
GROUP BY department;
```

5. Show minimum salary in each department  
```sql
SELECT department, MIN(salary) 
FROM employees 
GROUP BY department;
```

6. Show average salary by degree  
```sql
SELECT degree, AVG(salary) 
FROM employees 
GROUP BY degree;
```

7. List employees hired after 2020  
```sql
SELECT * 
FROM employees 
WHERE hire_date > '2020-01-01';
```

8. List employees hired before 2015  
```sql
SELECT * 
FROM employees 
WHERE hire_date < '2015-01-01';
```

9. Show employees with last name starting with 'J'  
```sql
SELECT * 
FROM employees 
WHERE last_name LIKE 'J%';
```

10. Show employees with first name containing 'a'  
```sql
SELECT * 
FROM employees 
WHERE first_name LIKE '%a%';
```

11. Show employees with hire_date in 2018 or 2019  
```sql
SELECT * 
FROM employees 
WHERE YEAR(hire_date) IN (2018,2019);
```

12. Group employees by country and department  
```sql
SELECT country, department, COUNT(*) 
FROM employees 
GROUP BY country, department;
```

13. Find the highest salary employee  
```sql
SELECT * 
FROM employees 
ORDER BY salary DESC 
LIMIT 1;
```

14. Find the lowest salary employee  
```sql
SELECT * 
FROM employees 
ORDER BY salary ASC 
LIMIT 1;
```

15. Show top 5 highest paid employees  
```sql
SELECT * 
FROM employees 
ORDER BY salary DESC 
LIMIT 5;
```

16. Show employees with salary above average  
```sql
SELECT * 
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);
```

17. Show employees with salary below average  
```sql
SELECT * 
FROM employees 
WHERE salary < (SELECT AVG(salary) FROM employees);
```

18. Find average age of employees  
```sql
SELECT AVG(YEAR(CURDATE())-YEAR(date_of_birth)) 
FROM employees;
```

19. Count employees born in each decade  
```sql
SELECT (YEAR(date_of_birth) DIV 10)*10 AS decade, 
       COUNT(*) 
FROM employees 
GROUP BY decade;
```

20. Count employees hired each year  
```sql
SELECT YEAR(hire_date), COUNT(*) 
FROM employees 
GROUP BY YEAR(hire_date);
```

---

## Part 3: Intermediate Queries (20)

1. Find employees earning more than their department’s average salary  
```sql
SELECT * 
FROM employees e 
WHERE salary > (
                 SELECT AVG(salary) 
                 FROM employees 
                 WHERE department=e.department
               );
```

2. Find the youngest employee in each department  
```sql
SELECT e.* 
FROM employees e 
WHERE date_of_birth = (
                        SELECT MAX(date_of_birth) 
                        FROM employees 
                        WHERE department=e.department
                      );
```

3. Find the oldest employee in each department  
```sql
SELECT e.* 
FROM employees e 
WHERE date_of_birth = (
                        SELECT MIN(date_of_birth) 
                        FROM employees 
                        WHERE department=e.department
                      );
```

4. Rank employees by salary within each department  
```sql
SELECT emp_id, 
       first_name, 
       last_name, 
       department, 
       salary, 
       RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_rank 
FROM employees;
```

5. Dense rank employees globally by salary  
```sql
SELECT emp_id, 
       first_name, 
       salary, 
       DENSE_RANK() OVER(ORDER BY salary DESC) AS rank_salary 
FROM employees;
```

6. Find departments with an average salary greater than 150000  
```sql
SELECT department, 
       AVG(salary) as avg_salary
FROM employees 
GROUP BY department 
HAVING avg_salary > 150000;
```

7. Find countries with more than 10 employees  
```sql
SELECT country,
       COUNT(*) AS num_of_emps 
FROM employees 
GROUP BY country 
HAVING num_of_emps > 10;
```

8. Show the top 3 highest salaries per department 

solution-1:
 
```sql
SELECT emp_id, 
       department, 
       salary FROM 
(
  SELECT emp_id, 
         department, 
         salary, 
         ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS rnk 
  FROM employees
) t 
WHERE rnk<=3;
```

solution-2:
 
```sql
WITH t AS
(
  SELECT emp_id, 
         department, 
         salary, 
         ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS rnk 
  FROM employees
)  
SELECT emp_id, 
       department, 
       salary,
       rnk 
FROM t
WHERE rnk<=3;
```

9. Find employees hired in the last 5 years  
```sql
SELECT * 
FROM employees 
WHERE hire_date > CURDATE()-INTERVAL 5 YEAR;
```

10. Show average salary grouped by hire year  
```sql
SELECT YEAR(hire_date), 
       AVG(salary) 
FROM employees 
GROUP BY YEAR(hire_date);
```

11. Show the highest paid employee in each country  
```sql
SELECT e.* 
FROM employees e 
WHERE salary = (
                 SELECT MAX(salary) 
                 FROM employees 
                 WHERE country=e.country
               );
```

12. Find number of PHD employees per department  
```sql
SELECT department, 
       COUNT(*) as num_of_phd_emps
FROM employees 
WHERE degree='PHD' 
GROUP BY department;
```

13. Find number of employees with each degree per country  
```sql
SELECT country, degree, COUNT(*) 
FROM employees 
GROUP BY country, degree;
```

14. Find employees with salary in the top 10%  
```sql
SELECT * 
FROM employees 
WHERE salary >= (
                  SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY salary) 
                  FROM employees
                );
```

15. Show employees with duplicate last names  
```sql
SELECT last_name, COUNT(*) AS cnt
FROM employees 
GROUP BY last_name 
HAVING cnt > 1;
```

16. Show employees hired on the same date  
```sql
SELECT hire_date, 
       COUNT(*) as hire_date_count
FROM employees 
GROUP BY hire_date 
HAVING hire_date_count > 1;
```

17. Show employees born on the same date  
```sql
SELECT date_of_birth, 
       COUNT(*) as cnt
FROM employees 
GROUP BY date_of_birth 
HAVING cnt > 1;
```

18. Find employees whose salary equals the maximum in their department  
```sql
SELECT * 
FROM employees e 
WHERE salary = (
                 SELECT MAX(salary) 
                 FROM employees 
                 WHERE department=e.department
               );
```

19. Find departments where the salary gap (max-min) is the largest  
```sql
SELECT department, 
       MAX(salary)-MIN(salary) AS gap 
FROM employees 
GROUP BY department 
ORDER BY gap DESC 
LIMIT 1;
```

20. Find the overall difference between highest and lowest average salaries across departments  
```sql
SELECT MAX(avg_salary)-MIN(avg_salary) 
FROM (
        SELECT department, 
        AVG(salary) AS avg_salary 
        FROM employees 
        GROUP BY department
     ) t;
```
