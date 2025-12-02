

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER
);

CREATE TABLE order_items (
    order_id INTEGER,
    product_id INTEGER
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    name TEXT,
    price INTEGER
);

INSERT INTO customers VALUES
(1, 'Riya'),
(2, 'Karan'),
(3, 'Amit'),
(4, 'Neha');

INSERT INTO orders VALUES
(101, 1),
(102, 2),
(103, 1);

INSERT INTO order_items VALUES
(101, 201),
(101, 202),
(102, 202),
(103, 203);

INSERT INTO products VALUES
(201, 'Pen', 10),
(202, 'Book', 100),
(203, 'Bag', 500),
(204, 'Bottle', 50);



SELECT 
    c.name,
    o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

SELECT 
    c.name AS customer_name,
    p.name AS product_name
FROM customers c
JOIN orders o        ON c.customer_id = o.customer_id
JOIN order_items oi  ON o.order_id = oi.order_id
JOIN products p      ON oi.product_id = p.product_id;

SELECT 
    c.name,
    SUM(p.price) AS total_spent
FROM customers c
JOIN orders o        ON c.customer_id = o.customer_id
JOIN order_items oi  ON o.order_id = oi.order_id
JOIN products p      ON oi.product_id = p.product_id
GROUP BY c.name;

SELECT 
    p.name AS unsold_products
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

SELECT 
    c.name AS no_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT 
    o.order_id,
    COUNT(oi.product_id) AS product_count
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id;

SELECT 
    p.name,
    SUM(p.price) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.name;

SELECT 
    p.name,
    SUM(p.price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.name
ORDER BY revenue DESC
LIMIT 1;

SELECT 
    temp.name,
    p.name AS product_name
FROM (
    SELECT 
        c.customer_id,
        c.name,
        o.order_id
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
) temp
JOIN order_items oi ON temp.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

SELECT 
    c.name,
    COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;
