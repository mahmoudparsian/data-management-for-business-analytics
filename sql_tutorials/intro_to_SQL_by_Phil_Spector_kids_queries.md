# Kids Table: Query Examples

## Schema
```sql
CREATE TABLE kids (
    id INT,
    race VARCHAR(28),
    country VARCHAR(20),
    age DECIMAL(6,3),
    height DECIMAL(7,3),
    weight DECIMAL(7,3),
    sex ENUM('MALE','FEMALE')
);
```

---

# 1. Basic Queries (5)

### **Query 1 — List all kids**

**English:** Retrieve all rows from the table.  

```sql
SELECT * 
FROM kids;
```

### **Query 2 — Find all female kids**

**English:** Return records where sex is FEMALE.  

```sql
SELECT id, race, country, age, height, weight
FROM kids
WHERE sex = 'FEMALE';
```

### **Query 3 — Kids older than 12**

**English:** Get all kids whose age is greater than 12.  

```sql
SELECT id, race, country, age
FROM kids
WHERE age > 12;
```

### **Query 4 — Kids from the USA**

**English:** Retrieve all kids whose country is USA.  
```sql
SELECT id, race, age, sex
FROM kids
WHERE country = 'USA';
```

### **Query 5 — List kids sorted by height**

**English:** Sort kids by height from tallest to shortest. 
 
```sql
SELECT id, race, country, height
FROM kids
ORDER BY height DESC;
```

---

# 2. Intermediate Queries (5)
(Using GROUP BY, aggregations, and ROW_NUMBER)

### **Query 1 — Average age per race**

**English:** Compute the average age of kids for each race.  

```sql
SELECT race, 
       AVG(age) AS avg_age
FROM kids
GROUP BY race;
```

### **Query 2 — Count kids per country**

**English:** Count how many kids appear from each country.  

```sql
SELECT country, 
       COUNT(*) AS total_kids
FROM kids
GROUP BY country;
```

### **Query 3 — Tallest kid per race (using ROW_NUMBER)**

**English:** Rank kids by height inside each race and return only the tallest.  

```sql
WITH ranked AS (
    SELECT
        id, race, height,
        ROW_NUMBER() OVER (PARTITION BY race 
                           ORDER BY height DESC) 
          AS rn
    FROM kids
)
SELECT id, race, height
FROM ranked
WHERE rn = 1;
```

### **Query 4 — Average weight per gender**

**English:** Compute average weight for male vs female.  

```sql
SELECT sex, 
       AVG(weight) AS avg_weight
FROM kids
GROUP BY sex;
```

### **Query 5 — Shortest kid per country (ROW_NUMBER)**

**English:** Find the shortest kid in every country.  
```sql
WITH ranked AS (
    SELECT
        id, country, height,
        ROW_NUMBER() OVER (PARTITION BY country 
                           ORDER BY height ASC) 
          AS rn
    FROM kids
)
SELECT id, country, height
FROM ranked
WHERE rn = 1;
```

---

# 3. Intermediate+ Queries (5)
(Grouping + window functions + ranking logic)

### **Query 1 — Rank kids by age inside each race**

**English:** Assign ranking numbers to kids by age within their race.  

```sql
SELECT
    id, race, age,
    ROW_NUMBER() OVER (PARTITION BY race 
                       ORDER BY age DESC) AS 
      age_rank
FROM kids;
```

### **Query 2 — Countries with more than 5 kids**

**English:** Use GROUP BY + HAVING to filter.  

```sql
SELECT country, 
       COUNT(*) AS total_kids
FROM kids
GROUP BY country
HAVING total_kids > 5;
```

### **Query 3 — Heaviest kid per race (ROW_NUMBER)**  
```sql
WITH ranked AS (
    SELECT
        id, race, weight,
        ROW_NUMBER() OVER (PARTITION BY race 
                           ORDER BY weight DESC) 
          AS rn
    FROM kids
)
SELECT id, race, weight
FROM ranked
WHERE rn = 1;
```

### **Query 4 — Gender distribution per race**

**English:** Count how many M/F are in each race. 
 
```sql
SELECT race, 
       sex, 
       COUNT(*) AS count_kids
FROM kids
GROUP BY race, sex
ORDER BY race, sex;
```

### **Query 5 — Top 3 tallest kids overall (ROW_NUMBER)**

**English:** Rank all kids by height and return only the top 3.  

```sql
WITH ranked AS (
    SELECT
        id, race, country, height,
        ROW_NUMBER() OVER (ORDER BY height DESC) AS rn
    FROM kids
)
SELECT id, race, country, height
FROM ranked
WHERE rn <= 3;
```

---

