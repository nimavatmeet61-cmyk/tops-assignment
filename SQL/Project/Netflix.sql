create database netflix01;

use netflix01;

create table subscriptions(
subscriptions_id int primary key,
plan_name varchar(50),
price decimal(10,2),
duration_month int,
device_limit int);

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    email VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    country VARCHAR(50),
    subscriptions_id INT,
    join_date DATE,
    FOREIGN KEY (subscriptions_id) REFERENCES subscriptions(subscriptions_id)
);

CREATE TABLE content (
    content_id INT PRIMARY KEY,
    title VARCHAR(200),
    content_type VARCHAR(20),     -- Movie / TV Show
    genre VARCHAR(50),
    language VARCHAR(50),
    release_year INT,
    duration_minutes INT,
    rating DECIMAL(3,1)
);

CREATE TABLE watch_history (
    watch_id INT PRIMARY KEY,
    user_id INT,
    content_id INT,
    watch_date DATE,
    watch_duration INT,
    completed_flag VARCHAR(5),    -- Yes / No
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (content_id) REFERENCES content(content_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    user_id INT,
    subscriptions_id INT,
    payment_date DATE,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),   
    payment_status VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (subscriptions_id) REFERENCES subscriptions(subscriptions_id)
);

CREATE TABLE ratings_reviews (
    review_id INT PRIMARY KEY,
    user_id INT,
    content_id INT,
    rating INT,
    review_text VARCHAR(500),
    review_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (content_id) REFERENCES content(content_id)
);

INSERT INTO subscriptions VALUES
(1,'Basic',199,1,1),
(2,'Standard',499,1,2),
(3,'Premium',799,1,4),
(4,'Basic',999,6,1),
(5,'Standard',2499,6,2),
(6,'Premium',3999,6,4),
(7,'Basic',1799,12,1),
(8,'Standard',2999,12,2),
(9,'Premium',4999,12,4),
(10,'Mobile',149,1,1),
(11,'Mobile',799,6,1),
(12,'Mobile',1299,12,1),
(13,'Family',699,1,5),
(14,'Family',3499,6,5),
(15,'Family',5999,12,5),
(16,'Student',99,1,1),
(17,'Student',499,6,1),
(18,'Student',899,12,1),
(19,'Trial',0,1,1),
(20,'Corporate',9999,12,10);
select * from subscriptions;

INSERT INTO users VALUES
(1,'Rahul Sharma','rahul@gmail.com','Male',25,'India',1,'2023-01-10'),
(2,'Amit Patel','amit@gmail.com','Male',30,'India',2,'2023-02-12'),
(3,'Sneha Iyer','sneha@gmail.com','Female',27,'India',3,'2023-03-15'),
(4,'John Smith','john@gmail.com','Male',35,'USA',9,'2023-01-20'),
(5,'Emma Watson','emma@gmail.com','Female',28,'UK',8,'2023-04-01'),
(6,'Raj Mehta','raj@gmail.com','Male',40,'India',5,'2023-05-10'),
(7,'Anjali Desai','anjali@gmail.com','Female',23,'India',10,'2023-06-18'),
(8,'Vikram Singh','vikram@gmail.com','Male',33,'India',6,'2023-02-28'),
(9,'Sara Khan','sara@gmail.com','Female',29,'India',7,'2023-03-22'),
(10,'David Lee','david@gmail.com','Male',45,'Canada',15,'2023-01-30'),
(11,'Rohan Verma','rohan@gmail.com','Male',26,'India',16,'2023-04-14'),
(12,'Neha Joshi','neha@gmail.com','Female',31,'India',4,'2023-05-05'),
(13,'Arjun Rao','arjun@gmail.com','Male',34,'India',11,'2023-06-01'),
(14,'Pooja Shah','pooja@gmail.com','Female',22,'India',12,'2023-07-10'),
(15,'Michael Brown','michael@gmail.com','Male',38,'USA',14,'2023-02-05'),
(16,'Sonia Kapoor','sonia@gmail.com','Female',41,'India',13,'2023-03-09'),
(17,'Kunal Jain','kunal@gmail.com','Male',28,'India',18,'2023-04-22'),
(18,'Priya Nair','priya@gmail.com','Female',36,'India',17,'2023-05-30'),
(19,'Alex Green','alex@gmail.com','Male',32,'Australia',20,'2023-01-18'),
(20,'Mehul Patel','mehul@gmail.com','Male',27,'India',19,'2023-06-25');
select * from users;

