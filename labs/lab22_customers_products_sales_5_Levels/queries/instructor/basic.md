1. List all customers.
```sql
SELECT * FROM customers;
```

2. Show all products in the Electronics category.
```sql
SELECT * FROM products WHERE category = 'Electronics';
```

3. Find all sales paid by CASH.
```sql
SELECT * FROM sales WHERE sale_type = 'CASH';
```

4. List all distinct countries of customers.
```sql
SELECT DISTINCT country FROM customers;
```

5. Find names and ages of all customers from USA.
```sql
SELECT name, age FROM customers WHERE country = 'USA';
```

6. List customers older than 60.
```sql
SELECT * FROM customers WHERE age > 60;
```

7. Show products in Home or Garden categories.
```sql
SELECT * FROM products WHERE category IN ('Home','Garden');
```

8. Show sales that happened in 2024.
```sql
SELECT * FROM sales WHERE YEAR(sale_date) = 2024;
```

9. Find customers whose name starts with 'Customer1'.
```sql
SELECT * FROM customers WHERE name LIKE 'Customer1%';
```

10. List all FEMALE customers.
```sql
SELECT * FROM customers WHERE gender = 'FEMALE';
```

11. Get product with product_id = 5.
```sql
SELECT * FROM products WHERE product_id = 5;
```

12. Find sales where price > 300.
```sql
SELECT * FROM sales WHERE price > 300;
```

13. Show the 10 most expensive transactions.
```sql
SELECT * FROM sales ORDER BY price DESC LIMIT 10;
```

14. List customers from CANADA ordered by age descending.
```sql
SELECT * FROM customers WHERE country='CANADA' ORDER BY age DESC;
```

15. Find products whose name contains '5'.
```sql
SELECT * FROM products WHERE name LIKE '%5%';
```

16. Return the first 5 customers by customer_id.
```sql
SELECT * FROM customers ORDER BY customer_id ASC LIMIT 5;
```

17. Show sales made using CREDIT on or after 2023-01-01.
```sql
SELECT * FROM sales WHERE sale_type='CREDIT' AND sale_date >= '2023-01-01';
```

18. List all sales for customer_id = 7.
```sql
SELECT * FROM sales WHERE customer_id = 7;
```

19. Show all products not in the MISC category.
```sql
SELECT * FROM products WHERE category <> 'MISC';
```

20. Find customers aged between 25 and 35 inclusive.
```sql
SELECT * FROM customers WHERE age BETWEEN 25 AND 35;
```

