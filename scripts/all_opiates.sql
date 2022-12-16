use opiate
-- per 100 scripts compare USA vs TN
with count as
( SELECT 
	Year, 
    SUM(Value) as total_opioids
	from scripts
where  Indicator = 'All Opioids for Pain' 
	AND ValueType = "Count" And GeographyType = "State"
    GROUP BY Year), 
  year as   
   (SELECT
   year, 
   SUM(total_pop) as pop 
   FROM pop_inc
   WHERE year >= 2017
   group by year), 
  TN_100 as (SELECT
   c.*,
   y.pop,
   ROUND(c.total_opioids/y.pop *100,2) as TN_per_100
   FROM count as c
   left join year as y
   on c.year=y.year)
SELECT
u.year, 
u.rate_per_100 as USA, 
t.TN_per_100 as TN
FROM usa_rateper100_opiates as u
LEFT JOIN TN_100 as t
on u.year=t.year
WHERE u.year >= 2017
GROUP BY u.year
        
       