# Lab 1 — Very Basic Queries

## Schema (simplified):

```sql
  stores(store_id, store_location, city, country)

  customers(customer_id, name, email, gender, age, city, country)

  books(book_id, ISBN, title, author, category, published_date)

  transactions(sale_id, store_id, book_id, customer_id, purchase_date, price)
```

## Stores

**1. List all stores.**

```sql
SELECT * 
FROM stores;
```

**2. Show store_id and city for all stores.**

```sql
SELECT store_id, city 
FROM stores;
```

**3. Find stores in the UK.**

```sql
SELECT * 
FROM stores 
WHERE country = 'UK';
```

**4. List stores ordered by city A→Z.**

```sql
SELECT * 
FROM stores 
ORDER BY city ASC;
```

**5. List stores ordered by city Z→A.**

```sql
SELECT * 
FROM stores 
ORDER BY city DESC;
```

**6. Count stores per country.**

solution-1:

```sql
SELECT country, COUNT(*) 
FROM stores 
GROUP BY country;
```

solution-2:

```sql
SELECT country, COUNT(*) as count_per_country
FROM stores 
GROUP BY country;
```

**7. Find store(s) located in London.**

```sql
SELECT * 
FROM stores 
WHERE city ='London';
```

## Customers

**8. List first 10 customers.**

```sql
SELECT * 
FROM customers 
LIMIT 10;
```

**9. Find customers older than 40.**

```sql
SELECT * 
FROM customers 
WHERE age > 40;
```

**10. Show distinct customer cities.**

```sql
SELECT DISTINCT city 
FROM customers;
```

**11. Customers in the same country as 'London' store (UK).**

```sql
SELECT * 
FROM customers 
WHERE country = 'UK';
```

**12. Customers with email ending in 'mail.com'.**

```sql
SELECT * 
FROM customers 
WHERE email LIKE '%@mail.com';
```

**13. Count customers by gender.**

solution-1:

```sql
SELECT gender, COUNT(*) 
FROM customers 
GROUP BY gender;
```

solution-2:

```sql
SELECT gender, COUNT(*) as count_per_gender
FROM customers 
GROUP BY gender;
```

## Books

**14. List 10 books (title, author).**

```sql
SELECT title, author 
FROM books 
LIMIT 10;
```

**15. Find all books in 'Fiction' category.**

```sql
SELECT * 
FROM books 
WHERE category = 'Fiction';
```

**16. Books published after 2015.**

```sql
SELECT * 
FROM books 
WHERE published_date >= '2016-01-01';
```

**17. Show distinct categories.**

```sql
SELECT DISTINCT category 
FROM books;
```

**18. Count books per category.**

solution-1:

```sql
SELECT category, COUNT(*) 
FROM books 
GROUP BY category;
```

solution-2:

```sql
SELECT category, COUNT(*) as count_per_category
FROM books 
GROUP BY category;
```

**19. Find books with 'City' in the title.**

```sql
SELECT * 
FROM books 
WHERE title LIKE '%City%';
```

## Transactions

**20. Show 10 sample transactions.**

```sql
SELECT * 
FROM transactions 
LIMIT 10;
```

**21. Find transactions above price 25.**

```sql
SELECT * 
FROM transactions 
WHERE price > 25;
```

**22. Transactions in 2024.**

```sql
SELECT * 
FROM transactions 
WHERE purchase_date BETWEEN '2024-01-01' AND '2024-12-31';
```

**23. Count transactions per store.**

solution-1:

```sql
SELECT store_id, COUNT(*) 
FROM transactions 
GROUP BY store_id;
```

solution-2:

```sql
SELECT store_id, COUNT(*) as count_per_store
FROM transactions 
GROUP BY store_id;
```

**24. Average price of all transactions.**

solution-1:

```sql
SELECT AVG(price) 
FROM transactions;
```

solution-2:

```sql
SELECT AVG(price) as avg_price
FROM transactions;
```

**25. Top 5 most expensive purchases.**

```sql
SELECT * 
FROM transactions 
ORDER BY price DESC 
LIMIT 5;
```

## Extras

**26. Customers ordered by name.**

```sql
SELECT * 
FROM customers 
ORDER BY name;
```

**27. Latest 5 published books.**

```sql
SELECT * 
FROM books 
ORDER BY published_date 
DESC LIMIT 5;
```

**28. Cheapest 5 transactions.**

```sql
SELECT * 
FROM transactions 
ORDER BY price ASC LIMIT 5;
```

**29. Stores in USA or UK.**

solution-1:

```sql
SELECT * 
FROM stores 
WHERE country IN ('USA','UK');
```

solution-2:

```sql
SELECT * 
FROM stores 
WHERE (country = 'USA') OR (country = 'UK');
```

**30. Customers aged between 25 and 35.**

solution-1:

```sql
SELECT * 
FROM customers 
WHERE age BETWEEN 25 AND 35;
```

solution-2:

```sql
SELECT * 
FROM customers 
WHERE (age >= 25) AND (age <= 35);
```

**31. Books not in 'Children' category.**

```sql
SELECT * 
FROM books 
WHERE category <> 'Children';
```

