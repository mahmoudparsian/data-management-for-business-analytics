-- -----------------------------
-- Books-on-Cities: MySQL Schema
-- -----------------------------

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS stores;

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
