# 📝 MySQL Command Line Cheat Sheet

## 🔹 Starting MySQL

~~~
mysql -u root -p             # login as root (will ask password)
mysql -u username -p dbname  # login directly into a database
~~~

⸻

## 🔹 General CLI Commands

~~~
\q              # quit / exit MySQL
\h              # help
\c              # clear current input
status;         # show connection info
~~~

⸻

## 🔹 Database Operations

~~~
SHOW DATABASES;               # list databases
CREATE DATABASE testdb;       # create new database
USE testdb;                   # switch to database
DROP DATABASE testdb;         # delete database
~~~

⸻

## 🔹 Table Operations

~~~mysql
SHOW TABLES;                   # list tables in current DB

DESCRIBE users;                # show table structure

CREATE TABLE users (           # create table
   id INT PRIMARY KEY,
   name VARCHAR(50)
); 
                            
DROP TABLE users;              # delete table
~~~

⸻

## 🔹 Data Operations

~~~mysql
INSERT INTO users VALUES (1, 'Alice');       # insert row

SELECT * FROM users;                         # query table

UPDATE users SET name='Bob' WHERE id=1;      # update row

DELETE FROM users WHERE id=1;                # delete row
~~~

⸻

🔹 Running Scripts

~~~
mysql -u root -p < script.sql       # run SQL file

source /path/to/script.sql;         # run SQL inside MySQL prompt
~~~

⸻

## 🔹 User Management

~~~mysql
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON testdb.* TO 'newuser'@'localhost';
FLUSH PRIVILEGES;     # apply changes
~~~

⸻

## 🔹 Useful Options

~~~
mysql -u root -p --table     # outputs results in table format
mysql -u root -p --silent    # less verbose output
mysql -u root -p --execute "SHOW DATABASES;"   # run one command
~~~

⸻

