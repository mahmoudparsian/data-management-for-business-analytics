#*********************** Single Entity Question ********************************#
#1. Prepare a list of offices sorted by country, state, city.
SELECT country, state, city from classicmodels.offices;
#2. how many employees are there in the company
SELECT count(employeeNumber) FROM classicmodels.employees;
#3. What is the total of payments received?
SELECT sum(amount) AS Total from classicmodels.payments;
#10  List all payments greater than twice the average payment. 
SELECT amount from classicmodels.payments
where amount > (select 2*avg(amount) from classicmodels.payments);
#11. What is the average percentage markup of the MSRP on buyPrice?
select avg((msrp-buyPrice)/buyPrice) from classicmodels.products;
#12. How many distinct products does ClassicModels sell?
select distinct count(productCode) from classicmodels.products;
#14. What are the names of executives with VP or Manager in their title? Use the CONCAT function to combine the employee's first name and last name into a single field for reporting.
SELECT CONCAT(firstName, ' ', lastName) AS name from classicmodels.employees
WHERE jobTitle LIKE '%Manager%' or '%VP%';
#*********************** One to many relationship ********************************#
# 4. Report the products that have not been sold.
SELECT * from classicmodels.products, orderdetails,orders
where products.productCode = orderdetails.productCode
	and orders.orderNumber = orderdetails.orderNumber
    and orders.status not like 'shipped'
group by products.productCode
;
# 5. List the amount paid by each customer.
SELECT c.customerName ,p.customerNumber, sum(amount) from 
customers c, payments p 
where c.customerNumber = p.customerNumber
group by p.customerNumber;
# 6. How many orders have been placed by Herkku Gifts?
SELECT c.customerName ,p.customerNumber, sum(amount) from 
customers c, payments p 
where c.customerNumber = p.customerNumber
group by p.customerNumber
having c.customerName = 'Herkku Gifts' ;
#*********************** Many to Many relationship ********************************#
#3. List the names of customers and their corresponding order number where a particular order from that customer has a value greater than $25,000?
SELECT c.customerName,p.amount, o.orderNumber
from payments p,customers c, orders o
where p.amount > 25000 and c.customerNumber = c.customerNumber;
#4. Are there any products that appear on all orders?
#5. List the names of products sold at less than 80% of the MSRP.
SELECT p.productName,p.MSRP from orderdetails od, products p
where od.productCode = p.productCode and MSRP >=80
GROUP by p.productName;
#*********************** Regular experience ********************************#
#1. Find products containing the name 'Ford'.
SELECT p.productName from products p
where p.productName LIKE '%Ford%';
#2. List products ending in 'ship'.
SELECT p.productName from products p
where p.productName LIKE '%ship';
#3. Report the number of customers in Denmark, Norway, and Sweden.
SELECT count(c.customerName) from customers c
where c.country = 'Denmark' or c.country = 'Norway' or c.country = 'Sweden';
