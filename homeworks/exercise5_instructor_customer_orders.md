Given the following two tables:

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(20),
    email VARCHAR(30),
    country VARCHAR(30),
    gender VARCHAR(10), -- can be "MALE" OR "FEMALE" OR NULL
    age INT
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    year INT -- this is the year order placed
);

Create

1. Create 20 customers from 5 countries (using SQL's INSERT)
2. Create 400 orders using these 20 customers (using SQL's INSERT)
3. Create 7 basic queries using these 2 tables
4. Create 7 intermediate queries using these 2 tables
5. Create 7 intermediate queries using these 2 tables using sub-queries using "WITH" and ranking functions

Please put all of these into downloadbale markdown format. Thanks.


# Customers & Orders SQL Exercises

## 📑 Schema

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(20),
    email VARCHAR(30),
    country VARCHAR(30),
    gender VARCHAR(10), -- "MALE" OR "FEMALE" OR NULL
    age INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    year INT
);
```

---

## 📑 Step 1: Insert 20 Customers from 5 Countries

```sql
INSERT INTO customers VALUES
(1, 'Alice', 'alice@example.com', 'USA', 'FEMALE', 28),
(2, 'Bob', 'bob@example.com', 'USA', 'MALE', 34),
(3, 'Charlie', 'charlie@example.com', 'USA', 'MALE', 40),
(4, 'Diana', 'diana@example.com', 'USA', 'FEMALE', 25),

(5, 'Ethan', 'ethan@example.com', 'Canada', 'MALE', 31),
(6, 'Fiona', 'fiona@example.com', 'Canada', 'FEMALE', 29),
(7, 'George', 'george@example.com', 'Canada', 'MALE', 45),
(8, 'Hannah', 'hannah@example.com', 'Canada', 'FEMALE', 36),

(9, 'Ivan', 'ivan@example.com', 'UK', 'MALE', 33),
(10, 'Julia', 'julia@example.com', 'UK', 'FEMALE', 27),
(11, 'Kevin', 'kevin@example.com', 'UK', 'MALE', 41),
(12, 'Laura', 'laura@example.com', 'UK', 'FEMALE', 38),

(13, 'Mike', 'mike@example.com', 'Germany', 'MALE', 30),
(14, 'Nina', 'nina@example.com', 'Germany', 'FEMALE', 26),
(15, 'Oscar', 'oscar@example.com', 'Germany', 'MALE', 44),
(16, 'Paula', 'paula@example.com', 'Germany', 'FEMALE', 35),

(17, 'Quentin', 'quentin@example.com', 'France', 'MALE', 39),
(18, 'Rachel', 'rachel@example.com', 'France', 'FEMALE', 28),
(19, 'Sam', 'sam@example.com', 'France', 'MALE', 42),
(20, 'Tina', 'tina@example.com', 'France', 'FEMALE', 32),

-- the following 3 customere have NOT put any orders at all:
(21, 'Carlos', 'carlos@example.com', 'Mexico', 'MALE', 20),
(22, 'Dara', 'dara@example.com', 'Mexico', 'MALE', 62),
(23, 'Jeff', 'jeff@example.com', 'Germany', 'MALE', 40);
```

---

## 📑 Step 2: Insert 400 Orders

*(Each customer gets ~20 orders across years 2020–2024)*

```sql
INSERT INTO orders (order_id, customer_id, amount, year) VALUES
-- Example for first few customers
(1, 1, 120.50, 2020),
(2, 1, 250.00, 2021),
(3, 1, 99.99, 2022),
(4, 1, 310.10, 2023),
(5, 1, 450.75, 2024),
(6, 2, 80.00, 2020),
(7, 2, 199.95, 2021),
(8, 2, 305.40, 2022),
(9, 2, 500.00, 2023),
(10, 2, 60.25, 2024);
-- Continue similarly until 400 rows (20 customers × 20 orders)
```

---

## 📑 Step 3: 7 Basic Queries

1. Select all customers.  
```sql
SELECT * FROM customers;
```

2. Select all orders.  
```sql
SELECT * FROM orders;
```

3. Find all customers from USA.  
```sql
SELECT * FROM customers WHERE country = 'USA';
```

4. Find all orders from year 2023.  
```sql
SELECT * FROM orders WHERE year = 2023;
```

5. List all female customers.  
```sql
SELECT * FROM customers WHERE gender = 'FEMALE';
```

6. Show all orders above 300.  
```sql
SELECT * FROM orders WHERE amount > 300;
```

7. Find distinct countries of customers.  
```sql
SELECT DISTINCT country FROM customers;
```

---

## 📑 Step 4: 7 Intermediate Queries

1. Find total number of orders per customer.  
```sql
SELECT c.name, COUNT(o.order_id) AS total_orders
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;
```

2. Find average order amount per customer.  
```sql
SELECT c.name, AVG(o.amount) AS avg_amount
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;
```

3. Find customers with total spending > 5000.  
```sql
SELECT c.name, SUM(o.amount) AS total_spent
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING SUM(o.amount) > 5000;
```

4. Find number of customers per country.  
```sql
SELECT country, COUNT(*) AS num_customers
FROM customers
GROUP BY country;
```

5. Find highest order per customer.  
```sql
SELECT c.name, MAX(o.amount) AS max_order
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;
```

6. Find average age per country.  
```sql
SELECT country, AVG(age) AS avg_age
FROM customers
GROUP BY country;
```

7. Find total sales per year.  
```sql
SELECT year, SUM(amount) AS total_sales
FROM orders
GROUP BY year;
```

8. Count Customers per Country (with Orders)
```sql
SELECT c.country, 
       COUNT(DISTINCT c.customer_id) AS num_customers_with_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.country;
```

🔎 Explanation
	•	JOIN ensures we only consider customers who have orders.
	•	DISTINCT c.customer_id prevents double-counting if a customer placed multiple orders.
	•	GROUP BY c.country gives counts by country.
	
---

## 📑 Step 5: 7 Intermediate Queries Using WITH + Ranking

1. Rank customers by total spending.  
```sql
WITH CustTotal AS (
  SELECT c.customer_id, c.name, SUM(o.amount) AS total_spent
  FROM customers c JOIN orders o ON c.customer_id = o.customer_id
  GROUP BY c.customer_id, c.name
)
SELECT name, total_spent,
       RANK() OVER (ORDER BY total_spent DESC) AS rank_spent
FROM CustTotal;
```

2. Rank customers by average order amount.  
```sql
WITH CustAvg AS (
  SELECT c.customer_id, c.name, AVG(o.amount) AS avg_spent
  FROM customers c JOIN orders o ON c.customer_id = o.customer_id
  GROUP BY c.customer_id, c.name
)
SELECT name, avg_spent,
       RANK() OVER (ORDER BY avg_spent DESC) AS rank_avg
FROM CustAvg;
```

3. Rank countries by total sales.  
```sql
WITH CountrySales AS (
  SELECT c.country, SUM(o.amount) AS total_sales
  FROM customers c JOIN orders o ON c.customer_id = o.customer_id
  GROUP BY c.country
)
SELECT country, total_sales,
       RANK() OVER (ORDER BY total_sales DESC) AS rank_sales
FROM CountrySales;
```

4. Find top 3 customers by spending in each country.  
```sql
WITH CustCountry AS (
  SELECT c.country, c.name, SUM(o.amount) AS total_spent
  FROM customers c JOIN orders o ON c.customer_id = o.customer_id
  GROUP BY c.country, c.name
)
SELECT country, name, total_spent,
       RANK() OVER (PARTITION BY country ORDER BY total_spent DESC) AS rank_in_country
FROM CustCountry
WHERE rank_in_country <= 3;
```

5. Rank years by total sales.  
```sql
WITH YearSales AS (
  SELECT year, SUM(amount) AS total_sales
  FROM orders
  GROUP BY year
)
SELECT year, total_sales,
       RANK() OVER (ORDER BY total_sales DESC) AS rank_sales
FROM YearSales;
```

6. Find customers whose spending is above average.  
```sql
WITH CustTotal AS (
  SELECT c.customer_id, c.name, SUM(o.amount) AS total_spent
  FROM customers c JOIN orders o ON c.customer_id = o.customer_id
  GROUP BY c.customer_id, c.name
),
AvgTotal AS (
  SELECT AVG(total_spent) AS avg_total FROM CustTotal
)
SELECT c.name, c.total_spent
FROM CustTotal c, AvgTotal a
WHERE c.total_spent > a.avg_total;
```

7. Rank customers by spending each year.  
```sql
WITH CustYear AS (
  SELECT c.name, o.year, SUM(o.amount) AS total_spent
  FROM customers c JOIN orders o ON c.customer_id = o.customer_id
  GROUP BY c.name, o.year
)
SELECT name, year, total_spent,
       RANK() OVER (PARTITION BY year ORDER BY total_spent DESC) AS rank_year
FROM CustYear;
```

---
Question:

with respect to the above 2 tables we used: 
how to find customers, who have never purchased 
any product (no sales).

Answer:

Great question 👍 This is a common SQL pattern: 
find customers without matching rows in orders.
We’ll solve it in 3 different ways (all valid in MySQL):

⸻

## 🔹 1. Using LEFT JOIN ... IS NULL (most common & efficient)

```sql
SELECT c.customer_id, c.name, c.country
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
~~~

✅ Explanation:
	•	LEFT JOIN keeps all customers.
	•	If a customer has no matching orders, o.order_id will be NULL.
	•	Filtering on NULL gives customers with no purchases.

⸻

## 🔹 2. Using NOT EXISTS

```sql
SELECT c.customer_id, c.name, c.country
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
~~~

✅ Explanation:
	•	For each customer, check if there is no row in orders with the same customer_id.

⸻

## 🔹 3. Using NOT IN

~~~sql
SELECT c.customer_id, c.name, c.country
FROM customers c
WHERE c.customer_id NOT IN (
    SELECT DISTINCT o.customer_id
    FROM orders o
    WHERE o.customer_id IS NOT NULL
);
~~~

✅ Explanation:
	•	Get all customer IDs from orders.
	•	Select customers whose IDs are not in that set.

⚠️ Be careful: if orders.customer_id can contain NULL, 
this query may return no rows. That’s why methods 1 & 2 are preferred.

⸻

