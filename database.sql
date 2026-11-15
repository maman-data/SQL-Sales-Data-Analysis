-- =====================================
-- PROJECT 03: SALES ANALYSIS
-- Database: projek_03_sales
-- Author: SQL Data Analyst Portfolio
-- =====================================

-- 1. JOIN TABLES

SELECT
    orders.order_id,
    orders.order_date,
    customers.customer_name,
    products.product_name,
    order_details.quantity,
    order_details.unit_price,
    order_details.subtotal
FROM order_details
JOIN orders
    ON order_details.order_id = orders.order_id
JOIN customers
    ON orders.customer_id = customers.customer_id
JOIN products
    ON order_details.product_id = products.product_id;

-- 2. TOTAL SALES

SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM orders;

-- 3. TOTAL ORDERS

SELECT COUNT(*) AS total_order
FROM order_details;

-- 4. TOTAL PRODUCT SOLD

SELECT
    SUM(quantity) AS total_product_sold
FROM order_details;

-- 5. AVERAGE PRODUCT PRICE
SELECT AVG(price) AS average 
	FROM products;

-- 6. BEST SELLING PRODUCTS

SELECT
    products.product_name,
    SUM(order_details.quantity) AS total_sold
FROM order_details
JOIN products
    ON order_details.product_id = products.product_id
GROUP BY products.product_name
ORDER BY total_sold DESC;

-- 7. TOTAL REVENUE ANALYSIS

SELECT
    products.product_name,
    SUM(order_details.subtotal) AS total_revenue
FROM order_details
JOIN products
    ON order_details.product_id = products.product_id
GROUP BY products.product_name
ORDER BY total_revenue DESC;

-- 8. CATEGORY ANALYSIS

SELECT
    products.category,
    SUM(order_details.quantity) AS total_sold,
    SUM(order_details.subtotal) AS total_revenue
FROM order_details
JOIN products
    ON order_details.product_id = products.product_id
GROUP BY products.category
ORDER BY total_revenue DESC;

-- 9. CUSTOMER ANALYSIS

SELECT
    customers.customer_name,
    COUNT(DISTINCT orders.order_id) AS total_orders,
    SUM(order_details.subtotal) AS total_spent
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id
JOIN order_details
    ON orders.order_id = order_details.order_id
GROUP BY customers.customer_name
ORDER BY total_spent DESC;

-- 10. DATE ANALYSIS

SELECT
    orders.order_date,
    COUNT(DISTINCT orders.order_id) AS total_orders,
    SUM(order_details.subtotal) AS total_revenue
FROM orders
JOIN order_details
    ON orders.order_id = order_details.order_id
GROUP BY orders.order_date
ORDER BY orders.order_date ASC;

-- 11. ORDER STATUS

SELECT
    status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY status
ORDER BY total_orders DESC;

-- 12. CUSTOMER SPENDING FILTER

SELECT
    customers.customer_name,
    SUM(order_details.subtotal) AS total_spent
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY customers.customer_name
HAVING total_spent > 1000000
ORDER BY total_spent DESC;

-- 13. FILTER ORDERS BY DATE

SELECT
    order_id,
    order_date,
    status
FROM orders
WHERE order_date BETWEEN '2026-11-02' AND '2026-11-04';


