# Data Story and SQL Queries

	OK, for the first time I have installed 
	mysql on my macbook/windows, and I want 
	to practice some SQL commands.

~~~
1. Let's create a products table with the following columns:

-- id (unique id as 1, 2, 3, ...)
-- name (as a product name)
-- category (5 of them as: home, electronics, shoes, cloths, jewelry)
-- price (as integer)
-- country (5 of them as  USA, CANADA, MEXICO, GERMANY, ITALY)
-- color (5 of them: red, blue, gray, white, black)

2. Create a table schema in MySQL

3. populate table with SQL's INSERT statements:
   let's create 60 products: 
   -- make sure the number of products per countries are not even
   -- make sure the number of categories per products are not even
   -- make sure the color per products are not even

4. Provide 40 English/SQL queries from 
   very basic to basic to very intermediate:
   these queries should be thoughtful and meaningful
   
5. All of these on one downloadable file in markdown format
~~~

# Products Table SQL Practice

## 1. Create a Database

~~~sql
CREATE DATABASE product_db;
~~~

## 2. Table Schema

```sql
USE product_db;

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price INT,
    country VARCHAR(50),
    color VARCHAR(20)
);
```

## 3. Insert Statements
```sql
INSERT INTO products (id, name, category, price, country, color)
VALUES (1, 'Product_1', 'jewelry', 492, 'CANADA', 'black');
INSERT INTO products (id, name, category, price, country, color)
VALUES (2, 'Product_2', 'cloths', 277, 'USA', 'gray');
INSERT INTO products (id, name, category, price, country, color)
VALUES (3, 'Product_3', 'jewelry', 236, 'ITALY', 'gray');
INSERT INTO products (id, name, category, price, country, color)
VALUES (4, 'Product_4', 'jewelry', 211, 'USA', 'black');
INSERT INTO products (id, name, category, price, country, color)
VALUES (5, 'Product_5', 'shoes', 179, 'MEXICO', 'blue');
INSERT INTO products (id, name, category, price, country, color)
VALUES (6, 'Product_6', 'jewelry', 211, 'ITALY', 'blue');
INSERT INTO products (id, name, category, price, country, color)
VALUES (7, 'Product_7', 'home', 428, 'ITALY', 'white');
INSERT INTO products (id, name, category, price, country, color)
VALUES (8, 'Product_8', 'cloths', 272, 'GERMANY', 'gray');
INSERT INTO products (id, name, category, price, country, color)
VALUES (9, 'Product_9', 'electronics', 468, 'GERMANY', 'black');
INSERT INTO products (id, name, category, price, country, color)
VALUES (10, 'Product_10', 'electronics', 112, 'USA', 'white');
INSERT INTO products (id, name, category, price, country, color)
VALUES (11, 'Product_11', 'shoes', 26, 'ITALY', 'black');
INSERT INTO products (id, name, category, price, country, color)
VALUES (12, 'Product_12', 'electronics', 38, 'MEXICO', 'blue');
INSERT INTO products (id, name, category, price, country, color)
VALUES (13, 'Product_13', 'electronics', 192, 'MEXICO', 'white');
INSERT INTO products (id, name, category, price, country, color)
VALUES (14, 'Product_14', 'electronics', 148, 'CANADA', 'black');
INSERT INTO products (id, name, category, price, country, color)
VALUES (15, 'Product_15', 'jewelry', 294, 'ITALY', 'black');
INSERT INTO products (id, name, category, price, country, color)
VALUES (16, 'Product_16', 'electronics', 336, 'GERMANY', 'black');
INSERT INTO products (id, name, category, price, country, color)
VALUES (17, 'Product_17', 'cloths', 176, 'MEXICO', 'gray');
INSERT INTO products (id, name, category, price, country, color)
VALUES (18, 'Product_18', 'shoes', 450, 'ITALY', 'gray');
INSERT INTO products (id, name, category, price, country, color)
VALUES (19, 'Product_19', 'shoes', 255, 'USA', 'blue');
INSERT INTO products (id, name, category, price, country, color)
VALUES (20, 'Product_20', 'cloths', 442, 'MEXICO', 'red');
INSERT INTO products (id, name, category, price, country, color)
VALUES (21, 'Product_21', 'jewelry', 179, 'GERMANY', 'white');
INSERT INTO products (id, name, category, price, country, color)
VALUES (22, 'Product_22', 'jewelry', 456, 'USA', 'blue');
INSERT INTO products (id, name, category, price, country, color)
VALUES (23, 'Product_23', 'home', 268, 'MEXICO', 'black');
INSERT INTO products (id, name, category, price, country, color)
VALUES (24, 'Product_24', 'cloths', 278, 'CANADA', 'red');
INSERT INTO products (id, name, category, price, country, color)
VALUES (25, 'Product_25', 'jewelry', 469, 'USA', 'black');
INSERT INTO products (id, name, category, price, country, color)
VALUES (26, 'Product_26', 'electronics', 71, 'GERMANY', 'red');
INSERT INTO products (id, name, category, price, country, color)
VALUES (27, 'Product_27', 'jewelry', 152, 'CANADA', 'red');
INSERT INTO products (id, name, category, price, country, color)
VALUES (28, 'Product_28', 'cloths', 276, 'ITALY', 'white');
INSERT INTO products (id, name, category, price, country, color)
VALUES (29, 'Product_29', 'home', 413, 'USA', 'red');
INSERT INTO products (id, name, category, price, country, color)
VALUES (30, 'Product_30', 'home', 378, 'GERMANY', 'gray');
INSERT INTO products (id, name, category, price, country, color)
VALUES (31, 'Product_31', 'shoes', 274, 'CANADA', 'red');
INSERT INTO products (id, name, category, price, country, color)
VALUES (32, 'Product_32', 'home', 260, 'MEXICO', 'black');
INSERT INTO products (id, name, category, price, country, color)
VALUES (33, 'Product_33', 'shoes', 333, 'GERMANY', 'blue');
INSERT INTO products (id, name, category, price, country, color)
VALUES (34, 'Product_34', 'home', 254, 'MEXICO', 'gray');
INSERT INTO products (id, name, category, price, country, color)
VALUES (35, 'Product_35', 'home', 291, 'ITALY', 'black');
INSERT INTO products (id, name, category, price, country, color)
VALUES (36, 'Product_36', 'shoes', 411, 'GERMANY', 'gray');
INSERT INTO products (id, name, category, price, country, color)
VALUES (37, 'Product_37', 'jewelry', 129, 'MEXICO', 'red');
INSERT INTO products (id, name, category, price, country, color)
VALUES (38, 'Product_38', 'jewelry', 336, 'USA', 'red');
INSERT INTO products (id, name, category, price, country, color)
VALUES (39, 'Product_39', 'electronics', 267, 'ITALY', 'blue');
INSERT INTO products (id, name, category, price, country, color)
VALUES (40, 'Product_40', 'jewelry', 178, 'ITALY', 'gray');
INSERT INTO products (id, name, category, price, country, color)
VALUES (41, 'Product_41', 'jewelry', 439, 'ITALY', 'white');
INSERT INTO products (id, name, category, price, country, color)
VALUES (42, 'Product_42', 'cloths', 60, 'ITALY', 'red');
INSERT INTO products (id, name, category, price, country, color)
VALUES (43, 'Product_43', 'cloths', 462, 'USA', 'blue');
INSERT INTO products (id, name, category, price, country, color)
VALUES (44, 'Product_44', 'cloths', 59, 'MEXICO', 'black');
INSERT INTO products (id, name, category, price, country, color)
VALUES (45, 'Product_45', 'jewelry', 331, 'ITALY', 'red');
INSERT INTO products (id, name, category, price, country, color)
VALUES (46, 'Product_46', 'jewelry', 85, 'CANADA', 'gray');
INSERT INTO products (id, name, category, price, country, color)
VALUES (47, 'Product_47', 'home', 438, 'GERMANY', 'blue');
INSERT INTO products (id, name, category, price, country, color)
VALUES (48, 'Product_48', 'electronics', 146, 'ITALY', 'gray');
INSERT INTO products (id, name, category, price, country, color)
VALUES (49, 'Product_49', 'shoes', 381, 'CANADA', 'gray');
INSERT INTO products (id, name, category, price, country, color)
VALUES (50, 'Product_50', 'electronics', 325, 'GERMANY', 'red');
INSERT INTO products (id, name, category, price, country, color)
VALUES (51, 'Product_51', 'home', 315, 'GERMANY', 'white');
INSERT INTO products (id, name, category, price, country, color)
VALUES (52, 'Product_52', 'jewelry', 160, 'USA', 'black');
INSERT INTO products (id, name, category, price, country, color)
VALUES (53, 'Product_53', 'shoes', 39, 'MEXICO', 'white');
INSERT INTO products (id, name, category, price, country, color)
VALUES (54, 'Product_54', 'electronics', 466, 'ITALY', 'gray');
INSERT INTO products (id, name, category, price, country, color)
VALUES (55, 'Product_55', 'electronics', 343, 'MEXICO', 'red');
INSERT INTO products (id, name, category, price, country, color)
VALUES (56, 'Product_56', 'home', 500, 'CANADA', 'black');
INSERT INTO products (id, name, category, price, country, color)
VALUES (57, 'Product_57', 'home', 145, 'ITALY', 'blue');
INSERT INTO products (id, name, category, price, country, color)
VALUES (58, 'Product_58', 'shoes', 386, 'USA', 'blue');
INSERT INTO products (id, name, category, price, country, color)
VALUES (59, 'Product_59', 'cloths', 163, 'ITALY', 'blue');
INSERT INTO products (id, name, category, price, country, color)
VALUES (60, 'Product_60', 'electronics', 219, 'CANADA', 'gray');
```

