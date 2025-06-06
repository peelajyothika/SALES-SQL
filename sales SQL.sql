create database sales_sql;
use sales_sql;
create table Customers(customer_id  int , name varchar(50), country varchar(50));
INSERT INTO Customers (customer_id, name, country)
VALUES 
(1, 'jyo', 'ind'),
(2, 'rahul', 'ind'),
(3, 'liki', 'ind'),
(4, 'dilip', 'ind'),
(5, 'pratyu', 'ind'),
(6, 'kiran', 'ind'),
(7, 'vasu', 'ind'),
(8, 'mouli', 'us'),
(9, 'peter', 'eup');

create table Orders(order_id int, customer_id int , order_date timestamp, total_amount int);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount)
VALUES
INSERT INTO Orders (order_id, customer_id, total_amount)
VALUES
(1, 1, 500),
(2, 2, 50),
(3, 3, 1500),
(4, 4, 1500),
(5, 5, 100),
(6, 6, 1500),
(7, 7, 2500),
(8, 8, 1500),
(9, 9, 1500);
select* from orders;

create table Products(product_id int, name varchar(50), price int, category varchar(50));
INSERT INTO Products (product_id, name, price, category)
VALUES
(1, 'chair', 20000, 'b'),
(2, 'sofa', 120000, 'b'),
(3, 'bed', 56000, 'a'),
(4, 'dinning table', 30000, 'g');

CREATE TABLE OrderDetails (
  order_detail_id INT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity VARCHAR(50));
  
INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity)
VALUES
(1, 1, 1, 'A'),
(2, 2, 2, 'B'),
(3, 3, 3, 'C');

-- Show all orders above ₹500, sorted by total_amount descending
SELECT * 
FROM Orders 
WHERE total_amount > 500 
ORDER BY total_amount DESC;

-- Total amount spent by each customer
SELECT customer_id, SUM(total_amount) AS total_spent
FROM Orders
GROUP BY customer_id
ORDER BY total_spent DESC;

-- List all customers with their orders (INNER JOIN)
SELECT c.name, o.order_id, o.total_amount
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;

-- LEFT JOIN to show customers even without orders
SELECT c.name, o.order_id
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

-- Customers who spent more than average
SELECT name
FROM Customers
WHERE customer_id IN (
  SELECT customer_id
  FROM Orders
  GROUP BY customer_id
  HAVING SUM(total_amount) > (
    SELECT AVG(total_amount) FROM Orders
  )
);

-- Average order value
SELECT AVG(total_amount) AS avg_order_value FROM Orders;

-- Number of orders per country
SELECT c.country, COUNT(o.order_id) AS num_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.country;

-- Create a view for high-value customers (spent > ₹2000)
DROP VIEW IF EXISTS high_value_customers;
-- or if it's a stored procedure:
DROP PROCEDURE IF EXISTS high_value_customers;

-- Then create your object again
CREATE VIEW high_value_customers AS
SELECT customer_id, SUM(total_amount) AS total_spent
FROM Orders
GROUP BY customer_id
HAVING SUM(total_amount) > 2000;
 
 -- Create index on Orders.customer_id for faster JOINs
CREATE INDEX idx_customer_id ON Orders(customer_id);






