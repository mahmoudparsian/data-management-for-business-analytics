**Q1.** List all premium users from France.
```sql
SELECT * FROM users WHERE plan='premium' AND country='FRANCE';
```

**Q2.** Find all songs longer than 250 seconds.
```sql
SELECT * FROM songs WHERE duration>250;
```

**Q3.** Count the number of users per country.
```sql
SELECT country, COUNT(*) FROM users GROUP BY country;
```

**Q4.** Find the average duration of songs in each genre.
```sql
SELECT genre, AVG(duration) FROM songs GROUP BY genre;
```

**Q5.** Show the longest song by each artist.
```sql
SELECT artist, MAX(duration) FROM songs GROUP BY artist;
```

**Q6.** List all plays along with user name and song title.
```sql
SELECT p.play_id, u.user_name, s.title FROM plays p JOIN users u ON p.user_id=u.user_id JOIN songs s ON p.song_id=s.song_id;
```

**Q7.** Find the number of plays per device.
```sql
SELECT device_id, COUNT(*) FROM plays GROUP BY device_id;
```

**Q8.** Show all users who never played any song.
```sql
SELECT u.* FROM users u LEFT JOIN plays p ON u.user_id=p.user_id WHERE p.play_id IS NULL;
```

**Q9.** Find the most played song overall.
```sql
SELECT song_id, COUNT(*) AS cnt FROM plays GROUP BY song_id ORDER BY cnt DESC LIMIT 1;
```

**Q10.** Find the number of distinct users who played each genre.
```sql
SELECT s.genre, COUNT(DISTINCT p.user_id) FROM plays p JOIN songs s ON p.song_id=s.song_id GROUP BY s.genre;
```

**Q11.** Show the most popular artist (by play count).
```sql
SELECT s.artist, COUNT(*) AS cnt FROM plays p JOIN songs s ON p.song_id=s.song_id GROUP BY s.artist ORDER BY cnt DESC LIMIT 1;
```

**Q12.** Find the number of plays per quarter in 2020.
```sql
SELECT d.quarter, COUNT(*) FROM plays p JOIN dates d ON p.date_id=d.date_id WHERE d.year=2020 GROUP BY d.quarter;
```

**Q13.** Find all songs played by user 'alex'.
```sql
SELECT DISTINCT s.title FROM plays p JOIN songs s ON p.song_id=s.song_id JOIN users u ON p.user_id=u.user_id WHERE u.user_name='alex';
```

**Q14.** Count free vs premium users.
```sql
SELECT plan, COUNT(*) FROM users GROUP BY plan;
```

**Q15.** Show the top 5 most played songs.
```sql
SELECT song_id, COUNT(*) FROM plays GROUP BY song_id ORDER BY COUNT(*) DESC LIMIT 5;
```

