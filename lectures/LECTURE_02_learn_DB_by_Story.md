# Learn DBMS by Story Telling

That's a fantastic way to learn\! 

Let's tell the story of a **Database**, a **Table**, and their friends.

Imagine you've just opened a new, beautiful, but empty **filing cabinet** 📂. 

This filing cabinet is your **MySQL Server**—it's the machine that manages all your data.

-----

## Chapter 1: The Land of Databases

Our story begins with the need for a place to organize things. 

You can't just pile papers on the floor\!

### The Database: The Top Drawer

Within your MySQL Server (the filing cabinet), the first thing you need is a **Database**. Think of a Database as the **top drawer** of the filing cabinet—a container for a single project or application.

You want a database for your *pet store* business. You tell the server:

| Action | SQL Command | Story Analogy |
| :--- | :--- | :--- |
| **Create** the new database (the drawer). | `CREATE DATABASE pet_store;` | "Make a new drawer and label it 'Pet Store'." |
| **Use** this database (open the drawer so you can put things inside). | `USE pet_store;` | "Now, I'm working *in* the 'Pet Store' drawer." |

Now you're ready to organize the papers inside.

------
## Main Concepts

#### 💡 A Database = { set of Tables }
#### 💡  An enterprise may have many Databases 

#### 💡 A Database Example `company_db` = { 3 Tables: employees, departments, projects}

#### 💡 A Table: employees = rows x columns
#### 💡 A Table: departments = rows x columns
#### 💡 A Table: projects = rows x columns
#### 💡 row = record = tuple
#### 💡 column = field = attribute

-----

### employees Table: 7 rows x 4 columns

#### employees Table:

**Columns are**: { `emp_id`, `emp_name`, `dept_id`, `salary` }

* NOT enforcing a FOREIGN KEY (for `dept_id`)

```sql 
CREATE TABLE employees(
  emp_id     INT Primary Key, 
  emp_name   VARCHAR(40), 
  dept_id    VARCHAR(10),
  salary     INT
);
```

* Enforcing a FOREIGN KEY (for `dept_id`)
* `dept_id` must be valid department id and CAN NOT be a NULL

```sql
CREATE TABLE employees(
  emp_id     INT Primary Key, 
  emp_name   VARCHAR(40), 
  dept_id    VARCHAR(10) NOT NULL, 
  salary     INT,
  FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
```


| `emp_id` | `emp_name`     | `dept_id` | `salary`|
| -------- | -------------- | --------- | --------|
| 900      | Tracy Martinez | DEPT300   | NULL    |
| 100      | Alex Taylor    | DEPT300   | 65000   |
| 400      | Bob Federer    | DEPT700   | 76000   |
| 300      | Jane Austin    | DEPT300   | 68000   |
| 700      | Rafa Nadal     | DEPT100   | 86000   |
| 800      | Carlos Alcaraz | DEPT100   | 98000   |
| 200      | Max Jobrani    | DEPT300   | 65000   |

* ✅ NOTE-1: NULL means a "missing" (undefined) value.
* ✅  NOTE-2: NULL is NOT a zero (0)
* ✅  NOTE-3: NULL is NOT an empty string of length 0


#### Populate employees Table:

```sql
INSERT INTO employees(emp_id, emp_name, dept_id, salary) 
VALUES
(900,  'Tracy Martinez', 'DEPT300',  NULL),
(100,  'Alex Taylor',    'DEPT300',  65000),
(400,  'Bob Federer',    'DEPT700',  76000),
(300,  'Jane Austin',    'DEPT300',  68000),
(700,  'Rafa Nadal',     'DEPT100',  86000),
(800,  'Carlos Alcaraz', 'DEPT100',  98000),
(200,  'Max Jobrani',    'DEPT300',  65000);
```


### departments Table: 4 rows x 2 columns

**Columns are**: { `dept_id`, `dept_name` }

```sql
CREATE TABLE departments (
  dept_id    VARCHAR(10) PRIMARY KEY, 
  dept_name   VARCHAR(40) 
);
```


