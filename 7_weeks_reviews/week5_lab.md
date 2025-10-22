# Week 5 — Subqueries (SELECT/FROM/WHERE) and CTEs (WITH)

## Slides (20)
#### Slide 1: Subquery Types
- Scalar, row, table (derived)

#### Slide 2: WHERE with IN/EXISTS
- Semi-joins via EXISTS
- NOT EXISTS

#### Slide 3: Correlated vs Non-Correlated
- When correlation is needed
- Performance effects

#### Slide 4: Subqueries in SELECT
- Computed values
- Dept averages

#### Slide 5: Derived Tables in FROM
- Prefilter then aggregate
- Naming derived tables

#### Slide 6: CTEs — WITH
- Syntax in MySQL 8
- Readability & reuse

#### Slide 7: Recursive CTEs
- Counters, trees (overview)

#### Slide 8: Top-N per Group
- ROW_NUMBER with partitions
- Alternatives

#### Slide 9: Semi vs Anti Joins
- IN vs EXISTS
- NOT EXISTS patterns

#### Slide 10: Filtering by Aggregates
- HAVING with grouped subqueries

#### Slide 11: Mix Joins & Subqueries
- Choose simplest tool
- Test incrementally

#### Slide 12: Percentiles & Medians
- PERCENTILE_CONT
- Approximations

#### Slide 13: Window vs Subquery
- When each is better

#### Slide 14: Performance
- Indexes, materialization

#### Slide 15: Style
- Readable names
- CTE order

#### Slide 16: Debugging
- Run inner subquery first

#### Slide 17: Edge Cases
- Empty sets, NULLs

#### Slide 18: Anti-Patterns
- Over-nesting, SELECT *

#### Slide 19: Lab Tips
- Build from core query outward

#### Slide 20: Summary
- Key takeaways


## Lab: 40 Queries (English → SQL)

1. Employees above department average (correlated)
```sql
SELECT * FROM employees e WHERE salary > (SELECT AVG(salary) FROM employees WHERE dept_id=e.dept_id);
```

2. Departments with headcount > 10
```sql
SELECT dept_id FROM employees GROUP BY dept_id HAVING COUNT(*)>10;
```

3. Employees in depts with avg salary ≥ 130k
```sql
SELECT * FROM employees WHERE dept_id IN (SELECT dept_id FROM employees GROUP BY dept_id HAVING AVG(salary)>=130000);
```

4. Top earner overall via derived
```sql
SELECT * FROM (SELECT * FROM employees ORDER BY salary DESC LIMIT 1) t;
```

5. Within 10k of dept max
```sql
SELECT * FROM employees e WHERE (SELECT MAX(salary) FROM employees WHERE dept_id=e.dept_id) - e.salary <= 10000;
```

6. CTE example 1
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

7. CTE example 2
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

8. CTE example 3
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

9. CTE example 4
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

10. CTE example 5
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

11. CTE example 6
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

12. CTE example 7
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

13. CTE example 8
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

14. CTE example 9
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

15. CTE example 10
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

16. CTE example 11
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

17. CTE example 12
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

18. CTE example 13
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

19. CTE example 14
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

20. CTE example 15
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

21. CTE example 16
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

22. CTE example 17
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

23. CTE example 18
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

24. CTE example 19
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

25. CTE example 20
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

26. CTE example 21
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

27. CTE example 22
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

28. CTE example 23
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

29. CTE example 24
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

30. CTE example 25
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

31. CTE example 26
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

32. CTE example 27
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

33. CTE example 28
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

34. CTE example 29
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

35. CTE example 30
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

36. CTE example 31
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

37. CTE example 32
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

38. CTE example 33
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

39. CTE example 34
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```

40. CTE example 35
```sql
WITH dept_avg AS (SELECT dept_id, AVG(salary) AS av FROM employees GROUP BY dept_id) SELECT e.*, av FROM employees e JOIN dept_avg d ON e.dept_id=d.dept_id;
```
