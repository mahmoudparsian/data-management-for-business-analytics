-- employees_schema.sql
-- 1) Verify / create schema in MySQL
-- Run these commands in MySQL to verify existence and then create the table.

-- Verify current database (optional)
SELECT DATABASE();

-- Create table (drop if exists for idempotency during demos)
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
  emp_id       INT PRIMARY KEY,
  first_name   VARCHAR(60),
  last_name    VARCHAR(60),
  department   VARCHAR(20),
  gender       VARCHAR(10),
  country      VARCHAR(10),
  salary       INT,
  age          INT,
  date_joined  DATE
);

-- Helpful checks
DESCRIBE employees;

SHOW CREATE TABLE employees;
