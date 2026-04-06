-- ============================================================
--  E-Commerce Sales Analysis — Core Business Queries
--  Author : [Your Name]
--  Updated: 2024
-- ============================================================

-- ────────────────────────────────────────────────────────────
-- Q1. Overall KPI Summary (Delivered orders only)
-- ────────────────────────────────────────────────────────────
SELECT
    COUNT(Order_ID)              AS Total_Orders,
    SUM(Revenue)                 AS Total_Revenue,
    SUM(Profit)                  AS Total_Profit,
    ROUND(AVG(Revenue), 2)       AS Avg_Order_Value,
    ROUND(AVG(Profit_Margin), 2) AS Avg_Profit_Margin_Pct,
    SUM(Quantity)                AS Total_Units_Sold
FROM orders
WHERE Order_Status = 'Delivered';


-- ────────────────────────────────────────────────────────────
-- Q2. Monthly Revenue & Profit Trend
-- ────────────────────────────────────────────────────────────
SELECT
    DATE_FORMAT(Order_Date, '%Y-%m')  AS Year_Month,   -- MySQL
    -- TO_CHAR(Order_Date, 'YYYY-MM') AS Year_Month,   -- PostgreSQL
    COUNT(Order_ID)                   AS Orders,
    SUM(Revenue)                      AS Monthly_Revenue,
    SUM(Profit)                       AS Monthly_Profit,
    ROUND(SUM(Profit)/SUM(Revenue)*100, 2) AS Margin_Pct
FROM orders
WHERE Order_Status = 'Delivered'
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY Year_Month;


-- ────────────────────────────────────────────────────────────
-- Q3. Revenue by Category (ranked)
-- ────────────────────────────────────────────────────────────
SELECT
    Category,
    COUNT(Order_ID)                       AS Orders,
    SUM(Revenue)                          AS Total_Revenue,
    SUM(Profit)                           AS Total_Profit,
    ROUND(AVG(Profit_Margin), 2)          AS Avg_Margin_Pct,
    RANK() OVER (ORDER BY SUM(Revenue) DESC) AS Revenue_Rank
FROM orders
WHERE Order_Status = 'Delivered'
GROUP BY Category
ORDER BY Total_Revenue DESC;


-- ────────────────────────────────────────────────────────────
-- Q4. Top 10 Best-Selling Products by Revenue
-- ────────────────────────────────────────────────────────────
SELECT
    Product,
    Category,
    SUM(Quantity)   AS Units_Sold,
    SUM(Revenue)    AS Total_Revenue,
    SUM(Profit)     AS Total_Profit,
    ROUND(AVG(Unit_Price), 2) AS Avg_Price
FROM orders
WHERE Order_Status = 'Delivered'
GROUP BY Product, Category
ORDER BY Total_Revenue DESC
LIMIT 10;


-- ────────────────────────────────────────────────────────────
-- Q5. Regional Performance Breakdown
-- ────────────────────────────────────────────────────────────
SELECT
    Region,
    COUNT(Order_ID)                          AS Orders,
    SUM(Revenue)                             AS Total_Revenue,
    SUM(Profit)                              AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Revenue)*100, 2)   AS Margin_Pct,
    ROUND(AVG(Revenue), 2)                   AS Avg_Order_Value,
    ROUND(SUM(Revenue) / (SELECT SUM(Revenue) FROM orders
                          WHERE Order_Status='Delivered') * 100, 2) AS Revenue_Share_Pct
FROM orders
WHERE Order_Status = 'Delivered'
GROUP BY Region
ORDER BY Total_Revenue DESC;


-- ────────────────────────────────────────────────────────────
-- Q6. Order Status Distribution
-- ────────────────────────────────────────────────────────────
SELECT
    Order_Status,
    COUNT(Order_ID)                             AS Orders,
    ROUND(COUNT(Order_ID) * 100.0 /
          (SELECT COUNT(*) FROM orders), 2)     AS Pct_of_Total,
    COALESCE(SUM(Revenue), 0)                   AS Revenue_Impact
FROM orders
GROUP BY Order_Status
ORDER BY Orders DESC;


-- ────────────────────────────────────────────────────────────
-- Q7. Shipping Method Analysis
-- ────────────────────────────────────────────────────────────
SELECT
    Shipping_Method,
    COUNT(Order_ID)               AS Orders,
    ROUND(AVG(Revenue), 2)        AS Avg_Revenue,
    SUM(Revenue)                  AS Total_Revenue,
    ROUND(AVG(
        DATEDIFF(Ship_Date, Order_Date)  -- MySQL
        -- Ship_Date - Order_Date        -- PostgreSQL
    ), 1)                         AS Avg_Ship_Days
FROM orders
WHERE Order_Status = 'Delivered'
GROUP BY Shipping_Method
ORDER BY Total_Revenue DESC;


-- ────────────────────────────────────────────────────────────
-- Q8. Customer Segmentation by Spend (RFM-lite)
-- ────────────────────────────────────────────────────────────
SELECT
    Customer_ID,
    COUNT(DISTINCT Order_ID)       AS Total_Orders,
    SUM(Revenue)                   AS Total_Spend,
    ROUND(AVG(Revenue), 2)         AS Avg_Order_Value,
    MAX(Order_Date)                AS Last_Order_Date,
    CASE
        WHEN SUM(Revenue) >= 3000  THEN 'High Value'
        WHEN SUM(Revenue) >= 1000  THEN 'Mid Value'
        ELSE                            'Low Value'
    END                            AS Customer_Segment
FROM orders
WHERE Order_Status = 'Delivered'
GROUP BY Customer_ID
ORDER BY Total_Spend DESC
LIMIT 20;


-- ────────────────────────────────────────────────────────────
-- Q9. Discount Impact on Profit Margin
-- ────────────────────────────────────────────────────────────
SELECT
    CASE
        WHEN Discount = 0    THEN 'No Discount'
        WHEN Discount <= 0.10 THEN '1–10%'
        WHEN Discount <= 0.20 THEN '11–20%'
        ELSE '20%+'
    END                              AS Discount_Band,
    COUNT(Order_ID)                  AS Orders,
    ROUND(AVG(Profit_Margin), 2)     AS Avg_Margin_Pct,
    SUM(Revenue)                     AS Total_Revenue,
    SUM(Profit)                      AS Total_Profit
FROM orders
WHERE Order_Status = 'Delivered'
GROUP BY Discount_Band
ORDER BY Avg_Margin_Pct DESC;


-- ────────────────────────────────────────────────────────────
-- Q10. Year-over-Year Revenue Growth
-- ────────────────────────────────────────────────────────────
WITH yearly AS (
    SELECT
        YEAR(Order_Date)  AS yr,   -- MySQL; use EXTRACT(YEAR FROM ...) for PostgreSQL
        SUM(Revenue)      AS revenue
    FROM orders
    WHERE Order_Status = 'Delivered'
    GROUP BY YEAR(Order_Date)
)
SELECT
    yr                                              AS Year,
    revenue                                         AS Total_Revenue,
    LAG(revenue) OVER (ORDER BY yr)                 AS Prev_Year_Revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY yr))
        / LAG(revenue) OVER (ORDER BY yr) * 100, 2
    )                                               AS YoY_Growth_Pct
FROM yearly
ORDER BY yr;
