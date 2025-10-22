# 🗝️ MySQL 101 Homework: Insurance Table (Answer Key)

## Part A: Basic Queries
```sql
-- Q1
SELECT * 
FROM insurance;

-- Q2
SELECT holder_name, insurance_type 
FROM insurance;

-- Q3
SELECT * 
FROM insurance
WHERE insurance_type = 'Health';

-- Q4
SELECT * 
FROM insurance
ORDER BY premium DESC;

-- Q5
SELECT * 
FROM insurance
WHERE start_date BETWEEN '2024-03-01' AND '2024-03-31';
```

---

## Part B: Intermediate Queries
```sql
-- Q6
SELECT COUNT(*) AS total_policies 
FROM insurance;

-- Q7
SELECT AVG(premium) AS avg_premium 
FROM insurance;

-- Q8
SELECT MAX(premium) AS highest_premium 
FROM insurance;

-- Q9
SELECT insurance_type, COUNT(*) AS total
FROM insurance
GROUP BY insurance_type;

-- Q10
SELECT insurance_type, AVG(premium) AS avg_premium
FROM insurance
GROUP BY insurance_type;
```
