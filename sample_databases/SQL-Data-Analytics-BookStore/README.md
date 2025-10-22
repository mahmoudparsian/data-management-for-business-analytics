# SQL-Data-Analytics-BookStore

This is a SQL-only data analytics project built in MySQL Workbench.
It simulates an Online Bookstore where I imported CSV datasets into MySQL tables and wrote 20+ SQL queries (basic & advanced) to extract business insights.

# Project Overview
The focus of this project is on data analysis using SQL — querying, aggregations, joins, grouping, and insights.

## Data Sets of this Project
The project uses three CSV datasets (included in the data/ folder):

Books.csv → Book_ID, Title, Author, Genre, Published_Year, Price, Stock

Customers.csv → Customer_ID, Name, Email, Phone, City, Country

Orders.csv → Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount

These files were imported into MySQL using LOAD DATA INFILE.

## Queries

14 Basic Queries — filtering, aggregation, grouping, ordering
8 Advanced Queries — joins, group aggregates, HAVING, subqueries, top-N queries

## Questions

14 Basics & 8 Advanced 

#Basics:

- Retrieve all books in the "Fiction" genre
- Retrieve the "average" price of all books
- Show the top 5 most recently published books
- Count how many customers are from each country
- Find books published after the year 1950
- List all customers from the Canada
- Show orders placed in November 2023
- Retrieve the total stock of books available
- Find the details of the most expensive book
- Show all customers who ordered more than 1 quantity of a book
- Retrieve all orders where the total amount exceeds $20
- List all genres available in the Books table
- Find the book with the lowest stock
- Calculate the total revenue generated from all orders

#Advance
- Retrieve the total number of books sold for each genre
- Find the average price of books in the "Fantasy" genre
- List customers who have placed at least 2 orders
- Find the most frequently ordered book
- Show the top 3 most expensive books of 'Fantasy' Genre
- Retrieve the total quantity of books sold by each author
- List the cities where customers who spent over $30 are located
- Find the customer who spent the most on orders
  
# Project Demonstrates

- Ability to import and work with external data in MySQL.
- Skill of writing Basic & Advance level (Such as Grouping, Joins, Aggregession & Filtering) queries to solve business problems.
- Ability of analyzing revenue trends, customer purchasing behavior, inventory levels and top-performing genres/authors.

## View the Queries
Click on this link to see the queries: https://github.com/Shahimti/SQL-Data-Analytics-BookStore/blob/main/Bookstore%20Portfolio%20Project.sql
