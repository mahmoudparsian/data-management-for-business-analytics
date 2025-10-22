
# BookNest Analytics – Data Story, Schema, Sample Data, and Query Library

## Data Story (Business Requirement)

A lifelong book lover launches **BookNest**, a network of ten cozy bookstores spread across the United States—each located in a different state. Every shop has a distinct neighborhood vibe and readership: the Portland store leans toward indie fiction, Austin loves tech and start‑ups, and Miami moves lots of travel and bilingual titles. The owner wants **store-by-store visibility** into what sells, how quickly, and to whom—so he can tailor inventory, events, and staff picks to local tastes.

BookNest’s catalog spans many **categories**—Fiction, Non‑Fiction, Poetry, Children, Graphic Novels, Self‑Help, Technology, and Travel. Each **book** carries a list price and a primary category. To simplify analysis, every **transaction records the sale of exactly one book** (no mixed baskets), capturing the store, the date, and the book sold. This helps generate clean measures like **units sold**, **gross revenue**, and **category share**, and makes it easy to spot rising titles and seasonal spikes.

The owner also keeps a **customer registry** with basic demographics (name, gender, education level, email, join date). He hopes to identify **loyal readers**, measure the impact of **author events and promotions**, and compare **customer segments** across states. Over time, BookNest will expand the model to track returns, discounts, and multi‑book orders; for now, this lean schema should power the first dashboards and weekly “what’s working” memos.

---

## MySQL Schema
```sql

CREATE DATABASE IF NOT EXISTS booknest;
USE booknest;

CREATE TABLE stores (
  store_id   INT PRIMARY KEY,
  store_name VARCHAR(60) NOT NULL,
  state_code CHAR(2) NOT NULL,
  opened_date DATE NOT NULL
);

CREATE TABLE categories (
  category_id INT PRIMARY KEY,
  category_name VARCHAR(40) UNIQUE NOT NULL
);

CREATE TABLE books (
  book_id     INT PRIMARY KEY,
  title       VARCHAR(120) NOT NULL,
  author      VARCHAR(80) NOT NULL,
  category_id INT NOT NULL,
  list_price  DECIMAL(7,2) NOT NULL,
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE customers (
  customer_id  INT PRIMARY KEY,
  full_name    VARCHAR(80) NOT NULL,
  gender       ENUM('F','M','X') DEFAULT 'X',
  education    ENUM('HS','BA','MA','PhD','Other') DEFAULT 'Other',
  email        VARCHAR(120) UNIQUE NOT NULL,
  join_date    DATE NOT NULL
);

CREATE TABLE transactions (
  txn_id     INT PRIMARY KEY,
  store_id   INT NOT NULL,
  customer_id INT NOT NULL,
  book_id    INT NOT NULL,
  txn_date   DATE NOT NULL,
  channel    ENUM('in_store','online') NOT NULL,
  price_paid DECIMAL(7,2) NOT NULL,
  FOREIGN KEY (store_id)   REFERENCES stores(store_id),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (book_id)    REFERENCES books(book_id)
);

```