| `dept_id` | `dept_name`     | 
| --------- | --------------- | 
| DEPT100   | Sports          | 
| DEPT200   | AI              | 
| DEPT300   | Human Resources | 
| DEPT700   | Business        | 

#### Populate departments Table:

```sql
INSERT INTO departments(dept_id, dept_name) 
VALUES
('DEPT100', 'Sports'),        
('DEPT200', 'AI'),             
('DEPT300', 'Human Resources'),
('DEPT700', 'Business');

```


#### ✅ NOTE-1: `departments.dept_id` Links to `employees.dept_id`

#### ✅ NOTE-2: Tables are linked by one or more COMMON columns

#### Note of NULL values in SQL Queries

```sql
-- Query-1
select count(*) 
from employees;
+----------+
| count(*) |
+----------+
|        7 |
+----------+
1 row in set (0.001 sec)

-- Query-2
select count(salary) 
from employees;
+---------------+
| count(salary) |
+---------------+
|             6 |
+---------------+
1 row in set (0.001 sec)


-- Query-3
select dept_id, 
       sum(salary), 
       count(*)
from employees 
group by dept_id;
+---------+-------------+----------+
| dept_id | sum(salary) | count(*) |
+---------+-------------+----------+
| DEPT300 |      198000 |        4 |
| DEPT700 |       76000 |        1 |
| DEPT100 |      184000 |        2 |
+---------+-------------+----------+
3 rows in set (0.001 sec)

-- Query-4
select dept_id, 
       sum(salary), 
       count(salary) 
from employees 
group by dept_id;
+---------+-------------+---------------+
| dept_id | sum(salary) | count(salary) |
+---------+-------------+---------------+
| DEPT300 |      198000 |             3 |
| DEPT700 |       76000 |             1 |
| DEPT100 |      184000 |             2 |
+---------+-------------+---------------+
3 rows in set (0.001 sec)

-- Query-5
select dept_id, 
       sum(salary), 
       count(salary), 
       count(*) 
from employees 
group by dept_id;
+---------+-------------+---------------+----------+
| dept_id | sum(salary) | count(salary) | count(*) |
+---------+-------------+---------------+----------+
| DEPT300 |      198000 |             3 |        4 |
| DEPT700 |       76000 |             1 |        1 |
| DEPT100 |      184000 |             2 |        2 |
+---------+-------------+---------------+----------+
3 rows in set (0.001 sec)


-- Query-6
select dept_id, 
       avg(salary) AS avg_salary,
       count(*) AS total_count,
       count(salary) AS salary_count, 
       GROUP_CONCAT(salary) AS list_of_salaries
from employees 
group by dept_id;

mysql> select dept_id,
    ->        avg(salary) AS avg_salary,
    ->        count(*) AS total_count,
    ->        count(salary) AS salary_count,
    ->        GROUP_CONCAT(salary) AS list_of_salaries
    -> from employees
    -> group by dept_id;
+---------+------------+-------------+--------------+-------------------+
| dept_id | avg_salary | total_count | salary_count | list_of_salaries  |
+---------+------------+-------------+--------------+-------------------+
| DEPT100 | 92000.0000 |           2 |            2 | 86000,98000       |
| DEPT300 | 66000.0000 |           4 |            3 | 65000,65000,68000 |
| DEPT700 | 76000.0000 |           1 |            1 | 76000             |
+---------+------------+-------------+--------------+-------------------+
3 rows in set (0.000 sec)




-- Query-7
select dept_id, 
       MIN(salary) AS min_salary,
       MAX(salary) AS max_salary,
       count(salary) AS salary_count, 
       GROUP_CONCAT(salary) AS list_of_salaries
from employees 
group by dept_id;

mysql> select dept_id,
    ->        MIN(salary) AS min_salary,
    ->        MAX(salary) AS max_salary,
    ->        count(salary) AS salary_count,
    ->        GROUP_CONCAT(salary) AS list_of_salaries
    -> from employees
    -> group by dept_id;
+---------+------------+------------+--------------+-------------------+
| dept_id | min_salary | max_salary | salary_count | list_of_salaries  |
+---------+------------+------------+--------------+-------------------+
| DEPT100 |      86000 |      98000 |            2 | 86000,98000       |
| DEPT300 |      65000 |      68000 |            3 | 65000,65000,68000 |
| DEPT700 |      76000 |      76000 |            1 | 76000             |
+---------+------------+------------+--------------+-------------------+
3 rows in set (0.000 sec)
```
-----

