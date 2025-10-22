# Teachers Table - Intermediate Queries (20)

1. Find average salary per degree.
```sql
SELECT degree, AVG(salary) AS avg_salary FROM teachers GROUP BY degree;
```

2. Find maximum salary per department.
```sql
SELECT department, MAX(salary) AS max_salary FROM teachers GROUP BY department;
```

3. Find minimum salary per school.
```sql
SELECT school, MIN(salary) AS min_salary FROM teachers GROUP BY school;
```

4. Count teachers per school.
```sql
SELECT school, COUNT(*) FROM teachers GROUP BY school;
```

5. Find total salary paid by each country.
```sql
SELECT country, SUM(salary) FROM teachers GROUP BY country;
```

6. Find average salary per department in MIT.
```sql
SELECT department, AVG(salary) FROM teachers WHERE school = 'MIT' GROUP BY department;
```

7. Find number of teachers per hire_year.
```sql
SELECT hire_year, COUNT(*) FROM teachers GROUP BY hire_year;
```

8. Find highest salary per country.
```sql
SELECT country, MAX(salary) FROM teachers GROUP BY country;
```

9. Find average salary per department per school.
```sql
SELECT school, department, AVG(salary) FROM teachers GROUP BY school, department;
```

10. Count number of PhD teachers per country.
```sql
SELECT country, COUNT(*) FROM teachers WHERE degree = 'PHD' GROUP BY country;
```

11. Show schools with average salary > 150,000.
```sql
SELECT school, AVG(salary) AS avg_salary FROM teachers GROUP BY school HAVING AVG(salary) > 150000;
```

12. Find departments with more than 10 teachers.
```sql
SELECT department, COUNT(*) AS num_teachers FROM teachers GROUP BY department HAVING COUNT(*) > 10;
```

13. Find average salary per school and order descending.
```sql
SELECT school, AVG(salary) FROM teachers GROUP BY school ORDER BY AVG(salary) DESC;
```

14. Count teachers per degree per country.
```sql
SELECT country, degree, COUNT(*) FROM teachers GROUP BY country, degree;
```

15. Find sum of salaries per school per year.
```sql
SELECT school, hire_year, SUM(salary) FROM teachers GROUP BY school, hire_year;
```

16. Find number of unique departments per school.
```sql
SELECT school, COUNT(DISTINCT department) FROM teachers GROUP BY school;
```

17. Find average salary per hire_year.
```sql
SELECT hire_year, AVG(salary) FROM teachers GROUP BY hire_year;
```

18. Find total salary per department per country.
```sql
SELECT department, country, SUM(salary) FROM teachers GROUP BY department, country;
```

19. Find number of MBA teachers per department.
```sql
SELECT department, COUNT(*) FROM teachers WHERE degree = 'MBA' GROUP BY department;
```

20. Find schools with more than 3 departments.
```sql
SELECT school, COUNT(DISTINCT department) FROM teachers GROUP BY school HAVING COUNT(DISTINCT department) > 3;
```
