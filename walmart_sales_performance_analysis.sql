SELECT * FROM internsala_final_project.walmartsalesdata;


## task1: Identifying the Top Branch by Sales Growth Rate 
SELECT Branch, 
       MONTH(Date) AS month, 
       SUM(Total) AS total_sales,
       (SUM(Total) - LAG(SUM(Total)) OVER (PARTITION BY Branch ORDER BY MONTH(Date))) / 
       LAG(SUM(Total)) OVER (PARTITION BY Branch ORDER BY MONTH(Date)) * 100 AS growth_rate
FROM internsala_final_project.walmartsalesdata
GROUP BY Branch, MONTH(Date)
ORDER BY growth_rate DESC;

## task2:Finding the Most Profitable Product Line for Each Branch 
SELECT Branch, 
       Product_line, 
       SUM('gross_income' - cogs) AS profit
FROM internsala_final_project.walmartsalesdata
GROUP BY Branch, Product_line
ORDER BY Branch,profit DESC;

## task3: Analyzing Customer Segmentation Based on Spending
SELECT Customer_type, Gender, SUM(Total) AS Total_Spent,
   CASE
     WHEN SUM(Total) >= 800 THEN 'high spender'
     WHEN SUM(Total) BETWEEN 500 AND 799 THEN 'medium spender'
     ELSE 'low spender'
   END AS spending_3tier
FROM internsala_final_project.walmartsalesdata
GROUP BY Customer_type, Gender
LIMIT 0, 1000;

## task4:Detecting Anomalies in Sales Transactions 
WITH product_line_avg AS (
     SELECT Product_line, AVG(Total) AS avg_sales
     FROM internsala_final_project.walmartsalesdata
     GROUP BY Product_line
)
SELECT w.*, P.avg_sales
FROM internsala_final_project.walmartsalesdata w
INNER JOIN product_line_avg P
  ON w.Product_line = P.Product_line
WHERE ABS(w.Total - P.avg_sales) > 2 * P.avg_sales;

## task5: Most Popular Payment Method by City
select city, payment, count(payment) as payment_count
from internsala_final_project.walmartsalesdata
group by city, payment
order by payment_count desc;

## task 6: Monthly Sales Distribution by Gender 
SELECT Gender, Month(Date) as Month, SUM(Total) AS total_sales
from internsala_final_project.walmartsalesdata
GROUP BY Gender, MONTH(Date)
ORDER BY Month, total_sales DESC;

## task7:Best Product Line by Customer Type 
select Customer_type, Product_line, sum(Total) as Total_sales
from internsala_final_project.walmartsalesdata
group by Customer_type, Product_line
order by Customer_type,Total_sales desc;

## task8: Identifying Repeat Customers 
WITH repeat_customers as(
   select Invoice_ID , Customer_type, 
    Date,
    Lead(Date) over(partition by Customer_type, City order by Date) as next_purchase
    from internsala_final_project.walmartsalesdata
    )
select Invoice_ID, 
       Customer_type,
       Date, 
       next_purchase
from repeat_customers  
where DateDIFF(next_purchase, Date) <= 30;

## task9:Finding Top 5 Customers by Sales Volume 
WITH ranked_customers AS (
  SELECT 
    Customer_type, 
    Total,
    SUM(Total) OVER (PARTITION BY Customer_type ORDER BY SUM(Total) DESC) AS Total_sales,
    RANK() OVER (PARTITION BY Customer_type ORDER BY SUM(Total) DESC) AS Customer_rank
  FROM internsala_final_project.walmartsalesdata
  GROUP BY Customer_type, Product_line, Total
)
SELECT * 
FROM ranked_customers
WHERE Customer_rank <= 5;

## task10:Analyzing Sales Trends by Day of the Week 
WITH ranked_customers AS (
  SELECT 
    Customer_type, 
    Total,
    SUM(Total) OVER (PARTITION BY Customer_type ORDER BY SUM(Total) DESC) AS Total_sales,
    RANK() OVER (PARTITION BY Customer_type ORDER BY SUM(Total) DESC) AS Customer_rank
  FROM internsala_final_project.walmartsalesdata
  GROUP BY Customer_type, Product_line, Total
)
SELECT * 
FROM ranked_customers
WHERE Customer_rank <= 5;
