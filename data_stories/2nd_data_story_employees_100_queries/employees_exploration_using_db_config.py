"""
employees_exploration_dbconfig.py
Load database config from db_config.json, connect to MySQL,
fetch employees table, and explore/visualize data.
"""

import json
import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt

# Load DB config
with open("db_config.json") as f:
    config = json.load(f)

# Connect
conn = mysql.connector.connect(
    host=config["host"],
    user=config["user"],
    password=config["password"],
    database=config["database"]
)

# Query
df = pd.read_sql("SELECT * FROM employees;", conn)
conn.close()

# Exploration
print("Shape:", df.shape)
print("\nHead:\n", df.head())
print("\nDescribe (numeric):\n", df[["salary","age"]].describe())

# Aggregations
dept_agg = df.groupby("department").agg(
    headcount=("emp_id","count"),
    avg_salary=("salary","mean"),
    avg_age=("age","mean")
).reset_index().sort_values("headcount", ascending=False)
print("\nDepartment summary:\n", dept_agg)

country_agg = df.groupby("country").agg(
    headcount=("emp_id","count"),
    avg_salary=("salary","mean")
).reset_index().sort_values("headcount", ascending=False)
print("\nCountry summary:\n", country_agg)

# Plots
plt.figure()
dept_agg.plot(x="department", y="headcount", kind="bar", legend=False, title="Headcount by Department")
plt.tight_layout()
plt.savefig("headcount_by_department.png")

plt.figure()
dept_agg.plot(x="department", y="avg_salary", kind="bar", legend=False, title="Average Salary by Department")
plt.tight_layout()
plt.savefig("avg_salary_by_department.png")

plt.figure()
country_agg.plot(x="country", y="headcount", kind="bar", legend=False, title="Headcount by Country")
plt.tight_layout()
plt.savefig("headcount_by_country.png")

plt.figure()
df["salary"].plot(kind="hist", bins=10, title="Salary Distribution")
plt.tight_layout()
plt.savefig("salary_distribution.png")

plt.figure()
df.plot(x="age", y="salary", kind="scatter", title="Age vs Salary")
plt.tight_layout()
plt.savefig("age_vs_salary.png")

print("\nSaved figures:")
print(" - headcount_by_department.png")
print(" - avg_salary_by_department.png")
print(" - headcount_by_country.png")
print(" - salary_distribution.png")
print(" - age_vs_salary.png")
