# Week 7 – Instructor Solutions

1)  
```sql
SELECT * FROM accounts;
```

2)  
```sql
START TRANSACTION;
```

3)  
```sql
UPDATE accounts SET balance = balance - 200 WHERE acct_id=1; -- Alice
UPDATE accounts SET balance = balance + 200 WHERE acct_id=2; -- Bob
```

4)  
```sql
ROLLBACK;
SELECT * FROM accounts; -- balances unchanged
```

5)  
```sql
START TRANSACTION;
UPDATE accounts SET balance = balance - 200 WHERE acct_id=1;
UPDATE accounts SET balance = balance + 200 WHERE acct_id=2;
COMMIT;
SELECT * FROM accounts; -- balances reflect transfer
```

6)  
```sql
CREATE INDEX idx_owner ON accounts(owner);
```

7)  
```sql
DROP INDEX idx_owner ON accounts;
```

8)  In MySQL 8 you can use CHECK (enforced), or a BEFORE UPDATE trigger to prevent `balance < 0`.  
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

9)  
```sql
START TRANSACTION;
INSERT INTO accounts VALUES (4,'Dave',300.00),(5,'Erin',250.00);
ROLLBACK;
```

10)  
```sql
UPDATE accounts SET balance=balance+50 WHERE owner='Carol';
```

11)  Add indexes when:
- You frequently filter/join on a column.
- The column has high cardinality.
- Writes are not overly impacted.

12) Best practices:
- Use meaningful data types and names.
- Normalize to reduce redundancy.
- Add primary/foreign keys and necessary indexes.
