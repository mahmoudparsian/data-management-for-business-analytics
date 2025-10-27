# SEER Breast Cancer Dataset (No-Spaces Columns) — 60 SQL Queries

Assume the table name is **seer_breast_cancer** and columns are exactly:
`age, race, marital_status, x, t_stage, n_stage, sixth_6_stage, grade, a_stage, tumor_size, estrogen_status, progesterone_status, regional_node_examined, reginol_node_positive, survival_months, status`.

---
## 1) Basic (1–20)

1. Show all rows  
```sql
SELECT * FROM seer_breast_cancer;
```
2. Only age and status  
```sql
SELECT age, status FROM seer_breast_cancer;
```
3. Total number of patients  
```sql
SELECT COUNT(*) FROM seer_breast_cancer;
```
4. Distinct races  
```sql
SELECT COUNT(DISTINCT race) AS distinct_races FROM seer_breast_cancer;
```
5. List unique marital statuses  
```sql
SELECT DISTINCT marital_status FROM seer_breast_cancer;
```
6. Patients older than 60  
```sql
SELECT * FROM seer_breast_cancer WHERE age > 60;
```
7. Patients who survived > 60 months  
```sql
SELECT * FROM seer_breast_cancer WHERE survival_months > 60;
```
8. Alive vs Dead counts  
```sql
SELECT status, COUNT(*) AS cnt FROM seer_breast_cancer GROUP BY status;
```
9. Youngest and oldest patient  
```sql
SELECT MIN(age) AS min_age, MAX(age) AS max_age FROM seer_breast_cancer;
```
10. Tumor size > 50  
```sql
SELECT * FROM seer_breast_cancer WHERE tumor_size > 50;
```
11. ER+/PR+ patients  
```sql
SELECT * 
FROM seer_breast_cancer 
WHERE estrogen_status='Positive' AND progesterone_status='Positive';
```
12. Count by T stage  
```sql
SELECT t_stage, COUNT(*) AS cnt FROM seer_breast_cancer GROUP BY t_stage;
```
13. Count by N stage  
```sql
SELECT n_stage, COUNT(*) AS cnt FROM seer_breast_cancer GROUP BY n_stage;
```
14. Average tumor size (overall)  
```sql
SELECT AVG(tumor_size) AS avg_tumor FROM seer_breast_cancer;
```
15. Average tumor size by grade  
```sql
SELECT grade, AVG(tumor_size) AS avg_tumor 
FROM seer_breast_cancer
GROUP BY grade;
```
16. Count by race  
```sql
SELECT race, COUNT(*) AS cnt FROM seer_breast_cancer GROUP BY race;
```
17. Alive vs Dead by race  
```sql
SELECT race, status, COUNT(*) AS cnt 
FROM seer_breast_cancer 
GROUP BY race, status;
```
18. Alive vs Dead by marital_status  
```sql
SELECT marital_status, status, COUNT(*) AS cnt 
FROM seer_breast_cancer 
GROUP BY marital_status, status;
```
19. Average age by status  
```sql
SELECT status, AVG(age) AS avg_age 
FROM seer_breast_cancer 
GROUP BY status;
```
20. Average tumor size by status  
```sql
SELECT status, AVG(tumor_size) AS avg_tumor 
FROM seer_breast_cancer 
GROUP BY status;
```

---
## 2) Intermediate (21–40)