## 4. SQL Practice Queries

### Q1. Show all products

```sql
SELECT * 
FROM products;
```

### Q2. List product names and prices

```sql
SELECT name, price 
FROM products;
```

### Q3. Find all products from USA

```sql
SELECT * 
FROM products 
WHERE country = 'USA';
```

### Q4. Get all electronics products

```sql
SELECT * 
FROM products 
WHERE category = 'electronics';
```

### Q5. Find all products cheaper than 100

```sql
SELECT * 
FROM products 
WHERE price < 100;
```

### Q6. Count total number of products

solution-1:

```sql
SELECT COUNT(*) 
FROM products;
```

solution-2:

```sql
SELECT COUNT(*) as number_of_products
FROM products;
```


### Q7. Find unique categories

```sql
SELECT DISTINCT category 
FROM products;
```

### Q8. Find unique countries

```sql
SELECT DISTINCT country 
FROM products;
```

### Q9. Get all products ordered by price ascending

```sql
SELECT * 
FROM products 
ORDER BY price ASC;
```

### Q10. Get all products ordered by price descending

```sql
SELECT * 
FROM products 
ORDER BY price DESC;
```

### Q11. Count products per category

solution-1:

```sql
SELECT category, COUNT(*) 
FROM products 
GROUP BY category;
```

