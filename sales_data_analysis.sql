-- Create the regions table
CREATE TABLE regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(100)
);

-- Insert sample data into regions
INSERT INTO regions (region_id, region_name) VALUES
(1, 'North America'),
(2, 'Europe'),
(3, 'Asia');

-- Create the customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    region_id INT,
    signup_date DATE,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

-- Insert sample data into customers
INSERT INTO customers (customer_id, customer_name, email, region_id, signup_date) VALUES
(1, 'Alice Johnson', 'alice@example.com', 1, '2023-01-10'),
(2, 'Bob Smith', 'bob@example.com', 2, '2023-02-15'),
(3, 'Charlie Brown', 'charlie@example.com', 3, '2023-03-20');

-- Create the products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10, 2)
);

-- Insert sample data into products
INSERT INTO products (product_id, product_name, category, price) VALUES
(1, 'Laptop', 'Electronics', 1200.00),
(2, 'Smartphone', 'Electronics', 800.00),
(3, 'Headphones', 'Accessories', 150.00);

-- Create the sales table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE,
    customer_id INT,
    product_id INT,
    quantity INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample data into sales
INSERT INTO sales (sale_id, sale_date, customer_id, product_id, quantity, total_amount) VALUES
(1, '2024-01-01', 1, 1, 2, 2400.00),
(2, '2024-01-05', 2, 2, 1, 800.00),
(3, '2024-01-10', 3, 3, 5, 750.00);

-- Query to calculate total sales amount by product
SELECT 
    p.product_name, 
    SUM(s.total_amount) AS total_sales
FROM 
    sales s
JOIN 
    products p ON s.product_id = p.product_id
GROUP BY 
    p.product_name
ORDER BY 
    total_sales DESC;

-- Query to calculate sales by region
SELECT 
    r.region_name, 
    SUM(s.total_amount) AS total_sales
FROM 
    sales s
JOIN 
    customers c ON s.customer_id = c.customer_id
JOIN 
    regions r ON c.region_id = r.region_id
GROUP BY 
    r.region_name
ORDER BY 
    total_sales DESC;

-- Query to find the top customers by total spending
SELECT 
    c.customer_name, 
    SUM(s.total_amount) AS total_spent
FROM 
    sales s
JOIN 
    customers c ON s.customer_id = c.customer_id
GROUP BY 
    c.customer_name
ORDER BY 
    total_spent DESC
LIMIT 5;

-- Query to analyze sales performance over time (monthly)
SELECT 
    DATE_FORMAT(s.sale_date, '%Y-%m') AS month,
    SUM(s.total_amount) AS total_sales
FROM 
    sales s
GROUP BY 
    month
ORDER BY 
    month;

-- Query to evaluate sales performance by product category
SELECT 
    p.category, 
    SUM(s.total_amount) AS total_sales
FROM 
    sales s
JOIN 
    products p ON s.product_id = p.product_id
GROUP BY 
    p.category
ORDER BY 
    total_sales DESC;
