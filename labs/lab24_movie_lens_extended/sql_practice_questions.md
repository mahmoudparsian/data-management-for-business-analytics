SQL Practice Questions - MovieLens  Dataset
This document contains structured SQL practice 
questions for a real dataset project. These 
questions cover all SQL concepts, from basic SELECT 
statements to advanced window functions and subqueries, 
making it perfect for a portfolio or HR showcase.

consider the movielens schema
with 4 tables: movies, ratings, tags, links

The schema is defined below:

movies: movieId,title,genres
ratings: userId,movieId,rating,timestamp
tags: userId,movieId,tag,timestamp
links: movieId,imdbId,tmdbId


Let's create the following set queries with English and
associated SQL(using mySQL database).

# 1. Basic SELECT & Filtering
1.    List all movies released after 2015.
2.    Find all movies in the "Comedy" genre.
3.    Display movies with a rating higher than 4.5.

# 2. Aggregation & GROUP BY
1.    Count how many movies exist in each genre.
2.    Find the average rating of each movie.
3.    Find the total number of ratings given by each user.
 
# 3. Sorting & LIMIT
1.    List the top 10 movies with the highest average rating.
2.    List the top 5 users who rated the most movies.
3.    List movies with the longest runtime, in descending order.

# 4. JOINs
1.    List all movies along with their ratings.
2.    Show movies with their corresponding tags applied by users.
3.    Find movies and the number of times each has been tagged.
4.    Find movies along with IMDb links (from links.csv ).

# 5. Filtering with JOINs
1.    Find all Comedy movies rated higher than 4.
2.    Find users who have rated the movie “Toy Story (1995)”.
3.    List all movies rated by user with userId = 1 along with their ratings.

# 6. Window Functions & Ranking
1.    Rank movies by average rating within each genre.
2.    Show the top 3 movies per genre based on average rating.
3.    Calculate a running total of ratings per user.

# 7. Subqueries
1.    Find movies with rating higher than the overall average rating.
2.    Find users who rated more than 50 movies.
3.    List movies that have never received a rating of 5.

# 8. Advanced / Combined
1.    Find the most popular tag (used the most by users).
2.    Find the genre with the highest average movie rating.
3.    Find the average rating given per year of release.
4.    Find movies with at least 50 ratings and an average rating above 4.

