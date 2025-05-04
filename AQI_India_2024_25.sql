SELECT * FROM air_quality_data.india_aqi_2024_25;

-- AVGAQI in 2024_25
SELECT City, State, ROUND(AVG(AQI), 2) AS Avg_AQI 
FROM air_quality_data.india_aqi_2024_25
GROUP BY City, State
ORDER BY Avg_AQI DESC
LIMIT 5;

-- Monthly avg aqi of capacity
select State,DATE_FORMAT(Date,'%m-%y') AS month ,ROUND(AVG(AQI),2) AS avg_aqi
from air_quality_data.india_aqi_2024_25
group by State,month
order by State,month;

-- Highest no. of AQI in 2024
select City,State,count(*) as unhealthy_days
from air_quality_data.india_aqi_2024_25
where AQI>= 100 AND AQI<=200 AND YEAR(Date)=2024
group by City,State
order by unhealthy_days DESC
LIMIT 10;

-- find the date of AQI over the past 12 months
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Month, 
    ROUND(AVG(AQI), 2) AS Avg_AQI
FROM 
    air_quality_data.india_aqi_2024_25
WHERE 
    City = 'Delhi'
GROUP BY 
    DATE_FORMAT(Date, '%Y-%m')
ORDER BY 
    DATE_FORMAT(Date, '%Y-%m');

-- cities with max daily PM10
USE air_quality_data;

SELECT City, Date, PM10
 FROM air_quality_data.india_aqi_2024_25
WHERE PM10 = (
    SELECT MAX(PM10) FROM india_aqi_2024_25
)
LIMIT 1000;

-- Most recent AQI reporter cities
SELECT City, MAX(Date) AS Latest_Report_Date
FROM air_quality_data.india_aqi_2024_25
GROUP BY City;




