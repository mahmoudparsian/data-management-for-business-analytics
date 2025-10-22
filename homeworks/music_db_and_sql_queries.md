# Music Database, SQL Queries, and OLAP Examples 



# 1. Data Story here...

	1. Provide a star schema with record 
	   examples in music industry: 
	   
	     users, music, plays. 
	  
	  Then provide a complete example of OLAP 
	  operations with roll-up, roll-down, slide, 
	  dice, and pivot. 
	
	2. Provide 2 queries for every olap operation.
	
	3. This example provides a **complete OLAP workflow** 
	   for a music streaming service, enabling insightful 
	   analysis of **user behaviors, music trends, and 
	   time-based patterns**.  


# 2. Star Schema for Music Streaming Analytics

A **star schema** in the music industry (for a music streaming service) consists of a 

* **fact table** (`plays_fact`) and 

* multiple **dimension tables** (`users_dim`, `music_dim`, `date_dim`).

---

### **Tables and Sample Records**

#### **Fact Table: `plays_fact`**  
Stores listening activity.

| play_id | date_id | user_id | music_id | play_count | play_duration |
|---------|--------|----------|----------|------------|---------------|
| 1       | 1      | 1        | 1        | 3          | 180           |
| 2       | 2      | 2        | 2        | 5          | 250           |
| 3       | 3      | 3        | 3        | 2          | 120           |
| 4       | 4      | 4        | 1        | 7          | 420           |
| 5       | 5      | 5        | 2        | 4          | 300           |

---

#### **Dimension Table: `users_dim`**  
Stores user-related information.

| user_id | user_name | age | country  |
|---------|-----------|-----|----------|
| 1       | Alice     | 25  | USA      |
| 2       | Bob       | 30  | UK       |
| 3       | Charlie   | 22  | Canada   |
| 4       | David     | 28  | USA      |
| 5       | Emily     | 27  | UK       |

---

#### **Dimension Table: `music_dim`**  
Stores music-related information.

| music_id | song_name | artist     | genre   |
|----------|-----------|------------|---------|
| 1        | Song A    | Artist X   | Pop     |
| 2        | Song B    | Artist Y   | Rock    |
| 3        | Song C    | Artist Z   | Jazz    |

---

#### **Dimension Table: `date_dim`**  
Stores date-related information.

| date_id | date       | year | quarter | month |
|---------|------------|------|---------|-------|
| 1       | 2024-01-01 | 2024 | Q1      | Jan   |
| 2       | 2024-02-01 | 2024 | Q1      | Feb   |
| 3       | 2024-03-01 | 2024 | Q1      | Mar   |
| 4       | 2024-04-01 | 2024 | Q2      | Apr   |
| 5       | 2024-05-01 | 2024 | Q2      | May   |


---


# 3. SQL Queries

Consider the following 4 tables for music database
with some sample records.

Can you provide

A. 6 Simple, but meaningful English queries and 
   an associated SQL query

B. 6 Intermediate, but meaningful English queries 
   and an associated SQL query

C. 6 Intermediate (using sub-queries using WITH and 
   ranking functions), but meaningful English queries 
   and an associated SQL query


#### **Fact Table: `plays_fact`**  
Stores listening activity.

| play_id | date_id | user_id | music_id | play_count | play_duration |
|---------|--------|----------|----------|------------|---------------|
| 1       | 1      | 1        | 1        | 3          | 180           |
| 2       | 2      | 2        | 2        | 5          | 250           |
| 3       | 3      | 3        | 3        | 2          | 120           |
| 4       | 4      | 4        | 1        | 7          | 420           |
| 5       | 5      | 5        | 2        | 4          | 300           |

---

#### **Dimension Table: `users_dim`**  
Stores user-related information.

| user_id | user_name | age | country  |
|---------|-----------|-----|----------|
| 1       | Alice     | 25  | USA      |
| 2       | Bob       | 30  | UK       |
| 3       | Charlie   | 22  | Canada   |
| 4       | David     | 28  | USA      |
| 5       | Emily     | 27  | UK       |

---

#### **Dimension Table: `music_dim`**  
Stores music-related information.

| music_id | song_name | artist     | genre   |
|----------|-----------|------------|---------|
| 1        | Song A    | Artist X   | Pop     |
| 2        | Song B    | Artist Y   | Rock    |
| 3        | Song C    | Artist Z   | Jazz    |

