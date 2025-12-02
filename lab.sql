
-- CUSTOMER DIMENSION TABLE (who bought)
CREATE TABLE dim_customer (
    customer_id INTEGER PRIMARY KEY,
    customer_name TEXT,
    city TEXT
);


-- PRODUCT DIMENSION TABLE (what was bought)
CREATE TABLE dim_product (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    category TEXT
);


-- DATE DIMENSION TABLE (when something happened)
CREATE TABLE dim_date (
    date_id INTEGER PRIMARY KEY,
    full_date TEXT,
    year INTEGER,
    month INTEGER,
    day INTEGER
);


-- FACT TABLE (actual sales and numbers)
CREATE TABLE fact_sales (
    sale_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    product_id INTEGER,
    date_id INTEGER,
    quantity INTEGER,
    amount REAL,

    -- links to dimension tables
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);


-- INSERT CUSTOMER DATA
INSERT INTO dim_customer VALUES
(1, 'Aarav', 'Delhi'),
(2, 'Vihaan', 'Mumbai'),
(3, 'Siya', 'Bangalore');


-- INSERT PRODUCT DATA
INSERT INTO dim_product VALUES
(101, 'Notebook', 'Stationery'),
(102, 'Pen', 'Stationery'),
(103, 'Headphones', 'Electronics'),
(104, 'Keyboard', 'Electronics');  -- this product has no sales yet


-- INSERT DATE DATA
INSERT INTO dim_date VALUES
(20240101, '2024-01-01', 2024, 1, 1),
(20240102, '2024-01-02', 2024, 1, 2),
(20240201, '2024-02-01', 2024, 2, 1);


-- INSERT SALES DATA (FACT)
INSERT INTO fact_sales VALUES
(1, 1, 101, 20240101, 2, 200.00),
(2, 1, 102, 20240102, 5, 250.00),
(3, 2, 103, 20240201, 1, 1500.00),
(4, 3, 101, 20240201, 1, 100.00);



SELECT * FROM dim_customer;

SELECT * FROM dim_product;

SELECT * FROM dim_date;

SELECT * FROM fact_sales;

SELECT 
    fs.sale_id,
    dc.customer_name,
    dc.city,
    dp.product_name,
    dp.category,
    dd.full_date,
    fs.quantity,
    fs.amount
FROM fact_sales fs
JOIN dim_customer dc ON fs.customer_id = dc.customer_id
JOIN dim_product dp ON fs.product_id = dp.product_id
JOIN dim_date dd ON fs.date_id = dd.date_id;

SELECT 
    dc.city,
    SUM(fs.amount) AS total_sales
FROM fact_sales fs
JOIN dim_customer dc ON fs.customer_id = dc.customer_id
GROUP BY dc.city;

SELECT 
    dp.category,
    SUM(fs.amount) AS total_sales
FROM fact_sales fs
JOIN dim_product dp ON fs.product_id = dp.product_id
GROUP BY dp.category;

SELECT 
    dd.year,
    dd.month,
    SUM(fs.amount) AS total_sales
FROM fact_sales fs
JOIN dim_date dd ON fs.date_id = dd.date_id
WHERE dd.year = 2024
GROUP BY dd.year, dd.month;

SELECT 
    dc.city,
    SUM(fs.amount) AS revenue
FROM fact_sales fs
JOIN dim_customer dc ON fs.customer_id = dc.customer_id
GROUP BY dc.city
ORDER BY revenue DESC
LIMIT 1;

SELECT 
    dp.product_name
FROM dim_product dp
LEFT JOIN fact_sales fs ON dp.product_id = fs.product_id
WHERE fs.product_id IS NULL;

SELECT 
    dp.product_name,
    SUM(fs.quantity) AS total_quantity
FROM fact_sales fs
JOIN dim_product dp ON fs.product_id = dp.product_id
GROUP BY dp.product_name;
