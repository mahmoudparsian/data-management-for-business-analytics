# Import a CSV File and Create a Table: employees

## Introduction

	1. Consider the following CSV file, which is 
	imported to MySQL database as an employees table:

		% head employee_records.csv
		employee_id,employee_name,age,country,department,position,salary,joined_date
		1,Daniel Taylor,25,UK,HR,Analyst,142278.32,2023-06-04
		2,Ethan Brown,44,India,Marketing,Executive,98549.2,2018-01-13
		3,Sophia Martinez,51,Japan,Finance,Developer,85565.84,2015-04-30
		4,Ethan Martinez,47,Germany,Support,Analyst,34513.67,2015-06-17
		5,Mia Brown,32,Australia,Support,Consultant,45339.72,2019-02-22
		6,Ava Moore,35,Japan,HR,Executive,90973.25,2018-09-29
		7,Mason Brown,48,UK,Finance,Assistant,58227.95,2021-08-24
		8,Mason Anderson,45,USA,Finance,Manager,147839.1,2021-01-08
		9,Sophia Wilson,40,Brazil,Marketing,Developer,126394.86,2018-12-20

	2. provide 20 basic English/SQL queries

	3. provide 20 intermediate English/SQL queries

	4. provide 20 advanced English/SQL queries (including very 
   		basic ranking, very basic subqueries using "WITH")

	5. provide a data exploration and basic analytics about this
   		table: read all records from employees table and then do 
   		the exploration (no need to save images)
   
	6. provide a jupyter version of #4


## Table Schema

```sql
mysql> SHOW CREATE TABLE employees;
+-----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table     | Create Table                                                                                                                                                                                                                                                                                     |
+-----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| employees | CREATE TABLE `employees` (
  `employee_id` int DEFAULT NULL,
  `employee_name` text,
  `age` int DEFAULT NULL,
  `country` text,
  `department` text,
  `position` text,
  `salary` double DEFAULT NULL,
  `joined_date` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+-----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.001 sec)
```


## 📂 Deliverables

	1.	60 SQL queries in English + SQL
		•	20 basic/simple
		•	20 basic to intermediate
		•	20 intermediate++ (includes WITH, ranking, subqueries)
		•	Provided in one Markdown file for easy sharing.
	
	2.	Data Exploration & Basic Analytics (Python script):
	•	Read from MySQL employees table.
	•	Explore: shape, schema, head, summary statistics, 
	    nulls, unique values, distributions, groupby summaries, etc.
	    
	3.	Jupyter Notebook version of exploration (same as #2).


