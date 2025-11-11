# JOIN operation

	A JOIN operation combines rows from 
	two or more tables based on a related 
	column between them, using syntax like 
	
	   SELECT ... 
	   FROM table1 
	   JOIN table2 ON table1.column = table2.column;
	
	where column is a common attribute in 
	both table1 and table2.
	
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

------
       
## LEFT JOIN (or LEFT OUTER JOIN): 

	Returns all rows from the left table, 
	and the matched rows from the right table. 
	If there is no match, the result is NULL 
	for the right table's columns.

![](./JOIN_LEFT.png)

------
	
## RIGHT JOIN (or RIGHT OUTER JOIN): 

	Returns all rows from the right table, 
	and the matched rows from the left table. 
	If there is no match, the result is NULL 
	for the left table's columns.

![](./JOIN_RIGHT.png)

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

