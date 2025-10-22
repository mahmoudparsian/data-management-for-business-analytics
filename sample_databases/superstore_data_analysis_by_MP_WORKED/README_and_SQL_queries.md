https://medium.com/@mohamedharris1297/superstore-analysis-using-mysql-91afa0459520

create table sales(
   row_id          INT,
   order_id        varchar(40),
   order_date      varchar(12),
   ship_date       varchar(12),
   ship_mode       varchar(40),
   customer_id     varchar(40),
   customer_name   varchar(64),
   segment         varchar(40),
   country         varchar(40),
   city            varchar(40),
   state           varchar(40),
   postal_code     varchar(20),
   region          varchar(40),
   product_id      varchar(36),
   category        varchar(40),
   sub_category    varchar(40),
   product_name    varchar(180),
   sales           double,
   quantity        INT,
   discount        double,
   profit          double
)
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


mysql -h localhost -uroot -p

mysql> CREATE DATABASE superstore_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
Query OK, 1 row affected (0.02 sec)

mysql> use superstore_db;
Database changed
mysql>

mysql> SET GLOBAL local_infile=1;

mysql> SHOW GLOBAL VARIABLES LIKE 'local_infile';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| local_infile  | ON    |
+---------------+-------+

LOAD DATA LOCAL INFILE 'superstore.csv' 
  INTO TABLE sales
  FIELDS TERMINATED BY ',' 
  OPTIONALLY ENCLOSED BY '"'
  IGNORE 1 LINES;
  



mysql> CREATE DATABASE superstore_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
Query OK, 1 row affected (0.02 sec)

mysql> use superstore_db;
Database changed
mysql> create table sales(
    ->    row_id          INT,
    ->    order_id        varchar(40),
    ->    order_date      varchar(12),
    ->    ship_date       varchar(12),
    ->    ship_mode       varchar(40),
    ->    customer_id     varchar(40),
    ->    customer_name   varchar(64),
    ->    segment         varchar(40),
    ->    country         varchar(40),
    ->    city            varchar(40),
    ->    state           varchar(40),
    ->    postal_code     varchar(20),
    ->    region          varchar(40),
    ->    product_id      varchar(36),
    ->    category        varchar(40),
    ->    sub_category    varchar(40),
    ->    product_name    varchar(180),
    ->    sales           double,
    ->    quantity        INT,
    ->    discount        double,
    ->    profit          double
    -> )
    -> CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
Query OK, 0 rows affected (0.02 sec)

mysql> LOAD DATA LOCAL INFILE 'superstore.csv'
    ->   INTO TABLE sales
    ->   FIELDS TERMINATED BY ','
    ->   OPTIONALLY ENCLOSED BY '"'
    ->   IGNORE 1 LINES;
Query OK, 9994 rows affected, 5349 warnings (0.21 sec)
Records: 9994  Deleted: 0  Skipped: 0  Warnings: 5349

mysql>   select * from sales limit 3;
+--------+----------------+------------+------------+--------------+-------------+-----------------+-----------+---------------+-------------+------------+-------------+--------+-----------------+-----------------+--------------+------------------------------------------------------------+--------+----------+----------+---------+
| row_id | order_id       | order_date | ship_date  | ship_mode    | customer_id | customer_name   | segment   | country       | city        | state      | postal_code | region | product_id      | category        | sub_category | product_name                                               | sales  | quantity | discount | profit  |
+--------+----------------+------------+------------+--------------+-------------+-----------------+-----------+---------------+-------------+------------+-------------+--------+-----------------+-----------------+--------------+------------------------------------------------------------+--------+----------+----------+---------+
|      1 | CA-2016-152156 | 11/8/2016  | 11/11/2016 | Second Class | CG-12520    | Claire Gute     | Consumer  | United States | Henderson   | Kentucky   | 42420       | South  | FUR-BO-10001798 | Furniture       | Bookcases    | Bush Somerset Collection Bookcase                          | 261.96 |        2 |        0 | 41.9136 |
|      2 | CA-2016-152156 | 11/8/2016  | 11/11/2016 | Second Class | CG-12520    | Claire Gute     | Consumer  | United States | Henderson   | Kentucky   | 42420       | South  | FUR-CH-10000454 | Furniture       | Chairs       | Hon Deluxe Fabric Upholstered Stacking Chairs Rounded Back | 731.94 |        3 |        0 | 219.582 |
|      3 | CA-2016-138688 | 6/12/2016  | 6/16/2016  | Second Class | DV-13045    | Darrin Van Huff | Corporate | United States | Los Angeles | California | 90036       | West   | OFF-LA-10000240 | Office Supplies | Labels       | Self-Adhesive Address Labels for Typewriters by Universal  |  14.62 |        2 |        0 |  6.8714 |
+--------+----------------+------------+------------+--------------+-------------+-----------------+-----------+---------------+-------------+------------+-------------+--------+-----------------+-----------------+--------------+------------------------------------------------------------+--------+----------+----------+---------+
3 rows in set (0.00 sec)