INSERT INTO content VALUES
(1,'Sacred Games','TV Show','Crime','Hindi',2018,600,8.6),
(2,'Money Heist','TV Show','Thriller','Spanish',2017,700,8.3),
(3,'Breaking Bad','TV Show','Drama','English',2008,900,9.5),
(4,'RRR','Movie','Action','Telugu',2022,182,8.1),
(5,'3 Idiots','Movie','Comedy','Hindi',2009,170,8.4),
(6,'KGF','Movie','Action','Kannada',2018,155,8.2),
(7,'Stranger Things','TV Show','Sci-Fi','English',2016,800,8.7),
(8,'Dark','TV Show','Sci-Fi','German',2017,720,8.8),
(9,'Dangal','Movie','Drama','Hindi',2016,161,8.4),
(10,'Bahubali','Movie','Action','Telugu',2015,159,8.0),
(11,'Friends','TV Show','Comedy','English',1994,1000,8.9),
(12,'The Crown','TV Show','Drama','English',2016,850,8.6),
(13,'Jawan','Movie','Action','Hindi',2023,165,7.8),
(14,'Pushpa','Movie','Action','Telugu',2021,179,7.6),
(15,'The Witcher','TV Show','Fantasy','English',2019,780,8.1),
(16,'Parasite','Movie','Thriller','Korean',2019,132,8.5),
(17,'Lucifer','TV Show','Crime','English',2016,900,8.2),
(18,'Drishyam','Movie','Thriller','Hindi',2015,163,8.3),
(19,'Narcos','TV Show','Crime','Spanish',2015,820,8.8),
(20,'Avatar','Movie','Sci-Fi','English',2009,162,7.9);
select * from content;

INSERT INTO watch_history VALUES
(1,1,1,'2023-07-01',300,'Yes'),
(2,2,2,'2023-07-02',200,'No'),
(3,3,3,'2023-07-03',900,'Yes'),
(4,4,4,'2023-07-04',180,'Yes'),
(5,5,5,'2023-07-05',170,'Yes'),
(6,6,6,'2023-07-06',140,'No'),
(7,7,7,'2023-07-07',600,'Yes'),
(8,8,8,'2023-07-08',700,'Yes'),
(9,9,9,'2023-07-09',160,'Yes'),
(10,10,10,'2023-07-10',150,'No'),
(11,11,11,'2023-07-11',1000,'Yes'),
(12,12,12,'2023-07-12',800,'Yes'),
(13,13,13,'2023-07-13',165,'Yes'),
(14,14,14,'2023-07-14',150,'No'),
(15,15,15,'2023-07-15',780,'Yes'),
(16,16,16,'2023-07-16',132,'Yes'),
(17,17,17,'2023-07-17',850,'Yes'),
(18,18,18,'2023-07-18',163,'Yes'),
(19,19,19,'2023-07-19',820,'Yes'),
(20,20,20,'2023-07-20',162,'Yes');
select * from watch_history;

