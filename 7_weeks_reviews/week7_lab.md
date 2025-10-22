# Week 7 — Capstone: Customers, Products, Orders

## Slides (20)
#### Slide 1: Schema Review
- customers, products, orders

#### Slide 2: Business KPIs
- Revenue, AOV, Quantity

#### Slide 3: Joining Three Tables
- Join order & correctness

#### Slide 4: Revenue Math
- price * quantity

#### Slide 5: Time Buckets
- DATE_FORMAT('%Y-%m')
- Grouping by month/day

#### Slide 6: Top-N
- Top customers/products
- Windows vs subqueries

#### Slide 7: Cohorts
- First order date
- Retention basics

#### Slide 8: Country Segments
- Group by country
- Compare AOV

#### Slide 9: Outliers & Quality
- Zero orders, missing refs

#### Slide 10: Views (Preview)
- Reusable reports

#### Slide 11: Indexing
- FKs and join keys

#### Slide 12: Security
- Least privilege
- Read-only roles

#### Slide 13: Transactions (High level)
- ACID & reporting

#### Slide 14: Dimensional Modeling (Preview)
- Facts & dimensions

#### Slide 15: Performance Tips
- Limit data early
- Avoid SELECT *

#### Slide 16: Testing
- Cross-check totals

#### Slide 17: Debugging
- Build query layers

#### Slide 18: Deliverables
- Tables & queries needed

#### Slide 19: Lab Tips
- Document assumptions

#### Slide 20: Wrap-Up
- What to study next


```sql
CREATE TABLE customers (cust_id INT PRIMARY KEY, cust_name VARCHAR(40), country VARCHAR(20));
CREATE TABLE products  (prod_id INT PRIMARY KEY, prod_name VARCHAR(40), price INT);
CREATE TABLE orders    (order_id INT PRIMARY KEY, cust_id INT, prod_id INT, quantity INT, order_date DATE);

```

```sql
INSERT INTO customers(cust_id,cust_name,country) VALUES
(1,'Cust1','CANADA'),
(2,'Cust2','CANADA'),
(3,'Cust3','GERMANY'),
(4,'Cust4','CANADA'),
(5,'Cust5','GERMANY'),
(6,'Cust6','USA'),
(7,'Cust7','USA'),
(8,'Cust8','USA'),
(9,'Cust9','INDIA'),
(10,'Cust10','INDIA'),
(11,'Cust11','INDIA'),
(12,'Cust12','GERMANY'),
(13,'Cust13','USA'),
(14,'Cust14','GERMANY'),
(15,'Cust15','GERMANY'),
(16,'Cust16','GERMANY'),
(17,'Cust17','GERMANY'),
(18,'Cust18','USA'),
(19,'Cust19','CANADA'),
(20,'Cust20','CANADA'),
(21,'Cust21','CANADA'),
(22,'Cust22','INDIA'),
(23,'Cust23','USA'),
(24,'Cust24','CANADA'),
(25,'Cust25','CANADA'),
(26,'Cust26','GERMANY'),
(27,'Cust27','USA'),
(28,'Cust28','INDIA'),
(29,'Cust29','CANADA'),
(30,'Cust30','CANADA'),
(31,'Cust31','USA'),
(32,'Cust32','USA'),
(33,'Cust33','INDIA'),
(34,'Cust34','GERMANY'),
(35,'Cust35','USA'),
(36,'Cust36','GERMANY'),
(37,'Cust37','INDIA'),
(38,'Cust38','CANADA'),
(39,'Cust39','USA'),
(40,'Cust40','GERMANY');
```

```sql
INSERT INTO products(prod_id,prod_name,price) VALUES
(1,'Prod1',308),
(2,'Prod2',160),
(3,'Prod3',365),
(4,'Prod4',27),
(5,'Prod5',348),
(6,'Prod6',123),
(7,'Prod7',266),
(8,'Prod8',454),
(9,'Prod9',228),
(10,'Prod10',252),
(11,'Prod11',428),
(12,'Prod12',459),
(13,'Prod13',55),
(14,'Prod14',44),
(15,'Prod15',195),
(16,'Prod16',97),
(17,'Prod17',370),
(18,'Prod18',352),
(19,'Prod19',462),
(20,'Prod20',144),
(21,'Prod21',148),
(22,'Prod22',160),
(23,'Prod23',18),
(24,'Prod24',407),
(25,'Prod25',310),
(26,'Prod26',398),
(27,'Prod27',88),
(28,'Prod28',123),
(29,'Prod29',259),
(30,'Prod30',487),
(31,'Prod31',229),
(32,'Prod32',418),
(33,'Prod33',114),
(34,'Prod34',417),
(35,'Prod35',429),
(36,'Prod36',216),
(37,'Prod37',244),
(38,'Prod38',174),
(39,'Prod39',465),
(40,'Prod40',458);
```

