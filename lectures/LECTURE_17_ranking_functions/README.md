# Ranking Functions

	1. RANK()
	
	2. DENSE_RANK()
	
	3. ROW_NUMBER()

## 1. `RANK():`

	Assigns a unique rank number to each distinct row 
	within a partition. If two or more rows have the same 
	value, they receive the same rank, but the next rank(s) 
	will skip numbers.

	For example, if two rows are tied for rank 1, the next 
	rank will be 3 (1, 1, 3).

## 2. `DENSE_RANK(): no gap`

	Similar to RANK(), but it does not skip ranks when 
	there are ties. If two rows have the same rank, 
	the next rank will be consecutive.

	For example, if two rows are tied for rank 1, 
	the next rank will be 2 (1, 1, 2).

## 3. `ROW_NUMBER():`

	Assigns a unique sequential integer to rows 
	within a partition. Unlike RANK() and DENSE_RANK(), 
	it does not account for ties; each row gets a unique 
	number regardless of duplicates.

## Syntax

	The syntax for using these functions is as follows:

		RANK() OVER (PARTITION BY column ORDER BY column)
		
		DENSE_RANK() OVER (PARTITION BY column ORDER BY column)
		
		ROW_NUMBER() OVER (PARTITION BY column ORDER BY column)



# References

[1. What’s the difference? — RANK() vs.DENSE_RANK() vs.ROW_NUMBER()](https://medium.com/@LoriLu/whats-the-difference-rank-vs-dense-rank-vs-row-number-3aca5ecfb928)

[2. MySQL RANK Function](https://www.mysqltutorial.org/mysql-window-functions/mysql-rank-function)