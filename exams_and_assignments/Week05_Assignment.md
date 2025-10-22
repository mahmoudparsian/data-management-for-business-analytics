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
(1,'Ava','USA'),
(2,'Noah','CANADA'),
(3,'Emma','USA'),
(4,'Adam','USA'),
(5,'Rafa','CANADA'),
(6,'Max','USA'),
(7,'Alex','MEXICO'),
(8,'Jeff','UK');

INSERT INTO orders VALUES
(101,1,200.00,'PAID'),
(102,2,150.00,'PENDING'),
(103,1,120.00,'PAID'),
(104,3,300.00,'PAID'),
(105,1,100.00,'PAID'),
(106,2,250.00,'PENDING'),
(107,1,220.00,'PAID'),
(108,3,600.00,'PAID');
(109,2,150.00,'PAID'),
(110,2,150.00,'PAID'),
(111,3,350.00,'PENDING'),
(112,3,450.00,'PENDING'),
(113,4,100.00,'PAID'),
(114,4,250.00,'PAID'),
(115,5,320.00,'PAID'),
(116,5,400.00,'PAID'),
(117,3,250.00,'PENDING'),
(118,3,150.00,'PENDING'),
(119,3,200.00,'PAID'),
(120,3,450.00,'PAID');
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