INSERT INTO payments VALUES
(1,1,1,'2023-01-10',199,'UPI','Success'),
(2,2,2,'2023-02-12',499,'Card','Success'),
(3,3,3,'2023-03-15',799,'UPI','Success'),
(4,4,9,'2023-01-20',4999,'Card','Success'),
(5,5,8,'2023-04-01',2999,'NetBanking','Success'),
(6,6,5,'2023-05-10',2499,'UPI','Success'),
(7,7,10,'2023-06-18',149,'UPI','Success'),
(8,8,6,'2023-02-28',3999,'Card','Success'),
(9,9,7,'2023-03-22',1799,'UPI','Success'),
(10,10,15,'2023-01-30',5999,'Card','Success'),
(11,11,16,'2023-04-14',99,'UPI','Success'),
(12,12,4,'2023-05-05',999,'NetBanking','Success'),
(13,13,11,'2023-06-01',799,'UPI','Success'),
(14,14,12,'2023-07-10',1299,'UPI','Success'),
(15,15,14,'2023-02-05',3499,'Card','Success'),
(16,16,13,'2023-03-09',699,'UPI','Success'),
(17,17,18,'2023-04-22',899,'UPI','Success'),
(18,18,17,'2023-05-30',499,'Card','Success'),
(19,19,20,'2023-01-18',9999,'NetBanking','Success'),
(20,20,19,'2023-06-25',0,'NA','Success');
select * from payments;

INSERT INTO ratings_reviews VALUES
(1,1,1,9,'Excellent show','2023-07-02'),
(2,2,2,8,'Very thrilling','2023-07-03'),
(3,3,3,10,'Masterpiece','2023-07-04'),
(4,4,4,8,'Great action','2023-07-05'),
(5,5,5,9,'Inspirational','2023-07-06'),
(6,6,6,8,'Good movie','2023-07-07'),
(7,7,7,9,'Amazing','2023-07-08'),
(8,8,8,9,'Mind blowing','2023-07-09'),
(9,9,9,8,'Emotional','2023-07-10'),
(10,10,10,7,'Good visuals','2023-07-11'),
(11,11,11,10,'All time favorite','2023-07-12'),
(12,12,12,9,'Well made','2023-07-13'),
(13,13,13,8,'Nice movie','2023-07-14'),
(14,14,14,7,'Decent','2023-07-15'),
(15,15,15,8,'Enjoyable','2023-07-16'),
(16,16,16,9,'Brilliant','2023-07-17'),
(17,17,17,8,'Interesting','2023-07-18'),
(18,18,18,9,'Suspense','2023-07-19'),
(19,19,19,9,'Very engaging','2023-07-20'),
(20,20,20,8,'Good sci-fi','2023-07-21');
select * from ratings_reviews;

--------------------------------------------------------- Arithmetic operators----------------------------------------------------------------
select user_id , payment_id * 2 as Calculate_column 
from payments;

select content_id , rating + 0.23 as total_sum
from ratings_reviews; 

select plan_name , price , price - 12 as substraction 
from subscriptions;

select plan_name , price / duration_month as months
from subscriptions
where duration_month = 12;

select sum(amount) as revenue , 
	   sum(amount) * 1.18 as total_gst 
from payments;

--------------------------------- Comparision operator --------------------------------------------------------------------
-- Comparision operator are used to compare value.
select * from users 
where age > 30;

select * from subscriptions
where price >= 3000;

select title , release_year from content
where release_year > 2020;

---------------------------------------------------- Logical Operator --------------------------------------------------------------------

select * from users 
where country = 'India' and age > 35 and gender = 'Female';

select * from content 
where not language = 'English' or Language = 'Hindi';

----------------------------------------------------- Special character -------------------------------------------------------------------
select * from users 
where user_id in (2,3,11);

select * from payments
where amount between 1200 and 2500;

select * from users 
where user_name like 'A%' ;
select * from users 
where user_name like '_________' ;
select * from users 
where user_name like '%Raj%' ;

select * from ratings_reviews
where review_text is null;

select * from ratings_reviews
where review_text is not null
order by review_text asc
limit 2;

-------------------------------------------------- Agregate Function ------------------------------------------------------------------------

select count(*) as count_rows
from users;

select sum(age) as sum_rows
from users;

select avg(amount) as avg_rows
from payments;

select min(rating) as min_rating_rows 
from ratings_reviews;

