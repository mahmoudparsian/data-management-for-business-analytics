# 20 Basic SQL Tasks (SELECT / INSERT / UPDATE / DELETE)

> Table: `teachers(id, first_name, last_name, degree, school, department, hire_year, hire_date, salary, country)`

1. **List first 10 teachers (all columns)**  
```sql
SELECT * FROM teachers LIMIT 10;
```

2. **Show first/last name and school for 10 rows**  
```sql
SELECT first_name, last_name, school FROM teachers LIMIT 10;
```

3. **Insert a new teacher**  
```sql
INSERT INTO teachers (id, first_name, last_name, degree, school, department, hire_year, hire_date, salary, country)
VALUES (10001,'Ada','Lovelace','PHD','MIT','Computer Science',2024,'2024-09-01',180000,'UK');
```

4. **Update salary for a specific id**  
```sql
UPDATE teachers SET salary = 190000 WHERE id = 10001;
```

5. **Delete a specific teacher**  
```sql
DELETE FROM teachers WHERE id = 10001;
```

6. **Find all PHDs**  
```sql
SELECT id, first_name, last_name FROM teachers WHERE degree='PHD' LIMIT 20;
```

7. **Find teachers hired after 2020**  
```sql
SELECT id, first_name, last_name, hire_date FROM teachers WHERE hire_date > '2020-12-31' LIMIT 20;
```

8. **Teachers from USA making over 150k**  
```sql
SELECT first_name, last_name, salary FROM teachers WHERE country='USA' AND salary > 150000 LIMIT 20;
```

9. **Teachers with last name starting with 'Sm'**  
```sql
SELECT id, first_name, last_name FROM teachers WHERE last_name LIKE 'Sm%' LIMIT 20;
```

10. **Order by salary descending (top 10)**  
```sql
SELECT id, first_name, last_name, salary FROM teachers ORDER BY salary DESC LIMIT 10;
```

11. **Order by hire_date ascending (first 10)**  
```sql
SELECT id, first_name, last_name, hire_date FROM teachers ORDER BY hire_date ASC LIMIT 10;
```

12. **Change department for one teacher**  
```sql
UPDATE teachers SET department='Data Science' WHERE id=5;
```

13. **Give 5% raise to all 'Engineering'**  
```sql
UPDATE teachers SET salary = ROUND(salary*1.05) WHERE department='Engineering';
```

14. **Delete all rows from a specific school (demo)**  
```sql
-- Be careful! This is destructive; typically do this in a test DB.
DELETE FROM teachers WHERE school='ISU' AND id > 20000; -- adjust condition to be safe
```

15. **Reinsert one deleted row (demo)**  
```sql
INSERT INTO teachers VALUES (20001,'Test','Teacher','MS','ISU','Business',2021,'2021-08-15',130000,'USA');
```

16. **Select teachers in schools MIT or Harvard**  
```sql
SELECT id, first_name, last_name, school FROM teachers WHERE school IN ('MIT','Harvard') LIMIT 20;
```

17. **Select non-USA teachers**  
```sql
SELECT id, country FROM teachers WHERE country <> 'USA' LIMIT 20;
```

18. **Teachers hired in 2024**  
```sql
SELECT id, first_name, last_name, hire_date FROM teachers WHERE hire_year = 2024 LIMIT 20;
```

19. **Find any salaries outside the policy range (sanity check)**  
```sql
SELECT id, salary FROM teachers WHERE salary < 100000 OR salary > 200000;
```

20. **Undo a raise (demo rollback by opposite update)**  
```sql
UPDATE teachers SET salary = ROUND(salary/1.05) WHERE department='Engineering';
```