mysql> select count(*) from sales;
+----------+
| count(*) |
+----------+
|     9994 |
+----------+
1 row in set (0.02 sec)


Q1: What is the total sales and profit in each of the regions in 2018?

Q2: Which states had the maximum and minimum sales in 2018?

Q3) What is the average sales in each of the region in 2018?

Q4) What are the 5 sub categories that have the maximum profit margin in 2018?

Q5) What is the YoY change in sales?

Q6) What is the average dispatching time in each region in 2016, 2017 and 2018?

Q7) Compare the sales in 2016 and 2017 by Sub Category.

Q8) What are the top 2 sub categories in every region by most sales?

Q9) What are the 2 worst selling products in each region?

Q10) What is the most and least expensive product in each subcategory?


Data Cleansing:
---------------
mysql> desc sales;
+---------------+--------------+------+-----+---------+-------+
| Field         | Type         | Null | Key | Default | Extra |
+---------------+--------------+------+-----+---------+-------+
| row_id        | int          | YES  |     | NULL    |       |
| order_id      | varchar(40)  | YES  |     | NULL    |       |
| order_date    | varchar(12)  | YES  |     | NULL    |       |
| ship_date     | varchar(12)  | YES  |     | NULL    |       |
| ship_mode     | varchar(40)  | YES  |     | NULL    |       |
| customer_id   | varchar(40)  | YES  |     | NULL    |       |
| customer_name | varchar(64)  | YES  |     | NULL    |       |
| segment       | varchar(40)  | YES  |     | NULL    |       |
| country       | varchar(40)  | YES  |     | NULL    |       |
| city          | varchar(40)  | YES  |     | NULL    |       |
| state         | varchar(40)  | YES  |     | NULL    |       |
| postal_code   | varchar(20)  | YES  |     | NULL    |       |
| region        | varchar(40)  | YES  |     | NULL    |       |
| product_id    | varchar(36)  | YES  |     | NULL    |       |
| category      | varchar(40)  | YES  |     | NULL    |       |
| sub_category  | varchar(40)  | YES  |     | NULL    |       |
| product_name  | varchar(180) | YES  |     | NULL    |       |
| sales         | double       | YES  |     | NULL    |       |
| quantity      | int          | YES  |     | NULL    |       |
| discount      | double       | YES  |     | NULL    |       |
| profit        | double       | YES  |     | NULL    |       |
+---------------+--------------+------+-----+---------+-------+
21 rows in set (0.01 sec)

There is nothing much to do with this almost clean 
dataset (at least as this project is concerned). 
We’ll convert the datatype of the order_date and 
ship_date columns from VARCHAR to DATE.

I did this by,

Adding a new column called order_date_new
Update the values in this new column by converting 
the dates in VARCHAR to DATE using STR_TO_DATE function in MySQL


-- change order_date datatype from STRING to DATE
ALTER TABLE sales ADD (order_date_new DATE);
UPDATE sales SET order_date_new = STR_TO_DATE(order_date, '%m/%d/%Y');
ALTER TABLE Sales DROP COLUMN order_date;
ALTER TABLE sales RENAME COLUMN order_date_new TO order_date;

-- change ship_date datatype from STRING to DATE
ALTER TABLE sales ADD (ship_date_new DATE);
UPDATE sales SET ship_date_new = STR_TO_DATE(ship_date, '%m/%d/%Y');
ALTER TABLE Sales DROP COLUMN ship_date;
ALTER TABLE sales RENAME COLUMN ship_date_new TO ship_date;

