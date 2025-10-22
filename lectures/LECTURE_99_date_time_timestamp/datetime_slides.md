# MySQL Date, Time, and Timestamp

## Slide 1: Introduction
- MySQL provides three main temporal data types: 

		`DATE`
		
		`TIME`
		
		`TIMESTAMP`
	
- These are essential for recording events, scheduling, and analyzing time-series data.

----

## Slide 2: DATE
- Stores date values (YYYY-MM-DD).
- Example: `'2025-10-17'`.
- Range: `'1000-01-01'` to `'9999-12-31'`.

-----

## Slide 3: TIME
- Stores time of day (HH:MM:SS).
- Example: `'13:45:30'`.
- Range: `'-838:59:59'` to `'838:59:59'`.

----

## Slide 4: TIMESTAMP
- Stores date and time (YYYY-MM-DD HH:MM:SS).
- Example: `'2025-10-17 14:30:00'`.
- Range: `'1970-01-01 00:00:01 UTC'` to `'2038-01-19 03:14:07 UTC'`.

----

## Slide 5: Functions for DATE
- `CURDATE()` → Current date
- `DAY(date)` → Extract day
- `MONTH(date)` → Extract month
- `YEAR(date)` → Extract year
- Example: `SELECT YEAR('2025-10-17');` → 2025

----

## Slide 6: Functions for TIME
- `CURTIME()` → Current time
- `HOUR(time)` → Extract hour
- `MINUTE(time)` → Extract minutes
- `SECOND(time)` → Extract seconds
- Example: `SELECT HOUR('13:45:30');` → 13

-----

## Slide 7: Functions for TIMESTAMP
- `NOW()` → Current date and time
- `UNIX_TIMESTAMP()` → Convert to Unix time
- `FROM_UNIXTIME()` → Convert from Unix time
- Example: `SELECT NOW();` → 2025-10-17 18:00:00

-----

## Slide 8: Schema Example
```sql
CREATE TABLE events (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(50),
    event_date DATE,
    event_time TIME,
    event_timestamp TIMESTAMP
);
```

## Slide 9: Sample Inserts (20 rows)
```sql
INSERT INTO events VALUES
(1, 'Team Meeting', '2025-01-10', '09:00:00', '2025-01-10 09:00:00'),
(2, 'Project Deadline', '2025-01-15', '23:59:59', '2025-01-15 23:59:59'),
(3, 'Doctor Appointment', '2025-02-01', '10:30:00', '2025-02-01 10:30:00'),
(4, 'Birthday Party', '2025-02-20', '18:00:00', '2025-02-20 18:00:00'),
(5, 'Conference', '2025-03-05', '08:00:00', '2025-03-05 08:00:00'),
(6, 'Flight', '2025-03-12', '06:45:00', '2025-03-12 06:45:00'),
(7, 'Exam', '2025-04-01', '14:00:00', '2025-04-01 14:00:00'),
(8, 'Workshop', '2025-04-15', '11:00:00', '2025-04-15 11:00:00'),
(9, 'Concert', '2025-05-07', '20:00:00', '2025-05-07 20:00:00'),
(10, 'Hackathon', '2025-05-20', '09:00:00', '2025-05-20 09:00:00'),
(11, 'Seminar', '2025-06-02', '10:00:00', '2025-06-02 10:00:00'),
(12, 'Exam', '2025-06-10', '14:00:00', '2025-06-10 14:00:00'),
(13, 'Holiday', '2025-07-04', '00:00:00', '2025-07-04 00:00:00'),
(14, 'Team Outing', '2025-07-15', '12:00:00', '2025-07-15 12:00:00'),
(15, 'Training', '2025-08-01', '09:30:00', '2025-08-01 09:30:00'),
(16, 'Meeting', '2025-08-10', '15:00:00', '2025-08-10 15:00:00'),
(17, 'Presentation', '2025-09-01', '10:00:00', '2025-09-01 10:00:00'),
(18, 'Hackathon', '2025-09-15', '09:00:00', '2025-09-15 09:00:00'),
(19, 'Concert', '2025-10-01', '19:30:00', '2025-10-01 19:30:00'),
(20, 'Exam', '2025-10-17', '14:00:00', '2025-10-17 14:00:00');
```

## Slide 10: Sample Queries (English + SQL)

### 1. Show all events → 

```mysql
SELECT * 
FROM events;
```

### 2. Find all events in January → 

```sql
SELECT  * 
FROM events 
WHERE MONTH(event_date) = 1;
```

### 3. List events happening after 6 PM → 

```sql
SELECT  * 
FROM events 
WHERE HOUR(event_time) >= 18;
```


### 4. Get events scheduled in 2025 → 

```sql
SELECT  * 
FROM events 
WHERE YEAR(event_date) = 2025;
```

### 5. Show today’s events → 

```sql
SELECT  * 
FROM events 
WHERE event_date = CURDATE();
```

### 6. Find events happening tomorrow → 

```sql
SELECT  * 
FROM events 
WHERE event_date = CURDATE() + INTERVAL 1 DAY;
```

### 7. List events ordered by date → 

```sql
SELECT  * 
FROM events 
ORDER BY event_date;
```

### 8. Get events happening this month → 

```sql
SELECT  * 
FROM events 
WHERE MONTH(event_date) = MONTH(CURDATE());
```

### 9. Count events in March → 

```sql
SELECT  COUNT(*) 
FROM events 
WHERE MONTH(event_date)=3;
```

### 10. Find earliest event → 

```sql
SELECT  * 
FROM events 
ORDER BY event_date ASC LIMIT 1;
```

### 11. Find latest event → 

```sql
SELECT  * 
FROM events 
ORDER BY event_date DESC LIMIT 1;
```

### 12. Find duration between two events → 

```sql
SELECT  DATEDIFF('2025-05-20','2025-05-07');
```

### 13. Show events and weekday → 

```sql
SELECT  event_name, DAYNAME(event_date) FROM events;
```

### 14. Get hour of each event → 

```sql
SELECT  event_name, HOUR(event_time) 
FROM events;
```

### 15. Find all exams → 

```sql
SELECT  * 
FROM events 
WHERE event_name='Exam';
```

### 16. Show events in September ordered by time → 

```sql
SELECT  * 
FROM events 
WHERE MONTH(event_date)=9 
ORDER BY event_time;
```

### 17. Get number of events per month → 

```sql
SELECT  MONTH(event_date), COUNT(*) 
FROM events 
GROUP BY MONTH(event_date);
```

### 18. Show events in the next 30 days → 

```sql
SELECT  * 
FROM events 
WHERE event_date BETWEEN CURDATE() AND CURDATE()+INTERVAL 30 DAY;
```

### 19. Convert timestamp to Unix → 

```sql
SELECT  event_id, UNIX_TIMESTAMP(event_timestamp) 
FROM events;
```

### 20. Convert Unix back to timestamp → 

```sql
SELECT  FROM_UNIXTIME(UNIX_TIMESTAMP(event_timestamp)) 
FROM events;
```
