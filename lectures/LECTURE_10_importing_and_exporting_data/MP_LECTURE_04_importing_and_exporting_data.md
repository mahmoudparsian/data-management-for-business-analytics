# 📊 Importing & Exporting Data in MySQL

	Using mysql, create a comprehensive set of slides  
	for importing and exporting data from database tables. Give a concrete and simple example
  for each case and scenarios

---

# 🔹 Why Import & Export Data?

- Move data between systems
- Backup & restore
- Share with others
- Load large datasets efficiently

---

# 🔹 Methods for Exporting Data

1. `mysqldump` (common for backups)
2. `SELECT ... INTO OUTFILE` (write query results to file)
3. `MySQL Workbench` GUI export

---

# 📤 Example 1: Export Entire Database with `mysqldump`
```bash
mysqldump -u root -p mydatabase > mydatabase_backup.sql
```
✅ Saves all tables and data into a `.sql` file.  
✅ You can later import it back.

---

# 📤 Example 2: Export a Single Table
```bash
mysqldump -u root -p mydatabase customers > customers_backup.sql
```
✅ Only exports the `customers` table.

---

# 📤 Example 3: Export Query Results to CSV
```sql
SELECT customer_id, name, country
FROM customers
INTO OUTFILE '/tmp/customers.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
```
✅ Writes query results to `customers.csv`.

---

# 🔹 Methods for Importing Data

1. Import `.sql` files (restore)
2. `LOAD DATA INFILE` (fast CSV import)
3. `MySQL Workbench` GUI import

---

# 📥 Example 1: Import SQL File
```bash
mysql -u root -p mydatabase < mydatabase_backup.sql
```
✅ Restores tables & data.

---

# 📥 Example 2: Import CSV with `LOAD DATA INFILE`
```sql
LOAD DATA INFILE '/tmp/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(customer_id, name, country);
```
✅ Quickly loads CSV rows into `customers` table.

---

# 📥 Example 3: Insert Data via Workbench
- Open **MySQL Workbench**
- Right-click table → **Table Data Import Wizard**
- Choose CSV → Map columns → Finish

---

# 🔎 Practical Scenario: Data Sharing
- Export customer data:
```sql
SELECT * FROM customers
INTO OUTFILE '/tmp/customers_export.csv'
FIELDS TERMINATED BY ',';
```
- Send file to partner  
- Partner imports using:
```sql
LOAD DATA INFILE '/tmp/customers_export.csv' INTO TABLE customers;
```

---

# 📝 Best Practices
- Ensure file permissions (MySQL must read/write to directory)
- Use proper delimiters (`,` or `;`)
- Use `ENCLOSED BY '"'` for text with commas
- Always backup before importing

---

# ✅ Summary
- **Export:** `mysqldump`, `SELECT ... INTO OUTFILE`
- **Import:** `mysql < file.sql`, `LOAD DATA INFILE`
- **GUI tools:** MySQL Workbench
- Useful for backups, migrations, data loading

---

