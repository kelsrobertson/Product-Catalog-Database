# # Many-to-many relationship
CREATE DATABASE product_catalog_db;
USE product_catalog_db;

CREATE TABLE Users (
	user_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) NOT NULL
);

CREATE TABLE Orders (
	order_id INT AUTO_INCREMENT PRIMARY KEY,
	user_id INT,
	order_date DATE NOT NULL,
	FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Products (
	product_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Orderitems (
	order_item_id INT AUTO_INCREMENT PRIMARY KEY,
	order_id INT,
	product_id INT,
	quantity INT NOT NULL,
	FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
	FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

CREATE TABLE Categories (
	category_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) NOT NULL
);

CREATE TABLE ProductCategories (
	product_id INT,
	category_id INT,
	PRIMARY KEY (product_id, category_id),
	FOREIGN KEY (product_id) REFERENCES Products(product_id),
	FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

INSERT INTO Users(name) VALUES 
('Jayson Barclay'), ('Shawn Carnahan'), ('Josh Brewington');

INSERT INTO Orders(user_id, order_date) VALUES
(1, '2024-04-23'), (2, '2024-08-01'), (3,'2024-09-30');

INSERT INTO Products(name, price) VALUES
('Nike Running Shoes', 120.00), ('Apple IPhone 15', 999.99), ('Sony Headphones', 150.00);

INSERT INTO Orderitems(order_id, product_id, quantity) VALUES
(1, 1, 1), (2, 2, 1), (3, 3, 1);

INSERT INTO Categories(name) VALUES
('Electronics'), ('Sale'), ('Footwear');

INSERT INTO ProductCategories(product_id, category_id) VALUES
(1, 3), (1, 2), (2, 1), (2, 2), (3,1), (3,2);


SELECT Products.name, Products.price
FROM Products
INNER JOIN ProductCategories ON Products.product_id =
ProductCategories.product_id
INNER JOIN Categories ON ProductCategories.category_id =
Categories.category_id
WHERE Categories.name = 'Electronics';

SELECT Products.name, COUNT(ProductCategories.category_id) AS 
category_count
FROM Products
INNER JOIN ProductCategories ON Products.product_id =
ProductCategories.product_id
GROUP BY Products.product_id
HAVING category_count > 1;

SELECT Products.name, OrderItems.quantity
FROM Orders
INNER JOIN OrderItems ON Orders.order_id = OrderItems.order_id
INNER JOIN Products ON OrderItems.product_id = Products.product_id
WHERE Orders.user_id = 1; 

SELECT Orders.order_id, Orders.order_date, Products.name, OrderItems.quantity
FROM Orders
LEFT JOIN OrderItems ON Orders.order_id = OrderItems.order_id
LEFT JOIN Products ON OrderItems.product_id = Products.product_id
WHERE Orders.user_id = 1;



