SELECT * FROM road_accident_india.accidents;

-- Total no.of accident by severity
SELECT severity, count(*) as total_severity
from accidents
group by severity
order by total_severity asc;

-- Top 5 accident in location
SELECT location,count(*) as total_accident_count
from accidents
group by location
order by total_accident_count desc
limit 5;

-- Accident in highways with bad wheather
SELECT *
from accidents
where road_type="Highway" and weather_condition IN ('Snow','Fog');

-- find most dangereous weather for fatal accidents(fatal counts)
SELECT severity,weather_condition ,count(*) as fatal_count
from accidents
where severity='Fatal'
GROUP BY weather_condition
order by fatal_count desc;

-- Correlation: Drunk driving and fatal accidents
SELECT a.severity,
       count(*) as Total ,
       sum(case when is_drunk="Yes" then 1  else 0 end) as drunk_cases
from accidents a
inner join vehicles_involved v on v.accident_id=a.accident_id
where a.severity='Fatal'
group by a.severity;

-- Avg driver age on each severity type
SELECT a.severity,round(avg(v.driver_age)) as avg_driver_age
from accidents a
INNER JOIN vehicles_involved v on a.accident_id=v.accident_id
group by a.severity;

-- Top 5 accident-prone road types
SELECT road_type,count(*) road_type_count
from accidents
group by road_type
order by road_type_count desc;

-- find top 5 locations by drunk driving
SELECT a.location, COUNT(is_drunk) AS drunk_accidents
FROM Accidents a
JOIN Vehicles_Involved v ON a.accident_id = v.accident_id
WHERE v.is_drunk = 'Yes'
GROUP BY a.location
ORDER BY drunk_accidents DESC
LIMIT 5;