The above two queries will alter the table to perform the datatype conversion. 
The resulting table is as below.

mysql> desc sales;
+---------------+--------------+------+-----+---------+-------+
| Field         | Type         | Null | Key | Default | Extra |
+---------------+--------------+------+-----+---------+-------+
| row_id        | int          | YES  |     | NULL    |       |
| order_id      | varchar(40)  | YES  |     | NULL    |       |
| ship_mode     | varchar(40)  | YES  |     | NULL    |       |
| customer_id   | varchar(40)  | YES  |     | NULL    |       |
| customer_name | varchar(64)  | YES  |     | NULL    |       |
| segment       | varchar(40)  | YES  |     | NULL    |       |
| country       | varchar(40)  | YES  |     | NULL    |       |
| city          | varchar(40)  | YES  |     | NULL    |       |
| state         | varchar(40)  | YES  |     | NULL    |       |
| postal_code   | varchar(20)  | YES  |     | NULL    |       |
| region        | varchar(40)  | YES  |     | NULL    |       |
| product_id    | varchar(36)  | YES  |     | NULL    |       |
| category      | varchar(40)  | YES  |     | NULL    |       |
| sub_category  | varchar(40)  | YES  |     | NULL    |       |
| product_name  | varchar(180) | YES  |     | NULL    |       |
| sales         | double       | YES  |     | NULL    |       |
| quantity      | int          | YES  |     | NULL    |       |
| discount      | double       | YES  |     | NULL    |       |
| profit        | double       | YES  |     | NULL    |       |
| order_date    | date         | YES  |     | NULL    |       |
| ship_date     | date         | YES  |     | NULL    |       |
+---------------+--------------+------+-----+---------+-------+
21 rows in set (0.00 sec)

Answering the questions:
Q1: What is the total sales and profit in each of the regions in 2017?

mysql> select distinct YEAR(order_date) from sales;
+------------------+
| YEAR(order_date) |
+------------------+
|             2016 |
|             2015 |
|             2014 |
|             2017 |
+------------------+
4 rows in set (0.01 sec)

SELECT region, 
       FLOOR(SUM(sales)) AS sales, 
       FLOOR(SUM(profit)) AS profit 
FROM Sales
WHERE YEAR(order_date) = 2017
GROUP BY region
ORDER BY 2 DESC;

mysql> SELECT region,
    ->        FLOOR(SUM(sales)) AS sales,
    ->        FLOOR(SUM(profit)) AS profit
    -> FROM Sales
    -> WHERE YEAR(order_date) = 2017
    -> GROUP BY region
    -> ORDER BY 2 DESC;
+---------+--------+--------+
| region  | sales  | profit |
+---------+--------+--------+
| West    | 217981 |  43420 |
| East    | 186297 |  31590 |
| Central | 136398 |   9332 |
| South   | 112881 |   7172 |
+---------+--------+--------+
4 rows in set (0.01 sec)


Q2: Which states had the maximum and minimum sales in 2017?

Since this question demands the names of states that 
had both maximum and minimum sales respectively in 2017, 
we need to give the answer in the same output table. 
Let’s achieve this by writing two sub queries and 
then union them as below.

(SELECT state, FLOOR(SUM(sales)) AS sales 
FROM Sales
WHERE YEAR(order_date) = 2017
GROUP BY state
ORDER BY 2 DESC
LIMIT 1)
UNION
(SELECT state, FLOOR(SUM(sales)) AS sales 
FROM Sales
WHERE YEAR(order_date) = 2017
GROUP BY state
ORDER BY 2 ASC
LIMIT 1);

mysql> (SELECT state, FLOOR(SUM(sales)) AS sales
    -> FROM Sales
    -> WHERE YEAR(order_date) = 2017
    -> GROUP BY state
    -> ORDER BY 2 DESC
    -> LIMIT 1)
    -> UNION
    -> (SELECT state, FLOOR(SUM(sales)) AS sales
    -> FROM Sales
    -> WHERE YEAR(order_date) = 2017
    -> GROUP BY state
    -> ORDER BY 2 ASC
    -> LIMIT 1);
+----------------------+--------+
| state                | sales  |
+----------------------+--------+
| California           | 127333 |
| District of Columbia |     77 |
+----------------------+--------+
2 rows in set (0.02 sec)


