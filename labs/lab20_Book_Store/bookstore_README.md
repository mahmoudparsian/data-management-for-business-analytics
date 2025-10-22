# Bookstore Database Sample Data

This package contains **sample data** for a fictional bookstore system with 4 tables:
- `stores`
- `customers`
- `books`
- `transactions`

Two sets of files are provided:
1. **CSV files** (`bookstore_csv_package.zip`) – can be imported with `LOAD DATA` or GUI tools like MySQL Workbench.
2. **SQL INSERT files** (`bookstore_sql_package.zip`) – can be run directly in MySQL.

---

## 1. Create Schema

Run these statements first to create your tables:

```sql
CREATE TABLE stores (
  store_id INT PRIMARY KEY AUTO_INCREMENT,
  store_location VARCHAR(100),
  city VARCHAR(50),
  country VARCHAR(50)
);

CREATE TABLE customers (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  gender ENUM('M','F','Other') DEFAULT 'Other',
  age INT,
  city VARCHAR(50),
  country VARCHAR(50)
);

CREATE TABLE books (
  book_id INT PRIMARY KEY AUTO_INCREMENT,
  ISBN VARCHAR(20) UNIQUE,
  title VARCHAR(200),
  author VARCHAR(100),
  category VARCHAR(50),
  published_date DATE
);

CREATE TABLE transactions (
  sale_id INT PRIMARY KEY AUTO_INCREMENT,
  store_id INT,
  book_id INT,
  customer_id INT,
  purchase_date DATE,
  price DECIMAL(8,2),
  FOREIGN KEY (store_id) REFERENCES stores(store_id),
  FOREIGN KEY (book_id) REFERENCES books(book_id),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
```

---

## 2. Load with SQL INSERT files

1. Open MySQL Workbench or the MySQL CLI.  
2. Select your database (e.g., `USE bookstore;`).  
3. Run the `.sql` files in this order (to satisfy foreign keys):

```bash
mysql -u root -p bookstore < stores.sql
mysql -u root -p bookstore < customers.sql
mysql -u root -p bookstore < books.sql
mysql -u root -p bookstore < transactions.sql
```

---

## 3. Load with CSV files

If you prefer CSV imports, use:

```sql
LOAD DATA LOCAL INFILE 'stores.csv'
INTO TABLE stores
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'books.csv'
INTO TABLE books
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'transactions.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS;
```

⚠️ Note: ensure you enable `LOCAL INFILE` in your MySQL server and client (`--local-infile` option).

---

## 4. Verify

After loading, try some queries:

```sql
SELECT COUNT(*) FROM stores;        -- should return 9
SELECT COUNT(*) FROM customers;     -- should return 121
SELECT COUNT(*) FROM books;         -- should return 205
SELECT COUNT(*) FROM transactions;  -- should return 901
```

---

Happy querying! 🎉
