"""
Let's create a sample employee.csv file with 10 records, 
then write a working python program to read this CSV file 
and load it to mysql database, be as detail as possible.

Great task 👍 — 
let’s do this step by step. We’ll:

    1.    Create a sample employee.csv file with 10 rows.
    2.    Create a MySQL table schema.
    3.    Write a Python program that:
    		•    Reads the CSV file.
    		•    Connects to MySQL.
    		•    Creates the employee table if it doesn’t exist.
    		•    Inserts the rows into the table.

⸻

1. Sample employee.csv

Let’s make a simple CSV file with the following columns:
emp_id, first_name, last_name, department, salary, hire_date

Here’s the content of employee.csv:

emp_id,first_name,last_name,department,salary,hire_date
1,John,Doe,Engineering,75000,2018-03-15
2,Jane,Smith,HR,60000,2019-06-01
3,Robert,Brown,Finance,82000,2017-11-20
4,Linda,Johnson,Engineering,95000,2015-05-23
5,Michael,Williams,Marketing,67000,2020-01-12
6,Susan,Jones,Finance,73000,2016-09-18
7,David,Miller,Engineering,88000,2014-07-09
8,Karen,Davis,Sales,64000,2021-02-25
9,James,Wilson,Marketing,70000,2019-10-10
10,Patricia,Moore,HR,62000,2018-12-05

Save this as employee.csv.
⸻

2. MySQL Table Schema

We’ll create a table named employee in a database called test_db2.

CREATE DATABASE IF NOT EXISTS test_db2;

mysql> CREATE DATABASE IF NOT EXISTS test_db2;
Query OK, 1 row affected (0.00 sec)

mysql> use test_db2;
Database changed
mysql> show tables;
Empty set (0.00 sec)

USE test_db2;

CREATE TABLE IF NOT EXISTS employee (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);


⸻
"""
#---------------
# Python Program
#---------------

"""
We’ll use mysql-connector-python (official MySQL driver).
If you don’t have it, install via:

pip install mysql-connector-python pandas
"""

import sys
import pandas as pd
import mysql.connector
from mysql.connector import Error

#------------------------------------------
# function to create a database connection
#------------------------------------------
def get_db_connection():
    connection = mysql.connector.connect(
        host="localhost",      # change if not local
        user="root",           # replace with your MySQL username
        password="mp22pass",   # replace with your MySQL password
        database="test_db2"    # ensure this DB exists
    )
    #
    return connection
#end-def

#----------------------------------------------
# function to define table creation in database
#----------------------------------------------
def get_table_creation():
    create_table_query = """
        CREATE TABLE IF NOT EXISTS employee (
            emp_id INT PRIMARY KEY,
            first_name VARCHAR(50),
            last_name VARCHAR(50),
            department VARCHAR(50),
            salary DECIMAL(10,2),
            hire_date DATE
        )
    """
    #
    return create_table_query
#end-def

#----------------------------------------------
# function to define INSERT query to database
#----------------------------------------------
def get_insert_statement():
    insert_query = """
        INSERT INTO employee (emp_id, first_name, last_name, department, salary, hire_date)
            VALUES (%s, %s, %s, %s, %s, %s)
            ON DUPLICATE KEY UPDATE
                first_name=VALUES(first_name),
                last_name=VALUES(last_name),
                department=VALUES(department),
                salary=VALUES(salary),
                hire_date=VALUES(hire_date)
    """
    #
    return insert_query
#end-def

#------------------------------------------
# Main python deriver starts here...
#------------------------------------------

# Step 1: Load CSV into pandas DataFrame
# csv_file = "employee.csv"
csv_file = sys.argv[1]
print("csv_file=", csv_file)

# Read CSV file and create a DataFrame
df = pd.read_csv(csv_file)
print("df=", df)

# Step 2: Connect to MySQL
try:
    connection = get_db_connection()

    if connection.is_connected():
        print("✅ Connected to MySQL database")
        
        create_table_query = get_table_creation()

        cursor = connection.cursor()

        # Step 3: Create table if not exists
        cursor.execute(create_table_query)
        print("✅ Employee table is ready")

        # Step 4: Insert data from DataFrame
        insert_query = get_insert_statement()

        for row_number, row in df.iterrows():
            data_tuple = (
                int(row["emp_id"]),
                row["first_name"],
                row["last_name"],
                row["department"],
                float(row["salary"]),
                row["hire_date"]
            )
            cursor.execute(insert_query, data_tuple)
            print("row number is inserted:", row_number)
        #end-for

        connection.commit()
        print(f"✅ {cursor.rowcount} rows inserted/updated successfully")

except Error as e:
    print("❌ Error while connecting to MySQL:", e)

finally:
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("🔒 MySQL connection closed")


"""

4. Run & Verify
    1.    Save the script as load_employee.py.
    2.    Run:

python load_employee.py

    3.    Verify in MySQL:

USE test_db2;
SELECT * FROM employee;

"""
