-- Books-on-Cities — LOAD DATA INFILE scripts
-- Usage (CLI):
--   mysql --local-infile=1 -u root -p
-- Then inside MySQL:
--   USE books_on_cities;
--   SOURCE books_on_cities_schema.sql;   -- if not created yet
--   SOURCE load_data_infile.sql;

-- If LOCAL is not allowed, enable in client or server, or move CSVs into secure-file-priv directory.

-- Paths: When using LOCAL, MySQL reads from the CLIENT machine.
-- Place the CSVs in the same folder as your MySQL client or give absolute paths.

LOAD DATA LOCAL INFILE 'data/stores.csv'
INTO TABLE stores
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(store_id, store_location, city, country);

LOAD DATA LOCAL INFILE 'data/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id, name, email, gender, age, city, country);

LOAD DATA LOCAL INFILE 'data/books.csv'
INTO TABLE books
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(book_id, ISBN, title, author, category, published_date);

LOAD DATA LOCAL INFILE 'data/transactions.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(sale_id, store_id, book_id, customer_id, purchase_date, price);