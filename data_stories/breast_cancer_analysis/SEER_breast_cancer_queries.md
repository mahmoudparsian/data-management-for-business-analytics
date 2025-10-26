# SEER Breast Cancer Dataset SQL Queries

The table is assumed to be named **seer_breast_cancer**.

---
## 1. Basic Queries (1–15)

1. Show all records.
```sql
SELECT * FROM seer_breast_cancer;
```
2. Show only Age and Status.
```sql
SELECT Age, Status FROM seer_breast_cancer;
```
3. Count total number of patients.
```sql
SELECT COUNT(*) FROM seer_breast_cancer;
```
4. Count distinct races.
```sql
SELECT COUNT(DISTINCT Race) FROM seer_breast_cancer;
```
5. List all unique marital statuses.
```sql
SELECT DISTINCT `Marital Status` FROM seer_breast_cancer;
```
6. Get all patients older than 60.
```sql
SELECT * FROM seer_breast_cancer WHERE Age > 60;
```
7. Show patients who survived more than 5 years (60 months).
```sql
SELECT * FROM seer_breast_cancer WHERE `Survival Months` > 60;
```
8. Count how many patients are Alive vs Dead.
```sql
SELECT Status, COUNT(*) FROM seer_breast_cancer GROUP BY Status;
```
9. Find youngest and oldest patient.
```sql
SELECT MIN(Age), MAX(Age) FROM seer_breast_cancer;
```
10. Patients with Tumor Size > 50.
```sql
SELECT * FROM seer_breast_cancer WHERE `Tumor Size` > 50;
```
11. Patients with Estrogen Status = Positive and Progesterone Status = Positive.
```sql
SELECT * FROM seer_breast_cancer WHERE `Estrogen Status`='Positive' AND `Progesterone Status`='Positive';
```
12. Count patients by T Stage.
```sql
SELECT `T Stage`, COUNT(*) FROM seer_breast_cancer GROUP BY `T Stage`;
```
13. Count patients by N Stage.
```sql
SELECT `N Stage`, COUNT(*) FROM seer_breast_cancer GROUP BY `N Stage`;
```
14. Average tumor size overall.
```sql
SELECT AVG(`Tumor Size`) FROM seer_breast_cancer;
```
15. Average tumor size grouped by Grade.
```sql
SELECT Grade, AVG(`Tumor Size`) FROM seer_breast_cancer GROUP BY Grade;
```

---
## 2. Intermediate Queries (16–35)

16. Count patients grouped by Race.
```sql
SELECT Race, COUNT(*) FROM seer_breast_cancer GROUP BY Race;
```
17. Count Alive vs Dead grouped by Race.
```sql
SELECT Race, Status, COUNT(*) FROM seer_breast_cancer GROUP BY Race, Status;
```
18. Count Alive vs Dead grouped by Marital Status.
```sql
SELECT `Marital Status`, Status, COUNT(*) FROM seer_breast_cancer GROUP BY `Marital Status`, Status;
```
19. Average Age by Status.
```sql
SELECT Status, AVG(Age) FROM seer_breast_cancer GROUP BY Status;
```
20. Average Tumor Size grouped by Status.
```sql
SELECT Status, AVG(`Tumor Size`) FROM seer_breast_cancer GROUP BY Status;
```
21. Patients with Grade = 'Poorly differentiated; Grade III'.
```sql
SELECT * FROM seer_breast_cancer WHERE Grade LIKE '%Grade III%';
```
22. Patients with Survival Months < 12 (1 year).
```sql
SELECT * FROM seer_breast_cancer WHERE `Survival Months` < 12;
```
23. Count patients grouped by 6th Stage.
```sql
SELECT `6th Stage`, COUNT(*) FROM seer_breast_cancer GROUP BY `6th Stage`;
```
24. Count patients grouped by A Stage.
```sql
SELECT `A Stage`, COUNT(*) FROM seer_breast_cancer GROUP BY `A Stage`;
```
25. Top 10 patients with largest Tumor Size.
```sql
SELECT * FROM seer_breast_cancer ORDER BY `Tumor Size` DESC LIMIT 10;
```
26. Patients with more than 10 Regional Node Positive.
```sql
SELECT * FROM seer_breast_cancer WHERE `Reginol Node Positive` > 10;
```
27. Patients with no Regional Node Positive.
```sql
SELECT * FROM seer_breast_cancer WHERE `Reginol Node Positive`=0;
```
28. Average Survival Months by Grade.
```sql
SELECT Grade, AVG(`Survival Months`) FROM seer_breast_cancer GROUP BY Grade;
```
29. Average Survival Months by T Stage.
```sql
SELECT `T Stage`, AVG(`Survival Months`) FROM seer_breast_cancer GROUP BY `T Stage`;
```
30. Average Survival Months by N Stage.
```sql
SELECT `N Stage`, AVG(`Survival Months`) FROM seer_breast_cancer GROUP BY `N Stage`;
```
31. Survival distribution (Alive vs Dead) by Grade.
```sql
SELECT Grade, Status, COUNT(*) FROM seer_breast_cancer GROUP BY Grade, Status;
```
32. Patients with Estrogen Negative.
```sql
SELECT * FROM seer_breast_cancer WHERE `Estrogen Status`='Negative';
```
33. Patients with Progesterone Negative.
```sql
SELECT * FROM seer_breast_cancer WHERE `Progesterone Status`='Negative';
```
34. Find top 5 youngest patients who died.
```sql
SELECT * FROM seer_breast_cancer WHERE Status='Dead' ORDER BY Age ASC LIMIT 5;
```
35. Find top 5 oldest patients alive.
```sql
SELECT * FROM seer_breast_cancer WHERE Status='Alive' ORDER BY Age DESC LIMIT 5;
```

