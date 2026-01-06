CREATE DATABASE movie_streaming;
USE movie_streaming;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL);
    

CREATE TABLE movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    release_year INT NOT NULL);
    
	
    delimiter // 
    create trigger trigger_after_insert
    before insert on movies
    for each row
    begin
       IF NEW.release_year<0 then
       set NEW.release_year=0;
	end if;
    end;
    delimiter ; 

CREATE TABLE ratings (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    rating DECIMAL(2,1) CHECK (rating BETWEEN 1 AND 5),
    rating_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id));

CREATE TABLE watch_history (
    watch_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    watch_date DATE,
FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id));
    
INSERT INTO users (name, country) 
VALUES
('Amit Sharma', 'India'),
('Sophia Brown', 'USA'),
('Raj Patel', 'India'),
('Lucas Smith', 'Canada'),
('Maria Garcia', 'Spain'),
('Chen Wei', 'China');

INSERT INTO movies (title, genre, release_year) 
VALUES
('Inception', 'Sci-Fi', 2010),
('Avengers: Endgame', 'Action', 2019),
('Parasite', 'Thriller', 2019),
('Dune', 'Sci-Fi', 2021),
('La La Land', 'Romance', 2016),
('Tenet', 'Sci-Fi', 2020),
('Soul', 'Animation', 2020),
('RRR', 'Action', 2022);

INSERT INTO ratings (user_id, movie_id, rating, rating_date) 
VALUES
(1, 1, 5, '2023-01-12'),
(1, 2, 4, '2023-02-15'),
(2, 3, 5, '2023-03-20'),
(3, 4, 3, '2023-04-10'),
(4, 1, 4, '2023-05-05'),
(5, 2, 5, '2023-06-25'),
(6, 7, 5, '2023-07-01');

INSERT INTO watch_history (user_id, movie_id, watch_date) 
VALUES
(1, 1, '2023-01-10'),
(1, 2, '2023-02-12'),
(2, 3, '2023-03-18'),
(3, 4, '2023-04-08'),
(4, 1, '2023-05-03'),
(5, 2, '2023-06-22'),
(6, 7, '2023-07-01'),
(1, 1, '2023-08-01');

select * from ratings;
select * from users;
select * from movies;


SELECT country, genre, watch_count
FROM (
    SELECT u.country,m.genre,COUNT(*) AS watch_count,
	RANK() OVER (PARTITION BY u.country ORDER BY COUNT(*) DESC) AS genre_rank
    FROM watch_history w
    JOIN users u ON w.user_id = u.user_id
    JOIN movies m ON w.movie_id = m.movie_id
    GROUP BY u.country, m.genre)AS ranked;
    
SELECT user_id, COUNT(*) AS ratings_count
FROM ratings
GROUP BY user_id
HAVING COUNT(*) > 0
ORDER BY ratings_count DESC;

SELECT title, release_year
FROM movies
WHERE release_year > 2020;

SELECT m.genre,AVG(r.rating) AS avg_rating,COUNT(r.rating) AS rating_count
FROM ratings r
JOIN movies m ON r.movie_id = m.movie_id
GROUP BY m.genre
ORDER BY avg_rating DESC;


WITH genre_totals AS (
  SELECT genre, COUNT(*) AS total_movies
  FROM movies
  GROUP BY genre
)
SELECT r.user_id, m.genre
FROM ratings r
JOIN movies m 
ON r.movie_id = m.movie_id
JOIN genre_totals g 
ON m.genre = g.genre
GROUP BY r.user_id, m.genre, g.total_movies
HAVING SUM(CASE WHEN r.rating = 5 THEN 1 ELSE 0 END) = g.total_movies;


SELECT m.title, COUNT(DISTINCT u.country) AS country_count
FROM watch_history w
 JOIN users u 
 ON w.user_id = u.user_id
 JOIN movies m 
 ON w.movie_id = m.movie_id
GROUP BY m.movie_id
HAVING COUNT(DISTINCT u.country) >= 2;

SELECT ROUND(COUNT(*) / COUNT(DISTINCT CONCAT(user_id, '-', YEAR(watch_date), '-', MONTH(watch_date))), 2)
AS avg_movies_per_user_per_month
FROM watch_history;

SELECT u.user_id, u.name, m.title, COUNT(*) AS times_watched
FROM watch_history w
JOIN users u 
ON w.user_id = u.user_id
JOIN movies m 
ON w.movie_id = m.movie_id
GROUP BY u.user_id, m.movie_id, m.title
HAVING COUNT(*) > 1;

SELECT COUNT(DISTINCT r.movie_id) AS rated_but_not_watched
FROM ratings r
LEFT JOIN watch_history w 
ON r.movie_id = w.movie_id
WHERE w.movie_id IS NULL;


SELECT m.genre,COUNT(CASE WHEN r.rating = 5 THEN 1 END) / COUNT(DISTINCT m.movie_id) AS avg_5star_per_movie
FROM movies m
LEFT JOIN ratings r ON m.movie_id = r.movie_id
GROUP BY m.genre
ORDER BY avg_5star_per_movie DESC
limit 3;










delimiter //    
create trigger after_customer_insert 
after insert on customers
for each row
begin 
 insert into action_log(table_name, action_type, new_data)
 values ('Customers', 'insert', concat('name:', NEW.name, ',email: ', NEW.Email, ',country: ', NEW.Country));
   end //
delimiter ;
