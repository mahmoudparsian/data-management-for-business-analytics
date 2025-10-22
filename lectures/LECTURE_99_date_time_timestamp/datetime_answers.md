# Teacher’s Answer Key: MySQL DATE, TIME, and TIMESTAMP

This file contains the SQL solutions for the student exercise sheet.

---

1. Show all events  
```sql
SELECT * FROM events;
```

2. Find all events happening in January  
```sql
SELECT * FROM events WHERE MONTH(event_date) = 1;
```

3. List events happening after 6 PM  
```sql
SELECT * FROM events WHERE HOUR(event_time) >= 18;
```

4. Get events scheduled in 2025  
```sql
SELECT * FROM events WHERE YEAR(event_date) = 2025;
```

5. Show today’s events  
```sql
SELECT * FROM events WHERE event_date = CURDATE();
```

6. Find events happening tomorrow  
```sql
SELECT * FROM events WHERE event_date = CURDATE() + INTERVAL 1 DAY;
```

7. List events ordered by date  
```sql
SELECT * FROM events ORDER BY event_date;
```

8. Get events happening this month  
```sql
SELECT * FROM events WHERE MONTH(event_date) = MONTH(CURDATE());
```

9. Count the number of events in March  
```sql
SELECT COUNT(*) FROM events WHERE MONTH(event_date) = 3;
```

10. Find the earliest event  
```sql
SELECT * FROM events ORDER BY event_date ASC LIMIT 1;
```

11. Find the latest event  
```sql
SELECT * FROM events ORDER BY event_date DESC LIMIT 1;
```

12. Calculate the duration (days) between two given events  
```sql
SELECT DATEDIFF('2025-05-20', '2025-05-07');
```

13. Show each event and its weekday  
```sql
SELECT event_name, DAYNAME(event_date) FROM events;
```

14. Extract and show the hour of each event  
```sql
SELECT event_name, HOUR(event_time) FROM events;
```

15. Find all events named 'Exam'  
```sql
SELECT * FROM events WHERE event_name = 'Exam';
```

16. Show events in September ordered by their start time  
```sql
SELECT * FROM events WHERE MONTH(event_date) = 9 ORDER BY event_time;
```

17. Count the number of events per month  
```sql
SELECT MONTH(event_date), COUNT(*) FROM events GROUP BY MONTH(event_date);
```

18. Show events happening in the next 30 days  
```sql
SELECT * FROM events WHERE event_date BETWEEN CURDATE() AND CURDATE() + INTERVAL 30 DAY;
```

19. Convert each event’s timestamp into Unix time  
```sql
SELECT event_id, UNIX_TIMESTAMP(event_timestamp) FROM events;
```

20. Convert Unix time back into timestamp format  
```sql
SELECT FROM_UNIXTIME(UNIX_TIMESTAMP(event_timestamp)) FROM events;
```
