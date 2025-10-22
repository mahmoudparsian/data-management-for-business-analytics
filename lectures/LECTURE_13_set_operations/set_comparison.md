# 🎓 Set Comparison in MySQL

## 1. Concept

Set comparison queries check whether a value:

    •    is equal to ALL values in a set (= ALL, > ALL, < ALL)
    
    •    is equal to ANY / SOME value in a set (= ANY, > ANY, < ANY)

⸻

## 2. Schema

TABLE employees:

~~~sql
CREATE TABLE employees (
    id INT,
    name VARCHAR(20),
    salary INT
);

INSERT INTO employees VALUES
(1, 'Alice', 5000),
(2, 'Bob', 7000),
(3, 'Charlie', 6000),
(4, 'David', 4000);
~~~

TABLE managers:

~~~sql
CREATE TABLE managers (
    id INT,
    name VARCHAR(20),
    salary INT
);

INSERT INTO managers VALUES
(101, 'Mary', 6500),
(102, 'John', 8000);
~~~


### 📊 employees

~~~
id   name    salary
1    Alice    5000
2    Bob      7000
3    Charlie  6000
4    David    4000
~~~

### 📊 managers

~~~
id    name    salary
101    Mary    6500
102    John    8000
~~~

⸻

## 3. Examples

### A. `> ALL (greater than all values in set)`

👉 Find employees earning more than all managers.

~~~sql
SELECT name, salary
FROM employees
WHERE salary > ALL (SELECT salary FROM managers);
~~~

✅ Output:

~~~
name    salary
Bob     7000
~~~

	(Bob’s 7000 > Mary’s 6500, but not greater than John’s 8000 → so ❌)
	Actually → no one qualifies. Correction: since Bob’s 7000 is not greater 
	than all (John has 8000). So result is empty set.

⸻

### B. `> ANY (greater than at least one value in set)`

👉 Find employees earning more than at least one manager.

~~~sql
SELECT name, salary
FROM employees
WHERE salary > ANY (SELECT salary FROM managers);
~~~

✅ Output:

~~~
name     salary
Bob      7000
Charlie  6000
~~~

(Both earn more than Mary’s 6500, but not more than John’s 8000.)

⸻

### C. `= ANY (equal to some value in set)`

👉 Find employees with salary equal to at least one manager.

~~~sql
SELECT name, salary
FROM employees
WHERE salary = ANY (SELECT salary FROM managers);
~~~

✅ Output:
(none in this dataset, since no employee has salary 6500 or 8000)

⸻

### D. `< ALL (less than all values in set)`

👉 Find employees earning less than all managers.

~~~sql
SELECT name, salary
FROM employees
WHERE salary < ALL (SELECT salary FROM managers);
~~~

✅ Output:

~~~
name    salary
Alice    5000
David    4000
~~~

(Both < 6500 and < 8000.)

⸻

## 4. Key Takeaways

    •    ALL → condition must hold for 
               every value in the set.
               
    •    ANY / SOME → condition must hold for 
         at least one value in the set.
         
    •    Useful for comparisons between subsets of data.

⸻
