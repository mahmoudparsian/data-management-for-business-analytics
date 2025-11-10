
-- Generated on 2025-11-10
-- Complete, runnable MySQL script for the module

-- 1) Create database
DROP DATABASE IF EXISTS module_db;
CREATE DATABASE module_db;
USE module_db;

-- 2) Tables
CREATE TABLE students (
  student_id INT PRIMARY KEY,
  name VARCHAR(60) NOT NULL,
  country VARCHAR(30),
  age INT
);

CREATE TABLE departments (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(40) UNIQUE
);

CREATE TABLE courses (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(80) NOT NULL,
  dept_id INT,
  FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE enrollments (
  enroll_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT,
  course_id INT,
  semester VARCHAR(10),
  grade DECIMAL(4,2),
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (course_id) REFERENCES courses(course_id),
  INDEX(student_id),
  INDEX(course_id)
);

CREATE TABLE tests (
  test_id INT AUTO_INCREMENT PRIMARY KEY,
  course_id INT,
  test_name VARCHAR(80),
  max_score INT,
  FOREIGN KEY (course_id) REFERENCES courses(course_id),
  INDEX(course_id)
);

CREATE TABLE scores (
  score_id INT AUTO_INCREMENT PRIMARY KEY,
  test_id INT,
  student_id INT,
  score INT,
  FOREIGN KEY (test_id) REFERENCES tests(test_id),
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  INDEX(test_id),
  INDEX(student_id)
);

-- 3) Seed data
INSERT INTO students(student_id, name, country, age) VALUES
(101, 'Alice', 'USA', 20),
(102, 'Bob', 'CANADA', 22),
(103, 'Carol', 'GERMANY', 23),
(104, 'David', 'USA', 21),
(105, 'Eve', 'FRANCE', 24),
(106, 'Frank', 'MEXICO', 22),
(107, 'Grace', 'TURKEY', 23),
(108, 'Heidi', 'ITALY', 25),
(109, 'Ivan', 'GERMANY', 21),
(110, 'Judy', 'USA', 22);

INSERT INTO departments(dept_id, dept_name) VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Business'),
(4, 'Physics');

INSERT INTO courses(course_id, course_name, dept_id) VALUES
(201, 'Intro to SQL', 1),
(202, 'Data Structures', 1),
(203, 'Linear Algebra', 2),
(204, 'Calculus I', 2),
(205, 'Accounting 101', 3),
(206, 'Microeconomics', 3),
(207, 'Classical Mechanics', 4),
(208, 'Electromagnetism', 4);

INSERT INTO enrollments(student_id, course_id, semester, grade) VALUES
(101,201,'F24', 3.7),
(101,203,'F24', 3.3),
(101,204,'S25', 3.9),
(102,201,'F24', 3.4),
(102,205,'F24', 3.2),
(103,201,'F24', 3.8),
(103,202,'S25', 3.6),
(103,203,'S25', 3.7),
(104,204,'F24', 3.1),
(104,207,'S25', 3.0),
(105,201,'F24', 3.9),
(105,206,'S25', 3.6),
(106,205,'F24', 3.0),
(106,206,'S25', 3.4),
(107,207,'F24', 3.2),
(108,208,'F24', 3.5),
(109,201,'F24', 3.0),
(109,203,'S25', 3.4),
(110,201,'F24', 3.1),
(110,202,'S25', 3.2);

INSERT INTO tests(course_id, test_name, max_score) VALUES
(201, 'Quiz 1', 50),
(201, 'Midterm', 100),
(201, 'Final', 100),
(203, 'Midterm', 100),
(203, 'Final', 100),
(204, 'Midterm', 100),
(204, 'Final', 100),
(202, 'Project', 100),
(205, 'Midterm', 100),
(206, 'Final', 100),
(207, 'Lab', 50),
(208, 'Final', 100);

-- Scores for Intro to SQL (201) : test_ids will be 1..3 in insert order
-- We assume auto-increment IDs start at 1 in the order above.
INSERT INTO scores(test_id, student_id, score) VALUES
-- Quiz 1 (test_id=1)
(1,101,45),(1,102,40),(1,103,48),(1,105,50),(1,109,38),(1,110,35),
-- Midterm (test_id=2)
(2,101,88),(2,102,76),(2,103,92),(2,105,96),(2,109,70),(2,110,73),
-- Final (test_id=3)
(3,101,94),(3,102,80),(3,103,95),(3,105,98),(3,109,78),(3,110,81);

-- Scores for Linear Algebra (203): test_ids=4..5
INSERT INTO scores(test_id, student_id, score) VALUES
(4,101,86),(4,103,89),(4,109,84),
(5,101,92),(5,103,88),(5,109,90);

-- Scores for Calculus I (204): test_ids=6..7
INSERT INTO scores(test_id, student_id, score) VALUES
(6,101,90),(6,104,72),
(7,101,93),(7,104,75);

-- Data Structures (202): test_id=8
INSERT INTO scores(test_id, student_id, score) VALUES
(8,103,95),(8,110,88);

-- Accounting 101 (205): test_id=9
INSERT INTO scores(test_id, student_id, score) VALUES
(9,102,82),(9,106,75);

-- Microeconomics (206): test_id=10
INSERT INTO scores(test_id, student_id, score) VALUES
(10,105,91),(10,106,78);

-- Classical Mechanics (207): test_id=11
INSERT INTO scores(test_id, student_id, score) VALUES
(11,104,45),(11,107,48);

-- Electromagnetism (208): test_id=12
INSERT INTO scores(test_id, student_id, score) VALUES
(12,108,87);
