-- ============================================================================
-- SALES PROJECT - COMPLETE DATABASE SETUP
-- ============================================================================
-- Database: sales_db
-- Complexity: Advanced (Joins, CTEs, Window Functions, Aggregations)
-- Use Case: Multi-branch retail company with customer relationships
-- ============================================================================

-- Drop existing database if it exists
DROP DATABASE IF EXISTS sales_db;
CREATE DATABASE sales_db;
USE sales_db;

-- ============================================================================
-- 1.CREATING CUSTOMERS TABLE
-- ============================================================================
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    country VARCHAR(50),
    state VARCHAR(50),
    city VARCHAR(50),
    zip_code VARCHAR(10),
    registration_date DATE NOT NULL,
    customer_type ENUM('Individual', 'Corporate') NOT NULL,
    credit_limit DECIMAL(12,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_country (country),
    INDEX idx_registration (registration_date)
);

-- Insert sample customer data
INSERT INTO customers (customer_name, email, phone, country, state, city, zip_code, registration_date, customer_type, credit_limit) VALUES
('John Smith', 'john.smith@email.com', '555-0101', 'USA', 'New York', 'New York', '10001', '2022-01-15', 'Individual', 50000),
('Sarah Johnson', 'sarah.j@email.com', '555-0102', 'USA', 'California', 'Los Angeles', '90001', '2022-02-20', 'Individual', 75000),
('ABC Corporation', 'contact@abc.com', '555-0103', 'USA', 'Texas', 'Houston', '77001', '2021-06-10', 'Corporate', 500000),
('Mike Davis', 'mike.d@email.com', '555-0104', 'USA', 'Florida', 'Miami', '33101', '2022-03-05', 'Individual', 45000),
('XYZ Industries', 'orders@xyz.com', '555-0105', 'Canada', 'Ontario', 'Toronto', 'M5H', '2021-11-30', 'Corporate', 750000),
('Emma Wilson', 'emma.w@email.com', '555-0106', 'USA', 'New York', 'Buffalo', '14202', '2023-01-10', 'Individual', 35000),
('Global Tech Ltd', 'sales@globaltech.com', '555-0107', 'UK', 'England', 'London', 'EC1A', '2020-05-15', 'Corporate', 1000000),
('Robert Brown', 'rb@email.com', '555-0108', 'USA', 'Illinois', 'Chicago', '60601', '2023-02-14', 'Individual', 55000),
('Linda Martinez', 'lm@email.com', '555-0109', 'USA', 'Texas', 'Austin', '78701', '2023-03-20', 'Individual', 40000),
('International Ventures', 'intl@ventures.com', '555-0110', 'Australia', 'NSW', 'Sydney', '2000', '2020-08-22', 'Corporate', 650000);

-- ============================================================================
-- 2. PRODUCTS TABLE
-- ============================================================================
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(50) NOT NULL,
    subcategory VARCHAR(50),
    supplier_id INT,
    cost_price DECIMAL(10,2) NOT NULL,
    list_price DECIMAL(10,2) NOT NULL,
    discount_percent DECIMAL(5,2) DEFAULT 0,
    reorder_level INT DEFAULT 10,
    stock_quantity INT DEFAULT 0,
    weight_kg DECIMAL(8,3),
    is_discontinued BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_category (category),
    INDEX idx_supplier (supplier_id),
    INDEX idx_price (list_price)
);

-- Insert sample product data
INSERT INTO products (product_name, category, subcategory, supplier_id, cost_price, list_price, discount_percent, reorder_level, stock_quantity) VALUES
('Laptop Pro 15', 'Electronics', 'Computers', 1, 600, 1299, 5, 5, 45),
('Wireless Mouse', 'Electronics', 'Accessories', 1, 15, 49.99, 10, 50, 200),
('USB-C Hub', 'Electronics', 'Accessories', 1, 20, 79.99, 5, 30, 150),
('Monitor 27 Inch 4K', 'Electronics', 'Monitors', 2, 250, 599.99, 8, 10, 32),
('Mechanical Keyboard', 'Electronics', 'Accessories', 1, 60, 149.99, 12, 25, 85),
('Office Chair Executive', 'Furniture', 'Seating', 3, 150, 449.99, 10, 8, 28),
('Standing Desk', 'Furniture', 'Desks', 3, 200, 599.99, 15, 6, 18),
('Desk Lamp LED', 'Furniture', 'Lighting', 3, 25, 89.99, 5, 40, 120),
('Monitor Stand', 'Furniture', 'Accessories', 2, 35, 119.99, 0, 20, 75),
('Phone Stand', 'Electronics', 'Accessories', 1, 8, 24.99, 20, 100, 300),
('Webcam 1080P', 'Electronics', 'Accessories', 2, 30, 99.99, 10, 30, 95),
('Portable SSD 1TB', 'Electronics', 'Storage', 1, 70, 199.99, 5, 15, 42),
('Desk Organizer', 'Furniture', 'Accessories', 3, 12, 39.99, 0, 50, 180),
('Blue Light Glasses', 'Electronics', 'Accessories', 4, 10, 59.99, 25, 60, 220),
('Notebook Set', 'Stationery', 'Paper', 4, 3, 14.99, 10, 100, 500);

