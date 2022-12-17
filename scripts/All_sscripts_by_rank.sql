use opiate
SELECT* from scripts

with count as( SELECT *
from scripts
where  Indicator like 'All_%' 
	AND ValueType = "Count"and GeographyType = "County")
select 
	c.year, 
    c.Geography, 
    c.Indicator, 
    c.Value, 
    p.total_pop,
    RANK() OVER(PARTITION BY Year, Indicator ORDER BY Value DESC) AS Rnk
    FROM count as c
    LEFT JOIN pop_inc as p 
    on c.year=p.year and c.Geography=p.County
    WHERE c.Indicator = 'All Benzodiazepines'
    
with count as( SELECT *
from scripts
where  Indicator like 'All_%' 
	AND ValueType = "Count"and GeographyType = "County")
select 
	c.year, 
    c.Geography, 
    c.Indicator, 
    c.Value, 
    p.total_pop,
    LAG(Value) OVER ( ORDER BY Year ) AS Drugs_Previous_Year,
       Value - LAG(Value) OVER ( ORDER BY Year ) AS YOY_Difference
	FROM count as c
    LEFT JOIN pop_inc as p 
    on c.year=p.year and c.Geography=p.County
    WHERE c.Indicator = 'All Benzodiazepines' and c.Geography = 'Davidson'



select * from 2010_2020_scripts
-- top 5 counties by year
with top5 as(SELECT 
county, 
year, 
opiates_per_100,
 RANK() OVER(PARTITION BY Year ORDER BY opiates_per_100 DESC) AS Rnk
 from 2010_2020_scripts)
 SELECT
 county, 
 year, 
 opiates_per_100, 
 Rnk
 from top5
 where Rnk <= 5
 

with top as(SELECT 
county, 
year, 
opiates_per_100,
 RANK() OVER(PARTITION BY Year ORDER BY opiates_per_100 DESC) AS Rnk
 from 2010_2020_scripts),
 top5 as(SELECT
 county, 
 year, 
 opiates_per_100, 
 Rnk
 from top
 where Rnk <= 5),
 drugs as (select 
				Geography, 
                year, 
                Indicator, 
                value
                FROM scripts 
                WHERE ValueType = 'Count' and Indicator NOT LIKE 'All_%')
                SELECT
                top5.county, 
                top5.year,
                drugs.Indicator,
                drugs.value
                FROM top5
                LEFT JOIN drugs
                on top5.county=drugs.Geography and top5.year=drugs.year
                WHERE top5.year > 2016
 
 
 -- remove rank combine and avg rate_per_100
with top as(SELECT 
county, 
year, 
opiates_per_100,
 RANK() OVER(PARTITION BY Year ORDER BY opiates_per_100 DESC) AS Rnk
 from 2010_2020_scripts),
 top5 as(SELECT
 county, 
 year, 
 opiates_per_100, 
 Rnk
 from top
 where Rnk <= 5),
 drugs as (select 
				Geography, 
                year, 
                Indicator, 
                value
                FROM scripts 
                WHERE ValueType = 'Count' and Indicator NOT LIKE 'All_%')
                SELECT
                top5.county, 
                top5.year,
                drugs.Indicator,
                drugs.value
                FROM top5
                LEFT JOIN drugs
                on top5.county=drugs.Geography and top5.year=drugs.year
                WHERE top5.year > 2016
 


SELECT * from 2010_2020_scripts
select distinct(year) from 2010_2020_scripts 
SELECT
County, 
ROUND(SUM(opiates_per_100)/15,2) as scripts_per_100 
from 2010_2020_scripts
WHERE year >= 2016
GROUP BY county


SELECT
County, 
--ROUND(SUM(opiates_per_100)/15,2) as scripts_per_100 
opiates_per_100
from 2010_2020_scripts
GROUP BY County

SELECT * from fatal

SELECT
Geography, 
SUM(value) as total,
drug_type
FROM fatal
WHERE year >= 2016
GROUP BY Geography, drug_type




