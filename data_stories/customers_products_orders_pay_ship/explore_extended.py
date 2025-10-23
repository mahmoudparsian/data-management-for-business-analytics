# explore_extended.py
# Requires: mysql-connector-python, pandas, matplotlib
# pip install mysql-connector-python pandas matplotlib

import mysql.connector as mc
import pandas as pd
import matplotlib.pyplot as plt

# ---- Connect to MySQL ----
conn = mc.connect(
    host="localhost",
    user="root",        # adjust if needed
    password="YOUR_PASSWORD",  # change this
    database="retail_demo_ext2"
)

# ---- Load Data ----
customers = pd.read_sql("SELECT * FROM customers", conn)
products  = pd.read_sql("SELECT * FROM products", conn)
orders    = pd.read_sql("SELECT * FROM orders", conn)
payments  = pd.read_sql("SELECT * FROM payments", conn)
shipments = pd.read_sql("SELECT * FROM shipments", conn)

# Join into a wide fact table
query = """
SELECT o.order_id, o.paid_price, o.order_date,
       c.customer_id, c.name, c.country,
       p.product_id, p.product_name, p.category,
       pay.method AS payment_method,
       s.status AS shipment_status, s.carrier
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
JOIN products p ON o.product_id=p.product_id
LEFT JOIN payments pay ON o.order_id=pay.order_id
LEFT JOIN shipments s ON o.order_id=s.order_id;
"""
orders_full = pd.read_sql(query, conn)

print("Data loaded successfully!")
print(orders_full.head())

# ---- Visualizations ----
plt.figure(); orders.groupby("customer_id")["order_id"].count().plot(kind="bar"); plt.title("Orders per Customer"); plt.tight_layout(); plt.savefig("viz1_orders_per_customer.png")

plt.figure(); orders_full.groupby("name")["paid_price"].sum().sort_values(ascending=False).plot(kind="bar"); plt.title("Revenue per Customer"); plt.tight_layout(); plt.savefig("viz2_revenue_per_customer.png")

plt.figure(); orders_full.groupby("country")["order_id"].count().plot(kind="bar"); plt.title("Orders by Country"); plt.tight_layout(); plt.savefig("viz3_orders_by_country.png")

plt.figure(); orders_full.groupby("category")["paid_price"].sum().plot(kind="bar"); plt.title("Revenue by Category"); plt.tight_layout(); plt.savefig("viz4_revenue_by_category.png")

plt.figure(); payments.groupby("method")["amount"].sum().plot(kind="bar"); plt.title("Orders by Payment Method"); plt.tight_layout(); plt.savefig("viz5_payment_methods.png")

plt.figure(); shipments.groupby("status")["shipment_id"].count().plot(kind="bar"); plt.title("Shipments by Status"); plt.tight_layout(); plt.savefig("viz6_shipments_by_status.png")

plt.figure(); shipments.groupby("carrier")["shipment_id"].count().plot(kind="bar"); plt.title("Shipments by Carrier"); plt.tight_layout(); plt.savefig("viz7_shipments_by_carrier.png")

plt.figure(); orders_full.groupby("category")["paid_price"].mean().plot(kind="bar"); plt.title("Average Paid Price by Category"); plt.tight_layout(); plt.savefig("viz8_avg_price_by_category.png")

plt.figure(); orders_full.groupby("product_name")["paid_price"].sum().sort_values(ascending=False).head(15).plot(kind="bar"); plt.title("Top 15 Products by Revenue"); plt.tight_layout(); plt.savefig("viz9_top_products.png")

plt.figure(); orders["paid_price"].plot(kind="hist", bins=30); plt.title("Paid Price Distribution"); plt.xlabel("Price"); plt.tight_layout(); plt.savefig("viz10_price_distribution.png")

print("✅ 10 visuals saved as PNG files in current directory.")
conn.close()