Q3) What is the average sales in each of the region in 2017?

SELECT region, 
       FLOOR(AVG(sales)) AS average_sales 
FROM Sales
WHERE YEAR(order_date) = 2017
GROUP BY region
ORDER BY average_sales DESC;

mysql> SELECT region,
    ->        FLOOR(AVG(sales)) AS average_sales
    -> FROM Sales
    -> WHERE YEAR(order_date) = 2017
    -> GROUP BY region
    -> ORDER BY average_sales DESC;
+---------+---------------+
| region  | average_sales |
+---------+---------------+
| South   |           217 |
| East    |           202 |
| West    |           199 |
| Central |           175 |
+---------+---------------+
4 rows in set (0.01 sec)


Q4) What are the 5 sub categories that have the maximum profit margin in 2017?

SELECT sub_category, 
       FLOOR((SUM(profit)/SUM(sales))*100) AS profit_margin_percent 
FROM Sales
WHERE YEAR(order_date) = 2017
GROUP BY sub_category
ORDER BY 2 DESC
LIMIT 5;

mysql> SELECT sub_category,
    ->        FLOOR((SUM(profit)/SUM(sales))*100) AS profit_margin_percent
    -> FROM Sales
    -> WHERE YEAR(order_date) = 2017
    -> GROUP BY sub_category
    -> ORDER BY 2 DESC
    -> LIMIT 5;
+--------------+-----------------------+
| sub_category | profit_margin_percent |
+--------------+-----------------------+
| Paper        |                    44 |
| Copiers      |                    39 |
| Envelopes    |                    39 |
| Accessories  |                    25 |
| Furnishings  |                    21 |
+--------------+-----------------------+
5 rows in set (0.01 sec)


Q5) What is the YoY change in sales?

Let’s answer this question by writing two 
sub queries and then joining it. We can use 
row_number to assign a number to every row 
and then use it to navigate to the adjacent 
rows to find the difference in sales between 
the previous and the current row.

WITH yearly_sales AS
(
  SELECT YEAR(order_date) AS order_year, 
         FLOOR(SUM(sales)) AS sales,
         row_number() OVER (ORDER BY YEAR(order_date)) AS rn
  FROM Sales
  GROUP BY order_year
  ORDER BY order_year
)
SELECT S1.order_year, 
       S1.sales,
       COALESCE(
                FLOOR(
                      ((S1.sales - S2.sales)/S2.sales) * 100
                     ), 0
               ) 
         AS YoY_Percent_Change_Sales
FROM yearly_sales S1
LEFT JOIN yearly_sales S2
ON S1.rn = S2.rn + 1;

mysql> WITH yearly_sales AS
    -> (
    ->   SELECT YEAR(order_date) AS order_year,
    ->          FLOOR(SUM(sales)) AS sales,
    ->          row_number() OVER (ORDER BY YEAR(order_date)) AS rn
    ->   FROM Sales
    ->   GROUP BY order_year
    ->   ORDER BY order_year
    -> )
    -> SELECT S1.order_year,
    ->        S1.sales,
    ->        COALESCE(
    ->                 FLOOR(
    ->                       ((S1.sales - S2.sales)/S2.sales) * 100
    ->                      ), 0
    ->                )
    ->          AS YoY_Percent_Change_Sales
    -> FROM yearly_sales S1
    -> LEFT JOIN yearly_sales S2
    -> ON S1.rn = S2.rn + 1;
+------------+--------+--------------------------+
| order_year | sales  | YoY_Percent_Change_Sales |
+------------+--------+--------------------------+
|       2014 | 431256 |                        0 |
|       2015 | 416504 |                       -4 |
|       2016 | 526741 |                       26 |
|       2017 | 653558 |                       24 |
+------------+--------+--------------------------+
4 rows in set (0.01 sec)


Q6) What is the average dispatching time 
in each region in 2015, 2016 and 2017?

Dispatching time is the difference in time between 
the Shipped Date and Ordered Date. We can calculate 
this by using the DATEDIFF function and supplying 
the above two column names.

Let us write 3 sub queries to find the dispatching time 
for each of the years and then join those three tables 
by using a JOIN function as below.

