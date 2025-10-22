# Week 4 — Joins Part 2: FULL OUTER (via UNION), SELF JOIN, Multi-joins

## Slides (20)
#### Slide 1: FULL OUTER in MySQL
- UNION of LEFT and RIGHT
- COALESCE keys

#### Slide 2: Self Joins
- When to self-join
- Common patterns

#### Slide 3: Anti/Semi Joins
- LEFT JOIN ... IS NULL
- EXISTS/NOT EXISTS

#### Slide 4: Multi-Table Joins
- Three or more tables
- Readability & order

#### Slide 5: Detecting Duplicates
- Pairs & gaps
- GROUP BY HAVING COUNT>1

#### Slide 6: Conditional Joins
- REGEXP on names
- Range conditions

#### Slide 7: Join + Aggregate
- Per-dept rollups
- Per-country rollups

#### Slide 8: NULL Handling
- WHERE vs ON
- Ordering NULLs

#### Slide 9: Performance
- Indexes on keys
- Avoid cartesian

#### Slide 10: Debugging
- Build progressively
- Check intermediate outputs

#### Slide 11: Data Quality Checks
- Orphans
- Missing references

#### Slide 12: Advanced Conditions
- REGEXP, functions in ON/WHERE

#### Slide 13: Practical Cases
- Top earners per dept
- Mentor matching

#### Slide 14: Anti-Patterns
- SELECT * everywhere
- Implicit casts

#### Slide 15: Docs & Help
- MySQL manual
- EXPLAIN, SHOW WARNINGS

#### Slide 16: Security Basics
- Least privilege
- Avoid injection

#### Slide 17: Transactions
- ACID recap
- When joins meet writes

#### Slide 18: Views (Preview)
- Encapsulate joins
- Security & reuse

#### Slide 19: Lab Tips
- Start with INNER, widen to LEFT/RIGHT

#### Slide 20: Summary
- Checklist before submission


## Lab: 40 Queries (English → SQL)

1. Simulate FULL OUTER JOIN to list all (department, employee) pairs
```sql
SELECT d.dept_id, d.dept_name, e.emp_id, e.first_name
FROM departments d
LEFT JOIN employees e ON e.dept_id=d.dept_id
UNION
SELECT d.dept_id, d.dept_name, e.emp_id, e.first_name
FROM departments d
RIGHT JOIN employees e ON e.dept_id=d.dept_id;
```

2. List employees who have no matching department (diagnostic)
```sql
SELECT e.* FROM employees e LEFT JOIN departments d ON e.dept_id=d.dept_id WHERE d.dept_id IS NULL;
```

3. List departments that currently have no employees (diagnostic)
```sql
SELECT d.* FROM departments d LEFT JOIN employees e ON e.dept_id=d.dept_id WHERE e.emp_id IS NULL;
```

4. Self-join: list pairs of employees in the same department (a<b to avoid duplicates)
```sql
SELECT e1.emp_id AS emp_a, e2.emp_id AS emp_b, e1.dept_id FROM employees e1 JOIN employees e2 ON e1.dept_id=e2.dept_id AND e1.emp_id<e2.emp_id;
```

5. Self-join: potential mentors where salary gap within same dept is ≥ 30,000
```sql
SELECT m.emp_id AS mentor, j.emp_id AS junior, m.dept_id FROM employees m JOIN employees j ON m.dept_id=j.dept_id AND m.salary - j.salary >= 30000;
```

6. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

7. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

8. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

9. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

10. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

11. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

12. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

13. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

14. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

15. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

16. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

17. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

18. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

19. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

20. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

21. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

22. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

23. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

24. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

25. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

26. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

27. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

28. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

29. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

30. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

31. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

32. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

33. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

34. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

35. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

36. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

37. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

38. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

39. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```

40. Variant — employees with department (salary >= 150k)
```sql
SELECT e.emp_id, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.salary >= 150000;
```