## Sample Data (INSERTS)
```sql
INSERT INTO stores(store_id,store_name,state_code,opened_date) VALUES
(1,'BookNest Portland','OR','2021-01-31'),
(2,'BookNest Austin','TX','2021-03-02'),
(3,'BookNest Miami','FL','2021-04-01'),
(4,'BookNest Boston','MA','2021-05-01'),
(5,'BookNest Seattle','WA','2021-05-31'),
(6,'BookNest Denver','CO','2021-06-30'),
(7,'BookNest Chicago','IL','2021-07-30'),
(8,'BookNest Brooklyn','NY','2021-08-29'),
(9,'BookNest Santa Monica','CA','2021-09-28'),
(10,'BookNest Minneapolis','MN','2021-10-28');
```
```sql
INSERT INTO categories(category_id,category_name) VALUES
(1,'Fiction'),
(2,'Non-Fiction'),
(3,'Poetry'),
(4,'Children'),
(5,'Graphic Novels'),
(6,'Self-Help'),
(7,'Technology'),
(8,'Travel');
```
```sql
INSERT INTO books(book_id,title,author,category_id,list_price) VALUES
(1,'The River Between','Ngũgĩ wa Thiong’o',1,15.99),
(2,'Algorithms to Live By','Brian Christian',2,18.50),
(3,'The Pragmatic Programmer','Andrew Hunt',7,39.99),
(4,'Clean Code','Robert C. Martin',7,42.00),
(5,'Where the Wild Things Are','Maurice Sendak',4,12.49),
(6,'Milk and Honey','Rupi Kaur',3,14.00),
(7,'The Alchemist','Paulo Coelho',1,16.00),
(8,'Educated','Tara Westover',2,17.99),
(9,'Atomic Habits','James Clear',6,21.00),
(10,'Deep Work','Cal Newport',6,19.00),
(11,'Watchmen','Alan Moore',5,24.00),
(12,'The Sandman Vol. 1','Neil Gaiman',5,22.00),
(13,'Python Crash Course','Eric Matthes',7,34.99),
(14,'Designing Data-Intensive Applications','Martin Kleppmann',7,49.99),
(15,'The Little Prince','Antoine de Saint-Exupéry',4,10.99),
(16,'On Writing','Stephen King',2,16.50),
(17,'Leaves of Grass','Walt Whitman',3,13.50),
(18,'Dune','Frank Herbert',1,18.00),
(19,'Project Hail Mary','Andy Weir',1,19.50),
(20,'Lonely Planet Japan','Lonely Planet',8,28.00),
(21,'Lonely Planet Italy','Lonely Planet',8,26.00),
(22,'Thinking, Fast and Slow','Daniel Kahneman',2,18.99),
(23,'Goodnight Moon','Margaret Wise Brown',4,8.99),
(24,'Hyperbole and a Half','Allie Brosh',5,16.99);
```
```sql
INSERT INTO customers(customer_id,full_name,gender,education,email,join_date) VALUES
(1,'Raj Thompson','M','BA','raj.thompson1@example.com','2024-10-27'),
(2,'Ethan Davis','X','BA','ethan.davis2@example.com','2024-11-10'),
(3,'Mia Jones','M','BA','mia.jones3@example.com','2024-02-16'),
(4,'Sara Johnson','X','Other','sara.johnson4@example.com','2024-08-19'),
(5,'Zoe Davis','X','HS','zoe.davis5@example.com','2024-09-27'),
(6,'Liam Johnson','F','HS','liam.johnson6@example.com','2024-05-03'),
(7,'Zoe Smith','M','BA','zoe.smith7@example.com','2024-10-29'),
(8,'Ethan Martin','F','MA','ethan.martin8@example.com','2024-09-12'),
(9,'Ava Brown','M','MA','ava.brown9@example.com','2024-07-27'),
(10,'Sara Brown','X','BA','sara.brown10@example.com','2025-01-23'),
(11,'Sophia Martin','M','HS','sophia.martin11@example.com','2024-10-15'),
(12,'Emma Thomas','F','MA','emma.thomas12@example.com','2024-07-16'),
(13,'Liam Smith','X','HS','liam.smith13@example.com','2024-04-17'),
(14,'Noah Harris','M','Other','noah.harris14@example.com','2024-07-22'),
(15,'Lea Brown','X','MA','lea.brown15@example.com','2025-02-02'),
(16,'Isabella Perez','F','BA','isabella.perez16@example.com','2024-01-08'),
(17,'Lea Jones','F','HS','lea.jones17@example.com','2024-02-21'),
(18,'Ava Johnson','M','MA','ava.johnson18@example.com','2024-03-31'),
(19,'Sara Wilson','M','BA','sara.wilson19@example.com','2025-01-09'),
(20,'Olivia Jackson','X','BA','olivia.jackson20@example.com','2024-07-21');
```
```sql
INSERT INTO transactions(txn_id,store_id,customer_id,book_id,txn_date,channel,price_paid) VALUES
(1,7,7,1,'2025-08-29','online',15.04),
(2,1,7,6,'2025-09-08','in_store',13.43),
(3,1,5,7,'2024-01-10','online',15.46),
(4,5,13,3,'2024-08-01','in_store',36.44),
(5,1,20,12,'2025-04-09','in_store',21.03),
(6,10,16,19,'2025-01-30','in_store',17.95),
(7,3,10,8,'2024-09-12','in_store',18.40),
(8,3,18,7,'2025-02-01','online',16.05),
(9,10,3,14,'2024-04-21','in_store',45.35),
(10,9,9,8,'2025-02-05','online',18.19),
(11,7,20,16,'2024-06-28','in_store',15.58),
(12,3,8,16,'2025-09-22','in_store',16.23),
(13,5,7,7,'2024-03-11','online',16.20),
(14,7,15,8,'2024-06-29','online',16.35),
(15,6,17,19,'2024-04-04','online',20.40),
(16,3,15,11,'2025-12-08','in_store',23.96),
(17,10,2,1,'2025-01-01','online',15.53),
(18,1,1,20,'2025-05-08','in_store',27.87),
(19,5,11,5,'2024-03-18','online',13.11),
(20,9,12,24,'2025-12-21','in_store',15.40),
(21,6,12,3,'2024-03-20','online',40.10),
(22,1,16,19,'2025-11-09','online',17.59),
(23,7,19,1,'2024-03-23','in_store',15.85),
(24,2,9,14,'2025-02-01','online',50.45),
(25,8,15,18,'2025-06-10','in_store',16.43),
(26,5,20,3,'2024-08-23','in_store',38.88),
(27,8,20,22,'2024-09-18','in_store',19.71),
(28,6,10,5,'2024-07-26','in_store',12.51),
(29,6,15,16,'2024-11-30','online',17.06),
(30,5,7,21,'2024-07-24','in_store',25.08),
(31,7,8,19,'2024-08-02','in_store',20.24),
(32,3,16,12,'2024-02-11','in_store',22.56),
(33,5,6,4,'2024-10-08','in_store',40.64),
(34,7,13,21,'2025-11-19','online',25.43),
(35,10,15,11,'2024-02-02','online',21.87),
(36,10,2,22,'2025-08-07','online',19.11),
(37,5,19,1,'2025-02-18','online',15.93),
(38,4,1,9,'2024-05-24','in_store',19.65),
(39,2,15,4,'2025-11-01','online',41.77),
(40,2,7,7,'2024-09-19','in_store',16.38),
(41,1,16,18,'2024-07-02','in_store',18.13),
(42,5,12,18,'2025-06-16','in_store',18.08),
(43,7,8,3,'2025-02-01','in_store',38.45),
(44,8,15,7,'2024-01-07','online',15.90),
(45,9,19,21,'2024-12-17','online',26.83),
(46,6,7,4,'2025-10-19','in_store',42.35),
(47,4,8,13,'2024-11-13','online',36.64),
(48,5,1,12,'2024-02-08','online',21.47),
(49,6,18,14,'2025-05-14','in_store',50.75),
(50,4,3,14,'2024-06-26','online',50.99),
(51,3,16,5,'2025-06-14','online',13.11),
(52,8,19,23,'2024-08-14','online',8.21),
(53,9,18,10,'2025-07-29','in_store',19.47),
(54,9,17,18,'2025-11-18','online',16.89),
(55,10,7,10,'2025-07-11','online',19.52),
(56,10,16,7,'2024-04-27','in_store',15.39),
(57,10,13,1,'2024-02-15','online',15.68),
(58,9,19,4,'2025-12-08','in_store',40.89),
(59,2,18,15,'2025-02-17','online',10.57),
(60,4,16,16,'2025-03-20','online',15.16);
```

