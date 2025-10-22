-- create a database
CREATE DATABASE IF NOT EXISTS superstore;

-- use database
USE superstore;

-- What columns are in the dataset?
DESCRIBE rawsuperstore;

-- Total number of rows
SELECT COUNT(*) AS total_rows 
FROM rawsuperstore; -- 9,994 records


-- Check for Null Values per Column
SELECT 
    SUM(CASE WHEN `Row ID` IS NULL THEN 1 ELSE 0 END) AS null_row_id,
    SUM(CASE WHEN `Order ID` IS NULL THEN 1 ELSE 0 END) AS null_order_id,
    SUM(CASE WHEN `Order Date` IS NULL THEN 1 ELSE 0 END) AS null_order_date,
    SUM(CASE WHEN `Ship Date` IS NULL THEN 1 ELSE 0 END) AS null_ship_date,
    SUM(CASE WHEN `Ship Mode` IS NULL THEN 1 ELSE 0 END) AS null_ship_mode,
    SUM(CASE WHEN `Customer ID` IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN `Customer Name` IS NULL THEN 1 ELSE 0 END) AS null_customer_name,
    SUM(CASE WHEN `Segment` IS NULL THEN 1 ELSE 0 END) AS null_segment,
    SUM(CASE WHEN `Country` IS NULL THEN 1 ELSE 0 END) AS null_country,
    SUM(CASE WHEN `City` IS NULL THEN 1 ELSE 0 END) AS null_city,
    SUM(CASE WHEN `State` IS NULL THEN 1 ELSE 0 END) AS null_state,
    SUM(CASE WHEN `Postal Code` IS NULL THEN 1 ELSE 0 END) AS null_postal_code,
    SUM(CASE WHEN `Region` IS NULL THEN 1 ELSE 0 END) AS null_region,
    SUM(CASE WHEN `Product ID` IS NULL THEN 1 ELSE 0 END) AS null_product_id,
    SUM(CASE WHEN `Category` IS NULL THEN 1 ELSE 0 END) AS null_category,
    SUM(CASE WHEN `Sub-Category` IS NULL THEN 1 ELSE 0 END) AS null_subcategory,
    SUM(CASE WHEN `Product Name` IS NULL THEN 1 ELSE 0 END) AS null_product_name,
    SUM(CASE WHEN `Sales` IS NULL THEN 1 ELSE 0 END) AS null_sales,
    SUM(CASE WHEN `Quantity` IS NULL THEN 1 ELSE 0 END) AS null_quantity,
    SUM(CASE WHEN `Discount` IS NULL THEN 1 ELSE 0 END) AS null_discount,
    SUM(CASE WHEN `Profit` IS NULL THEN 1 ELSE 0 END) AS null_profit
FROM RawSuperstore; -- no missing values

--  Checking for Duplicate Row IDs
SELECT `Row ID`, COUNT(*) 
FROM RawSuperstore 
GROUP BY `Row ID` 
HAVING COUNT(*) > 1; -- no duplicate exits

-- Checking Date Consistency (Ship Date after Order Date)
SELECT `Order ID`, `Order Date`, `Ship Date` 
FROM RawSuperstore 
WHERE STR_TO_DATE(`Ship Date`, '%d-%m-%Y') < STR_TO_DATE(`Order Date`, '%d-%m-%Y'); -- all order date occurred before ship date

-- check value range for anomalies or outliers
SELECT
  MIN(Sales) AS min_sales,
  MAX(Sales) AS max_sales,
  AVG(Sales) AS avg_sales
FROM RawSuperstore; -- discover this field contains inappropriate value like "Wirebound"


-- check distint values in Sales
SELECT DISTINCT Sales
FROM RawSuperstore
ORDER by Sales DESC; -- discover there 34 unique text values.

SELECT
  MIN(Quantity) AS min_qty,
  MAX(Quantity) AS max_qty,
  AVG(Quantity) AS avg_qty
FROM RawSuperstore; -- discover this field contains inappropriate value like "Wirebound Standard Line Memo"

SELECT DISTINCT Quantity
FROM RawSuperstore
ORDER by Quantity DESC; -- discover there 18 unique text values.


SELECT
  MIN(Discount) AS min_discount,
  MAX(Discount) AS max_discount,
  AVG(Discount) AS avg_discount
FROM RawSuperstore; -- discover this field contains inappropriate value like "Sand"

SELECT DISTINCT Discount
FROM RawSuperstore
ORDER by Discount DESC; -- discover there 3 unique text values.

SELECT
  MIN(Profit) AS min_profit,
  MAX(Profit) AS max_profit,
  AVG(Profit) AS avg_profit
FROM RawSuperstore; -- discover this field contains negative profit which signify loss.
