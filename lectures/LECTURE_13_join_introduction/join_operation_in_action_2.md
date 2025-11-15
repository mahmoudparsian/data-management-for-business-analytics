# JOIN operation in Action

	A JOIN operation combines rows from 
	two or more tables based on a related 
	column between them, using syntax like 
	
	   SELECT ... 
	   FROM table1 
	   JOIN table2 ON table1.column = table2.column;
	
	where column is a common attribute 
	in both table1 and table2.

	
## Common Join types include 

#### `INNER JOIN` (only matching rows)

#### `LEFT JOIN` (all left table rows + matches from right)

#### `RIGHT JOIN` (all right table rows + matches from left)

#### `FULL OUTER JOIN` (all rows from both)

	✅ All rows from the left table
	 + All rows from the right table
	 + Matches where they exist
	 + NULLs where there is no match


## Key concepts

	1. Related Columns: 
	
		Joins require a common column between 
		tables, such as a primary key (PK) in 
		one table and a foreign key  (FK)  in 
		another, to establish a logical connection.
		
	2. Join Condition: 
	
		This is the rule that determines how rows 
		are matched, usually an equality test in 
		the ON clause. The column names don't have 
		to be the same, but their data types must 
		be compatible.


## INNER JOIN: 

	Returns only the rows where there is a match 
	in both tables based on the join condition.
	
	Example: 
	         SELECT o.order_id, 
	                c.customer_name 
	         FROM orders o
	         INNER JOIN customers c 
	              ON o.customer_id = c.customer_id;

![](./JOIN_INNER.png)

## A Complete Example

```sql
use join_tutorial;

mysql> show tables;
+-------------------------+
| Tables_in_join_tutorial |
+-------------------------+
| Departments             |
| Employees               |
+-------------------------+
2 rows in set (0.002 sec)

CREATE TABLE A (
   the_key INT, 
   value1 CHAR(1)
);

CREATE TABLE B (
   the_key INT, 
   value2 CHAR(1)
);

mysql> show tables;
+-------------------------+
| Tables_in_join_tutorial |
+-------------------------+
| A                       |
| B                       |
| Departments             |
| Employees               |
+-------------------------+
4 rows in set (0.002 sec)

mysql> desc A;
+---------+---------+------+-----+---------+-------+
| Field   | Type    | Null | Key | Default | Extra |
+---------+---------+------+-----+---------+-------+
| the_key | int     | YES  |     | NULL    |       |
| value1  | char(1) | YES  |     | NULL    |       |
+---------+---------+------+-----+---------+-------+
2 rows in set (0.003 sec)

mysql> desc B;
+---------+---------+------+-----+---------+-------+
| Field   | Type    | Null | Key | Default | Extra |
+---------+---------+------+-----+---------+-------+
| the_key | int     | YES  |     | NULL    |       |
| value2  | char(1) | YES  |     | NULL    |       |
+---------+---------+------+-----+---------+-------+
2 rows in set (0.002 sec)
```

### Populate Tables A and B

```sql
INSERT INTO A(the_key, value1)
VALUES
(1, 'a'),
(1, 'b'),
(1, 'c'),
(2, 'd'),
(2, 'e'),
(3, 'f'),
(5, 'g'),
(5, 'h');

mysql> SELECT * FROM A;
+---------+--------+
| the_key | value1 |
+---------+--------+
|       1 | a      |
|       1 | b      |
|       1 | c      |
|       2 | d      |
|       2 | e      |
|       3 | f      |
|       5 | g      |
|       5 | h      |
+---------+--------+
8 rows in set (0.001 sec)

INSERT INTO B(the_key, value2)
VALUES
(1, 'p'),
(1, 'q'),
(2, 'r'),
(2, 's'),
(2, 't'),
(3, 'u'),
(6, 'v'),
(7, 'w'),
(8, 'x'),
(9, 'y');

mysql> select * from B;
+---------+--------+
| the_key | value2 |
+---------+--------+
|       1 | p      |
|       1 | q      |
|       2 | r      |
|       2 | s      |
|       2 | t      |
|       3 | u      |
|       6 | v      |
|       7 | w      |
|       8 | x      |
|       9 | y      |
+---------+--------+
10 rows in set (0.001 sec)

```

### INNER JOIN