-- ============================================================================
-- 3. SALES REPRESENTATIVES TABLE
-- ============================================================================
CREATE TABLE sales_reps (
    rep_id INT PRIMARY KEY AUTO_INCREMENT,
    rep_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    department VARCHAR(50),
    region VARCHAR(50),
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2),
    commission_rate DECIMAL(5,2) DEFAULT 5,
    manager_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_region (region),
    INDEX idx_manager (manager_id)
);

-- Insert sales representative data
INSERT INTO sales_reps (rep_name, email, phone, department, region, hire_date, salary, commission_rate, manager_id) VALUES
('Alice Johnson', 'alice.johnson@company.com', '555-2001', 'Sales', 'North', '2020-01-10', 50000, 5, NULL),
('Bob Wilson', 'bob.wilson@company.com', '555-2002', 'Sales', 'South', '2020-06-15', 48000, 5, 1),
('Carol Martinez', 'carol.m@company.com', '555-2003', 'Sales', 'East', '2021-03-20', 52000, 6, 1),
('David Lee', 'david.lee@company.com', '555-2004', 'Sales', 'West', '2021-09-01', 51000, 5.5, 1),
('Eve Brown', 'eve.brown@company.com', '555-2005', 'Sales', 'North', '2022-02-14', 46000, 5, 1),
('Frank Garcia', 'frank.g@company.com', '555-2006', 'Sales', 'South', '2022-07-22', 47000, 5.5, 2),
('Grace Lee', 'grace.lee@company.com', '555-2007', 'Sales', 'East', '2023-01-10', 49000, 6, 3),
('Henry Chen', 'henry.c@company.com', '555-2008', 'Sales', 'West', '2023-04-01', 45000, 5, 4);

-- ============================================================================
-- 4. SALES ORDERS TABLE
-- ============================================================================
CREATE TABLE sales_orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    rep_id INT NOT NULL,
    order_date DATE NOT NULL,
    ship_date DATE,
    required_date DATE,
    order_status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    shipping_cost DECIMAL(10,2),
    total_amount DECIMAL(12,2),
    discount_amount DECIMAL(12,2) DEFAULT 0,
    net_amount DECIMAL(12,2),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (rep_id) REFERENCES sales_reps(rep_id),
    INDEX idx_customer (customer_id),
    INDEX idx_rep (rep_id),
    INDEX idx_order_date (order_date),
    INDEX idx_status (order_status)
);

