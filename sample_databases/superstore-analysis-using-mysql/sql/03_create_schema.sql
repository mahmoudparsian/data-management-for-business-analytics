-- Use the Superstore Relationonal database
USE Superstore;

-- Table: DimCategories
CREATE TABLE DimCategories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);

-- Table: DimSubCategories
CREATE TABLE DimSubCategories (
    subcategory_id INT PRIMARY KEY AUTO_INCREMENT,
    subcategory_name VARCHAR(100) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES DimCategories(category_id)
);

-- Table: DimProducts
CREATE TABLE DimProducts (
    product_id VARCHAR(20),
    product_name VARCHAR(255),
    subcategory_id INT NOT NULL,
    PRIMARY KEY (product_id, product_name),  -- Composite primary key
    FOREIGN KEY (subcategory_id) REFERENCES DimSubCategories(subcategory_id)
);

-- Table: DimCustomers
CREATE TABLE DimCustomers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    segment VARCHAR(50)
);

-- Table: DimShipMode
CREATE TABLE DimShipMode (
    shipmode_id INT PRIMARY KEY AUTO_INCREMENT,
    ship_mode VARCHAR(50) NOT NULL
);

-- Table: DimLocations
CREATE TABLE DimLocations (
	location_id INT PRIMARY KEY AUTO_INCREMENT,
    postal_code INT,
    city VARCHAR(100),
    state VARCHAR(100),
    region VARCHAR(100),
    country VARCHAR(100)
);

-- Table: DimOrders
CREATE TABLE DimOrders (
    order_id VARCHAR(15) PRIMARY KEY,
    customer_id VARCHAR(10),
    order_date DATE,
    ship_date DATE,
    ship_mode_id INT,
    location_id INT,
    FOREIGN KEY (customer_id) REFERENCES DimCustomers(customer_id),
    FOREIGN KEY (ship_mode_id) REFERENCES DimShipMode(shipmode_id),
    FOREIGN KEY (location_id) REFERENCES DimLocations(location_id)
);

-- Table: FactOrderDetails
CREATE TABLE FactOrderDetails (
	fact_order_details_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id VARCHAR(15),
    product_id VARCHAR(20),
    product_name VARCHAR(255),
    quantity INT,
    sales FLOAT,
    discount FLOAT,
    profit FLOAT,
    FOREIGN KEY (order_id) REFERENCES DimOrders(order_id),
    FOREIGN KEY (product_id, product_name) REFERENCES DimProducts(product_id, product_name)
);

