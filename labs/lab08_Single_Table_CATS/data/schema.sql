-- Schema
DROP TABLE IF EXISTS cats;
DROP TABLE IF EXISTS breeds;

CREATE TABLE breeds (
  breed VARCHAR(20) PRIMARY KEY,
  description VARCHAR(128)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE cats (
  id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  date_of_birth DATE,
  num_of_tricks INT,
  country VARCHAR(20),
  gender VARCHAR(10),
  breed VARCHAR(20),
  age INT,
  FOREIGN KEY (breed) REFERENCES breeds(breed)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
