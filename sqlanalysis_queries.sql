CREATE DATABASE ecommerce;
USE ecommerce;
SELECT * FROM train LIMIT 5;
USE finance_db;
SHOW TABLES;
SELECT * FROM train LIMIT 5;ALTER TABLE train
ADD COLUMN order_date_clean DATE,
ADD COLUMN ship_date_clean DATE;

UPDATE train
SET order_date_clean = STR_TO_DATE(`Order Date`, '%d-%m-%Y'),
    ship_date_clean = STR_TO_DATE(`Ship Date`, '%d-%m-%Y');
# Total Revenue
SELECT ROUND(SUM(Sales), 2) AS total_revenue
FROM train;
# Sales by Region
SELECT Region, ROUND(SUM(Sales),2) AS total_sales
FROM train
GROUP BY Region
ORDER BY total_sales DESC;
# Sales by Category
SELECT Category, ROUND(SUM(Sales),2) AS total_sales
FROM train
GROUP BY Category
ORDER BY total_sales DESC;
# Top 5 Customers
SELECT `Customer Name`, ROUND(SUM(Sales),2) AS total_spent
FROM train
GROUP BY `Customer Name`
ORDER BY total_spent DESC
LIMIT 5;
# Top 10 Products
SELECT `Product Name`, ROUND(SUM(Sales),2) AS revenue
FROM train
GROUP BY `Product Name`
ORDER BY revenue DESC
LIMIT 10;
# Monthly Sales Trend
SELECT MONTH(STR_TO_DATE(`Order Date`, '%d/%m/%Y')) AS month,
       ROUND(SUM(Sales),2) AS total_sales
FROM train
GROUP BY month
ORDER BY month;
# Window Function
SELECT `Customer Name`,
       SUM(Sales) OVER(PARTITION BY `Customer Name`) AS total_spent
FROM train;
# Delivery Time
SELECT AVG(
    DATEDIFF(
        STR_TO_DATE(`Ship Date`, '%d/%m/%Y'),
        STR_TO_DATE(`Order Date`, '%d/%m/%Y')
    )
) AS avg_delivery_days
FROM train;
# Region Ranking
SELECT Region,
       SUM(Sales) AS total_sales,
       RANK() OVER (ORDER BY SUM(Sales) DESC) AS rank_position
FROM train
GROUP BY Region;
######## INSIGHTS #########
• West region contributes highest revenue
• Technology category dominates sales
• Top customers generate major revenue share
• Sales show monthly variation (seasonality)
• Average delivery time is ~4 days
