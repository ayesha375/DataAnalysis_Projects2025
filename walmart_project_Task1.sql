use final_project_walmart_sales_analysis;
select * from walmartsalesdata;
SELECT Branch, 
       MONTH(Date) AS month, 
       SUM(Total) AS total_sales,
       (SUM(Total) - LAG(SUM(Total)) OVER (PARTITION BY Branch ORDER BY MONTH(Date))) / 
       LAG(SUM(Total)) OVER (PARTITION BY Branch ORDER BY MONTH(Date)) * 100 AS growth_rate
FROM walmartsalesdata
GROUP BY Branch, MONTH(Date)
ORDER BY growth_rate DESC;
