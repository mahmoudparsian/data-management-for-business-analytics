Given the following 3 tables (schemas are provided) 
for world database in mysql:

* city
* country
* countrylanguage

1. Provide 5 basic SQL queries and associated SQL for mySQL

2. Provide 5 intermediate SQL queries and associated SQL for mySQL

3. Provide 5 intermediate SQL queries and associated SQL using 
   sub-queries and ranking functions for mySQL
   
   
CREATE TABLE `city` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` CHAR(35) NOT NULL DEFAULT '',
  `CountryCode` CHAR(3) NOT NULL DEFAULT '',
  `District` CHAR(20) NOT NULL DEFAULT '',
  `Population` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `CountryCode` (`CountryCode`),
  CONSTRAINT `city_ibfk_1` FOREIGN KEY (`CountryCode`) REFERENCES `country` (`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=4080 DEFAULT CHARSET=latin1;

CREATE TABLE `country` (
  `Code` CHAR(3) NOT NULL DEFAULT '',
  `Name` CHAR(52) NOT NULL DEFAULT '',
  `Continent` enum('Asia','Europe','North America','Africa','Oceania','Antarctica','South America') NOT NULL DEFAULT 'Asia',
  `Region` CHAR(26) NOT NULL DEFAULT '',
  `SurfaceArea` FLOAT(10,2) NOT NULL DEFAULT '0.00',
  `IndepYear` SMALLINT(6) DEFAULT NULL,
  `Population` INT(11) NOT NULL DEFAULT '0',
  `LifeExpectancy` FLOAT(3,1) DEFAULT NULL,
  `GNP` FLOAT(10,2) DEFAULT NULL,
  `GNPOld` FLOAT(10,2) DEFAULT NULL,
  `LocalName` CHAR(45) NOT NULL DEFAULT '',
  `GovernmentForm` CHAR(45) NOT NULL DEFAULT '',
  `HeadOfState` CHAR(60) DEFAULT NULL,
  `Capital` INT(11) DEFAULT NULL,
  `Code2` CHAR(2) NOT NULL DEFAULT '',
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `countrylanguage` (
  `CountryCode` CHAR(3) NOT NULL DEFAULT '',
  `Language` CHAR(30) NOT NULL DEFAULT '',
  `IsOfficial` enum('T','F') NOT NULL DEFAULT 'F',
  `Percentage` FLOAT(4,1) NOT NULL DEFAULT '0.0',
  PRIMARY KEY (`CountryCode`,`Language`),
  KEY `CountryCode` (`CountryCode`),
  CONSTRAINT `countryLanguage_ibfk_1` FOREIGN KEY (`CountryCode`) REFERENCES `country` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


✅ This set covers:

* **5 Basic SQL queries** : **Basic filters and selects**
* **5 Intermediate SQL queries** : **Aggregations and joins**
* **5 Intermediate queries using subqueries and ranking functions**


---

# 1. Basic SQL Queries

### Q1. List the names of all countries in Europe.

```sql
SELECT Name 
FROM country
WHERE Continent = 'Europe';
```

### Q2. Show all cities in the USA.

```sql
SELECT Name, District, Population
FROM city
WHERE CountryCode = 'USA';
```

### Q3. Find the population of Japan.

```sql
SELECT Population
FROM country
WHERE Name = 'Japan';
```

### Q4. Get all official languages spoken in India.

```sql
SELECT Language
FROM countrylanguage
WHERE CountryCode = 'IND' AND IsOfficial = 'T';
```

### Q5. List the top 5 most populated cities in the world.

```sql
SELECT Name, CountryCode, Population
FROM city
ORDER BY Population DESC
LIMIT 5;
```

---

# 2. Intermediate SQL Queries

### Q1. Find the average life expectancy of countries in Asia.

```sql
SELECT AVG(LifeExpectancy) AS avg_life_expectancy
FROM country
WHERE Continent = 'Asia';
```

### Q2. List countries with population greater than 100 million.

```sql
SELECT Name, Population
FROM country
WHERE Population > 100000000
ORDER BY Population DESC;
```

### Q3. Show the country and its capital city.

```sql
SELECT 
      c.Name AS Country, 
      ci.Name AS Capital
FROM country c
JOIN city ci ON c.Capital = ci.ID;
```

### Q4. Find the total population of each continent.

```sql
SELECT Continent, SUM(Population) AS total_population
FROM country
GROUP BY Continent;
```

### Q5. List top 5 countries by GNP per capita.

```sql
SELECT Name, (GNP / Population) AS gnp_per_capita
FROM country
WHERE GNP IS NOT NULL AND Population > 0
ORDER BY gnp_per_capita DESC
LIMIT 5;
```

---

# 3. Intermediate Queries (Subqueries + Ranking Functions)

(*Assuming MySQL 8+ for window functions*)

### Q1. Find the largest city (by population) in each country.

```sql
WITH ranked_data as 
(
  SELECT c.CountryCode, 
         c.Name, 
         c.Population,
         ROW_NUMBER() OVER (PARTITION BY c.CountryCode ORDER BY c.Population DESC) AS rn
  FROM city c
) 
SELECT CountryCode, Name AS City, Population
FROM ranked_data
WHERE rn = 1;

```

### Q2. Find countries where life expectancy is higher than the world average.

```sql
SELECT Name, LifeExpectancy
FROM country
WHERE LifeExpectancy > (SELECT AVG(LifeExpectancy) FROM country);
```

### Q3. List the top 3 most spoken languages in each country (by percentage).

```sql
WITH ranked_data as
(  SELECT cl.CountryCode, cl.Language, cl.Percentage,
         ROW_NUMBER() OVER (PARTITION BY cl.CountryCode ORDER BY cl.Percentage DESC) AS rn
  FROM countrylanguage cl
)
SELECT CountryCode, Language, Percentage
FROM ranked_data
WHERE rn <= 3;

```

### Q4. Find the top 5 countries by population density (population per surface area).

```sql
SELECT Name, 
       (Population / SurfaceArea) AS population_density
FROM country
WHERE SurfaceArea > 0
ORDER BY population_density DESC
LIMIT 5;
```

### Q5. Rank countries in South America by population.

```sql
SELECT Name, 
       Population,
       RANK() OVER (ORDER BY Population DESC) AS population_rank
FROM country
WHERE Continent = 'South America';
```

---