---

# Query Library (60)
## Basic Queries (20)

**1. List all stores**

```sql
SELECT * FROM stores;
```

**2. List all categories**

```sql
SELECT * FROM categories;
```

**3. List all books**

```sql
SELECT * FROM books;
```

**4. List first 5 customers**

```sql
SELECT * FROM customers ORDER BY customer_id LIMIT 5;
```

**5. List the 10 most recent transactions**

```sql
SELECT * FROM transactions ORDER BY txn_date DESC, txn_id DESC LIMIT 10;
```

**6. Show store names and states**

```sql
SELECT store_name, state_code FROM stores;
```

**7. Find all Technology books**

```sql
SELECT * FROM books b JOIN categories c ON b.category_id=c.category_id WHERE c.category_name='Technology';
```

**8. Find books priced below $15**

```sql
SELECT * FROM books WHERE list_price < 15.00;
```

**9. Show unique education levels**

```sql
SELECT DISTINCT education FROM customers;
```

**10. Show customers who joined in 2025**

```sql
SELECT * FROM customers WHERE YEAR(join_date)=2025;
```

**11. Find online transactions**

```sql
SELECT * FROM transactions WHERE channel='online';
```

**12. Transactions on a specific date (sample)**

```sql
SELECT * FROM transactions WHERE txn_date='2025-03-15';
```

