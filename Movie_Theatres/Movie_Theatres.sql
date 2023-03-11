CREATE DATABASE movie_theatres;
USE movie_theatres;

CREATE TABLE movies (
code INT PRIMARY KEY,
title VARCHAR(255) NOT NULL,
rating VARCHAR(255)
);

INSERT INTO movies (code, title, rating) VALUES
(1,'Citizen Kane','PG'),
(2,'Singin'' in the Rain','G'),
(3,'The Wizard of Oz','G'),
(4,'The Quiet Man',NULL),
(5,'North by Northwest',NULL),
(6,'The Last Tango in Paris','NC-17'),
(7,'Some Like it Hot','PG-13'),
(8,'A Night at the Opera',NULL),
(9,'Citizen King','G');

CREATE TABLE movietheatres (
code INT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
movie INT,
FOREIGN KEY(movie) REFERENCES movies(code)
)ENGINE=InnoDB;

INSERT INTO movietheatres (code, name, movie) VALUES
(1,'Odeon',5),
(2,'Imperial',1),
(3,'Majestic',NULL),
(4,'Royale',6),
(5,'Paraiso',3),
(6,'Nickelodeon',NULL);

-- 1. Select the title of all movies.
SELECT title FROM movies;

-- 2. Show all the distinct ratings in the database.
SELECT DISTINCT(rating) FROM movies;

-- 3. Show all unrated movies.
SELECT * FROM movies
WHERE rating IS NULL;

-- 4. Select all movie theaters that are not currently showing a movie.
SELECT * FROM movietheatres
WHERE movie IS NULL;

-- 5. Select all data from all movie theaters and, additionally, the data from the movie that is being shown in the 
-- theater (if one is being shown).
SELECT * FROM movietheatres AS MT
LEFT JOIN movies AS M
ON MT.movie = M.code;

-- 6. Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
SELECT * FROM movietheatres AS MT
RIGHT JOIN movies AS M
ON MT.movie = M.code;

-- 7. Show the titles of movies not currently being shown in any theaters.
SELECT title FROM movies 
WHERE code NOT IN (
	SELECT movie FROM movietheatres
    WHERE movie IS NOT NULL
);

SELECT M.title FROM movies AS M
LEFT JOIN movietheatres AS MT
ON M.code = MT.movie
WHERE MT.movie IS NULL;

-- 8. Add the unrated movie "One, Two, Three".
INSERT INTO movies(code, title, rating) VALUES (10,'one, two, three', NULL);

-- 9. Set the rating of all unrated movies to "G".
UPDATE movies
SET rating = 'G'
WHERE rating IS NULL;

-- 10. Remove movie theaters projecting movies rated "NC-17".
DELETE FROM movietheatres
WHERE movie IN (
	SELECT code FROM movies
    WHERE rating = 'NC-17'
);

















