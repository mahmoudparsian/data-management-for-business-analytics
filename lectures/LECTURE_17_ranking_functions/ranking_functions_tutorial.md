# Rank functions in MySQL

	Rank functions in MySQL are window functions 
	that allow you to assign a rank to each row 
	within a partition of a result set. 
	
	These functions are particularly useful for 
	performing calculations based on the order 
	of rows, such as finding the highest or lowest 
	values, and they can help you easily categorize 
	data without needing to create complex subqueries.

## Types of Rank Functions


### 1. `RANK()`:

	Assigns a unique rank number to each distinct 
	row within a partition. If two or more rows have 
	the same value, they receive the same rank, but 
	the next rank(s) will skip numbers.

	For example, if two rows are tied for rank 1, 
	the next rank will be 3 (1, 1, 3).


### 2. `DENSE_RANK()`:

	Similar to RANK(), but it does not skip ranks 
	when there are ties. If two rows have the same 
	rank, the next rank will be consecutive.

	For example, if two rows are tied for rank 1, 
	the next rank will be 2 (1, 1, 2).


### 3. `ROW_NUMBER()`:

	Assigns a unique sequential integer to rows 
	within a partition. Unlike `RANK()` and 
	`DENSE_RANK()`, it does not account for ties; 
	each row gets a unique number regardless of duplicates.

## Syntax

The syntax for using these functions is as follows:

```
   RANK() OVER (PARTITION BY column ORDER BY column)
   
   DENSE_RANK() OVER (PARTITION BY column ORDER BY column)
   
   ROW_NUMBER() OVER (PARTITION BY column ORDER BY column)
```

## Example:

Suppose you have a scores table with the following structure and data:

```sql
-- Create the scores table
CREATE TABLE scores (
    student_id INT,
    subject VARCHAR(50),
    score INT
);

-- Insert data into the scores table
INSERT INTO scores (student_id, subject, score) 
VALUES
(1, 'Math', 95),
(2, 'Math', 85),
(3, 'Math', 95),
(4, 'Math', 75),
(1, 'Science', 90),
(2, 'Science', 88),
(3, 'Science', 90);
```

### View Data

```
mysql> select * from scores;
+------------+---------+-------+
| student_id | subject | score |
+------------+---------+-------+
|          1 | Math    |    95 |
|          2 | Math    |    85 |
|          3 | Math    |    95 |
|          4 | Math    |    75 |
|          1 | Science |    90 |
|          2 | Science |    88 |
|          3 | Science |    90 |
+------------+---------+-------+
7 rows in set (0.00 sec)
```

## Query Example

	To assign ranks to students based on their scores 
	in each subject, you could use:

```sql
SELECT 
    student_id,
    subject,
    score,
    RANK() OVER (PARTITION BY subject ORDER BY score DESC) AS ranking,
    DENSE_RANK() OVER (PARTITION BY subject ORDER BY score DESC) AS denseRank,
    ROW_NUMBER() OVER (PARTITION BY subject ORDER BY score DESC) AS rowNumber
FROM 
    scores;
```

output:

```
+------------+---------+-------+---------+-----------+-----------+
| student_id | subject | score | ranking | denseRank | rowNumber |
+------------+---------+-------+---------+-----------+-----------+
|          1 | Math    |    95 |       1 |         1 |         1 |
|          3 | Math    |    95 |       1 |         1 |         2 |
|          2 | Math    |    85 |       3 |         2 |         3 |
|          4 | Math    |    75 |       4 |         3 |         4 |
|          1 | Science |    90 |       1 |         1 |         1 |
|          3 | Science |    90 |       1 |         1 |         2 |
|          2 | Science |    88 |       3 |         2 |         3 |
+------------+---------+-------+---------+-----------+-----------+
7 rows in set (0.00 sec)
```


## Summary

	RANK() provides a rank with gaps for ties.
	
	DENSE_RANK() provides a rank without gaps for ties.
	
	ROW_NUMBER() provides a unique sequential number for each row.
	

	These functions are powerful tools for analysis 
	and reporting, allowing you to easily segment 
	and rank your data based on various criteria.

## Source:

1. [Rank functions in MySQL](https://medium.com/@emad-mohamed/rank-functions-in-mysql-e76762c210a6)