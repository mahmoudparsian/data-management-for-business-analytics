# Intermediate and Advanced Queries

## 1. Table Schema

```sql
CREATE TABLE insurance (
    age INT,
    gender VARCHAR(10),
    bmi DECIMAL(5,2),
    children INT,
    smoker VARCHAR(5),
    region VARCHAR(20),
    charges DECIMAL(10,2)
);
```

Given the following relational table: insurance with the following 7 columns:

~~~
age,
gender,
bmi,
children,
smoker,
region,
charges
~~~

The sample records are (first line is header):

~~~
age gender  bmi    children  smoker region     charges
19  female  27.9    0         yes    southwest  16884.924
18  male    33.77   1         no     southeast  1725.5523
28  male    33      3         no     southeast  4449.462
~~~

1. Create schema in MySQL

2. give instructions to load data into mysql table
   using LOAD LOCAL
   
3. provide 30 English/SQL queries from very basic, to basic to intermediate 

4. provide sql 10 queries using group by and simple ranking functions and sub-queries

All in one single downloadable file : all format is markdown format




### Q1. Find region with highest average charges

```sql
SELECT region, AVG(charges) as avg_charges 
FROM insurance 
GROUP BY region 
ORDER BY avg_charges DESC 
LIMIT 1;
```


### Q2. Find gender with lowest average BMI

```sql
SELECT gender, AVG(bmi) as avg_bmi 
FROM insurance 
GROUP BY gender 
ORDER BY avg_bmi ASC 
LIMIT 1;
```


### Q3. Rank regions by total charges

```sql
SELECT region, 
       SUM(charges) as total_charges, 
       RANK() OVER (ORDER BY SUM(charges) DESC) as rnk
FROM insurance 
GROUP BY region;
```


### Q4. Rank genders by average charges

```sql
SELECT gender, 
       AVG(charges) as avg_charges, 
       DENSE_RANK() OVER (ORDER BY AVG(charges) DESC) as rnk 
FROM insurance 
GROUP BY gender;
```


### Q5. Find top 3 regions with highest average BMI

```sql
SELECT region, AVG(bmi) as avg_bmi 
FROM insurance 
GROUP BY region 
ORDER BY avg_bmi DESC 
LIMIT 3;
```


### Q6. Find second highest charges

```sql
WITH ranked AS
(
  SELECT charges, 
         DENSE_RANK() OVER (ORDER BY charges DESC) as rnk 
  FROM insurance
)
SELECT charges 
FROM ranked 
WHERE rnk = 2;
```


### Q7. Find smokers paying above average charges

```sql
SELECT * 
FROM insurance 
WHERE (smoker = 'yes') AND 
      charges > (SELECT AVG(charges) FROM insurance);
```


### Q8. Find non-smokers paying below average charges

```sql
SELECT * 
FROM insurance 
WHERE (smoker = 'no') AND 
      charges < (SELECT AVG(charges) FROM insurance);
```


### Q9. Find average charges by (gender, smoker)

```sql
SELECT gender, smoker, AVG(charges) AS avg_charges
FROM insurance 
GROUP BY gender, smoker;
```


### Q10. Find top 5 youngest people with highest charges

```sql
SELECT * 
FROM insurance 
ORDER BY age ASC, charges DESC 
LIMIT 5;
```



### Q11. Using SQL, find the charges for customers in the southwest and southeast regions


### Q12. Using SQL, find the distribution of charges for customers in each region based on gender ('male', 'female')



### Q13. Using SQL, create the following result:

~~~
+-------------+----------------------------------------+
| age_group   | average_charge                         |
+-------------+----------------------------------------+
|  0-19       | average-charge for age_group of 0-19   |
|  20-40      | average-charge for age_group of 20-40  |
|  41-60      | average-charge for age_group of 41-60  |
|  61-70      | average-charge for age_group of 61-70  |
|  70+        | average-charge for age_group of 70+    |
+-------------+----------------------------------------+
~~~

Query:

~~~sql
SELECT 
    CASE 
        WHEN age BETWEEN 0  AND 19 THEN '0-19'
        WHEN age BETWEEN 20 AND 40 THEN '20-40'
        WHEN age BETWEEN 41 AND 60 THEN '41-60'
        WHEN age BETWEEN 61 AND 70 THEN '61-70'
        ELSE '70+'
    END AS age_group,
    AVG(charges) AS average_charge
FROM insurance
GROUP BY age_group
ORDER BY MIN(age);
~~~


## Sub-Queries based on your `insurance` table.

### 14. Rank charges within each region:**

This query assigns a rank to each insurance charge within its respective region, ordered from highest to lowest.

```sql
SELECT
    age,
    sex,
    bmi,
    children,
    smoker,
    region,
    charges,
    RANK() OVER (PARTITION BY region ORDER BY charges DESC) as region_charge_rank
FROM insurance;
```

### 15. Find the top 3 highest charges overall:

This query first ranks all insurance charges from highest to lowest and then uses a subquery to select only the top 3 records.

