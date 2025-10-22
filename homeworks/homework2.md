Using mysql database, Very Basic Data Modeling and some queries: Create a simple database requirement: let's say in 5 lines of english sentences. Then map these requirements to a very simple relational database model: come up with 2 to 3 tables, then provide 10 sql queries (5 simple and 5 intermediate)

Perfect exercise 👌 This will demonstrate how to go from requirements → data model → SQL queries. I’ll keep it very basic and beginner-friendly.

⸻

📘 Step 1. Requirements (in 5 simple sentences)
    1.    A company has departments (like IT, HR, Finance).
    2.    Each department has many employees.
    3.    Every employee has a name, salary, and department.
    4.    Employees can work on projects.
    5.    A project can have many employees assigned to it.

⸻

📘 Step 2. Simple Relational Data Model

From the requirements, we can design 3 tables:
    •    departments (department_id, dept_name)
    •    employees (employee_id, name, salary, department_id)
    •    projects (project_id, project_name)
    •    employee_projects (employee_id, project_id) ← junction table for many-to-many

⸻

📘 Step 3. SQL: Create Tables

CREATE DATABASE company_db;
USE company_db;

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10,2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(50)
);

CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);


⸻

📘 Step 4. Insert Sample Data

-- Departments
INSERT INTO departments (dept_name) VALUES
('IT'), ('HR'), ('Finance');

-- Employees
INSERT INTO employees (name, salary, department_id) VALUES
('Alice Johnson', 60000, 1),
('Bob Smith', 55000, 1),
('Charlie Davis', 50000, 2),
('Diana Evans', 65000, 3),
('Ethan Brown', 62000, 1);

-- Projects
INSERT INTO projects (project_name) VALUES
('Website Upgrade'),
('Payroll System'),
('Recruitment Drive');

-- Employee Projects
INSERT INTO employee_projects VALUES
(1, 1), -- Alice works on Website Upgrade
(2, 1), -- Bob works on Website Upgrade
(2, 2), -- Bob works on Payroll System
(3, 3), -- Charlie works on Recruitment Drive
(4, 2), -- Diana works on Payroll System
(5, 1); -- Ethan works on Website Upgrade


⸻

📘 Step 5. SQL Queries

🟢 5 Simple Queries
    1.    Show all employees.

SELECT * FROM employees;

    2.    List all departments.

SELECT * FROM departments;

    3.    Find employees in the IT department.

SELECT name FROM employees
WHERE department_id = 1;

    4.    Show employees earning more than 55,000.

SELECT name, salary FROM employees
WHERE salary > 55000;

    5.    Show all projects.

SELECT * FROM projects;


⸻

🟡 5 Intermediate Queries
    6.    Count how many employees are in each department.

SELECT d.dept_name, COUNT(e.employee_id) AS total_employees
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.dept_name;

    7.    Find the average salary per department.

SELECT d.dept_name, AVG(e.salary) AS avg_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.dept_name;

    8.    List employees working on the “Website Upgrade” project.

SELECT e.name
FROM employees e
JOIN employee_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON ep.project_id = p.project_id
WHERE p.project_name = 'Website Upgrade';

    9.    Find all projects and the number of employees assigned to each.

SELECT p.project_name, COUNT(ep.employee_id) AS total_employees
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY p.project_name;

    10.    Find the highest salary in the company and which employee earns it.

SELECT name, salary
FROM employees
ORDER BY salary DESC
LIMIT 1;


⸻

✅ This exercise walks students through:
    •    English requirements
    •    Mapping to relational model
    •    Writing CREATE TABLE statements
    •    Inserting sample data
    •    Running simple and intermediate queries

Would you like me to format this into a student homework sheet in Markdown (with separate student & instructor versions), like we did for the insurance homework?

