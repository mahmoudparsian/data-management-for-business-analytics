# MySQL Joins – Teacher Answer Key

## Answers

### 1. INNER JOIN
```sql
SELECT c.name, o.product, o.amount
FROM customers c
INNER JOIN orders o
  ON c.customer_id = o.customer_id;
```

### 2. LEFT JOIN
```sql
SELECT c.name, o.product, o.amount
FROM customers c
LEFT JOIN orders o
  ON c.customer_id = o.customer_id;
```

### 3. RIGHT JOIN
```sql
SELECT c.name, o.product, o.amount
FROM customers c
RIGHT JOIN orders o
  ON c.customer_id = o.customer_id;
```
