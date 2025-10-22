# 📝 Homework 2: Very Basic Data Modeling

## Requirements (in plain English)
1. A company has **departments** (like IT, HR, Finance).  
2. Each department has **many employees**.  
3. Every employee has a **name, salary, and department**.  
4. Employees can work on **projects**.  
5. A project can have **many employees assigned** to it.  

---

## Data Model (Relational Tables)

- **departments** (department_id, dept_name)  
- **employees** (employee_id, name, salary, department_id)  
- **projects** (project_id, project_name)  
- **employee_projects** (employee_id, project_id)  

---

## Tasks

### Part A: Simple Queries (Write the SQL)
1. Show all employees.  
2. List all departments.  
3. Find employees in the **IT department**.  
4. Show employees earning **more than 55,000**.  
5. Show all projects.  

### Part B: Intermediate Queries (Write the SQL)
6. Count how many employees are in each department.  
7. Find the **average salary** per department.  
8. List employees working on the **“Website Upgrade”** project.  
9. Find all projects and the **number of employees** assigned to each.  
10. Find the **highest salary** in the company and which employee earns it.  
