CREATE TABLE superstoreorders (
    order_id VARCHAR(255),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(255),
    customer_name VARCHAR(255),
    segment VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255),
    market VARCHAR(255),
    region VARCHAR(255),
    product_id VARCHAR(255),
    category VARCHAR(255),
    sub_category VARCHAR(255),
    product_name VARCHAR(255),
    sales DECIMAL(10, 2),
    quantity INT,
    discount DECIMAL(5, 2),
    profit DECIMAL(10, 2),
    shipping_cost DECIMAL(10, 2),
    order_priority VARCHAR(255),
    year INT
);

-- Uploading the file --
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/superstoreorders.csv'
INTO TABLE superstoreorders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS -- Skip header row 
(order_id, @order_date, @ship_date, ship_mode, customer_name, segment, state, country, market, region, product_id, category, sub_category, product_name, sales, quantity, discount, profit, shipping_cost, order_priority, year)
SET 
    order_date = STR_TO_DATE(@order_date, '%m/%d/%Y'),
    ship_date = STR_TO_DATE(@ship_date, '%m/%d/%Y');

SELECT * FROM superstoreorders;

-- Total Sales, Profit, and Quantity
SELECT
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity
FROM superstoreorders;

-- Average, Minimum, and Maximum Values for Sales, Profit, and Quantity
SELECT
    AVG(sales) AS average_sales,
    MIN(sales) AS min_sales,
    MAX(sales) AS max_sales,
    AVG(profit) AS average_profit,
    MIN(profit) AS min_profit,
    MAX(profit) AS max_profit,
    AVG(quantity) AS average_quantity,
    MIN(quantity) AS min_quantity,
    MAX(quantity) AS max_quantity
FROM superstoreorders;

-- Temporal Analysis - Sales, Profit, and Quantity Trends by Quarter
SELECT
    YEAR(order_date) AS order_year,
    QUARTER(order_date) AS order_quarter,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity
FROM superstoreorders
GROUP BY order_year, order_quarter
ORDER BY order_year, order_quarter;

-- Identify Top Sales Quarter for Each Year
WITH RankedQuarters AS (
    SELECT
        YEAR(order_date) AS order_year,
        QUARTER(order_date) AS order_quarter,
        SUM(sales) AS total_sales,
        RANK() OVER (PARTITION BY YEAR(order_date) ORDER BY SUM(sales) DESC) AS sales_rank
    FROM superstoreorders
    GROUP BY order_year, order_quarter
)
SELECT
    order_year,
    order_quarter,
    total_sales AS peak_sales
FROM RankedQuarters
WHERE sales_rank = 1;

-- Top-Selling Categories and Sub-Categories
SELECT
    category,
    sub_category,
    SUM(sales) AS total_sales
FROM superstoreorders
GROUP BY category, sub_category
ORDER BY total_sales DESC;

-- Most Profitable Categories and Sub-Categories
SELECT
    category,
    sub_category,
    SUM(profit) AS total_profit
FROM superstoreorders
GROUP BY category, sub_category
ORDER BY total_profit DESC;

-- Sales and Profit by Region
SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstoreorders
GROUP BY region
ORDER BY total_profit DESC;

-- Most Valuable Customer Segments
SELECT
    segment,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstoreorders
GROUP BY segment
ORDER BY total_profit DESC;

-- Most Profitable and Top-Selling Products
SELECT
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstoreorders
GROUP BY product_name
ORDER BY total_profit DESC, total_sales DESC;

-- Impact of Discounts on Sales and Profit
SELECT
    discount,
    AVG(sales) AS average_sales,
    AVG(profit) AS average_profit
FROM superstoreorders
GROUP BY discount
ORDER BY discount DESC;


-- Shipping Costs and Their Impact on Profit
SELECT
    ship_mode,
    AVG(shipping_cost) AS avg_shipping_cost,
    AVG(profit) AS average_profit
FROM superstoreorders
GROUP BY ship_mode
ORDER BY avg_shipping_cost DESC;

-- Distribution of Order Priorities
SELECT
    order_priority,
    AVG(sales) AS avg_sales,
    AVG(profit) AS avg_profit,
    COUNT(distinct order_id) AS order_count
FROM superstoreorders
GROUP BY order_priority
ORDER BY order_priority;

-- Top Customers Based on Total Sales
SELECT
    customer_name,
    SUM(sales) AS total_sales
FROM superstoreorders
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10; 

-- Top Customers Based on Total Profit
SELECT
    customer_name,
    SUM(profit) AS total_profit
FROM superstoreorders
GROUP BY customer_name
ORDER BY total_profit DESC
LIMIT 10; -- Adjust the limit as needed

-- Analyze Customer Buying Patterns
SELECT
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    AVG(sales) AS average_sales_per_order
FROM superstoreorders
GROUP BY customer_name
ORDER BY total_orders DESC
LIMIT 10;


-- Calculating RFM
SELECT
    customer_name,
    DATEDIFF('2015-01-30', MAX(order_date)) AS recency,
    COUNT(DISTINCT order_id) AS frequency,
    SUM(sales) AS monetary_value
FROM
    superstoreorders
GROUP BY
    customer_name;
    
SELECT
    customer_name,
    NTILE(4) OVER (ORDER BY DATEDIFF('2015-01-30', MAX(order_date))) AS rfm_recency,
    NTILE(4) OVER (ORDER BY COUNT(DISTINCT order_id)) AS rfm_frequency,
    NTILE(4) OVER (ORDER BY SUM(sales)) AS rfm_monetary
FROM
    superstoreorders
GROUP BY
    customer_name;
    
    

