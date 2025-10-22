CREATE DATABASE Marketing;

USE Marketing;

CREATE TABLE Customers (
    Cust_ID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(100),
    City VARCHAR(100),
    Credits DECIMAL(12,2),
    Mobile VARCHAR(15)
);

INSERT INTO Customers (Cust_ID, Name, Address, City, Credits, Mobile) VALUES
('C001', 'Ripon', 'Lalbag', 'Rangpur', 20000.00, '1738552051'),
('C002', 'Babul', 'Shapla', 'Rangpur', 120000.00, '1521771944'),
('C003', 'Rafi', 'Talaimari', 'Rajshahi', 23000.00, '1828679600'),
('C004', 'Fahim', 'Saidpur', 'Nilphamari', 14000.00, '1580302073'),
('C005', 'Shamsu', 'Gomastapur', 'Chapainawaganj', 35000.00, '1748342181'),
('C006', 'Sayem', 'Sardullahpur', 'Gaibandha', 13000.00, '1307389900'),
('C007', 'Shakil', 'Dariapur', 'Gaibandha', 34000.00, '1304593498'),
('C008', 'Sourav', 'Kamarkhanda', 'Sirajganj', 14000.00, '1988735372'),
('C009', 'Saif', 'Meherpur Sadar', 'Meherpur', 45000.00, '1743523392'),
('C010', 'Soriful', 'Bodagonj', 'Panchagrah', 50000.00, '1762536232'),
('C011', 'Rotan', 'Saidpur', 'Nilphamari', 70000.00, '1334444432'),
('C012', 'Shafin', 'Jesshore Sadar', 'Jesshore', 15000.00, '1835482382'),
('C013', 'Shafi', '-1', 'Chapainawabganj', 23000.00, '1835362432'),
('C014', 'Alif', 'Gulshan', 'Dhaka', 25000.00, '1983723527'),
('C015', 'Naim', 'Keraniganj', 'Dhaka', 19000.00, '1863725392'),
('C016', 'Sumi', 'Jaintapur', 'Sylhet', 18000.00, '1953624283'),
('C017', 'Arif', 'Shibganj', 'Bogura', 16000.00, '1823632892'),
('C018', 'Nila', 'Dimla', 'Dhaka', 15000.00, '1974539362'),
('C019', 'Joya', 'Babuganj', 'Barishal', 18000.00, '1725347237'),
('C020', 'Emon', 'Gomastapur', 'Naogoan', 18000.00, '1936354365'),
('C021', 'Tani', 'Pirganj', 'Thakurgaon', 20000.00, '1783064537'),
('C022', 'Liza', 'Feni Sadar', 'Feni', 23000.00, '1453635392'),
('C023', 'Kona', 'Muktagacha', 'Mymansingh', 23000.00, '1836364533'),
('C024', 'Mitu', 'Netrokona Sadar', 'Netrakona', 25000.00, '1843654365'),
('C025', 'Tito', 'Dumki', 'Patuakhali', 24000.00, '1453745727'),
('C026', 'Rupa', 'Joldhaka', 'Niplhamari', 34000.00, '1682462734'),
('C027', 'Raju', 'Lalbag', 'Rangpur', 6000.00, '1534265725'),
('C028', 'Lamia', 'Shapla', 'Rangpur', 7600.00, '1736243562'),
('C029', 'Rahi', 'Kurigram Sadar', 'Kurigram', 34000.00, '1743735462'),
('C030', 'Zia', 'Bogura Sadar', 'Bogura', 35000.00, '1937354763'),
('C031', 'Khaleda', 'Noakhali Sadar', 'Noakhali', 54000.00, '1537253522'),
('C032', 'Hasina', 'Dhaka Sadar', 'Dhaka', 78000.00, '1735463453'),
('C033', 'Kader', 'Thakurgaon Sadar', 'Thakurgaon', 30000.00, '1736343234'),
('C034', 'Palak', 'Natore Sadar', 'Natore', 76000.00, '1936364322'),
('C035', 'Joy', 'Araihazar', 'Narayanganj', 34000.00, '1735232345'),
('C036', 'Reza', 'Kutubdia', 'CoxBazar', 45000.00, '1634253426'),
('C037', 'Nobi', 'Lama', 'Gazipur', 34000.00, '1636237452'),
('C038', 'Nipu', 'Kaliganj', 'Jhenaidah', 36000.00, '1846376522'),
('C039', 'Kafii', 'Hatibandha', 'Lalmonirhat', 39000.00, '1303837432'),
('C040', 'Abir', 'Pirganj', 'Rangpur', 8000.00, '1535243724'),
('C041', 'Moon', 'Sherpur', 'Bogura', 45000.00, '1963625444'),
('C042', 'Joty', 'Maymansingh Sadar', 'Maymansingh', 67000.00, '1936245242'),
('C043', 'Fahmida', 'Kawkhali', 'Kustia', 35000.00, '1736253222'),
('C044', 'Jinat', 'Mirpur', 'Dhaka', 78000.00, '1735253423'),
('C045', 'Sumaiya', 'Dhaka', 'Dhaka', 83000.00, '1635375433'),
('C046', 'Rimi', 'Dinajpur Sadar', 'Dinajpur', 45000.00, '1936236353'),
('C047', 'Sayab', 'Ullapara', 'Sirajganj', 67000.00, '1534252211'),
('C048', 'Zillu', 'Kamarkhanda', 'Sirajganj', 45000.00, '1432273522'),
('C049', 'Nahid', 'Nachole', 'Chapainawabganj', 34000.00, '1832673526'),
('C050', 'Nawshin', 'Ullapara', 'Siranjganj', 37000.00, '1634272638');

