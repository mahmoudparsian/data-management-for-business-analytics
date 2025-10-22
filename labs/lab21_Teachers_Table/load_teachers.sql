-- Fast load teachers.csv into MySQL

LOAD DATA INFILE '/path/to/teachers.csv'
INTO TABLE teachers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, first_name, last_name, degree, school, department, hire_year, hire_date, salary, country);
