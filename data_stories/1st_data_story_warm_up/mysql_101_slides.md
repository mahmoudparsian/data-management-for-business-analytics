# Introduction to MySQL 101

## Slide 1: What is MySQL?
- Open-source relational database system
- Uses SQL (Structured Query Language)
- Widely used for web and business applications

## Slide 2: Installing MySQL
- Available for Windows, macOS, Linux
- Use installers or package managers (brew, apt, yum)
- Ensure MySQL server and client tools are installed

## Slide 3: Starting the MySQL Server
- Start the MySQL service
- On Linux: `sudo systemctl start mysql`
- On macOS (brew): `brew services start mysql`
- On Windows: Start from Services panel

## Slide 4: Connecting to MySQL
- Command: `mysql -u root -p`
- Enter password when prompted
- You are now in the MySQL shell

## Slide 5: Basic MySQL Shell Commands
- `help;` → list commands
- `exit;` or `quit;` → leave MySQL shell
- End SQL statements with `;`

## Slide 6: Creating a Database
- Command: `CREATE DATABASE mydb;`
- Show databases: `SHOW DATABASES;`
- Use a database: `USE mydb;`

## Slide 7: Creating a Table
- Example:
```sql
CREATE TABLE students (
 id INT PRIMARY KEY,
 name VARCHAR(50),
 age INT
);
```

## Slide 8: Showing Tables
- `SHOW TABLES;`
- Show schema: `DESCRIBE students;`

## Slide 9: Inserting Data
```sql
INSERT INTO students VALUES (1,'Alice',20);
INSERT INTO students VALUES (2,'Bob',22);
```

## Slide 10: Selecting Data
- Basic select: `SELECT * FROM students;`
- Selecting specific columns: `SELECT name FROM students;`

## Slide 11: Filtering Data
- Using WHERE:
```sql
SELECT * FROM students WHERE age > 20;
```

## Slide 12: Updating Data
```sql
UPDATE students
SET age=23
WHERE name='Bob';
```

## Slide 13: Deleting Data
```sql
DELETE FROM students
WHERE id=1;
```

## Slide 14: Constraints
- PRIMARY KEY → unique ID
- NOT NULL → column must have a value
- UNIQUE → all values must be unique

## Slide 15: Basic Data Types
- INT → numbers
- VARCHAR(n) → strings
- DATE → date values
- DECIMAL(p,s) → precise numbers

## Slide 16: Using ORDER BY
```sql
SELECT * FROM students
ORDER BY age DESC;
```

## Slide 17: Using LIMIT
```sql
SELECT * FROM students
LIMIT 5;
```

## Slide 18: Aggregate Functions
- COUNT, SUM, AVG, MIN, MAX
```sql
SELECT AVG(age) FROM students;
```

## Slide 19: GROUP BY
```sql
SELECT age, COUNT(*)
FROM students
GROUP BY age;
```

## Slide 20: Dropping Tables and Databases
- Drop table: `DROP TABLE students;`
- Drop database: `DROP DATABASE mydb;`