SELECT * FROM Customers;


CREATE TABLE Products (
    Product_ID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100),
    Company VARCHAR(100),
    Rate DECIMAL(10,2)
);

INSERT INTO Products (Product_ID, Name, Company, Rate) VALUES
('P001', 'Lux', 'UNILEVER', 50.00),
('P002', 'WHEEL', 'UNILEVER', 160.00),
('P003', 'DETOL', 'ACI', 150.00),
('P004', 'AERSOL', 'ACI', 60.00),
('P005', 'AXE', 'AXE', 350.00),
('P006', 'Mojo', 'Akij', 40.00),
('P007', 'Pran_Up', 'Pran', 45.00),
('P008', 'Sprite', 'Akij', 30.00),
('P009', 'Royal Tiger', 'Globe', 67.00),
('P010', 'Fresh Cola', 'Fresh', 45.00),
('P011', 'Milk Vita', 'Milk Vita', 20.00),
('P012', 'Local Milk Pawder', 'Pran', 34.00),
('P013', 'Cadbury', 'Cadbury', 45.00),
('P014', 'Teer Oil', 'City Group', 67.00),
('P015', 'Soyabean', 'Fresh', 89.00),
('P016', 'Radhuni', 'Meghna', 56.00),
('P017', 'Salt', 'ACI', 45.00),
('P018', 'Maggi Noodles', 'Nestle', 34.00),
('P019', 'Mr. Noodles', 'Pran Food', 32.00),
('P020', 'Savlon', 'ACI', 45.00),
('P021', 'Toilet Cleaner', 'Square', 187.00),
('P022', 'Baby Lotion', 'Square', 123.00),
('P023', 'Symphony', 'Symphony', 400.00),
('P024', 'Walton', 'Walton', 500.00),
('P025', 'Washing Machine', 'Singer', 350.00),
('P026', 'Walton TV', 'Walton', 250.00),
('P027', 'Desktop', 'Sony', 350.00),
('P028', 'Shampo', 'Square', 45.00),
('P029', 'Super Salt', 'Molla', 56.00),
('P030', 'Meril', 'Square', 34.00),
('P031', 'Tibet', 'kohinoor', 45.00),
('P032', 'Keya', 'Keya Cosmetic', 78.00),
('P033', 'Sandelina', 'Kohinoor', 46.00),
('P034', 'Pusti', 'T.K Group', 23.00),
('P035', 'Family', 'T.K Group', 56.00),
('P036', 'Munchee', 'Ceylon LTD', 87.00),
('P037', 'Bombay Sweets', 'Bombay', 20.00),
('P038', 'Olympic', 'Olympic', 10.00),
('P039', 'Mama', 'President Food', 45.00),
('P040', 'Sajeeb', 'Sajeeb Group', 15.00),
('P041', 'Ifad', 'Ifad LDT', 36.00),
('P042', 'Doodles', 'New Zealand Group', 67.00),
('P043', 'Confidence', 'Confidence LTD', 59.00),
('P044', 'Cool', 'Square', 34.00),
('P045', 'Cute', 'Kohinoor', 34.00),
('P046', 'Apex Footware', 'Apex', 56.00),
('P047', 'Hometex', 'HomeTex LTD', 46.00),
('P048', 'Haiko', 'Electro Mart', 78.00),
('P049', 'Gree AC', 'Gree', 560.00),
('P050', 'LG TV', 'LG LTD', 450.00);

SELECT * FROM Products;


CREATE TABLE orders (
    Order_ID VARCHAR(10) PRIMARY KEY,
    Date DATE,
    Cust_ID VARCHAR(10),
    Product_ID VARCHAR(10),
    Quantity INT,
    Paid BOOLEAN
);

