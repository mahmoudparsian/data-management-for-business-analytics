-- 1. List all students
SELECT * FROM students;

-- 2. Count total students
SELECT COUNT(*) FROM students;

-- 3. Find all female students
SELECT * FROM students WHERE gender = 'FEMALE';

-- 4. Find students from India
SELECT * FROM students WHERE country = 'INDIA';

-- 5. List distinct majors
SELECT DISTINCT major FROM students;

-- 6. Count students per country
SELECT country, COUNT(*) FROM students GROUP BY country;

-- 7. Find students born before 1990
SELECT * FROM students WHERE date_of_birth < '1990-01-01';

-- 8. List students sorted by last name
SELECT * FROM students ORDER BY last_name;

-- 9. Find students with 'Data Science' major
SELECT * FROM students WHERE major = 'Data Science';

-- 10. Count male vs female students
SELECT gender, COUNT(*) FROM students GROUP BY gender;

-- 11. Find students whose first name starts with 'A'
SELECT * FROM students WHERE first_name LIKE 'A%';

-- 12. List students from USA or Canada
SELECT * FROM students WHERE country IN ('USA', 'CANADA');

-- 13. Find students born in March
SELECT * FROM students WHERE MONTH(date_of_birth) = 3;

-- 14. Count students per major
SELECT major, COUNT(*) FROM students GROUP BY major;

-- 15. Find students with email ending in '.com'
SELECT * FROM students WHERE email LIKE '%.com';

-- 16. List students born between 1985 and 1990
SELECT * FROM students WHERE date_of_birth BETWEEN '1985-01-01' AND '1990-12-31';

-- 17. Find students with last name 'Chen'
SELECT * FROM students WHERE last_name = 'Chen';

-- 18. Count students per language
SELECT language, COUNT(*) FROM students GROUP BY language;

-- 19. Find students with major containing 'Science'
SELECT * FROM students WHERE major LIKE '%Science%';

-- 20. List students ordered by birthdate (youngest first)
SELECT * FROM students ORDER BY date_of_birth DESC;

-- 21. Find students with emails containing 'liu'
SELECT * FROM students WHERE email LIKE '%liu%';

-- 22. List students grouped by major and gender
SELECT major, gender, COUNT(*) FROM students GROUP BY major, gender;

-- 23. Find students with birth year between 1985 and 1990
SELECT * FROM students WHERE YEAR(date_of_birth) BETWEEN 1985 AND 1990;

-- 24. List students whose last name ends with 'i'
SELECT * FROM students WHERE last_name LIKE '%i';

-- 25. Count students per country and gender
SELECT country, gender, COUNT(*) FROM students GROUP BY country, gender;

-- 26. Find students with duplicate first names
SELECT first_name, COUNT(*) FROM students GROUP BY first_name HAVING COUNT(*) > 1;

-- 27. List students with major 'Math' and born after 1990
SELECT * FROM students WHERE major = 'Math' AND date_of_birth > '1990-01-01';

-- 28. Find students whose email domain is 'example.com'
SELECT * FROM students WHERE email LIKE '%@example.com';

-- 29. Count students born in each month
SELECT MONTH(date_of_birth) AS birth_month, COUNT(*) FROM students GROUP BY birth_month;

-- 30. List students with first name length > 6
SELECT * FROM students WHERE LENGTH(first_name) > 6;

-- 31. Find students born on the 15th of any month
SELECT * FROM students WHERE DAY(date_of_birth) = 15;

-- 32. List students with major in ('Biology', 'Finance')
SELECT * FROM students WHERE major IN ('Biology', 'Finance');

-- 33. Count students per language and major
SELECT language, major, COUNT(*) FROM students GROUP BY language, major;

-- 34. Find students with last name starting with 'M' and born before 1990
SELECT * FROM students WHERE last_name LIKE 'M%' AND date_of_birth < '1990-01-01';

-- 35. List students with country not equal to 'USA'
SELECT * FROM students WHERE country <> 'USA';

-- 36. Find students with first name containing 'an'
SELECT * FROM students WHERE first_name LIKE '%an%';

-- 37. Count students with each email domain
SELECT SUBSTRING_INDEX(email, '@', -1) AS domain, COUNT(*) FROM students GROUP BY domain;

-- 38. List students whose major is not 'Business'
SELECT * FROM students WHERE major <> 'Business';

-- 39. Find students born in the 1980s
SELECT * FROM students WHERE YEAR(date_of_birth) BETWEEN 1980 AND 1989;

-- 40. Count students per gender and language
SELECT gender, language, COUNT(*) FROM students GROUP BY gender, language;

-- 41. Find top 3 countries with most students
SELECT country, COUNT(*) AS total FROM students GROUP BY country ORDER BY total DESC LIMIT 3;

-- 42. List students whose first and last names start with the same letter
SELECT * FROM students WHERE LEFT(first_name,1) = LEFT(last_name,1);

-- 43. Find students with palindromic first names
SELECT * FROM students WHERE first_name = REVERSE(first_name);

-- 44. Count students born on weekends
SELECT COUNT(*) FROM students WHERE DAYOFWEEK(date_of_birth) IN (1,7);

-- 45. List students with unique majors per country
SELECT country, major FROM students GROUP BY country, major HAVING COUNT(*) = 1;

-- 46. Find students with most common birth year
SELECT YEAR(date_of_birth) AS year, COUNT(*) AS total FROM students GROUP BY year ORDER BY total DESC LIMIT 1;

-- 47. List students whose email username matches their first name
SELECT * FROM students WHERE SUBSTRING_INDEX(email, '@', 1) LIKE CONCAT('%', LOWER(first_name), '%');

-- 48. Count students with same first and last name
SELECT COUNT(*) FROM students WHERE first_name = last_name;

-- 49. Find students with longest full name
SELECT *, LENGTH(CONCAT(first_name, last_name)) AS name_length FROM students ORDER BY name_length DESC LIMIT 1;

-- 50. List students with major and country combinations that appear only once
SELECT major, country FROM students GROUP BY major, country HAVING COUNT(*) = 1;

-- 51. Find students born on leap day
SELECT * FROM students WHERE MONTH(date_of_birth) = 2 AND DAY(date_of_birth) = 29;

-- 52. Count students with email domains used by more than 5 students
SELECT SUBSTRING_INDEX(email, '@', -1) AS domain, COUNT(*) FROM students GROUP BY domain HAVING COUNT(*) > 5;

-- 53. List students whose last name is longer than their first name
SELECT * FROM students WHERE LENGTH(last_name) > LENGTH(first_name);

-- 54. Find students with same birthdate
SELECT date_of_birth, COUNT(*) FROM students GROUP BY date_of_birth HAVING COUNT(*) > 1;

-- 55. Count students per major per gender per country
SELECT country, gender, major, COUNT(*) FROM students GROUP BY country, gender, major;

-- 56. List students with first name in uppercase
SELECT * FROM students WHERE BINARY first_name = UPPER(first_name);

-- 57. Find students with email usernames longer than 10 characters
SELECT * FROM students WHERE LENGTH(SUBSTRING_INDEX(email, '@', 1)) > 10;

-- 58. Count students born in each decade
SELECT FLOOR(YEAR(date_of_birth)/10)*10 AS decade, COUNT(*) FROM students GROUP BY decade;

-- 59. List students whose first name contains exactly 5 letters
SELECT * FROM students WHERE LENGTH(first_name) = 5;

-- 60. Find students whose country and language match (e.g., 'GERMANY' and 'GERMAN')
SELECT * FROM students WHERE LOWER(country) = LOWER(language);

