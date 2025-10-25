"""
employees_exploration.py
Load the 50 employees and perform exploration & visualization.

Usage:
  python employees_exploration.py
"""

"""
employees_exploration.py
Connect to a MySQL database, read the employees table,
and perform exploration & visualization.

Usage:
  python employees_exploration.py
"""

import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt

# ---------- Database connection ----------
# Update with your MySQL credentials
conn = mysql.connector.connect(
    host="localhost",     # or your DB host
    user="root",          # your MySQL username
    password="password",  # your MySQL password
    database="testdb"     # database name containing employees table
)

query = "SELECT * FROM employees;"
df = pd.read_sql(query, conn)
conn.close()

# ---------- Basic info & stats ----------
print("Shape:", df.shape)
print("\nHead:\n", df.head())
print("\nDescribe (numeric):\n", df[["salary", "age"]].describe())

print("\nCounts by department:\n", df["department"].value_counts())
print("\nCounts by country:\n", df["country"].value_counts())
print("\nCounts by gender:\n", df["gender"].value_counts())

# ---------- Aggregations ----------
dept_agg = df.groupby("department").agg(
    headcount=("emp_id", "count"),
    avg_salary=("salary", "mean"),
    avg_age=("age", "mean")
).reset_index().sort_values("headcount", ascending=False)
print("\nDepartment summary:\n", dept_agg)

country_agg = df.groupby("country").agg(
    headcount=("emp_id", "count"),
    avg_salary=("salary", "mean")
).reset_index().sort_values("headcount", ascending=False)
print("\nCountry summary:\n", country_agg)

# ---------- Plots ----------
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
