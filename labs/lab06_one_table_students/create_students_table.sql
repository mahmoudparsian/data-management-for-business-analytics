CREATE TABLE IF NOT EXISTS students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    date_of_birth DATE,
    major VARCHAR(50),
    country VARCHAR(20),
    gender VARCHAR(10),
    language VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;