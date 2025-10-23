# Customer and Order Model

## customers Table: 

	Stores individual customer information 
	with a unique customer_id as the primary 
	key, along with columns like name, email, 
	country, gender and phone_number.

## products Table: 

	Stores individual product information 
	with a unique product_id as the primary 
	key, along with columns like product_name, 
	category, color.

## orders Table: 

	Stores order details, with each row 
	representing a single order. It includes 
	a order_id as the primary key and a 
	customer_id as a foreign key to link it 
	to the customer who placed the order, 
	and product_id link to products table, 
	and paid_price (as an integer).

## Relationship: One-to-Many. 

	One customer can place many orders, 
	but each order belongs to only one 
	customer.

## Learning Focus: 

	Introduces the concept of primary and 
	foreign keys to connect tables, enabling 
	a user to find a customer's orders or find 
	a customer's details from an order. 

## What to create:

	1. Complete MySQL schema for 3 tables: 
	   customers, products, and orders

	2. customers table with 22 rows from different 
	   countries.  2 of the customers will not place 
	   any orders at all (will be used for LEFT 
	   join operation)

	3. products table with 54 rows: make it as 
	   real as possible.   4 of the products were 
	   never sold to any one at all (will be used 
	   for LEFT join operation)

	4. orders table: 300 rows: please make sure 
	   that we do not have even number of orders 
	   per customer.

	5. Then 30 simple English/SQL queries using 
	   all these tables

	6. Then 30 simple-to-intermediate English/SQL 
	   queries using all these tables

	7. Then 30 intermediate English/SQL queries 
	   using all these tables: using sub-queries 
	   using "WITH" and ranking functions such as 
	   row_number(), rank(), dense_rank()
   
	8. Then give a python program for data exploration 
	   and visualization: have at least 9 visuals from 
	   these 3 tables.
   
 
# Files:

	•	schema_and_data.md — full schema + inserts 
	    for customers, products, orders
	
	•	schema.sql — executable SQL script
	
	•	customer_orders_queries.md — placeholder with 
	    90 queries (30 simple, 30 simple-to-intermediate, 
	    30 intermediate with WITH and ranking)

	•	data_exploration.py — Python script for data 
	    exploration & visualization (ready to be expanded 
	    into 9 visuals)


## File: `customer_orders_queries.md`

	This file contains the query sets 
	for the Customer & Order Model.


#### 30 Simple Queries
	(Examples shown in earlier generated content)

#### 30 Simple-to-Intermediate Queries
	(Examples shown in earlier generated content)

#### 30 Intermediate Queries (WITH, ROW_NUMBER, RANK, DENSE_RANK)
	(Examples shown in earlier generated content)
	