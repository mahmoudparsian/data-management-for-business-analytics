# 2 SQL Queries: Different Semantics

Using the `kids` table:

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

# Question?

Explain the following 2 queries and tell why they are not equivalent.

### Query 1

```sql
SELECT race,
       SUM(height > 150)/COUNT(*), 
       COUNT(*) 
FROM kids 
GROUP BY race;
+-----------------+----------------------------+----------+
| race            | SUM(height > 150)/COUNT(*) | COUNT(*) |
+-----------------+----------------------------+----------+
| Native Hawaiian |                     0.5000 |       22 |
| Asian           |                     0.2609 |       23 |
| Black           |                     0.4706 |       17 |
| American Indian |                     0.3478 |       23 |
| White           |                     0.4667 |       15 |
+-----------------+----------------------------+----------+
5 rows in set (0.000 sec)
```
### Query 2

```sql
SELECT race, 
       SUM(height)/COUNT(*), 
       COUNT(*) 
FROM kids 
WHERE height > 150 
GROUP BY race;
+-----------------+----------------------+----------+
| race            | SUM(height)/COUNT(*) | COUNT(*) |
+-----------------+----------------------+----------+
| Native Hawaiian |          163.2497273 |       11 |
| Black           |          170.8457500 |        8 |
| American Indian |          163.5357500 |        8 |
| Asian           |          166.4863333 |        6 |
| White           |          163.6344286 |        7 |
+-----------------+----------------------+----------+
5 rows in set (0.001 sec)
```

## Comparison of 2 Queries

### 🟢 Query 1: discussion

* In Query 1, the expression `height > 150` is evaluated 
for every row in the kids table. In MySQL a boolean expression returns `1` for `TRUE` and `0` for `FALSE`. Thus:

```
SUM(height > 150)          -- counts how many kids of 
                              each race have height > 150
                              
COUNT(*)                   -- counts all kids of each race

SUM(height > 150)/COUNT(*) -- gives the proportion of 
                              kids above 150
```

Because it groups by `race` but has no `WHERE` clause, 
it includes every child in each racial group. The resulting 
fraction tells you what fraction of children in that race 
have a height greater than 150.

### 🟢 Query 2: discussion

* In Query 2 the `WHERE height > 150` clause filters out 
  all rows whose height is `≤ 150`. The calculation is 
  then made only on the remaining rows:

```
SUM(height) / COUNT(*)  -- gives the average height of 
                           the kids whose height > 150
                           
COUNT(*)                -- counts only the kids whose 
                           height > 150
```

So for each `race` it calculates the mean 
height of the taller kids (above 150) and 
reports how many tall kids were used for 
that calculation.  Children with height 
`≤ 150` are not counted at all.

## Query 1 and Query 2 are Not Equivalent:

* These two queries are not equivalent because:

#### 📊 Different aggregation: 
		
		✅ Query 1 divides the number of 
		“tall” kids by the total number 
		of kids to produce a proportion. 
		  
		✅ Query 2 divides the sum of heights 
		by the number of “tall” kids to 
		produce an average height.
	
#### 📊 Different row sets: 
		
		✅ Query 1 processes all 
		rows in each racial group. 
		
		✅ Query 2 processes only rows 
		where height > 150, so the 
		denominator in its average 
		and the count of rows are 
		both smaller.

## Conclusion:

As a result the numeric values in their 
outputs measure different things 
(proportion vs. mean) and cannot be 
used interchangeably.