## Chapter 2: The Tables and The Schema

Inside the 'Pet Store' drawer, you don't just dump all your receipts and customer lists together. You use **folders**\!

### The Table: The Folders

A **Table** is a folder inside your Database. A Table holds information about a specific *type* of thing. For the pet store, you need separate folders for:

1.  **Pets** (the animals you sell)
2.  **Customers** (who buys the pets)
3.  **Products** (food, toys, etc.)

Let's focus on the **Pets Table**.

### The Schema: The Column Headings

When you create a Table (the folder), you must first decide *what* information you're going to keep. This structure is called the **Schema**. Think of it as deciding on the **column headings** on a sheet of paper inside the folder.

For the **Pets Table**, you decide you need:

| Column Name | Data Type | Story Analogy |
| :--- | :--- | :--- |
| **pet\_id** | `INT` (Integer/Whole Number) | A unique ID number for the animal. |
| **name** | `VARCHAR(50)` (Variable Character, up to 50 letters) | The animal's name. |
| **species** | `VARCHAR(50)` | Cat, Dog, Bird, etc. |
| **price** | `DECIMAL(6,2)` (A number with decimals) | How much it costs. |

This is how you tell MySQL to create the 'Pets' folder with these specific column headings:

#### ✅ Create a database called `pets_db`

```sql
CREATE DATABASE pets_db; 
```

#### ✅ Use `pets_db` to create a table:

```sql
USE pets_db;

CREATE TABLE Pets (
    pet_id INT PRIMARY KEY,
    name VARCHAR(50),
    species VARCHAR(50),
    price DECIMAL(6,2)
);
```

> 💡 **Key Concept:** `PRIMARY KEY` means the `pet_id` is the **unique identifier**—no two pets can have the same `pet_id`. It's like the license plate number for your car.

-----

## Chapter 3: The Four Heroes of SQL (CRUD)

Now that you have your 'Pets' folder with column headings, it's time to do the actual work. SQL operations are often remembered by the acronym **CRUD**: 

* **C**reate, 
* **R**ead, 
* **U**pdate, 
* **D**elete.

### 1\. CREATE (Inserting Data)

You get a new kitten and a puppy\! You need to add them to the **Pets Table**. This means you are **INSERTING** new rows of data.

```sql
-- Insert the kitten
INSERT INTO Pets (pet_id, name, species, price)
VALUES (101, 'Whiskers', 'Cat', 199.99);

-- Insert the puppy
INSERT INTO Pets (pet_id, name, species, price)
VALUES (102, 'Buddy', 'Dog', 450.00);

-- Insert 3 another rows:
INSERT INTO Pets (pet_id, name, species, price)
VALUES 
(104, 'Pishi', 'Cat', 89.99),
(105, 'Salt', 'Cat',  79.99),
(109, 'Ginger', 'Dog',  59.00);

```

| `pet_id` | `name` | `species` | `price` |
| :--- | :--- | :--- | :--- |
| **101** | **Whiskers** | **Cat** | **199.99** |
| **102** | **Buddy** | **Dog** | **450.00** |

### 2\. READ (Retrieving Data)

You want to see what's in the folder. This is the most common operation, and you use the **SELECT** command.

| Action | SQL Command | Story Analogy |
| :--- | :--- | :--- |
| **Show ALL** the columns (`*` means "everything") and ALL the rows from the Pets Table. | `SELECT *` <br> `FROM Pets;` | "Pull out the 'Pets' folder and show me everything." |
| Show only the **name** and **price** of the pets. | `SELECT name, price` <br> `FROM Pets;` | "Show me just the 'Name' and 'Price' columns." |
| Show all information for only the **Dogs**. | `SELECT * ` <br> `FROM Pets` <br> `WHERE species = 'Dog';` | "Show me everything, but ONLY the entries where the 'Species' column says 'Dog'." |

