"""
consider the following schema in mysql: employees(
  emp_id, 
  first_name, 
  last_name, 
  age, 
  degree, 
  gender, 
  country, 
  department, 
  hire_date, 
  salary
)  provide a python program to read employee table from mysql and then do expiatory analysis of this data, and then some basic group by of age, degree, country, department: show graphs for understandings of data


Got it 👍 You want a Python program that:
    1.    Connects to MySQL and reads the employees table into a Pandas DataFrame.
    2.    Performs exploratory data analysis (EDA): summary stats, missing values, distributions.
    3.    Runs some basic GROUP BY aggregations: by age, degree, country, department.
    4.    Shows graphs (bar plots, histograms, boxplots, etc.) for better understanding.

⸻

✅ What this program does:
    •    Connects to MySQL, pulls the employees table into a Pandas DataFrame.
    •    Prints out info, summary stats, missing values.
    •    Creates graphs:
    •    Histogram of age
    •    Histogram of salary
    •    Gender countplot
    •    Average salary by degree (bar plot)
    •    Average salary by country (bar plot)
    •    Employees per department (bar plot)
    •    Age distribution per department (box plot)

⸻

⚡ You’ll need to install dependencies if not installed:

pip install pandas mysql-connector-python matplotlib seaborn

Here’s a complete Python program 👇

⸻
"""

import pandas as pd
import mysql.connector
import matplotlib.pyplot as plt
import seaborn as sns

# -------------------------------
# 1. Connect to MySQL and read data
# -------------------------------
def load_employees():
    conn = mysql.connector.connect(
        host="localhost",   # change if needed
        user="root",        # change if needed
        password="mp22pass", # change if needed
        database="test_db" # change if needed
    )
    query = "SELECT * FROM employees;"
    df = pd.read_sql(query, conn)
    conn.close()
    return df

# -------------------------------
# 2. Exploratory Data Analysis
# -------------------------------
def exploratory_analysis(df):
    print("First 5 rows:")
    print(df.head())
    print("\nData Info:")
    print(df.info())
    print("\nSummary Statistics:")
    print(df.describe(include='all'))
    print("\nMissing Values:")
    print(df.isnull().sum())

    # Histogram of ages
    plt.figure(figsize=(8,5))
    sns.histplot(df['age'], bins=20, kde=True)
    plt.title("Age Distribution of Employees")
    plt.show()

    # Salary distribution
    plt.figure(figsize=(8,5))
    sns.histplot(df['salary'], bins=20, kde=True)
    plt.title("Salary Distribution of Employees")
    plt.show()

    # Gender distribution
    plt.figure(figsize=(6,4))
    sns.countplot(x='gender', data=df)
    plt.title("Gender Distribution")
    plt.show()

# -------------------------------
# 3. Basic Group By analysis
# -------------------------------
def groupby_analysis(df):
    # Average salary by degree
    avg_salary_degree = df.groupby("degree")['salary'].mean().reset_index()
    print("\nAverage Salary by Degree:")
    print(avg_salary_degree)

    plt.figure(figsize=(8,5))
    sns.barplot(x="degree", y="salary", data=avg_salary_degree)
    plt.title("Average Salary by Degree")
    plt.xticks(rotation=45)
    plt.show()

    # Average salary by country
    avg_salary_country = df.groupby("country")['salary'].mean().reset_index()
    plt.figure(figsize=(8,5))
    sns.barplot(x="country", y="salary", data=avg_salary_country)
    plt.title("Average Salary by Country")
    plt.xticks(rotation=45)
    plt.show()

    # Employees count by department
    dept_count = df['department'].value_counts().reset_index()
    dept_count.columns = ["department", "count"]
    plt.figure(figsize=(8,5))
    sns.barplot(x="department", y="count", data=dept_count)
    plt.title("Employees per Department")
    plt.xticks(rotation=45)
    plt.show()

    # Age distribution per department (boxplot)
    plt.figure(figsize=(10,6))
    sns.boxplot(x="department", y="age", data=df)
    plt.title("Age Distribution per Department")
    plt.xticks(rotation=45)
    plt.show()

# -------------------------------
# Main Execution
# -------------------------------
if __name__ == "__main__":
    employees_df = load_employees()
    exploratory_analysis(employees_df)
    groupby_analysis(employees_df)
