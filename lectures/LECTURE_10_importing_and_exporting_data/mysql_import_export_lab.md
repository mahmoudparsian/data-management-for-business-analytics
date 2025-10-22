# 🧪 MySQL Lab: Importing & Exporting Data

### Dataset: Customers & Orders  

We will use the provided **demo dataset** (`demo_dataset.sql`, `customers.csv`, `orders.csv`).

---

# 🔹 Step 1: Setup Database

```sql
CREATE DATABASE demo_db;
USE demo_db;
```

---

# 🔹 Step 2: Import from SQL File

### Using CLI:
```bash
mysql -u root -p demo_db < demo_dataset.sql
```

✅ This creates the `customers` and `orders` tables and loads sample data.

---

# 🔹 Step 3: Verify Imported Data

```sql
SELECT * FROM customers;
SELECT * FROM orders;
```

✅ You should see 5 customers and 8 orders.

---

# 🔹 Step 4: Export Data to CSV

### Export `customers` table to CSV:
```sql
SELECT * FROM customers
INTO OUTFILE '/tmp/customers_export.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
```

### Export `orders` table to CSV:
```sql
SELECT * FROM orders
INTO OUTFILE '/tmp/orders_export.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
```

✅ Files will be created in `/tmp/` (ensure MySQL has permission).

---

# 🔹 Step 5: Import from CSV

### Load Customers from CSV:
```sql
LOAD DATA INFILE '/tmp/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(customer_id, name, email, country);
```

### Load Orders from CSV:
```sql
LOAD DATA INFILE '/tmp/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(order_id, customer_id, amount, year);
```

✅ Quickly loads data from CSV files into MySQL.

---

# 🔹 Step 6: Export/Import via SQL Dump

### Export Database to SQL file:
```bash
mysqldump -u root -p demo_db > demo_db_backup.sql
```

### Import Database from SQL file:
```bash
mysql -u root -p demo_db < demo_db_backup.sql
```

✅ Useful for backup & restore.

---

# 🔎 Key Takeaways

- **Export options:** `mysqldump`, `SELECT ... INTO OUTFILE`
- **Import options:** `mysql < file.sql`, `LOAD DATA INFILE`
- **CSV imports/exports** are best for large tabular datasets.
- **SQL dump** is best for full backup & restore.

---

# 🎯 Lab Tasks for Students

1. Export `customers` table to CSV.  
2. Delete all rows in `customers`, then re-import from CSV.  
3. Export `orders` table to SQL using `mysqldump`.  
4. Drop the `orders` table, then restore from the SQL dump.  
5. Try importing/exporting using MySQL Workbench GUI.

---
