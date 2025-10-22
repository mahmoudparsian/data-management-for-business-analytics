# Week 4 Assignment – Aggregation & GROUP BY (12 Tasks)

## Schema
```sql
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
  sale_id INT PRIMARY KEY,
  customer VARCHAR(40),
  region VARCHAR(20),
  amount DECIMAL(10,2),
  status VARCHAR(20)
);
```

## Sample Data
```sql
INSERT INTO sales VALUES
(1,'Alice','North',120.00,'PAID'),
(2,'Bob','West',250.00,'PAID'),
(3,'Carol','West',80.00,'PENDING'),
(4,'Dan','East',300.00,'PAID'),
(5,'Eva','North',150.00,'PENDING'),
(6,'Frank','South',200.00,'PAID'),
(7,'Grace','East',130.00,'PAID'),
(8,'Hank','West',400.00,'PAID');
```

## Tasks
1) Total number of sales.  
2) Total revenue (sum of amount).  
3) Average sale amount.  
4) Max and min sale amounts.  
5) Revenue by region.  
6) Count of sales by status.  
7) Average sale by region.  
8) Regions with total revenue > 300.  
9) Number of customers per region.  
10) Top region by revenue.  
11) Average amount for PAID sales only.  
12) For each region, show revenue and average amount.
