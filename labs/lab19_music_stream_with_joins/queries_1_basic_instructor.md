**Q1.** List all users from USA.
```sql
SELECT * FROM users WHERE country = 'USA';
```

**Q2.** Show all songs by Taylor Swift.
```sql
SELECT * FROM songs WHERE artist = 'Taylor Swift';
```

**Q3.** Find the names and emails of all free plan users.
```sql
SELECT user_name, email FROM users WHERE plan = 'free';
```

**Q4.** Show all premium plan users from Spain.
```sql
SELECT user_name, email FROM users WHERE country = 'SPAIN' AND plan = 'premium';
```

**Q5.** Display all songs in the rock genre.
```sql
SELECT * FROM songs WHERE genre = 'rock';
```

**Q6.** Find all users who have null subscription plan.
```sql
SELECT * FROM users WHERE plan IS NULL;
```

**Q7.** List all songs longer than 250 seconds.
```sql
SELECT * FROM songs WHERE duration > 250;
```

**Q8.** Find all users whose name is 'ted'.
```sql
SELECT * FROM users WHERE user_name = 'ted';
```

**Q9.** Show all distinct countries of users.
```sql
SELECT DISTINCT country FROM users;
```

**Q10.** Display all songs by Beatles ordered by duration.
```sql
SELECT * FROM songs WHERE artist = 'Beatles' ORDER BY duration;
```

**Q11.** List all devices available in the system.
```sql
SELECT * FROM devices;
```

**Q12.** Find all users from Brazil.
```sql
SELECT * FROM users WHERE country = 'BRAZIL';
```

**Q13.** Show songs with duration less than 200 seconds.
```sql
SELECT * FROM songs WHERE duration < 200;
```

**Q14.** Find all users on premium plan in France.
```sql
SELECT * FROM users WHERE plan = 'premium' AND country = 'FRANCE';
```

**Q15.** List all pop songs by Ed Sheeran.
```sql
SELECT * FROM songs WHERE artist = 'Ed Sheeran' AND genre = 'pop';
```

**Q16.** Show all classical songs by Mozart.
```sql
SELECT * FROM songs WHERE artist = 'Mozart' AND genre = 'classic';
```

**Q17.** Find all unique subscription plans.
```sql
SELECT DISTINCT plan FROM users;
```

**Q18.** List all users whose email ends with 'tennis.com'.
```sql
SELECT * FROM users WHERE email LIKE '%tennis.com';
```

**Q19.** Show all songs titled 'The 1'.
```sql
SELECT * FROM songs WHERE title = 'The 1';
```

**Q20.** Display all songs not in the 'pop' genre.
```sql
SELECT * FROM songs WHERE genre <> 'pop';
```