**13. Books by author 'Neil Gaiman'**

```sql
SELECT * FROM books WHERE author='Neil Gaiman';
```

**14. Count customers per gender**

```sql
SELECT gender, COUNT(*) FROM customers GROUP BY gender;
```

**15. Count books per category**

```sql
SELECT c.category_name, COUNT(*) FROM books b JOIN categories c ON b.category_id=c.category_id GROUP BY c.category_name;
```

**16. Sort books by price (desc)**

```sql
SELECT * FROM books ORDER BY list_price DESC;
```

**17. Find customers with education MA or PhD**

```sql
SELECT * FROM customers WHERE education IN ('MA','PhD');
```

**18. Find stores in West Coast states (CA, OR, WA)**

```sql
SELECT * FROM stores WHERE state_code IN ('CA','OR','WA');
```

**19. Show titles and authors (project only)**

```sql
SELECT title, author FROM books;
```

**20. Find transactions for store_id = 3**

```sql
SELECT * FROM transactions WHERE store_id=3;
```

## Basic-to-Intermediate Queries (20)

**1. Join transactions to book titles and prices**

```sql
SELECT t.txn_id, t.txn_date, b.title, t.price_paid
FROM transactions t
JOIN books b ON b.book_id=t.book_id;
```

**2. Revenue per transaction (same as price_paid)**

```sql
SELECT txn_id, price_paid AS revenue FROM transactions;
```

**3. Total revenue overall**

```sql
SELECT SUM(price_paid) AS total_revenue FROM transactions;
```

**4. Revenue by store**

```sql
SELECT s.store_name, SUM(t.price_paid) AS revenue
FROM transactions t JOIN stores s ON s.store_id=t.store_id
GROUP BY s.store_name
ORDER BY revenue DESC;
```

**5. Revenue by category**

```sql
SELECT c.category_name, SUM(t.price_paid) AS revenue
FROM transactions t
JOIN books b ON b.book_id=t.book_id
JOIN categories c ON c.category_id=b.category_id
GROUP BY c.category_name
ORDER BY revenue DESC;
```

**6. Units sold per book (top 5)**

```sql
SELECT b.title, COUNT(*) AS units
FROM transactions t JOIN books b ON b.book_id=t.book_id
GROUP BY b.title
ORDER BY units DESC, b.title
LIMIT 5;
```

**7. Monthly revenue (YYYY-MM)**

```sql
SELECT DATE_FORMAT(txn_date,'%Y-%m') AS ym, SUM(price_paid) AS revenue FROM transactions GROUP BY ym ORDER BY ym;
```

**8. Average price paid vs list price per book**

```sql
SELECT b.title, ROUND(AVG(t.price_paid),2) AS avg_paid, b.list_price
FROM books b
LEFT JOIN transactions t ON t.book_id=b.book_id
GROUP BY b.book_id, b.title, b.list_price;
```

