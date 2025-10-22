# join of tables in math

let’s think of SQL joins in mathematical terms.

⸻

## 1. Tables as Sets

In mathematics, a relation is a set of tuples.

    •    A SQL table = a relation 
         (set of rows, each row = a tuple).
         
    •    Each column = an attribute.

For example:

    •    Table Students(id, name) = 
         a set of ordered pairs (id, name).
         
    •    Table Courses(id, title) = 
         another set of pairs.

⸻

## 2. Cartesian Product (Cross Join)

The most fundamental operation:

A \times B = \{ (a, b) \ | \ a \in A, b \in B \}

In SQL:

~~~
SELECT * 
FROM Students 
CROSS JOIN Courses;
~~~

Every row of Students combines with every row of Courses.

If |A|=m and |B|=n, then |A × B| = m \times n.

⸻

## 3. Inner Join (Natural Join / Equi-Join)

This is a restricted Cartesian product, where we keep only rows matching a condition.

Mathematically:

A \bowtie_{A.x = B.y} B = \{ (a, b) \in A \times B \ | \ a.x = b.y \}


SQL:

~~~sql
SELECT *
FROM Students s
JOIN Courses c
ON s.id = c.id;
~~~

⸻

## 4. Left Join

We take all rows from A, and match rows from B if possible.
If no match, put NULL.

Mathematically:

A \ \text{LEFT JOIN} \ B = (A \bowtie B) \ \cup \ \{ (a, NULL) \ | \ a \in A \text{ and no match in } B\}

⸻

## 5. Right Join

The symmetric case: all rows from B, matching rows from A if possible.

A \ \text{RIGHT JOIN} \ B = (A \bowtie B) \ \cup \ \{ (NULL, b) \ | \ b \in B \text{ and no match in } A\}

⸻

## 6. Full Outer Join

Take all rows from A and B, match where possible, fill NULL otherwise.

A \ \text{FULL JOIN} \ B = (A \bowtie B) \ \cup \{ (a, NULL) \ | a \in A \text{ unmatched}\} \cup \{ (NULL, b) \ | b \in B \text{ unmatched}\}

⸻

## 7. Example with Sets

Let
Students = \{ (1, ‘Alice’), (2, ‘Bob’) \}

Courses = \{ (1, ‘Math’), (3, ‘Physics’) \}

-----

### Cartesian Product:

\{ (1, Alice, 1, Math), (1, Alice, 3, Physics), (2, Bob, 1, Math), (2, Bob, 3, Physics) \}

------

### Inner Join on id:

\{ (1, Alice, 1, Math) \}

------

### Left Join:

\{ (1, Alice, 1, Math), (2, Bob, NULL, NULL) \}

------

### Right Join:

\{ (1, Alice, 1, Math), (NULL, NULL, 3, Physics) \}

-------

### Full Join:

\{ (1, Alice, 1, Math), (2, Bob, NULL, NULL), (NULL, NULL, 3, Physics) \}

⸻

✅ So in math terms:

    •    JOIN = subset of Cartesian product with conditions.
    
    •    LEFT/RIGHT/FULL JOIN = add missing tuples with NULL padding.

⸻

