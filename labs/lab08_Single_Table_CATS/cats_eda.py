import pandas as pd
import mysql.connector
import matplotlib.pyplot as plt

def load_cats():
    conn = mysql.connector.connect(
        host="localhost",    # change if needed
        user="root",         # change if needed
        password="mp22pass", # change if needed
        database="cats_db  " # change if needed
    )
    query = "SELECT * FROM cats;"
    df = pd.read_sql(query, conn)
    conn.close()
    return df

def exploratory_analysis(df):
    print("First 5 rows:")
    print(df.head())
    print("\nData Info:")
    print(df.info())
    print("\nSummary Statistics:")
    print(df.describe(include='all'))
    print("\nMissing Values:")
    print(df.isnull().sum())

    # Age distribution
    plt.figure(figsize=(8,5))
    df['age'].dropna().plot(kind='hist', bins=15)
    plt.title("Age Distribution of Cats")
    plt.xlabel("Age")
    plt.ylabel("Count")
    plt.show()

    # Gender distribution
    plt.figure(figsize=(6,4))
    df['gender'].value_counts().plot(kind='bar')
    plt.title("Gender Distribution")
    plt.xlabel("Gender")
    plt.ylabel("Count")
    plt.show()

def groupby_analysis(df):
    # Average tricks by breed
    tricks_by_breed = df.groupby("breed")['num_of_tricks'].mean()
    print("\nAverage Tricks by Breed:")
    print(tricks_by_breed)

    tricks_by_breed.plot(kind='bar', figsize=(8,5), title="Average Tricks by Breed")
    plt.show()

    # Count by country
    count_by_country = df['country'].value_counts()
    print("\nCats by Country:")
    print(count_by_country)

    count_by_country.plot(kind='bar', figsize=(8,5), title="Cats by Country")
    plt.show()

if __name__ == "__main__":
    df = load_cats()
    exploratory_analysis(df)
    groupby_analysis(df)
