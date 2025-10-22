use jan22;
create table manufacturers(
code integer PRIMARY KEY NOT NULL,
NAME CHAR(50) not null);

create table products(
code integer primary key not null,
name char(50) not null,
price real not null,
manufacturer integer not null
);

insert into manufacturers(code,name) values (1,'Sony');
insert into manufacturers(code,name) values (2, 'Creative Labs');
INSERT INTO Manufacturers(Code,Name) VALUES(3,'Hewlett-Packard');
INSERT INTO Manufacturers(Code,Name) VALUES(4,'Iomega');
INSERT INTO Manufacturers(Code,Name) VALUES(5,'Fujitsu');
INSERT INTO Manufacturers(Code,Name) VALUES(6,'Winchester');
INSERT INTO Manufacturers(Code,Name) VALUES(7,'Bose');


insert into Products (code,name,price,Manufacturer) values
(1,'Hard Drive',240,5);

INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(2,'Memory',120,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(3,'ZIP drive',150,4);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(4,'Floppy disk',5,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(5,'Monitor',240,1);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(6,'DVD drive',180,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(7,'CD drive',90,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(8,'Printer',270,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(9,'Toner cartridge',66,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(10,'DVD burner',180,2);

#Q1: select the names of all products in the store.

select name  from products;

#Q2: select the names and price of all products in the store.
select name , price from products;

#Q3: select the name and price less than or equal to 200.

select name  from products 
where price <=200;

#Q4. Select prouduts with the prices between 60 and 120.
select * from products
where price between 60 and 120;

SELECT * FROM Products   
WHERE Price >= 60 AND Price <= 120;

#Q5.Select the name and price in cents (i.e., the price must be multiplied by 100).

select name ,price *100 from products;
select name , price *100 as PriceCents from products;

#Q6.Compute the average price of all the products.
select avg(price) from products;

#Q7.  Compute the average price of all products with manufacturer code equal to 2.
select avg(price) from products where
manufacturer = 2;

#Q8. Compute the number of products with a price larger than or equal to $180.

select count(*) from products
where price >=180;

#Q9. Select the name and price of all products with a price larger than or equal to $180, and sort first by 
-- price (in descending order),and then by name (in ascending order).

select name,price from products
where price >= 180
order by price DESC , name ;

#Q10. Select all the data from the products, including all the data for each product's manufacturer.

select * from products, manufacturers
where products.manufacturer = manufacturers.code;

select * from products
left join manufacturers
on products.manufacturer = manufacturers.code;

#Q11.Select the product name, price, and manufacturer name of all the products.
select products.name,price,manufacturers.name
from products, manufacturers
where products.manufacturer = manufacturers.code;

select products.name,price,manufacturers.name
from products
inner join manufacturers
on products.manufacturer = manufacturers.code;

#Q12.Select the average price of each manufacturer's products, showing only the manufacturer's code.

select avg(price),manufacturer
from products
group by manufacturer;

#Q13.Select the average price of each manufacturer's products, showing the manufacturer's name.

select avg(price),manufacturers.name
from products 
inner join manufacturers
on products.manufacturer = manufacturers.code
group by manufacturers.name;

#Q14.select the names of manufacturer whose products have an average price larger than or equal to $150.
select avg(price),manufacturers.name
from products 
inner join manufacturers
on products.manufacturer = manufacturers.code
group by manufacturers.name
having avg(price)>=150;

#Q15.Select the name and price of the cheapest product.
select name,price
from products
where price = (select min(price)from products);

#Q16.Select the name of each manufacturer along with the name and price of its most expensive product.
select a.name,a.price,F.name
from products a
inner join manufacturers f
on a.manufacturer = f.code
and a.price = 
(select max(a.price) from products a
where a.manufacturer = f.code);

#Q17.Select the name of each manufacturer which have an average price above $145 and contain at least 2 different products.

select m.name ,avg(p.price) as p_price,
count(p.manufacturer) as m_count
from manufacturers m, products p
where p.manufacturer = m.code
group by p.manufacturer
having p_price >=150 and m_count >=2;


#Q18.  Add a new product: Loudspeakers, $70, manufacturer 2.

insert into products (code,name,price,manufacturer)
values (11,'Loudspeaker',70,2);

#Q19. Update the name of product 8 to "Laser Printer".
update products 
SET name = 'Laser Printer'
where code = 8;

#Q20.Apply a 10% discount to all products.

update products 
set price = price - (price *0.1);

#Q21. Apply a 10% discount to all products with a price larger than or equal to $120.
update products
set price = price - (price * 0.1)
where price >=120;