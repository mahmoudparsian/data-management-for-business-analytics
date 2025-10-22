The Interview Question
You’re interviewing at a fintech startup. They say:

“Our user_transactions table has duplicate records. 
Some users appear multiple times with the 
same transaction ID, amount, and timestamp. 
Write a SQL query to identify and remove duplicates 
while keeping only one record per unique transaction."

This is a classic data quality problem — and one that 
separates junior from senior engineers.


Got it 👍 — this is a classic deduplication problem in SQL.
We want to keep one row per unique transaction 
(transaction_id, amount, timestamp) and remove the duplicates.

Here’s how you can do it:

⸻

Step 1: Identify duplicates

SELECT 
    transaction_id,
    amount,
    timestamp,
    COUNT(*) AS duplicate_count
FROM user_transactions
GROUP BY transaction_id, amount, timestamp
HAVING COUNT(*) > 1;

This will show you which transactions appear more than once.

⸻

Step 2: Remove duplicates (keep one)

You can use a CTE with ROW_NUMBER():

WITH cte AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (
            PARTITION BY transaction_id, amount, timestamp 
            ORDER BY transaction_id
        ) AS rn
    FROM user_transactions
)
DELETE FROM user_transactions
WHERE id IN (
    SELECT id FROM cte WHERE rn > 1
);

🔑 Notes:
    •    id here is assumed to be the primary key column of user_transactions.
    •    The ROW_NUMBER() assigns 1 to the first row of each duplicate set; rows with rn > 1 are true duplicates and will be deleted.
    •    If your SQL dialect doesn’t support CTE DELETE, you can replace it with a subquery or join.

⸻

Alternative (create deduped table)

If you prefer to create a clean version instead of deleting directly:

CREATE TABLE user_transactions_dedup AS
SELECT 
    transaction_id,
    amount,
    timestamp
FROM user_transactions
GROUP BY transaction_id, amount, timestamp;

👉 Do you want me to adapt this query for a specific SQL dialect 
(MySQL, PostgreSQL, Snowflake, etc.)? Some databases differ slightly 
in how DELETE with CTE works.

yes, MySQL:

Perfect 👍 In MySQL, the trick is that DELETE ... JOIN is usually the 
cleanest way to handle duplicate removal, since MySQL doesn’t allow a 
DELETE directly from a CTE.

Here’s the MySQL solution:

⸻

Step 1: Identify duplicates

SELECT 
    transaction_id,
    amount,
    timestamp,
    COUNT(*) AS duplicate_count
FROM user_transactions
GROUP BY transaction_id, amount, timestamp
HAVING COUNT(*) > 1;

Step 2: Remove duplicates but keep one

We use MySQL’s ROW_NUMBER() (available in MySQL 8.0+):

WITH ranked AS (
    SELECT 
        id,
        ROW_NUMBER() OVER (
            PARTITION BY transaction_id, amount, timestamp 
            ORDER BY id
        ) AS rn
    FROM user_transactions
)
DELETE ut
FROM user_transactions ut
JOIN ranked r ON ut.id = r.id
WHERE r.rn > 1;

✅ Explanation:
    •    ROW_NUMBER() partitions rows by (transaction_id, amount, timestamp) → duplicates get ranked.
    •    rn = 1 is kept, all others (rn > 1) are removed.
    •    id is assumed to be the primary key of the table.

If you’re on MySQL < 8.0 (no window functions)

Use a self-join trick:

DELETE ut1
FROM user_transactions ut1
JOIN user_transactions ut2
  ON ut1.transaction_id = ut2.transaction_id
 AND ut1.amount = ut2.amount
 AND ut1.timestamp = ut2.timestamp
 AND ut1.id > ut2.id;

✅ Explanation:
    •    For each duplicate pair, the row with the larger id gets deleted.
    •    Leaves only the first inserted row for each unique (transaction_id, amount, timestamp).

