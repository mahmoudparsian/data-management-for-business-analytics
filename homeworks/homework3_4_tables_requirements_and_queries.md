Using mysql database, Very Basic Data Modeling and some queries: 
Create a simple database requirement: let's say in two paragraphs 
of english sentences which translates into 4 tables:

products : describe each product and category
customers: customer identification
stores: products sold in stores
transactions: customers buy products at specific stores for price and date

Then map these requirements to a very simple relational database 
model: come up with these 4 tables and then provide 10 Natural Language 
queries and provide sql queries (5 simple and 5 intermediate).


Got it. Let’s build this step by step so it’s useful both as a 
teaching exercise and as a working MySQL model.

---

## Step 1. English Requirement (2 paragraphs)

We want to design a simple retail database to keep track of 
products, customers, stores, and transactions. Each product 
belongs to a specific category, and we want to know its name 
and description. 

Customers can buy products at different stores, and we should 
keep track of who they are and their identifying details.

Each store sells products, and customers make purchases at 
these stores. For each transaction, we need to record which 
customer made the purchase, what product they bought, from 
which store, the purchase price, and the date of the purchase. 
This setup will allow us to query information about products, 
customers, stores, and sales transactions.

---

## Step 2. Relational Database Model (4 Tables)

```sql
CREATE TABLE products (
    product_id   INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category     VARCHAR(50) NOT NULL,
    description  VARCHAR(255)
);

CREATE TABLE customers (
    customer_id   INT AUTO_INCREMENT PRIMARY KEY,
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    email         VARCHAR(100),
    phone         VARCHAR(20)
);

CREATE TABLE stores (
    store_id   INT AUTO_INCREMENT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    location   VARCHAR(100)
);

CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id    INT NOT NULL,
    product_id     INT NOT NULL,
    store_id       INT NOT NULL,
    price          DECIMAL(10,2) NOT NULL,
    purchase_date  DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);
```

👍 Let’s populate these four tables with a **small but meaningful dataset** 
so the queries will return real results.

---

# Data Population

✅ Now you have:

* 5 products
* 5 customers
* 3 stores
* 7 transactions across different dates

## 1. Insert Sample Rows into `products`

```sql
INSERT INTO products (product_name, category, description) VALUES
('iPhone 15', 'Electronics', 'Latest Apple smartphone'),
('Samsung Galaxy S24', 'Electronics', 'High-end Android phone'),
('Dell XPS 13', 'Computers', 'Lightweight laptop'),
('Sony WH-1000XM5', 'Accessories', 'Noise-cancelling headphones'),
('Nike Air Max', 'Footwear', 'Popular running shoes');
```

---

## 2. Insert Sample Rows into `customers`

```sql
INSERT INTO customers (first_name, last_name, email, phone) VALUES
('Alice', 'Johnson', 'alice.johnson@example.com', '555-1234'),
('Bob', 'Smith', 'bob.smith@example.com', '555-2345'),
('Charlie', 'Lee', 'charlie.lee@example.com', '555-3456'),
('Diana', 'Martinez', 'diana.martinez@example.com', '555-4567'),
('Ethan', 'Brown', 'ethan.brown@example.com', '555-5678');
```

---

## 3. Insert Sample Rows into `stores`

```sql
INSERT INTO stores (store_name, location) VALUES
('Tech World', 'New York'),
('Gadget Hub', 'San Francisco'),
('Smart Store', 'Chicago');
```

---

## 4. Insert Sample Rows into `transactions`

```sql
INSERT INTO transactions (customer_id, product_id, store_id, price, purchase_date) VALUES
(1, 1, 1, 999.99, '2025-01-05'),   -- Alice buys iPhone 15 at Tech World
(2, 2, 1, 899.99, '2025-01-10'),   -- Bob buys Galaxy S24 at Tech World
(3, 3, 2, 1299.99, '2025-02-02'),  -- Charlie buys Dell XPS 13 at Gadget Hub
(1, 4, 2, 349.99, '2025-02-15'),   -- Alice buys Sony headphones at Gadget Hub
(4, 5, 3, 149.99, '2025-03-01'),   -- Diana buys Nike Air Max at Smart Store
(5, 1, 3, 999.99, '2025-03-10'),   -- Ethan buys iPhone 15 at Smart Store
(2, 4, 2, 349.99, '2025-03-12');   -- Bob buys Sony headphones at Gadget Hub
```

---

## Step 3. Natural Language Queries + SQL

### **Simple Queries (5)**

1. **List all products with their categories.**

   ```sql
   SELECT product_name, 
          category 
   FROM products;
   ```

2. **Find all customers’ first and last names.**

   ```sql
   SELECT first_name, 
          last_name 
   FROM customers;
   ```

3. **Show all store names and their locations.**

   ```sql
   SELECT store_name, 
          location 
   FROM stores;
   ```