-- Insert sales order data
INSERT INTO sales_orders (customer_id, rep_id, order_date, ship_date, required_date, order_status, shipping_cost, total_amount, discount_amount, net_amount) VALUES
(1, 1, '2023-01-15', '2023-01-18', '2023-01-20', 'Delivered', 25, 2699.00, 135, 2589.00),
(2, 2, '2023-01-20', '2023-01-22', '2023-01-25', 'Delivered', 35, 1499.99, 150, 1384.99),
(3, 3, '2023-02-05', '2023-02-07', '2023-02-10', 'Delivered', 50, 8999.95, 1500, 7549.95),
(4, 4, '2023-02-10', '2023-02-12', '2023-02-15', 'Delivered', 20, 599.99, 48, 571.99),
(5, 1, '2023-02-20', '2023-02-22', '2023-02-28', 'Delivered', 100, 24999.80, 2500, 22499.80),
(1, 2, '2023-03-05', '2023-03-07', '2023-03-10', 'Delivered', 30, 3599.97, 360, 3239.97),
(6, 3, '2023-03-15', '2023-03-17', '2023-03-20', 'Delivered', 25, 1199.98, 120, 1079.98),
(7, 4, '2023-03-20', '2023-03-22', '2023-03-25', 'Shipped', 45, 15999.85, 1600, 14399.85),
(2, 5, '2023-04-01', '2023-04-03', '2023-04-08', 'Delivered', 35, 2999.97, 300, 2699.97),
(8, 1, '2023-04-10', '2023-04-12', '2023-04-15', 'Delivered', 25, 899.98, 90, 809.98),
(9, 2, '2023-04-20', '2023-04-22', '2023-04-27', 'Processing', 40, 1999.96, 200, 1799.96),
(4, 3, '2023-05-01', '2023-05-03', '2023-05-08', 'Delivered', 30, 4999.95, 500, 4499.95),
(10, 4, '2023-05-10', '2023-05-12', '2023-05-20', 'Shipped', 75, 31999.80, 3200, 28799.80),
(3, 5, '2023-05-15', '2023-05-17', '2023-05-22', 'Delivered', 60, 19999.85, 2000, 17999.85),
(5, 1, '2023-06-01', '2023-06-03', '2023-06-10', 'Shipped', 100, 35999.70, 3600, 32399.70),
(1, 6, '2023-06-10', '2023-06-12', '2023-06-18', 'Delivered', 35, 2399.97, 240, 2159.97),
(2, 7, '2023-06-20', '2023-06-22', '2023-06-28', 'Delivered', 40, 3199.96, 320, 2879.96),
(6, 8, '2023-07-01', '2023-07-03', '2023-07-08', 'Processing', 30, 1699.98, 170, 1529.98),
(7, 1, '2023-07-15', '2023-07-17', '2023-07-23', 'Shipped', 50, 9999.99, 1000, 8999.99),
(4, 2, '2023-08-01', '2023-08-03', '2023-08-10', 'Delivered', 45, 6999.94, 700, 6299.94),
(8, 3, '2023-08-10', NULL, '2023-08-20', 'Pending', 25, 1299.99, 130, 1169.99),
(9, 4, '2023-08-20', NULL, '2023-08-28', 'Pending', 35, 2999.97, 300, 2699.97),
(10, 5, '2023-09-01', '2023-09-03', '2023-09-10', 'Delivered', 80, 45999.60, 4600, 41399.60),
(3, 6, '2023-09-15', '2023-09-17', '2023-09-23', 'Shipped', 60, 24999.80, 2500, 22499.80),
(1, 7, '2023-10-01', '2023-10-03', '2023-10-10', 'Delivered', 35, 3999.96, 400, 3599.96);

-- ============================================================================
-- 5. ORDER DETAILS TABLE
-- ============================================================================
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discount_percent DECIMAL(5,2) DEFAULT 0,
    line_amount DECIMAL(12,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES sales_orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    INDEX idx_order (order_id),
    INDEX idx_product (product_id)
);

