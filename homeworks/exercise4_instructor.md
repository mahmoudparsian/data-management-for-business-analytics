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

## Answers
1. SELECT * FROM orders;
2. SELECT customer, SUM(amount) FROM orders GROUP BY customer;
3. SELECT customer FROM (SELECT customer, SUM(amount) AS total FROM orders GROUP BY customer) t ORDER BY total DESC LIMIT 1;
4. SELECT AVG(amount) FROM orders;
5. WITH totals AS (SELECT customer, SUM(amount) AS total FROM orders GROUP BY customer) SELECT customer, total, RANK() OVER (ORDER BY total DESC) FROM totals;
6. SELECT order_id, customer, amount, RANK() OVER (ORDER BY amount DESC) FROM orders;
7. WITH totals AS (SELECT customer, SUM(amount) AS total FROM orders GROUP BY customer) SELECT customer, total FROM totals WHERE total > (SELECT AVG(total) FROM totals);


