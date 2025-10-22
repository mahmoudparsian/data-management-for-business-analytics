# MySQL: difference of two result sets

How can I get the set difference of two result sets?

Say I have a result set (just one column in each):

~~~
result1:
'a'
'b'
'c'
~~~

~~~
result2:
'b'
'c'
~~~

	I want to minus what is in result1 by result2: 
	result1 - result2 such that it equals:
	
	difference of result1 - result2:
	'a'

## Answer:

To perform `result1 - result2`, you can join result1 with result2, and only output items that exist in result1. For example:

~~~mysql
SELECT DISTINCT result1.column
FROM result1 
LEFT JOIN result2 ON result1.column = result2.column
WHERE result2.column IS NULL;
~~~

### Notes...

	1. In set theory terms this is a set difference of 
	   result1 and result2, i.e. elements in result1 
	   but not in result2.

	2. If you are looking for a symmetric difference 
	   (elements in either result1 or result2, but not 
	   both), you can do a FULL OUTER JOIN and filter 
	   out elements where either side is NULL.

	3. Finally, as a caveat, this won't work well if you 
	   have nullable columns in your database, as these 
	   will be seen identically to a row where the join 
	   failed. Thankfully, joins are normally performed 
	   on indexed columns, where nullable values are rare.

