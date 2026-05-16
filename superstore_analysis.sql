CREATE DATABASE superstore;
USE superstore;
SHOW TABLES;
SELECT * FROM `sample - superstore` LIMIT 10;
SELECT 
  Category,
  ROUND(SUM(Sales), 2) AS total_sales,
  COUNT(*) AS total_orders
FROM `sample - superstore`
GROUP BY Category
ORDER BY total_sales DESC;

SELECT 
  Region,
  ROUND(SUM(Sales), 2) AS total_sales,
  ROUND(SUM(Profit), 2) AS total_profit,
  COUNT(*) AS total_orders
FROM `sample - superstore`
GROUP BY Region
ORDER BY total_sales DESC;

SELECT 
  DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%Y-%m') AS month,
  ROUND(SUM(Sales), 2) AS monthly_sales,
  ROUND(SUM(Profit), 2) AS monthly_profit
FROM `sample - superstore`
GROUP BY month
ORDER BY month;

SELECT 
  CASE 
    WHEN Discount = 0 THEN 'No Discount'
    WHEN Discount <= 0.2 THEN 'Low (0-20%)'
    WHEN Discount <= 0.4 THEN 'Medium (21-40%)'
    ELSE 'High (40%+)'
  END AS discount_bucket,
  COUNT(*) AS total_orders,
  ROUND(SUM(Sales), 2) AS total_sales,
  ROUND(SUM(Profit), 2) AS total_profit,
  ROUND(AVG(Profit), 2) AS avg_profit
FROM `sample - superstore`
GROUP BY discount_bucket
ORDER BY total_profit DESC;

SELECT 
  `Customer Name`,
  COUNT(*) AS total_orders,
  ROUND(SUM(Sales), 2) AS total_sales,
  ROUND(SUM(Profit), 2) AS total_profit
FROM `sample - superstore`
GROUP BY `Customer Name`
ORDER BY total_profit DESC
LIMIT 10;

SELECT 
  `Sub-Category`,
  ROUND(SUM(Sales), 2) AS total_sales,
  ROUND(SUM(Profit), 2) AS total_profit,
  ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS profit_margin_pct
FROM `sample - superstore`
GROUP BY `Sub-Category`
ORDER BY total_profit DESC;

SELECT 
  DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%Y-%m') AS month,
  ROUND(SUM(Sales), 2) AS monthly_sales,
  ROUND(SUM(SUM(Sales)) OVER (
    ORDER BY DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%Y-%m')
  ), 2) AS running_total
FROM `sample - superstore`
GROUP BY month
ORDER BY month;

SELECT 
  State,
  ROUND(SUM(Sales), 2) AS total_sales,
  ROUND(SUM(Profit), 2) AS total_profit,
  RANK() OVER (ORDER BY SUM(Sales) DESC) AS sales_rank
FROM `sample - superstore`
GROUP BY State
ORDER BY sales_rank;