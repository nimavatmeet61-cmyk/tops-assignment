create database Amazon 
USE Amazon
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    country VARCHAR(50));

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id));

CREATE TABLE OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id));

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(30),
    amount DECIMAL(10,2),
    payment_date DATE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id));

INSERT INTO Customers (name, email, country) 
VALUES
('Amit Sharma', 'amit@gmail.com', 'India'),
('Priya Mehta', 'priya@gmail.com', 'India'),
('John Smith', 'john@gmail.com', 'USA'),
('Mahesh Ram', 'mahesh@gmail.com', 'Aus'),
('Dax Rau', 'dax@gmail.com', 'Japan'),
('Parth Sharma', 'parth@gmail.com', 'Pak'),
('Raj Mishra', 'raj2gmail.com', 'Usa');
select * from customers;

INSERT INTO Products (name, category, price, stock) 
VALUES
('Laptop', 'Electronics', 60000, 10),
('Mobile', 'Electronics', 25000, 15),
('Shoes', 'Fashion', 3000, 25),
('Watch', 'Accessories', 5000, 20),
('Tv', 'Electronics', 20000, 12),
('Clothes', 'Fashion', 25000, 8 );
select * from products;

INSERT INTO Orders (customer_id, order_date, status) 
VALUES
(1, '2025-10-10', 'Delivered'),
(2, '2025-10-12', 'Pending'),
(3, '2025-10-14', 'Delivered'),
(4, '2025-9-25', 'Arrived'),
(5, '2025-10-3', 'Pending'),
(6, '2025-5-6', 'Arrived');
select * from orders;

INSERT INTO OrderDetails (order_id, product_id, quantity) 
VALUES
(1, 1, 1),
(1, 4, 2),
(2, 2, 1),
(3, 3, 3),
(4, 5, 7),
(5, 2, 4);
select * from orderDetails;

INSERT INTO Payments (order_id, payment_method, amount, payment_date) 
VALUES
(1, 'Credit Card', 70000, '2025-10-11'),
(2, 'UPI', 25000, '2025-10-13'),
(3, 'Debit Card', 9000, '2025-10-15'),
(4, 'UPI', 10000, '2025-6-4'),
(5, 'Credit Card', 52036, '2025-8-23'),
(6, 'Debit Card', 42015, '2025-3-12');
select * from Payments;

SELECT name, category, price 
FROM Products;

SELECT order_id, status 
FROM Orders;

SELECT * FROM Customers 
WHERE country = 'India';

SELECT * FROM Products 
WHERE price >= 22000;

SELECT * FROM Products 
WHERE price <= 21000;

SELECT * FROM Products 
ORDER BY price DESC LIMIT 2;

select * from customers
where customer_id in (6);

select * from products
where price between 10000 and 100000;

select * from customers
where name like "__________";

select * from customers
where customer_id is null;

select * from customers
where customer_id is not null;

select distinct status from orders;

SELECT c.name, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.name;

SELECT p.category, SUM(od.quantity * p.price) AS total_revenue
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.category;

SELECT AVG(price) AS avg_price 
FROM Products;

SELECT p.category, SUM(od.quantity * p.price) AS total_revenue
FROM OrderDetails od
JOIN Products as p 
ON od.product_id = p.product_id
GROUP BY p.category
HAVING total_revenue > 10000;

UPDATE Products 
SET stock = stock - 2 
WHERE product_id = 1;

SELECT o.order_id, 
  c.name AS customer_name, 
  p.name AS product_name, 
  od.quantity
FROM Orders o
LEFT JOIN Customers c 
ON o.customer_id = c.customer_id
LEFT JOIN OrderDetails od 
ON o.order_id = od.order_id
LEFT JOIN Products p 
ON od.product_id = p.product_id;

SELECT o.order_id, 
  c.name AS customer_name, 
  p.name AS product_name, 
  od.quantity
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id;

SELECT o.order_id, 
  c.name AS customer_name, 
  p.name AS product_name, 
  od.quantity
FROM Orders o
RIGHT JOIN Customers c 
ON o.customer_id = c.customer_id
RIGHT JOIN OrderDetails od 
ON o.order_id = od.order_id
RIGHT JOIN Products p 
ON od.product_id = p.product_id;

SELECT * 
FROM Orders o
LEFT JOIN Customers c ON o.customer_id = c.customer_id
UNION
SELECT * 
FROM Orders o
RIGHT JOIN Customers c ON o.customer_id = c.customer_id;

SELECT 
  c.name AS customer_name, 
  p.name AS product_name
FROM Customers c
CROSS JOIN Products p;

DELIMITER //
CREATE PROCEDURE GetCustomerOrders(IN cust_id INT)
BEGIN
    SELECT o.order_id, o.status, p.amount, p.payment_date
    FROM Orders o
    JOIN Payments p ON o.order_id = p.order_id
    WHERE o.customer_id = cust_id;
END //
DELIMITER ;
CALL GetCustomerOrders(1);

CREATE VIEW OrderSummary AS
SELECT o.order_id, c.name AS customer_name, o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;

--------------------------------------------Before insert---------------------------------------------

DELIMITER //
CREATE TRIGGER trigger_before_insert 
before insert ON products
FOR EACH ROW
BEGIN
     if NEW.price < 0 then
      set NEW.price = 0;
      end if;
