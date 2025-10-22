"""
pip install sqlalchemy pymysql
"""


"""
Database setup:

use company;

CREATE TABLE employees_new (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    salary DECIMAL(10,2),
    department VARCHAR(50),
    tax DECIMAL(10,2)
);

mysql> use company;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql>
mysql> CREATE TABLE employees_new (
    ->     id INT PRIMARY KEY,
    ->     name VARCHAR(50),
    ->     age INT,
    ->     salary DECIMAL(10,2),
    ->     department VARCHAR(50),
    ->     tax DECIMAL(10,2)
    -> );
Query OK, 0 rows affected (0.01 sec)

"""
import pandas as pd
import numpy as np
from sqlalchemy import create_engine

# -----------------------
# 1. Extract
# -----------------------
df = pd.read_csv("employees.csv")
print("original df=", df)

# -----------------------
# 2. Transform
# -----------------------

#-------------------------------------------------
# Transformation 1: Add tax column (20% of salary)
#-------------------------------------------------
df["tax"] = df["salary"] * 0.2

#-------------------------------------------------
# Transformation 2: Increase salary by 10% for IT employees
#-------------------------------------------------
df.loc[df["department"] == "IT", "salary"] *= 1.1


# Save transformed data
df.to_csv("employees_transformed.csv", index=False)
print("transformed df=", df)

# -----------------------
# 3. Load (to MySQL)
# -----------------------
# Replace placeholders with your own MySQL credentials
username = "root"
password = "mp22pass"
host = "localhost"
port = 3306
database = "company"

# Create SQLAlchemy engine
engine = create_engine(f"mysql+pymysql://{username}:{password}@{host}:{port}/{database}")

# Write the DataFrame to MySQL (replace if exists)
df.to_sql("employees_new", con=engine, if_exists="replace", index=False)

print("ETL completed: Data loaded into MySQL table 'employees_new'")