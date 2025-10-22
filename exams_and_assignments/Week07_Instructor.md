# Week 7 – Instructor Solutions

1) Show all accounts.  

```sql
SELECT * 
FROM accounts;
```

2) Start a transaction.  

```sql
START TRANSACTION;
```

3) Transfer 200 from Alice (1) to Bob (2) using two UPDATEs.  

```sql
UPDATE accounts SET balance = balance - 200 WHERE acct_id=1; -- Alice
UPDATE accounts SET balance = balance + 200 WHERE acct_id=2; -- Bob
```

4) Rollback the transaction (verify balances unchanged).  

```sql
ROLLBACK;
SELECT * 
FROM accounts; -- balances unchanged
```

5) Repeat transfer and COMMIT (verify balances changed).  
  
```sql
START TRANSACTION;
UPDATE accounts SET balance = balance - 200 WHERE acct_id=1;
UPDATE accounts SET balance = balance + 200 WHERE acct_id=2;
COMMIT;
SELECT * FROM accounts; -- balances reflect transfer
```

6) Create an index on owner.  
 
```sql
CREATE INDEX idx_owner ON accounts(owner);
```

7) Show how to drop the index.  
  
```sql
DROP INDEX idx_owner ON accounts;
```


8) Add a CHECK-like constraint using trigger idea (explain).  
8) In MySQL 8 you can use CHECK (enforced), or a BEFORE UPDATE 
   trigger to prevent `balance < 0`.  
Example (conceptual):

```sql
/* Example trigger idea */
-- CREATE TRIGGER prevent_negative_balance
-- BEFORE UPDATE ON accounts
-- FOR EACH ROW
-- BEGIN
--   IF NEW.balance < 0 THEN
--     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Negative balance not allowed';
--   END IF;
-- END;
```

9) Show an atomic multi-row insert inside a transaction (and rollback).  
 
```sql
START TRANSACTION;
INSERT INTO accounts VALUES (4,'Dave',300.00),(5,'Erin',250.00);
ROLLBACK;
```

10) Demonstrate idempotent update (only if owner='Carol').  

```sql
UPDATE accounts 
SET balance=balance+50 
WHERE owner='Carol';
```
11) Explain when to add an index (short paragraph).  
11)  Add indexes when:
- You frequently filter/join on a column.
- The column has high cardinality.
- Writes are not overly impacted.

12) Write 3 best practices for schema design (bulleted). 
12) Best practices:
- Use meaningful data types and names.
- Normalize to reduce redundancy.
- Add primary/foreign keys and necessary indexes.