END //
DELIMITER ;
SHOW TRIGGERS;
INSERT INTO Products (name, category, price, stock) 
VALUES
("Meet", "Fashion", "-25000", "10");
INSERT INTO Products (name, category, price, stock) 
VALUES
("Abc", "Electronic", "250000", "1");
select * from products;
-------------------------------------After Insert---------------------------------------------------------------------
create TABLE action_log(
	log_id int auto_increment primary key,
	table_name varchar(50),
    action_type varchar(20),
    old_data text,
    new_data text,
    action_time timestamp default current_timestamp);
    
    delimiter //    
create trigger after_customer_insert 
after insert on customers
for each row
begin 
 insert into action_log(table_name, action_type, new_data)
 values ('Customers', 'insert', concat('name:', NEW.name, ',email: ', NEW.Email, ',country: ', NEW.Country));
   end //
delimiter ;
    
insert into customers (name, email, country)
values
('Nmb', 'nmbabc@45gmail.com', 'Bangladesh');
------------------------------------------Before update----------------------------------
DELIMITER //
CREATE TRIGGER before_products_update  
before update ON products
FOR EACH ROW
BEGIN
	 set NEW.name = upper(NEW.name);
END //
DELIMITER ;

update products
set name = 'Meet Kumar'
where product_id = 7;
select * from products;
------------------------------After update---------------------------------------------------------
create TABLE action_log(
	log_id int auto_increment primary key,
	table_name varchar(50),
    action_type varchar(20),
    old_data text,
    new_data text,
    action_time timestamp default current_timestamp);
select * from products;

DELIMITER //
CREATE TRIGGER after_products_update
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    INSERT INTO action_log (table_name, action_type, old_data, new_data)
    VALUES (
        'products',
        'Update',
      CONCAT('Old name: ', OLD.name, ', Old category: ', OLD.category, ', Old price: ', OLD.price, ', Old stock: ', OLD.stock),
        CONCAT('New name: ', NEW.name, ', New category: ', NEW.category, ', New price: ', NEW.price, ', New stock: ', NEW.stock));
END //

DELIMITER ;

UPDATE products
SET stock = 35
WHERE product_id = 1;
select * from action_log;
                 
-----------------------------------------before delete--------------------------------------------------------------------

DELIMITER //
CREATE TRIGGER before_products_delete
BEFORE DELETE ON products
FOR EACH ROW
BEGIN
    INSERT INTO action_log (table_name, action_type, old_data, new_data)
    VALUES (
        'products',
        'delete',
        CONCAT('Deleted Product -> Name: ', OLD.name, 
               ', Category: ', OLD.category, 
               ', Price: ', OLD.price, 
               ', Stock: ', OLD.stock),
        NULL
    );
END //
DELIMITER ;

DELETE FROM products
WHERE product_id = 2;
SET FOREIGN_KEY_CHECKS = 0;

------------------------------------------------After Delete---------------------------------------------------------------------------
create TABLE action_log(
	log_id int auto_increment primary key,
	table_name varchar(50),
    action_type varchar(20),
    old_data text,
    new_data text,
    action_time timestamp default current_timestamp);
    
DELIMITER //
CREATE TRIGGER after_products_delete
AFTER DELETE ON products
FOR EACH ROW
BEGIN
    INSERT INTO action_log (table_name, action_type, old_data, new_data)
    VALUES (
        'products',
        'delete',
        CONCAT('Deleted Product -> Name: ', OLD.name, 
               ', Category: ', OLD.category, 
               ', Price: ', OLD.price, 
               ', Stock: ', OLD.stock),
        NULL);
END //
DELIMITER ;

DELETE FROM products
WHERE product_id = 3;
select * from products;

















create TABLE action_log(
	log_id int auto_increment primary key,
	table_name varchar(50),
    action_type varchar(20),
    old_data text,
    new_data text,
    action_time timestamp default current_timestamp);
    
    
delimiter //
create trigger after_order_update
after update on orders 
for each row
begin 
	insert into action_log (table_name, action_type, old_data, new_data)
	values ( 'orders',
			 'update',
             concat('Old order_id: ', OLD.order_id, ', Old customer_id: ', OLD.customer_id, ', Old order_date: ', OLD.order_date, ', Old status:', OLD.status),
	         concat('New order_id: ', NEW.order_id, ', New customer_id: ', NEW.customer_id, ', New order_date: ', NEW.order_date, ', New status:', NEW.status));
end //
delimiter ;
select * from orders;


UPDATE orders
SET status = 'Arrived'
WHERE order_id = 6;



DROP TRIGGER IF EXISTS after_order_update;




DELIMITER //
CREATE TRIGGER after_order_update
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    INSERT INTO action_log (table_name, action_type, old_data, new_data)
    VALUES (
        'orders',
        'update',
        CONCAT(
            'Old order_id: ', OLD.order_id,
            ', Old customer_id: ', OLD.customer_id,
            ', Old order_date: ', OLD.order_date,
            ', Old status: ', OLD.status
        ),
        CONCAT(
            'New order_id: ', NEW.order_id,
            ', New customer_id: ', NEW.customer_id,
            ', New order_date: ', NEW.order_date,
            ', New status: ', NEW.status
        )
    );
END //

DELIMITER ;
