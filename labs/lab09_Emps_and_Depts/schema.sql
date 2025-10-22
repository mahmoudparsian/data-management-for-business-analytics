-- MySQL Schema for Employees & Departments
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(50) NOT NULL,
  location VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  name VARCHAR(80) NOT NULL,
  age INT,
  degree ENUM('BS','MS','MBA','PHD') NOT NULL,
  gender ENUM('MALE','FEMALE') NOT NULL,
  country VARCHAR(40) NOT NULL,
  dept_id INT,
  hire_date DATE,
  salary DECIMAL(10,2),
  FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
