# Week 5 Assignment – Joins & Keys (12 Tasks)

## Schema
```sql
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS orders;
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(40),
  country VARCHAR(30)
);
CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  amount DECIMAL(10,2),
  status VARCHAR(20),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
```

## Sample Data
```sql
INSERT INTO customers VALUES
(1,'Ava','USA'),(2,'Noah','Canada'),(3,'Emma','USA'),(4,'Liam','UK');

INSERT INTO orders VALUES
(101,1,200.00,'PAID'),
(102,2,150.00,'PENDING'),
(103,1,120.00,'PAID'),
(104,3,300.00,'PAID');
```

## Tasks
1) Inner join customers and orders.  
2) Left join customers and orders.  
3) Customers with no orders.  
4) Total order amount per customer.  
5) Customers with total orders > 250.  
6) Number of orders per country.  
7) Average order amount per customer.  
8) Orders with status = 'PAID' and their customers.  
9) Countries with at least 2 customers.  
10) Top customer by total spend.  
11) Show each customer and their latest order_id (max).  
12) Right join (explain why results match inner/left here).