```sql
WITH AS ranked_charges AS
(  SELECT
        age,
        sex,
        bmi,
        children,
        smoker,
        region,
        charges,
        RANK() OVER (ORDER BY charges DESC) as overall_charge_rank
   FROM insurance
) 
SELECT
    age,
    sex,
    bmi,
    children,
    smoker,
    region,
    charges,
    overall_charge_rank
FROM ranked_charges
WHERE overall_charge_rank <= 3;
```

### 16. Rank BMI within each smoking status

This query ranks individuals based on their BMI within their respective smoking categories (smoker or non-smoker).

```sql
SELECT
    age,
    sex,
    bmi,
    children,
    smoker,
    region,
    charges,
    DENSE_RANK() OVER (PARTITION BY smoker ORDER BY bmi DESC) 
      as smoker_bmi_rank
FROM insurance;
```

### 17. Identify the charge that is in the top 50% within its region:

This query uses the `NTILE` function to divide the charges within each region into two equal groups (50%). It then selects the records that fall into the first group (representing the top 50%).

```sql
SELECT
    age,
    sex,
    bmi,
    children,
    smoker,
    region,
    charges
FROM (
    SELECT
        age,
        sex,
        bmi,
        children,
        smoker,
        region,
        charges,
        NTILE(2) OVER (PARTITION BY region ORDER BY charges DESC) as charge_quartile
    FROM insurance
) AS charge_groups
WHERE charge_quartile = 1;
```


### 18. Rank Individuals by Charges

This query assigns a rank to each individual based on 
their `charges` in descending order.

```sql
SELECT 
    age, 
    sex, 
    bmi, 
    charges,
    RANK() OVER (ORDER BY charges DESC) AS rank_by_charges
FROM 
    insurance;
```

### 19. Find the Top N Most Expensive Charges for Smokers

Using a sub-query, this identifies the top 3 most 
expensive charges among smokers.

```sql
SELECT * 
FROM (
    SELECT 
        age, 
        sex, 
        bmi, 
        charges,
        RANK() OVER (PARTITION BY smoker ORDER BY charges DESC) AS rank_by_smoker
    FROM 
        insurance
    WHERE smoker = 'yes'
) ranked_smokers
WHERE rank_by_smoker <= 3;
```

### 20. Average Charges per Region, Ranked

This query calculates the average charges per region 
and ranks the regions by average charges.

```sql
SELECT 
    region, 
    AVG(charges) AS avg_charges,
    DENSE_RANK() OVER (ORDER BY AVG(charges) DESC) AS rank_by_region
FROM 
    insurance
GROUP BY 
    region;
```

### 21. Find the Oldest Person in Each Region
Here, we use a sub-query to find the oldest person in each region.

```sql
SELECT 
    region, 
    age, 
    sex, 
    charges
FROM (
    SELECT 
        region, 
        age, 
        sex, 
        charges, 
        ROW_NUMBER() OVER (PARTITION BY region ORDER BY age DESC) AS row_num
    FROM 
        insurance
) ranked_by_region
WHERE 
    row_num = 1;
```


### 22. Find the average charges grouped by smoker status and sex.
```sql
SELECT smoker, 
       sex, 
       AVG(charges) AS avg_charges
FROM insurance
GROUP BY smoker, sex;
```

### 23. List individuals whose charges are above the overall average

```sql
SELECT *
FROM insurance
WHERE charges > (SELECT AVG(charges) FROM insurance);
```

### 24. Get the number of children per smoker group.

```sql
SELECT smoker, SUM(children) AS total_children
FROM insurance
GROUP BY smoker;
```

### 25. List all individuals who have the highest charges in their region.

```sql
SELECT *
FROM insurance i
WHERE charges = (
  SELECT MAX(charges)
  FROM insurance
  WHERE region = i.region
);
```

---

## 🔶 Complex Queries

### 26. Rank individuals within each region based on their charges (highest to lowest).


```sql
SELECT *,
       RANK() OVER (PARTITION BY region ORDER BY charges DESC) 
        AS charge_rank
FROM insurance;
```

### 27. Find the top 3 individuals with the highest charges in each region.

```sql
SELECT *
FROM (
  SELECT *,
         RANK() OVER (PARTITION BY region ORDER BY charges DESC) 
           AS rnk
  FROM insurance
) ranked
WHERE rnk <= 3;
```

### 28. Calculate the average charges for individuals grouped by age group: `<30`, `30–50`, and `>50`.

```sql
SELECT age_group, AVG(charges) AS avg_charge
FROM (
  SELECT *,
         CASE
           WHEN age < 30 THEN '<30'
           WHEN age BETWEEN 30 AND 50 THEN '30-50'
           ELSE '>50'
         END AS age_group
  FROM insurance
) age_groups
GROUP BY age_group;
```

### 29. List individuals who pay more than the average charge for their age group

```sql
SELECT *
FROM (
  SELECT *,
         AVG(charges) OVER (PARTITION BY 
           CASE 
             WHEN age < 30 THEN '<30'
             WHEN age BETWEEN 30 AND 50 THEN '30-50'
             ELSE '>50'
           END
         ) AS avg_group_charge
  FROM insurance
) grouped
WHERE charges > avg_group_charge;
```

---


