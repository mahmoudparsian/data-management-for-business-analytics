# Teachers Table - Basic to Intermediate Queries (20)

1. Find all teachers.
```sql
SELECT * FROM teachers;
```

2. Find first and last names of all teachers.
```sql
SELECT first_name, last_name FROM teachers;
```

3. List all unique schools.
```sql
SELECT DISTINCT school FROM teachers;
```

4. Find teachers with salary greater than 150,000.
```sql
SELECT * FROM teachers WHERE salary > 150000;
```

5. Find teachers hired in 2020.
```sql
SELECT * FROM teachers WHERE hire_year = 2020;
```

6. Find teachers from the USA.
```sql
SELECT * FROM teachers WHERE country = 'USA';
```

7. Count teachers in the Computer Science department.
```sql
SELECT COUNT(*) FROM teachers WHERE department = 'Computer Science';
```

8. Show names and salaries of teachers in Stanford.
```sql
SELECT first_name, last_name, salary FROM teachers WHERE school = 'Stanford';
```

9. Find teachers earning exactly 200,000.
```sql
SELECT * FROM teachers WHERE salary = 200000;
```

10. Show teachers with degree = PHD.
```sql
SELECT * FROM teachers WHERE degree = 'PHD';
```

11. Order teachers by salary descending.
```sql
SELECT first_name, last_name, salary FROM teachers ORDER BY salary DESC;
```

12. Find the youngest hire year.
```sql
SELECT MIN(hire_year) FROM teachers;
```

13. Find the oldest hire year.
```sql
SELECT MAX(hire_year) FROM teachers;
```

14. Show teachers hired between 2010 and 2015.
```sql
SELECT * FROM teachers WHERE hire_year BETWEEN 2010 AND 2015;
```

15. Find teachers not from USA.
```sql
SELECT * FROM teachers WHERE country <> 'USA';
```

16. Find teachers with salary between 120,000 and 140,000.
```sql
SELECT * FROM teachers WHERE salary BETWEEN 120000 AND 140000;
```

17. Show teachers whose last name starts with "S".
```sql
SELECT * FROM teachers WHERE last_name LIKE 'S%';
```

18. Find all unique departments.
```sql
SELECT DISTINCT department FROM teachers;
```

19. Show number of teachers per country.
```sql
SELECT country, COUNT(*) FROM teachers GROUP BY country;
```

20. Show average salary per school.
```sql
SELECT school, AVG(salary) FROM teachers GROUP BY school;
```
