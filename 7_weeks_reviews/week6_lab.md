# Week 6 — Window Functions: ROW_NUMBER, RANK, DENSE_RANK, LAG/LEAD

## Slides (20)
#### Slide 1: Window Function Basics
- OVER(), PARTITION BY, ORDER BY

#### Slide 2: ROW_NUMBER vs RANK
- Ties handling
- Use-cases

#### Slide 3: DENSE_RANK
- No gaps with ties

#### Slide 4: Aggregates as Windows
- AVG() OVER
- SUM() OVER

#### Slide 5: Frames
- ROWS/RANGE
- Moving averages

#### Slide 6: LAG/LEAD
- Access previous/next rows

#### Slide 7: NTH_VALUE/First/Last
- NTH_VALUE()
- FIRST_VALUE()

#### Slide 8: Rank Top-N per Group
- ROW_NUMBER+filter
- vs QUALIFY

#### Slide 9: Mix with Aggregations
- Delta from group avg
- Z-scores

#### Slide 10: Windows + Joins
- Compute then join

#### Slide 11: Performance
- Sort costs
- Indexing join keys

#### Slide 12: Style & Testing
- Small result first
- Check partitions

#### Slide 13: Edge Cases
- Empty partitions
- Nulls in ORDER BY

#### Slide 14: Common Mistakes
- Forgetting ORDER BY in window

#### Slide 15: Debugging
- Compare window to grouped

#### Slide 16: Practical Patterns
- Top-k per dept
- Cohort ranks

#### Slide 17: Alternatives
- Self-joins for running totals

#### Slide 18: Reading Plans
- Filesorts
- Temp tables

#### Slide 19: Lab Tips
- Incrementally build windows

#### Slide 20: Summary
- What to practice next


## Lab: 40 Queries (English → SQL)

1. Global salary RANK()
```sql
SELECT emp_id, first_name, salary, RANK() OVER(ORDER BY salary DESC) AS rnk FROM employees;
```

2. Global salary DENSE_RANK()
```sql
SELECT emp_id, salary, DENSE_RANK() OVER(ORDER BY salary DESC) AS dr FROM employees;
```

3. ROW_NUMBER() within each department
```sql
SELECT emp_id, dept_id, ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rn FROM employees;
```

4. Top 3 per department
```sql
SELECT * FROM (SELECT e.*, ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) rn FROM employees e) t WHERE rn<=3;
```

5. Window example 1
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

6. Window example 2
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

7. Window example 3
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

8. Window example 4
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

9. Window example 5
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

10. Window example 6
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

11. Window example 7
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

12. Window example 8
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

13. Window example 9
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

14. Window example 10
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

15. Window example 11
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

16. Window example 12
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

17. Window example 13
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

18. Window example 14
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

19. Window example 15
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

20. Window example 16
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

21. Window example 17
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

22. Window example 18
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

23. Window example 19
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

24. Window example 20
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

25. Window example 21
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

26. Window example 22
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

27. Window example 23
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

28. Window example 24
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

29. Window example 25
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

30. Window example 26
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

31. Window example 27
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

32. Window example 28
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

33. Window example 29
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

34. Window example 30
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

35. Window example 31
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

36. Window example 32
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

37. Window example 33
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

38. Window example 34
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

39. Window example 35
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```

40. Window example 36
```sql
SELECT emp_id, dept_id, (salary-AVG(salary) OVER(PARTITION BY dept_id))/NULLIF(STDDEV_POP(salary) OVER(PARTITION BY dept_id),0) AS z FROM employees;
```
