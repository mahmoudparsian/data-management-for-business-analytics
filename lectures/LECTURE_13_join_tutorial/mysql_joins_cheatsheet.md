# MySQL JOIN Cheat Sheet

## INNER JOIN
Returns matching rows in both tables.

```sql
SELECT * FROM A
INNER JOIN B ON A.id = B.id;
```

## LEFT JOIN
Returns all rows from left table, even without matches.

```sql
SELECT * FROM A
LEFT JOIN B ON A.id = B.id;
```

## RIGHT JOIN
Returns all rows from right table.

```sql
SELECT * FROM A
RIGHT JOIN B ON A.id = B.id;
```