-- Insert order details
INSERT INTO order_details (order_id, product_id, quantity, unit_price, discount_percent, line_amount) VALUES
(1, 1, 2, 1299, 5, 2470.10),
(1, 5, 1, 149.99, 12, 131.99),
(2, 4, 1, 599.99, 8, 551.99),
(2, 11, 1, 99.99, 10, 89.99),
(3, 1, 5, 1299, 5, 6169.25),
(3, 6, 3, 449.99, 10, 1214.97),
(3, 7, 2, 599.99, 15, 1019.98),
(4, 2, 8, 49.99, 10, 359.92),
(5, 1, 10, 1299, 5, 12340.50),
(5, 6, 5, 449.99, 10, 2024.95),
(5, 12, 5, 199.99, 5, 949.95),
(6, 4, 3, 599.99, 8, 1655.97),
(6, 8, 2, 89.99, 5, 170.98),
(6, 3, 1, 79.99, 5, 75.99),
(7, 2, 10, 49.99, 10, 449.91),
(7, 5, 5, 149.99, 12, 659.96),
(8, 1, 8, 1299, 5, 9872.40),
(8, 4, 2, 599.99, 8, 1103.98),
(8, 6, 3, 449.99, 10, 1214.97),
(9, 11, 15, 99.99, 10, 1349.85),
(9, 2, 5, 49.99, 10, 224.95),
(9, 3, 8, 79.99, 5, 607.92),
(10, 12, 3, 199.99, 5, 569.97),
(10, 14, 5, 59.99, 25, 224.96),
(11, 5, 8, 149.99, 12, 1055.93),
(11, 8, 10, 89.99, 5, 854.90),
(12, 1, 3, 1299, 5, 3708.15),
(12, 4, 2, 599.99, 8, 1103.98),
(12, 11, 5, 99.99, 10, 449.95),
(13, 1, 15, 1299, 5, 18488.25),
(13, 6, 8, 449.99, 10, 3239.92),
(13, 7, 5, 599.99, 15, 2549.96),
(14, 4, 10, 599.99, 8, 5519.92),
(14, 12, 8, 199.99, 5, 1519.92),
(15, 1, 20, 1299, 5, 24681.00),
(15, 6, 15, 449.99, 10, 6074.85),
(16, 2, 20, 49.99, 10, 899.82),
(16, 5, 10, 149.99, 12, 1319.92),
(17, 11, 12, 99.99, 10, 1079.89),
(17, 3, 15, 79.99, 5, 1139.85),
(18, 8, 8, 89.99, 5, 683.92),
(18, 14, 10, 59.99, 25, 449.93),
(19, 1, 5, 1299, 5, 6176.25),
(19, 4, 4, 599.99, 8, 2207.96),
(20, 12, 10, 199.99, 5, 1899.90),
(20, 2, 20, 49.99, 10, 899.82),
(21, 5, 3, 149.99, 12, 395.97),
(21, 15, 20, 14.99, 10, 269.82),
(22, 1, 2, 1299, 5, 2470.10),
(22, 6, 1, 449.99, 10, 404.99),
(23, 4, 20, 599.99, 8, 11039.82),
(23, 11, 15, 99.99, 10, 1349.85),
(23, 12, 10, 199.99, 5, 1899.90),
(24, 1, 12, 1299, 5, 14785.80),
(24, 6, 8, 449.99, 10, 3239.92),
(24, 7, 5, 599.99, 15, 2549.96),
(25, 2, 25, 49.99, 10, 1124.77),
(25, 5, 15, 149.99, 12, 1979.88);

-- ============================================================================
-- 6. PAYMENTS TABLE
-- ============================================================================
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    payment_date DATE NOT NULL,
    payment_method ENUM('Credit Card', 'Bank Transfer', 'Check', 'Cash') NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    reference_number VARCHAR(50),
    payment_status ENUM('Pending', 'Processed', 'Failed', 'Refunded') DEFAULT 'Processed',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES sales_orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    INDEX idx_customer (customer_id),
    INDEX idx_payment_date (payment_date),
    INDEX idx_status (payment_status)
);

-- Insert payment data
INSERT INTO payments (order_id, customer_id, payment_date, payment_method, amount, reference_number, payment_status) VALUES
(1, 1, '2023-01-20', 'Credit Card', 2589.00, 'REF001', 'Processed'),
(2, 2, '2023-01-25', 'Bank Transfer', 1384.99, 'REF002', 'Processed'),
(3, 3, '2023-02-10', 'Bank Transfer', 7549.95, 'REF003', 'Processed'),
(4, 4, '2023-02-15', 'Credit Card', 571.99, 'REF004', 'Processed'),
(5, 5, '2023-02-28', 'Bank Transfer', 22499.80, 'REF005', 'Processed'),
(6, 1, '2023-03-10', 'Credit Card', 3239.97, 'REF006', 'Processed'),
(7, 6, '2023-03-20', 'Credit Card', 1079.98, 'REF007', 'Processed'),
(8, 7, '2023-03-25', 'Bank Transfer', 14399.85, 'REF008', 'Processed'),
(9, 2, '2023-04-08', 'Credit Card', 2699.97, 'REF009', 'Processed'),
(10, 8, '2023-04-15', 'Check', 809.98, 'REF010', 'Processed'),
(11, 9, '2023-04-27', 'Credit Card', 1799.96, 'REF011', 'Pending'),
(12, 4, '2023-05-08', 'Bank Transfer', 4499.95, 'REF012', 'Processed'),
(13, 10, '2023-05-20', 'Bank Transfer', 28799.80, 'REF013', 'Processed'),
(14, 3, '2023-05-22', 'Credit Card', 17999.85, 'REF014', 'Processed'),
(15, 5, '2023-06-10', 'Bank Transfer', 32399.70, 'REF015', 'Processed'),
(16, 1, '2023-06-18', 'Credit Card', 2159.97, 'REF016', 'Processed'),
(17, 2, '2023-06-28', 'Credit Card', 2879.96, 'REF017', 'Processed'),
(18, 6, '2023-07-08', 'Check', 1529.98, 'REF018', 'Pending'),
(19, 7, '2023-07-23', 'Bank Transfer', 8999.99, 'REF019', 'Processed'),
(20, 4, '2023-08-10', 'Credit Card', 6299.94, 'REF020', 'Processed');