select max(rating) as max_rating_rows
from ratings_reviews;

-------------------------------------------------- group by ------------------------------------------------------------------------------

select country , count(*) as contry_count 
from users 
group by country;

select plan_name , sum(price) as sum_price
from subscriptions 
group by plan_name;

select user_id , min(rating) as min_rating 
from ratings_reviews
group by user_id;

-- ****
select payment_date , min(amount) as max_amount
from payments 
group by payment_date;

select user_id ,avg(rating) as avg_rating 
from ratings_reviews
group by user_id;

--------------------------------------------- Having Clause ---------------------------------------------------------------------------------

select user_id , avg(rating) as avg_rating
from ratings_reviews
group by user_id 
having avg(rating) >=9;

-------------------------------------------- String Function ---------------------------------------------------------------------------------

select upper('meet');

select lower('MEET');

select length('ASDDGUGFBKID');

select left('Meet',1) as lefiside_name ; 

select right('Meet',2) as rightside_name;

select trim('     sql    ') as trim_name;

select ltrim('           sql            ') as ltrim_name;

select concat("Power","  ","Bi") as conact_name;

select concat_ws("-", "2004" , "2" , "15") as concate_ws_name;

select substring('Power Bi',1,7) as substring_name ;

select position("W"  in  "POWER BI") as positin_name;

select repeat('*',5) as repeat_column;

select reverse("SQL") as reverse_column;

-------------------------------- joins -------------------------------------------------------------------------------------------------

select review_id , review_text , rating
from ratings_reviews as r
inner join users as u 
on r.user_id = u.user_id ;

select payment_id , payment_date , amount , rating , review_date 
from ratings_reviews as r
cross join payments as p ;

---------------------------------------------------------------- Subquery ----------------------------------------------

select review_id , user_id , review_text  from ratings_reviews 
where rating > (select avg(rating) from ratings_reviews);

---------------------------------------------------- view --------------------------------------------------------------------------------

create view as_ratings_reviews as 
select review_id , user_id , content_id 
from ratings_reviews;

select * from as_ratings_reviews ;

create view cv_payments as 
select payment_id , user_id , payment_date 
from payments;
select * from cv_payments;

create view gh_content as
select content_id , title , genre 
from content ;
select * from gh_content;

create view bn_watch_history as 
select watch_date , watch_duration 
from watch_history ; 
select * from bn_watch_history;

----------------------------------------------- Store procedure ------------------------------------------

delimiter //
create procedure get_users()
begin 
select user_id , email , age from users 
limit 5 ;
end //
delimiter ;
call get_users();

delimiter //
create procedure et_users()
begin 
select user_id , email , age from users 
limit 4 ;
end //
delimiter ;
call et_users();

delimiter // 
create procedure gf_payments()
begin 
select payment_id , payment_date , amount 
from payments 
where payment_id > 5 
limit 5;
end // 
delimiter ;
call gf_payments();

delimiter // 
create procedure ab_watch_history()
begin
select watch_id , watch_date , watch_duration , completed_flag 
from watch_history
where watch_id < 5
limit 3;
end //
delimiter ; 
call ab_watch_history();

select * from users;
update users 
set age = case
    when age =30 then 35 
    when age = 35 then 40
    else age 
end
where user_id > 0;
update users
set age = case
    when age = 30 then 35
    when age = 35 then 40
    else age
end
where user_id > 0;
select * from users;
select left (user_name , 3) from users;
select replace(country , 'India','Ind') as replace_name from users;

create index idx_country on users (country);
show index from users;

------------------------------------------------------ Transaction --------------------------------------------------------------------------

start transaction ;
update users set age = age + 1 where user_id = 1;
update users set age = age * 5 where user_id =5;
update users set age = age / 5 where user_id = 5;
commit;
select * from users
where user_id in (5);

select * from users 
where user_id % 2 = 1 ;

select * from users 
where user_id % 2 = 0 ;