INSERT INTO orders (Order_ID, Date, Cust_ID, Product_ID, Quantity, Paid) VALUES
('OR001', '2025-06-26', 'C001', 'P010', 30, TRUE),
('OR002', '2025-06-27', 'C002', 'P015', 20, TRUE),
('OR003', '2025-06-30', 'C006', 'P007', 6, TRUE),
('OR004', '2025-06-09', 'C008', 'P042', 10, TRUE),
('OR005', '2025-06-30', 'C008', 'P006', 5, FALSE),
('OR006', '2025-06-17', 'C011', 'P030', 13, TRUE),
('OR007', '2025-06-16', 'C013', 'P002', 8, FALSE),
('OR008', '2025-06-25', 'C015', 'P005', 16, FALSE),
('OR009', '2025-06-09', 'C035', 'P001', 24, TRUE),
('OR010', '2025-06-30', 'C036', 'P004', 2, TRUE),
('OR011', '2025-06-23', 'C038', 'P009', 12, TRUE),
('OR012', '2025-07-09', 'C046', 'P008', 23, FALSE),
('OR013', '2025-07-30', 'C007', 'P043', 12, TRUE),
('OR014', '2025-06-10', 'C038', 'P048', 3, TRUE),
('OR015', '2025-06-14', 'C005', 'P007', 4, FALSE),
('OR016', '2025-06-18', 'C010', 'P010', 6, TRUE),
('OR017', '2025-06-30', 'C003', 'P004', 9, FALSE),
('OR018', '2025-06-18', 'C015', 'P011', 23, TRUE),
('OR019', '2025-06-19', 'C020', 'P003', 11, TRUE),
('OR020', '2025-06-21', 'C025', 'P003', 2, TRUE),
('OR021', '2025-06-21', 'C035', 'P050', 7, FALSE),
('OR022', '2025-06-22', 'C041', 'P022', 5, TRUE),
('OR023', '2025-06-23', 'C037', 'P006', 8, FALSE),
('OR024', '2025-06-24', 'C008', 'P005', 7, TRUE),
('OR025', '2025-06-24', 'C015', 'P011', 9, TRUE),
('OR026', '2025-06-24', 'C027', 'P040', 8, FALSE),
('OR027', '2025-06-24', 'C004', 'P002', 12, TRUE),
('OR028', '2025-06-24', 'C040', 'P011', 17, TRUE),
('OR029', '2025-06-25', 'C006', 'P003', 25, TRUE),
('OR030', '2025-06-25', 'C006', 'P012', 12, TRUE),
('OR031', '2025-06-25', 'C007', 'P013', 19, FALSE),
('OR032', '2025-06-25', 'C013', 'P015', 1, TRUE),
('OR033', '2025-06-26', 'C043', 'P014', 12, FALSE),
('OR034', '2025-06-26', 'C004', 'P025', 2, FALSE),
('OR035', '2025-06-26', 'C027', 'P030', 23, TRUE),
('OR036', '2025-06-26', 'C016', 'P050', 6, FALSE),
('OR037', '2025-06-26', 'C013', 'P017', 8, TRUE);
('OR038', '2025-07-14', 'C009', 'P011', 7, FALSE),
('OR039', '2025-07-13', 'C024', 'P021', 23, TRUE),
('OR040', '2025-07-09', 'C005', 'P010', 12, FALSE),
('OR041', '2025-07-12', 'C025', 'P039', 6, TRUE),
('OR042', '2025-07-12', 'C015', 'P044', 9, TRUE),
('OR043', '2025-07-21', 'C008', 'P007', 4, FALSE),
('OR044', '2025-07-08', 'C010', 'P019', 9, TRUE),
('OR045', '2025-07-15', 'C016', 'P011', 1, FALSE),
('OR046', '2025-07-14', 'C007', 'P018', 3, TRUE),
('OR047', '2025-07-09', 'C014', 'P017', 7, FALSE),
('OR048', '2025-07-12', 'C021', 'P047', 9, TRUE),
('OR049', '2025-07-14', 'C048', 'P040', 11, TRUE),
('OR050', '2025-07-14', 'C050', 'P050', 12, FALSE);

SELECT * FROM orders;

ALTER TABLE orders
MODIFY COLUMN Paid ENUM('Yes', 'No');

UPDATE orders SET Paid = 'Yes' WHERE Paid = 1;
UPDATE orders SET Paid = 'No' WHERE Paid = 0;

DROP TABLE orders;

CREATE TABLE orders (
    Order_ID VARCHAR(10) PRIMARY KEY,
    Date DATE,
    Cust_ID VARCHAR(10),
    Product_ID VARCHAR(10),
    Quantity INT,
    Paid ENUM('Yes', 'No')
);

