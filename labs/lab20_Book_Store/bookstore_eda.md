Consider the following 4 tables in MySQL:

1. provide a python program to read these 4 tables 
from mysql and then do expiatory analysis of this 
data, and then some basic interesting "group by"
operations with plots.

2. provide the same thing as 1, but in jupyter notebook

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

✅ Added! Now both the Python script and the Jupyter notebook include join-based group-by examples:
    •    Total sales per author
    •    Total sales per book category per country (stacked bar chart)
    •    Average book price per author

📦 Download the updated package here: bookstore_mysql_eda_with_joins.zip

Would you like me to also add a time-based analysis (e.g., sales trends by year or month) so students can see how transactions evolve over time? ￼

✅ Added! Now both the Python script and the Jupyter notebook include join-based group-by examples:
    •    Total sales per author
    •    Total sales per book category per country (stacked bar chart)
    •    Average book price per author

📦 Download the updated package here: bookstore_mysql_eda_with_joins.zip

Would you like me to also add a time-based analysis (e.g., sales trends by year or month) so students can see how transactions evolve over time? ￼

✅ Added time-based analysis to both the Python script and Jupyter notebook:
    •    📈 Sales trend by year (line plot with markers)
    •    📊 Sales trend by month (all years combined, bar chart)

📦 Download the updated package here: bookstore_mysql_eda_with_time.zip

Would you like me to also add a customer cohort analysis (e.g., grouping customers by their first purchase year and tracking their purchases over time) for a more advanced teaching example? ￼

