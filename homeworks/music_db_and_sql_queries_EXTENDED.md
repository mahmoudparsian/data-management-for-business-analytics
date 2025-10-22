# Extended Schema (Music Streaming Analytics)

Extend this dataset with one or two more dimensions to simulate a real-world analytics case (e.g., streaming service dashboard).

For extended, can you provide a complete example, integrate subscriptions with users and play, complete schema, sample rows, 18 queries (6 simple, 6 intermediate, 6 with sub-queries using WITH and ranking functions)

Excellent 🚀 Let’s build a complete, extended music streaming schema including subscriptions and devices, populate with sample rows, and provide 18 meaningful queries (6 simple, 6 intermediate, 6 advanced with WITH + ranking).

⸻

# 🎼 1. Extended Schema (Music Streaming Analytics)

~~~sql
-- Fact Table
CREATE TABLE plays_fact (
    play_id INT PRIMARY KEY,
    date_id INT,
    user_id INT,
    music_id INT,
    device_id INT,
    play_count INT,
    play_duration INT,
    FOREIGN KEY (date_id) REFERENCES date_dim(date_id),
    FOREIGN KEY (user_id) REFERENCES users_dim(user_id),
    FOREIGN KEY (music_id) REFERENCES music_dim(music_id),
    FOREIGN KEY (device_id) REFERENCES device_dim(device_id)
);

-- Users Dimension
CREATE TABLE users_dim (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50),
    age INT,
    country VARCHAR(50),
    subscription_id INT,
    FOREIGN KEY (subscription_id) REFERENCES subscription_dim(subscription_id)
);

-- Music Dimension
CREATE TABLE music_dim (
    music_id INT PRIMARY KEY,
    song_name VARCHAR(100),
    artist VARCHAR(100),
    genre VARCHAR(50)
);

-- Date Dimension
CREATE TABLE date_dim (
    date_id INT PRIMARY KEY,
    date DATE,
    year INT,
    quarter VARCHAR(5),
    month VARCHAR(10)
);

-- Subscription Dimension
CREATE TABLE subscription_dim (
    subscription_id INT PRIMARY KEY,
    subscription_type VARCHAR(50),
    monthly_fee DECIMAL(5,2)
);

-- Device Dimension
CREATE TABLE device_dim (
    device_id INT PRIMARY KEY,
    device_type VARCHAR(50)
);
~~~
⸻

# 📊 2. Sample Data

~~~sql
-- Subscriptions
INSERT INTO subscription_dim VALUES
(1, 'Free', 0.00),
(2, 'Premium', 9.99),
(3, 'Family', 14.99);

-- Devices
INSERT INTO device_dim VALUES
(1, 'Mobile'),
(2, 'Desktop'),
(3, 'Smart Speaker');

-- Users
INSERT INTO users_dim VALUES
(1, 'Alice', 25, 'USA', 2),
(2, 'Bob', 30, 'UK', 1),
(3, 'Charlie', 22, 'Canada', 3),
(4, 'David', 28, 'USA', 2),
(5, 'Emily', 27, 'UK', 1);

-- Music
INSERT INTO music_dim VALUES
(1, 'Song A', 'Artist X', 'Pop'),
(2, 'Song B', 'Artist Y', 'Rock'),
(3, 'Song C', 'Artist Z', 'Jazz');

-- Dates
INSERT INTO date_dim VALUES
(1, '2024-01-01', 2024, 'Q1', 'Jan'),
(2, '2024-02-01', 2024, 'Q1', 'Feb'),
(3, '2024-03-01', 2024, 'Q1', 'Mar'),
(4, '2024-04-01', 2024, 'Q2', 'Apr'),
(5, '2024-05-01', 2024, 'Q2', 'May');

-- Plays
INSERT INTO plays_fact VALUES
(1, 1, 1, 1, 1, 3, 180),
(2, 2, 2, 2, 2, 5, 250),
(3, 3, 3, 3, 3, 2, 120),
(4, 4, 4, 1, 1, 7, 420),
(5, 5, 5, 2, 2, 4, 300);
~~~

⸻

✅ This schema + 18 queries covers:

    •    Simple lookups (users, songs, devices, dates)
    •    Intermediate aggregations (totals, averages, grouping)
    •    Advanced analytics (WITH, RANK, PARTITION BY)



# 🟢 A. Six Simple Queries
    
### 1.    List all users with their subscription type.

~~~sql
SELECT u.user_name, s.subscription_type
FROM users_dim u
JOIN subscription_dim s ON u.subscription_id = s.subscription_id;
~~~
    
### 2.    Show all songs with artist and genre.

~~~sql
SELECT song_name, artist, genre 
FROM music_dim;
~~~
    
### 3.    List all devices.

~~~sql
SELECT device_type 
FROM device_dim;
~~~

### 4.    Find all play records with play count.

~~~sql
SELECT play_id, 
       play_count 
FROM plays_fact;
~~~

### 5.    Show all plays in February 2024.

~~~sql
SELECT p.play_id, 
       d.date, 
       p.play_count
