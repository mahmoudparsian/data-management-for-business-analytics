# SQL Aggregate Functions

	Create a simple but effective schema in mysql 
	for each aggregate function provide a solid 
	example with output

	👍 — here’s the same content reformatted into a 
	Markdown slide deck.

⸻

## SQL Aggregate Functions (MySQL Examples)

* AVG, 
* MIN, 
* MAX, 
* SUM, 
* COUNT

⸻

# Slide 1: Schema and Sample Data

~~~sql
CREATE TABLE sales (
  id INT,
  product VARCHAR(20),
  amount DECIMAL(10, 2)
);

INSERT INTO sales VALUES
(1, 'Book', 50.00),
(2, 'Pen', 5.00),
(3, 'Book', 30.00),
(4, 'Bag', 70.00),
(5, 'Pen', 8.00),
(6, 'Book', NULL);
~~~

📊 sales table

~~~
mysql> select * from sales;
+------+---------+--------+
| id   | product | amount |
+------+---------+--------+
|    1 | Book    |  50.00 |
|    2 | Pen     |   5.00 |
|    3 | Book    |  30.00 |
|    4 | Bag     |  70.00 |
|    5 | Pen     |   8.00 |
|    6 | Book    |   NULL |
+------+---------+--------+
6 rows in set (0.001 sec)
~~~

⸻

## Slide 2: AVG, MIN, MAX

* -- Average

~~~sql
mysql> SELECT AVG(amount)
    -> FROM sales;
+-------------+
| AVG(amount) |
+-------------+
|   32.600000 |
+-------------+
1 row in set (0.001 sec)

mysql> select (50.00+5.00+30.00+70.00+8.00)/5.0;
+-----------------------------------+
| (50.00+5.00+30.00+70.00+8.00)/5.0 |
+-----------------------------------+
|                         32.600000 |
+-----------------------------------+
1 row in set (0.000 sec)

(NULL ignored)
~~~

* -- Minimum

~~~sql
SELECT MIN(amount) 
FROM sales;

→ 5.00
~~~

* -- Maximum

~~~sql
SELECT MAX(amount) FROM sales;
→ 70.00
~~~

⸻

# Slide 3: SUM and COUNT

* -- Total sum

~~~sql
SELECT SUM(amount) 
FROM sales;

→ 163.00
~~~

* -- Count all rows

~~~sql
SELECT COUNT(*) 
FROM sales;

→ 6
~~~

* -- Count non-NULL values


~~~sql
SELECT COUNT(amount) 
FROM sales;

→ 5
~~~

⸻

# Slide 4: Aggregates with GROUP BY

~~~sql
SELECT product,
       COUNT(amount) AS num_sales,
       AVG(amount)   AS avg_amount,
       SUM(amount)   AS total_amount
FROM sales
GROUP BY product;
~~~

✅ Results:

```sql
mysql> SELECT product,
    ->        COUNT(amount) AS num_sales,
    ->        AVG(amount)   AS avg_amount,
    ->        SUM(amount)   AS total_amount
    -> FROM sales
    -> GROUP BY product;
+---------+-----------+------------+--------------+
| product | num_sales | avg_amount | total_amount |
+---------+-----------+------------+--------------+
| Book    |         2 |  40.000000 |        80.00 |
| Pen     |         2 |   6.500000 |        13.00 |
| Bag     |         1 |  70.000000 |        70.00 |
+---------+-----------+------------+--------------+
3 rows in set (0.001 sec)
```

⸻


# Slide 5: How NULL Affects Aggregates

    •    NULL values are ignored in most aggregates 
        (AVG, SUM, MIN, MAX, COUNT(column)).
        
    •    But COUNT(*) counts all rows, including 
         those with NULL.

* 📊 Example

~~~sql
SELECT COUNT(*) AS total_rows,
       COUNT(amount) AS non_null_rows,
       SUM(amount) AS total_amount,
       AVG(amount) AS avg_amount
FROM sales;
~~~

✅ Output:

~~~
mysql> SELECT COUNT(*) AS total_rows,
    ->        COUNT(amount) AS non_null_rows,
    ->        SUM(amount) AS total_amount,
    ->        AVG(amount) AS avg_amount
    -> FROM sales;
+------------+---------------+--------------+------------+
| total_rows | non_null_rows | total_amount | avg_amount |
+------------+---------------+--------------+------------+
|          6 |             5 |       163.00 |  32.600000 |
+------------+---------------+--------------+------------+
1 row in set (0.001 sec)
~~~

👉 Notice:

    •    Row with NULL counted in COUNT(*), 
         but ignored in others.

⸻


## 🎓 Aggregate Functions with HAVING

🔹 Key Idea

    •    WHERE → filters before grouping
    
    •    HAVING → filters after grouping 
         (on aggregate results)

⸻

## Example Schema

~~~sql
CREATE TABLE sales (
    id INT,
    product VARCHAR(20),
    amount DECIMAL(10,2)
);

INSERT INTO sales VALUES
(1, 'Book', 50.00),
(2, 'Pen', 5.00),
(3, 'Book', 30.00),
(4, 'Bag', 70.00),
(5, 'Pen', 8.00),
(6, 'Book', 20.00);
~~~

📊 sales table

~~~
id    product    amount
1     Book       50.00
2     Pen         5.00
3     Book       30.00
4     Bag        70.00
5     Pen         8.00
6     Book       20.00
~~~

⸻

## Example 1: Total Sales per Product

~~~sql
SELECT product,
       SUM(amount) AS total_sales
FROM sales
GROUP BY product;
~~~

✅ Output:

~~~
product    total_sales
Book       100.00
Pen         13.00
Bag         70.00
~~~

⸻

## Example 2: Using HAVING

👉 Find products with total sales greater than 50.

~~~sql
SELECT product,
       SUM(amount) AS total_sales
FROM sales
GROUP BY product
HAVING SUM(amount) > 50;
~~~

✅ Output:

~~~
+---------+-------------+
| product | total_sales |
+---------+-------------+
| Book    |       80.00 |
| Bag     |       70.00 |
+---------+-------------+
2 rows in set (0.001 sec)
~~~

⸻

## Example 3: Combining WHERE + HAVING

👉 Filter rows before grouping and then after grouping.

	-- Consider only sales > 10 (WHERE)
	-- Then find products with avg sale > 30 (HAVING)

~~~sql
SELECT product,
       AVG(amount) AS avg_amount
FROM sales
WHERE amount > 10
GROUP BY product
HAVING AVG(amount) > 30;
~~~

✅ Output:

~~~
+---------+------------+
| product | avg_amount |
+---------+------------+
| Book    |  40.000000 |
| Bag     |  70.000000 |
+---------+------------+
2 rows in set (0.001 sec)
~~~

Re-write SQL Query:

~~~sql
SELECT product,
       AVG(amount) AS avg_amount
FROM sales
WHERE amount > 10
GROUP BY product
HAVING avg_amount > 30;

+---------+------------+
| product | avg_amount |
+---------+------------+
| Book    |  40.000000 |
| Bag     |  70.000000 |
+---------+------------+
2 rows in set (0.001 sec)
~~~

⸻