WITH 
R1 AS
( SELECT Region,
  ROUND(AVG(DATEDIFF(ship_date, order_date)),2) AS Dispatching_Time_2015
 FROM Sales
 WHERE YEAR(order_date) = 2015
 GROUP BY Region
),
R2 AS
( SELECT Region,
  ROUND(AVG(DATEDIFF(ship_date, order_date)),2) AS Dispatching_Time_2016
  FROM Sales
  WHERE YEAR(order_date) = 2016
  GROUP BY Region
),
R3 AS
( SELECT Region,
  ROUND(AVG(DATEDIFF(ship_date, order_date)),2) AS Dispatching_Time_2017
  FROM Sales
  WHERE YEAR(order_date) = 2017
  GROUP BY Region
)
SELECT R1.Region,
       R1.Dispatching_Time_2015,
       R2.Dispatching_Time_2016,
       R3.Dispatching_Time_2017 
FROM R1
JOIN R2 ON R1.Region = R2.Region
JOIN R3 ON R2.Region = R3.Region;

mysql> WITH
    -> R1 AS
    -> ( SELECT Region,
    ->   ROUND(AVG(DATEDIFF(ship_date, order_date)),2) AS Dispatching_Time_2015
    ->  FROM Sales
    ->  WHERE YEAR(order_date) = 2015
    ->  GROUP BY Region
    -> ),
    -> R2 AS
    -> ( SELECT Region,
    ->   ROUND(AVG(DATEDIFF(ship_date, order_date)),2) AS Dispatching_Time_2016
    ->   FROM Sales
    ->   WHERE YEAR(order_date) = 2016
    ->   GROUP BY Region
    -> ),
    -> R3 AS
    -> ( SELECT Region,
    ->   ROUND(AVG(DATEDIFF(ship_date, order_date)),2) AS Dispatching_Time_2017
    ->   FROM Sales
    ->   WHERE YEAR(order_date) = 2017
    ->   GROUP BY Region
    -> )
    -> SELECT R1.Region,
    ->        R1.Dispatching_Time_2015,
    ->        R2.Dispatching_Time_2016,
    ->        R3.Dispatching_Time_2017
    -> FROM R1
    -> JOIN R2 ON R1.Region = R2.Region
    -> JOIN R3 ON R2.Region = R3.Region;
+---------+-----------------------+-----------------------+-----------------------+
| Region  | Dispatching_Time_2015 | Dispatching_Time_2016 | Dispatching_Time_2017 |
+---------+-----------------------+-----------------------+-----------------------+
| South   |                  4.34 |                  3.76 |                  3.92 |
| Central |                  3.99 |                  4.15 |                  3.95 |
| West    |                  3.96 |                  4.00 |                  3.81 |
| East    |                  3.91 |                  3.85 |                  3.97 |
+---------+-----------------------+-----------------------+-----------------------+
4 rows in set (0.02 sec)


Q7) Compare the sales in 2016 and 2017 by Sub Category.

Let’s write two sub queries to find the sales 
by sub_category in 2016 and 2017. We’ll join 
these tables and then find the difference in 
sales between these years.

With 
S_2016 AS
(
  SELECT sub_category, FLOOR(SUM(Sales)) AS Sales_2016
  FROM Sales
  WHERE YEAR(order_date) = 2016
  GROUP BY sub_category
),
S_2017 AS
(
  SELECT sub_category, FLOOR(SUM(Sales)) AS Sales_2017
  FROM Sales
  WHERE YEAR(order_date) = 2017
  GROUP BY sub_category
)
SELECT S_2016.sub_category, 
       Sales_2016, 
       Sales_2017, 
       (Sales_2017 - Sales_2016) AS CY_vs_PY_Sales
FROM S_2016
JOIN S_2017 ON S_2016.sub_category = S_2017.sub_category
ORDER BY CY_vs_PY_Sales DESC;

