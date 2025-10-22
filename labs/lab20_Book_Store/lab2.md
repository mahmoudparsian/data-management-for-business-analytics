# Lab 2 — Basics + Intro Intermediate

## Schema (simplified):

```sql
  stores(store_id, store_location, city, country)

  customers(customer_id, name, email, gender, age, city, country)

  books(book_id, ISBN, title, author, category, published_date)

  transactions(sale_id, store_id, book_id, customer_id, purchase_date, price)
```

## Joins & Lookups

**1. List transactions with store city and book title.**

```sql
SELECT t.sale_id, s.city, b.title, t.price
FROM transactions t
JOIN stores s ON t.store_id = s.store_id
JOIN books b ON t.book_id = b.book_id
LIMIT 20;
```

**2. Find customers with their last purchase price.**

```sql
SELECT c.customer_id, c.name, t.price
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
ORDER BY t.purchase_date DESC
LIMIT 20;
```

**3. Transactions in 'Paris' stores.**

```sql
SELECT t.* FROM transactions t
JOIN stores s ON t.store_id = s.store_id
WHERE s.city='Paris';
```

**4. Books sold in Japan (Tokyo store).**

```sql
SELECT DISTINCT b.title
FROM transactions t
JOIN stores s ON t.store_id = s.store_id
JOIN books b ON t.book_id = b.book_id
WHERE s.country='Japan';
```

**5. Customers who bought in 'Berlin'.**

```sql
SELECT DISTINCT c.name
FROM transactions t
JOIN customers c ON t.customer_id=c.customer_id
JOIN stores s ON t.store_id=s.store_id
WHERE s.city='Berlin';
```

**6. Count sales per country (store location).**

```sql
SELECT s.country, COUNT(*) AS sales
FROM transactions t JOIN stores s ON t.store_id=s.store_id
GROUP BY s.country
ORDER BY sales DESC;
```

**7. List all sales with customer, book, store.**

```sql
SELECT t.sale_id, c.name, b.title, s.city, t.price, t.purchase_date
FROM transactions t
JOIN customers c ON t.customer_id=c.customer_id
JOIN books b ON t.book_id=b.book_id
JOIN stores s ON t.store_id=s.store_id
ORDER BY t.purchase_date DESC
LIMIT 30;
```

**8. Customers in same city as store 'London'.**

```sql
SELECT c.* 
FROM customers c 
WHERE c.city='London';
```

**9. Books per author (count).**

```sql
SELECT author, COUNT(*) AS titles 
FROM books 
GROUP BY author 
ORDER BY titles DESC 
LIMIT 10;
```

**10. Average price per store.**

```sql
SELECT s.store_id, s.city, AVG(t.price) AS avg_price
FROM transactions t JOIN stores s ON t.store_id=s.store_id
GROUP BY s.store_id, s.city;
```

## Aggregates

**11. Average price per category.**

```sql
SELECT b.category, AVG(t.price) AS avg_price
FROM transactions t JOIN books b ON t.book_id=b.book_id
GROUP BY b.category
ORDER BY avg_price DESC;
```

**12. Top 5 authors by total revenue.**

```sql
SELECT b.author, SUM(t.price) AS revenue
FROM transactions t JOIN books b ON t.book_id=b.book_id
GROUP BY b.author
ORDER BY revenue DESC
LIMIT 5;
```

**13. Monthly sales count (2024).**

```sql
SELECT DATE_FORMAT(purchase_date,'%Y-%m') AS month, COUNT(*) AS cnt
FROM transactions
WHERE purchase_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY month
ORDER BY month;
```

**14. Customers who spent over 100 total.**

```sql
SELECT c.customer_id, c.name, SUM(t.price) AS total_spent
FROM customers c JOIN transactions t ON c.customer_id=t.customer_id
GROUP BY c.customer_id, c.name
HAVING SUM(t.price) > 100
ORDER BY total_spent DESC;
```

**15. Stores with average price > 20.**

```sql
SELECT s.store_id, s.city, AVG(t.price) AS avg_price
FROM stores s JOIN transactions t ON s.store_id = t.store_id
GROUP BY s.store_id, s.city
HAVING AVG(t.price) > 20
ORDER BY avg_price DESC;
```

**16. Categories with at least 30 sales.**

```sql
SELECT b.category, COUNT(*) AS sales
FROM books b JOIN transactions t ON b.book_id=t.book_id
GROUP BY b.category
HAVING COUNT(*) >= 30
ORDER BY sales DESC;
```

**17. Revenue by country and month.**

```sql
SELECT s.country, DATE_FORMAT(t.purchase_date,'%Y-%m') AS month, SUM(t.price) AS revenue
FROM transactions t JOIN stores s ON t.store_id=s.store_id
GROUP BY s.country, month
ORDER BY s.country, month;
```

**18. Top 10 customers by number of purchases.**

```sql
SELECT c.customer_id, c.name, COUNT(*) AS purchases
FROM customers c JOIN transactions t ON c.customer_id=t.customer_id
GROUP BY c.customer_id, c.name
ORDER BY purchases DESC
LIMIT 10;
```

