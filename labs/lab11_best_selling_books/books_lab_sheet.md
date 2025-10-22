# 📘 Lab Sheet: Practicing SQL with Best-Selling Books

This lab will guide you step by step on loading and querying the **books** dataset.

---

## 1. Load the Table

```sql
SOURCE books_real_bestsellers.sql;
```

This creates and populates the table **books**.

---

## 2. Explore the Data

### Q1: Show all columns for the first 10 rows
```sql
SELECT * FROM books LIMIT 10;
```

✅ *Expected output:* First 10 rows with `book_id, title, author, year_published, genre, sales_band, source`.

---

## 3. Filtering

### Q2: Find books published after 2000
```sql
SELECT title, author, year_published
FROM books
WHERE year_published > 2000
ORDER BY year_published;
```

✅ *Expected output:* Recent titles like *The Da Vinci Code*, *The Hunger Games*, *The Girl on the Train*.

### Q3: List all Fantasy books
```sql
SELECT title, author FROM books WHERE genre='Fantasy';
```

✅ *Expected output:* *The Lord of the Rings*, *The Hobbit*, *Harry Potter* series, etc.

---

## 4. Aggregation

### Q4: Count books by genre
```sql
SELECT genre, COUNT(*) AS num_titles
FROM books
GROUP BY genre
ORDER BY num_titles DESC;
```

✅ *Expected output:* Genres like *Fantasy* and *Children* have the highest counts.

### Q5: Earliest and latest publication year
```sql
SELECT MIN(year_published) AS first_year,
       MAX(year_published) AS last_year
FROM books;
```

✅ *Expected output:* Earliest ~1605 (*Don Quixote*), latest ~2018 (*Where the Crawdads Sing*).

---

## 5. Pattern Matching

### Q6: Find books with 'Girl' in the title
```sql
SELECT title, author FROM books WHERE title LIKE '%Girl%';
```

✅ *Expected output:* *Gone Girl*, *The Girl with the Dragon Tattoo*, *The Girl on the Train*.

---

## 6. Intermediate Queries with Ranking

### Q7: Rank authors by number of titles
```sql
WITH A AS (
  SELECT author, COUNT(*) AS titles
  FROM books
  GROUP BY author
)
SELECT author, titles,
       RANK() OVER (ORDER BY titles DESC) AS author_rank
FROM A
ORDER BY author_rank, author;
```

✅ *Expected output:* J.K. Rowling near the top with 7 Harry Potter books, Tolkien with 2, etc.

### Q8: Rank genres by number of titles
```sql
WITH G AS (
  SELECT genre, COUNT(*) AS num_titles
  FROM books
  GROUP BY genre
)
SELECT genre, num_titles,
       DENSE_RANK() OVER (ORDER BY num_titles DESC) AS genre_rank
FROM G;
```

✅ *Expected output:* *Fantasy* and *Children* ranked highest.

---

## 7. Challenge

### Q9: Find the top 3 longest titles (by character length)
```sql
WITH L AS (
  SELECT title, CHAR_LENGTH(title) AS len
  FROM books
)
SELECT title, len,
       RANK() OVER (ORDER BY len DESC) AS len_rank
FROM L
WHERE len_rank <= 3;
```

✅ *Expected output:* Titles like *She: A History of Adventure* should appear.

---

## 8. Wrap-Up

Congratulations 🎉 — you practiced:

- Basic selection & filtering  
- Aggregation with GROUP BY  
- Pattern matching with LIKE  
- CTEs and RANK() functions  

Next steps: Try the full **books_queries.md** set for deeper exploration!
