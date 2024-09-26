--Create a database and tables to manage a simple e-commerce system. The system should have three tables: customers, orders, and products.

--1)Create a database named ecommerce.

CREATE DATABASE ecommerce;

USE ecommerce;

--2)Create the table customers

CREATE TABLE customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(200) NOT NULL,
  email VARCHAR(200)NOT NULL UNIQUE,
  address VARCHAR(200)NOT NULL
);

INSERT INTO customers( name,email,address)
VALUES 
   ('Olivia','olivia@gmail.com','147 main road,Nagercoil.'),
   ('Anitha','anitha3@gmail.com','188 ramaraj street,Chennai.'),
   ('Benisha','Benisha@gmail.com','193 main road,Delhi.'),
   ('Femi','femi@gmail.com','64 main street,Bengaluru.'),
   ('Anisha','anisha@gmail.com','100 main street,Kanyakumari.'),
   ('Nisha','nisha@gmail.com','164 Asaripallam,Bengaluru.');
   
   
   SELECT * FROM customers;


--3)Create the table orders

CREATE TABLE orders (
     id INT AUTO_INCREMENT PRIMARY KEY,
     customer_id INT NOT NULL,
     order_date DATE NOT NULL,
     total_amount DECIMAL(10,2) NOT NULL,
     FOREIGN KEY (customer_id) REFERENCES customers(id)
   );
   
 INSERT INTO orders (customer_id, order_date, total_amount)
 VALUES  
    (1, '2024-06-20', 1000.75),
    (2, '2024-08-25', 2080.50),
    (3, '2024-08-18', 850.45),
    (4, '2024-07-20', 1500.75),
    (2, '2024-08-15', 1080.00),
    (4, '2024-08-10', 500.75),
    (5, '2024-09-21', 250.75),
    (6, '2024-08-11', 1200.54);
    
   SELECT * FROM orders;

  
  --4)Create the table products

    CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT
);

INSERT INTO products (name, price, description)
VALUES ('Product A', 101.29, 'No risk or hazards from using the product.'),
        ('Product B', 109.50, 'Ease of use/user friendliness.'),
        ('Product C', 60.99, 'Aesthetics, style, visual appeal.'),
        ('Product D', 890.99, 'They are widely available, easy to obtain and  low price.'),
        ('Product E', 1200.99, 'Budget-friendly item for daily use.');
        

SELECT * FROM products;


--5)Retrieve all customers who have placed an order in the last 30 days.

SELECT *
FROM customers
WHERE id IN (
    SELECT customer_id
    FROM orders
    WHERE order_date >= '2024-08-22' - INTERVAL 30 DAY
);

      
         
--6)Get the total amount of all orders placed by each customer.  
      
  SELECT
    customers.id, customers.name,
    (SELECT SUM(total_amount)
    FROM orders
    WHERE orders.customer_id = customers.id) AS totalorder_amount
  FROM customers;

  --7)Update the price of Product C to 45.00.

UPDATE products
SET price = 45.00
WHERE name = 'Product C';

SELECT * FROM products;


--8)Add a new column discount to the products table.

ALTER TABLE products
ADD discount DECIMAL(5,2);

INSERT INTO products (name, price, description,discount)
    VALUES ('Product F', 200.90, 'No risk from using the product.',15.00),
           ('Product G', 230.90, 'Budget-friendly.',50.00);
    
SELECT * FROM products;


--9)Retrieve the top 3 products with the highest price.

SELECT * FROM products ORDER BY price DESC LIMIT 3;


--10)Get the names of customers who have ordered Product A.

SELECT customers.name
FROM customers
JOIN orders ON customers.id = orders.customer_id
JOIN products ON orders.id = products.id
WHERE products.name = 'Product A';

--11)Join the orders and customers tables to retrieve the customer's name and order date for each order. 

SELECT customers.name, orders.order_date
FROM customers JOIN orders ON customers.id = orders.customer_id;


--12)Retrieve the orders with a total amount greater than 150.00.

SELECT * FROM orders WHERE total_amount > 150.00;

--13)Normalize the database by creating a separate table for order items and updating the orders table to reference the order_items table.

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

    
INSERT INTO order_items(customer_id, quantity, order_date, total_amount)
VALUES (2, 5, '2024-08-25', 2080.50),
       (1, 3, '2024-06-20', 1000.75),
       (6, 5, '2024-08-11', 1200.54);


SELECT * FROM order_items;


--14)Retrieve the average total of all orders.

SELECT AVG(total_amount) AS totalorder_amount FROM orders;


--https://sqlfiddle.com/mysql/online-compiler?id=83d6df7e-ef35-49da-ad99-b0530ed59464





