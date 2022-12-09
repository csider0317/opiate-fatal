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
    WHERE c.year = 2017 and c.Indicator = 'All Benzodiazepines'
    


 
