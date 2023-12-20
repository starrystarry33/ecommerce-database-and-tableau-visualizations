USE group4;

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


