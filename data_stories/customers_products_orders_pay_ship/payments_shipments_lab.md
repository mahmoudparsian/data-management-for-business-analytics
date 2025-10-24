# Payments + Shipments Lab (Customer–Order Extension)

## 📖 Data Story

Your company now wants to **track how customers pay for their orders** 
and **how those orders are shipped**.

- **Payments:** Each order has exactly one payment (one-to-one).  
- **Shipments:** Each order may have one or more shipments (one-to-many).  

This models the **end-to-end lifecycle of an order**: 

from placement → payment → shipping → delivery.

---

## 🗂️ Schema

```sql
CREATE DATABASE IF NOT EXISTS retail_demo_ext;
USE retail_demo_ext;

-- Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    country VARCHAR(30)
);

-- Products
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30)
);

-- Orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    paid_price INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Payments (1-to-1 with orders)
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT UNIQUE,
    payment_date DATE,
    amount INT,
    method ENUM('Credit Card','PayPal','Bank Transfer'),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Shipments (1-to-many with orders)
CREATE TABLE shipments (
    shipment_id INT PRIMARY KEY,
    order_id INT,
    shipped_date DATE,
    delivery_date DATE,
    carrier VARCHAR(30),
    status ENUM('Pending','Shipped','Delivered','Returned'),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
```

---

## 📥 Sample Data

### Customers (10 rows)
```sql
INSERT INTO customers VALUES
(1,'Alice','USA'),
(2,'Bob','Canada'),
(3,'Carol','Germany'),
(4,'David','UK'),
(5,'Eva','France'),
(6,'Frank','India'),
(7,'Grace','USA'),
(8,'Henry','Brazil'),
(9,'Isabel','Japan'),
(10,'Jack','Australia');
```

### Products (8 rows)
```sql
INSERT INTO products VALUES
(101,'Laptop','Electronics'),
(102,'Phone','Electronics'),
(103,'Tablet','Electronics'),
(104,'Desk','Furniture'),
(105,'Chair','Furniture'),
(106,'Shoes','Apparel'),
(107,'Book','Books'),
(108,'Blender','Kitchen');
```

### Orders (15 rows)
```sql
INSERT INTO orders VALUES
(1001,1,101,1200,'2024-01-15'),
(1002,2,104,300,'2024-01-16'),
(1003,3,102,800,'2024-01-18'),
(1004,4,105,150,'2024-01-20'),
(1005,5,106,90,'2024-01-21'),
(1006,6,103,600,'2024-01-22'),
(1007,7,107,30,'2024-01-22'),
(1008,8,108,120,'2024-01-23'),
(1009,9,101,1100,'2024-01-25'),
(1010,10,102,850,'2024-01-26'),
(1011,1,104,320,'2024-01-28'),
(1012,2,106,95,'2024-01-29'),
(1013,3,107,25,'2024-01-30'),
(1014,4,108,150,'2024-02-01'),
(1015,5,103,610,'2024-02-02');
```

### Payments (15 rows)
```sql
INSERT INTO payments VALUES
(1,1001,'2024-01-15',1200,'Credit Card'),
(2,1002,'2024-01-16',300,'PayPal'),
(3,1003,'2024-01-18',800,'Credit Card'),
(4,1004,'2024-01-20',150,'Bank Transfer'),
(5,1005,'2024-01-21',90,'Credit Card'),
(6,1006,'2024-01-22',600,'PayPal'),
(7,1007,'2024-01-22',30,'Credit Card'),
(8,1008,'2024-01-23',120,'Bank Transfer'),
(9,1009,'2024-01-25',1100,'Credit Card'),
(10,1010,'2024-01-26',850,'PayPal'),
(11,1011,'2024-01-28',320,'Credit Card'),
(12,1012,'2024-01-29',95,'PayPal'),
(13,1013,'2024-01-30',25,'Credit Card'),
(14,1014,'2024-02-01',150,'Bank Transfer'),
(15,1015,'2024-02-02',610,'Credit Card');
```

### Shipments (20 rows)
```sql
INSERT INTO shipments VALUES
(1,1001,'2024-01-16','2024-01-20','UPS','Delivered'),
(2,1002,'2024-01-17','2024-01-19','FedEx','Delivered'),
(3,1003,'2024-01-19','2024-01-22','UPS','Delivered'),
(4,1004,'2024-01-21','2024-01-23','DHL','Delivered'),
(5,1005,'2024-01-22','2024-01-25','DHL','Delivered'),
(6,1006,'2024-01-23','2024-01-27','FedEx','Delivered'),
(7,1007,'2024-01-23','2024-01-26','UPS','Delivered'),
(8,1008,'2024-01-24','2024-01-28','FedEx','Delivered'),
(9,1009,'2024-01-26','2024-01-30','DHL','Delivered'),
(10,1010,'2024-01-27','2024-01-31','UPS','Delivered'),
(11,1011,'2024-01-29','2024-02-02','UPS','Shipped'),
(12,1012,'2024-01-30',NULL,'FedEx','Pending'),
(13,1013,'2024-01-31','2024-02-04','DHL','Delivered'),
(14,1014,'2024-02-02','2024-02-06','UPS','Delivered'),
(15,1015,'2024-02-03',NULL,'FedEx','Pending'),
(16,1015,'2024-02-05',NULL,'FedEx','Shipped'),
(17,1006,'2024-01-25',NULL,'UPS','Returned'),
(18,1001,'2024-01-18',NULL,'DHL','Returned'),
(19,1010,'2024-01-28',NULL,'DHL','Shipped'),
(20,1007,'2024-01-25','2024-01-28','FedEx','Delivered');
```

---

## 📝 Lab Queries

### 🔹 10 Simple Queries
1. List all customers.  
2. Show all orders with paid_price.  
3. Show all payment methods used.  
4. List all shipments with status Delivered.  
5. Find orders where price > 500.  
6. Show all payments made via PayPal.  
7. List orders not yet delivered.  
8. Show all products ordered by Alice.  
9. Count total customers.  
10. Count total products.  

### 🔹 10 Simple-to-Intermediate Queries
11. Show all orders with customer name, product name, and payment method.  
12. Find total revenue per payment method.  
13. Count shipments by status.  
14. Average paid_price per product category.  
15. List customers with more than 2 orders.  
16. Show orders with shipment carrier and delivery status.  
17. List payments where amount < 100.  
18. Find the max paid_price per country.  
19. Count orders by country.  
20. Show top 3 products by total revenue.  

### 🔹 10 Intermediate Queries (CTEs + Ranking)
21. **With CTE:** Find customers ranked by total spend.  
22. **With CTE:** Rank products by total revenue.  
23. **With CTE:** Top customer per country by spend.  
24. **With ROW_NUMBER:** Top 2 shipments per order by date.  
25. **With DENSE_RANK:** Rank carriers by number of shipments.  
26. **With RANK:** Rank customers by number of orders.  
27. **With CTE:** Find customers who only used Credit Card.  
28. **With ROW_NUMBER:** For each product, show the top order by paid_price.  
29. **With CTE:** Find categories where average spend > overall average.  
30. **With RANK:** Rank orders by paid_price within each customer.  

---

✅ End of Lab

-----

## Extend the SQL INSERT as:

### Customers (22 rows): 2 OF THEM NEVER BUY ANYTHING

### Products (54 rows): 4 of the products never bougut

### Orders (300 rows): do not even among customers

### Payments (50 rows)

### Shipments (80 rows)


