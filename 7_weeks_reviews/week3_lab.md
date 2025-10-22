# Week 3 — Joins Part 1: INNER / LEFT / RIGHT

## Slides (20)
#### Slide 1: Why Joins?
- Normalize data across tables
- PK/FK relationships

#### Slide 2: INNER JOIN
- Matching rows only
- ON vs USING

#### Slide 3: LEFT JOIN
- Keep left rows
- NULLs on the right when no match

#### Slide 4: RIGHT JOIN
- Keep right rows
- NULLs on the left when no match

#### Slide 5: Join Conditions
- Equality joins
- Multiple conditions

#### Slide 6: Aliases
- Short names e,d
- Disambiguate columns

#### Slide 7: Avoid Cartesian
- Always use ON
- Symptoms of mistakes

#### Slide 8: Multi-Join Chains
- e→d→other
- Readability tips

#### Slide 9: Aggregates After Join
- COUNT per dept
- AVG salary per dept

#### Slide 10: Filtering After Join
- WHERE clauses
- ON vs WHERE difference

#### Slide 11: Duplicates
- DISTINCT when needed
- Counting carefully

#### Slide 12: Outer Join Effects
- NULLs introduced
- Checking non-matches

#### Slide 13: Performance Basics
- Indexes on join keys
- Cardinality

#### Slide 14: Integrity
- FK constraints (concept)
- Detecting orphan rows

#### Slide 15: Debugging Joins
- Start small
- Add columns gradually

#### Slide 16: EXPLAIN Joins
- Join order
- Key usage

#### Slide 17: Style
- Consistent aliasing
- Explicit column lists

#### Slide 18: Edge Cases
- Many-to-many
- Missing data

#### Slide 19: Patterns
- Top-N per dept (preview)
- Self-joins (preview)

#### Slide 20: Lab Preview
- Practice set overview


```sql
CREATE TABLE departments (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(30)
);
CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(30),
  last_name  VARCHAR(30),
  dept_id    INT,
  country    VARCHAR(20),
  salary     INT,
  hire_date  DATE,
  degree     VARCHAR(10)
);
```

```sql
INSERT INTO departments(dept_id,dept_name) VALUES
(1,'Business'),
(2,'Marketing'),
(3,'Engineering'),
(4,'IT');
```

```sql
INSERT INTO employees(emp_id,first_name,last_name,dept_id,country,salary,hire_date,degree) VALUES
(1,'Frank','Gonzalez',3,'MEXICO',154061,'2014-03-24','BS'),
(2,'Owen','Hernandez',1,'USA',61585,'2022-10-14','MS'),
(3,'Frank','Wilson',3,'INDIA',87124,'2019-02-21','BS'),
(4,'Dylan','Rodriguez',3,'CANADA',150996,'2015-07-10','PHD'),
(5,'Ben','Brown',2,'MEXICO',136135,'2020-11-29','BS'),
(6,'Ben','Miller',3,'MEXICO',149588,'2012-02-11','MBA'),
(7,'Bob','White',4,'MEXICO',62587,'2017-10-28','BS'),
(8,'Una','Martin',3,'CANADA',146883,'2018-12-06','PHD'),
(9,'Hank','Johnson',3,'GERMANY',92444,'2015-12-20','MS'),
(10,'Hank','Martinez',1,'GERMANY',135012,'2014-10-07','BS'),
(11,'Gina','Ramirez',4,'USA',109715,'2022-11-16','BS'),
(12,'Tina','Davis',1,'CANADA',110979,'2020-05-09','MS'),
(13,'Rita','White',2,'CANADA',151905,'2013-12-04','PHD'),
(14,'Oscar','Taylor',1,'INDIA',172430,'2024-12-20','BS'),
(15,'Paul','Perez',1,'MEXICO',154564,'2015-11-06','MBA'),
(16,'Zane','Jackson',4,'USA',136442,'2023-11-20','MBA'),
(17,'Gina','Smith',1,'CANADA',101361,'2024-01-01','MBA'),
(18,'Sara','Garcia',2,'USA',83529,'2023-04-25','PHD'),
(19,'Finn','Moore',2,'MEXICO',144424,'2015-10-28','BS'),
(20,'Uma','Ramirez',3,'GERMANY',147221,'2018-04-25','PHD'),
(21,'Finn','Lewis',4,'CANADA',124288,'2024-01-18','MBA'),
(22,'Oscar','Davis',3,'CANADA',117120,'2016-03-16','MBA'),
(23,'Finn','Ramirez',3,'CANADA',79429,'2019-05-17','MBA'),
(24,'Owen','Wilson',4,'MEXICO',70591,'2016-07-28','BS'),
(25,'Bob','Garcia',4,'GERMANY',67099,'2019-10-05','MS'),
(26,'Vera','Lee',1,'MEXICO',175322,'2014-05-31','PHD'),
(27,'Zane','Martin',3,'CANADA',147677,'2020-05-17','BS'),
(28,'Vera','White',1,'CANADA',156530,'2012-10-31','BS'),
(29,'Jack','Rodriguez',4,'CANADA',117647,'2012-11-04','BS'),
(30,'Zoe','Martinez',1,'GERMANY',158500,'2018-01-20','PHD'),
(31,'Ivy','Moore',3,'USA',153301,'2013-04-28','MBA'),
(32,'Liam','Robinson',1,'GERMANY',100382,'2020-07-07','PHD'),
(33,'Vera','Sanchez',2,'USA',139215,'2024-03-12','PHD'),
(34,'Yuri','Hernandez',2,'CANADA',61014,'2017-01-16','PHD'),
(35,'Wendy','Smith',1,'MEXICO',110991,'2021-03-11','MS'),
(36,'Rita','White',2,'CANADA',142703,'2017-04-21','MS'),
(37,'Aria','Lopez',3,'GERMANY',154388,'2022-09-20','MBA'),
(38,'Will','Smith',3,'MEXICO',116536,'2013-01-16','MBA'),
(39,'Pia','Johnson',1,'GERMANY',68821,'2017-02-11','PHD'),
(40,'Jon','Johnson',2,'CANADA',106086,'2019-09-05','PHD');
```

