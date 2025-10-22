# sales_analysis_mysql.py
import pandas as pd
import matplotlib.pyplot as plt
import mysql.connector

# --------------------------
# Step 1: Connect to MySQL
# --------------------------
conn = mysql.connector.connect(
    host="localhost",      # change if needed
    user="root",           # your MySQL username
    password="yourpassword",  # your MySQL password
    database="testdb"      # your database name
)

query = "SELECT * FROM sales"
df = pd.read_sql(query, conn)
conn.close()

# --------------------------
# Step 2: Exploratory Analysis
# --------------------------
print("=== First 5 Rows ===")
print(df.head(), "\n")

print("=== Info ===")
print(df.info(), "\n")

print("=== Summary Statistics ===")
print(df.describe(), "\n")

# --------------------------
# Step 3: Group By Operations
# --------------------------
print("=== Total quantity per region ===")
print(df.groupby("region")["quantity"].sum(), "\n")

print("=== Average price per product ===")
print(df.groupby("product")["price"].mean(), "\n")

print("=== Total revenue per region ===")
df["revenue"] = df["quantity"] * df["price"]
print(df.groupby("region")["revenue"].sum(), "\n")

print("=== Total revenue per region & product ===")
print(df.groupby(["region", "product"])["revenue"].sum(), "\n")

# --------------------------
# Step 4: Visualizations
# --------------------------
# Quantity per region
df.groupby("region")["quantity"].sum().plot(kind="bar", title="Total Quantity per Region")
plt.ylabel("Quantity")
plt.show()

# Average price per product
df.groupby("product")["price"].mean().plot(kind="bar", color="orange", title="Average Price per Product")
plt.ylabel("Average Price")
plt.show()

# Revenue per region
df.groupby("region")["revenue"].sum().plot(kind="bar", color="green", title="Total Revenue per Region")
plt.ylabel("Revenue")
plt.show()
