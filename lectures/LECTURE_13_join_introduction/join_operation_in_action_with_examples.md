# Understanding Joins

#### General JOIN

	A x B = {(a, b) / a in A & b in B}

#### INNER JOIN
		INNER JOIN → only matches (intersection).
		
		•	Definition: Returns only the rows where 
		    there is a match in both tables.
	
		•	Think of it as: “Give me only the overlap.”
	
		•	Example: If you join Employees with Departments, 
		    you only get employees that belong to a department, 
		    and departments that actually have employees.
	

#### LEFT JOIN
		LEFT JOIN → everything from left + matches.
		
		•	Definition: Returns all rows from the left table, 
		    and the matching rows from the right table. If 
		    no match is found, the right side will show NULLs.
		    
		•	Think of it as: “Give me everything from the left, 
		    and fill what you can from the right.”

		•	Example: List all employees, even if some don’t 
			belong to a department. Those employees will have 
			NULL in the department columns.


#### RIGHT JOIN
		•	RIGHT JOIN → everything from right + matches.
	
		•	Definition: Returns all rows from the right table, 
		    and the matching rows from the left table. If no match 
		    is found, the left side will show NULLs.
		    
		•	Think of it as: “Give me everything from the right, 
		    and fill what you can from the left.”
	
		•	Example: List all departments, even if some don’t have 
			employees. Those empty departments will have NULL in 
			the employee columns.
		
		
------

## Table `table_A`

~~~sql
CREATE TABLE table_A (
    id    INT,
    name  varchar(3)
);

insert into table_A(id, name)
values
(1, 'a'),
(2, 'b'),
(3, 'c'),
(4, 'd');

mysql> select * from table_A;
+------+------+
| id   | name |
+------+------+
|    1 | a    |
|    2 | b    |
|    3 | c    |
|    4 | d    |
+------+------+
4 rows in set (0.00 sec)
~~~

-----

## Table `table_B`

~~~sql
CREATE TABLE table_B (
    id    INT,
    name  varchar(3)
);

insert into table_B(id, name)
values
(1, 'e'),
(2, 'f'),
(7, 'g'),
(8, 'h'),
(9, 'i');

mysql> select * from table_B;
+------+------+
| id   | name |
+------+------+
|    1 | e    |
|    2 | f    |
|    7 | g    |
|    8 | h    |
|    9 | i    |
+------+------+
5 rows in set (0.00 sec)
~~~

------

## General JOIN

~~~sql
-- ----------------------------
-- JOIN of table_A and table_B
-- ----------------------------
SELECT A.id as id_A,
       A.name as name_A,
       B.id as id_B,
       B.name as name_B
FROM table_A as A,
     table_B as B;

+------+--------+------+--------+
| id_A | name_A | id_B | name_B |
+------+--------+------+--------+
|    4 | d      |    1 | e      |
|    3 | c      |    1 | e      |
|    2 | b      |    1 | e      |
|    1 | a      |    1 | e      |
|    4 | d      |    2 | f      |
|    3 | c      |    2 | f      |
|    2 | b      |    2 | f      |
|    1 | a      |    2 | f      |
|    4 | d      |    7 | g      |
|    3 | c      |    7 | g      |
|    2 | b      |    7 | g      |
|    1 | a      |    7 | g      |
|    4 | d      |    8 | h      |
|    3 | c      |    8 | h      |
|    2 | b      |    8 | h      |
|    1 | a      |    8 | h      |
|    4 | d      |    9 | i      |
|    3 | c      |    9 | i      |
|    2 | b      |    9 | i      |
|    1 | a      |    9 | i      |
+------+--------+------+--------+
20 rows in set (0.00 sec)
~~~

------

## General JOIN (ORDER BY id)

~~~sql
-- ----------------------------
-- JOIN of table_A and table_B
-- ----------------------------
SELECT A.id as id_A,
       A.name as name_A,
       B.id as id_B,
       B.name as name_B
FROM table_A as A,
     table_B as B
ORDER BY A.id, B.id;

+------+--------+------+--------+
| id_A | name_A | id_B | name_B |
+------+--------+------+--------+
|    1 | a      |    1 | e      |
|    1 | a      |    2 | f      |
|    1 | a      |    7 | g      |
|    1 | a      |    8 | h      |
|    1 | a      |    9 | i      |
|    2 | b      |    1 | e      |
|    2 | b      |    2 | f      |
|    2 | b      |    7 | g      |
|    2 | b      |    8 | h      |
|    2 | b      |    9 | i      |
|    3 | c      |    1 | e      |
|    3 | c      |    2 | f      |
|    3 | c      |    7 | g      |
|    3 | c      |    8 | h      |
|    3 | c      |    9 | i      |
|    4 | d      |    1 | e      |
|    4 | d      |    2 | f      |
|    4 | d      |    7 | g      |
|    4 | d      |    8 | h      |
|    4 | d      |    9 | i      |
+------+--------+------+--------+
20 rows in set (0.00 sec)
~~~