mysql> With
    -> S_2016 AS
    -> (
    ->   SELECT sub_category, FLOOR(SUM(Sales)) AS Sales_2016
    ->   FROM Sales
    ->   WHERE YEAR(order_date) = 2016
    ->   GROUP BY sub_category
    -> ),
    -> S_2017 AS
    -> (
    ->   SELECT sub_category, FLOOR(SUM(Sales)) AS Sales_2017
    ->   FROM Sales
    ->   WHERE YEAR(order_date) = 2017
    ->   GROUP BY sub_category
    -> )
    -> SELECT S_2016.sub_category,
    ->        Sales_2016,
    ->        Sales_2017,
    ->        (Sales_2017 - Sales_2016) AS CY_vs_PY_Sales
    -> FROM S_2016
    -> JOIN S_2017 ON S_2016.sub_category = S_2017.sub_category
    -> ORDER BY CY_vs_PY_Sales DESC;
+--------------+------------+------------+----------------+
| sub_category | Sales_2016 | Sales_2017 | CY_vs_PY_Sales |
+--------------+------------+------------+----------------+
| Phones       |      78210 |     102484 |          24274 |
| Binders      |      48592 |      71535 |          22943 |
| Storage      |      35748 |      53424 |          17676 |
| Accessories  |      41436 |      58372 |          16936 |
| Chairs       |      59583 |      74038 |          14455 |
| Copiers      |      49599 |      62899 |          13300 |
| Appliances   |      23226 |      35781 |          12555 |
| Labels       |      11936 |      22255 |          10319 |
| Paper        |      27373 |      34056 |           6683 |
| Art          |       8127 |      10637 |           2510 |
| Fasteners    |        740 |       3054 |           2314 |
| Supplies     |      14069 |      15856 |           1787 |
| Furnishings  |      17275 |      17684 |            409 |
| Envelopes    |       2808 |       2361 |           -447 |
| Bookcases    |      12710 |      10170 |          -2540 |
| Tables       |      49842 |      42087 |          -7755 |
| Machines     |      45458 |      36858 |          -8600 |
+--------------+------------+------------+----------------+
17 rows in set (0.01 sec)


Q8) What are the top 2 sub categories 
    in every region by most sales?

We’ll utilize the window functions from this question 
(RANK, ROW_NUMBER, DENSE_RANK, FIRST_VALUE etc.)

SELECT R2.* FROM
(SELECT R1.*, RANK() OVER(PARTITION BY Region ORDER BY Sales DESC) AS Sales_Rank FROM
(SELECT Region, sub_category, FLOOR(SUM(Sales)) AS Sales
FROM Sales
GROUP BY Region, sub_category
ORDER BY Region, Sales DESC) R1)R2
WHERE R2.Sales_Rank < 3;

mysql> SELECT R2.* FROM
    -> (SELECT R1.*, RANK() OVER(PARTITION BY Region ORDER BY Sales DESC) AS Sales_Rank FROM
    -> (SELECT Region, sub_category, FLOOR(SUM(Sales)) AS Sales
    -> FROM Sales
    -> GROUP BY Region, sub_category
    -> ORDER BY Region, Sales DESC) R1)R2
    -> WHERE R2.Sales_Rank < 3;
+---------+--------------+-------+------------+
| Region  | sub_category | Sales | Sales_Rank |
+---------+--------------+-------+------------+
| Central | Phones       | 71464 |          1 |
| Central | Chairs       | 61937 |          2 |
| East    | Phones       | 98608 |          1 |
| East    | Chairs       | 72311 |          2 |
| South   | Phones       | 57019 |          1 |
| South   | Machines     | 52382 |          2 |
| West    | Phones       | 97127 |          1 |
| West    | Chairs       | 82196 |          2 |
+---------+--------------+-------+------------+
8 rows in set (0.02 sec)


Q9) What are the 2 worst selling products in each region?

SELECT R2.* FROM
(SELECT R1.*, RANK() OVER(PARTITION BY Region ORDER BY TotalSales) AS Sales_Rank FROM
(SELECT Region, sub_category, FLOOR(SUM(Sales)) AS TotalSales
FROM Sales
GROUP BY Region, sub_category
ORDER BY Region, TotalSales DESC) R1)R2
WHERE R2.Sales_Rank < 3;

mysql> SELECT R2.* FROM
    -> (SELECT R1.*, RANK() OVER(PARTITION BY Region ORDER BY TotalSales) AS Sales_Rank FROM
    -> (SELECT Region, sub_category, FLOOR(SUM(Sales)) AS TotalSales
    -> FROM Sales
    -> GROUP BY Region, sub_category
    -> ORDER BY Region, TotalSales DESC) R1)R2
    -> WHERE R2.Sales_Rank < 3;