**9. Customer order counts**

```sql
SELECT customer_id, COUNT(*) AS orders_count FROM transactions GROUP BY customer_id ORDER BY orders_count DESC;
```

**10. Customers with > 3 purchases**

```sql
SELECT customer_id, COUNT(*) AS cnt FROM transactions GROUP BY customer_id HAVING COUNT(*) > 3;
```

**11. Orders per channel**

```sql
SELECT channel, COUNT(*) AS orders_cnt FROM transactions GROUP BY channel;
```

**12. Average order value per channel**

```sql
SELECT channel, ROUND(AVG(price_paid),2) AS aov FROM transactions GROUP BY channel;
```

**13. Top 5 customers by spend**

```sql
SELECT c.customer_id, c.full_name, SUM(t.price_paid) AS spend
FROM transactions t JOIN customers c ON c.customer_id=t.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY spend DESC
LIMIT 5;
```

**14. Category mix by store (units)**

```sql
SELECT s.store_name, c.category_name, COUNT(*) AS units
FROM transactions t
JOIN stores s ON s.store_id=t.store_id
JOIN books b ON b.book_id=t.book_id
JOIN categories c ON c.category_id=b.category_id
GROUP BY s.store_name, c.category_name
ORDER BY s.store_name, units DESC;
```

**15. Books never purchased (if any)**

```sql
SELECT b.*
FROM books b
LEFT JOIN transactions t ON t.book_id=b.book_id
WHERE t.txn_id IS NULL;
```

**16. Customers with no purchases (if any)**

```sql
SELECT c.*
FROM customers c
LEFT JOIN transactions t ON t.customer_id=c.customer_id
WHERE t.txn_id IS NULL;
```

**17. Most recent transaction per store (ROW_NUMBER)**

```sql
WITH r AS (
  SELECT t.*, ROW_NUMBER() OVER(PARTITION BY store_id ORDER BY txn_date DESC, txn_id DESC) rn
  FROM transactions t
)
SELECT * FROM r WHERE rn=1;
```

**18. Average spend per customer by education**

```sql
SELECT c.education, ROUND(AVG(x.spend),2) AS avg_spend
FROM (
  SELECT customer_id, SUM(price_paid) AS spend
  FROM transactions GROUP BY customer_id
) x
JOIN customers c ON c.customer_id=x.customer_id
GROUP BY c.education
ORDER BY avg_spend DESC;
```

**19. Revenue by state (store state)**

```sql
SELECT s.state_code, SUM(t.price_paid) AS revenue
FROM transactions t JOIN stores s ON s.store_id=t.store_id
GROUP BY s.state_code
ORDER BY revenue DESC;
```

## Intermediate Queries (20)

**1. CTE: top 3 books by revenue per category**

```sql
WITH book_rev AS (
  SELECT b.book_id, b.title, b.category_id, SUM(t.price_paid) AS revenue
  FROM books b JOIN transactions t ON t.book_id=b.book_id
  GROUP BY b.book_id, b.title, b.category_id
), ranked AS (
  SELECT br.*, ROW_NUMBER() OVER(PARTITION BY br.category_id ORDER BY br.revenue DESC) rn
  FROM book_rev br
)
SELECT c.category_name, title, revenue
FROM ranked r JOIN categories c ON c.category_id=r.category_id
WHERE rn <= 3;
```

**2. CTE: rank customers by spend (top 10)**

```sql
WITH cust_spend AS (
  SELECT c.customer_id, c.full_name, SUM(t.price_paid) AS spend
  FROM customers c JOIN transactions t ON t.customer_id=c.customer_id
  GROUP BY c.customer_id, c.full_name
)
SELECT *, RANK() OVER(ORDER BY spend DESC) AS rnk
FROM cust_spend
ORDER BY rnk
LIMIT 10;
```

**3. CTE: month-over-month revenue and growth**

