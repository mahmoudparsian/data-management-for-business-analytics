# Method-1: Load CSV file and Create a Table
### Use MySQLWorkbench

	Use MySQLWorkbench to import the salaries_data.csv data.
	First select a database, then right click and them import.

	Import Worked on 9/24/2025
	
# Method-2: Load CSV file and Create a Table
### Use LOAD DATA from Command Line

~~~
 % mysql --local-infile=1 -h localhost -u root -p

CREATE DATABASE my_test_db 
     CHARACTER SET utf8mb4 
     COLLATE utf8mb4_0900_ai_ci;

use my_test_db;

CREATE TABLE `salaries` (
  `Id` int DEFAULT NULL,
  `EmployeeName` text,
  `JobTitle` text,
  `BasePay` double DEFAULT NULL,
  `OvertimePay` double DEFAULT NULL,
  `OtherPay` double DEFAULT NULL,
  `Benefits` text,
  `TotalPay` double DEFAULT NULL,
  `TotalPayBenefits` double DEFAULT NULL,
  `Year` int DEFAULT NULL,
  `Notes` text,
  `Agency` text,
  `Status` text
)  
CHARSET=utf8mb4 
COLLATE=utf8mb4_0900_ai_ci;

mysql> SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE "/Users/max/mp/dominican_university/MP_MSBA_5503/homeworks/employee_salaries/salaries_data.csv"
INTO TABLE salaries
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
~~~

### Log of Activities

~~~
% mysql --local-infile=1 -h localhost -u root -p
Enter password: xxxxxxxx

Server version: 9.2.0 MySQL Community Server - GPL


mysql> CREATE DATABASE my_test_db
    ->      CHARACTER SET utf8mb4
    ->      COLLATE utf8mb4_0900_ai_ci;
Query OK, 1 row affected (0.01 sec)

mysql> use my_test_db;
Database changed

mysql> CREATE TABLE `salaries` (
    ->   `Id` int DEFAULT NULL,
    ->   `EmployeeName` text,
    ->   `JobTitle` text,
    ->   `BasePay` double DEFAULT NULL,
    ->   `OvertimePay` double DEFAULT NULL,
    ->   `OtherPay` double DEFAULT NULL,
    ->   `Benefits` text,
    ->   `TotalPay` double DEFAULT NULL,
    ->   `TotalPayBenefits` double DEFAULT NULL,
    ->   `Year` int DEFAULT NULL,
    ->   `Notes` text,
    ->   `Agency` text,
    ->   `Status` text
    -> )
    -> CHARSET=utf8mb4
    -> COLLATE=utf8mb4_0900_ai_ci;
Query OK, 0 rows affected (0.00 sec)


mysql> SET GLOBAL local_infile = 1;
Query OK, 0 rows affected (0.00 sec)

mysql> LOAD DATA LOCAL INFILE "/Users/max/mp/dominican_university/MP_MSBA_5503/homeworks/employee_salaries/salaries_data.csv"
    -> INTO TABLE salaries
    -> COLUMNS TERMINATED BY ','
    -> OPTIONALLY ENCLOSED BY '"'
    -> ESCAPED BY '"'
    -> LINES TERMINATED BY '\n'
    -> IGNORE 1 LINES;
Query OK, 148654 rows affected, 617 warnings (0.43 sec)
Records: 148654  Deleted: 0  Skipped: 0  Warnings: 617

mysql> show tables;
+----------------------+
| Tables_in_my_test_db |
+----------------------+
| salaries             |
+----------------------+
1 row in set (0.00 sec)

mysql> select count(*) from salaries;
+----------+
| count(*) |
+----------+
|   148654 |
+----------+
1 row in set (0.01 sec)

mysql> select * from salaries limit 3;
+------+----------------+------------------------------------------------+-----------+-------------+-----------+----------+-----------+------------------+------+-------+---------------+--------+
| Id   | EmployeeName   | JobTitle                                       | BasePay   | OvertimePay | OtherPay  | Benefits | TotalPay  | TotalPayBenefits | Year | Notes | Agency        | Status |
+------+----------------+------------------------------------------------+-----------+-------------+-----------+----------+-----------+------------------+------+-------+---------------+--------+
|    1 | NATHANIEL FORD | GENERAL MANAGER-METROPOLITAN TRANSIT AUTHORITY | 167411.18 |           0 | 400184.25 |          | 567595.43 |        567595.43 | 2011 |       | San Francisco |        |
|    2 | GARY JIMENEZ   | CAPTAIN III (POLICE DEPARTMENT)                | 155966.02 |   245131.88 | 137811.38 |          | 538909.28 |        538909.28 | 2011 |       | San Francisco |        |
|    3 | ALBERT PARDINI | CAPTAIN III (POLICE DEPARTMENT)                | 212739.13 |   106088.18 |   16452.6 |          | 335279.91 |        335279.91 | 2011 |       | San Francisco |        |
+------+----------------+------------------------------------------------+-----------+-------------+-----------+----------+-----------+------------------+------+-------+---------------+--------+
3 rows in set (0.00 sec)
~~~