-- ============================================================================
-- 7. INVENTORY TABLE
-- ============================================================================
CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL UNIQUE,
    warehouse_location VARCHAR(50),
    last_restock_date DATE,
    restock_quantity INT,
    min_stock_level INT DEFAULT 5,
    max_stock_level INT DEFAULT 500,
    adjustment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    INDEX idx_product (product_id)
);

-- Insert inventory data
INSERT INTO inventory (product_id, warehouse_location, last_restock_date, restock_quantity, min_stock_level, max_stock_level) VALUES
(1, 'A-01', '2023-09-20', 50, 5, 100),
(2, 'B-05', '2023-09-18', 200, 30, 500),
(3, 'B-06', '2023-09-19', 150, 20, 400),
(4, 'A-02', '2023-09-17', 30, 5, 80),
(5, 'B-03', '2023-09-20', 90, 15, 200),
(6, 'C-01', '2023-09-15', 30, 5, 80),
(7, 'C-02', '2023-09-18', 20, 3, 60),
(8, 'C-03', '2023-09-16', 120, 30, 300),
(9, 'A-03', '2023-09-19', 75, 15, 200),
(10, 'B-07', '2023-09-20', 300, 50, 800),
(11, 'B-08', '2023-09-17', 100, 20, 300),
(12, 'A-04', '2023-09-19', 45, 10, 150),
(13, 'C-04', '2023-09-18', 180, 40, 500),
(14, 'B-09', '2023-09-20', 220, 50, 600),
(15, 'C-05', '2023-09-16', 500, 100, 1000);

-- ============================================================================
-- Create Indexes for Better Performance
-- ============================================================================
CREATE INDEX idx_order_total ON sales_orders(total_amount);
CREATE INDEX idx_payment_amount ON payments(amount);
CREATE INDEX idx_product_price ON products(list_price);
CREATE INDEX idx_order_date_range ON sales_orders(order_date, order_status);

-- ============================================================================
-- Display the count of rows message
-- ============================================================================
SELECT COUNT(*) as customers FROM customers;
SELECT COUNT(*) as products FROM products;
SELECT COUNT(*) as orders FROM sales_orders;
SELECT COUNT(*) as order_details FROM order_details;
SELECT COUNT(*) as payments FROM payments;
-- ============================================================================
-- Display All Data from Tables
-- ============================================================================
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM inventory;
SELECT * FROM order_details;
SELECT * FROM payments;
SELECT * FROM sales_orders;
SELECT * FROM sales_reps;

use sales_db;

-- Revenue Breakdown by Customer Type and Region

SELECT c.customer_type,sr.region,round(sum(so.net_amount),2) as total_revenue,round(avg(so.net_amount),2) as avg_ordervalue,
count(distinct order_id) as num_of_order from customers c
join sales_orders so on c.customer_id=so.customer_id
join sales_reps sr on so.rep_id=sr.rep_id
group by c.customer_type,sr.region
order by total_revenue desc;

-- Product Performance Analysis
-- Identify products that generated revenue > $5000 and list:
-- product name, category, total quantity sold, total revenue, profit margin
-- Order by profit margin descending

select p.product_name,p.category,sum(o.quantity) as 'total quantity sold',round(sum(o.line_amount)) as total_revenue,
round(((sum(o.line_amount)-sum(o.quantity * p.cost_price))/sum(o.line_amount))*100,2) as profit_margin from products p
join order_details o on p.product_id=o.product_id
group by p.product_name,p.category
having total_revenue> 5000
order by profit_margin desc;

-- Sales Rep Performance Ranking
-- Create a ranked list of sales representatives showing:
-- rep name, total orders, total revenue, average order value, rank by revenue
-- Also show manager name for each rep