```sql   
	SELECT A.the_key AS a_key,
	       A.value1  AS a_value,
	       B.the_key AS b_key,
	       B.value2  AS b_value    
	FROM A
	INNER JOIN B 
	    ON A.the_key = B.the_key
	ORDER BY 
	         a_key,
	         a_value,
	         b_key,
	         b_value; 

+-------+---------+-------+---------+
| a_key | a_value | b_key | b_value |
+-------+---------+-------+---------+
|     1 | a       |     1 | p       |
|     1 | a       |     1 | q       |
|     1 | b       |     1 | p       |
|     1 | b       |     1 | q       |
|     1 | c       |     1 | p       |
|     1 | c       |     1 | q       |
|     2 | d       |     2 | r       |
|     2 | d       |     2 | s       |
|     2 | d       |     2 | t       |
|     2 | e       |     2 | r       |
|     2 | e       |     2 | s       |
|     2 | e       |     2 | t       |
|     3 | f       |     3 | u       |
+-------+---------+-------+---------+
13 rows in set (0.001 sec)
```   
    
------
       
## LEFT JOIN (or LEFT OUTER JOIN): 

	Returns all rows from the left table, 
	and the matched rows from the right table. 
	If there is no match, the result is NULL 
	for the right table's columns.

![](./JOIN_LEFT.png)

```sql
	SELECT A.the_key AS a_key,
	       A.value1  AS a_value,
	       B.the_key AS b_key,
	       B.value2  AS b_value    
	FROM A
	LEFT JOIN B 
	    ON A.the_key = B.the_key
	ORDER BY 
	         a_key,
	         a_value,
	         b_key,
	         b_value; 
+-------+---------+-------+---------+
| a_key | a_value | b_key | b_value |
+-------+---------+-------+---------+
|     1 | a       |     1 | p       |
|     1 | a       |     1 | q       |
|     1 | b       |     1 | p       |
|     1 | b       |     1 | q       |
|     1 | c       |     1 | p       |
|     1 | c       |     1 | q       |
|     2 | d       |     2 | r       |
|     2 | d       |     2 | s       |
|     2 | d       |     2 | t       |
|     2 | e       |     2 | r       |
|     2 | e       |     2 | s       |
|     2 | e       |     2 | t       |
|     3 | f       |     3 | u       |
|     5 | g       |  NULL | NULL    |
|     5 | h       |  NULL | NULL    |
+-------+---------+-------+---------+
15 rows in set (0.001 sec)
```
------
	
## RIGHT JOIN (or RIGHT OUTER JOIN): 

	Returns all rows from the right table, 
	and the matched rows from the left table. 
	If there is no match, the result is NULL 
	for the left table's columns.

![](./JOIN_RIGHT.png)

```sql

	SELECT A.the_key AS a_key,
	       A.value1  AS a_value,
	       B.the_key AS b_key,
	       B.value2  AS b_value    
	FROM A
	RIGHT JOIN B 
	    ON A.the_key = B.the_key
	ORDER BY 
	         a_key,
	         a_value,
	         b_key,
	         b_value; 
+-------+---------+-------+---------+
| a_key | a_value | b_key | b_value |
+-------+---------+-------+---------+
|  NULL | NULL    |     6 | v       |
|  NULL | NULL    |     7 | w       |
|  NULL | NULL    |     8 | x       |
|  NULL | NULL    |     9 | y       |
|     1 | a       |     1 | p       |
|     1 | a       |     1 | q       |
|     1 | b       |     1 | p       |
|     1 | b       |     1 | q       |
|     1 | c       |     1 | p       |
|     1 | c       |     1 | q       |
|     2 | d       |     2 | r       |
|     2 | d       |     2 | s       |
|     2 | d       |     2 | t       |
|     2 | e       |     2 | r       |
|     2 | e       |     2 | s       |
|     2 | e       |     2 | t       |
|     3 | f       |     3 | u       |
+-------+---------+-------+---------+
17 rows in set (0.003 sec)
```

------

## FULL OUTER JOIN: 

	Returns all rows when there is a match 
	in either the left or right table. It 
	returns NULL for columns of the table 
	that doesn't have a match.

![](./JOIN_FULL.png)


### ✅ `FULL OUTER JOIN` (Not supported natively in MySQL, but can be emulated)

```sql
	SELECT A.the_key AS a_key,
	       A.value1  AS a_value,
	       B.the_key AS b_key,
	       B.value2  AS b_value    
	FROM A
	LEFT JOIN B 
	    ON A.the_key = B.the_key
	    
	UNION

	SELECT A.the_key AS a_key,
	       A.value1  AS a_value,
	       B.the_key AS b_key,
	       B.value2  AS b_value    
	FROM A
	RIGHT JOIN B 
	    ON A.the_key = B.the_key
	    	    
	ORDER BY 
	         a_key,
	         a_value,
	         b_key,
	         b_value; 

+-------+---------+-------+---------+
| a_key | a_value | b_key | b_value |
+-------+---------+-------+---------+
|  NULL | NULL    |     6 | v       |
|  NULL | NULL    |     7 | w       |
|  NULL | NULL    |     8 | x       |
|  NULL | NULL    |     9 | y       |
|     1 | a       |     1 | p       |
|     1 | a       |     1 | q       |
|     1 | b       |     1 | p       |
|     1 | b       |     1 | q       |
|     1 | c       |     1 | p       |
|     1 | c       |     1 | q       |
|     2 | d       |     2 | r       |
|     2 | d       |     2 | s       |
|     2 | d       |     2 | t       |
|     2 | e       |     2 | r       |
|     2 | e       |     2 | s       |
|     2 | e       |     2 | t       |
|     3 | f       |     3 | u       |
|     5 | g       |  NULL | NULL    |
|     5 | h       |  NULL | NULL    |
+-------+---------+-------+---------+
19 rows in set (0.001 sec)

```


