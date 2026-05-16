-- switch to imdb_2 dataset
USE imdb_2;

-- list all the tables in the dataset
SHOW tables;

-- display the structure of the movies table
DESCRIBE movies;

-- select all the columns from the movies table 
SELECT*
FROM movies;

-- select the name and year columns from the movies table 
SELECT 
	name,
    year
FROM movies;

-- select the rank score and names from the movies table 
SELECT 
	rankscore,
    name
FROM movies;

-- get 20 first rows with name and rankscore from movies 
SELECT 
	name,
    rankscore
FROM movies
LIMIT 20;

-- get 20 rowa of name and rankscore starting from the 41st row in movies 
SELECT
	name,
    rankscore
FROM movies
LIMIT 20 
OFFSET 40;

-- list the top 10 most recent movies by year, showing name, rankscore and year
SELECT 
	name,
    rankscore,
    year
FROM movies 
ORDER BY year DESC
LIMIT 10;

-- list the top 10 oldest movies by year, showing name, rankscore and year 
SELECT 
	name,
    rankscore,
    year
FROM movies 
ORDER BY year 
LIMIT 10;

-- list all the unique generes from the movie_generes table
SELECT
	DISTINCT genre
FROM movies_genres;

-- list all the unique combinations of first_name and last_name from the directors table 
SELECT DISTINCT
    first_name, last_name
FROM
    directors;

-- list all the movies with rankscore greater than 9 showing name, year and rankscore
SELECT 
	name,
    year,
    rankscore
FROM movies
WHERE rankscore > 9;

SELECT
	name,
    year,
    rankscore
FROM movies
WHERE rankscore > 9 
ORDER BY rankscore DESC
LIMIT 20;

-- list all the records from movie_generes where the genre is 'Comedy'
SELECT*
FROM movies_genres
WHERE genre = 'Comedy';

-- list all the records from movies genres where the genre is not 'Horror'
SELECT*
FROM movies_genres
WHERE genre <> 'Horror';

-- query moviees where the rankscore equals NULL
SELECT*
FROM movies
WHERE rankscore IS NULL;

-- list the first 20 movies where the rankscore is NULL 
SELECT*
FROM movies
WHERE rankscore IS NULL
LIMIT 20;

-- list the first 20 movies where the rankscore is not NULL
 SELECT*
FROM movies
WHERE rankscore IS NOT NULL
LIMIT 20;

-- list movies with a rankscore greater than 9 released after the year 2000
SELECT 
	name,
    year,
    rankscore
FROM movies
WHERE rankscore > 9 AND year > 2000;

-- list first 20 movies released after the year 2000
SELECT 
	name,
    year,
    rankscore
FROM movies
WHERE  year > 2000
LIMIT 20;

-- list movies with a rankscore greater than 9 or released after the year 2007 
SELECT 
	name,
    year,
    rankscore
FROM movies
WHERE rankscore > 9 OR year > 2007;

-- list movies between 1999 and 2000 
SELECT 
	name,
    year,
    rankscore
FROM movies
WHERE  year BETWEEN 1999 AND 2000;

-- list records where the genre is either 'Comedy' or 'Horror'
SELECT*
FROM movies_genres
WHERE genre IN ( 'Horror','Comedy');

-- list movies with names starting with 'Tis'
SELECT 
	name,
    year,
    rankscore
FROM movies
WHERE name LIKE 'tis%';

-- list actors whose first name ends with 'es'
SELECT*
FROM actors
WHERE first_name LIKE '%es';

-- list actors whose first name contains 'es'
SELECT*
FROM actors
WHERE first_name LIKE '%es%';

-- list actors whose first name match 'Agn_s'
SELECT*
FROM actors
WHERE first_name LIKE 'Agn_s';

-- list actors with first name start with 'L' but does not start with 'Li'
SELECT*
FROM actors
WHERE first_name LIKE 'L%'AND 
	first_name NOT LIKE 'LI%';
    
-- find the earliest year in the movies table
SELECT MIN(YEAR)
FROM movies;

-- find the most recent year in the movies table 
 SELECT MAX(YEAR)
 FROM movies;
 
 -- count the total number of movies released after the year 2000
 SELECT COUNT(*)
FROM movies
WHERE year > 2000;

-- count the number of non - NULL year values in the movies table 
SELECT COUNT(year)
FROM movies 
WHERE year IS NOT NULL;

-- Find the number of movies released each year 
SELECT 
	year,
    COUNT(*)
FROM movies 
GROUP BY year;

-- Find the movies released each year, ordered by year
SELECT 
	year,
    COUNT(*)
FROM movies 
GROUP BY year
ORDER BY year;

-- Find the number of movies released each year, ordered by year 
SELECT 
	year,
    COUNT(year) as total_count
FROM movies
GROUP BY year 
ORDER BY total_count;

-- Find years with more than 1000 movies. 
SELECT
	year,
    COUNT(*) as year_count
FROM movies
GROUP BY year
HAVING year_count > 1000;

-- List movies released after the year 2000 without using GROUP BY 
SELECT 
	name,
    year
HAVING year > 2000;

-- Find years with more than 20 movies that have a rankscore greater than 9 
SELECT 
	year,
    COUNT(*) as year_count
FROM movies 
WHERE rankscore > 9 
GROUP BY year
HAVING year_count > 20;

-- Limit the names and genres of movies, limiting the the result to 20 rows
SELECT* 
FROM movies; 

SELECT*
FROM movies_genres;

SELECT
	m.name,
    mg.genre
FROM movies m 
JOIN movies_genres mg 
	ON m.id = mg.movie_id
LIMIT 20;
 
 -- List the names and generes of movies, including movies with no gernre, limiting the result to 20 rows
 SELECT
	m.name,
    mg.genre
FROM movies m 
LEFT JOIN movies_genres mg 
	ON m.id = mg.movie_id
LIMIT 20;

-- List the first name and last names of actors who acted in the movie 'Officer444'
SELECT 
    a.first_name, a.last_name
FROM
    actors a
        JOIN
    movies m ON a.id = m.id
        JOIN
    roles r ON m.id = r.actor_id
WHERE
    m.name = 'Officer444';

-- List all the actors in the "Schindler's list"
SELECT*
FROM movies m 
JOIN actors a 
	ON m.id = a.id
WHERE m.name LIKE "Schindler's list";

-- Insert a new movie record with the ID 412312, name "Thor", year 2011 and rankscore 7
INSERT INTO movies (id, name, year, rankscore)
VALUES (412312, 'Thor', 2011, 7)
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    year = VALUES(year),
    rankscore = VALUES(rankscore);
    