---

#### **Dimension Table: `date_dim`**  
Stores date-related information.

| date_id | date       | year | quarter | month |
|---------|------------|------|---------|-------|
| 1       | 2024-01-01 | 2024 | Q1      | Jan   |
| 2       | 2024-02-01 | 2024 | Q1      | Feb   |
| 3       | 2024-03-01 | 2024 | Q1      | Mar   |
| 4       | 2024-04-01 | 2024 | Q2      | Apr   |
| 5       | 2024-05-01 | 2024 | Q2      | May   |



⸻

# 🟢 4. Six Simple Queries


### 1.	List all users and their countries.

~~~sql
SELECT 
       user_name, 
       country
FROM 
       users_dim;
~~~


### 2.	Find all songs with their artists.

~~~sql
SELECT 
      song_name, 
      artist
FROM 
      music_dim;
~~~

### 3.	Show all play records with play count and duration.

~~~sql
SELECT 
       play_id, 
       play_count, 
       play_duration
FROM 
       plays_fact;
~~~

### 4.	Find all plays made in January 2024.

~~~sql
SELECT 
       p.play_id, 
       d.date, 
       p.play_count
FROM
       plays_fact p
JOIN 
       date_dim d ON p.date_id = d.date_id
WHERE 
       d.month = 'Jan';
~~~

### 5.	List all songs in the ‘Rock’ genre.

~~~sql
SELECT 
      song_name, 
      artist
FROM 
      music_dim
WHERE 
      genre = 'Rock';
~~~

### 6.	Find users from the USA.

~~~sql
SELECT 
       user_name, 
       age
FROM 
       users_dim
WHERE 
       country = 'USA';
~~~


⸻

## 🟡 5. Six Intermediate Queries

### 7.	Find the total play count for each user.

~~~sql
SELECT 
      u.user_name, 
      SUM(p.play_count) AS total_plays
FROM 
      plays_fact p
JOIN 
      users_dim u ON p.user_id = u.user_id
GROUP BY 
      u.user_name;
~~~

### 8.	Find the total play duration for each genre.

~~~sql
SELECT 
      m.genre, 
      SUM(p.play_duration) AS total_duration
FROM 
      plays_fact p
JOIN 
      music_dim m ON p.music_id = m.music_id
GROUP BY 
      m.genre;
~~~

### 9.	Get the number of plays per country.

~~~sql
SELECT  u.country, 
        SUM(p.play_count) AS total_plays
FROM 
        plays_fact p
JOIN 
        users_dim u ON p.user_id = u.user_id
GROUP BY 
        u.country;
~~~

### 10.	Find the average play duration per song.

~~~sql
SELECT  m.song_name, 
        AVG(p.play_duration) AS avg_duration
FROM 
        plays_fact p
JOIN 
        music_dim m ON p.music_id = m.music_id
GROUP BY 
        m.song_name;
~~~

### 11.	Show total plays by quarter.

~~~sql
SELECT   d.quarter, 
         SUM(p.play_count) AS total_plays
FROM 
         plays_fact p
JOIN 
         date_dim d ON p.date_id = d.date_id
GROUP BY 
         d.quarter;
~~~

### 12.	Find the most played song overall (highest total play_count).

~~~sql
SELECT   m.song_name, 
         SUM(p.play_count) AS total_plays
FROM 
         plays_fact p
JOIN 
         music_dim m ON p.music_id = m.music_id
GROUP BY 
         m.song_name
ORDER BY 
         total_plays DESC
LIMIT 1;
~~~


⸻

# 🔵 6. Six Advanced Queries (WITH + Ranking Functions)
	
### 13.	Rank users by total play count.

~~~sql
WITH user_play_counts AS 
(
    SELECT u.user_name, 
           SUM(p.play_count) AS total_plays
    FROM 
           plays_fact p
    JOIN 
           users_dim u ON p.user_id = u.user_id
    GROUP BY 
           u.user_name
)
SELECT 
       user_name, 
       total_plays,
       RANK() OVER (ORDER BY total_plays DESC) AS rank_position
FROM 
       user_play_counts;
~~~

### 14.	Rank songs by total play duration.

~~~sql
WITH song_durations AS 
(
    SELECT 
           m.song_name, 
           SUM(p.play_duration) AS total_duration
    FROM 
           plays_fact p
    JOIN 
           music_dim m ON p.music_id = m.music_id
    GROUP BY 
           m.song_name
)
SELECT song_name, 
       total_duration,
       RANK() OVER (ORDER BY total_duration DESC) AS rank_position