solution-2:

```sql
SELECT category, COUNT(*) AS num_of_products_per_category
FROM products 
GROUP BY category;
```


### Q12. Count products per country

solution-1:

```sql
SELECT country, COUNT(*) 
FROM products 
GROUP BY country;
```

solution-2:

```sql
SELECT country, COUNT(*) AS num_of_products_per_country
FROM products 
GROUP BY country;
```


### Q13. Average price per category

solution-1:

```sql
SELECT category, AVG(price) 
FROM products 
GROUP BY category;
```

solution-2:

```sql
SELECT category, AVG(price) as avg_price
FROM products 
GROUP BY category;
```

### Q14. Maximum price per country

solution-1:

```sql
SELECT country, MAX(price) 
FROM products 
GROUP BY country;
```

solution-2:

```sql
SELECT country, MAX(price) AS max_price
FROM products 
GROUP BY country;
```

### Q15. Minimum price per category

solution-1:

```sql
SELECT category, MIN(price) 
FROM products 
GROUP BY category;
```

solution-2:

```sql
SELECT category, MIN(price) AS min_price
FROM products 
GROUP BY category;
```

### Q16. Find red color products

```sql
SELECT * 
FROM products 
WHERE color = 'red';
```

### Q17. Find products not from USA

```sql
SELECT * 
FROM products 
WHERE country != 'USA';
```

### Q18. Find products with price between 200 and 400

solution-1:

```sql
SELECT * 
FROM products 
WHERE price BETWEEN 200 AND 400;
```

solution-2:

```sql
SELECT * 
FROM products 
WHERE (price >= 200) AND 
      (price <= 400);
```

### Q19. Find top 5 most expensive products

```sql
SELECT * 
FROM products 
ORDER BY price DESC 
LIMIT 5;
```

### Q20. Find top 5 cheapest products

```sql
SELECT * 
FROM products 
ORDER BY price ASC 
LIMIT 5;
```

