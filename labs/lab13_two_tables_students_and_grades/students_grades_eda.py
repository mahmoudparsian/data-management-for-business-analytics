# students_grades_eda.py
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
grades_df = pd.read_sql("SELECT * FROM grades", conn)

print("Students Table:")
print(students_df.head())
print("\nGrades Table:")
print(grades_df.head())

# ---- Merge for analysis ----
df = grades_df.merge(students_df, on="student_id", how="left")

# ---- Exploratory Analysis ----
print("\nSummary Statistics:")
print(df.describe())

# Count students per grade_level
sns.countplot(data=students_df, x="grade_level", order=students_df["grade_level"].value_counts().index)
plt.title("Number of Students per Grade Level")
plt.show()

# Average score per grade_level
avg_scores = df.groupby("grade_level")["score"].mean().reset_index()
sns.barplot(data=avg_scores, x="grade_level", y="score")
plt.title("Average Scores per Grade Level")
plt.show()

# Average score per course
avg_course = df.groupby("course_name")["score"].mean().reset_index()
sns.barplot(data=avg_course, x="course_name", y="score")
plt.title("Average Scores per Course")
plt.xticks(rotation=45)
plt.show()

# Average score by semester
avg_semester = df.groupby("semester")["score"].mean().reset_index()
sns.barplot(data=avg_semester, x="semester", y="score")
plt.title("Average Scores by Semester")
plt.show()

conn.close()
