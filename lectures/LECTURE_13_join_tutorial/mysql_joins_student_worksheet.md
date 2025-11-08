# MySQL Joins – Student Worksheet

## Schema
```sql
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(30),
  country VARCHAR(20)
);

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  product VARCHAR(30),
  amount DECIMAL(10,2)
);
```

## Exercises
1. List all customers and their orders using an INNER JOIN.
2. Show all customers even if they have no orders (LEFT JOIN).
3. Show all orders even if the customer has been deleted (RIGHT JOIN).