```sql
WITH m AS (
  SELECT DATE_FORMAT(txn_date,'%Y-%m') AS ym, SUM(price_paid) AS rev
  FROM transactions GROUP BY ym
), g AS (
  SELECT ym, rev, LAG(rev) OVER(ORDER BY ym) AS prev_rev
  FROM m
)
SELECT ym, rev,
       ROUND(100.0*(rev - prev_rev)/NULLIF(prev_rev,0),2) AS mom_pct
FROM g;
```

**4. Window: z-score of price paid per book**

```sql
SELECT book_id, price_paid,
        (price_paid - AVG(price_paid) OVER(PARTITION BY book_id))
        / NULLIF(STDDEV_POP(price_paid) OVER(PARTITION BY book_id),0) AS z
FROM transactions;
```

**5. CTE: best-selling category per store (by units)**

```sql
WITH store_cat AS (
  SELECT s.store_id, c.category_id, COUNT(*) AS units
  FROM transactions t
  JOIN stores s ON s.store_id=t.store_id
  JOIN books b ON b.book_id=t.book_id
  JOIN categories c ON c.category_id=b.category_id
  GROUP BY s.store_id, c.category_id
), ranked AS (
  SELECT *, ROW_NUMBER() OVER(PARTITION BY store_id ORDER BY units DESC) rn
  FROM store_cat
)
SELECT st.store_name, c.category_name, r.units
FROM ranked r
JOIN stores st ON st.store_id=r.store_id
JOIN categories c ON c.category_id=r.category_id
WHERE rn=1;
```

**6. CTE: customers who bought in both channels**

```sql
WITH ch AS (
  SELECT customer_id, COUNT(DISTINCT channel) AS ch_ct
  FROM transactions GROUP BY customer_id
)
SELECT c.customer_id, c.full_name
FROM ch JOIN customers c ON c.customer_id=ch.customer_id
WHERE ch_ct=2;
```

**7. CTE: average price paid vs list by category**

```sql
WITH paid AS (
  SELECT b.category_id, AVG(t.price_paid) AS avg_paid
  FROM transactions t JOIN books b ON b.book_id=t.book_id
  GROUP BY b.category_id
)
SELECT c.category_name, ROUND(p.avg_paid,2) AS avg_paid
FROM paid p JOIN categories c ON c.category_id=p.category_id;
```

**8. CTE: top author per store (by units)**

```sql
WITH au AS (
  SELECT s.store_id, b.author, COUNT(*) AS units
  FROM transactions t JOIN stores s ON s.store_id=t.store_id
  JOIN books b ON b.book_id=t.book_id
  GROUP BY s.store_id, b.author
), r AS (
  SELECT *, ROW_NUMBER() OVER(PARTITION BY store_id ORDER BY units DESC) rn
  FROM au
)
SELECT st.store_name, author, units
FROM r JOIN stores st ON st.store_id=r.store_id
WHERE rn=1;
```

**9. Window: latest purchase date per customer**

```sql
SELECT customer_id, txn_date,
        MAX(txn_date) OVER(PARTITION BY customer_id) AS last_purchase
FROM transactions;
```

**10. CTE: revenue share by category**

```sql
WITH cat_rev AS (
  SELECT c.category_id, SUM(t.price_paid) rev
  FROM transactions t
  JOIN books b ON b.book_id=t.book_id
  JOIN categories c ON c.category_id=b.category_id
  GROUP BY c.category_id
), tot AS (SELECT SUM(rev) AS total_rev FROM cat_rev)
SELECT c.category_name, cr.rev,
       ROUND(100.0*cr.rev/t.total_rev,2) AS pct_share
FROM cat_rev cr CROSS JOIN tot t JOIN categories c ON c.category_id=cr.category_id
ORDER BY pct_share DESC;
```

**11. CTE: best month for each store (by revenue)**

```sql
WITH s_m AS (
  SELECT s.store_id, DATE_FORMAT(t.txn_date,'%Y-%m') ym, SUM(t.price_paid) rev
  FROM transactions t JOIN stores s ON s.store_id=t.store_id
  GROUP BY s.store_id, ym
), r AS (
  SELECT *, ROW_NUMBER() OVER(PARTITION BY store_id ORDER BY rev DESC) rn
  FROM s_m
)
SELECT st.store_name, ym, rev
FROM r JOIN stores st ON st.store_id=r.store_id
WHERE rn=1;
```

