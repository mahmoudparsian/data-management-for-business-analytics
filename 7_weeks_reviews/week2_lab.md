# Week 2 — Aggregation, GROUP BY, HAVING

## Slides (20)
#### Slide 1: Aggregation Overview
- COUNT, SUM, AVG, MIN, MAX
- When to aggregate

#### Slide 2: GROUP BY Rules
- Select list vs grouped columns
- Functional dependencies (intuition)

#### Slide 3: HAVING vs WHERE
- Filter before vs after aggregation
- Common mistakes

#### Slide 4: Multi-Column GROUP BY
- Country, Age examples
- Ordering after grouping

#### Slide 5: DISTINCT & Aggregates
- COUNT(DISTINCT ...)
- Use cases

#### Slide 6: Derived Columns & Aliases
- Naming aggregates
- Reusing in ORDER BY

#### Slide 7: Bucketing with CASE
- Age buckets
- Score bands

#### Slide 8: Top-N Per Group (Preview)
- Patterns without windows
- LIMIT caveats

#### Slide 9: NULLs with Aggregates
- COUNT(*) vs COUNT(col)
- AVG ignores NULLs

#### Slide 10: Percentiles
- PERCENTILE_CONT in MySQL 8
- Alternatives

#### Slide 11: Text Functions Recap
- LEFT/RIGHT/LENGTH
- TRUNCATE/ROUND

#### Slide 12: Performance Notes
- Index selection matters
- Avoid SELECT * in groups

#### Slide 13: Style & Readability
- Column aliases
- Formatting

#### Slide 14: EXPLAIN (High Level)
- What to look for
- Rows & key usage

#### Slide 15: Real Analytics Examples
- Per-country averages
- Top cohorts

#### Slide 16: Common Errors
- Mixing grouped & ungrouped cols improperly

#### Slide 17: Lab Tips
- Build query in layers
- Validate intermediate results

#### Slide 18: Testing
- Use LIMIT to inspect
- Sanity checks

#### Slide 19: Edge Cases
- Singleton groups
- Skewed data

#### Slide 20: Summary
- Key distinctions & next steps


## Lab: 40 Queries (English → SQL)

1. Count total number of students
```sql
SELECT COUNT(*) AS total FROM students;
```

2. Compute average GPA overall
```sql
SELECT AVG(gpa) AS avg_gpa FROM students;
```

3. Find minimum and maximum GPA
```sql
SELECT MIN(gpa) AS min_gpa, MAX(gpa) AS max_gpa FROM students;
```

4. Count students per country
```sql
SELECT country, COUNT(*) AS cnt FROM students GROUP BY country;
```

5. Average GPA per country
```sql
SELECT country, AVG(gpa) AS avg_gpa FROM students GROUP BY country;
```

6. Average age per country, sorted by avg age desc
```sql
SELECT country, AVG(age) AS avg_age FROM students GROUP BY country ORDER BY avg_age DESC;
```

7. Return only countries with more than 8 students
```sql
SELECT country, COUNT(*) AS cnt FROM students GROUP BY country HAVING COUNT(*) > 8;
```

8. Country with the highest average GPA
```sql
SELECT country, AVG(gpa) AS avg_gpa FROM students GROUP BY country ORDER BY avg_gpa DESC LIMIT 1;
```

9. Count distinct last names
```sql
SELECT COUNT(DISTINCT last_name) AS unique_last FROM students;
```

10. Top 3 countries by headcount
```sql
SELECT country, COUNT(*) AS cnt FROM students GROUP BY country ORDER BY cnt DESC LIMIT 3;
```

11. Average GPA of 20-year-olds grouped by country
```sql
SELECT country, AVG(gpa) FROM students WHERE age=20 GROUP BY country;
```

12. Count of students per age
```sql
SELECT age, COUNT(*) FROM students GROUP BY age ORDER BY age;
```

13. Maximum GPA for each age
```sql
SELECT age, MAX(gpa) FROM students GROUP BY age;
```

14. Return ages that appear more than 7 times
```sql
SELECT age, COUNT(*) FROM students GROUP BY age HAVING COUNT(*) > 7;
```

15. Group by (country, age) and keep only groups with avg(gpa) > 3.20
```sql
SELECT country, age, AVG(gpa) AS avg_gpa FROM students GROUP BY country, age HAVING AVG(gpa) > 3.20;
```

16. Sum of GPAs per country (demo purpose)
```sql
SELECT country, SUM(gpa) AS sum_gpa FROM students GROUP BY country;
```

