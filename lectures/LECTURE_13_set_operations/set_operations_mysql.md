# SET Operations (using MySQL)

	Let's teach MySQL's union, union all, intersect 
	and except set operations. create 2 simple table 
	each having 3 rows and then demo these set operations 
	with sql and  output


📝 Teaching Notes

    •    UNION removes duplicates.
    •    UNION ALL keeps duplicates.
    •    INTERSECT → simulate with INNER JOIN.
    •    EXCEPT 

⸻

## 🎓 Teaching Example: Set Operations in MySQL

### Step 1: Create Two Tables

~~~mysql
CREATE TABLE tableA (
    id INT,
    name VARCHAR(20)
);

CREATE TABLE tableB (
    id INT,
    name VARCHAR(20)
);
~~~

### Step 2: Populate these Two Tables

~~~mysql
INSERT INTO tableA VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

INSERT INTO tableB VALUES
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David');
~~~


### 📊 tableA

~~~
id    name
1     Alice
2     Bob
3     Charlie
~~~

### 📊 tableB

~~~
id    name
2     Bob
3     Charlie
4     David
~~~

⸻

## Step 3: UNION (removes duplicates)

~~~mysql
SELECT id, name FROM tableA
UNION
SELECT id, name FROM tableB;
~~~

✅ Output

~~~
id    name
1    Alice
2    Bob
3    Charlie
4    David
~~~

⸻

## Step 4: UNION ALL (keeps duplicates)

~~~mysql
SELECT id, name FROM tableA
UNION ALL
SELECT id, name FROM tableB;
~~~

✅ Output

~~~
id    name
1    Alice
2    Bob
3    Charlie
2    Bob
3    Charlie
4    David
~~~

⸻

## Step 5: INTERSECT (common rows)

~~~mysql
SELECT a.id, a.name
FROM tableA a
INTERSECT
SELECT b.id, b.name
FROM tableB b;
~~~

✅ Output

~~~
id    name
2     Bob
3     Charlie
~~~

👉 MySQL INTERSECT, by using INNER JOIN:

~~~sql
SELECT a.id, a.name
FROM tableA a
INNER JOIN tableB b
ON a.id = b.id AND a.name = b.name;
~~~

✅ Output

~~~
id    name
2     Bob
3     Charlie
~~~


⸻

## Step 6: EXCEPT (rows in A but not in B)

~~~sql
SELECT id, name FROM tableA
EXCEPT
SELECT id, name FROM tableB;
~~~

✅ Output

id    name
1     Alice

## Step 7: EXCEPT: another method

~~~sql
SELECT id, name FROM tableA
WHERE (id, name) NOT IN (
    SELECT id, name FROM tableB
);
~~~

✅ Output

~~~
id    name
1     Alice
~~~

⸻

