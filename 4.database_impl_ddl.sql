CREATE DATABASE group4;

USE group4;

CREATE TABLE users (
    user_id INT PRIMARY KEY IDENTITY,
    email VARCHAR(255),
    password VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY IDENTITY,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


CREATE TABLE addresses (
    address_id INT PRIMARY KEY IDENTITY,
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(50),
    zip_code VARCHAR(20)
);


CREATE TABLE sellers (
    seller_id INT PRIMARY KEY IDENTITY,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


CREATE TABLE revenues (
    revenue_id INT PRIMARY KEY IDENTITY,
    seller_id INT,
    total DECIMAL(10,2) NOT NULL,
    created_date DATE DEFAULT(GETDATE()),
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);


CREATE TABLE coupons (
    coupon_id INT PRIMARY KEY IDENTITY,
    seller_id INT,
    discount DECIMAL(5,2) NOT NULL,
    coupon_code VARCHAR(20) NOT NULL,
    valid_date DATE DEFAULT(GETDATE()),
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY IDENTITY,
    customer_id INT,
    coupon_id INT,
    total DECIMAL(10,2) NOT NULL,
    created_date DATE DEFAULT(GETDATE()),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (coupon_id) REFERENCES coupons(coupon_id)
);


CREATE TABLE payments (
    payment_id INT PRIMARY KEY IDENTITY,
    revenue_id INT,
    order_id INT,
    seller_id INT,
    total DECIMAL(10,2) NOT NULL,
    updated_date DATE DEFAULT(GETDATE()),
    FOREIGN KEY (revenue_id) REFERENCES revenues(revenue_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);



CREATE TABLE [returns] (
    return_id INT PRIMARY KEY IDENTITY,
    order_id INT,
    customer_id INT,
    payment_id INT,
    created_date DATE DEFAULT(GETDATE()),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (payment_id) REFERENCES payments(payment_id)
);


CREATE TABLE categories (
    category_id INT PRIMARY KEY IDENTITY,
    categegory_type VARCHAR(255) NOT NULL
);


CREATE TABLE products (
    product_id INT PRIMARY KEY IDENTITY,
    seller_id INT,
    price DECIMAL(10,2) NOT NULL,
    product_description VARCHAR(255) DEFAULT(''),
    updated_date DATE DEFAULT(GETDATE()),
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);


CREATE TABLE products_categories (
    product_id INT,
    category_id INT,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);


CREATE TABLE reviews (
    review_id INT PRIMARY KEY IDENTITY,
    product_id INT,
    customer_id INT,
    review_star INT NOT NULL,
    review_content VARCHAR(255) DEFAULT(''),
  	created_date DATE DEFAULT(GETDATE()),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


CREATE TABLE orders_products (
    order_id INT,
    product_id INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


CREATE TABLE users_addresses (
    user_id INT,
    address_id INT,
    PRIMARY KEY (user_id, address_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (address_id) REFERENCES addresses(address_id)
);

INSERT INTO users (email, password, first_name, last_name) VALUES
('alice.smith@example.com', 'password123', 'Alice', 'Smith'),
('bob.johnson@example.com', 'password456', 'Bob', 'Johnson'),
('carol.williams@example.com', 'password789', 'Carol', 'Williams'),
('dave.jones@example.com', 'password101', 'Dave', 'Jones'),
('emma.brown@example.com', 'password202', 'Emma', 'Brown'),
('frank.davis@example.com', 'password303', 'Frank', 'Davis'),
('grace.miller@example.com', 'password404', 'Grace', 'Miller'),
('henry.wilson@example.com', 'password505', 'Henry', 'Wilson'),
('irene.moore@example.com', 'password606', 'Irene', 'Moore'),
('jack.taylor@example.com', 'password707', 'Jack', 'Taylor'),
('lucy.anderson@example.com', 'securepass11', 'Lucy', 'Anderson'),
('max.harris@example.com', 'mypass12', 'Max', 'Harris'),
('nina.thompson@example.com', 'nina1234', 'Nina', 'Thompson'),
('oliver.martinez@example.com', 'oliverpass', 'Oliver', 'Martinez'),
('penny.white@example.com', 'pennysecure', 'Penny', 'White'),
('quinn.lopez@example.com', 'quinnpassword', 'Quinn', 'Lopez'),
('rachel.green@example.com', 'rachel123', 'Rachel', 'Green'),
('samuel.lewis@example.com', 'samspass', 'Samuel', 'Lewis'),
('tina.hall@example.com', 'tinapass1', 'Tina', 'Hall'),
('umar.khan@example.com', 'umark123', 'Umar', 'Khan');

SELECT * FROM users;

INSERT INTO customers (user_id) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

SELECT * FROM customers;

INSERT INTO addresses (street, city, state, zip_code) VALUES
('123 Maple Street', 'Springfield', 'WA', '12345'),
('456 Oak Street', 'Riverdale', 'WA', '23456'),
('789 Pine Street', 'Hilltown', 'WA', '34567'),
('101 Elm Street', 'Laketown', 'WA', '45678'),
('202 Birch Street', 'Seaside', 'WA', '56789'),
('303 Cedar Street', 'Cliffside', 'WA', '67890'),
('404 Aspen Street', 'Valleyville', 'WA', '78901'),
('505 Willow Street', 'Forest City', 'WA', '89012'),
('606 Spruce Street', 'Mountain View', 'NY', '90123'),
('707 Redwood Street', 'Sunnyvale', 'NY', '01234');

UPDATE addresses SET street = '600 Pine St', city = 'Seattle', state = 'WA', zip_code = '98101' WHERE address_id = 1;
UPDATE addresses SET street = '200 N Spring St', city = 'Los Angeles', state = 'CA', zip_code = '90012' WHERE address_id = 2;
UPDATE addresses SET street = '1220 SW 5th Ave', city = 'Portland', state = 'OR', zip_code = '97204' WHERE address_id = 3;
UPDATE addresses SET street = '233 Broadway', city = 'New York', state = 'NY', zip_code = '10279' WHERE address_id = 4;
UPDATE addresses SET street = '1 City Hall Square', city = 'Boston', state = 'MA', zip_code = '02201' WHERE address_id = 5;
UPDATE addresses SET street = '900 Congress Ave', city = 'Austin', state = 'TX', zip_code = '78701' WHERE address_id = 6;
UPDATE addresses SET street = '414 E 12th St', city = 'Kansas City', state = 'MO', zip_code = '64106' WHERE address_id = 7;
UPDATE addresses SET street = '200 E Colfax Ave', city = 'Denver', state = 'CO', zip_code = '80203' WHERE address_id = 8;
UPDATE addresses SET street = '2 Woodward Ave', city = 'Detroit', state = 'MI', zip_code = '48226' WHERE address_id = 9;
UPDATE addresses SET street = '1600 Pennsylvania Ave NW', city = 'Washington', state = 'DC', zip_code = '20500' WHERE address_id = 10;

SELECT * FROM addresses;

INSERT INTO sellers (user_id) VALUES
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20);

SELECT * FROM sellers;

INSERT INTO coupons (seller_id, discount, coupon_code) VALUES
(1, 10.00, 'DISC10'), 
(2, 15.00, 'SAVE15'), 
(3, 20.00, 'OFF20'),
(4, 5.00, 'DEAL5'), 
(5, 25.00, 'PROMO25'), 
(6, 30.00, 'CUT30'),
(7, 35.00, 'SALE35'), 
(8, 40.00, 'BARGAIN40'), 
(9, 23.00, 'XQAIN41'),
(10, 9.00, 'OOPAIN42')

SELECT * FROM coupons;

INSERT INTO orders (customer_id, coupon_id, total) VALUES
(1, 1, 150.00), 
(2, 2, 250.00), 
(3, 3, 350.00), 
(4, 4, 450.00),
(5, 5, 550.00), 
(6, 6, 650.00), 
(7, 7, 750.00), 
(8, 8, 850.00),
(9, 9, 950.00), 
(10, 10, 1050.00),
(1, 1, 150.00);

INSERT INTO orders (customer_id, coupon_id, total) VALUES
(1, 1, 150.00),
(1, 1, 150.00), 
(2, 2, 250.00),
(2, 2, 250.00),
(3, 3, 350.00);

SELECT * FROM orders;

INSERT INTO revenues (seller_id, total) VALUES
(1, 150.00), 
(2, 250.00), 
(3, 350.00), 
(4, 450.00),
(5, 550.00), 
(6, 650.00), 
(7, 750.00), 
(8, 850.00),
(9, 950.00), 
(10, 1050.00),
(1, -150.00), 
(2, -250.00), 
(3, -350.00), 
(4, -450.00),
(5, -550.00), 
(6, -650.00), 
(7, -750.00), 
(8, -850.00),
(9, -950.00), 
(10, -1050.00),
(1, 150.00);

INSERT INTO revenues (seller_id, total) VALUES
(1, 150.00), 
(1, 150.00), 
(2, 250.00), 
(2, 250.00), 
(3, 350.00);

SELECT * FROM revenues;

INSERT INTO payments (revenue_id, order_id, seller_id, total) VALUES
(1, 1, 1, 150.00), 
(2, 2, 2, 250.00), 
(3, 3, 3, 350.00),
(4, 4, 4, 450.00), 
(5, 5, 5, 550.00), 
(6, 6, 6, 650.00),
(7, 7, 7, 750.00), 
(8, 8, 8, 850.00), 
(9, 9, 9, 950.00),
(10, 10, 10, 1050.00),
(1, 1, 1, 150.00);

INSERT INTO payments (revenue_id, order_id, seller_id, total) VALUES
(1, 1, 1, 150.00), 
(1, 1, 1, 150.00), 
(2, 2, 2, 250.00), 
(2, 2, 2, 250.00), 
(3, 3, 3, 350.00);

SELECT * FROM payments;

INSERT INTO [returns] (order_id, customer_id, payment_id) VALUES
(1, 1, 1), 
(2, 2, 2), 
(3, 3, 3), 
(4, 4, 4),
(5, 5, 5), 
(6, 6, 6), 
(7, 7, 7), 
(8, 8, 8),
(9, 9, 9), 
(10, 10, 10);

SELECT * FROM [returns];

INSERT INTO categories (categegory_type) VALUES
('Electronics'), 
('Books'), 
('Clothing'), 
('Home'),
('Sports'), 
('Toys'), 
('Health'), 
('Automotive'),
('Groceries'), 
('Music');

SELECT * FROM categories;

INSERT INTO products (seller_id, price, product_description) VALUES
(1, 160.00, 'Innovative electronic gadget'),
(2, 265.00, 'Bestselling novel'),
(3, 370.00, 'Stylish t-shirt'),
(4, 455.00, 'Garden tool set'),
(5, 575.00, 'Sports equipment'),
(6, 680.00, 'Fun toy for kids'),
(7, 785.00, 'Luxury beauty product'),
(8, 890.00, 'Automotive accessories'),
(9, 973.00, 'Organic grocery item'),
(10, 1059.00, 'Exclusive music album');

SELECT * FROM products;

INSERT INTO products_categories (product_id, category_id) VALUES
(1, 1), 
(2, 2), 
(3, 3), 
(4, 4),
(5, 5), 
(6, 6), 
(7, 7), 
(8, 8),
(9, 9), 
(10, 10);

SELECT * FROM products_categories;

INSERT INTO reviews (product_id, customer_id, review_star, review_content) VALUES
(1, 1, 2, 'Disappointed with the quality, expected more.'),
(2, 2, 1, 'Product did not work as advertised, very unsatisfied.'),
(3, 3, 2, 'Not worth the price, would not recommend.'),
(4, 4, 1, 'Very poor performance, would not buy again.'),
(5, 5, 2, 'Expected better quality, quite underwhelming.'),
(6, 6, 1, 'Had issues from the start, not reliable.'),
(7, 7, 2, 'Design is flawed, not user-friendly.'),
(8, 8, 1, 'Completely dissatisfied, a waste of money.'),
(9, 9, 2, 'Not up to the mark, many improvements needed.'),
(10, 10, 1, 'Extremely poor service and product quality.'),
(1, 1, 5, 'Extremely awesome product.');

INSERT INTO reviews (product_id, customer_id, review_star, review_content) VALUES
(1, 1, 3, 'Smart choice.'),
(1, 1, 4, 'Best purchase ever.'),
(2, 2, 5, 'Absolutely thrilled with this purchase.'),
(2, 2, 2, 'Product did not work as advertised, very unsatisfied.'),
(3, 3, 3, 'Not bad. Not really recommend.');

SELECT * FROM reviews;

INSERT INTO orders_products (order_id, product_id) VALUES
(1, 1), 
(2, 2), 
(3, 3), 
(4, 4),
(5, 5), 
(6, 6), 
(7, 7), 
(8, 8),
(9, 9), 
(10, 10),
(11, 1);

INSERT INTO orders_products (order_id, product_id) VALUES
(12, 1), 
(13, 1), 
(14, 2), 
(15, 2), 
(16, 3);

SELECT * FROM orders_products;

INSERT INTO users_addresses (user_id, address_id) VALUES
(1, 1), 
(2, 2), 
(3, 3), 
(4, 4),
(5, 5), 
(6, 6), 
(7, 7), 
(8, 8),
(9, 9), 
(10, 10);

SELECT * FROM users_addresses;

CREATE FUNCTION dbo.CustomerBoughtProduct
(
    @CustomerId INT,
    @ProductId INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Result INT;

    IF EXISTS(SELECT 1 FROM orders_products op
              INNER JOIN orders o ON op.order_id = o.order_id
              WHERE op.product_id = @ProductId AND o.customer_id = @CustomerId)
        SET @Result = 1; 
    ELSE
        SET @Result = 0;

    RETURN @Result;
END;

ALTER TABLE reviews
ADD CONSTRAINT CHK_CustomerBoughtProduct 
CHECK (dbo.CustomerBoughtProduct(customer_id, product_id) = 1);

CREATE FUNCTION dbo.GetAverageProductRating (@ProductId INT)
RETURNS DECIMAL(3,2)
AS
BEGIN
    DECLARE @AvgRating DECIMAL(3,2);

    SELECT @AvgRating = AVG(CAST(review_star AS DECIMAL(3,2)))
    FROM reviews
    WHERE product_id = @ProductId;

    RETURN @AvgRating;
END;

ALTER TABLE products
ADD avg_rating AS dbo.GetAverageProductRating(product_id);

SELECT * FROM products;

CREATE VIEW CustomerOrderDetails AS
SELECT 
    c.customer_id,
    u.first_name + ' ' + u.last_name AS customer_name,
    o.order_id,
    o.total AS order_total,
    co.coupon_code,
    co.discount AS coupon_discount,
    pr.product_id,
    pr.product_description
FROM 
    customers c
    INNER JOIN users u ON c.user_id = u.user_id
    INNER JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN coupons co ON o.coupon_id = co.coupon_id
    INNER JOIN orders_products op ON o.order_id = op.order_id
    INNER JOIN products pr ON op.product_id = pr.product_id;
   
SELECT * FROM CustomerOrderDetails;

CREATE VIEW ProductSalesReviews AS
SELECT 
    p.product_id,
    p.product_description,
    COUNT(DISTINCT op.order_id) AS total_sales
FROM 
    products p
    LEFT JOIN orders_products op ON p.product_id = op.product_id
GROUP BY 
    p.product_id, 
    p.product_description;

SELECT * FROM ProductSalesReviews;

CREATE VIEW CategoryOrderCounts AS
SELECT 
    cat.category_id,
    cat.categegory_type,
    COUNT(DISTINCT ord.order_id) AS total_orders
FROM 
    categories cat
    INNER JOIN products_categories pc ON cat.category_id = pc.category_id
    INNER JOIN products prod ON pc.product_id = prod.product_id
    INNER JOIN orders_products op ON prod.product_id = op.product_id
    INNER JOIN orders ord ON op.order_id = ord.order_id
GROUP BY 
    cat.category_id, 
    cat.categegory_type;
   
SELECT * FROM CategoryOrderCounts;