SELECT sr.rep_name,
count(so.order_id) as total_orders,
sum(so.net_amount) as total_revenue,
round(avg(so.net_amount),2) as avg_order,
coalesce(m.rep_name,'No Manager') as manager_name,
rank() OVER (ORDER BY SUM(net_amount) DESC) as revenue_rank from sales_reps sr
join sales_orders so on sr.rep_id=so.rep_id
left join sales_reps m on sr.manager_id=m.rep_id
group by sr.rep_name,m.rep_name
ORDER BY revenue_rank;

-- Customer Lifetime Value (CLV) Analysis
-- Calculate customer lifetime value including:
-- customer name, customer type, total spending, order count,
-- days as customer, average days between orders
-- Only include customers with 3+ orders
WITH customer_orders AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        c.customer_type,
        c.registration_date,
        so.order_date,
        so.net_amount,
        COUNT(so.order_id) OVER (PARTITION BY c.customer_id) as total_orders,
        LAG(so.order_date) OVER (PARTITION BY c.customer_id ORDER BY so.order_date) as prev_order_date
    FROM customers c
    LEFT JOIN sales_orders so ON c.customer_id = so.customer_id
)
SELECT 
    customer_name,
    customer_type,
    ROUND(SUM(COALESCE(net_amount, 0)), 2) as lifetime_value,
    MAX(total_orders) as order_count,
    DATEDIFF(MAX(order_date), MIN(registration_date)) as days_as_customer,
    ROUND(AVG(DATEDIFF(order_date, prev_order_date)), 0) as avg_days_between_orders
FROM customer_orders
GROUP BY customer_id, customer_name, customer_type, registration_date
HAVING MAX(total_orders) >= 3
ORDER BY lifetime_value DESC;

-- Month-over-Month Revenue Growth
-- Show revenue for each month, previous month revenue, growth amount and percentage
-- Use CTE to organize the data

with monthly_revenue as 
(
select date_format(order_date,'%y-%m') as month,
round(sum(net_amount),2) as monthly_revenue 
from sales_orders where order_status in ('Delivered','Shipped')
group by date_format(order_date,'%y-%m')
)
select month , monthly_revenue as revenue,
lag(monthly_revenue) over (order by month) as prev_month_revenue,
ROUND(monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY month), 2) as growth_amount,
ROUND(((monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY month)) / LAG(monthly_revenue) OVER (ORDER BY month) * 100), 2) as growth_percent
from monthly_revenue
order by month;

-- Customer Segmentation by Purchase Pattern
-- Segment customers into categories based on:
-- - High Value: Customer Lifetime Value > $30,000
-- - Medium Value: Customer Lifetime Value between $10,000 and $30,000
-- - Low Value: CLV < $10,000
-- Show segment, count of customers, total revenue, average customer value

WITH customer_spending AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        ROUND(SUM(COALESCE(so.net_amount, 0)), 2) as customer_lifetime_value
    FROM customers c
    LEFT JOIN sales_orders so ON c.customer_id = so.customer_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT 
    CASE 
        WHEN customer_lifetime_value > 30000 THEN 'High Value'
        WHEN customer_lifetime_value BETWEEN 10000 AND 30000 THEN 'Medium Value'
        ELSE 'Low Value'
    END as segment,
    COUNT(*) as customer_count,
    ROUND(SUM(customer_lifetime_value), 2) as total_segment_revenue,
    ROUND(AVG(customer_lifetime_value), 2) as avg_customer_value
FROM customer_spending
GROUP BY segment
ORDER BY total_segment_revenue DESC;

-- Product Cross-Sell Analysis
-- Find which products are frequently bought together
-- Show product pairs and their co-occurrence count
-- Only show pairs where frequency > 1

SELECT 
    p1.product_name as product1,
    p2.product_name as product2,
    COUNT(DISTINCT od1.order_id) as frequency_together,
    ROUND(SUM(od1.line_amount + od2.line_amount), 2) as combined_revenue
FROM order_details od1
JOIN order_details od2 ON od1.order_id = od2.order_id 
    AND od1.product_id < od2.product_id
JOIN products p1 ON od1.product_id = p1.product_id
JOIN products p2 ON od2.product_id = p2.product_id
GROUP BY od1.product_id, od2.product_id, p1.product_name, p2.product_name
HAVING COUNT(DISTINCT od1.order_id) > 1
ORDER BY frequency_together DESC;