FROM 
       song_durations;
~~~

### 15.	Find the top song per genre (by total play count).

~~~sql
WITH genre_ranking AS
(
    SELECT m.genre, 
           m.song_name, 
           SUM(p.play_count) AS total_plays,
           RANK() OVER (PARTITION BY m.genre ORDER BY SUM(p.play_count) DESC) AS rank_position
    FROM 
           plays_fact p
    JOIN 
           music_dim m ON p.music_id = m.music_id
    GROUP BY 
           m.genre, m.song_name
)
SELECT genre, song_name, total_plays
FROM genre_ranking
WHERE rank_position = 1;
~~~

### 16.	Find the top user per country by play count.

~~~sql
WITH country_user_ranking AS 
(
    SELECT u.country, 
           u.user_name, 
           SUM(p.play_count) AS total_plays,
           RANK() OVER (PARTITION BY u.country ORDER BY SUM(p.play_count) DESC) AS rank_position
    FROM plays_fact p
    JOIN users_dim u ON p.user_id = u.user_id
    GROUP BY u.country, u.user_name
)
SELECT country, user_name, total_plays
FROM country_user_ranking
WHERE rank_position = 1;
~~~

### 17.	Find monthly play totals and rank months by play count.

~~~sql
WITH monthly_totals AS 
(
    SELECT d.month, 
           SUM(p.play_count) AS total_plays
    FROM plays_fact p
    JOIN date_dim d ON p.date_id = d.date_id
    GROUP BY d.month
)
SELECT month, 
       total_plays,
       RANK() OVER (ORDER BY total_plays DESC) AS rank_position
FROM monthly_totals;
~~~

### 18.	Find the top 2 users overall by play duration.

~~~sql
WITH user_durations AS 
(
    SELECT  u.user_name, 
            SUM(p.play_duration) AS total_duration
    FROM plays_fact p
    JOIN users_dim u ON p.user_id = u.user_id
    GROUP BY u.user_name
)
SELECT user_name, total_duration,
       RANK() OVER (ORDER BY total_duration DESC) AS rank_position
FROM user_durations
WHERE rank_position <= 2;
~~~

⸻

----

# 7. OLAP Operations

## Summary of OLAP Operations

| **Operation** | **Concept**                                    | **Example Query**              |
|---------------|------------------------------------------------|--------------------------------|
| **Roll-Up**   | Aggregate data up (e.g., monthly → quarterly)  | Total plays by quarter.        |
| **Roll-Down** | Drill into details (e.g., quarterly → monthly) | Play counts by song            |
| **Slice**     | Filter on a single dimension                   | Play counts for Q1 2024        |
| **Dice**      | Filter on multiple dimensions                  | Play counts for Rock in Q1 2024|
| **Pivot**     | Reshape data for comparison                    | Monthly play counts as columns |



## **A. Roll-Up (Aggregating Data Upward)**

	Roll-up aggregates data **from lower levels to higher levels** 
	(e.g., from months to quarters or years).

#### **Query 1: ROLL-UP: Total Plays by Quarter**

```sql
SELECT d.year, 
       d.quarter, 
       SUM(f.play_count) AS total_plays
FROM 
    plays_fact f
JOIN 
    date_dim d ON f.date_id = d.date_id
GROUP BY 
    d.year, d.quarter;
```

### **Query 2: ROLL-UP: Total Play Duration by Year**

```sql
SELECT d.year, 
       SUM(f.play_duration) AS total_play_duration
FROM 
       plays_fact f
JOIN 
       date_dim d ON f.date_id = d.date_id
GROUP BY 
      d.year;
```


### **Query 3: ROLL-UP: Total Plays by Quarter with Ranking**

```sql
with subquery as (
    SELECT d.year, 
           d.quarter, 
           SUM(f.play_count) AS total_plays
    FROM plays_fact f
    JOIN date_dim d ON f.date_id = d.date_id
    GROUP BY d.year, d.quarter
)
SELECT year, 
       quarter, 
       total_plays, 
       RANK() OVER (PARTITION BY year ORDER BY total_plays DESC) AS rank_by_quarter
FROM 
    subquery;

```