+---------+--------------+------------+------------+
| Region  | sub_category | TotalSales | Sales_Rank |
+---------+--------------+------------+------------+
| Central | Fasteners    |       2988 |          1 |
| Central | Envelopes    |       3693 |          2 |
| East    | Fasteners    |       1458 |          1 |
| East    | Envelopes    |       3381 |          2 |
| South   | Fasteners    |       1174 |          1 |
| South   | Envelopes    |       2063 |          2 |
| West    | Envelopes    |       2270 |          1 |
| West    | Fasteners    |       3074 |          2 |
+---------+--------------+------------+------------+
8 rows in set (0.01 sec)


Q10) What is the most and least expensive product in each subcategory?

SELECT S1.* FROM
(SELECT sub_category,
FIRST_VALUE(product_name) OVER w AS Expensive_Product,
LAST_VALUE(product_name) OVER w AS Cheapest_Product
FROM Sales
WINDOW W AS (PARTITION BY sub_category ORDER BY FLOOR((Sales/Quantity)) DESC
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) S1
GROUP BY sub_category;

mysql> SELECT S1.* FROM
    -> (SELECT sub_category,
    -> FIRST_VALUE(product_name) OVER w AS Expensive_Product,
    -> LAST_VALUE(product_name) OVER w AS Cheapest_Product
    -> FROM Sales
    -> WINDOW W AS (PARTITION BY sub_category ORDER BY FLOOR((Sales/Quantity)) DESC
    -> RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) S1
    -> GROUP BY sub_category;
+--------------+--------------------------------------------------------------------+------------------------------------------------------------------------+
| sub_category | Expensive_Product                                                  | Cheapest_Product                                                       |
+--------------+--------------------------------------------------------------------+------------------------------------------------------------------------+
| Accessories  | Plantronics Savi W720 Multi-Device Wireless Headset System         | Verbatim 25 GB 6x Blu-ray Single Layer Recordable Disc                 |
| Appliances   | Hoover WindTunnel Plus Canister Vacuum                             | Fellowes Premier Superior Surge Suppressor                             |
| Art          | Boston Heavy-Duty Trimline Electric Pencil Sharpeners              | Premium Writing Pencils                                                |
| Binders      | Ibico EPK-21 Electric Binding System                               | GBC Pre-Punched Binding Paper                                          |
| Bookcases    | DMI Eclipse Executive Suite Bookcases                              | Safco Value Mate Series Steel Bookcases                                |
| Chairs       | HON 5400 Series Task Chairs for Big and Tall                       | Padded Folding Chairs                                                  |
| Copiers      | Canon imageCLASS 2200 Advanced Copier                              | Canon PC-428 Personal Copier                                           |
| Envelopes    | Multimedia Mailers                                                 | Inter-Office Recycled Envelopes                                        |
| Fasteners    | Vinyl Coated Wire Paper Clips in Organizer Box                     | OIC Colored Binder Clips                                               |
| Furnishings  | Luxo Professional Fluorescent Magnifier Lamp with Clamp-Mount Base | Career Cubicle Clock                                                   |
| Labels       | Avery 477                                                          | Avery 05222 Permanent Self-Adhesive File Folder Labels for Typewriters |
| Machines     | Cisco TelePresence System EX90 Videoconferencing Unit              | Canon Color ImageCLASS MF8580Cdw Wireless Laser All-In-One Printer     |
| Paper        | White Dual Perf Computer Printout Paper                            | Message Book                                                           |
| Phones       | Apple iPhone 5                                                     | Square Credit Card Reader                                              |
| Storage      | Tennsco 16-Compartment Lockers with Coat Rack                      | Advantus 10-Drawer Portable Organizer                                  |
| Supplies     | High Speed Automatic Electric Letter Opener                        | Fiskars 8 Scissors                                                     |
| Tables       | Chromcraft Bull-Nose Wood 48 x 96 Rectangular Conference Tables    | SAFCO PlanMaster Heigh-Adjustable Drafting Table Base                  |
+--------------+--------------------------------------------------------------------+------------------------------------------------------------------------+
17 rows in set, 768 warnings (0.08 sec)

mysql>