### 3\. UPDATE (Modifying Data)

Oh no\! You realized the price for 'Buddy' the puppy was wrong—it should be $475. You need to **UPDATE** the data.

```sql
UPDATE Pets
SET price = 475.00  -- SET the new price
WHERE pet_id = 102; -- ONLY WHERE the pet_id is 102 (Buddy)
```

> ⚠️ **CRITICAL WARNING:** Always use a **`WHERE`** clause with `UPDATE` and `DELETE`\! If you forget it, you will change or delete *every single row* in your table\!

### 4\. DELETE (Removing Data)

'Whiskers' the kitten was just adopted\! Hooray\! You need to remove them from the Table.

```sql
DELETE FROM Pets
WHERE pet_id = 101; -- ONLY WHERE the pet_id is 101 (Whiskers)
```

Now, if you use `SELECT * FROM Pets;`, you'll only see the 'Buddy' row.

### Example on using DELETE

```sql
mysql> select * from employees;
+--------+----------------+---------+--------+
| emp_id | emp_name       | dept_id | salary |
+--------+----------------+---------+--------+
|    100 | Alex Taylor    | DEPT300 |  65000 |
|    200 | Max Jobrani    | DEPT300 |  65000 |
|    300 | Jane Austin    | DEPT300 |  68000 |
|    400 | Bob Federer    | DEPT700 |  76000 |
|    700 | Rafa Nadal     | DEPT100 |  86000 |
|    800 | Carlos Alcaraz | DEPT100 |  98000 |
|    900 | Tracy Martinez | DEPT300 |   NULL |
+--------+----------------+---------+--------+
7 rows in set (0.000 sec)

mysql> DELETE FROM employees WHERE emp_id = 100;
Query OK, 1 row affected (0.001 sec)

mysql> select * from employees;
+--------+----------------+---------+--------+
| emp_id | emp_name       | dept_id | salary |
+--------+----------------+---------+--------+
|    200 | Max Jobrani    | DEPT300 |  65000 |
|    300 | Jane Austin    | DEPT300 |  68000 |
|    400 | Bob Federer    | DEPT700 |  76000 |
|    700 | Rafa Nadal     | DEPT100 |  86000 |
|    800 | Carlos Alcaraz | DEPT100 |  98000 |
|    900 | Tracy Martinez | DEPT300 |   NULL |
+--------+----------------+---------+--------+
6 rows in set (0.000 sec)

mysql> DELETE FROM employees WHERE emp_id = 200;
Query OK, 1 row affected (0.001 sec)

mysql> select * from employees;
+--------+----------------+---------+--------+
| emp_id | emp_name       | dept_id | salary |
+--------+----------------+---------+--------+
|    300 | Jane Austin    | DEPT300 |  68000 |
|    400 | Bob Federer    | DEPT700 |  76000 |
|    700 | Rafa Nadal     | DEPT100 |  86000 |
|    800 | Carlos Alcaraz | DEPT100 |  98000 |
|    900 | Tracy Martinez | DEPT300 |   NULL |
+--------+----------------+---------+--------+
5 rows in set (0.000 sec)

mysql> DELETE FROM employees;
Query OK, 5 rows affected (0.001 sec)

mysql> select * from employees;
Empty set (0.000 sec)

```
-----

## Chapter 4: Practice Commands

Here are a few quick commands to check your work, which act like quickly reading the labels on your drawers and folders:

| Goal | SQL Command | Story Analogy |
| :--- | :--- | :--- |
| See all the databases (drawers) in your server. | `SHOW DATABASES;` | "What drawers do I have?" |
| See all the tables (folders) in the currently open database. | `SHOW TABLES;` | "What folders are in this drawer?" |
| See the structure/schema (column headings) of a specific table. | `DESCRIBE Pets;` or `DESC Pets;` | "What are the column headings on the 'Pets' sheet?" |

And that's the basic story of SQL\! You now know how to create the container (`DATABASE`), define the structure (`TABLE`), and perform the four core operations on the data (`INSERT`, `SELECT`, `UPDATE`, `DELETE`). 

Go forth and start filling your filing cabinet\! 🚀
