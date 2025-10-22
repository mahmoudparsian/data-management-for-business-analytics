# Multiple ways to load CSV data into MySQL 

Below are 5 practical approaches with examples:

⸻

## ✅ 1. Using MySQL’s Client programs: MySQL Workbench 

----

## ✅ 2. Using MySQL’s LOAD DATA INFILE (fastest native way)

-- Create table

~~~sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    salary DECIMAL(10,2),
    department VARCHAR(50)
);
~~~

-- Load CSV into MySQL

~~~
LOAD DATA INFILE '/path/to/employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, name, age, salary, department);
~~~

📌 Notes:

    •    Requires LOCAL INFILE privilege enabled.
    •    Very fast for large files.
    •    Path must be accessible to the MySQL server.

⸻

## ✅ 3. Using mysqlimport command-line tool

~~~
mysqlimport --local --user=root --password=your_password \
--fields-terminated-by=',' --lines-terminated-by='\n' \
--ignore-lines=1 etl_demo /path/to/employees.csv
~~~

📌 Notes:

    •    mysqlimport is a wrapper around LOAD DATA.
    •    The CSV filename should match the table name (or use --columns).

⸻

## ✅ 4. Using Python pandas.to_sql() (via SQLAlchemy + PyMySQL)

~~~python
import pandas as pd
from sqlalchemy import create_engine

# Read CSV
df = pd.read_csv("employees.csv")

# Create MySQL connection (replace credentials)
engine = create_engine("mysql+pymysql://root:your_password@localhost:3306/etl_demo")

# Write DataFrame to MySQL table
df.to_sql("employees", con=engine, if_exists="replace", index=False)
~~~

📌 Notes:

    •    Very flexible for ETL pipelines.
    •    Converts DataFrame schema automatically into SQL table schema.

⸻

## ✅ 5. Using Python csv + executemany() (manual inserts)

~~~python
import csv
import mysql.connector

# Connect to MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="your_password",
    database="etl_demo"
)
cursor = conn.cursor()

# Create table
cursor.execute("""
CREATE TABLE IF NOT EXISTS employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    salary DECIMAL(10,2),
    department VARCHAR(50)
)
""")

# Insert from CSV
with open("employees.csv", "r") as f:
    reader = csv.reader(f)
    next(reader)  # skip header
    rows = [tuple(row) for row in reader]

cursor.executemany("INSERT INTO employees (id, name, age, salary, department) VALUES (%s, %s, %s, %s, %s)", rows)

conn.commit()
cursor.close()
conn.close()
~~~

📌 Notes:

    •    Good for smaller datasets.
    •    Slower than LOAD DATA for very large CSVs.

⸻

## 🔎 Summary

    •    Best performance → LOAD DATA INFILE or mysqlimport
    •    Best for Python ETL workflows → pandas.to_sql()
    •    Best for fine control of inserts → Python executemany()

⸻

