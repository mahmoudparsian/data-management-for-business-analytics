
-- Use the Superstore Relationonal database
USE Superstore;

-- Insert distinct values of DimCategories
INSERT INTO DimCategories (category_name)
SELECT DISTINCT Category
FROM 
    clean_superstore
WHERE 
     Category NOT IN (
        SELECT category_name 
        FROM DimCategories
    );
    


-- Insert distinct values of DimSubCategories with generated IDs
INSERT INTO DimSubCategories(subcategory_name, category_id)
SELECT 
    cs.sub_category,
    c.category_id
FROM 
    (SELECT DISTINCT sub_category, Category FROM clean_superstore) AS cs -- distinct sub-category from raw data
INNER JOIN
    DimCategories AS c ON cs.Category = c.category_name
WHERE 
    cs.sub_category NOT IN (
        SELECT subcategory_name 
        FROM DimSubCategories
    ); 
    
    
-- Insert the distinct DimProducts with their subcategory relationships
INSERT INTO DimProducts (product_id, product_name, subcategory_id)
SELECT
    cs.product_id,
    cs.product_name,
    s.subcategory_id
FROM 
    (SELECT DISTINCT product_id, product_name, sub_category FROM clean_superstore) as cs
JOIN 
    DimSubCategories as s ON cs.sub_category = s.subcategory_name
WHERE 
	cs.product_id NOT IN (
		SELECT product_id 
		FROM DimProducts
	)
AND
	cs.product_name NOT IN (
		SELECT product_name 
		FROM DimProducts
	);



-- Insert the distinct DimCustomers 
INSERT INTO DimCustomers (customer_id, customer_name, segment)
SELECT DISTINCT 
    customer_id, 
    customer_name, 
    Segment
FROM 
    clean_superstore
WHERE 
    customer_id NOT IN (
        SELECT customer_id 
        FROM DimCustomers
    );


-- Insert distinct values of DimShipMode with generated IDs
INSERT INTO DimShipMode (ship_mode)
SELECT DISTINCT
    ship_mode
FROM clean_superstore
WHERE 
    ship_mode NOT IN (
        SELECT ship_mode 
        FROM DimShipMode
    );


-- Insert distinct values of DimLocation 
INSERT INTO DimLocations (postal_code, city, state, region, country)
SELECT DISTINCT
    postal_code,
    City,
    State,
    Region,
    Country
FROM 
    clean_superstore
WHERE 
    City NOT IN (
		SELECT city FROM DimLocations
    );


-- Insert for DimOrders with all foreign key relationships validated
-- same order were mistakenly linked to the same postal_code
INSERT IGNORE INTO DimOrders (order_id, customer_id, order_date, ship_date, ship_mode_id, location_id)
SELECT
    cs.order_id,
    cs.customer_id,
    cs.order_date,
    cs.ship_date,    
    s.shipmode_id,
    l.location_id
FROM 
    (SELECT DISTINCT order_id, customer_id, order_date, ship_date, postal_code, ship_mode FROM clean_superstore) AS cs
JOIN DimCustomers c ON cs.customer_id = c.customer_id
JOIN DimShipMode s ON cs.ship_mode = s.ship_mode
JOIN DimLocations l ON cs.postal_code = l.postal_code
WHERE 
 cs.order_id NOT IN (SELECT order_id FROM DimOrders);
 

-- Insert for FactOrderDetails
INSERT INTO FactOrderDetails(order_id, product_id, quantity, sales, discount, profit)
SELECT 
    o.order_id,
    p.product_id,
    cs.Quantity,
    cs.Sales,
    cs.Discount,
    cs.Profit
FROM clean_superstore cs
JOIN DimOrders o ON cs.order_id = o.order_id
JOIN DimProducts p ON cs.product_id = p.product_id AND p.product_name = cs.product_name
WHERE
	cs.order_id NOT IN (SELECT order_id FROM FactOrderDetails);
    
    

select count(*) from DimCategories;
select count(*) from DimSubCategories;
select count(*) from DimProducts;
select count(*) from DimCustomers;
select count(*) from DimShipMode;
select count(*) from DimLocations;
select count(*) from DimOrders; 
select count(*) from FactOrderDetails;






