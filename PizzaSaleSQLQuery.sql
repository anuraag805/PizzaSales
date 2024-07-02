SELECT * from dbo.pizza_sales

--Total Revenue
SELECT SUM(total_price) AS Total_Revenue from pizza_sales

--Average Order Value
SELECT SUM(total_price) / COUNT (DISTINCT order_id) AS Avg_Order_Value from pizza_sales

--Total Pizza Sold
SELECT SUM(quantity) AS Total_Quantity_Sold from pizza_sales 

--Total_Orders
SELECT COUNT(DISTINCT Order_id) AS Total_Orders from pizza_sales

--Average Pizza Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT Order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_Order FROM pizza_sales

--Daily Trend for Total Orders
SELECT DATENAME(DW, order_date) as order_day, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

--Monthly Trend for Total Order
SELECT DATENAME(MONTH, order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders desc

--Percentage of sales by pizza category
SELECT pizza_category, SUM(total_price) AS Total_Sales, SUM(total_price) * 100/
(SELECT SUM(total_price) from pizza_sales WHERE MONTH(order_date)=1) AS PCT
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category

--Percentage of Sales by pizza size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, CAST(SUM(total_price) * 100/
(SELECT SUM(total_price) from pizza_sales WHERE MONTH(order_date)=1) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size

--Total Pizzas Sold by pizza category
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, 
CAST(SUM(total_price)*100/(SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER, order_date)=1) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_size
ORDER BY PCT DESC

--Top 5 Best sellers by Revenue. Total Quantity and Total Orders
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_revenue DESC

--Bottom 5 Best sellers by Revenue. Total Quantity and Total Orders
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_revenue ASC

--Top 5 By Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Revenue 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_revenue DESC

--Bottom 5 By Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Revenue 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_revenue ASC

--Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC                             