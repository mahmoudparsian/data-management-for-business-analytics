# students_single_table_eda.py
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
students_df = pd.read_sql("SELECT * FROM students", conn)
print("Students Table:")
print(students_df.head())

# ---- Exploratory Analysis ----
print("\nSummary Statistics:")
print(students_df.describe())

# Distribution of grade levels
sns.countplot(data=students_df, x="grade_level", order=students_df["grade_level"].value_counts().index)
plt.title("Number of Students per Grade Level")
plt.show()

# Average GPA per grade level
avg_gpa = students_df.groupby("grade_level")["gpa"].mean().reset_index()
sns.barplot(data=avg_gpa, x="grade_level", y="gpa")
plt.title("Average GPA per Grade Level")
plt.show()

# GPA distribution by enrollment status
sns.boxplot(data=students_df, x="enrolled", y="gpa")
plt.title("GPA Distribution by Enrollment Status")
plt.show()

# Average age per grade level
avg_age = students_df.groupby("grade_level")["age"].mean().reset_index()
sns.barplot(data=avg_age, x="grade_level", y="age")
plt.title("Average Age per Grade Level")
plt.show()

conn.close()
