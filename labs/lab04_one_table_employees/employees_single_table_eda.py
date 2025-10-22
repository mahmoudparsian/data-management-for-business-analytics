# employees_single_table_eda.py
import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# ---- MySQL connection ----
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="your_password",
    database="your_db"
)

# ---- Load data ----
employees_df = pd.read_sql("SELECT * FROM employees", conn)
print("Employees Table:")
print(employees_df.head())

# ---- Exploratory Analysis ----
print("\nSummary Statistics:")
print(employees_df.describe())

# Distribution of departments
sns.countplot(data=employees_df, x="department", order=employees_df["department"].value_counts().index)
plt.title("Number of Employees per Department")
plt.show()

# Average salary per department
avg_salary = employees_df.groupby("department")["salary"].mean().reset_index()
sns.barplot(data=avg_salary, x="department", y="salary")
plt.title("Average Salary per Department")
plt.show()

# Salary distribution
sns.histplot(employees_df["salary"], bins=10, kde=True)
plt.title("Salary Distribution")
plt.show()

# Age distribution per department
sns.boxplot(data=employees_df, x="department", y="age")
plt.title("Age Distribution per Department")
plt.show()

conn.close()
