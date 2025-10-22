import pandas as pd
import mysql.connector
import matplotlib.pyplot as plt

def load_teachers():
    conn = mysql.connector.connect(
        host="localhost",   # change as needed
        user="root",        # change as needed
        password="mp22pass", # change as needed
        database="teachers_db" # change as needed
    )
    df = pd.read_sql("SELECT * FROM teachers;", conn)
    conn.close()
    return df

def exploratory_analysis(df):
    print("--- Head ---")
    print(df.head())
    print("\n--- Info ---")
    print(df.info())
    print("\n--- Summary ---")
    print(df.describe(include='all'))
    print("\n--- Missing Values ---")
    print(df.isnull().sum())

def groupby_analysis(df):
    # Average salary per degree
    avg_salary_degree = df.groupby("degree")['salary'].mean()
    print(avg_salary_degree)
    avg_salary_degree.plot(kind='bar', title="Average Salary by Degree")
    plt.show()

    # Average salary per school
    avg_salary_school = df.groupby("school")['salary'].mean()
    print(avg_salary_school)
    avg_salary_school.plot(kind='bar', title="Average Salary by School")
    plt.show()

    # Teachers count per department
    dept_count = df['department'].value_counts()
    print(dept_count)
    dept_count.plot(kind='bar', title="Teachers Count by Department")
    plt.show()

    # Salary distribution per country
    df.groupby("country")['salary'].mean().plot(kind='bar', title="Average Salary by Country")
    plt.show()

    # Hire trend by year
    hire_trend = df['hire_year'].value_counts().sort_index()
    print(hire_trend)
    hire_trend.plot(kind='line', marker='o', title="Hire Trend by Year")
    plt.show()


    # Salary distribution histogram
    df['salary'].plot(kind='hist', bins=20, title="Salary Distribution Histogram")
    plt.xlabel("Salary")
    plt.show()

    # Salary distribution boxplot
    df['salary'].plot(kind='box', title="Salary Distribution Boxplot")
    plt.show()


    # Salary distribution by degree (boxplot)
    df.boxplot(column='salary', by='degree', grid=False, figsize=(8,6))
    plt.title("Salary Distribution by Degree")
    plt.suptitle("")
    plt.xlabel("Degree")
    plt.ylabel("Salary")
    plt.show()

    # Salary distribution by school (boxplot)
    df.boxplot(column='salary', by='school', grid=False, figsize=(10,6))
    plt.title("Salary Distribution by School")
    plt.suptitle("")
    plt.xlabel("School")
    plt.ylabel("Salary")
    plt.show()

if __name__ == "__main__":
    df = load_teachers()
    exploratory_analysis(df)
    groupby_analysis(df)
