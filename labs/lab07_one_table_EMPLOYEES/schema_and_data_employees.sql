-- -----------------------------
-- if table exists, then drop it
-- -----------------------------
DROP TABLE IF EXISTS employees;


-- -----------------------------
-- create a new emtpy table 
-- -----------------------------
CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  department VARCHAR(30),
  salary DECIMAL(10,2),
  hire_date DATE
);

-- -----------------------------
-- populate the employee table 
-- -----------------------------
INSERT INTO employees VALUES (1, 'Uma', 'Brown', 'HR', 76048, '2012-04-05');
INSERT INTO employees VALUES (2, 'Xavier', 'Brown', 'Operations', 111482, '2007-10-14');
INSERT INTO employees VALUES (3, 'Bob', 'Smith', 'HR', 68657, '2012-09-20');
INSERT INTO employees VALUES (4, 'Alice', 'Jackson', 'Finance', 111426, '2018-04-15');
INSERT INTO employees VALUES (5, 'Steve', 'Rodriguez', 'HR', 60926, '2018-06-09');
INSERT INTO employees VALUES (6, 'Ethan', 'Davis', 'Marketing', 53396, '2007-07-04');
INSERT INTO employees VALUES (7, 'Laura', 'Anderson', 'Sales', 74671, '2006-12-15');
INSERT INTO employees VALUES (8, 'Rachel', 'Brown', 'IT', 50328, '2022-05-27');
INSERT INTO employees VALUES (9, 'Uma', 'White', 'Marketing', 115674, '2011-12-03');
INSERT INTO employees VALUES (10, 'Bob', 'Garcia', 'Marketing', 50458, '2012-02-13');
INSERT INTO employees VALUES (11, 'Ian', 'Hernandez', 'Operations', 87819, '2010-06-12');
INSERT INTO employees VALUES (12, 'George', 'Rodriguez', 'Operations', 49358, '2010-09-24');
INSERT INTO employees VALUES (13, 'Hannah', 'Miller', 'IT', 89735, '2013-11-23');
INSERT INTO employees VALUES (14, 'Rachel', 'Garcia', 'Operations', 82504, '2006-04-27');
INSERT INTO employees VALUES (15, 'Bob', 'Martinez', 'IT', 75093, '2007-04-19');
INSERT INTO employees VALUES (16, 'Wendy', 'Martinez', 'Finance', 105435, '2017-11-15');
INSERT INTO employees VALUES (17, 'Ethan', 'Rodriguez', 'Finance', 72325, '2022-09-09');
INSERT INTO employees VALUES (18, 'Xavier', 'Thompson', 'IT', 116484, '2017-06-08');
INSERT INTO employees VALUES (19, 'Ethan', 'Martin', 'IT', 51915, '2006-02-05');
INSERT INTO employees VALUES (20, 'Uma', 'Miller', 'Operations', 95333, '2007-07-13');
INSERT INTO employees VALUES (21, 'Tina', 'Hernandez', 'Sales', 72953, '2022-01-22');
INSERT INTO employees VALUES (22, 'Xavier', 'Brown', 'Operations', 110381, '2013-11-11');
INSERT INTO employees VALUES (23, 'Diana', 'Wilson', 'IT', 60730, '2019-01-24');
INSERT INTO employees VALUES (24, 'Xavier', 'Rodriguez', 'Sales', 63416, '2021-02-28');
INSERT INTO employees VALUES (25, 'Uma', 'Wilson', 'Operations', 106540, '2011-03-12');
INSERT INTO employees VALUES (26, 'Yara', 'Miller', 'Sales', 109514, '2005-10-11');
INSERT INTO employees VALUES (27, 'Paula', 'Smith', 'HR', 87576, '2014-04-02');
INSERT INTO employees VALUES (28, 'Hannah', 'Thompson', 'HR', 51226, '2020-02-25');
INSERT INTO employees VALUES (29, 'Rachel', 'Jones', 'Finance', 102296, '2022-03-09');
INSERT INTO employees VALUES (30, 'Quinn', 'White', 'IT', 67760, '2022-12-23');
INSERT INTO employees VALUES (31, 'George', 'Wilson', 'IT', 88944, '2019-09-15');
INSERT INTO employees VALUES (32, 'Diana', 'Garcia', 'Finance', 48392, '2015-01-19');
INSERT INTO employees VALUES (33, 'Rachel', 'Garcia', 'Sales', 68864, '2005-02-23');
INSERT INTO employees VALUES (34, 'Uma', 'Johnson', 'Finance', 48834, '2006-06-03');
INSERT INTO employees VALUES (35, 'Quinn', 'Garcia', 'Marketing', 103624, '2011-09-05');
INSERT INTO employees VALUES (36, 'Xavier', 'Thompson', 'Sales', 101953, '2012-08-26');
INSERT INTO employees VALUES (37, 'Nina', 'Davis', 'HR', 52704, '2018-06-14');
INSERT INTO employees VALUES (38, 'Nina', 'Hernandez', 'Operations', 47100, '2008-01-13');
INSERT INTO employees VALUES (39, 'Xavier', 'Martinez', 'HR', 72591, '2011-04-18');
INSERT INTO employees VALUES (40, 'Oscar', 'Jones', 'IT', 64050, '2013-08-08');
INSERT INTO employees VALUES (41, 'Charlie', 'Hernandez', 'Sales', 52833, '2006-11-18');
INSERT INTO employees VALUES (42, 'Alice', 'Williams', 'Finance', 61798, '2018-08-16');
INSERT INTO employees VALUES (43, 'George', 'Taylor', 'HR', 61579, '2017-01-13');
INSERT INTO employees VALUES (44, 'Ian', 'Hernandez', 'Marketing', 95444, '2022-11-23');
INSERT INTO employees VALUES (45, 'Paula', 'Jones', 'Finance', 78890, '2011-01-19');
INSERT INTO employees VALUES (46, 'Xavier', 'Jackson', 'HR', 81104, '2006-01-19');
INSERT INTO employees VALUES (47, 'Paula', 'Martin', 'Sales', 60635, '2006-09-03');
INSERT INTO employees VALUES (48, 'Fiona', 'Williams', 'Sales', 48907, '2012-07-04');
INSERT INTO employees VALUES (49, 'Steve', 'Garcia', 'Sales', 117924, '2006-10-03');
INSERT INTO employees VALUES (50, 'Nina', 'Thompson', 'Sales', 108522, '2015-05-07');