21. Patients with Grade III in text  
```sql
SELECT * FROM seer_breast_cancer WHERE grade LIKE '%Grade III%';
```
22. Survival < 12 months  
```sql
SELECT * FROM seer_breast_cancer WHERE survival_months < 12;
```
23. Count by sixth_6_stage  
```sql
SELECT sixth_6_stage, COUNT(*) AS cnt 
FROM seer_breast_cancer 
GROUP BY sixth_6_stage;
```
24. Count by a_stage  
```sql
SELECT a_stage, COUNT(*) AS cnt 
FROM seer_breast_cancer 
GROUP BY a_stage;
```
25. Top 10 by tumor_size  
```sql
SELECT * 
FROM seer_breast_cancer 
ORDER BY tumor_size DESC 
LIMIT 10;
```
26. reginol_node_positive > 10  
```sql
SELECT * 
FROM seer_breast_cancer 
WHERE reginol_node_positive > 10;
```
27. reginol_node_positive = 0  
```sql
SELECT * 
FROM seer_breast_cancer 
WHERE reginol_node_positive = 0;
```
28. Avg survival by grade  
```sql
SELECT grade, AVG(survival_months) AS avg_survival 
FROM seer_breast_cancer 
GROUP BY grade;
```
29. Avg survival by t_stage  
```sql
SELECT t_stage, AVG(survival_months) AS avg_survival 
FROM seer_breast_cancer 
GROUP BY t_stage;
```
30. Avg survival by n_stage  
```sql
SELECT n_stage, AVG(survival_months) AS avg_survival 
FROM seer_breast_cancer 
GROUP BY n_stage;
```
31. Survival distribution by grade  
```sql
SELECT grade, status, COUNT(*) AS cnt 
FROM seer_breast_cancer 
GROUP BY grade, status;
```
32. Estrogen Negative  
```sql
SELECT * FROM seer_breast_cancer WHERE estrogen_status='Negative';
```
33. Progesterone Negative  
```sql
SELECT * FROM seer_breast_cancer WHERE progesterone_status='Negative';
```
34. 5 youngest who died  
```sql
SELECT * 
FROM seer_breast_cancer 
WHERE status='Dead' 
ORDER BY age ASC 
LIMIT 5;
```
35. 5 oldest who are alive  
```sql
SELECT * 
FROM seer_breast_cancer 
WHERE status='Alive' 
ORDER BY age DESC 
LIMIT 5;
```
36. Avg tumor_size by race & status  
```sql
SELECT race, status, AVG(tumor_size) AS avg_tumor 
FROM seer_breast_cancer 
GROUP BY race, status;
```
37. Avg survival by race & marital_status  
```sql
SELECT race, marital_status, AVG(survival_months) AS avg_survival 
FROM seer_breast_cancer 
GROUP BY race, marital_status;
```
38. Above-grade-average tumor_size (correlated)  
```sql
SELECT s1.* 
FROM seer_breast_cancer s1
WHERE tumor_size > (
  SELECT AVG(tumor_size) 
  FROM seer_breast_cancer s2 
  WHERE s2.grade = s1.grade
);
```
39. Above-status-average survival_months (correlated)  
```sql
SELECT s1.* 
FROM seer_breast_cancer s1
WHERE survival_months > (
  SELECT AVG(survival_months) 
  FROM seer_breast_cancer s2 
  WHERE s2.status = s1.status
);
```
40. Survival < 6 months  
```sql
SELECT * FROM seer_breast_cancer WHERE survival_months < 6;
```

---
## 3) Advanced (41–60) — WITH + Window Functions

