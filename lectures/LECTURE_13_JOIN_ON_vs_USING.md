# MySQL JOIN "ON" vs "USING"

## Question:

	In a MySQL JOIN, what is the difference 
	between ON and USING()? 
	
	As far as I can tell, USING() is just 
	more convenient syntax, whereas ON allows 
	a little more flexibility when the column 
	names are not identical. 
	
	However, that difference is so minor, 
	you'd think they'd just do away with USING().
	
## Example:

	Consider two tables, employees and departments, 
	both having a column named department_id.
	

		-- employees table
		+----+----------+---------------+
		| id | name     | department_id |
		+----+----------+---------------+
		| 1  | Alice    | 1             |
		| 2  | Bob      | 2             |
		| 3  | Charlie  | 1             |
		+----+----------+---------------+

		-- departments table
		+---------------+--------------+
		| department_id | name         |
		+---------------+--------------+
		| 1             | HR           |
		| 2             | Engineering  |
		+---------------+--------------+

## Query 1 and Query 2 are Equivalent

	-- Query 1
	SELECT e.name AS employee_name, 
	       d.name AS department_name
	FROM employees AS e
	INNER JOIN departments AS d 
	   USING (department_id);
	
	-- Query 2
	SELECT e.name AS employee_name, 
	       d.name AS department_name
	FROM employees AS e
	INNER JOIN departments AS d 
	   ON e.department_id = d.department_id;
	   -- USING(department_id);

## Answer:

	It is mostly syntactic sugar, but a 
	couple differences are noteworthy:

	ON is the more general of the two. 
	One can join tables ON a column, 
	a set of columns and even a condition. 
	
For example:

```sql
SELECT * 
FROM world.City 
JOIN world.Country 
  ON (City.CountryCode = Country.Code) 
WHERE ...
```

## USING

		USING is useful when both tables share a 
		column of the exact same name on which 
		they join. In this case, one may say:

```sql
-- 1. film.film_id must be column
-- 2. film_actor .film_id must be column
SELECT ... 
FROM film 
JOIN film_actor 
USING (film_id) 
WHERE ...
```

An additional nice treat is that one does not need to fully qualify the joining columns:

```sql
SELECT film.title, film_id -- film_id is not prefixed
FROM film
JOIN film_actor 
USING (film_id)
WHERE ...
```

To illustrate, to do the above with ON, we would have to write:

```sql
SELECT film.title, 
       film.film_id  -- film.film_id is required here
FROM film
JOIN film_actor ON (film.film_id = film_actor.film_id)
WHERE ...
```

	Notice the `film.film_id` qualification 
	in the SELECT clause. It would be invalid 
	to just say film_id since that would make 
	for an ambiguity:

	ERROR 1052 (23000): Column 'film_id' in field list is ambiguous

As for `SELECT *`, the joining column appears in the result set twice with ON while it appears only once with USING:

```sql
create table t(i int);
insert t select 1;
create table t2 select * from t;

mysql> select * from t;
+------+
| i    |
+------+
|    1 |
+------+
1 row in set (0.000 sec)

mysql> select * from t2;
+------+
| i    |
+------+
|    1 |
+------+
1 row in set (0.001 sec)

SELECT *
FROM t 
JOIN t2 
ON t.i = t2.i;
+------+------+
|    i |    i |
+------+------+
|    1 |    1 |
+------+------+
1 row in set (0.00 sec)

SELECT * 
FROM t 
JOIN t2 USING(i);
+------+
| i    |
+------+
| 1    |
+------+
1 row in set (0.00 sec)
```


