-- LOAD DATA LOCAL example (use mysql client with --local-infile=1)
-- SHOW VARIABLES LIKE 'local_infile';
-- SET SESSION local_infile=1;

LOAD DATA LOCAL INFILE '/absolute/path/to/employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(emp_id, first_name, last_name, age, degree, gender, country, department, hire_date, salary);