### Q21. Find category with most products

```sql
SELECT category, COUNT(*) as cnt 
FROM products 
GROUP BY category 
ORDER BY cnt DESC 
LIMIT 1;
```

### Q22. Find country with least number of products

```sql
SELECT country, COUNT(*) as cnt 
FROM products 
GROUP BY country 
ORDER BY cnt ASC 
LIMIT 1;
```

### Q23. Find average price of products in USA

```sql
SELECT AVG(price) 
FROM products 
WHERE country = 'USA';
```

### Q24. Find category with highest average price

```sql
SELECT category, AVG(price) as avg_price 
FROM products 
GROUP BY category 
ORDER BY avg_price DESC 
LIMIT 1;
```

### Q25. Find category with lowest average price

```sql
SELECT category, AVG(price) as avg_price 
FROM products 
GROUP BY category 
ORDER BY avg_price ASC 
LIMIT 1;
```

### Q26. Count products by color

solution-1:

```sql
SELECT color, COUNT(*) 
FROM products 
GROUP BY color;
```

solution-2:

```sql
SELECT color, COUNT(*) AS count_by_color
FROM products 
GROUP BY color;
```


### Q27. Find the most expensive product per country

solution-1:

```sql
SELECT country, MAX(price) 
FROM products 
GROUP BY country;
```

solution-2:

```sql
SELECT country, MAX(price) AS max_price
FROM products 
GROUP BY country;
```


### Q28. Find the cheapest product per category

solution-1:

```sql
SELECT category, MIN(price) 
FROM products 
GROUP BY category;
```

solution-2:

```sql
SELECT category, MIN(price) AS min_price
FROM products 
GROUP BY category;
```


### Q29. Find products with 'Product_1' in name

```sql
SELECT * 
FROM products 
WHERE name LIKE '%Product_1%';
```

### Q30. Find products not in 'electronics' category

```sql
SELECT * 
FROM products 
WHERE category != 'electronics';
```

### Q31. Find products with price above average of all products

```sql
SELECT * 
FROM products 
WHERE price > (SELECT AVG(price) FROM products);
```

### Q32. Find categories with more than 10 products

Step-1: understand GROUP BY:

```sql
SELECT category, COUNT(*) 
FROM products 
GROUP BY category;
```

Step-2: Find categories with more than 10 products

```sql
SELECT category, COUNT(*) 
FROM products 
GROUP BY category 
HAVING COUNT(*) > 10;
```


### Q33. Find countries with fewer than 8 products

```sql
SELECT country, COUNT(*) 
FROM products 
GROUP BY country 
HAVING COUNT(*) < 8;
```

### Q34. Find average price per country and order by it

Order from 100 -> 1:

```sql
SELECT country, AVG(price) 
FROM products 
GROUP BY country 
ORDER BY AVG(price) DESC;
```

Order from 1 -> 100:

```sql
SELECT country, AVG(price) 
FROM products 
GROUP BY country 
ORDER BY AVG(price) ASC;
```

### Q35. Find all products in 'red' or 'blue'

solution-1:

```sql
SELECT * 
FROM products 
WHERE color IN ('red', 'blue');
```

solution-2:

```sql
SELECT * 
FROM products 
WHERE (color = 'red') OR (color = 'blue');
```


### Q36. Find all products not in 'USA' or 'CANADA'

```sql
SELECT * 
FROM products 
WHERE country NOT IN ('USA','CANADA');
```

### Q37. Find second most expensive product

```sql
SELECT * 
FROM products 
ORDER BY price DESC 
LIMIT 1 
OFFSET 1;
```

### Q38. Find second cheapest product

```sql
SELECT * 
FROM products 
ORDER BY price ASC 
LIMIT 1 
OFFSET 1;
```

### Q39. Find product count per (category, country)

solution-1:

```sql
SELECT category, 
       country, 
       COUNT(*) 
FROM products 
GROUP BY category, country;
```

solution-2:

```sql
SELECT category, 
       country, 
       COUNT(*) AS count_per_category_country
FROM products 
GROUP BY category, country;
```

### Q40. Find product count per (country, color)

solution-1:

```sql
SELECT country, 
       color, 
       COUNT(*) 
FROM products 
GROUP BY country, color;
```

solution-2:

```sql
SELECT country, 
       color, 
       COUNT(*) AS count_per_country_color
FROM products 
GROUP BY country, color;
```

