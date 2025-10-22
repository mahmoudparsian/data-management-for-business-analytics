**Q1.** Find all users who have NULL subscription plans.
```sql
SELECT * FROM users WHERE plan IS NULL;
```

**Q2.** List the top 3 most played songs in 2020.
```sql
WITH sc AS (SELECT p.song_id, COUNT(*) AS cnt FROM plays p JOIN dates d ON p.date_id=d.date_id WHERE d.year=2020 GROUP BY p.song_id) SELECT * FROM (SELECT *, RANK() OVER (ORDER BY cnt DESC) AS rnk FROM sc) t WHERE rnk<=3;
```

**Q3.** Find the most popular artist in Spain.
```sql
SELECT s.artist, COUNT(*) AS cnt FROM plays p JOIN songs s ON p.song_id=s.song_id JOIN users u ON p.user_id=u.user_id WHERE u.country='SPAIN' GROUP BY s.artist ORDER BY cnt DESC LIMIT 1;
```

**Q4.** Find users who played at least 5 different genres.
```sql
SELECT user_id FROM (SELECT user_id, COUNT(DISTINCT s.genre) AS g FROM plays p JOIN songs s ON p.song_id=s.song_id GROUP BY user_id) t WHERE g>=5;
```

**Q5.** Rank countries by total number of plays.
```sql
SELECT u.country, COUNT(*) AS cnt, RANK() OVER (ORDER BY COUNT(*) DESC) FROM plays p JOIN users u ON p.user_id=u.user_id GROUP BY u.country;
```

**Q6.** Find devices ranked by distinct users who used them.
```sql
WITH dc AS (SELECT device_id, COUNT(DISTINCT user_id) AS ucnt FROM plays GROUP BY device_id) SELECT *, RANK() OVER (ORDER BY ucnt DESC) FROM dc;
```

**Q7.** Find songs never played in 2020 but played in 2021 or 2022.
```sql
SELECT DISTINCT p.song_id FROM plays p JOIN dates d ON p.date_id=d.date_id WHERE d.year NOT IN (2020) AND p.song_id NOT IN (SELECT DISTINCT p2.song_id FROM plays p2 JOIN dates d2 ON p2.date_id=d2.date_id WHERE d2.year=2020);
```

**Q8.** Find the most loyal premium user (highest plays).
```sql
SELECT u.user_name, COUNT(*) AS cnt FROM plays p JOIN users u ON p.user_id=u.user_id WHERE u.plan='premium' GROUP BY u.user_name ORDER BY cnt DESC LIMIT 1;
```

**Q9.** Find the user who played the highest number of distinct songs.
```sql
SELECT user_id FROM plays GROUP BY user_id ORDER BY COUNT(DISTINCT song_id) DESC LIMIT 1;
```

**Q10.** Find songs longer than the average duration.
```sql
SELECT * FROM songs WHERE duration>(SELECT AVG(duration) FROM songs);
```

**Q11.** Using CTE, calculate total plays per song.
```sql
WITH sc AS (SELECT song_id, COUNT(*) AS cnt FROM plays GROUP BY song_id) SELECT * FROM sc;
```

**Q12.** Rank songs globally by play count.
```sql
WITH sc AS (SELECT song_id, COUNT(*) AS cnt FROM plays GROUP BY song_id) SELECT *, RANK() OVER (ORDER BY cnt DESC) FROM sc;
```

**Q13.** Find the most active user per country (CTE + RANK).
```sql
WITH uc AS (SELECT u.country, u.user_name, COUNT(*) AS cnt FROM plays p JOIN users u ON p.user_id=u.user_id GROUP BY u.country, u.user_name) SELECT * FROM (SELECT *, RANK() OVER (PARTITION BY country ORDER BY cnt DESC) AS rnk FROM uc) t WHERE rnk=1;
```

**Q14.** Find the top 2 most played songs per genre.
```sql
WITH sc AS (SELECT s.genre, s.song_id, COUNT(*) AS cnt FROM plays p JOIN songs s ON p.song_id=s.song_id GROUP BY s.genre, s.song_id) SELECT * FROM (SELECT *, RANK() OVER (PARTITION BY genre ORDER BY cnt DESC) AS rnk FROM sc) t WHERE rnk<=2;
```

**Q15.** Find the most played song per quarter.
```sql
WITH qc AS (SELECT d.quarter, p.song_id, COUNT(*) AS cnt FROM plays p JOIN dates d ON p.date_id=d.date_id GROUP BY d.quarter, p.song_id) SELECT * FROM (SELECT *, RANK() OVER (PARTITION BY quarter ORDER BY cnt DESC) AS rnk FROM qc) t WHERE rnk=1;
```

**Q16.** Find artists ranked by average song duration.
```sql
WITH ac AS (SELECT s.artist, AVG(s.duration) AS avg_dur FROM songs s GROUP BY s.artist) SELECT *, RANK() OVER (ORDER BY avg_dur DESC) FROM ac;
```

**Q17.** Count the number of distinct songs played per user.
```sql
SELECT user_id, COUNT(DISTINCT song_id) FROM plays GROUP BY user_id;
```

**Q18.** Find the most popular genre in 2020.
```sql
WITH gc AS (SELECT s.genre, COUNT(*) AS cnt FROM plays p JOIN songs s ON p.song_id=s.song_id JOIN dates d ON p.date_id=d.date_id WHERE d.year=2020 GROUP BY s.genre) SELECT * FROM gc ORDER BY cnt DESC LIMIT 1;
```

**Q19.** Find users who played songs on more than one device.
```sql
SELECT user_id FROM plays GROUP BY user_id HAVING COUNT(DISTINCT device_id)>1;
```

**Q20.** Summarize per user: user_name, country, total plays, distinct songs played, and most played genre.
```sql
WITH up AS (SELECT u.user_name, u.country, COUNT(*) AS total_plays, COUNT(DISTINCT p.song_id) AS distinct_songs FROM plays p JOIN users u ON p.user_id=u.user_id GROUP BY u.user_name, u.country) SELECT * FROM up;
```

