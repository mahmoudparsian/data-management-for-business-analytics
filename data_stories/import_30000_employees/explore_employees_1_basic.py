import pandas as pd
import mysql.connector

# Connect to MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="password",
    database="world"
)

# Load employees table
df = pd.read_sql("SELECT * FROM employees", conn)

print("Shape:", df.shape)
print("\nSchema:")
print(df.dtypes)
print("\nFirst 5 rows:")
print(df.head())

print("\nSummary Statistics:")
print(df.describe(include="all"))

print("\nNull values per column:")
print(df.isnull().sum())

print("\nUnique values per column:")
print(df.nunique())

print("\nTop 5 departments by avg salary:")
print(df.groupby("department")["salary"].mean().sort_values(ascending=False).head())

print("\nAvg salary by country:")
print(df.groupby("country")["salary"].mean())

print("\nCount employees per position:")
print(df["position"].value_counts())

conn.close()
