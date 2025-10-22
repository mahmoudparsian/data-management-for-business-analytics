# import pandas as pd
# import mysql.connector

# # -------------------------------
# # Step 1: Connect to MySQL
# # -------------------------------
# conn = mysql.connector.connect(
#     host="localhost",
#     user="root",
#     password="xyz", your password
#     database="movies_db"  # Ensure this database exists
# )
# cursor = conn.cursor()

# # -------------------------------
# # Step 2: Load CSV files
# # -------------------------------
# tags = pd.read_csv(r"C:\Users\admin\OneDrive\Desktop\tags.csv")
# ratings = pd.read_csv(r"C:\Users\admin\OneDrive\Desktop\ratings.csv")
# movies = pd.read_csv(r"C:\Users\admin\OneDrive\Desktop\movies.csv")
# links = pd.read_csv(r"C:\Users\admin\OneDrive\Desktop\links.csv")

# # -------------------------------
# # Step 3: Create tables & insert data
# # -------------------------------
# def load_to_mysql(df, table_name):
#     # Drop table if exists
#     cursor.execute(f"DROP TABLE IF EXISTS {table_name}")
    
#     # Create table with all columns as TEXT
#     cols = ", ".join([f"`{col}` TEXT" for col in df.columns])
#     cursor.execute(f"CREATE TABLE {table_name} ({cols})")
    
#     # Insert data
#     for _, row in df.iterrows():
#         values = "', '".join(str(x).replace("'", "''") for x in row)
#         cursor.execute(f"INSERT INTO {table_name} VALUES ('{values}')")
#     conn.commit()
    
#     # Print success message
#     print(f"✅ Table '{table_name}' loaded successfully with {len(df)} records.")

# # Load tables
# load_to_mysql(movies, "movies")
# load_to_mysql(ratings, "ratings")
# load_to_mysql(tags, "tags")
# load_to_mysql(links, "links")

# # -------------------------------
# # Step 4: Close Connection
# # -------------------------------
# cursor.close()
# conn.close()
# print("All database operations completed and connection closed.")