------

## CROSS JOIN: 

	Returns the Cartesian product of both 
	tables, combining every row from the 
	first table with every row from the 
	second table. 

![](./JOIN_CROSS.webp)

```sql
	SELECT A.the_key AS a_key,
	       A.value1  AS a_value,
	       B.the_key AS b_key,
	       B.value2  AS b_value    
	FROM A,
	     B;

+-------+---------+-------+---------+
| a_key | a_value | b_key | b_value |
+-------+---------+-------+---------+
|     5 | h       |     1 | p       |
|     5 | g       |     1 | p       |
|     3 | f       |     1 | p       |
|     2 | e       |     1 | p       |
|     2 | d       |     1 | p       |
|     1 | c       |     1 | p       |
|     1 | b       |     1 | p       |
|     1 | a       |     1 | p       |
|     5 | h       |     1 | q       |
|     5 | g       |     1 | q       |
|     3 | f       |     1 | q       |
|     2 | e       |     1 | q       |
|     2 | d       |     1 | q       |
|     1 | c       |     1 | q       |
|     1 | b       |     1 | q       |
|     1 | a       |     1 | q       |
|     5 | h       |     2 | r       |
|     5 | g       |     2 | r       |
|     3 | f       |     2 | r       |
|     2 | e       |     2 | r       |
|     2 | d       |     2 | r       |
|     1 | c       |     2 | r       |
|     1 | b       |     2 | r       |
|     1 | a       |     2 | r       |
|     5 | h       |     2 | s       |
|     5 | g       |     2 | s       |
|     3 | f       |     2 | s       |
|     2 | e       |     2 | s       |
|     2 | d       |     2 | s       |
|     1 | c       |     2 | s       |
|     1 | b       |     2 | s       |
|     1 | a       |     2 | s       |
|     5 | h       |     2 | t       |
|     5 | g       |     2 | t       |
|     3 | f       |     2 | t       |
|     2 | e       |     2 | t       |
|     2 | d       |     2 | t       |
|     1 | c       |     2 | t       |
|     1 | b       |     2 | t       |
|     1 | a       |     2 | t       |
|     5 | h       |     3 | u       |
|     5 | g       |     3 | u       |
|     3 | f       |     3 | u       |
|     2 | e       |     3 | u       |
|     2 | d       |     3 | u       |
|     1 | c       |     3 | u       |
|     1 | b       |     3 | u       |
|     1 | a       |     3 | u       |
|     5 | h       |     6 | v       |
|     5 | g       |     6 | v       |
|     3 | f       |     6 | v       |
|     2 | e       |     6 | v       |
|     2 | d       |     6 | v       |
|     1 | c       |     6 | v       |
|     1 | b       |     6 | v       |
|     1 | a       |     6 | v       |
|     5 | h       |     7 | w       |
|     5 | g       |     7 | w       |
|     3 | f       |     7 | w       |
|     2 | e       |     7 | w       |
|     2 | d       |     7 | w       |
|     1 | c       |     7 | w       |
|     1 | b       |     7 | w       |
|     1 | a       |     7 | w       |
|     5 | h       |     8 | x       |
|     5 | g       |     8 | x       |
|     3 | f       |     8 | x       |
|     2 | e       |     8 | x       |
|     2 | d       |     8 | x       |
|     1 | c       |     8 | x       |
|     1 | b       |     8 | x       |
|     1 | a       |     8 | x       |
|     5 | h       |     9 | y       |
|     5 | g       |     9 | y       |
|     3 | f       |     9 | y       |
|     2 | e       |     9 | y       |
|     2 | d       |     9 | y       |
|     1 | c       |     9 | y       |
|     1 | b       |     9 | y       |
|     1 | a       |     9 | y       |
+-------+---------+-------+---------+
80 rows in set (0.001 sec)
```
------


## References

[1.The Join Operation](https://www.faastop.com/dbms/30.Join_Operator.html)