4. **Get all transactions with product IDs and purchase dates.**

   ```sql
   SELECT transaction_id, 
          product_id, 
          purchase_date
   FROM transactions;
   ```

5. **Find all transactions that happened on '2025-01-01'.**

   ```sql
   SELECT * 
   FROM transactions 
   WHERE purchase_date = '2025-01-01';
   ```

---

### **Intermediate Queries (5)**

6. **List each transaction with customer name, product name, store, and price.**

   ```sql
   SELECT t.transaction_id, c.first_name, c.last_name, p.product_name, s.store_name, t.price, t.purchase_date
   FROM transactions t
   JOIN customers c ON t.customer_id = c.customer_id
   JOIN products p ON t.product_id = p.product_id
   JOIN stores s ON t.store_id = s.store_id;
   ```

7. **Find total sales revenue across all stores.**

   ```sql
   SELECT SUM(price) AS total_revenue
   FROM transactions;
   ```

8. **Get the number of products sold per category.**

   ```sql
   SELECT p.category, 
          COUNT(*) AS total_sold
   FROM transactions t
   JOIN products p ON t.product_id = p.product_id
   GROUP BY p.category;
   ```

9. **Find top 3 customers who spent the most money.**

   ```sql
   SELECT c.first_name, 
          c.last_name, 
          SUM(t.price) AS total_spent
   FROM transactions t
   JOIN customers c ON t.customer_id = c.customer_id
   GROUP BY c.customer_id
   ORDER BY total_spent DESC
   LIMIT 3;
   ```

10. **Get total revenue per store in 2025.**

```sql
SELECT s.store_name, SUM(t.price) AS store_revenue
FROM transactions t
JOIN stores s ON t.store_id = s.store_id
WHERE YEAR(t.purchase_date) = 2025
GROUP BY s.store_id;
```



---

# 🔹 Five Advanced Queries (WITH + Ranking)

✅ These queries introduce **CTEs (`WITH`)** and **ranking functions** 
to solve real-world business questions:

* Most expensive purchase per customer
* Top products by sales
* Ranking customers by spending
* Latest purchase per store
* Category-wise top spender


---

### 11. **Find the most expensive purchase per customer**

👉 Natural language: For each customer, show their most expensive transaction.

```sql
WITH ranked_purchases AS (
    SELECT 
        t.transaction_id,
        t.customer_id,
        t.price,
        ROW_NUMBER() OVER (PARTITION BY t.customer_id ORDER BY t.price DESC) AS rn
    FROM transactions t
)
SELECT c.first_name, c.last_name, r.transaction_id, r.price
FROM ranked_purchases r
JOIN customers c ON r.customer_id = c.customer_id
WHERE rn = 1;
```

---

### 12. **Top 2 products by sales revenue**

👉 Natural language: List the top 2 products by total revenue generated.

```sql
WITH product_sales AS (
    SELECT 
        p.product_id,
        p.product_name,
        SUM(t.price) AS total_revenue
    FROM transactions t
    JOIN products p ON t.product_id = p.product_id
    GROUP BY p.product_id, p.product_name
)
SELECT product_name, total_revenue,
       RANK() OVER (ORDER BY total_revenue DESC) AS sales_rank
FROM product_sales
ORDER BY sales_rank
LIMIT 2;
```

---

### 13. **Rank customers by total spending**

👉 Natural language: Rank customers based on total money spent, highest first.

```sql
WITH customer_spending AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(t.price) AS total_spent
    FROM customers c
    JOIN transactions t ON c.customer_id = t.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT first_name, last_name, total_spent,
       RANK() OVER (ORDER BY total_spent DESC) AS spend_rank
FROM customer_spending;
```

---

### 14. **Find the latest purchase per store**

👉 Natural language: For each store, find the most recent transaction.

```sql
WITH store_latest AS (
    SELECT 
        t.transaction_id,
        t.store_id,
        t.purchase_date,
        ROW_NUMBER() OVER (PARTITION BY t.store_id ORDER BY t.purchase_date DESC) AS rn
    FROM transactions t
)
SELECT s.store_name, sl.transaction_id, sl.purchase_date
FROM store_latest sl
JOIN stores s ON sl.store_id = s.store_id
WHERE rn = 1;
```

---

### 15. **Category-wise top spender**

👉 Natural language: For each product category, show the customer who spent the most in that category.

```sql
WITH category_spending AS (
    SELECT 
        p.category,
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(t.price) AS total_spent,
        RANK() OVER (PARTITION BY p.category ORDER BY SUM(t.price) DESC) AS rn
    FROM transactions t
    JOIN products p ON t.product_id = p.product_id
    JOIN customers c ON t.customer_id = c.customer_id
    GROUP BY p.category, c.customer_id, c.first_name, c.last_name
)
SELECT category, first_name, last_name, total_spent
FROM category_spending
WHERE rn = 1;
```

---




