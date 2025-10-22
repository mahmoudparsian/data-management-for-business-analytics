# MySQL Exercise

## Schema and Sample Data

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer VARCHAR(30),
    amount DECIMAL(10,2)
);

INSERT INTO orders VALUES
(1, 'Alice', 300),
(2, 'Bob', 150),
(3, 'Charlie', 200),
(4, 'Alice', 400),
(5, 'Bob', 500),
(6, 'Charlie', 250);
```

## Questions
1. Select all orders.
2. Find total amount spent by each customer (use GROUP BY).
3. Find the customer with the maximum total amount (use subquery).
4. Find average order amount.
5. Rank customers by their total spending (use RANK()).
6. Rank orders by amount (highest to lowest).
7. Find customers who spent more than the average spending.
