Okay, let's have 3 tables: all for MySQL database.

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    country VARCHAR(50), -- can be in {"USA", "CANADA", "MEXICO", "FRANCE", "SPAIN"}
    gender VARCHAR(6), -- can be MALE or FEMALE
    age INT
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    amount INT,  -- how much a customer paid for this product
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

1. let's validate these schemas in MySQL database

2. Populate these 3 tables with CSV files as well as SQL INSERT statements:
There should be 

* 54 customers (make sure the last 4 customers do not buy any products -- useful for join)

* 105 products (make sure that the last 5 products are never purchased by any customer -- useful for join)

* 2000 orders

3. Prepare 5 labs, each having 25 queries of English and SQL

Lab-1: the most basic queries for primitives

Lab-2: basic to simple to intermediate

Lab-3: simple to intermediate: using GROUP BY and aggregation function, some basic joins

Lab-4: intermediate queries: using GROUP BY, inner join, left join, right join, 
       simple sub-queries using WITH, and simple ranking functions,
       

Lab-5: intermediate queries: using GROUP BY, sub-queries using WITH, and ranking functions


Prepare everything, labs in markdown format, data in CSV and SQL INSERT: all in one zip file.
Thanks.
What’s inside
    •    schema.sql – your exact MySQL schema (customers, products, orders with FKs)
    •    data/
    •    customers.csv (54 rows; last 4 customers have no orders)
    •    products.csv (105 rows; last 5 products never purchased)
    •    orders.csv (2000 rows referencing only customers 1–50 and products 1–100)
    •    inserts/
    •    customers_inserts.sql
    •    products_inserts.sql
    •    orders_inserts.sql (batched for performance)
    •    load_data_infile.sql – ready-to-run LOAD DATA INFILE scripts
    •    labs/ (Markdown, 25 queries each)
    •    lab1_basics.md – primitives, WHERE, ORDER BY, simple DML
    •    lab2_basic_to_intermediate.md – CASE, DISTINCT, IN/NOT IN, intro joins/agg
    •    lab3_groupby_agg_joins.md – GROUP BY, HAVING, multi-table aggregations
    •    lab4_intermediate_with_ranking.md – INNER/LEFT/RIGHT joins, CTEs, ranking
    •    lab5_with_ranking_advanced.md – CTEs, partitioned analytics, top-N per group

If you want, I can also provide an Instructor Solutions Pack next (with expected output shapes and notes for each query).

