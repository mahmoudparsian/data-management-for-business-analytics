# 20 Basic Queries (Instructor)

**1. List all cats.**

```sql
SELECT * 
FROM cats;
```

**2. Show all breeds.**

```sql
SELECT * 
FROM breeds;
```

**3. Find names and ages of all cats.**

```sql
SELECT name, age 
FROM cats;
```

**4. Find all cats older than 5.**

```sql
SELECT * 
FROM cats 
WHERE age > 5;
```

**5. Find all cats from USA.**

```sql
SELECT * 
FROM cats 
WHERE country='USA';
```

**6. List all female cats.**

```sql
SELECT * 
FROM cats 
WHERE gender='FEMALE';
```

**7. List all male cats.**

```sql
SELECT * 
FROM cats 
WHERE gender='MALE';
```

**8. Find cats with more than 5 tricks.**

```sql
SELECT * 
FROM cats 
WHERE num_of_tricks > 5;
```

**9. Find the youngest cat.**

```sql
SELECT * 
FROM cats 
ORDER BY age ASC 
LIMIT 1;
```

**10. Find the oldest cat.**

```sql
SELECT * 
FROM cats 
ORDER BY age DESC 
LIMIT 1;
```

**11. Count total number of cats.**

```sql
SELECT COUNT(*) 
FROM cats;
```

**12. Find cats with missing age values.**

```sql
SELECT * 
FROM cats 
WHERE age IS NULL;
```

**13. List cats whose name starts with 'M'.**

```sql
SELECT * 
FROM cats 
WHERE name LIKE 'M%';
```

**14. List cats whose name ends with 'y'.**

```sql
SELECT * 
FROM cats 
WHERE name LIKE '%y';
```

**15. Find cats born after 2020.**

```sql
SELECT * 
FROM cats 
WHERE date_of_birth > '2020-01-01';
```

**16. Find distinct countries of cats.**

```sql
SELECT DISTINCT country 
FROM cats;
```

**17. Find distinct breeds of cats.**

```sql
SELECT DISTINCT breed 
FROM cats;
```

**18. Find all cats sorted by age ascending.**

```sql
SELECT * 
FROM cats 
ORDER BY age ASC;
```

**19. Find first 5 cats in the table.**

```sql
SELECT * 
FROM cats 
LIMIT 5;
```

**20. Find cats with exactly 3 tricks.**

```sql
SELECT * 
FROM cats 
WHERE num_of_tricks = 3;
```