### **Query 4: ROLL-UP: Total Play Duration by Year with Running Total**

```sql
with subquery as
(
    SELECT d.year, SUM(f.play_duration) AS total_play_duration
    FROM plays_fact f
    JOIN date_dim d ON f.date_id = d.date_id
    GROUP BY d.year
) 
SELECT year, 
       total_play_duration, 
       SUM(total_play_duration) OVER (ORDER BY year) AS running_total
FROM 
    subquery;
```

### **Query 5: ROLL-UP: Genre-wise Play Count Roll-up to Yearly Level**

```sql
SELECT year, 
       genre, 
       SUM(play_count) AS total_plays
FROM 
     plays_fact f
JOIN 
     music_dim m ON f.music_id = m.music_id
JOIN 
     date_dim d ON f.date_id = d.date_id
GROUP BY 
     ROLLUP(year, genre);
```


---

## **B. Roll-Down (Drilling Down into More Detail)**

	Roll-down **moves from summarized data to more detailed levels** 
	(e.g., from years to quarters or months).

### **Query 1: Roll-Down: Play Counts by Month (Drilling down from Quarter)**

```sql
SELECT d.year, 
       d.quarter, 
       d.month, SUM(f.play_count) AS total_plays
FROM 
     plays_fact f
JOIN 
     date_dim d ON f.date_id = d.date_id
GROUP BY 
     d.year, d.quarter, d.month;
```

### **Query 2: Roll-Down: Play Counts by Song (Drilling down from Genre)**

```sql
SELECT m.genre, 
       m.song_name, 
       SUM(f.play_count) AS total_plays
FROM 
     plays_fact f
JOIN 
     music_dim m ON f.music_id = m.music_id
GROUP BY 
     m.genre, m.song_name;
```

#### **Query 3: Roll-Down: Top 3 Most Played Songs per Genre for a Specific Quarter**

```sql
SELECT genre, 
       song_name, 
       total_plays, 
       RANK() OVER (PARTITION BY genre ORDER BY total_plays DESC) AS rnk
FROM (
    SELECT m.genre, 
           m.song_name, 
           SUM(f.play_count) AS total_plays
    FROM plays_fact f
    JOIN music_dim m ON f.music_id = m.music_id
    JOIN date_dim d ON f.date_id = d.date_id
    WHERE d.quarter = 'Q1' AND d.year = 2024
    GROUP BY m.genre, m.song_name
) AS subquery
WHERE rnk <= 3;
```

#### **Query 4: Roll-Down: Monthly Play Distribution for Top Songs**

```sql
SELECT year, 
       month, 
       song_name, 
       total_plays
FROM (
    SELECT d.year, 
           d.month, 
           m.song_name, 
           SUM(f.play_count) AS total_plays,
           RANK() OVER (PARTITION BY d.year, d.month ORDER BY SUM(f.play_count) DESC) AS rnk
    FROM plays_fact f
    JOIN date_dim d ON f.date_id = d.date_id
    JOIN music_dim m ON f.music_id = m.music_id
    GROUP BY d.year, d.month, m.song_name
) AS subquery
WHERE rnk <= 5;
```

#### **Query 5: Roll-Down: Play Count Breakdown from Year to Month**

```sql
SELECT year, 
       quarter, 
       month, 
       SUM(play_count) AS total_plays
FROM plays_fact f
JOIN date_dim d ON f.date_id = d.date_id
GROUP BY ROLLUP(year, quarter, month);
```

---

## **C. Slice (Filtering One Dimension)**

Slice **focuses on a single dimension to analyze a subset of the data**.

### **Query 1: Slice: Play Counts for Q1 2024**

```sql
SELECT d.month, 
       SUM(f.play_count) AS total_plays
FROM 
     plays_fact f
JOIN 
     date_dim d ON f.date_id = d.date_id
WHERE 
     d.quarter = 'Q1' AND 
     d.year = 2024
GROUP BY 
     d.month;
```

### **Query 2: Slice: Rock Genre Play Counts**

```sql
SELECT m.song_name, 
       SUM(f.play_count) AS total_plays
FROM 
     plays_fact f
JOIN 
     music_dim m ON f.music_id = m.music_id
WHERE 
     m.genre = 'Rock'
GROUP BY 
     m.song_name;
```

### Slice (Filtering One Dimension)**  

#### **Query 3: Slice: Play Counts for Q1 2024**

