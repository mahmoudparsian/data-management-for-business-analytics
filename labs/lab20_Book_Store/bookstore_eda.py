import pandas as pd
import mysql.connector
import matplotlib.pyplot as plt

def load_tables():
    conn = mysql.connector.connect(
        host="localhost",   # change as needed
        user="root",        # change as needed
        password="yourpassword", # change as needed
        database="your_database" # change as needed
    )
    tables = {}
    for t in ["stores","customers","books","transactions"]:
        tables[t] = pd.read_sql(f"SELECT * FROM {t};", conn)
    conn.close()
    return tables

def exploratory_analysis(tables):
    for name, df in tables.items():
        print(f"--- {name.upper()} ---")
        print(df.head())
        print(df.info())
        print(df.describe(include='all'))
        print("\nMissing values:")
        print(df.isnull().sum())
        print("\n")

def groupby_analysis(tables):
    transactions = tables['transactions']
    customers = tables['customers']
    stores = tables['stores']
    books = tables['books']

    merged = transactions.merge(customers,on="customer_id").merge(stores,on="store_id").merge(books,on="book_id")

    # Average purchase price per country
    avg_price_country = merged.groupby("country")['price'].mean()
    print(avg_price_country)
    avg_price_country.plot(kind='bar', title="Average Price per Country")
    plt.show()

    # Total sales per store location
    sales_store = merged.groupby("store_location")['price'].sum().sort_values(ascending=False)
    print(sales_store)
    sales_store.plot(kind='bar', title="Total Sales per Store Location")
    plt.show()

    # Count purchases per book category
    cat_count = merged['category'].value_counts()
    print(cat_count)
    cat_count.plot(kind='bar', title="Purchases per Book Category")
    plt.show()

    # Average customer age per category
    avg_age_cat = merged.groupby("category")['age'].mean()
    print(avg_age_cat)
    avg_age_cat.plot(kind='bar', title="Average Customer Age per Book Category")
    plt.show()


    # Total sales per author
    sales_author = merged.groupby("author")['price'].sum().sort_values(ascending=False)
    print(sales_author)
    sales_author.head(10).plot(kind='bar', title="Top 10 Authors by Sales")
    plt.show()

    # Total sales per book category per country
    sales_cat_country = merged.groupby(["country","category"])['price'].sum().unstack().fillna(0)
    print(sales_cat_country)
    sales_cat_country.plot(kind='bar', stacked=True, figsize=(12,6), title="Sales by Category per Country")
    plt.show()

    # Average book price per author
    avg_price_author = merged.groupby("author")['price'].mean().sort_values(ascending=False)
    print(avg_price_author.head(10))
    avg_price_author.head(10).plot(kind='bar', title="Top 10 Authors by Avg Price")
    plt.show()


    # Sales trend by year
    merged['year'] = pd.to_datetime(merged['purchase_date']).dt.year
    sales_year = merged.groupby('year')['price'].sum()
    print(sales_year)
    sales_year.plot(kind='line', marker='o', title="Total Sales by Year")
    plt.show()

    # Sales trend by month (across all years)
    merged['month'] = pd.to_datetime(merged['purchase_date']).dt.month
    sales_month = merged.groupby('month')['price'].sum()
    print(sales_month)
    sales_month.plot(kind='bar', title="Total Sales by Month (all years combined)")
    plt.show()

if __name__ == "__main__":
    tables = load_tables()
    exploratory_analysis(tables)
    groupby_analysis(tables)
