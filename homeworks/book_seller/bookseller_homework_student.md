# 📝 MySQL Homework: Book Seller Data Model

## Requirements (in plain English)
1. The book seller has **8 stores** in different locations.  
2. Customers can buy **books** (both online and in-store).  
3. The seller wants to track **all daily transactions**.  
4. Each transaction records **who bought what, where, when, how much, and through which channel**.  
5. The seller also wants to see **weekly, monthly, yearly summaries** of sales.  

---

## Data Model (Relational Tables)

- **stores** (store_id, store_name, location)  
- **customers** (customer_id, name, email)  
- **books** (book_id, title, author, price)  
- **transactions** (transaction_id, customer_id, store_id, book_id, quantity, total_amount, purchase_date, channel)  

---

## Tasks

### Part A: Simple Queries (Write the SQL)
1. List all stores and their locations.  
2. Show all books with title and price.  
3. Find all customers.  
4. List all transactions with date and total amount.  
5. Find all online purchases.  
6. Show all books purchased in Store A.  

### Part B: Intermediate Queries (Write the SQL)
7. Find the total sales (sum of total_amount).  
8. Find the number of transactions per channel.  
9. Find the total revenue per store.  
10. Find the most expensive book sold.  
11. Find the average order value.  
12. Find the number of books sold per customer.  

### Part C: Advanced Queries (Write the SQL with WITH clause or ranking)
13. Find total monthly sales using `WITH`.  
14. Rank stores by revenue.  
15. Find top customer by total spending.  
16. Find best-selling book by quantity.  
17. Find weekly revenue trends.  
18. Find customer who bought the most distinct books.  
