# Insurance Table SQL Practice

	The goal of this homework/lab is to
	load some insurance data into MySQL
	table and perform some data analytics.
	

## 1. Data Download

```
file name: insurance_1338_records.csv
```


this file can be dowloaded from

```
https://github.com/mahmoudparsian/data-management-for-business-analytics/blob/main/data/insurance_1338_records.csv
```

## 2. Table Schema

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

## 3. Load Data Using MySQL Workbench

	Load data into MySQL table named insurance
	by using MySQL Workbench.



## 4. Instructions to Load CSV from Command Line:

```sql
-- First, make sure LOCAL INFILE is enabled in MySQL server.
-- Place your insurance.csv file in a known path, 
   e.g., /path/to/insurance_1338_records.csv

LOAD DATA LOCAL INFILE '/path/to/insurance_1338_records.csv'
INTO TABLE insurance
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(age, gender, bmi, children, smoker, region, charges);
```


## 5. SQL Practice Queries (basic)


### Q1. Show all rows

```sql
SELECT * 
FROM insurance;
```

### Q2. List ages and charges

```sql
SELECT age, charges 
FROM insurance;
```

### Q3. Find all smokers

```sql
SELECT * 
FROM insurance 
WHERE smoker = 'yes';
```

### Q4. Find all non-smokers

```sql
SELECT * 
FROM insurance 
WHERE smoker = 'no';
```

### Q5. List all unique regions

```sql
SELECT DISTINCT region 
FROM insurance;
```

### Q6. Count total records

solution-1:

```sql
SELECT COUNT(*) 
FROM insurance;
```

solution-2:

```sql
SELECT COUNT(*) AS total_records
FROM insurance;
```

### Q7. Find people with BMI > 30

```sql
SELECT * 
FROM insurance 
WHERE bmi > 30;
```

### Q8. Find people with children > 2

```sql
SELECT * 
FROM insurance 
WHERE children > 2;
```

### Q9. Find females with charges > 10000

```sql
SELECT * 
FROM insurance 
WHERE (gender = 'female') AND 
      (charges > 10000);
```

### Q10. Find males younger than 25

```sql
SELECT * 
FROM insurance 
WHERE (gender = 'male') AND 
      (age < 25);
```

### Q11. Find top 5 highest charges

```sql
SELECT * 
FROM insurance 
ORDER BY charges DESC 
LIMIT 5;
```

### Q12. Find top 5 lowest charges

```sql
SELECT * 
FROM insurance 
ORDER BY charges ASC 
LIMIT 5;
```

### Q13. Find average BMI

solution-1:

```sql
SELECT AVG(bmi) 
FROM insurance;
```

solution-2:

```sql
SELECT AVG(bmi) AS avg_bmi
FROM insurance;
```

### Q14. Find maximum charges

solution-1:

```sql
SELECT MAX(charges) 
FROM insurance;
```

solution-2:

```sql
SELECT MAX(charges) AS maximum_charges
FROM insurance;
```

### Q15. Find minimum charges

solution-1:

```sql
SELECT MIN(charges) 
FROM insurance;
```

solution-2:

```sql
SELECT MIN(charges) AS minimum_charges
FROM insurance;
```

### Q16. Count smokers

solution-1:

```sql
SELECT COUNT(*) 
FROM insurance 
WHERE smoker = 'yes';
```

solution-2:

```sql
SELECT COUNT(*) AS smokers_count
FROM insurance 
WHERE smoker = 'yes';
```

### Q17. Count non-smokers

solution-1:

```sql
SELECT COUNT(*) 
FROM insurance 
WHERE smoker = 'no';
```

solution-2:

```sql
SELECT COUNT(*) AS non_smokers_count
FROM insurance 
WHERE smoker = 'no';
```

### Q18. Average charges for smokers

solution-1:

```sql
SELECT AVG(charges) 
FROM insurance 
WHERE smoker = 'yes';
```

solution-2:

```sql
SELECT AVG(charges) AS avg_charges_for_smokers
FROM insurance 
WHERE smoker = 'yes';
```
### Q19. Average charges for non-smokers

solution-1:

```sql
SELECT AVG(charges) 
FROM insurance 
WHERE smoker = 'no';
```

solution-2:

```sql
SELECT AVG(charges) AS avg_charges_for_non_smokers
FROM insurance 
WHERE smoker = 'no';
```
### Q20. Find all records from southeast

```sql
SELECT * 
FROM insurance 
WHERE region='southeast';
```

### Q21. Find average age of females

solution-1:

```sql
SELECT AVG(age) 
FROM insurance 
WHERE gender = 'female';
```

solution-2:

```sql
SELECT AVG(age) as avg_age_females
FROM insurance 
WHERE gender = 'female';
```

### Q22. Find average age of males

solution-1:

```sql
SELECT AVG(age) 
FROM insurance 
WHERE gender = 'male';
```

solution-2:

```sql
SELECT AVG(age) AS average_age_of_males
FROM insurance 
WHERE gender = 'male';
```

### Q23. Find people with charges between 5000 and 10000

solution-1:

```sql
SELECT * 
FROM insurance 
WHERE charges BETWEEN 5000 AND 10000;
```

solution-2:

```sql
SELECT * 
FROM insurance 
WHERE (charges >= 5000)  AND 
      (charges <= 10000);
```

### Q24. Find distinct BMI values

```sql
SELECT DISTINCT bmi 
FROM insurance;
```

### Q25. Find people with exactly 2 children

```sql
SELECT * 
FROM insurance 
WHERE children = 2;
```

### Q26. Find youngest person

```sql
SELECT * 
FROM insurance 
ORDER BY age ASC 
LIMIT 1;
```

### Q27. Find oldest person

```sql
SELECT * 
FROM insurance 
ORDER BY age DESC 
LIMIT 1;
```

### Q28. Find average charges per region

solution-1:

```sql
SELECT region, AVG(charges) 
FROM insurance 
GROUP BY region;
```

solution-2:

```sql
SELECT region, AVG(charges) AS average_charges_per_region
FROM insurance 
GROUP BY region;
```

### Q29. Find average BMI per gender

solution-1:

```sql
SELECT gender, AVG(bmi) 
FROM insurance 
GROUP BY gender;
```

solution-2:

```sql
SELECT gender, AVG(bmi) AS avg_BMI_per_gender
FROM insurance 
GROUP BY gender;
```

### Q30. Find total charges per region

solution-1:

```sql
SELECT region, SUM(charges) 
FROM insurance 
GROUP BY region;
```

solution-2:

```sql
SELECT region, SUM(charges) AS total_charges_per_region
FROM insurance 
GROUP BY region;
```



### Q31. List all records where the person is a smoker.

```sql
SELECT * 
FROM insurance
WHERE smoker = 'yes';
```

### Q32. Get the average BMI of all individuals.

```sql
SELECT AVG(bmi) AS average_bmi
FROM insurance;
```

### Q33. Count how many individuals are from each region.

```sql
SELECT region, 
       COUNT(*) AS count
FROM insurance
GROUP BY region;
```

### Q34. Find the maximum charges for a female individual.

```sql
SELECT MAX(charges) AS max_female_charges
FROM insurance
WHERE sex = 'female';
```


