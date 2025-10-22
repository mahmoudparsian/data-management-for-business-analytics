# 📦 Simple ETL

	Let's create a very simple ETL in python: 

	1. Read a CSV file with 100 records: meaningful data. 

	2. Then create a DataFrame, then perform 2 meaningful 
	simple transformations, 
	
	3. finally load it to mysql table. 


Here’s a simple ETL pipeline in Python:

It includes:
    1.    employees.csv → raw data (100 records)
    2.    employees_transformed.csv → after 2 transformations
    •    Added a tax column (20% of salary)
    •    Increased salary by 10% for IT employees
    3.    load_to_mysql.sql → SQL script to create a MySQL table
          and insert transformed records