**12. CTE: customers whose AOV > overall AOV**

```sql
WITH per_cust AS (
  SELECT customer_id, AVG(price_paid) AS aov FROM transactions GROUP BY customer_id
), overall AS (
  SELECT AVG(price_paid) AS global_aov FROM transactions
)
SELECT c.customer_id, c.full_name, p.aov
FROM per_cust p
JOIN customers c ON c.customer_id=p.customer_id, overall
WHERE p.aov > overall.global_aov;
```

**13. CTE: books with median price paid (per title)**

```sql
WITH med AS (
  SELECT book_id, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price_paid) AS median_paid
  FROM transactions GROUP BY book_id
)
SELECT b.title, m.median_paid
FROM med m JOIN books b ON b.book_id=m.book_id
ORDER BY median_paid DESC;
```

**14. CTE: identify slow months (revenue < rolling 3-month avg)**

```sql
WITH m AS (
  SELECT DATE_FORMAT(txn_date,'%Y-%m') ym, SUM(price_paid) rev
  FROM transactions GROUP BY ym
), r AS (
  SELECT ym, rev,
         AVG(rev) OVER(ORDER BY ym ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING) AS roll3
  FROM m
)
SELECT ym, rev, roll3
FROM r
WHERE roll3 IS NOT NULL AND rev < roll3;
```

**15. CTE: repeat buyers (≥ 2 distinct months)**

```sql
WITH per_cust AS (
  SELECT customer_id, COUNT(DISTINCT DATE_FORMAT(txn_date,'%Y-%m')) AS active_months
  FROM transactions GROUP BY customer_id
)
SELECT c.customer_id, c.full_name, active_months
FROM per_cust pc JOIN customers c ON c.customer_id=pc.customer_id
WHERE active_months >= 2;
```

**16. CTE: category breadth per customer**

```sql
WITH breadth AS (
  SELECT customer_id, COUNT(DISTINCT b.category_id) AS cat_count
  FROM transactions t JOIN books b ON b.book_id=t.book_id
  GROUP BY customer_id
)
SELECT c.customer_id, c.full_name, cat_count
FROM breadth br JOIN customers c ON c.customer_id=br.customer_id
ORDER BY cat_count DESC, c.full_name;
```

**17. CTE: store that sells the most Technology books**

```sql
WITH tech_units AS (
  SELECT s.store_id, COUNT(*) AS units
  FROM transactions t JOIN stores s ON s.store_id=t.store_id
  JOIN books b ON b.book_id=t.book_id
  JOIN categories c ON c.category_id=b.category_id
  WHERE c.category_name='Technology'
  GROUP BY s.store_id
)
SELECT st.store_name, tu.units
FROM tech_units tu JOIN stores st ON st.store_id=tu.store_id
ORDER BY tu.units DESC
LIMIT 1;
```

**18. CTE: author share within Fiction**

```sql
WITH fic AS (
  SELECT b.author, COUNT(*) AS units
  FROM transactions t JOIN books b ON b.book_id=t.book_id
  JOIN categories c ON c.category_id=b.category_id
  WHERE c.category_name='Fiction'
  GROUP BY b.author
), tot AS (SELECT SUM(units) AS total_u FROM fic)
SELECT author, units, ROUND(100.0*units/t.total_u,2) AS pct_share
FROM fic CROSS JOIN tot
ORDER BY units DESC;
```

**19. CTE: top 3 states by average transaction value**

```sql
WITH s_avg AS (
  SELECT s.state_code, AVG(t.price_paid) AS aov
  FROM transactions t JOIN stores s ON s.store_id=t.store_id
  GROUP BY s.state_code
)
SELECT * FROM s_avg ORDER BY aov DESC LIMIT 3;
```