## Lab: 40 Queries (English → SQL)

1. List every employee with their department name
```sql
SELECT e.emp_id, e.first_name, e.last_name, d.dept_name FROM employees e INNER JOIN departments d ON e.dept_id=d.dept_id;
```

2. Return all employees, even if their department is missing (LEFT JOIN)
```sql
SELECT e.emp_id, e.first_name, d.dept_name FROM employees e LEFT JOIN departments d ON e.dept_id=d.dept_id;
```

3. Return all departments, even if they have no employees (RIGHT JOIN)
```sql
SELECT d.dept_name, e.emp_id FROM employees e RIGHT JOIN departments d ON e.dept_id=d.dept_id;
```

4. Find employees who belong to Engineering
```sql
SELECT e.* FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE d.dept_name='Engineering';
```

5. Count employees in each department
```sql
SELECT d.dept_name, COUNT(*) AS cnt FROM employees e JOIN departments d ON e.dept_id=d.dept_id GROUP BY d.dept_name;
```

6. Average salary per department
```sql
SELECT d.dept_name, AVG(e.salary) AS avg_sal FROM employees e JOIN departments d ON e.dept_id=d.dept_id GROUP BY d.dept_name;
```

7. Employees hired on/after 2020 with department name
```sql
SELECT e.emp_id, e.first_name, d.dept_name, e.hire_date FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.hire_date >= '2020-01-01';
```

8. Preview top earners by department (sorted list)
```sql
SELECT d.dept_name, e.first_name, e.salary FROM employees e JOIN departments d ON e.dept_id=d.dept_id ORDER BY d.dept_name, e.salary DESC;
```

9. Employees located in USA, grouped by department
```sql
SELECT d.dept_name, e.emp_id FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.country='USA';
```

10. Find employees whose department is missing (should be none)
```sql
SELECT e.* FROM employees e LEFT JOIN departments d ON e.dept_id=d.dept_id WHERE d.dept_id IS NULL;
```

11. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

12. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

13. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

14. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

15. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

16. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

17. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

18. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

19. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

20. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

21. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

22. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

23. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

24. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

25. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

26. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

27. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

28. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

29. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

30. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

31. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

32. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

33. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

34. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

35. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

36. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

37. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

38. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

39. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```

40. Employees with degree PHD and their departments
```sql
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id WHERE e.degree='PHD';
```