17. Per-country rollup: count, avg_gpa, min_gpa, max_gpa
```sql
SELECT country, COUNT(*) AS cnt, AVG(gpa) AS avg_gpa, MIN(gpa) AS min_gpa, MAX(gpa) AS max_gpa FROM students GROUP BY country;
```

18. Median GPA overall (MySQL 8 PERCENTILE_CONT)
```sql
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY gpa) AS median_gpa FROM students;
```

19. Top 2 last names by frequency
```sql
SELECT last_name, COUNT(*) AS cnt FROM students GROUP BY last_name ORDER BY cnt DESC, last_name LIMIT 2;
```

20. Frequency of first letter in last_name
```sql
SELECT LEFT(last_name,1) AS initial, COUNT(*) FROM students GROUP BY initial ORDER BY initial;
```

21. Count by (country, first-letter-of-last-name)
```sql
SELECT country, LEFT(last_name,1) AS init, COUNT(*) FROM students GROUP BY country, init;
```

22. Average GPA for USA and INDIA only
```sql
SELECT country, AVG(gpa) FROM students WHERE country IN ('USA','INDIA') GROUP BY country;
```

23. Return ages whose average GPA is at least 3.00
```sql
SELECT age, AVG(gpa) AS avg FROM students GROUP BY age HAVING AVG(gpa) >= 3.00;
```

24. Group students by GPA truncated to 1 decimal
```sql
SELECT TRUNCATE(gpa,1) AS g1, COUNT(*) FROM students GROUP BY g1 ORDER BY g1;
```

25. Which age has the highest average GPA?
```sql
SELECT age, AVG(gpa) AS avg FROM students GROUP BY age ORDER BY avg DESC LIMIT 1;
```

26. Countries where the maximum GPA exceeds 3.80
```sql
SELECT country FROM students GROUP BY country HAVING MAX(gpa) > 3.80;
```

27. Country with the lowest GPA overall (via MIN and ORDER)
```sql
SELECT country, MIN(gpa) AS min_g FROM students GROUP BY country ORDER BY min_g ASC LIMIT 1;
```

28. Bucketize ages and count students per bucket
```sql
SELECT CASE WHEN age<=19 THEN '≤19' WHEN age BETWEEN 20 AND 21 THEN '20-21' ELSE '22-24' END AS bucket, COUNT(*) FROM students GROUP BY bucket;
```

29. Average GPA per age bucket
```sql
SELECT CASE WHEN age<=19 THEN '≤19' WHEN age BETWEEN 20 AND 21 THEN '20-21' ELSE '22-24' END AS bucket, AVG(gpa) FROM students GROUP BY bucket;
```

30. Top-3 countries by maximum GPA
```sql
SELECT country, MAX(gpa) AS max_g FROM students GROUP BY country ORDER BY max_g DESC LIMIT 3;
```

31. Bottom-3 countries by average GPA
```sql
SELECT country, AVG(gpa) AS avg_g FROM students GROUP BY country ORDER BY avg_g ASC LIMIT 3;
```

32. Count of students with GPA ≥ 3.5 per country
```sql
SELECT country, SUM(gpa >= 3.5) AS cnt FROM students GROUP BY country;
```

33. Overall standard deviation of GPA
```sql
SELECT STDDEV_POP(gpa) AS s FROM students;
```

34. Average GPA (rounded to 2 decimals) per country
```sql
SELECT country, ROUND(AVG(gpa),2) AS avg2 FROM students GROUP BY country;
```

35. Percent share of students by country
```sql
SELECT country, COUNT(*)*100.0/(SELECT COUNT(*) FROM students) AS pct FROM students GROUP BY country;
```

36. Top 5 (country, age) groups by size
```sql
SELECT country, age, COUNT(*) AS cnt FROM students GROUP BY country, age ORDER BY cnt DESC LIMIT 5;
```

37. How many ages have more than 5 students?
```sql
SELECT COUNT(*) FROM (SELECT age FROM students GROUP BY age HAVING COUNT(*) > 5) AS t;
```

38. Return ages whose average GPA is between 3.10 and 3.40
```sql
SELECT age, AVG(gpa) AS avg FROM students GROUP BY age HAVING AVG(gpa) BETWEEN 3.10 AND 3.40;
```

39. List ages by average GPA (descending) and show top 10
```sql
SELECT age, AVG(gpa) AS avg FROM students GROUP BY age ORDER BY avg DESC LIMIT 10;
```

40. Order countries by student count desc, then by avg_gpa desc
```sql
SELECT country, COUNT(*) AS cnt, AVG(gpa) AS avg FROM students GROUP BY country ORDER BY cnt DESC, avg DESC;
```