---
## 3. Advanced Queries (36–50)

36. Average Tumor Size by Race and Status.
```sql
SELECT Race, Status, AVG(`Tumor Size`) FROM seer_breast_cancer GROUP BY Race, Status;
```
37. Average Survival Months by Race and Marital Status.
```sql
SELECT Race, `Marital Status`, AVG(`Survival Months`) FROM seer_breast_cancer GROUP BY Race, `Marital Status`;
```
38. Patients with Tumor Size above average of their Grade.
```sql
SELECT s1.* FROM seer_breast_cancer s1
WHERE `Tumor Size` > (SELECT AVG(`Tumor Size`) FROM seer_breast_cancer s2 WHERE s2.Grade=s1.Grade);
```
39. Patients with Survival Months above average of their Status group.
```sql
SELECT s1.* FROM seer_breast_cancer s1
WHERE `Survival Months` > (SELECT AVG(`Survival Months`) FROM seer_breast_cancer s2 WHERE s2.Status=s1.Status);
```
40. Rank patients by Tumor Size within each Grade.
```sql
SELECT id, Grade, `Tumor Size`,
       RANK() OVER (PARTITION BY Grade ORDER BY `Tumor Size` DESC) AS rnk
FROM seer_breast_cancer;
```
41. Top 3 patients per Race by Survival Months.
```sql
WITH ranked AS (
  SELECT Age, Race, `Survival Months`,
         RANK() OVER (PARTITION BY Race ORDER BY `Survival Months` DESC) AS rnk
  FROM seer_breast_cancer
)
SELECT * FROM ranked WHERE rnk <= 3;
```
42. Average Survival Months by Estrogen/Progesterone combination.
```sql
SELECT `Estrogen Status`, `Progesterone Status`, AVG(`Survival Months`)
FROM seer_breast_cancer
GROUP BY `Estrogen Status`, `Progesterone Status`;
```
43. Count patients where Tumor Size > 30 grouped by Status.
```sql
SELECT Status, COUNT(*) FROM seer_breast_cancer WHERE `Tumor Size` > 30 GROUP BY Status;
```
44. Compare avg Survival Months of Married vs Single patients.
```sql
SELECT `Marital Status`, AVG(`Survival Months`) FROM seer_breast_cancer GROUP BY `Marital Status`;
```
45. Patients with Survival Months less than 6 months.
```sql
SELECT * FROM seer_breast_cancer WHERE `Survival Months` < 6;
```
46. Top 5 patients with highest Regional Node Examined.
```sql
SELECT * FROM seer_breast_cancer ORDER BY `Regional Node Examined` DESC LIMIT 5;
```
47. Patients where Regional Node Examined > Regional Node Positive * 2.
```sql
SELECT * FROM seer_breast_cancer WHERE `Regional Node Examined` > `Reginol Node Positive`*2;
```
48. Patients whose Age is above average per Race group.
```sql
SELECT s1.* FROM seer_breast_cancer s1
WHERE Age > (SELECT AVG(Age) FROM seer_breast_cancer s2 WHERE s2.Race=s1.Race);
```
49. Patients whose Survival Months is below median overall.
```sql
SELECT * FROM seer_breast_cancer WHERE `Survival Months` < (
  SELECT AVG(`Survival Months`) FROM (
    SELECT `Survival Months` FROM seer_breast_cancer ORDER BY `Survival Months`
    LIMIT 2 OFFSET (SELECT COUNT(*)/2 FROM seer_breast_cancer)
  ) sub
);
```
50. Average Age, Tumor Size, Survival Months grouped by Status.
```sql
SELECT Status, AVG(Age), AVG(`Tumor Size`), AVG(`Survival Months`)
FROM seer_breast_cancer GROUP BY Status;
```