41. Rank tumor_size within each grade  
```sql
SELECT age, grade, tumor_size,
       RANK() OVER (PARTITION BY grade ORDER BY tumor_size DESC) AS rnk
FROM seer_breast_cancer;
```
42. Top 3 by survival per race (WITH + RANK)  
```sql
WITH ranked AS (
  SELECT age, race, survival_months,
         RANK() OVER (PARTITION BY race ORDER BY survival_months DESC) AS rnk
  FROM seer_breast_cancer
)
SELECT * FROM ranked WHERE rnk <= 3;
```
43. Avg survival by ER/PR combo  
```sql
SELECT estrogen_status, progesterone_status, AVG(survival_months) AS avg_survival
FROM seer_breast_cancer
GROUP BY estrogen_status, progesterone_status;
```
44. Tumor_size > 30 grouped by status  
```sql
SELECT status, COUNT(*) AS cnt
FROM seer_breast_cancer
WHERE tumor_size > 30
GROUP BY status;
```
45. Avg survival by marital_status  
```sql
SELECT marital_status, AVG(survival_months) AS avg_survival
FROM seer_breast_cancer 
GROUP BY marital_status;
```
46. Top 5 by regional_node_examined  
```sql
SELECT * 
FROM seer_breast_cancer 
ORDER BY regional_node_examined DESC 
LIMIT 5;
```
47. regional_node_examined > reginol_node_positive * 2  
```sql
SELECT * 
FROM seer_breast_cancer 
WHERE regional_node_examined > reginol_node_positive * 2;
```
48. Age above race average (correlated)  
```sql
SELECT s1.* 
FROM seer_breast_cancer s1
WHERE age > (
  SELECT AVG(age) 
  FROM seer_breast_cancer s2 
  WHERE s2.race = s1.race
);
```
49. Below-median survival (approx via middle values)  
```sql
SELECT * 
FROM seer_breast_cancer 
WHERE survival_months < (
  SELECT AVG(survival_months) 
  FROM (
    SELECT survival_months 
    FROM seer_breast_cancer 
    ORDER BY survival_months
    LIMIT 2 OFFSET (SELECT COUNT(*)/2 FROM seer_breast_cancer)
  ) AS mid
);
```
50. Avg age/tumor_size/survival by status  
```sql
SELECT status, AVG(age) AS avg_age, AVG(tumor_size) AS avg_tumor, AVG(survival_months) AS avg_survival
FROM seer_breast_cancer
GROUP BY status;
```
51. Grade with highest avg survival  
```sql
SELECT grade, AVG(survival_months) AS avg_survival
FROM seer_breast_cancer
GROUP BY grade
ORDER BY avg_survival DESC
LIMIT 1;
```
52. Race with highest avg tumor_size  
```sql
SELECT race, AVG(tumor_size) AS avg_tumor
FROM seer_breast_cancer
GROUP BY race
ORDER BY avg_tumor DESC
LIMIT 1;
```
53. Survival above race average (correlated)  
```sql
SELECT s1.* 
FROM seer_breast_cancer s1
WHERE survival_months > (
  SELECT AVG(survival_months) 
  FROM seer_breast_cancer s2 
  WHERE s2.race = s1.race
);
```
54. Avg reginol_node_positive by status  
```sql
SELECT status, AVG(reginol_node_positive) AS avg_pos
FROM seer_breast_cancer
GROUP BY status;
```
55. Survival less than grade average (correlated)  
```sql
SELECT s1.* 
FROM seer_breast_cancer s1
WHERE survival_months < (
  SELECT AVG(survival_months) 
  FROM seer_breast_cancer s2 
  WHERE s2.grade = s1.grade
);
```
56. Top 3 grades by avg tumor_size  
```sql
SELECT grade, AVG(tumor_size) AS avg_tumor
FROM seer_breast_cancer
GROUP BY grade
ORDER BY avg_tumor DESC
LIMIT 3;
```
57. Top 3 t_stage by avg survival  
```sql
SELECT t_stage, AVG(survival_months) AS avg_survival
FROM seer_breast_cancer
GROUP BY t_stage
ORDER BY avg_survival DESC
LIMIT 3;
```
58. tumor_size above overall average  
```sql
SELECT * 
FROM seer_breast_cancer
WHERE tumor_size > (SELECT AVG(tumor_size) FROM seer_breast_cancer);
```
59. age below overall average  
```sql
SELECT * 
FROM seer_breast_cancer
WHERE age < (SELECT AVG(age) FROM seer_breast_cancer);
```
60. Compare avg tumor_size vs avg survival by status  
```sql
SELECT status, AVG(tumor_size) AS avg_tumor, AVG(survival_months) AS avg_survival
FROM seer_breast_cancer
GROUP BY status;
```