INSERT INTO orders (Order_ID, Date, Cust_ID, Product_ID, Quantity, Paid) VALUES
('OR001', '2025-06-26', 'C001', 'P010', 30, 'Yes'),
('OR002', '2025-06-27', 'C002', 'P015', 20, 'Yes'),
('OR003', '2025-06-30', 'C006', 'P007', 6, 'Yes'),
('OR004', '2025-06-09', 'C008', 'P042', 10, 'Yes'),
('OR005', '2025-06-30', 'C008', 'P006', 5, 'No'),
('OR006', '2025-06-17', 'C011', 'P030', 13, 'Yes'),
('OR007', '2025-06-16', 'C013', 'P002', 8, 'No'),
('OR008', '2025-06-25', 'C015', 'P005', 16, 'No'),
('OR009', '2025-06-09', 'C035', 'P001', 24, 'Yes'),
('OR010', '2025-06-30', 'C036', 'P004', 2, 'Yes'),
('OR011', '2025-06-23', 'C038', 'P009', 12, 'Yes'),
('OR012', '2025-07-09', 'C046', 'P008', 23, 'No'),
('OR013', '2025-07-30', 'C007', 'P043', 12, 'Yes'),
('OR014', '2025-06-10', 'C038', 'P048', 3, 'Yes'),
('OR015', '2025-06-14', 'C005', 'P007', 4, 'No'),
('OR016', '2025-06-18', 'C010', 'P010', 6, 'Yes'),
('OR017', '2025-06-30', 'C003', 'P004', 9, 'No'),
('OR018', '2025-06-18', 'C015', 'P011', 23, 'Yes'),
('OR019', '2025-06-19', 'C020', 'P003', 11, 'Yes'),
('OR020', '2025-06-21', 'C025', 'P003', 2, 'Yes'),
('OR021', '2025-06-21', 'C035', 'P050', 7, 'No'),
('OR022', '2025-06-22', 'C041', 'P022', 5, 'Yes'),
('OR023', '2025-06-23', 'C037', 'P006', 8, 'No'),
('OR024', '2025-06-24', 'C008', 'P005', 7, 'Yes'),
('OR025', '2025-06-24', 'C015', 'P011', 9, 'Yes'),
('OR026', '2025-06-24', 'C027', 'P040', 8, 'No'),
('OR027', '2025-06-24', 'C004', 'P002', 12, 'Yes'),
('OR028', '2025-06-24', 'C040', 'P011', 17, 'Yes'),
('OR029', '2025-06-25', 'C006', 'P003', 25, 'Yes'),
('OR030', '2025-06-25', 'C006', 'P012', 12, 'Yes'),
('OR031', '2025-06-25', 'C007', 'P013', 19, 'No'),
('OR032', '2025-06-25', 'C013', 'P015', 1, 'Yes'),
('OR033', '2025-06-26', 'C043', 'P014', 12, 'No'),
('OR034', '2025-06-26', 'C004', 'P025', 2, 'No'),
('OR035', '2025-06-26', 'C027', 'P030', 23, 'Yes'),
('OR036', '2025-06-26', 'C016', 'P050', 6, 'No'),
('OR037', '2025-06-26', 'C013', 'P017', 8, 'Yes'),
('OR038', '2025-07-14', 'C009', 'P011', 7, 'No'),
('OR039', '2025-07-13', 'C024', 'P021', 23, 'Yes'),
('OR040', '2025-07-09', 'C005', 'P010', 12, 'No'),
('OR041', '2025-07-12', 'C025', 'P039', 6, 'Yes'),
('OR042', '2025-07-12', 'C015', 'P044', 9, 'Yes'),
('OR043', '2025-07-21', 'C008', 'P007', 4, 'No'),
('OR044', '2025-07-08', 'C010', 'P019', 9, 'Yes'),
('OR045', '2025-07-15', 'C016', 'P011', 1, 'No'),
('OR046', '2025-07-14', 'C007', 'P018', 3, 'Yes'),
('OR047', '2025-07-09', 'C014', 'P017', 7, 'No'),
('OR048', '2025-07-12', 'C021', 'P047', 9, 'Yes'),
('OR049', '2025-07-14', 'C048', 'P040', 11, 'Yes'),
('OR050', '2025-07-14', 'C050', 'P050', 12, 'No');

SELECT * FROM orders;


ALTER TABLE orders
ADD CONSTRAINT fk_orders_products
FOREIGN KEY (Product_ID) REFERENCES products(Product_ID);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (Cust_ID) REFERENCES customers(Cust_ID);

SHOW CREATE TABLE orders;

SELECT * FROM Products;

SELECT * FROM Customers;

SELECT name, City FROM customers;

SELECT * FROM Customers WHERE Credits > 15000.00;

SELECT * FROM 16th_batch;

UPDATE `marketing`.`Customers` SET `Name` = 'Asik' WHERE (`Cust_ID` = 'C010');