# JOIN operation

	A JOIN operation combines rows from 
	two or more tables based on a related 
	column between them, using syntax like 
	
	   SELECT ... 
	   FROM table1 
	   JOIN table2 ON table1.column = table2.column;
	
	where column is a common attribute 
	in both table1 and table2.
	
department_id is FK to 
	
	employees (emp_id, name, age, dept_id)
	              PK                 FK to departments.dept_id
	
	departments(dept_id, dept_name, location)
	               PK
	
	SELECT e.emp_id, 
	       e.department_id,
	       d.dept_name, 
	       d.location
	       
	FROM employees e
	INNER JOIN departments d
	    ON e.dept_id = d.dept_id AND
	       e.emp_id < 5000;
	    
	
## Common Join types include 

* INNER JOIN (only matching rows)

* LEFT JOIN (all left table rows + matches from right)

* RIGHT JOIN (all right table rows + matches from left)

* FULL OUTER JOIN (all rows from both)

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

CREATE TABLE A (
   the_key INT, 
   value1 CHAR(1)
);

CREATE TABLE B (
   the_key INT, 
   value2 CHAR(1)
);

+-------------------------+
| Tables_in_join_tutorial |
+-------------------------+
| A                       |
| B                       |
+-------------------------+
2 rows in set (0.001 sec)

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


INSERT INTO A(the_key, value1)
VALUES
(1, 'a'),
(1, 'b'),
(2, 'c'),
(2, 'd'),
(3, 'z'),
(5, 'g'),
(5, 'r');

mysql> select * from A;
+---------+--------+
| the_key | value1 |
+---------+--------+
|       1 | a      |
|       1 | b      |
|       2 | c      |
|       2 | d      |
|       3 | z      |
|       5 | g      |
|       5 | r      |
+---------+--------+
7 rows in set (0.000 sec)

INSERT INTO B(the_key, value2)
VALUES
(1, 'x'),
(1, 'y'),
(2, 'e'),
(2, 'f'),
(2, 'm'),
(6, 'k'),
(8, 'a');

mysql> select * from B;
+---------+--------+
| the_key | value2 |
+---------+--------+
|       1 | x      |
|       1 | y      |
|       2 | e      |
|       2 | f      |
|       2 | m      |
|       6 | k      |
|       8 | a      |
+---------+--------+
7 rows in set (0.000 sec)

    Table A     Table B
    ----------  ------------
  the_key Value1 the_key Value2
    ----------  ------------
    1   a       1     x
    1   b       1     y
    2   c       2     e
    2   d       2     f
    3   z       2     m
    5   g       6     k
    5   r       8     a
    
	SELECT A.the_key,
	       A.value1,
	       B.the_key,
	       B.value2 	       
	FROM A
	INNER JOIN B 
	    ON A.the_key = B.the_key;

+---------+--------+---------+--------+
| the_key | value1 | the_key | value2 |
+---------+--------+---------+--------+
|       1 | b      |       1 | x      |
|       1 | a      |       1 | x      |
|       1 | b      |       1 | y      |
|       1 | a      |       1 | y      |
|       2 | d      |       2 | e      |
|       2 | c      |       2 | e      |
|       2 | d      |       2 | f      |
|       2 | c      |       2 | f      |
|       2 | d      |       2 | m      |
|       2 | c      |       2 | m      |
+---------+--------+---------+--------+
10 rows in set (0.000 sec)
    
    INNER JOIN ON A.Key = B.Key
    -----------
    1  a   1  x
    1  a   1  y
    1  b   1  x
    1  b   1  y
    2  c   2  e
    2  c   2  f
    2  c   2  m
    2  d   2  e
    2  d   2  f
    2  d   2  m
    
    
------
       
## LEFT JOIN (or LEFT OUTER JOIN): 

	Returns all rows from the left table, 
	and the matched rows from the right table. 
	If there is no match, the result is NULL 
	for the right table's columns.

![](./JOIN_LEFT.png)

    Table A     Table B
    ----------  ------------
    Key Value1  Key   Value2
    ----------  ------------
    1   a       1     x
    1   b       1     y
    2   c       2     e
    2   d       2     f
    3   z       2     m
    5   g       6     k
    5   r       8     a
    
	SELECT A.the_key,
	       A.value1,
	       B.the_key,
	       B.value2 	       
	FROM A
	LEFT JOIN B 
	    ON A.the_key = B.the_key;
    
    LEFT JOIN ON A.Key = B.Key
    -----------
    1  a   x
    1  a   y
    1  b   x
    1  b   y
    2  c   e
    2  c   f
    2  c   m
    2  d   e
    2  d   f
    2  d   m
    3  z   NULL
    5  g   NULL
    5  r   NULL   
    
+---------+--------+---------+--------+
| the_key | value1 | the_key | value2 |
+---------+--------+---------+--------+
|       1 | a      |       1 | y      |
|       1 | a      |       1 | x      |
|       1 | b      |       1 | y      |
|       1 | b      |       1 | x      |
|       2 | c      |       2 | m      |
|       2 | c      |       2 | f      |
|       2 | c      |       2 | e      |
|       2 | d      |       2 | m      |
|       2 | d      |       2 | f      |
|       2 | d      |       2 | e      |
|       3 | z      |    NULL | NULL   |
|       5 | g      |    NULL | NULL   |
|       5 | r      |    NULL | NULL   |
+---------+--------+---------+--------+
13 rows in set (0.000 sec)
------
	
## RIGHT JOIN (or RIGHT OUTER JOIN): 

	Returns all rows from the right table, 
	and the matched rows from the left table. 
	If there is no match, the result is NULL 
	for the left table's columns.

![](./JOIN_RIGHT.png)

    Table A     Table B
    ----------  ------------
    Key Value1  Key   Value2
    ----------  ------------
    1   a       1     x
    1   b       1     y
    2   c       2     e
    2   d       2     f
    3   z       2     m
    5   g       6     k
    5   r       8     a
    
	SELECT A.the_key,
	       A.value1,
	       B.the_key,
	       B.value2 	       
	FROM A
	RIGHT JOIN B 
	    ON A.the_key = B.the_key;
    
    RIGHT JOIN ON A.Key = B.Key
    -----------
    1  a   x
    1  a   y
    1  b   x
    1  b   y
    2  c   e
    2  c   f
    2  c   m
    2  d   e
    2  d   f
    2  d   m
    6  k   NULL
    8  a   NULL
       
+---------+--------+---------+--------+
| the_key | value1 | the_key | value2 |
+---------+--------+---------+--------+
|       1 | b      |       1 | x      |
|       1 | a      |       1 | x      |
|       1 | b      |       1 | y      |
|       1 | a      |       1 | y      |
|       2 | d      |       2 | e      |
|       2 | c      |       2 | e      |
|       2 | d      |       2 | f      |
|       2 | c      |       2 | f      |
|       2 | d      |       2 | m      |
|       2 | c      |       2 | m      |
|    NULL | NULL   |       6 | k      |
|    NULL | NULL   |       8 | a      |
+---------+--------+---------+--------+
12 rows in set (0.001 sec)   


------

## FULL OUTER JOIN: 

	Returns all rows when there is a match 
	in either the left or right table. It 
	returns NULL for columns of the table 
	that doesn't have a match.

![](./JOIN_FULL.png)

------

## CROSS JOIN: 

	Returns the Cartesian product of both 
	tables, combining every row from the 
	first table with every row from the 
	second table. 

![](./JOIN_CROSS.webp)

------


## References

[1.The Join Operation](https://www.faastop.com/dbms/30.Join_Operator.html)