FROM plays_fact p
JOIN date_dim d ON p.date_id = d.date_id
WHERE d.month = 'Feb';
~~~
    
### 6.    Find users from the UK.

~~~sql
SELECT user_name, 
       age 
FROM users_dim 
WHERE country = 'UK';
~~~

⸻

# 🟡 B. Six Intermediate Queries
    
### 7.    Total plays by each user.

~~~sql
SELECT u.user_name, SUM(p.play_count) AS total_plays
FROM plays_fact p
JOIN users_dim u ON p.user_id = u.user_id
GROUP BY u.user_name;
~~~

### 8.    Total play duration per genre.

~~~sql
SELECT m.genre, 
       SUM(p.play_duration) AS total_duration
FROM plays_fact p
JOIN music_dim m ON p.music_id = m.music_id
GROUP BY m.genre;
~~~

### 9.    Plays by subscription type.

~~~sql
SELECT s.subscription_type, SUM(p.play_count) AS total_plays
FROM plays_fact p
JOIN users_dim u ON p.user_id = u.user_id
JOIN subscription_dim s ON u.subscription_id = s.subscription_id
GROUP BY s.subscription_type;
~~~
    
### 10.    Plays by device type.

~~~sql
SELECT d.device_type, 
       SUM(p.play_count) AS total_plays
FROM plays_fact p
JOIN device_dim d ON p.device_id = d.device_id
GROUP BY d.device_type;
~~~

### 11.    Total plays by month.

~~~sql
SELECT d.month, 
       SUM(p.play_count) AS total_plays
FROM plays_fact p
JOIN date_dim d ON p.date_id = d.date_id
GROUP BY d.month;
~~~

### 12.    Most played song overall.

~~~sql
SELECT m.song_name, 
       SUM(p.play_count) AS total_plays
FROM plays_fact p
JOIN music_dim m ON p.music_id = m.music_id
GROUP BY m.song_name
ORDER BY total_plays DESC
LIMIT 1;
~~~

⸻

# 🔵 C. Six Advanced Queries (WITH + Ranking)
    
### 13.    Rank users by total play count.

~~~sql
WITH user_plays AS 
(
    SELECT u.user_name, SUM(p.play_count) AS total_plays
    FROM plays_fact p
    JOIN users_dim u ON p.user_id = u.user_id
    GROUP BY u.user_name
)
SELECT user_name, total_plays,
       RANK() OVER (ORDER BY total_plays DESC) AS rank_position
FROM user_plays;
~~~
    
### 14.    Rank songs by total play duration.

~~~sql
WITH song_durations AS 
(
    SELECT m.song_name, SUM(p.play_duration) AS total_duration
    FROM plays_fact p
    JOIN music_dim m ON p.music_id = m.music_id
    GROUP BY m.song_name
)
SELECT song_name, total_duration,
       RANK() OVER (ORDER BY total_duration DESC) AS rank_position
FROM song_durations;
~~~

### 15.    Top subscription type by total plays.

~~~sql
WITH sub_plays AS
(
    SELECT s.subscription_type, SUM(p.play_count) AS total_plays
    FROM plays_fact p
    JOIN users_dim u ON p.user_id = u.user_id
    JOIN subscription_dim s ON u.subscription_id = s.subscription_id
    GROUP BY s.subscription_type
)
SELECT subscription_type, total_plays,
       RANK() OVER (ORDER BY total_plays DESC) AS rank_position
FROM sub_plays;
~~~
   
### 16. Find the top user in each country by play count.

~~~sql
WITH country_ranking AS 
(
    SELECT u.country, u.user_name, SUM(p.play_count) AS total_plays,
           RANK() OVER (PARTITION BY u.country ORDER BY SUM(p.play_count) DESC) AS rank_position
    FROM plays_fact p
    JOIN users_dim u ON p.user_id = u.user_id
    GROUP BY u.country, u.user_name
)
SELECT country, user_name, total_plays
FROM country_ranking
WHERE rank_position = 1;
~~~

### 17. Rank devices by play duration.

~~~sql
WITH device_durations AS 
(
    SELECT d.device_type, SUM(p.play_duration) AS total_duration
    FROM plays_fact p
    JOIN device_dim d ON p.device_id = d.device_id
    GROUP BY d.device_type
)
SELECT device_type, total_duration,
       RANK() OVER (ORDER BY total_duration DESC) AS rank_position
FROM device_durations;
~~~
    
### 18. Top 2 songs per genre by play count.

~~~sql
WITH genre_song_ranking AS 
(
    SELECT  m.genre, 
            m.song_name, 
            SUM(p.play_count) AS total_plays,
            RANK() OVER (PARTITION BY m.genre ORDER BY SUM(p.play_count) DESC) 
             AS rank_position
    FROM plays_fact p
    JOIN music_dim m ON p.music_id = m.music_id
    GROUP BY m.genre, m.song_name
)
SELECT genre, 
       song_name, 
       total_plays
FROM genre_song_ranking
WHERE rank_position <= 2;
~~~

⸻

