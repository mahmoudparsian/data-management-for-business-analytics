# Week 7 Assignment – Transactions, Indexes, Best Practices (12 Tasks)

## Schema
```sql
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  acct_id INT PRIMARY KEY,
  owner VARCHAR(40),
  balance DECIMAL(12,2)
);
```

## Sample Data
```sql
INSERT INTO accounts VALUES
(1,'Alice',1000.00),(2,'Bob',500.00),(3,'Carol',1200.00);
```

## Tasks
1) Show all accounts.  
2) Start a transaction.  
3) Transfer 200 from Alice (1) to Bob (2) using two UPDATEs.  
4) Rollback the transaction (verify balances unchanged).  
5) Repeat transfer and COMMIT (verify balances changed).  
6) Create an index on owner.  
7) Show how to drop the index.  
8) Add a CHECK-like constraint using trigger idea (explain).  
9) Show an atomic multi-row insert inside a transaction (and rollback).  
10) Demonstrate idempotent update (only if owner='Carol').  
11) Explain when to add an index (short paragraph).  
12) Write 3 best practices for schema design (bulleted).
