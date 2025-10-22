# Books on Cities

We have a company called books-on-cities.

## 1. Stores

1. They have 8 stores in different locations: 

~~~
store_id, store_location, city, country, ...
~~~

## 2. Customers

2. They have customers, which buy books, they buy one book at time
A customer has a 

~~~
customer_id, name, email, gender, age, city, country, ...
~~~

## 3. Books

3. We have books: a book has an 

~~~
book_id,  ISBN, title, author, category, published_date (no price here), ...
~~~

## 4. Transactions

4. We keep track of sales transactions:

~~~
sale_id,
store_id,
book_id
customer_id
purchase_date
price
...
~~~

## Tasks

The tasks we want to do are:

1. Define a mysql database schema, which covers our data story: 
lets keep everything as simple as possible

2. Populate these tables by CSV files (one file per table),
so our tables are: stores, customers, books, transactions.
The more records the better, but I do not want huge CSV files.

3. This is meant for LAB exercises (5 labs in total) by senior 
undergraduate students, who they have installed mysql database, 
but do not have exposure to databases and sql. I want to have these 
labs as progressive (starting with real basic, then basic, the 
intermediate, then intermediate 2, then advanced).  For each lab, 
I want 30 English/SQL queries. I want these queries to be meaningful 
(not just random queries).

* Lab-1: very basic

* Lab-2: basic, some intermediate

* Lab-3: some intermediate, intermediate

* Lab-4: intermediate+

* Lab-5: intermediate to advanced

Please use markdown format for all of the lab sql queries

Can you please give all of this in a downloadable zip file.

Before you work everything: should we review the schema first.
Once we agree on the schema, then you can do the work.



# ✅ Books-on-Cities — Solutions Pack (Expected Outputs, Summarized)

> Note: Values and row counts depend on your CSV load. 
> Note: Use these to **validate shape and logic**, not exact numbers.

---
## Lab 1 — Very Basic
1. **All stores** → 8 rows.
2. **Stores in UK** → London, Edinburgh (2 rows).
3. **Distinct customer cities** → A list of ~10–12 cities.
4. **Books after 2015** → Titles with `published_date >= '2016-01-01'`.
5. **Top 5 most expensive purchases** → 5 rows sorted by price desc.
... (similarly list all 30 with what they should roughly return)

---
## Lab 2 — Basics + Intro-Intermediate
- **Transactions with store + book** → Columns: `(sale_id, city, title, price)`; ~20 rows with LIMIT 20.
- **Avg price per category** → One row per category; `avg_price` decreases for Children; increases for Business/Science.
- **Customers spending > 100** → `(customer_id, name, total_spent)`; sorted desc.
- **Monthly sales count (2024)** → `(YYYY-MM, cnt)` rows, ascending by month.

---
## Lab 3 — Intermediate
- **Customers with > average # purchases** → Returns power users; shows `(customer_id, name, cnt)`.
- **Top 10 books by units** → `(title, units)`, sorted desc.
- **Stores with zero transactions in 2025** → Subset of 8 stores (possibly 0–3 stores).
- **Books above avg price (2024)** → Distinct titles priced above the avg for that period.

---
## Lab 4 — Intermediate+
- **Rank stores by total revenue** → `(store_id, city, rev, rev_rank)`; rank=1 is highest.
- **Age buckets AVG spend** → `(Under 25, 25-39, 40-59, 60+)` with `avg_spent` values.
- **MoM revenue growth** → `(month, rev, pct_growth)`; expect ± swings.
- **Best-selling book per store** → 8 rows, one per store: `(store_id, city, title, units)`.

---
## Lab 5 — Advanced
- **Most profitable store** → Single row with `(store_id, city, revenue)`.
- **Most valuable customer** → Single row `(customer_id, name, total_spent)`.
- **Top 3 authors per country** → `(country, author, rev, rnk)`; 3 per country.
- **Continuous 3-month growth stores** → `(store_id, city, ym)` rows satisfying growth condition.
- **Avg time between purchases** → `(customer_id, name, avg_days_between)`; realistic averages ~15–60 days.

---
### Tips for Verifying
- Sanity-check: Totals should add up.
- Time filters (year/month) should reduce row counts.
- If a query returns **0 rows**, check WHERE clause, dates, or joins.%
