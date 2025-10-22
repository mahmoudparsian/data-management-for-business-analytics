-- teachers schema (MySQL 8+)
DROP TABLE IF EXISTS teachers;

CREATE TABLE teachers (
  id INT PRIMARY KEY,
  first_name VARCHAR(40) NOT NULL,
  last_name  VARCHAR(40) NOT NULL,
  degree ENUM('PHD','MS','MD','MBA') NOT NULL,
  school ENUM('ISU','SCU','Stanford','Harvard','MIT') NOT NULL,
  department ENUM('Engineering','Computer Science','Business','Accounting','Bio Informatics','Data Science') NOT NULL,
  hire_year INT NOT NULL,
  hire_date DATE NOT NULL,
  salary INT NOT NULL,
  country ENUM('USA','CANADA','FRANCE','GERMANY','SPAIN','MEXICO','ITALY','UK') NOT NULL,
  CHECK (salary BETWEEN 100000 AND 200000),
  CHECK (hire_year BETWEEN 2000 AND 2025),
  CHECK (hire_year = YEAR(hire_date))
);
