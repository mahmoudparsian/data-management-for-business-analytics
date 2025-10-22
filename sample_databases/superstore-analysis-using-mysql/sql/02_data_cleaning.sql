
-- Use the Superstore Relationonal database
USE Superstore;

-- Create a Cleaned Copy of the Table
CREATE TABLE clean_superstore AS
SELECT * FROM rawsuperstore;

SET SQL_SAFE_UPDATES = 0;

-- Remove Rows with Invalid Sales Values
DELETE FROM clean_superstore
WHERE Sales NOT REGEXP '^[0-9]+(\\.[0-9]+)?$';

DELETE FROM clean_superstore
WHERE Quantity NOT REGEXP '^[0-9]+(\\.[0-9]+)?$';

DELETE FROM clean_superstore
WHERE Discount NOT REGEXP '^[0-9]+(\\.[0-9]+)?$';


-- Cast Columns to Appropriate Data Types
ALTER TABLE clean_superstore
MODIFY COLUMN Segment VARCHAR(255),
MODIFY COLUMN Country VARCHAR(255),
MODIFY COLUMN City VARCHAR(255),
MODIFY COLUMN State VARCHAR(255),
MODIFY COLUMN Region VARCHAR(255),
MODIFY COLUMN Category VARCHAR(255),
MODIFY COLUMN Sales FLOAT,
MODIFY COLUMN Quantity INT,
MODIFY COLUMN Discount FLOAT,
MODIFY COLUMN Profit FLOAT;


-- Standardize Column Names 
ALTER TABLE clean_superstore
CHANGE `Row ID` row_id INT,
CHANGE `Order ID` order_id VARCHAR(255),
CHANGE `Ship Mode` ship_mode VARCHAR(255),
CHANGE `Customer ID` customer_id VARCHAR(255),
CHANGE `Customer Name` customer_name VARCHAR(255),
CHANGE `Postal Code` postal_code INT,
CHANGE `Product ID` product_id VARCHAR(255),
CHANGE `Sub-Category` sub_category VARCHAR(255),
CHANGE `Product Name` product_name VARCHAR(255);

-- rename a columne
ALTER TABLE clean_superstore
RENAME COLUMN old_name TO new_name;

-- Cast Date Columns to appropriate type
-- add new order date column
ALTER TABLE clean_superstore
ADD COLUMN order_date DATE AFTER order_id; 

-- add new ship date column
ALTER TABLE clean_superstore
ADD COLUMN ship_date DATE AFTER order_date; 

-- Populate the new column using STR_TO_DATE
UPDATE clean_superstore
SET order_date = STR_TO_DATE(`Order Date`, '%d-%m-%Y');

UPDATE clean_superstore
SET ship_date = STR_TO_DATE(`Ship Date`, '%d-%m-%Y');

-- Drop the original string column
ALTER TABLE clean_superstore
DROP COLUMN `Order Date`;

ALTER TABLE clean_superstore
DROP COLUMN `Ship Date`;


-- Total number of rows
SELECT COUNT(*) AS total_rows 
FROM clean_superstore; -- 9,9472 records