------

## INNER JOIN (common/matching keys)

~~~sql
-- ----------------------------------
-- INNER JOIN of table_A and table_B
-- ----------------------------------
SELECT A.id as id_A,
       A.name as name_A,
       B.id as id_B,
       B.name as name_B
FROM table_A as A,
     table_B as B
WHERE A.id = B.id
ORDER BY A.id, B.id;

+------+--------+------+--------+
| id_A | name_A | id_B | name_B |
+------+--------+------+--------+
|    1 | a      |    1 | e      |
|    2 | b      |    2 | f      |
+------+--------+------+--------+
2 rows in set (0.00 sec)
~~~

-------

## LEFT JOIN

~~~sql
-- ----------------------------
-- LEFT JOIN of table_A and table_B
-- ----------------------------
SELECT A.id as id_A,
       A.name as name_A,
       B.id as id_B,
       B.name as name_B
FROM table_A  A
LEFT JOIN table_B  B ON A.id = B.id 
ORDER BY A.id, B.id;

+------+--------+------+--------+
| id_A | name_A | id_B | name_B |
+------+--------+------+--------+
|    1 | a      |    1 | e      |
|    2 | b      |    2 | f      |
|    3 | c      | NULL | NULL   |
|    4 | d      | NULL | NULL   |
+------+--------+------+--------+
4 rows in set (0.00 sec)
~~~

-------

## Find id's in A, which are not in B (version 1)

~~~sql
-- ----------------------------
-- LEFT JOIN of table_A and table_B
-- ----------------------------
SELECT A.id as id_A,
       A.name as name_A,
       B.id as id_B,
       B.name as name_B
FROM table_A  A
LEFT JOIN table_B  B ON A.id = B.id 
WHERE B.id is NULL
ORDER BY A.id, B.id;

+------+--------+------+--------+
| id_A | name_A | id_B | name_B |
+------+--------+------+--------+
|    3 | c      | NULL | NULL   |
|    4 | d      | NULL | NULL   |
+------+--------+------+--------+
2 rows in set (0.00 sec)
~~~

-------

## Find id's in A, which are not in B (version 2)

~~~sql
-- ----------------------------
-- LEFT JOIN of table_A and table_B
-- ----------------------------
SELECT A.id as id_A,
       A.name as name_A
FROM table_A  A
LEFT JOIN table_B  B ON A.id = B.id 
WHERE B.id is NULL
ORDER BY A.id;

+------+--------+
| id_A | name_A |
+------+--------+
|    3 | c      |
|    4 | d      |
+------+--------+
2 rows in set (0.00 sec)
~~~

---------

## RIGHT JOIN (`table_A RIGHT JOIN table_B`)

~~~sql
-- ----------------------------
--  table_A RIGHT JOIN table_B
-- ----------------------------
SELECT A.id as id_A,
       A.name as name_A,
       B.id as id_B,
       B.name as name_B
FROM table_A  A
RIGHT JOIN table_B  B ON A.id = B.id 
ORDER BY A.id, B.id;

+------+--------+------+--------+
| id_A | name_A | id_B | name_B |
+------+--------+------+--------+
| NULL | NULL   |    7 | g      |
| NULL | NULL   |    8 | h      |
| NULL | NULL   |    9 | i      |
|    1 | a      |    1 | e      |
|    2 | b      |    2 | f      |
+------+--------+------+--------+
5 rows in set (0.00 sec)
~~~

------

## Find id's in B, which are not in A (version 1)

~~~sql
SELECT A.id as id_A,
       A.name as name_A,
       B.id as id_B,
       B.name as name_B
FROM table_A  A
RIGHT JOIN table_B  B ON A.id = B.id 
WHERE A.id is NULL
ORDER BY A.id, B.id;

+------+--------+------+--------+
| id_A | name_A | id_B | name_B |
+------+--------+------+--------+
| NULL | NULL   |    7 | g      |
| NULL | NULL   |    8 | h      |
| NULL | NULL   |    9 | i      |
+------+--------+------+--------+
3 rows in set (0.00 sec)
~~~

-------

## Find id's in B, which are not in A (version 2)

~~~sql
SELECT B.id as id_B,
       B.name as name_B
FROM table_A  A
RIGHT JOIN table_B  B ON A.id = B.id 
WHERE A.id is NULL
ORDER BY  B.id;

+------+--------+
| id_B | name_B |
+------+--------+
|    7 | g      |
|    8 | h      |
|    9 | i      |
+------+--------+
3 rows in set (0.00 sec)
~~~