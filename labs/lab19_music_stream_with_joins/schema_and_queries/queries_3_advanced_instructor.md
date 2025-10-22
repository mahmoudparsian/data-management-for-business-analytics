**Q1.** Find the most played song overall using a CTE.
```sql
WITH song_counts AS (SELECT song_id, COUNT(*) AS play_count FROM plays GROUP BY song_id) SELECT song_id, play_count FROM song_counts ORDER BY play_count DESC LIMIT 1;
```

**Q2.** Find the top 3 most played songs using RANK.
```sql
WITH song_counts AS (SELECT song_id, COUNT(*) AS play_count FROM plays GROUP BY song_id) SELECT song_id, play_count, RANK() OVER (ORDER BY play_count DESC) AS rnk FROM song_counts WHERE RANK() OVER (ORDER BY play_count DESC)<=3;
```

**Q3.** Find the most active user per country.
```sql
WITH user_counts AS (SELECT u.country, u.user_name, COUNT(*) AS total_plays FROM plays p JOIN users u ON p.user_id=u.user_id GROUP BY u.country, u.user_name) SELECT * FROM (SELECT *, RANK() OVER (PARTITION BY country ORDER BY total_plays DESC) AS rnk FROM user_counts) t WHERE rnk=1;
```

**Q4.** Find the least played song using CTE.
```sql
WITH song_counts AS (SELECT song_id, COUNT(*) AS play_count FROM plays GROUP BY song_id) SELECT song_id, play_count FROM song_counts ORDER BY play_count ASC LIMIT 1;
```

**Q5.** Find the average plays per user using CTE.
```sql
WITH user_counts AS (SELECT user_id, COUNT(*) AS total_plays FROM plays GROUP BY user_id) SELECT AVG(total_plays) AS avg_per_user FROM user_counts;
```

**Q6.** Find the top 2 artists by play count.
```sql
WITH artist_counts AS (SELECT s.artist, COUNT(*) AS total_plays FROM plays p JOIN songs s ON p.song_id=s.song_id GROUP BY s.artist) SELECT * FROM (SELECT *, RANK() OVER (ORDER BY total_plays DESC) AS rnk FROM artist_counts) t WHERE rnk<=2;
```

**Q7.** Find the most popular genre using CTE.
```sql
WITH genre_counts AS (SELECT s.genre, COUNT(*) AS total_plays FROM plays p JOIN songs s ON p.song_id=s.song_id GROUP BY s.genre) SELECT * FROM genre_counts ORDER BY total_plays DESC LIMIT 1;
```

**Q8.** Find users who played more than average songs.
```sql
WITH user_counts AS (SELECT user_id, COUNT(DISTINCT song_id) AS songs_played FROM plays GROUP BY user_id) SELECT * FROM user_counts WHERE songs_played > (SELECT AVG(songs_played) FROM user_counts);
```

**Q9.** Find the user with maximum distinct songs played.
```sql
WITH user_counts AS (SELECT user_id, COUNT(DISTINCT song_id) AS songs_played FROM plays GROUP BY user_id) SELECT * FROM user_counts ORDER BY songs_played DESC LIMIT 1;
```

**Q10.** Find songs never played by any user.
```sql
SELECT * FROM songs s WHERE NOT EXISTS (SELECT 1 FROM plays p WHERE p.song_id=s.song_id);
```

**Q11.** Find devices ranked by number of plays.
```sql
WITH device_counts AS (SELECT device_id, COUNT(*) AS play_count FROM plays GROUP BY device_id) SELECT *, RANK() OVER (ORDER BY play_count DESC) AS rnk FROM device_counts;
```

**Q12.** Find users ranked by number of plays.
```sql
WITH user_counts AS (SELECT user_id, COUNT(*) AS play_count FROM plays GROUP BY user_id) SELECT *, RANK() OVER (ORDER BY play_count DESC) AS rnk FROM user_counts;
```

**Q13.** Find the most played artist per country.
```sql
WITH artist_counts AS (SELECT u.country, s.artist, COUNT(*) AS total_plays FROM plays p JOIN songs s ON p.song_id=s.song_id JOIN users u ON p.user_id=u.user_id GROUP BY u.country, s.artist) SELECT * FROM (SELECT *, RANK() OVER (PARTITION BY country ORDER BY total_plays DESC) AS rnk FROM artist_counts) t WHERE rnk=1;
```

**Q14.** Find the most played genre in 2020.
```sql
WITH genre_counts AS (SELECT s.genre, COUNT(*) AS total_plays FROM plays p JOIN songs s ON p.song_id=s.song_id JOIN dates d ON p.date_id=d.date_id WHERE d.year=2020 GROUP BY s.genre) SELECT * FROM genre_counts ORDER BY total_plays DESC LIMIT 1;
```

**Q15.** Find users who played songs on more than one device.
```sql
WITH user_devices AS (SELECT user_id, COUNT(DISTINCT device_id) AS device_count FROM plays GROUP BY user_id) SELECT * FROM user_devices WHERE device_count>1;
```

**Q16.** Find the top 2 most played songs per genre.
```sql
WITH song_counts AS (SELECT s.genre, s.song_id, COUNT(*) AS play_count FROM plays p JOIN songs s ON p.song_id=s.song_id GROUP BY s.genre, s.song_id) SELECT * FROM (SELECT *, RANK() OVER (PARTITION BY genre ORDER BY play_count DESC) AS rnk FROM song_counts) t WHERE rnk<=2;
```

**Q17.** Find the most played song per quarter.
```sql
WITH quarter_counts AS (SELECT d.quarter, p.song_id, COUNT(*) AS play_count FROM plays p JOIN dates d ON p.date_id=d.date_id GROUP BY d.quarter, p.song_id) SELECT * FROM (SELECT *, RANK() OVER (PARTITION BY quarter ORDER BY play_count DESC) AS rnk FROM quarter_counts) t WHERE rnk=1;
```

**Q18.** Find users ranked by plays within their country.
```sql
WITH user_counts AS (SELECT u.country, u.user_name, COUNT(*) AS total_plays FROM plays p JOIN users u ON p.user_id=u.user_id GROUP BY u.country, u.user_name) SELECT * FROM (SELECT *, RANK() OVER (PARTITION BY country ORDER BY total_plays DESC) AS rnk FROM user_counts) t;
```

**Q19.** Find artists ranked by average song duration.
```sql
WITH artist_avg AS (SELECT s.artist, AVG(s.duration) AS avg_duration FROM songs s GROUP BY s.artist) SELECT *, RANK() OVER (ORDER BY avg_duration DESC) AS rnk FROM artist_avg;
```

**Q20.** Find songs longer than the average duration using CTE.
```sql
WITH avg_dur AS (SELECT AVG(duration) AS avg_duration FROM songs) SELECT * FROM songs WHERE duration > (SELECT avg_duration FROM avg_dur);
```