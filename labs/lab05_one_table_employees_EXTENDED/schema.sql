-- MySQL schema
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    degree VARCHAR(10),
    gender VARCHAR(6),
    country VARCHAR(20),
    department VARCHAR(20),
    hire_date DATE,
    salary INT
);