```sql
SELECT d.month, SUM(f.play_count) AS total_plays
FROM plays_fact f
JOIN date_dim d ON f.date_id = d.date_id
WHERE d.quarter = 'Q1' AND d.year = 2024
GROUP BY d.month;
```

#### **Query 4: Slice: Monthly Play Duration for USA Users**

```sql
SELECT d.month, SUM(f.play_duration) AS total_duration
FROM plays_fact f
JOIN users_dim u ON f.user_id = u.user_id
JOIN date_dim d ON f.date_id = d.date_id
WHERE u.country = 'USA'
GROUP BY d.month;
```

#### **Query 5: Slice: Top 5 Songs in Q2 2024**

```sql
SELECT song_name, total_plays
FROM (
    SELECT m.song_name, SUM(f.play_count) AS total_plays,
           RANK() OVER (ORDER BY SUM(f.play_count) DESC) AS rank
    FROM plays_fact f
    JOIN music_dim m ON f.music_id = m.music_id
    JOIN date_dim d ON f.date_id = d.date_id
    WHERE d.quarter = 'Q2' AND d.year = 2024
    GROUP BY m.song_name
) AS subquery
WHERE rank <= 5;
```


---

## **D. Dice (Filtering Multiple Dimensions)**

	Dice **filters data based on multiple dimensions simultaneously**.

### **Query 1: Dice: Play Counts for Rock Genre in Q1 2024**

```sql
SELECT d.month, 
       m.song_name, 
       SUM(f.play_count) AS total_plays
FROM plays_fact f
JOIN date_dim d ON f.date_id = d.date_id
JOIN music_dim m ON f.music_id = m.music_id
WHERE d.quarter = 'Q1' AND d.year = 2024 AND m.genre = 'Rock'
GROUP BY d.month, m.song_name;
```

### **Query 2: Dice: Play Counts for USA Users Listening to Pop Music**

```sql
SELECT u.user_name, 
       SUM(f.play_count) AS total_plays
FROM plays_fact f
JOIN users_dim u ON f.user_id = u.user_id
JOIN music_dim m ON f.music_id = m.music_id
WHERE u.country = 'USA' AND m.genre = 'Pop'
GROUP BY u.user_name;
```

### **Query 3: Dice: Play Counts for Rock Genre in Q1 2024**

```sql
SELECT d.month, 
       m.song_name, 
       SUM(f.play_count) AS total_plays
FROM plays_fact f
JOIN date_dim d ON f.date_id = d.date_id
JOIN music_dim m ON f.music_id = m.music_id
WHERE d.quarter = 'Q1' AND d.year = 2024 AND m.genre = 'Rock'
GROUP BY d.month, m.song_name;
```
---

### **E. Pivot (Transforming Data Representation)**
Pivot **converts row-based data into columns** for better comparison.

### **Query 1: Pivot: Monthly Play Counts as Columns**

```sql
SELECT 
    year,
    SUM(CASE WHEN month = 'Jan' THEN play_count ELSE 0 END) AS Jan_plays,
    SUM(CASE WHEN month = 'Feb' THEN play_count ELSE 0 END) AS Feb_plays,
    SUM(CASE WHEN month = 'Mar' THEN play_count ELSE 0 END) AS Mar_plays
FROM plays_fact f
JOIN date_dim d ON f.date_id = d.date_id
GROUP BY year;
```

### **Query 2: Pivot: Play Counts by Genre and Quarter**

```sql
SELECT 
    genre,
    SUM(CASE WHEN quarter = 'Q1' THEN play_count ELSE 0 END) AS Q1_plays,
    SUM(CASE WHEN quarter = 'Q2' THEN play_count ELSE 0 END) AS Q2_plays
FROM plays_fact f
JOIN music_dim m ON f.music_id = m.music_id
JOIN date_dim d ON f.date_id = d.date_id
GROUP BY genre;
```

### Pivot (Transforming Data Representation) 

### **Query 3: Pivot: Monthly Play Counts as Columns**

```sql
SELECT year,
    SUM(CASE WHEN month = 'Jan' THEN play_count ELSE 0 END) AS Jan_plays,
    SUM(CASE WHEN month = 'Feb' THEN play_count ELSE 0 END) AS Feb_plays
FROM plays_fact f
JOIN date_dim d ON f.date_id = d.date_id
GROUP BY year;
```

---


