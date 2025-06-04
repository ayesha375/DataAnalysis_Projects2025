SELECT * FROM road_accident_india.vehicles_involved;

-- Vehicles involved in fatal accidents (by using inner join-Returns only matching rows from both tables)
SELECT v.*
FROM vehicles_involved v
INNER JOIN accidents a ON v.accident_id = a.accident_id
WHERE a.severity = 'Fatal';

-- Average driver age by vehicle_type
SELECT vehicle_type,round(avg(driver_age)) as avg_driver_age
from vehicles_involved
group by vehicle_type
order by avg_driver_age desc;

-- %ge of accidents involving drunk driving
SELECT 
  ROUND(100 * SUM(CASE WHEN is_drunk = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),2) AS drunk_driving_percentage
  FROM Vehicles_Involved;
  
  -- how many vehicles are evolved in each accident (vehicles count)
  SELECT accident_id,count(vehicle_id) as count_vehicle_id
  from vehicles_involved
  group by accident_id
  order by count_vehicle_id desc;
  
-- Accidents involving young drivers (<25) who were speeding
SELECT v.*, a.location, a.date
FROM vehicles_involved v
INNER JOIN accidents a ON v.accident_id = a.accident_id
WHERE v.driver_age < 25 AND v.is_speeding = 'Yes';

-- Drivers under 18 involved in accidents
SELECT *,
    case
    when driver_age<18 then 1 else 0 
    end as under_driver_age_18
from vehicles_involved;    