1. List all cats.

```sql
SELECT * 
FROM cats;
```

2. Show cat names and breeds.

```sql
SELECT name, breed 
FROM cats;
```

3. Find cats from USA.

```sql
SELECT * 
FROM cats 
WHERE country='USA';
```

4. Find female cats.

```sql
SELECT * 
FROM cats 
WHERE gender='FEMALE';
```

5. Cats older than 5.

```sql
SELECT * 
FROM cats 
WHERE age > 5;
```

6. Cats with at least 5 tricks.

```sql
SELECT * 
FROM cats 
WHERE num_of_tricks >= 5;
```

7. Cats born in 2020.

YEAR function:

```
mysql> select YEAR('2021-01-08');
+--------------------+
| YEAR('2021-01-08') |
+--------------------+
|               2021 |
+--------------------+
1 row in set (0.01 sec)

mysql> select YEAR('2025-10-10');
+--------------------+
| YEAR('2025-10-10') |
+--------------------+
|               2025 |
+--------------------+
1 row in set (0.00 sec)
```


```sql
SELECT * 
FROM cats 
WHERE YEAR(date_of_birth) = 2020;
```

8. List distinct countries represented.

```sql
SELECT DISTINCT country 
FROM cats;
```

9. Find cats named 'Luna'.

```sql
SELECT * 
FROM cats 
WHERE name = 'Luna';
```

10. Top 10 youngest by age (ascending age, then id).

```sql
SELECT * 
FROM cats 
ORDER BY age ASC, id ASC 
LIMIT 10;
```

11. Cats not from GERMANY.

```sql
SELECT * 
FROM cats 
WHERE country <> 'GERMANY';
```

12. Find all male Bengals.

```sql
SELECT * 
FROM cats 
WHERE (breed = 'Bengal') AND 
      (gender = 'MALE');
```

13. Breeds in the dataset.

```sql
SELECT DISTINCT breed 
FROM cats;
```

14. Find cats whose name starts with 'M'.

```sql
SELECT * 
FROM cats 
WHERE name LIKE 'M%';
```

15. Find cats born after 2022-01-01.

```sql
SELECT * 
FROM cats 
WHERE date_of_birth > '2022-01-01';
```

16. Cats with 0 tricks.

```sql
SELECT * 
FROM cats 
WHERE num_of_tricks = 0;
```

17. Count how many cats are named 'Leo'.

```sql
SELECT COUNT(*) 
FROM cats 
WHERE name = 'Leo';
```

18. Show the 5 most recent DOBs.

```sql
SELECT * 
FROM cats 
ORDER BY date_of_birth DESC 
LIMIT 5;
```

19. List cats with age between 3 and 7 inclusive.

solution-1:

```sql
SELECT * 
FROM cats 
WHERE age BETWEEN 3 AND 7;
```

solution-2:

```sql
SELECT * 
FROM cats 
WHERE (age >= 3) AND (age <= 7);
```

20. Find cats from CANADA or FRANCE.

solution-1:

```sql
SELECT * 
FROM cats 
WHERE country IN ('CANADA','FRANCE');
```

solution-2:

```sql
SELECT * 
FROM cats 
WHERE (country = 'CANADA') OR
      (country = 'FRANCE');
```