```sql
INSERT INTO orders(order_id,cust_id,prod_id,quantity,order_date) VALUES
(1,16,27,4,'2024-06-25'),
(2,10,7,1,'2024-07-07'),
(3,20,5,5,'2025-12-11'),
(4,20,23,4,'2022-01-26'),
(5,2,26,5,'2025-07-05'),
(6,30,16,2,'2024-02-23'),
(7,30,2,4,'2024-10-22'),
(8,27,17,4,'2025-12-07'),
(9,22,25,2,'2022-08-28'),
(10,32,12,2,'2023-11-16'),
(11,26,23,4,'2025-10-05'),
(12,25,19,2,'2024-08-05'),
(13,33,29,1,'2025-12-17'),
(14,37,26,2,'2024-04-01'),
(15,28,2,1,'2022-12-21'),
(16,40,30,2,'2025-07-15'),
(17,2,33,2,'2024-10-11'),
(18,37,18,1,'2022-05-02'),
(19,12,11,4,'2022-05-24'),
(20,20,11,5,'2022-08-31'),
(21,12,3,1,'2024-02-20'),
(22,31,26,2,'2024-01-20'),
(23,33,20,3,'2022-04-21'),
(24,17,40,4,'2022-06-30'),
(25,27,18,3,'2022-03-16'),
(26,26,7,3,'2022-07-03'),
(27,4,36,1,'2025-10-15'),
(28,2,22,2,'2024-04-25'),
(29,14,28,2,'2023-03-26'),
(30,31,38,5,'2025-12-04'),
(31,30,3,1,'2025-04-18'),
(32,16,17,4,'2025-03-30'),
(33,13,1,2,'2024-06-12'),
(34,9,26,3,'2024-10-24'),
(35,32,2,5,'2022-03-16'),
(36,11,18,4,'2023-11-05'),
(37,19,10,3,'2024-03-29'),
(38,32,39,3,'2022-01-13'),
(39,34,5,2,'2025-10-28'),
(40,31,10,5,'2024-01-09'),
(41,18,21,4,'2023-05-27'),
(42,28,1,2,'2025-02-06'),
(43,9,23,4,'2023-04-04'),
(44,37,4,1,'2022-07-16'),
(45,10,6,4,'2025-08-28'),
(46,37,22,1,'2023-04-12'),
(47,14,7,4,'2024-05-10'),
(48,16,13,1,'2023-01-26'),
(49,2,19,3,'2022-08-27'),
(50,33,40,5,'2024-08-20'),
(51,14,29,5,'2023-04-08'),
(52,33,11,3,'2025-02-18'),
(53,7,9,1,'2023-03-09'),
(54,31,32,1,'2025-09-14'),
(55,25,3,3,'2023-06-21'),
(56,32,33,1,'2025-09-22'),
(57,30,35,3,'2023-02-06'),
(58,12,26,3,'2022-11-01'),
(59,33,7,3,'2024-09-05'),
(60,29,30,2,'2023-06-04'),
(61,12,17,5,'2024-06-05'),
(62,24,6,1,'2022-02-13'),
(63,30,6,2,'2023-11-26'),
(64,5,11,1,'2023-04-12'),
(65,35,11,4,'2024-03-24'),
(66,25,28,3,'2024-05-18'),
(67,32,15,2,'2024-12-18'),
(68,6,21,1,'2022-04-03'),
(69,27,4,3,'2023-05-21'),
(70,31,12,2,'2024-08-22'),
(71,34,6,3,'2025-10-29'),
(72,10,38,4,'2024-05-23'),
(73,18,32,3,'2024-01-29'),
(74,40,34,5,'2024-09-02'),
(75,19,26,4,'2022-05-15'),
(76,21,19,3,'2022-06-28'),
(77,39,37,5,'2022-10-15'),
(78,40,33,1,'2023-07-05'),
(79,37,13,1,'2025-03-05'),
(80,25,7,4,'2022-02-23');
```

## Lab: 40 Queries (English → SQL)

1. Compute total revenue per order
```sql
SELECT o.order_id, (p.price*o.quantity) AS revenue FROM orders o JOIN products p ON o.prod_id=p.prod_id;
```

2. List the top 10 orders by revenue
```sql
SELECT o.order_id, p.price*o.quantity AS revenue FROM orders o JOIN products p ON o.prod_id=p.prod_id ORDER BY revenue DESC LIMIT 10;
```

3. Compute total revenue per customer
```sql
SELECT c.cust_id, c.cust_name, SUM(p.price*o.quantity) AS total_rev FROM orders o JOIN products p ON o.prod_id=p.prod_id JOIN customers c ON c.cust_id=o.cust_id GROUP BY c.cust_id, c.cust_name ORDER BY total_rev DESC;
```

4. Monthly revenue (YYYY-MM)
```sql
SELECT DATE_FORMAT(order_date,'%Y-%m') AS y_m, SUM(p.price*o.quantity) AS revenue FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY y_m ORDER BY y_m;
```

5. Top 5 customers by revenue in USA
```sql
SELECT c.cust_name, SUM(p.price*o.quantity) AS rev FROM orders o JOIN products p ON o.prod_id=p.prod_id JOIN customers c ON c.cust_id=o.cust_id WHERE c.country='USA' GROUP BY c.cust_name ORDER BY rev DESC LIMIT 5;
```

6. Capstone query 1
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

7. Capstone query 2
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

8. Capstone query 3
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

9. Capstone query 4
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

10. Capstone query 5
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

11. Capstone query 6
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

12. Capstone query 7
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

13. Capstone query 8
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

14. Capstone query 9
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

15. Capstone query 10
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

16. Capstone query 11
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

17. Capstone query 12
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

18. Capstone query 13
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

19. Capstone query 14
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

20. Capstone query 15
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

21. Capstone query 16
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

22. Capstone query 17
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

23. Capstone query 18
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

24. Capstone query 19
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

25. Capstone query 20
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

26. Capstone query 21
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

27. Capstone query 22
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

28. Capstone query 23
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

29. Capstone query 24
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

30. Capstone query 25
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

31. Capstone query 26
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

32. Capstone query 27
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

33. Capstone query 28
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

34. Capstone query 29
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

35. Capstone query 30
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

36. Capstone query 31
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

37. Capstone query 32
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

38. Capstone query 33
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

39. Capstone query 34
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```

40. Capstone query 35
```sql
SELECT p.prod_name, SUM(o.quantity) AS qty FROM orders o JOIN products p ON o.prod_id=p.prod_id GROUP BY p.prod_name ORDER BY qty DESC LIMIT 5;
```
