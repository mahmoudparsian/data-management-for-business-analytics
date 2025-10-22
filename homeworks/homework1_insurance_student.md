# 📝 MySQL 101 Homework: Insurance Table

## Step 1. Create the Table
```sql
CREATE TABLE insurance (
    policy_id INT AUTO_INCREMENT PRIMARY KEY,
    holder_name VARCHAR(50),
    insurance_type VARCHAR(30),   -- e.g. Health, Auto, Home
    premium DECIMAL(10,2),
    start_date DATE
);
```

---

## Step 2. Insert Sample Data
```sql
INSERT INTO insurance (holder_name, insurance_type, premium, start_date) 
VALUES
('Alice Johnson', 'Health', 350.00, '2024-01-10'),
('Bob Smith', 'Auto', 200.00, '2024-02-15'),
('Charlie Davis', 'Home', 500.00, '2024-03-01'),
('Diana Evans', 'Health', 375.00, '2024-01-20'),
('Ethan Brown', 'Auto', 220.00, '2024-03-15'),
('Fiona Clark', 'Home', 480.00, '2024-04-01'),
('George Lewis', 'Health', 340.00, '2024-02-05'),
('Hannah Adams', 'Auto', 210.00, '2024-01-25'),
('Ian Wilson', 'Home', 510.00, '2024-03-10'),
('Jane Miller', 'Health', 360.00, '2024-02-18');
```

---

## Part A: Basic Queries (Write the SQL)

1. Show all insurance records.  
2. Show only holder names and insurance types.  
3. Find all **Health insurance** policies.  
4. Show all policies sorted by **premium (highest first)**.  
5. Find policies that started in **March 2024**.  

---

## Part B: Intermediate Queries (Write the SQL)

6. Count how many policies exist in total.  
7. Find the **average premium** for all policies.  
8. Show the **highest premium** among all policies.  
9. Find the **number of policies per insurance type**.  
10. Find the **average premium per insurance type**.  
