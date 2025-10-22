# MySQL INTERSECT

	INTERSECT limits the result from multiple query 
	blocks to those rows which are common to all. 

## Example 1

Table a:

~~~mysql
mysql> TABLE a;
+------+------+
| m    | n    |
+------+------+
|    1 |    2 |
|    2 |    3 |
|    3 |    4 |
+------+------+
3 rows in set (0.00 sec)
~~~

Table b:

~~~mysql
mysql> TABLE b;
+------+------+
| m    | n    |
+------+------+
|    1 |    2 |
|    1 |    3 |
|    3 |    4 |
+------+------+
3 rows in set (0.00 sec)
~~~

Table c:

~~~mysql
mysql> TABLE c;
+------+------+
| m    | n    |
+------+------+
|    1 |    3 |
|    1 |    3 |
|    3 |    4 |
+------+------+
3 rows in set (0.00 sec)
~~~

## TABLE a INTERSECT TABLE b

~~~mysql
mysql> TABLE a INTERSECT TABLE b;
+------+------+
| m    | n    |
+------+------+
|    1 |    2 |
|    3 |    4 |
+------+------+
2 rows in set (0.00 sec)
~~~

## TABLE a INTERSECT TABLE c

~~~mysql
mysql> TABLE a INTERSECT TABLE c;
+------+------+
| m    | n    |
+------+------+
|    3 |    4 |
+------+------+
1 row in set (0.00 sec)
~~~

# Example 2

## Syntax

Following is the syntax of INTERSECT operator in MySQL

~~~mysql
SELECT column1, column2,..., columnN
FROM table1, table2,..., tableN
INTERSECT
SELECT column1, column2,..., columnN
FROM table1, table2,..., tableN
~~~

## 2 Tables: STUDENTS and ASSOCIATES

First of all, let us create a table named STUDENTS using the following query

~~~sql
CREATE TABLE STUDENTS(
   ID INT NOT NULL,
   NAME VARCHAR(20) NOT NULL,
   HOBBY VARCHAR(20) NOT NULL,
   AGE INT NOT NULL,
   PRIMARY KEY(ID)
);

INSERT INTO STUDENTS VALUES
(1, 'Vijay', 'Cricket', 18),
(2, 'Varun', 'Football', 26),
(3, 'Surya', 'Cricket', 19),
(4, 'Karthik', 'Cricket', 25),
(5, 'Sunny', 'Football', 26),
(6, 'Dev', 'Cricket', 23);
~~~

Now, let us create another table with name ASSOCIATES using the following query 

~~~sql
CREATE TABLE ASSOCIATES(
   ID INT NOT NULL,
   NAME VARCHAR(20) NOT NULL,
   SUBJECT VARCHAR(20) NOT NULL,
   AGE INT NOT NULL,
   HOBBY VARCHAR(20) NOT NULL,
   PRIMARY KEY(ID)
);

INSERT INTO ASSOCIATES VALUES
(1, 'Naina', 'Maths', 24, 'Cricket'),
(2, 'Varun', 'Physics', 26, 'Football'),
(3, 'Dev', 'Maths', 23, 'Cricket'),
(4, 'Priya', 'Physics', 25, 'Cricket'),
(5, 'Aditya', 'Chemistry', 21, 'Cricket'),
(6, 'Kalyan', 'Maths', 30, 'Football');
~~~

## Intersection Operation

Now, we return the common records from both the tables using the following query −

~~~sql
SELECT NAME, AGE, HOBBY FROM STUDENTS
INTERSECT
SELECT NAME, AGE, HOBBY FROM ASSOCIATES;
~~~

Output

The output is obtained as follows −

~~~sql
NAME   AGE	  HOBBY
Varun  26	  Football
Dev    23	  Cricket
~~~