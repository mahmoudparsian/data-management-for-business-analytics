# data_exploration.py
# Requires: mysql-connector-python, pandas, matplotlib
# pip install mysql-connector-python pandas matplotlib

import mysql.connector as mc
import pandas as pd
import matplotlib.pyplot as plt

conn = mc.connect(
    host="localhost",
    user="root",
    password="YOUR_PASSWORD",
    database="retail_demo"
)

customers = pd.read_sql("SELECT * FROM customers", conn)
products  = pd.read_sql("SELECT * FROM products", conn)
orders    = pd.read_sql("SELECT * FROM orders", conn)

orders_full = pd.read_sql(
    """
    SELECT o.order_id, o.paid_price,
           c.customer_id, c.name, c.country,
           p.product_id, p.product_name, p.category, p.color
    FROM orders o
    JOIN customers c ON o.customer_id=c.customer_id
    JOIN products  p ON o.product_id=p.product_id
    """, conn
)

print(customers.head(), "\n")
print(products.head(), "\n")
print(orders.head(), "\n")

# ----- 9 Visuals -----
plt.figure(); orders.groupby('customer_id')['order_id'].count().sort_values(ascending=False).plot(kind='bar'); plt.title('Orders per Customer'); plt.xlabel('customer_id'); plt.ylabel('orders'); plt.tight_layout(); plt.savefig('viz1_orders_per_customer.png')

plt.figure(); orders_full.groupby('country')['order_id'].count().sort_values(ascending=False).plot(kind='bar'); plt.title('Orders by Country'); plt.xlabel('country'); plt.ylabel('orders'); plt.tight_layout(); plt.savefig('viz2_orders_by_country.png')

plt.figure(); orders_full.groupby('category')['paid_price'].sum().sort_values(ascending=False).plot(kind='bar'); plt.title('Revenue by Category'); plt.xlabel('category'); plt.ylabel('revenue'); plt.tight_layout(); plt.savefig('viz3_revenue_by_category.png')

plt.figure(); orders_full.groupby('color')['order_id'].count().sort_values(ascending=False).head(15).plot(kind='bar'); plt.title('Top Colors by Orders'); plt.xlabel('color'); plt.ylabel('orders'); plt.tight_layout(); plt.savefig('viz4_top_colors.png')

top_products = orders_full.groupby('product_name')['order_id'].count().sort_values(ascending=False).head(15)
plt.figure(); top_products.plot(kind='bar'); plt.title('Top 15 Products by Orders'); plt.xlabel('product'); plt.ylabel('orders'); plt.tight_layout(); plt.savefig('viz5_top_products.png')

plt.figure(); orders_full.groupby('name')['paid_price'].sum().sort_values(ascending=False).plot(kind='bar'); plt.title('Total Spend per Customer'); plt.xlabel('customer'); plt.ylabel('revenue'); plt.tight_layout(); plt.savefig('viz6_spend_per_customer.png')

plt.figure(); orders_full.groupby('category')['paid_price'].mean().sort_values(ascending=False).plot(kind='bar'); plt.title('Average Order Value by Category'); plt.xlabel('category'); plt.ylabel('avg price'); plt.tight_layout(); plt.savefig('viz7_aov_by_category.png')

plt.figure(); orders_full.groupby(['category','color'])['paid_price'].sum().sort_values(ascending=False).head(20).plot(kind='bar'); plt.title('Revenue by Category-Color (Top 20)'); plt.xlabel('category-color'); plt.ylabel('revenue'); plt.tight_layout(); plt.savefig('viz8_cat_color_revenue.png')

plt.figure(); orders['paid_price'].plot(kind='hist', bins=30); plt.title('Paid Price Distribution'); plt.xlabel('paid_price'); plt.ylabel('frequency'); plt.tight_layout(); plt.savefig('viz9_paid_price_hist.png')

print("Saved 9 visuals as PNG files in the current directory.")
conn.close()
