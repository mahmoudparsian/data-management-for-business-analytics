**Q1.** Find the number of users in each country.
```sql
SELECT country, COUNT(*) AS user_count FROM users GROUP BY country;
```

**Q2.** Find the number of songs per genre.
```sql
SELECT genre, COUNT(*) AS song_count FROM songs GROUP BY genre;
```

**Q3.** Count the number of free and premium users.
```sql
SELECT plan, COUNT(*) AS user_count FROM users GROUP BY plan;
```

**Q4.** Find the average duration of songs per genre.
```sql
SELECT genre, AVG(duration) AS avg_duration FROM songs GROUP BY genre;
```

**Q5.** Find the longest song per artist.
```sql
SELECT artist, MAX(duration) AS longest_song FROM songs GROUP BY artist;
```

**Q6.** Count how many plays each user has.
```sql
SELECT user_id, COUNT(*) AS play_count FROM plays GROUP BY user_id;
```

**Q7.** Find the total plays of each song.
```sql
SELECT song_id, COUNT(*) AS play_count FROM plays GROUP BY song_id;
```

**Q8.** Find the number of plays per device.
```sql
SELECT device_id, COUNT(*) AS play_count FROM plays GROUP BY device_id;
```

**Q9.** Find the number of songs played per day.
```sql
SELECT date_id, COUNT(*) AS play_count FROM plays GROUP BY date_id;
```

**Q10.** Find the number of songs played per month in 2020.
```sql
SELECT d.month, COUNT(*) AS monthly_plays FROM plays p JOIN dates d ON p.date_id = d.date_id WHERE d.year=2020 GROUP BY d.month;
```

**Q11.** Find all users and the number of distinct songs they have played.
```sql
SELECT user_id, COUNT(DISTINCT song_id) AS distinct_songs FROM plays GROUP BY user_id;
```

**Q12.** Find the most played song in 2020.
```sql
SELECT song_id, COUNT(*) AS play_count FROM plays p JOIN dates d ON p.date_id=d.date_id WHERE d.year=2020 GROUP BY song_id ORDER BY play_count DESC LIMIT 1;
```

**Q13.** Find total plays per country.
```sql
SELECT u.country, COUNT(*) AS total_plays FROM plays p JOIN users u ON p.user_id = u.user_id GROUP BY u.country;
```

**Q14.** Find average song duration by artist.
```sql
SELECT artist, AVG(duration) AS avg_duration FROM songs GROUP BY artist;
```

**Q15.** Find songs played by user 'alex'.
```sql
SELECT DISTINCT s.title FROM plays p JOIN songs s ON p.song_id = s.song_id JOIN users u ON p.user_id = u.user_id WHERE u.user_name='alex';
```

**Q16.** Find how many distinct users played each genre.
```sql
SELECT s.genre, COUNT(DISTINCT p.user_id) AS user_count FROM plays p JOIN songs s ON p.song_id=s.song_id GROUP BY s.genre;
```

**Q17.** Find the top 5 most played songs.
```sql
SELECT song_id, COUNT(*) AS play_count FROM plays GROUP BY song_id ORDER BY play_count DESC LIMIT 5;
```

**Q18.** Find the number of plays in each quarter.
```sql
SELECT d.quarter, COUNT(*) AS play_count FROM plays p JOIN dates d ON p.date_id=d.date_id GROUP BY d.quarter;
```

**Q19.** Find all users who never played any song.
```sql
SELECT * FROM users u LEFT JOIN plays p ON u.user_id=p.user_id WHERE p.play_id IS NULL;
```

**Q20.** Find the number of plays for Beatles songs.
```sql
SELECT COUNT(*) AS play_count FROM plays p JOIN songs s ON p.song_id=s.song_id WHERE s.artist='Beatles';
```